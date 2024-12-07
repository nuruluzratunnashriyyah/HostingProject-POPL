/**
 * Enable object versioning for a GCS bucket
 */

// Uncomment and replace with your bucket name
const bucketName = 'my-popl-project';

const { Storage } = require('@google-cloud/storage');
const storage = new Storage();

async function enableBucketVersioning() {
  try {
    await storage.bucket(bucketName).setMetadata({
      versioning: {
        enabled: true,
      },
    });
    console.log(`Versioning is enabled for bucket: ${bucketName}`);
  } catch (error) {
    console.error(`Failed to enable versioning: ${error.message}`);
    process.exit(1);
  }
}

enableBucketVersioning();
