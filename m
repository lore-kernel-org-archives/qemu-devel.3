Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2FCC5B549
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 17:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPs3-0005EQ-I3; Sat, 31 May 2025 13:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPqN-0002R0-U1; Sat, 31 May 2025 13:18:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPqL-00018d-Eo; Sat, 31 May 2025 13:18:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 93A76126B46;
 Sat, 31 May 2025 20:16:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6BC9F21BA49;
 Sat, 31 May 2025 20:16:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 22/27] qemu-img: bench: refresh options/--help
Date: Sat, 31 May 2025 20:16:04 +0300
Message-Id: <20250531171609.197078-23-mjt@tls.msk.ru>
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

Add missing --object option.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 112 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 84 insertions(+), 28 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 0d4bdc5df5..5011ec5fce 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4859,28 +4859,93 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
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
+            {"write", no_argument, 0, 'w'},
             {"pattern", required_argument, 0, OPTION_PATTERN},
+            {"flush-interval", required_argument, 0, OPTION_FLUSH_INTERVAL},
             {"no-drain", no_argument, 0, OPTION_NO_DRAIN},
+            {"aio", required_argument, 0, 'i'},
+            {"native", no_argument, 0, 'n'},
             {"force-share", no_argument, 0, 'U'},
+            {"quiet", no_argument, 0, 'q'},
+            {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hc:d:f:ni:o:qs:S:t:wU", long_options,
-                        NULL);
+        c = getopt_long(argc, argv, "hf:t:c:d:o:s:S:wi:nUq",
+                        long_options, NULL);
         if (c == -1) {
             break;
         }
 
         switch (c) {
-        case ':':
-            missing_argument(argv[optind - 1]);
+        case 'h':
+            cmd_help(ccmd, "[-f FMT | --image-opts] [-t CACHE]\n"
+"        [-c COUNT] [-d DEPTH] [-o OFFSET] [-s BUFFER_SIZE] [-S STEP_SIZE]\n"
+"        [-w [--pattern PATTERN] [--flush-interval INTERVAL [--no-drain]]]\n"
+"        [-i AIO] [-n] [-U] [-q] FILE\n"
+,
+"  -f, --format FMT\n"
+"     specify FILE format explicitly\n"
+"  --image-opts\n"
+"     indicates that FILE is a complete image specification\n"
+"     instead of a file name (incompatible with --format)\n"
+"  -t, --cache CACHE\n"
+"     cache mode for FILE (default: " BDRV_DEFAULT_CACHE ")\n"
+"  -c, --count COUNT\n"
+"     number of I/O requests to perform\n"
+"  -d, --depth DEPTH\n"
+"     number of requests to perform in parallel\n"
+"  -o, --offset OFFSET\n"
+"     start first request at this OFFSET\n"
+"  -s, --buffer-size BUFFER_SIZE[bkKMGTPE]\n"
+"     size of each I/O request, with optional multiplier suffix\n"
+"     (powers of 1024, default is 4K)\n"
+"  -S, --step-size STEP_SIZE[bkKMGTPE]\n"
+"     each next request offset increment, with optional multiplier suffix\n"
+"     (powers of 1024, default is the same as BUFFER_SIZE)\n"
+"  -w, --write\n"
+"     perform write test (default is read)\n"
+"  --pattern PATTERN\n"
+"     write this pattern byte instead of zero\n"
+"  --flush-interval FLUSH_INTERVAL\n"
+"     issue flush after this number of requests\n"
+"  --no-drain\n"
+"     do not wait when flushing pending requests\n"
+"  -i, --aio AIO\n"
+"     async-io backend (threads, native, io_uring)\n"
+"  -n, --native\n"
+"     use native AIO backend if possible\n"
+"  -U, --force-share\n"
+"     open images in shared mode for concurrent access\n"
+"  -q, --quiet\n"
+"     quiet mode (produce only error messages if any)\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     name of the image file, or option string (key=value,..)\n"
+"     with --image-opts, to operate on\n"
+);
             break;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
+        case 'f':
+            fmt = optarg;
             break;
-        case 'h':
-            help();
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
+            break;
+        case 't':
+            ret = bdrv_parse_cache_mode(optarg, &flags, &writethrough);
+            if (ret < 0) {
+                error_report("Invalid cache mode");
+                ret = -1;
+                goto out;
+            }
             break;
         case 'c':
         {
@@ -4904,9 +4969,6 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
             depth = res;
             break;
         }
-        case 'f':
-            fmt = optarg;
-            break;
         case 'n':
             flags |= BDRV_O_NATIVE_AIO;
             break;
@@ -4927,9 +4989,6 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
             break;
         }
             break;
-        case 'q':
-            quiet = true;
-            break;
         case 's':
         {
             int64_t sval;
@@ -4954,21 +5013,10 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
             step = sval;
             break;
         }
-        case 't':
-            ret = bdrv_parse_cache_mode(optarg, &flags, &writethrough);
-            if (ret < 0) {
-                error_report("Invalid cache mode");
-                ret = -1;
-                goto out;
-            }
-            break;
         case 'w':
             flags |= BDRV_O_RDWR;
             is_write = true;
             break;
-        case 'U':
-            force_share = true;
-            break;
         case OPTION_PATTERN:
         {
             unsigned long res;
@@ -4994,9 +5042,17 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_NO_DRAIN:
             drain_on_flush = false;
             break;
-        case OPTION_IMAGE_OPTS:
-            image_opts = true;
+        case 'U':
+            force_share = true;
             break;
+        case 'q':
+            quiet = true;
+            break;
+        case OPTION_OBJECT:
+            user_creatable_process_cmdline(optarg);
+            break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.39.5


