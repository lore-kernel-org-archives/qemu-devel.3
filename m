Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F00C5B549
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 17:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPpS-0001S8-35; Sat, 31 May 2025 13:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPpO-0001Mg-1y; Sat, 31 May 2025 13:17:02 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPpL-00014K-Kc; Sat, 31 May 2025 13:17:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 39406126B3C;
 Sat, 31 May 2025 20:16:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1011621BA3F;
 Sat, 31 May 2025 20:16:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 12/27] qemu-img: convert: refresh options/--help (short option
 change)
Date: Sat, 31 May 2025 20:15:54 +0300
Message-Id: <20250531171609.197078-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531171609.197078-1-mjt@tls.msk.ru>
References: <20250531171609.197078-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add missing long options and --help output.

Reorder options for consistency.

Use -b for --backing, and recognize -B for backwards
compatibility.  Unfortunately we can't use -B to
specify backing format.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/tools/qemu-img.rst |   2 +-
 qemu-img.c              | 227 +++++++++++++++++++++++++++-------------
 2 files changed, 156 insertions(+), 73 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index a21e439082..23715811e2 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -419,7 +419,7 @@ Command description:
   4
     Error on reading data
 
-.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [--bitmaps [--skip-broken-bitmaps]] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE [-F BACKING_FMT]] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-r RATE_LIMIT] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
+.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [--bitmaps [--skip-broken-bitmaps]] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-b BACKING_FILE [-F BACKING_FMT]] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-r RATE_LIMIT] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
 
   Convert the disk image *FILENAME* or a snapshot *SNAPSHOT_PARAM*
   to disk image *OUTPUT_FILENAME* using format *OUTPUT_FMT*. It can
