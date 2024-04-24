Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8E3C07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzYMl-0006iM-90; Wed, 24 Apr 2024 04:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYMg-0006J8-5j; Wed, 24 Apr 2024 04:52:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYMd-000488-S7; Wed, 24 Apr 2024 04:52:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0EDDC6153E;
 Wed, 24 Apr 2024 11:50:44 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 377B7BE0EE;
 Wed, 24 Apr 2024 11:50:37 +0300 (MSK)
Received: (nullmailer pid 1179642 invoked by uid 1000);
 Wed, 24 Apr 2024 08:50:36 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Subject: [PATCH 21/27] qemu-img: bench: refresh options/--help
Date: Wed, 24 Apr 2024 11:50:29 +0300
Message-Id: <4dc62ec945910baea2b78be5ebc56ad86107e35d.1713948448.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1713948448.git.mjt@tls.msk.ru>
References: <cover.1713948448.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 64 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 10 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 76000c485c..fff537df26 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4849,28 +4849,70 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
     for (;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
-            {"flush-interval", required_argument, 0, OPTION_FLUSH_INTERVAL},
+            {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"cache", required_argument, 0, 't'},
+            {"count", required_argument, 0, 'c'},
+            {"depth", required_argument, 0, 'd'},
+            {"offset", required_argument, 0, 'o'},
+            {"buffer-size", required_argument, 0, 's'},
+            {"step-size", required_argument, 0, 'S'},
+            {"aio", required_argument, 0, 'i'},
+            {"native", no_argument, 0, 'n'},
+            {"write", no_argument, 0, 'w'},
             {"pattern", required_argument, 0, OPTION_PATTERN},
+            {"flush-interval", required_argument, 0, OPTION_FLUSH_INTERVAL},
             {"no-drain", no_argument, 0, OPTION_NO_DRAIN},
             {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hc:d:f:ni:o:qs:S:t:wU", long_options,
-                        NULL);
+        c = getopt_long(argc, argv, "hc:d:f:ni:o:qs:S:t:wU",
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
+            cmd_help(ccmd,
+"[-f FMT | --image-opts] [-t CACHE] [-c COUNT] [-d DEPTH]\n"
+"        [-o OFFSET] [-s BUFFER_SIZE] [-S STEP_SIZE] [-i AIO] [-n]\n"
+"        [-w [--pattern PATTERN] [--flush-interval INTERVAL [--no-drain]]]\n"
+,
+"  -q, --quiet\n"
+"     quiet operations\n"
+"  -f, --format FMT\n"
+"     specify FILENAME format explicitly\n"
+"  --image-opts\n"
+"     indicates that FILENAME is a complete image specification\n"
+"     instead of a file name (incompatible with --format)\n"
+"  -t, --cache CACHE\n"
+"     cache mode for FILENAME (" BDRV_DEFAULT_CACHE ")\n"
+"  -c, --count COUNT\n"
+"     number of I/O requests to perform\n"
+"  -s, --buffer-size BUFFER_SIZE\n"
+"     size of each I/O request\n"
+"  -d, --depth DEPTH\n"
+"     number of requests to perform in parallel\n"
+"  -o, --offset OFFSET\n"
+"     start first request at this OFFSET\n"
+"  -S, --step-size STEP_SIZE\n"
+"     each next request offset increment\n"
+"  -i, --aio AIO\n"
+"     async-io backend (threads, native, io_uring)\n"
+"  -n, --native\n"
+"     use native AIO backend if possible\n"
+"  -w, --write\n"
+"     perform write test (default is read)\n"
+"  --pattern PATTERN\n"
+"     write this pattern byte instead of zero\n"
+"  --flush-interval FLUSH_INTERVAL\n"
+"     issue flush after this number of requests\n"
+"  --no-drain\n"
+"     do not wait when flushing pending requests\n"
+"  -U, --force-share\n"
+"     open images in shared mode for concurrent access\n"
+);
             break;
         case 'c':
         {
@@ -4987,6 +5029,8 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.39.2


