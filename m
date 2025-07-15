Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83315C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgww-0002pW-1K; Tue, 15 Jul 2025 10:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ubgLK-0006JN-UA; Tue, 15 Jul 2025 10:09:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ubgLF-0007D4-CN; Tue, 15 Jul 2025 10:09:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CF5F8136EB9;
 Tue, 15 Jul 2025 17:08:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7CBAC247D92;
 Tue, 15 Jul 2025 17:09:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 14/27] qemu-img: map: refresh options/--help
Date: Tue, 15 Jul 2025 17:09:03 +0300
Message-ID: <20250715140903.131529-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250531171609.197078-15-mjt@tls.msk.ru>
References: <20250531171609.197078-15-mjt@tls.msk.ru>
 <20250531171609.197078-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

While at it, remove unused option_index variable.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 59 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 8138166896..e407b06d0c 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3454,41 +3454,53 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
 
     fmt = NULL;
     for (;;) {
-        int option_index = 0;
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
             {"format", required_argument, 0, 'f'},
-            {"output", required_argument, 0, OPTION_OUTPUT},
-            {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
-            {"force-share", no_argument, 0, 'U'},
             {"start-offset", required_argument, 0, 's'},
             {"max-length", required_argument, 0, 'l'},
+            {"force-share", no_argument, 0, 'U'},
+            {"output", required_argument, 0, OPTION_OUTPUT},
+            {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:s:l:hU",
-                        long_options, &option_index);
+        c = getopt_long(argc, argv, "hf:s:l:U",
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
+            cmd_help(ccmd, "[-f FMT | --image-opts]\n"
+"        [--start-offset OFFSET] [--max-length LENGTH]\n"
+"        [--output human|json] [-U] [--object OBJDEF] FILE\n"
+,
+"  -f, --format FMT\n"
+"     specify FILE image format explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat FILE as an option string (key=value,..), not a file name\n"
+"     (incompatible with -f|--format)\n"
+"  -s, --start-offset OFFSET\n"
+"     start at the given OFFSET in the image, not at the beginning\n"
+"  -l, --max-length LENGTH\n"
+"     process at max LENGTH bytes instead up to the end of the image\n"
+"  --output human|json\n"
+"     specify output format name (default: human)\n"
+"  -U, --force-share\n"
+"     open image in shared mode for concurrent access\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     the image file name, or option string (key=value,..)\n"
+"     with --image-opts, to operate on\n"
+);
             break;
         case 'f':
             fmt = optarg;
             break;
-        case 'U':
-            force_share = true;
-            break;
-        case OPTION_OUTPUT:
-            output_format = parse_output_format(argv[0], optarg);
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
             break;
         case 's':
             start_offset = cvtnum("start offset", optarg);
@@ -3502,12 +3514,17 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
                 return 1;
             }
             break;
+        case OPTION_OUTPUT:
+            output_format = parse_output_format(argv[0], optarg);
+            break;
+        case 'U':
+            force_share = true;
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
     if (optind != argc - 1) {
-- 
2.47.2


