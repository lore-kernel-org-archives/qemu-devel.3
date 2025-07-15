Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EC9C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublPz-0000mg-ML; Tue, 15 Jul 2025 15:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxk-0004Tq-DL
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxi-0001h3-2O
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=taA1HNznqd+8+gUd6weUC37cDbdr9lH7xvfJoqHRmag=;
 b=CnnN1M3vlLQd1IvvcAmaL1ja4phQA2J0PTxOB0hWfkZLaj92foBMMLOSx8JhdxnGMib1/C
 uK+V52ETeejmWqGPSTwMWUA7KeAnhsCeO1Dfumc0p7MkXfsui9x6H5SXpZFmxqO3BfLjua
 hGNzxwJtg+8FuXpuWLWd+7l9AAiGoCk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-JHv3wn5sOyC5UBGW2mQIvQ-1; Tue,
 15 Jul 2025 15:05:04 -0400
X-MC-Unique: JHv3wn5sOyC5UBGW2mQIvQ-1
X-Mimecast-MFC-AGG-ID: JHv3wn5sOyC5UBGW2mQIvQ_1752606304
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E03E5195608C; Tue, 15 Jul 2025 19:05:03 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 604C81977030; Tue, 15 Jul 2025 19:05:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 41/57] qemu-img: compare: refresh options/--help
Date: Tue, 15 Jul 2025 21:03:14 +0200
Message-ID: <20250715190330.378764-42-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Michael Tokarev <mjt@tls.msk.ru>

Add long options, add help, reorder options for consistency.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250531171609.197078-12-mjt@tls.msk.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 64 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index a7a07ed4bc..5697e45ae6 100644
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
2.50.1


