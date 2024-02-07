Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D5CC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 18:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmCZ-0004X8-Gc; Wed, 07 Feb 2024 12:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXmBx-0003ZC-NN; Wed, 07 Feb 2024 12:58:39 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXmBw-00044F-5d; Wed, 07 Feb 2024 12:58:37 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 322EF4B3D7;
 Wed,  7 Feb 2024 20:59:37 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 249A8763A7;
 Wed,  7 Feb 2024 20:58:25 +0300 (MSK)
Received: (nullmailer pid 296940 invoked by uid 1000);
 Wed, 07 Feb 2024 17:58:19 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 8/8] qemu-img: refresh options/--help for "convert" command
Date: Wed,  7 Feb 2024 20:58:17 +0300
Message-Id: <5692d04003f710ca003b492c167bee683033e280.1707328606.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1707328606.git.mjt@tls.msk.ru>
References: <cover.1707328606.git.mjt@tls.msk.ru>
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index ea3fe95169..c8fba27e35 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2351,14 +2351,28 @@ static int img_convert(const char *cmdname, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
+            {"quiet", no_argument, 0, 'q'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"source-format", required_argument, 0, 'f'},
+            {"source-cache", required_argument, 0, 'T'},
+            {"snapshot", required_argument, 0, 'l'},
+            {"sparse-size", required_argument, 0, 'S'},
+            {"output-format", required_argument, 0, 'O'},
+            {"options", required_argument, 0, 'o'},
+            {"output-cache", required_argument, 0, 't'},
+            {"backing", required_argument, 0, 'B'},
+            {"backing-format", required_argument, 0, 'F'},
             {"force-share", no_argument, 0, 'U'},
             {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
             {"salvage", no_argument, 0, OPTION_SALVAGE},
             {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
             {"bitmaps", no_argument, 0, OPTION_BITMAPS},
             {"skip-broken-bitmaps", no_argument, 0, OPTION_SKIP_BROKEN},
+            {"rate", required_argument, 0, 'r'},
+            {"parallel", required_argument, 0, 'm'},
+            {"oob-writes", no_argument, 0, 'W'},
+            {"copy-range-offloading", no_argument, 0, 'C'},
             {0, 0, 0, 0}
         };
         c = getopt_long(argc, argv, ":hf:O:B:CcF:o:l:S:pt:T:qnm:WUr:",
@@ -2374,7 +2388,37 @@ static int img_convert(const char *cmdname, int argc, char **argv)
             unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
-            help();
+            cmd_help(cmdname, "[OPTIONS] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME",
+                     "Convert image FILENAME (or a snapshot) to new image OUTPUT_FILENAME",
+" -q|--quiet - quiet operations\n"
+" -f|--source-format SFMT - specify FILENAME source image format explicitly\n"
+" --image-opts - indicates that FILENAME is a complete image specification\n"
+"  instead of a file name (incompatible with --source-format)\n"
+" -T|--source-cache CACHE_MODE - cache mode when opening source image (" BDRV_DEFAULT_CACHE ")\n"
+" -O|--output-format OFMT - specify OUTPUT_FILENAME image format (default is raw)\n"
+" --target-image-opts - indicates that OUTPUT_FILENAME is a complete image specification\n"
+"  instead of a file name (incompatible with --output-format)\n"
+" -o|--options OPTS - OFMT-specific options\n"
+" -c|--compress - create compressed output image (qcow and qcow2 format only)\n"
+" -t|--output-cache CACHE_MODE - cache mode when opening output image (" BDRV_DEFAULT_CACHE ")\n"
+" -B|--backing BACKING_FILENAME - create output to be a CoW on top of BACKING_FILENAME\n"
+" -F|--backing-format BFMT - specify BACKING_FILENAME image format explicitly\n"
+" --target-is-zero\n"
+" -l|--snapshot SNAPSHOT_PARAMS\n"
+" -S|--sparse-size SPARSE_SIZE\n"
+" --bitmaps - also copy any persistent bitmaps present in source\n"
+" --skip-broken-bitmaps - skip (do not error out) any broken bitmaps\n"
+" -U|--force-share - open images in shared mode for concurrent access\n"
+" -p|--progress - show operation progress\n"
+" -r|--rate RATE\n"
+" -m|--parallel NUM_COROUTINES - specify parallelism (default 8)\n"
+" -C|--copy-range-offloading - use copy_range offloading\n"
+" --salvage\n"
+" -W - enable out-of-order writes to improve performance\n"
+" -n|--no-create - omit target volume creation (eg on rbd)\n"
+" --object OBJDEF - QEMU user-creatable object (eg encryption key)\n"
+" FILENAME - source image file name\n"
+" OUTPUT_FILENAME - destination (output) image file name\n");
             break;
         case 'f':
             fmt = optarg;
-- 
2.39.2


