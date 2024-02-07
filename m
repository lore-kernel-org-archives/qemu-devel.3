Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E396C4829C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 17:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmCY-0004FT-3B; Wed, 07 Feb 2024 12:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXmBx-0003ZB-Lh; Wed, 07 Feb 2024 12:58:39 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXmBv-000446-EO; Wed, 07 Feb 2024 12:58:36 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3BAE84B3D6;
 Wed,  7 Feb 2024 20:59:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 58AFB763A6;
 Wed,  7 Feb 2024 20:58:24 +0300 (MSK)
Received: (nullmailer pid 296937 invoked by uid 1000);
 Wed, 07 Feb 2024 17:58:19 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 7/8] qemu-img: refresh options/--help for "compare" command
Date: Wed,  7 Feb 2024 20:58:16 +0300
Message-Id: <26f7115bd518de2b85955520ff714035ba21aee1.1707328606.git.mjt@tls.msk.ru>
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
 qemu-img.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 7ff63aeea2..ea3fe95169 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1447,9 +1447,15 @@ static int img_compare(const char *cmdname, int argc, char **argv)
     for (;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
+            {"quiet", no_argument, 0, 'q'},
             {"object", required_argument, 0, OPTION_OBJECT},
+            {"cache", required_argument, 0, 'T'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"format", required_argument, 0, 'f'},
+            {"format2?", required_argument, 0, 'F'},
             {"force-share", no_argument, 0, 'U'},
+            {"strict", no_argument, 0, 's'},
+            {"progress", no_argument, 0, 'p'},
             {0, 0, 0, 0}
         };
         c = getopt_long(argc, argv, ":hf:F:T:pqsU",
@@ -1465,7 +1471,18 @@ static int img_compare(const char *cmdname, int argc, char **argv)
             unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
-            help();
+            cmd_help(cmdname, "[OPTIONS] FILENAME1 FILENAME2",
+                     "Check if two images have the same content",
+" -q|--quiet - quiet operation\n"
+" -T|--cache - CACHE_MODE cache mode when opening images (" BDRV_DEFAULT_CACHE ")\n"
+"  instead of file names (incompatible with --format)\n"
+" -f|--format FMT - specify FILENAME1 image format explicitly\n"
+" -F|--format2? FMT - specify FILENAME2 image format explicitly\n"
+" -U|--force-share - open images in shared mode for concurrent access\n"
+" -s|--strict - strict mode, also check if sizes are equal\n"
+" -p|--progress - show operation progress\n"
+" --object OBJDEF - QEMU user-creatable object (eg encryption key)\n"
+" FILENAME1, FILENAME2 - image files to compare\n");
             break;
         case 'f':
             fmt1 = optarg;
-- 
2.39.2


