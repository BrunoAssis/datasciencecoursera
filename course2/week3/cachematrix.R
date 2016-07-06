## `makeCacheMatrix` creates a special type of matrix which can cache its
## inverse.
## `cacheSolve` receives a cacheable matrix returned by `makeCacheMatrix` and
## inverts the matrix. If it is already cached, it will use the cache value.

## `makeCacheMatrix`:
## Example:
##   `m <- makeCacheMatrix(matrix)`

makeCacheMatrix <- function(x = matrix()) {
  i <- NULL
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  get <- function() x
  setinverted <- function(inverted) i <<- inverted
  getinverted <- function() i
  list(set = set, get = get,
       setinverted = setinverted,
       getinverted = getinverted)
}

## `cacheSolve`:
## Example:
##   `m <- makeCacheMatrix(matrix)`
##   `inverted <- cacheSolve(m)`   # It'll be computed now...
##   `inverted2 <- cacheSolve(m)`  # It's already computed, so it'll use
##                                 # the cached data
##   `    getting cached data`

cacheSolve <- function(x, ...) {
  i <- x$getinverted()
  if(!is.null(i)) {
    message("getting cached data")
    return(i)
  }
  data <- x$get()
  i <- solve(data, ...)
  x$setinverted(i)
  i
}
