Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13263C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 21:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYLx-0000AF-VR; Fri, 09 Feb 2024 16:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYLv-000096-Lp; Fri, 09 Feb 2024 16:24:07 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYLu-0000Dc-3x; Fri, 09 Feb 2024 16:24:07 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 55AE34BF6A;
 Sat, 10 Feb 2024 00:24:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4284577EE4;
 Sat, 10 Feb 2024 00:22:48 +0300 (MSK)
Received: (nullmailer pid 1123193 invoked by uid 1000);
 Fri, 09 Feb 2024 21:22:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 18/23] qemu-img: refresh options/--help for "bench" command
Date: Sat, 10 Feb 2024 00:22:39 +0300
Message-Id: <412cd5a3af866763a22ec17a5eea99aa2b6564da.1707513011.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1707513011.git.mjt@tls.msk.ru>
References: <cover.1707513011.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 qemu-img.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index f598eba3a8..3be365cd07 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4781,9 +4781,19 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
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
@@ -4802,7 +4812,29 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
             unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
-            help();
+            cmd_help(ccmd,
+"[-f FMT | --image-opts] [-t CACHE] [-c COUNT] [-d DEPTH]\n"
+"	[-o OFFSET] [-s BUFFER_SIZE] [-S STEP_SIZE] [-i AIO] [-n]\n"
+"	[-w [--pattern PATTERN] [--flush-interval INTERVAL [--no-drain]]]\n"
+,
+" -q|--quiet - quiet operations\n"
+" -f|--format FMT - specify FILENAME format explicitly\n"
+" --image-opts - indicates that FILENAME is a complete image specification\n"
+"  instead of a file name (incompatible with --format)\n"
+" -t|--cache CACHE - cache mode for FILENAME (" BDRV_DEFAULT_CACHE ")\n"
+" -c|--count COUNT - number of I/O requests to perform\n"
+" -s|--buffer-size BUFFER_SIZE - size of each I/O request\n"
+" -d|--depth DEPTH - number of requests to perform in parallel\n"
+" -o|--offset OFFSET - start first request at this OFFSET\n"
+" -S|--step-size STEP_SIZE - each next request offset increment\n"
+" -i|--aio AIO - async-io backend (threads, native, io_uring)\n"
+" -n|--native - use native AIO backend if possible\n"
+" -w|--write - perform write test (default is read)\n"
+" --pattern PATTERN - write this pattern instead of zeros\n"
+" --flush-interval FLUSH_INTERVAL - issue flush after this number of requests\n"
+" --no-drain - do not wait when flushing pending requests\n"
+" -U|--force-share - open images in shared mode for concurrent access\n"
+);
             break;
         case 'c':
         {
-- 
2.39.2


