Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3865C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublQ5-000162-CX; Tue, 15 Jul 2025 15:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubky8-0004eU-Uc
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubky4-0001lQ-Ou
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xeqGBdSIo1Kezt99V2b6a5nLGVaHJEmc+IWu5aa0NyQ=;
 b=AHc/uc0cZI1T15cj2Ml8X224aDYsSKUGjM1NN2E3yYGq1AHep21Iszrl/9al1l15oGt1/A
 5ecuYx+RNMyzr6eR4TjUsQsy5J7ujJiex5UWGzPPLkAksPZZ/kShaMaK15nm+3usJ2mG+A
 TYg7i3FyUauTfnw2ktOdJvyuPnOpiko=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-oYyfQ9VyMICZGLfrWliUng-1; Tue,
 15 Jul 2025 15:05:29 -0400
X-MC-Unique: oYyfQ9VyMICZGLfrWliUng-1
X-Mimecast-MFC-AGG-ID: oYyfQ9VyMICZGLfrWliUng_1752606329
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 028C118002AB; Tue, 15 Jul 2025 19:05:29 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77223197702C; Tue, 15 Jul 2025 19:05:27 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 53/57] qemu-img: bitmap: refresh options/--help
Date: Tue, 15 Jul 2025 21:03:26 +0200
Message-ID: <20250715190330.378764-54-kwolf@redhat.com>
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250531171609.197078-24-mjt@tls.msk.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 80 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 17f7516a68..d7f69c4bfb 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5184,48 +5184,69 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
     for (;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
-            {"object", required_argument, 0, OPTION_OBJECT},
+            {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"add", no_argument, 0, OPTION_ADD},
+            {"granularity", required_argument, 0, 'g'},
             {"remove", no_argument, 0, OPTION_REMOVE},
             {"clear", no_argument, 0, OPTION_CLEAR},
             {"enable", no_argument, 0, OPTION_ENABLE},
             {"disable", no_argument, 0, OPTION_DISABLE},
             {"merge", required_argument, 0, OPTION_MERGE},
-            {"granularity", required_argument, 0, 'g'},
             {"source-file", required_argument, 0, 'b'},
             {"source-format", required_argument, 0, 'F'},
+            {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":b:f:F:g:h", long_options, NULL);
+        c = getopt_long(argc, argv, "hf:g:b:F:",
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
-            break;
-        case 'b':
-            src_filename = optarg;
+            cmd_help(ccmd, "[-f FMT | --image-opts]\n"
+"        ( --add [-g SIZE] | --remove | --clear | --enable | --disable |\n"
+"          --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
+"        [--object OBJDEF] FILE BITMAP\n"
+,
+"  -f, --format FMT\n"
+"     specify FILE format explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat FILE as an option string (key=value,..), not a file name\n"
+"     (incompatible with -f|--format)\n"
+"  --add\n"
+"     creates BITMAP in FILE, enables to record future edits\n"
+"  -g, --granularity SIZE[bKMGTPE]\n"
+"     sets non-default granularity for the bitmap being added,\n"
+"     with optional multiplier suffix (in powers of 1024)\n"
+"  --remove\n"
+"     removes BITMAP from FILE\n"
+"  --clear\n"
+"     clears BITMAP in FILE\n"
+"  --enable, --disable\n"
+"     starts and stops recording future edits to BITMAP in FILE\n"
+"  --merge SOURCE\n"
+"     merges contents of the SOURCE bitmap into BITMAP in FILE\n"
+"  -b, --source-file SRC_FILE\n"
+"     select alternative source file for --merge\n"
+"  -F, --source-format SRC_FMT\n"
+"     specify format for SRC_FILE explicitly\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     name of the image file, or option string (key=value,..)\n"
+"     with --image-opts, to operate on\n"
+"  BITMAP\n"
+"     name of the bitmap to add, remove, clear, enable, disable or merge to\n"
+);
             break;
         case 'f':
             fmt = optarg;
             break;
-        case 'F':
-            src_fmt = optarg;
-            break;
-        case 'g':
-            granularity = cvtnum("granularity", optarg);
-            if (granularity < 0) {
-                return 1;
-            }
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
             break;
         case OPTION_ADD:
             act = g_new0(ImgBitmapAction, 1);
@@ -5233,6 +5254,12 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
             add = true;
             break;
+        case 'g':
+            granularity = cvtnum("granularity", optarg);
+            if (granularity < 0) {
+                return 1;
+            }
+            break;
         case OPTION_REMOVE:
             act = g_new0(ImgBitmapAction, 1);
             act->act = BITMAP_REMOVE;
@@ -5260,12 +5287,17 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
             merge = true;
             break;
+        case 'b':
+            src_filename = optarg;
+            break;
+        case 'F':
+            src_fmt = optarg;
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
 
-- 
2.50.1


