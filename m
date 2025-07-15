Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4470C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublQL-0002iE-VF; Tue, 15 Jul 2025 15:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkyD-0004h5-Fz
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkyB-0001nY-L2
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0EOHuFMYVRcuZbgCHTLu4jqLIKx67Yh5hSOj0aEp0I=;
 b=WgDOaaL3i6T8YgVvBxuJ2M4GZ0wrJkLW61TLGoyyOCOD+OHwkrY+BsTC/4J3Oh9eEOAPLO
 JC9Gv6/a8UFoKdwRZCjtrWPGZh6zI4RDE7Exkcv+Mpziwd6BlEmpf9+yAe67LrzUJzSStU
 Bq1TGZshhTgl2iI1bJuWml9W95qbexA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-QbDz8SZBOleUTZb4lL_XoQ-1; Tue,
 15 Jul 2025 15:05:35 -0400
X-MC-Unique: QbDz8SZBOleUTZb4lL_XoQ-1
X-Mimecast-MFC-AGG-ID: QbDz8SZBOleUTZb4lL_XoQ_1752606331
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0503119560B1; Tue, 15 Jul 2025 19:05:31 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 78603197702B; Tue, 15 Jul 2025 19:05:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 54/57] qemu-img: dd: refresh options/--help
Date: Tue, 15 Jul 2025 21:03:27 +0200
Message-ID: <20250715190330.378764-55-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Add missing long options and --help output,
reorder options for consistency.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250531171609.197078-25-mjt@tls.msk.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index d7f69c4bfb..35c3d9ad48 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5538,31 +5538,54 @@ static int img_dd(const img_cmd_t *ccmd, int argc, char **argv)
     };
     const struct option long_options[] = {
         { "help", no_argument, 0, 'h'},
-        { "object", required_argument, 0, OPTION_OBJECT},
+        { "format", required_argument, 0, 'f'},
         { "image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+        { "output-format", required_argument, 0, 'O'},
         { "force-share", no_argument, 0, 'U'},
+        { "object", required_argument, 0, OPTION_OBJECT},
         { 0, 0, 0, 0 }
     };
 
-    while ((c = getopt_long(argc, argv, ":hf:O:U", long_options, NULL))) {
+    while ((c = getopt_long(argc, argv, "hf:O:U", long_options, NULL))) {
         if (c == EOF) {
             break;
         }
         switch (c) {
-        case 'O':
-            out_fmt = optarg;
+        case 'h':
+            cmd_help(ccmd, "[-f FMT|--image-opts] [-O OUTPUT_FMT] [-U]\n"
+"        [--object OBJDEF] [bs=BLOCK_SIZE] [count=BLOCKS] if=INPUT of=OUTPUT\n"
+,
+"  -f, --format FMT\n"
+"     specify format for INPUT explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat INPUT as an option string (key=value,..), not a file name\n"
+"     (incompatible with -f|--format)\n"
+"  -O, --output-format OUTPUT_FMT\n"
+"     format of the OUTPUT (default: raw)\n"
+"  -U, --force-share\n"
+"     open images in shared mode for concurrent access\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  bs=BLOCK_SIZE[bKMGTP]\n"
+"     size of the I/O block, with optional multiplier suffix (powers of 1024)\n"
+"     (default: 512)\n"
+"  count=COUNT\n"
+"     number of blocks to convert (default whole INPUT)\n"
+"  if=INPUT\n"
+"     name of the file, or option string (key=value,..)\n"
+"     with --image-opts, to use for input\n"
+"  of=OUTPUT\n"
+"     output file name to create (will be overridden if alrady exists)\n"
+);
             break;
         case 'f':
             fmt = optarg;
             break;
-        case ':':
-            missing_argument(argv[optind - 1]);
-            break;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
             break;
-        case 'h':
-            help();
+        case 'O':
+            out_fmt = optarg;
             break;
         case 'U':
             force_share = true;
@@ -5570,9 +5593,8 @@ static int img_dd(const img_cmd_t *ccmd, int argc, char **argv)
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


