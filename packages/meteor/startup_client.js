var callbackQueue = [];
var isLoadingCompleted = false;
var isReady = false;

// Keeps track of how many events to wait for in addition to loading completing,
// before we're considered ready.
var readyHoldsCount = 0;

var holdReady =  function () {
  readyHoldsCount++;
}

var releaseReadyHold = function () {
  readyHoldsCount--;
  maybeReady();
}

var maybeReady = function () {
  if (isReady || !isLoadingCompleted || readyHoldsCount > 0)
    return;

  isReady = true;

  // Run startup callbacks
  while (callbackQueue.length)
    (callbackQueue.shift())();

  if (Meteor.isCordova) {
    // Notify the WebAppLocalServer plugin that startup was completed successfully,
    // so we can roll back faulty versions if this doesn't happen
    WebAppLocalServer.startupDidComplete();
  }
};

var loadingCompleted = function () {
  if (!isLoadingCompleted) {
    isLoadingCompleted = true;
    maybeReady();
  }
};

setTimeout(loadingCompleted);

/**
 * @summary Run code when a client or a server starts.
 * @locus Anywhere
 * @param {Function} func A function to run on startup.
 */
Meteor.startup = function (callback) {

    if (isReady)
      callback();
    else
      callbackQueue.push(callback);
};
