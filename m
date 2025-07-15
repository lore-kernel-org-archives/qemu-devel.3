Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22829C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublaF-0000Sb-RZ; Tue, 15 Jul 2025 15:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkyA-0004fs-Ma
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubky8-0001mT-MH
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dRAY1iHGe9JZU4c78ar1+cHtiyObqQqXuvtezlNWzEw=;
 b=DSevb9wFuUvHWax9LiQm2CRaXUS9ICK4Px45YRaa7Aygf8eZTrkUNmu9z29AXUw58MZfXe
 Mhf/5XUlHy7cdPbCPbWnO+pchbq5A457gDa1/xmYkSw+XP/0m3oSX7it9yhZ11MY2Qre6c
 vId1jAvRH8/rXJIQ3ZPq3A+Jk4xGgNo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-fnn8_Nh4MgeykDYI-33kAQ-1; Tue,
 15 Jul 2025 15:05:33 -0400
X-MC-Unique: fnn8_Nh4MgeykDYI-33kAQ-1
X-Mimecast-MFC-AGG-ID: fnn8_Nh4MgeykDYI-33kAQ_1752606333
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04AB918002EC; Tue, 15 Jul 2025 19:05:33 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79BE0197702B; Tue, 15 Jul 2025 19:05:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 55/57] qemu-img: measure: refresh options/--help
Date: Tue, 15 Jul 2025 21:03:28 +0200
Message-ID: <20250715190330.378764-56-kwolf@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Also add -s short option for --size (and remove OPTION_SIZE).

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250531171609.197078-26-mjt@tls.msk.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 89 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 27 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 35c3d9ad48..a7d9d50250 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -72,7 +72,6 @@ enum {
     OPTION_FLUSH_INTERVAL = 261,
     OPTION_NO_DRAIN = 262,
     OPTION_TARGET_IMAGE_OPTS = 263,
-    OPTION_SIZE = 264,
     OPTION_PREALLOCATION = 265,
     OPTION_SHRINK = 266,
     OPTION_SALVAGE = 267,
@@ -5786,15 +5785,6 @@ static void dump_json_block_measure_info(BlockMeasureInfo *info)
 
 static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
 {
-    static const struct option long_options[] = {
-        {"help", no_argument, 0, 'h'},
-        {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
-        {"object", required_argument, 0, OPTION_OBJECT},
-        {"output", required_argument, 0, OPTION_OUTPUT},
-        {"size", required_argument, 0, OPTION_SIZE},
-        {"force-share", no_argument, 0, 'U'},
-        {0, 0, 0, 0}
-    };
     OutputFormat output_format = OFORMAT_HUMAN;
     BlockBackend *in_blk = NULL;
     BlockDriver *drv;
@@ -5815,23 +5805,61 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
     int ret = 1;
     int c;
 
-    while ((c = getopt_long(argc, argv, "hf:O:o:l:U",
+    static const struct option long_options[] = {
+        {"help", no_argument, 0, 'h'},
+        {"source-format", required_argument, 0, 'f'}, /* img_convert */
+        {"format", required_argument, 0, 'f'},
+        {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+        {"source-image-opts", no_argument, 0, OPTION_IMAGE_OPTS}, /* img_convert */
+        {"snapshot", required_argument, 0, 'l'},
+        {"target-format", required_argument, 0, 'O'},
+        {"target-format-options", required_argument, 0, 'o'}, /* img_convert */
+        {"options", required_argument, 0, 'o'},
+        {"force-share", no_argument, 0, 'U'},
+        {"output", required_argument, 0, OPTION_OUTPUT},
+        {"object", required_argument, 0, OPTION_OBJECT},
+        {"size", required_argument, 0, 's'},
+        {0, 0, 0, 0}
+    };
+
+    while ((c = getopt_long(argc, argv, "hf:l:O:o:Us:",
                             long_options, NULL)) != -1) {
         switch (c) {
-        case '?':
         case 'h':
-            help();
+            cmd_help(ccmd, "[-f FMT|--image-opts] [-l SNAPSHOT]\n"
+"       [-O TARGET_FMT] [-o TARGET_FMT_OPTS] [--output human|json]\n"
+"       [--object OBJDEF] (--size SIZE | FILE)\n"
+,
+"  -f, --format\n"
+"     specify format of FILE explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     indicates that FILE is a complete image specification\n"
+"     instead of a file name (incompatible with --format)\n"
+"  -l, --snapshot SNAPSHOT\n"
+"     use this snapshot in FILE as source\n"
+"  -O, --target-format TARGET_FMT\n"
+"     desired target/output image format (default: raw)\n"
+"  -o TARGET_FMT_OPTS\n"
+"     options specific to TARGET_FMT\n"
+"  --output human|json\n"
+"     output format (default: human)\n"
+"  -U, --force-share\n"
+"     open images in shared mode for concurrent access\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  -s, --size SIZE[bKMGTPE]\n"
+"     measure file size for given image size,\n"
+"     with optional multiplier suffix (powers of 1024)\n"
+"  FILE\n"
+"     measure file size required to convert from FILE (either a file name\n"
+"     or an option string (key=value,..) with --image-options)\n"
+);
             break;
         case 'f':
             fmt = optarg;
             break;
-        case 'O':
-            out_fmt = optarg;
-            break;
-        case 'o':
-            if (accumulate_options(&options, optarg) < 0) {
-                goto out;
-            }
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
             break;
         case 'l':
             if (strstart(optarg, SNAPSHOT_OPT_BASE, NULL)) {
@@ -5846,24 +5874,31 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
                 snapshot_name = optarg;
             }
             break;
-        case 'U':
-            force_share = true;
+        case 'O':
+            out_fmt = optarg;
             break;
-        case OPTION_OBJECT:
-            user_creatable_process_cmdline(optarg);
+        case 'o':
+            if (accumulate_options(&options, optarg) < 0) {
+                goto out;
+            }
             break;
-        case OPTION_IMAGE_OPTS:
-            image_opts = true;
+        case 'U':
+            force_share = true;
             break;
         case OPTION_OUTPUT:
             output_format = parse_output_format(argv[0], optarg);
             break;
-        case OPTION_SIZE:
+        case OPTION_OBJECT:
+            user_creatable_process_cmdline(optarg);
+            break;
+        case 's':
             img_size = cvtnum("image size", optarg);
             if (img_size < 0) {
                 goto out;
             }
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.50.1


