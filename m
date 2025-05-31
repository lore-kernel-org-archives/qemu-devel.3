Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269D6C5B552
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 17:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPsZ-0007La-MY; Sat, 31 May 2025 13:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPqU-0002Z6-Kp; Sat, 31 May 2025 13:18:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPqP-0001CV-Ca; Sat, 31 May 2025 13:18:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ADCD3126B48;
 Sat, 31 May 2025 20:16:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 86F6921BA4B;
 Sat, 31 May 2025 20:16:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 24/27] qemu-img: dd: refresh options/--help
Date: Sat, 31 May 2025 20:16:06 +0300
Message-Id: <20250531171609.197078-25-mjt@tls.msk.ru>
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
 qemu-img.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 97ce51a1c3..3220c95e3c 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5533,31 +5533,54 @@ static int img_dd(const img_cmd_t *ccmd, int argc, char **argv)
     };
     const struct option long_options[] = {
         { "help", no_argument, 0, 'h'},
-        { "object", required_argument, 0, OPTION_OBJECT},
+        { "format", required_argument, 0, 'f'},
         { "image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+        { "output-format", required_argument, 0, 'O'},
         { "force-share", no_argument, 0, 'U'},
+        { "object", required_argument, 0, OPTION_OBJECT},
         { 0, 0, 0, 0 }
     };
 
-    while ((c = getopt_long(argc, argv, ":hf:O:U", long_options, NULL))) {
+    while ((c = getopt_long(argc, argv, "hf:O:U", long_options, NULL))) {
         if (c == EOF) {
             break;
         }
         switch (c) {
-        case 'O':
-            out_fmt = optarg;
+        case 'h':
+            cmd_help(ccmd, "[-f FMT|--image-opts] [-O OUTPUT_FMT] [-U]\n"
+"        [--object OBJDEF] [bs=BLOCK_SIZE] [count=BLOCKS] if=INPUT of=OUTPUT\n"
+,
+"  -f, --format FMT\n"
+"     specify format for INPUT explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat INPUT as an option string (key=value,..), not a file name\n"
+"     (incompatible with -f|--format)\n"
+"  -O, --output-format OUTPUT_FMT\n"
+"     format of the OUTPUT (default: raw)\n"
+"  -U, --force-share\n"
+"     open images in shared mode for concurrent access\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  bs=BLOCK_SIZE[bKMGTP]\n"
+"     size of the I/O block, with optional multiplier suffix (powers of 1024)\n"
+"     (default: 512)\n"
+"  count=COUNT\n"
+"     number of blocks to convert (default whole INPUT)\n"
+"  if=INPUT\n"
+"     name of the file, or option string (key=value,..)\n"
+"     with --image-opts, to use for input\n"
+"  of=OUTPUT\n"
+"     output file name to create (will be overridden if alrady exists)\n"
+);
             break;
         case 'f':
             fmt = optarg;
             break;
-        case ':':
-            missing_argument(argv[optind - 1]);
-            break;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
             break;
-        case 'h':
-            help();
+        case 'O':
+            out_fmt = optarg;
             break;
         case 'U':
             force_share = true;
@@ -5565,9 +5588,8 @@ static int img_dd(const img_cmd_t *ccmd, int argc, char **argv)
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


