Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201F3C5B549
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 17:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPpQ-0001Q5-DA; Sat, 31 May 2025 13:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPp5-0001Bn-0B; Sat, 31 May 2025 13:16:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPoz-000148-8n; Sat, 31 May 2025 13:16:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2F1A7126B3B;
 Sat, 31 May 2025 20:16:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0852F21BA3E;
 Sat, 31 May 2025 20:16:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 11/27] qemu-img: compare: refresh options/--help
Date: Sat, 31 May 2025 20:15:53 +0300
Message-Id: <20250531171609.197078-12-mjt@tls.msk.ru>
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

Add long options, add help, reorder options for consistency.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 64 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index c24e1fb455..70573b79b5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1487,25 +1487,51 @@ static int img_compare(const img_cmd_t *ccmd, int argc, char **argv)
     for (;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
-            {"object", required_argument, 0, OPTION_OBJECT},
+            {"a-format", required_argument, 0, 'f'},
+            {"b-format", required_argument, 0, 'F'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"strict", no_argument, 0, 's'},
+            {"cache", required_argument, 0, 'T'},
             {"force-share", no_argument, 0, 'U'},
+            {"progress", no_argument, 0, 'p'},
+            {"quiet", no_argument, 0, 'q'},
+            {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:F:T:pqsU",
+        c = getopt_long(argc, argv, "hf:F:sT:Upq",
                         long_options, NULL);
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
+            cmd_help(ccmd,
+"[[-f FMT] [-F FMT] | --image-opts] [-s] [-T CACHE]\n"
+"        [-U] [-p] [-q] [--object OBJDEF] FILE1 FILE2\n"
+,
+"  -f, --a-format FMT\n"
+"     specify FILE1 image format explicitly (default: probing is used)\n"
+"  -F, --b-format FMT\n"
+"     specify FILE2 image format explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat FILE1 and FILE2 as option strings (key=value,..), not file names\n"
+"     (incompatible with -f|--a-format and -F|--b-format)\n"
+"  -s, --strict\n"
+"     strict mode, also check if sizes are equal\n"
+"  -T, --cache CACHE_MODE\n"
+"     images caching mode (default: " BDRV_DEFAULT_CACHE ")\n"
+"  -U, --force-share\n"
+"     open images in shared mode for concurrent access\n"
+"  -p, --progress\n"
+"     display progress information\n"
+"  -q, --quiet\n"
+"     quiet mode (produce only error messages if any)\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE1, FILE2\n"
+"     names of the image files, or option strings (key=value,..)\n"
+"     with --image-opts, to compare\n"
+);
             break;
         case 'f':
             fmt1 = optarg;
@@ -1513,27 +1539,29 @@ static int img_compare(const img_cmd_t *ccmd, int argc, char **argv)
         case 'F':
             fmt2 = optarg;
             break;
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
+            break;
+        case 's':
+            strict = true;
+            break;
         case 'T':
             cache = optarg;
             break;
+        case 'U':
+            force_share = true;
+            break;
         case 'p':
             progress = true;
             break;
         case 'q':
             quiet = true;
             break;
-        case 's':
-            strict = true;
-            break;
-        case 'U':
-            force_share = true;
-            break;
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


