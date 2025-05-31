Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207D3C5AE59
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 17:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPqu-0003gj-OH; Sat, 31 May 2025 13:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPpv-000204-A5; Sat, 31 May 2025 13:17:36 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPpt-00016f-7K; Sat, 31 May 2025 13:17:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6C892126B42;
 Sat, 31 May 2025 20:16:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 452F321BA45;
 Sat, 31 May 2025 20:16:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 18/27] qemu-img: rebase: refresh options/--help (short option
 change)
Date: Sat, 31 May 2025 20:16:00 +0300
Message-Id: <20250531171609.197078-19-mjt@tls.msk.ru>
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

Add missing long options and --help output,
reorder options for consistency.

Use -B for --backing-format, keep -F for
backwards compatibility.

Options added:
 --format, --cache - for the image in question
 --backing, --backing-format, --backing-cache, --backing-unsafe -
   for the new backing file
(was eg CACHE vs SRC_CACHE, which is unclear).

Probably should rename local variables.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/tools/qemu-img.rst |  2 +-
 qemu-img.c              | 88 +++++++++++++++++++++++++++++------------
 2 files changed, 64 insertions(+), 26 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index a346988292..5e7b85079d 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -667,7 +667,7 @@ Command description:
 
   List, apply, create or delete snapshots in image *FILENAME*.
 
-.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] [-c] -b BACKING_FILE [-F BACKING_FMT] FILENAME
+.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] [-c] -b BACKING_FILE [-B BACKING_FMT] FILENAME
 
   Changes the backing file of an image. Only the formats ``qcow2`` and
   ``qed`` support changing the backing file.
diff --git a/qemu-img.c b/qemu-img.c
index 0774529383..08b37ed486 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3792,45 +3792,90 @@ static int img_rebase(const img_cmd_t *ccmd, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
-            {"object", required_argument, 0, OPTION_OBJECT},
+            {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
-            {"force-share", no_argument, 0, 'U'},
+            {"cache", required_argument, 0, 't'},
             {"compress", no_argument, 0, 'c'},
+            {"backing", required_argument, 0, 'b'},
+            {"backing-format", required_argument, 0, 'B'},
+            {"backing-cache", required_argument, 0, 'T'},
+            {"backing-unsafe", no_argument, 0, 'u'},
+            {"force-share", no_argument, 0, 'U'},
+            {"progress", no_argument, 0, 'p'},
+            {"quiet", no_argument, 0, 'q'},
+            {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:F:b:upt:T:qUc",
+        c = getopt_long(argc, argv, "hf:t:cb:F:B:T:uUpq",
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
+            cmd_help(ccmd, "[-f FMT | --image-opts] [-t CACHE]\n"
+"        [-b BACKING_FILE [-B BACKING_FMT] [-T BACKING_CACHE]] [-u]\n"
+"        [-c] [-U] [-p] [-q] [--object OBJDEF] FILE\n"
+"Rebases FILE on top of BACKING_FILE or no backing file\n"
+,
+"  -f, --format FMT\n"
+"     specify FILE format explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat FILE as an option string (key=value,..), not a file name\n"
+"     (incompatible with -f|--format)\n"
+"  -t, --cache CACHE\n"
+"     cache mode for FILE (default: " BDRV_DEFAULT_CACHE ")\n"
+"  -b, --backing BACKING_FILE|\"\"\n"
+"     rebase onto this file (specify empty name for no backing file)\n"
+"  -B, --backing-format BACKING_FMT (was -F in <=10.0)\n"
+"     specify format for BACKING_FILE explicitly (default: probing is used)\n"
+"  -T, --backing-cache CACHE\n"
+"     BACKING_FILE cache mode (default: " BDRV_DEFAULT_CACHE ")\n"
+"  -u, --backing-unsafe\n"
+"     do not fail if BACKING_FILE can not be read\n"
+"  -c, --compress\n"
+"     compress image (when image supports this)\n"
+"  -U, --force-share\n"
+"     open image in shared mode for concurrent access\n"
+"  -p, --progress\n"
+"     display progress information\n"
+"  -q, --quiet\n"
+"     quiet mode (produce only error messages if any)\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     name of the image file, or option string (key=value,..)\n"
+"     with --image-opts, to operate on\n"
+);
             return 0;
         case 'f':
             fmt = optarg;
             break;
-        case 'F':
-            out_basefmt = optarg;
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
+            break;
+        case 't':
+            cache = optarg;
             break;
         case 'b':
             out_baseimg = optarg;
             break;
+        case 'F': /* <=10.0 */
+        case 'B':
+            out_basefmt = optarg;
+            break;
         case 'u':
             unsafe = 1;
             break;
+        case 'c':
+            compress = true;
+            break;
+        case 'U':
+            force_share = true;
+            break;
         case 'p':
             progress = 1;
             break;
-        case 't':
-            cache = optarg;
-            break;
         case 'T':
             src_cache = optarg;
             break;
@@ -3840,15 +3885,8 @@ static int img_rebase(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_OBJECT:
             user_creatable_process_cmdline(optarg);
             break;
-        case OPTION_IMAGE_OPTS:
-            image_opts = true;
-            break;
-        case 'U':
-            force_share = true;
-            break;
-        case 'c':
-            compress = true;
-            break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.39.5


