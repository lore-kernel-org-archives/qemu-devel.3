Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CA2C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublUv-0003bB-1K; Tue, 15 Jul 2025 15:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxp-0004Up-Qx
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxn-0001i0-1l
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PhLaAdsNrHeY9YCqj4vc9nJxGGtEE9fcIaoknxQSwGI=;
 b=OkvBcVLKQrzaxEYYG/KEZ4AU3WtRTmQgR/29R3c1rUfcbuf0zZLSJmCDFNFaCYMcR0NcvJ
 hR8IjzB4Y1JrufBZiDivtcvZXExlSmMyIv+AtRVCZCnWHO7+0WbQ7a79OPpGEaXPZ0o3oH
 c6JP8Mi1jMnP1mZ5rbH47GEAkjNP51M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-5chfcuU1NcyEo6uZm-_VRw-1; Tue,
 15 Jul 2025 15:05:11 -0400
X-MC-Unique: 5chfcuU1NcyEo6uZm-_VRw-1
X-Mimecast-MFC-AGG-ID: 5chfcuU1NcyEo6uZm-_VRw_1752606310
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F786180024D; Tue, 15 Jul 2025 19:05:10 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72655197702B; Tue, 15 Jul 2025 19:05:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 44/57] qemu-img: map: refresh options/--help
Date: Tue, 15 Jul 2025 21:03:17 +0200
Message-ID: <20250715190330.378764-45-kwolf@redhat.com>
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

While at it, remove unused option_index variable.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250715140903.131529-1-mjt@tls.msk.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 59 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 530123bfdf..a02ccad943 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3453,41 +3453,53 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
 
     fmt = NULL;
     for (;;) {
-        int option_index = 0;
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
             {"format", required_argument, 0, 'f'},
-            {"output", required_argument, 0, OPTION_OUTPUT},
-            {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
-            {"force-share", no_argument, 0, 'U'},
             {"start-offset", required_argument, 0, 's'},
             {"max-length", required_argument, 0, 'l'},
+            {"force-share", no_argument, 0, 'U'},
+            {"output", required_argument, 0, OPTION_OUTPUT},
+            {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:s:l:hU",
-                        long_options, &option_index);
+        c = getopt_long(argc, argv, "hf:s:l:U",
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
+            cmd_help(ccmd, "[-f FMT | --image-opts]\n"
+"        [--start-offset OFFSET] [--max-length LENGTH]\n"
+"        [--output human|json] [-U] [--object OBJDEF] FILE\n"
+,
+"  -f, --format FMT\n"
+"     specify FILE image format explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat FILE as an option string (key=value,..), not a file name\n"
+"     (incompatible with -f|--format)\n"
+"  -s, --start-offset OFFSET\n"
+"     start at the given OFFSET in the image, not at the beginning\n"
+"  -l, --max-length LENGTH\n"
+"     process at most LENGTH bytes instead of up to the end of the image\n"
+"  --output human|json\n"
+"     specify output format name (default: human)\n"
+"  -U, --force-share\n"
+"     open image in shared mode for concurrent access\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     the image file name, or option string (key=value,..)\n"
+"     with --image-opts, to operate on\n"
+);
             break;
         case 'f':
             fmt = optarg;
             break;
-        case 'U':
-            force_share = true;
-            break;
-        case OPTION_OUTPUT:
-            output_format = parse_output_format(argv[0], optarg);
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
             break;
         case 's':
             start_offset = cvtnum("start offset", optarg);
@@ -3501,12 +3513,17 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
                 return 1;
             }
             break;
+        case OPTION_OUTPUT:
+            output_format = parse_output_format(argv[0], optarg);
+            break;
+        case 'U':
+            force_share = true;
+            break;
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
     if (optind != argc - 1) {
-- 
2.50.1


