Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7EBC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 17:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmC9-0003iR-4e; Wed, 07 Feb 2024 12:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXmBu-0003WY-3x; Wed, 07 Feb 2024 12:58:35 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXmBr-00041k-Vg; Wed, 07 Feb 2024 12:58:33 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7FF2A4B3D5;
 Wed,  7 Feb 2024 20:59:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A8540763A5;
 Wed,  7 Feb 2024 20:58:23 +0300 (MSK)
Received: (nullmailer pid 296934 invoked by uid 1000);
 Wed, 07 Feb 2024 17:58:19 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 6/8] qemu-img: refresh options/--help for "commit" command
Date: Wed,  7 Feb 2024 20:58:15 +0300
Message-Id: <76c05bdf1bd337f75b11ea4e33d201a29aa57ecd.1707328606.git.mjt@tls.msk.ru>
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

Add missing long options and --help output.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 31c1891b43..7ff63aeea2 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1015,8 +1015,15 @@ static int img_commit(const char *cmdname, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
+            {"quiet", no_argument, 0, 'q'},
             {"object", required_argument, 0, OPTION_OBJECT},
+            {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"cache", required_argument, 0, 't'},
+            {"drop", no_argument, 0, 'd'},
+            {"base", required_argument, 0, 'b'},
+            {"progress", no_argument, 0, 'p'},
+            {"rate", required_argument, 0, 'r'},
             {0, 0, 0, 0}
         };
         c = getopt_long(argc, argv, ":f:ht:b:dpqr:",
@@ -1032,7 +1039,20 @@ static int img_commit(const char *cmdname, int argc, char **argv)
             unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
-            help();
+            cmd_help(cmdname, "[OPTIONS] FILENAME",
+                     "Commit changes recorded in FILENAME to its base image",
+" -q|--quiet - quiet operations\n"
+" -f|--format FMT - specify FILENAME image format explicitly\n"
+" --image-opts - indicates that FILENAME is a complete image specification\n"
+"  instead of a file name (incompatible with --format)\n"
+" -t|--cache CACHE_MODE cache mode when opening image (" BDRV_DEFAULT_CACHE ")\n"
+" -d|--drop - skip emptying FILENAME on completion\n"
+" -b|--base BASE_IMG - image in the backing chain to which to commit\n"
+"  changes instead of the previous one (implies --drop)\n"
+" -p|--progress - show operation progress\n"
+" -r|--rate RATE - I/O rate limit\n"
+" --object OBJDEF - QEMU user-creatable object (eg encryption key)\n"
+" FILENAME - name of the image file to operate on\n");
             break;
         case 'f':
             fmt = optarg;
-- 
2.39.2


