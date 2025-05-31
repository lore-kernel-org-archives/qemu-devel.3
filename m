Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD4DC5AE59
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 17:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPr9-0003z0-5K; Sat, 31 May 2025 13:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPq1-00026a-BF; Sat, 31 May 2025 13:17:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPpy-00018C-8Z; Sat, 31 May 2025 13:17:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8B0B4126B45;
 Sat, 31 May 2025 20:16:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6422021BA48;
 Sat, 31 May 2025 20:16:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 21/27] qemu-img: amend: refresh options/--help
Date: Sat, 31 May 2025 20:16:03 +0300
Message-Id: <20250531171609.197078-22-mjt@tls.msk.ru>
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
 qemu-img.c | 54 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 3dbfce527b..0d4bdc5df5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4559,26 +4559,48 @@ static int img_amend(const img_cmd_t *ccmd, int argc, char **argv)
     for (;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
-            {"object", required_argument, 0, OPTION_OBJECT},
+            {"options", required_argument, 0, 'o'},
+            {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"cache", required_argument, 0, 't'},
             {"force", no_argument, 0, OPTION_FORCE},
+            {"progress", no_argument, 0, 'p'},
+            {"quiet", no_argument, 0, 'q'},
+            {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":ho:f:t:pq",
+        c = getopt_long(argc, argv, "ho:f:t:pq",
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
+            cmd_help(ccmd, "-o FMT_OPTS [-f FMT | --image-opts]\n"
+"        [-t CACHE] [--force] [-p] [-q] [--object OBJDEF] FILE\n"
+,
+"  -o, --options FMT_OPTS\n"
+"     FMT-specfic format options (required)\n"
+"  -f, --format FMT\n"
+"     specify FILE format explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat FILE as an option string (key=value,..), not a file name\n"
+"     (incompatible with -f|--format)\n"
+"  -t, --cache CACHE\n"
+"     cache mode for FILE (default: " BDRV_DEFAULT_CACHE ")\n"
+"  --force\n"
+"     allow certain unsafe operations\n"
+"  -p, --progres\n"
+"     show operation progress\n"
+"  -q, --quiet\n"
+"     quiet mode (produce only error messages if any)\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     name of the image file, or option string (key=value,..)\n"
+"     with --image-opts, to operate on\n"
+);
             break;
         case 'o':
             if (accumulate_options(&options, optarg) < 0) {
@@ -4589,9 +4611,15 @@ static int img_amend(const img_cmd_t *ccmd, int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
+            break;
         case 't':
             cache = optarg;
             break;
+        case OPTION_FORCE:
+            force = true;
+            break;
         case 'p':
             progress = true;
             break;
@@ -4601,12 +4629,8 @@ static int img_amend(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_OBJECT:
             user_creatable_process_cmdline(optarg);
             break;
-        case OPTION_IMAGE_OPTS:
-            image_opts = true;
-            break;
-        case OPTION_FORCE:
-            force = true;
-            break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.39.5