diff --git a/qemu-img.c b/qemu-img.c
index 70573b79b5..5858304a62 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2390,53 +2390,119 @@ static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
-            {"object", required_argument, 0, OPTION_OBJECT},
+ /*XXX: use shorter --src-* and --tgt-*? or --out[put] not --target? */
+            {"source-format", required_argument, 0, 'f'},
+ /*XXX: make historic --image-opts to act on both source and target file? */
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
-            {"force-share", no_argument, 0, 'U'},
-            {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
-            {"salvage", no_argument, 0, OPTION_SALVAGE},
-            {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
+            {"source-image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"source-cache", required_argument, 0, 'T'},
+            {"snapshot", required_argument, 0, 'l'},
             {"bitmaps", no_argument, 0, OPTION_BITMAPS},
             {"skip-broken-bitmaps", no_argument, 0, OPTION_SKIP_BROKEN},
+            {"salvage", no_argument, 0, OPTION_SALVAGE},
+            {"target-format", required_argument, 0, 'O'},
+            {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
+            {"target-format-options", required_argument, 0, 'o'},
+            {"target-cache", required_argument, 0, 't'},
+            {"backing", required_argument, 0, 'b'},
+            {"backing-format", required_argument, 0, 'F'},
+            {"sparse-size", required_argument, 0, 'S'},
+            {"no-create", no_argument, 0, 'n'},
+            {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
+            {"force-share", no_argument, 0, 'U'},
+            {"rate-limit", required_argument, 0, 'r'},
+            {"parallel", required_argument, 0, 'm'},
+            {"oob-writes", no_argument, 0, 'W'},
+            {"copy-range-offloading", no_argument, 0, 'C'},
+            {"progress", no_argument, 0, 'p'},
+            {"quiet", no_argument, 0, 'q'},
+            {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:O:B:CcF:o:l:S:pt:T:qnm:WUr:",
+        c = getopt_long(argc, argv, "hf:O:b:B:CcF:o:l:S:pt:T:nm:WUr:q",
                         long_options, NULL);
         if (c == -1) {
             break;
         }
-        switch(c) {
-        case ':':
-            missing_argument(argv[optind - 1]);
-            break;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
-            break;
+        switch (c) {
         case 'h':
-            help();
+            cmd_help(ccmd, "[-f SRC_FMT | --source-image-opts] [-T SRC_CACHE]\n"
+"        [-l SNAPSHOT_PARAM] [--bitmaps [--skip-broken-bitmaps]] [--salvage]\n"
+"        [-O TGT_FMT | --target-image-opts] [-o TGT_FMT_OPTS] [-t TGT_CACHE]\n"
+"        [-b BACKING_FILE [-F BACKING_FMT]] [-S SPARSE_SIZE]\n"
+"        [-n] [--target-is-zero] [-c]\n"
+"        [-U] [-r RATE] [-m NUM_PARALLEL] [-W] [-C] [-p] [-q] [--object OBJDEF]\n"
+"        SRC_FILE [SRC_FILE2...] TGT_FILE\n"
+,
+"  -f, --source-format SRC_FMT\n"
+"     specify format of all SRC_FILEs explicitly (default: probing is used)\n"
+"  --source-image-opts (XXX was --image-opts, but it usually applies to both)\n"
+"     treat each SRC_FILE as an option string (key=value,...), not a file name\n"
+"     (incompatible with -f|--source-format)\n"
+"  -T, --source-cache SRC_CACHE\n"
+"     source image(s) cache mode (" BDRV_DEFAULT_CACHE ")\n"
+"  -l, --snapshot SNAPSHOT_PARAMS\n"
+"     specify source snapshot parameters\n"
+"  --bitmaps\n"
+"     also copy any persistent bitmaps present in source\n"
+"  --skip-broken-bitmaps\n"
+"     skip (do not error out) any broken bitmaps\n"
+"  --salvage\n"
+"     ignore errors on input (convert unreadable areas to zeros)\n"
+"  -O, --target-format TGT_FMT\n"
+"     specify TGT_FILE image format (default: raw)\n"
+"  --target-image-opts\n"
+"     treat TGT_FILE as an option string (key=value,...), not a file name\n"
+"     (incompatible with -O|--target-format)\n"
+"  -o, --target-format-options TGT_FMT_OPTS\n"
+"     TGT_FMT-specific options\n"
+"  -t, --target-cache TGT_CACHE\n"
+"     cache mode when opening output image (default: unsafe)\n"
+"  -b, --backing BACKING_FILE (was -B in <= 10.0)\n"
+"     create target image to be a CoW on top of BACKING_FILE\n"
+"  -F, --backing-format BACKING_FMT\n" /* -B used for -b in <=10.0 */
+"     specify BACKING_FILE image format explicitly (default: probing is used)\n"
+"  -S, --sparse-size SPARSE_SIZE[bkKMGTPE]\n"
+"     specify number of consecutive zero bytes to treat as a gap on output\n"
+"     (rounded down to nearest 512 bytes), with optional multiplier suffix\n"
+"  -n, --no-create\n"
+"     omit target volume creation (e.g. on rbd)\n"
+"  --target-is-zero\n"
+"     indicates that the target volume is pre-zeroed\n"
+"  -c, --compress\n"
+"     create compressed output image (qcow and qcow2 formats only)\n"
+"  -U, --force-share\n"
+"     open images in shared mode for concurrent access\n"
+"  -r, --rate-limit RATE\n"
+"     I/O rate limit, in bytes per second\n"
+"  -m, --parallel NUM_PARALLEL\n"
+"     specify parallelism (default: 8)\n"
+"  -C, --copy-range-offloading\n"
+"     try to use copy offloading\n"
+"  -W, --oob-writes\n"
+"     enable out-of-order writes to improve performance\n"
+"  -p, --progress\n"
+"     display progress information\n"
+"  -q, --quiet\n"
+"     quiet mode (produce only error messages if any)\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  SRC_FILE...\n"
+"     one or more source image file names,\n"
+"     or option strings (key=value,..) with --source-image-opts\n"
+"  TGT_FILE\n"
+"     target (output) image file name,\n"
+"     or option string (key=value,..) with --target-image-opts\n"
+);
             break;
         case 'f':
             fmt = optarg;
             break;
-        case 'O':
-            out_fmt = optarg;
-            break;
-        case 'B':
-            out_baseimg = optarg;
-            break;
-        case 'C':
-            s.copy_range = true;
-            break;
-        case 'c':
-            s.compressed = true;
-            break;
-        case 'F':
-            backing_fmt = optarg;
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
             break;
-        case 'o':
-            if (accumulate_options(&options, optarg) < 0) {
-                goto fail_getopt;
-            }
+        case 'T':
+            src_cache = optarg;
             break;
         case 'l':
             if (strstart(optarg, SNAPSHOT_OPT_BASE, NULL)) {
@@ -2451,6 +2517,36 @@ static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
                 snapshot_name = optarg;
             }
             break;
+        case OPTION_BITMAPS:
+            bitmaps = true;
+            break;
+        case OPTION_SKIP_BROKEN:
+            skip_broken = true;
+            break;
+        case OPTION_SALVAGE:
+            s.salvage = true;
+            break;
+         case 'O':
+            out_fmt = optarg;
+            break;
+        case OPTION_TARGET_IMAGE_OPTS:
+            tgt_image_opts = true;
+            break;
+        case 'o':
+            if (accumulate_options(&options, optarg) < 0) {
+                goto fail_getopt;
+            }
+            break;
+        case 't':
+            cache = optarg;
+            break;
+        case 'B': /* <=10.0 */
+        case 'b':
+            out_baseimg = optarg;
+            break;
+        case 'F': /* can't use -B as it used as -b in <=10.0 */
+            backing_fmt = optarg;
+            break;
         case 'S':
         {
             int64_t sval;
@@ -2471,20 +2567,28 @@ static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
             explict_min_sparse = true;
             break;
         }
-        case 'p':
-            progress = true;
+        case 'n':
+            skip_create = true;
             break;
-        case 't':
-            cache = optarg;
+        case OPTION_TARGET_IS_ZERO:
+            /*
+             * The user asserting that the target is blank has the
+             * same effect as the target driver supporting zero
+             * initialisation.
+             */
+            s.has_zero_init = true;
             break;
-        case 'T':
-            src_cache = optarg;
+        case 'c':
+            s.compressed = true;
             break;
-        case 'q':
-            s.quiet = true;
+        case 'U':
+            force_share = true;
             break;
-        case 'n':
-            skip_create = true;
+        case 'r':
+            rate_limit = cvtnum("rate limit", optarg);
+            if (rate_limit < 0) {
+                goto fail_getopt;
+            }
             break;
         case 'm':
             if (qemu_strtol(optarg, NULL, 0, &s.num_coroutines) ||
@@ -2497,41 +2601,20 @@ static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
         case 'W':
             s.wr_in_order = false;
             break;
-        case 'U':
-            force_share = true;
+        case 'C':
+            s.copy_range = true;
             break;
-        case 'r':
-            rate_limit = cvtnum("rate limit", optarg);
-            if (rate_limit < 0) {
-                goto fail_getopt;
-            }
+        case 'p':
+            progress = true;
+            break;
+        case 'q':
+            s.quiet = true;
             break;
         case OPTION_OBJECT:
             user_creatable_process_cmdline(optarg);
             break;
-        case OPTION_IMAGE_OPTS:
-            image_opts = true;
-            break;
-        case OPTION_SALVAGE:
-            s.salvage = true;
-            break;
-        case OPTION_TARGET_IMAGE_OPTS:
-            tgt_image_opts = true;
-            break;
-        case OPTION_TARGET_IS_ZERO:
-            /*
-             * The user asserting that the target is blank has the
-             * same effect as the target driver supporting zero
-             * initialisation.
-             */
-            s.has_zero_init = true;
-            break;
-        case OPTION_BITMAPS:
-            bitmaps = true;
-            break;
-        case OPTION_SKIP_BROKEN:
-            skip_broken = true;
-            break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.39.5


