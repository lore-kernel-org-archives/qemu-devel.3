Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D13DC5B549
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 17:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPsB-00063T-4R; Sat, 31 May 2025 13:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPqO-0002TD-OU; Sat, 31 May 2025 13:18:06 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPqM-00018r-PQ; Sat, 31 May 2025 13:18:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A6840126B47;
 Sat, 31 May 2025 20:16:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7464021BA4A;
 Sat, 31 May 2025 20:16:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 23/27] qemu-img: bitmap: refresh options/--help
Date: Sat, 31 May 2025 20:16:05 +0300
Message-Id: <20250531171609.197078-24-mjt@tls.msk.ru>
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 80 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 5011ec5fce..97ce51a1c3 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5179,48 +5179,69 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
     for (;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
-            {"object", required_argument, 0, OPTION_OBJECT},
+            {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"add", no_argument, 0, OPTION_ADD},
+            {"granularity", required_argument, 0, 'g'},
             {"remove", no_argument, 0, OPTION_REMOVE},
             {"clear", no_argument, 0, OPTION_CLEAR},
             {"enable", no_argument, 0, OPTION_ENABLE},
             {"disable", no_argument, 0, OPTION_DISABLE},
             {"merge", required_argument, 0, OPTION_MERGE},
-            {"granularity", required_argument, 0, 'g'},
             {"source-file", required_argument, 0, 'b'},
             {"source-format", required_argument, 0, 'F'},
+            {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":b:f:F:g:h", long_options, NULL);
+        c = getopt_long(argc, argv, "hf:g:b:F:",
+                        long_options, NULL);
         if (c == -1) {
             break;
         }
 
         switch (c) {
-        case ':':
-            missing_argument(argv[optind - 1]);
-            break;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
-            break;
         case 'h':
-            help();
-            break;
-        case 'b':
-            src_filename = optarg;
+            cmd_help(ccmd, "[-f FMT | --image-opts]\n"
+"        ( --add [-g SIZE] | --remove | --clear | --enable | --disable |\n"
+"          --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
+"        [--object OBJDEF] FILE BITMAP\n"
+,
+"  -f, --format FMT\n"
+"     specify FILE format explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat FILE as an option string (key=value,..), not a file name\n"
+"     (incompatible with -f|--format)\n"
+"  --add\n"
+"     creates BITMAP in FILE, enables to record future edits\n"
+"  -g, --granularity SIZE[bKMGTPE]\n"
+"     sets non-default granularity for the bitmap being added,\n"
+"     with optional multiplier suffix (in powers of 1024)\n"
+"  --remove\n"
+"     removes BITMAP from FILE\n"
+"  --clear\n"
+"     clears BITMAP in FILE\n"
+"  --enable, --disable\n"
+"     starts and stops recording future edits to BITMAP in FILE\n"
+"  --merge SOURCE\n"
+"     merges contents of the SOURCE bitmap into BITMAP in FILE\n"
+"  -b, --source-file SRC_FILE\n"
+"     select alternative source file for --merge\n"
+"  -F, --source-format SRC_FMT\n"
+"     specify format for SRC_FILE explicitly\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     name of the image file, or option string (key=value,..)\n"
+"     with --image-opts, to operate on\n"
+"  BITMAP\n"
+"     name of the bitmap to add, remove, clear, enable, disable or merge to\n"
+);
             break;
         case 'f':
             fmt = optarg;
             break;
-        case 'F':
-            src_fmt = optarg;
-            break;
-        case 'g':
-            granularity = cvtnum("granularity", optarg);
-            if (granularity < 0) {
-                return 1;
-            }
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
             break;
         case OPTION_ADD:
             act = g_new0(ImgBitmapAction, 1);
@@ -5228,6 +5249,12 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
             add = true;
             break;
+        case 'g':
+            granularity = cvtnum("granularity", optarg);
+            if (granularity < 0) {
+                return 1;
+            }
+            break;
         case OPTION_REMOVE:
             act = g_new0(ImgBitmapAction, 1);
             act->act = BITMAP_REMOVE;
@@ -5255,12 +5282,17 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
             merge = true;
             break;
+        case 'b':
+            src_filename = optarg;
+            break;
+        case 'F':
+            src_fmt = optarg;
+            break;
         case OPTION_OBJECT:
             user_creatable_process_cmdline(optarg);
             break;
-        case OPTION_IMAGE_OPTS:
-            image_opts = true;
-            break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.39.5


