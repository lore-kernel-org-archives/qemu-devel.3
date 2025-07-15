Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A7DC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubla6-0007xc-GL; Tue, 15 Jul 2025 15:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubky4-0004cM-O8
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubky0-0001k0-4H
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1lCKRAPXwO+P9hHFfO7gDlUoNGs/rw9v8WnCn3tdTh0=;
 b=F0m4h7FQZoSVBn3mG4ZxkpzwCFHgoujjU2YkCBeLsLuM3Xv1E9wwPK92s+eTQhvSIzEmkc
 nYj9OfBWufMR6D3FvjHhqvaQ7XS4Jl11AcUvKag15CnDa2aNHxmAfJqUiZZCFt9yWLbpeS
 qG+xW0VbA3egLV3BAE3UV5aIq0jO/gI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374--g6hd7EpNL2WrYmbLvbKUw-1; Tue,
 15 Jul 2025 15:05:24 -0400
X-MC-Unique: -g6hd7EpNL2WrYmbLvbKUw-1
X-Mimecast-MFC-AGG-ID: -g6hd7EpNL2WrYmbLvbKUw_1752606323
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3A6D1800289; Tue, 15 Jul 2025 19:05:22 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 745E7197702B; Tue, 15 Jul 2025 19:05:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 50/57] qemu-img: resize: refresh options/--help
Date: Tue, 15 Jul 2025 21:03:23 +0200
Message-ID: <20250715190330.378764-51-kwolf@redhat.com>
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
Message-ID: <20250531171609.197078-21-mjt@tls.msk.ru>
[kwolf: Fixed up qemu-iotests]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c                 | 52 ++++++++++++++++++++++++++------------
 tests/qemu-iotests/153.out | 12 ++++-----
 2 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 36ef998a34..c16de265e0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4329,36 +4329,48 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
-            {"object", required_argument, 0, OPTION_OBJECT},
+            {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"preallocation", required_argument, 0, OPTION_PREALLOCATION},
             {"shrink", no_argument, 0, OPTION_SHRINK},
+            {"quiet", no_argument, 0, 'q'},
+            {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "-:f:hq",
+        c = getopt_long(argc, argv, "-hf:q",
                         long_options, NULL);
         if (c == -1) {
             break;
         }
         switch(c) {
-        case ':':
-            missing_argument(argv[optind - 1]);
-            break;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
-            break;
         case 'h':
-            help();
-            break;
+            cmd_help(ccmd, "[-f FMT | --image-opts] [--preallocation PREALLOC] [--shrink]\n"
+"        [-q] [--object OBJDEF] FILE [+-]SIZE[bkKMGTPE]\n"
+,
+"  -f, --format FMT\n"
+"     specify FILE format explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat FILE as an option string (key=value,...), not a file name\n"
+"     (incompatible with -f|--format)\n"
+"  --shrink\n"
+"     allow operation when the new size is smaller than the original\n"
+"  --preallocation PREALLOC\n"
+"     specify FMT-specific preallocation type for the new areas\n"
+"  -q, --quiet\n"
+"     quiet mode (produce only error messages if any)\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     name of the image file, or option string (key=value,..)\n"
+"     with --image-opts, to operate on\n"
+"  [+-]SIZE[bkKMGTPE]\n"
+"     new image size or amount by which to shrink (-)/grow (+),\n"
+"     with optional multiplier suffix (powers of 1024, default is bytes)\n"
+);
+            return 0;
         case 'f':
             fmt = optarg;
             break;
-        case 'q':
-            quiet = true;
-            break;
-        case OPTION_OBJECT:
-            user_creatable_process_cmdline(optarg);
-            break;
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
@@ -4373,6 +4385,12 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_SHRINK:
             shrink = true;
             break;
+        case 'q':
+            quiet = true;
+            break;
+        case OPTION_OBJECT:
+            user_creatable_process_cmdline(optarg);
+            break;
         case 1: /* a non-optional argument */
             if (!filename) {
                 filename = optarg;
@@ -4391,6 +4409,8 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
                 error_exit(argv[0], "Extra argument(s) in command line");
             }
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
     if (!filename && optind < argc) {
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index a8ffd01266..ac3e340e15 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -128,8 +128,8 @@ qemu-img commit: invalid option -- 'U'
 Try 'qemu-img commit --help' for more information
 
 _qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
-qemu-img: unrecognized option '-U'
-Try 'qemu-img --help' for more information
+qemu-img resize: invalid option -- 'U'
+Try 'qemu-img resize --help' for more information
 
 _qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
@@ -252,8 +252,8 @@ qemu-img commit: invalid option -- 'U'
 Try 'qemu-img commit --help' for more information
 
 _qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
-qemu-img: unrecognized option '-U'
-Try 'qemu-img --help' for more information
+qemu-img resize: invalid option -- 'U'
+Try 'qemu-img resize --help' for more information
 
 _qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
@@ -357,8 +357,8 @@ qemu-img commit: invalid option -- 'U'
 Try 'qemu-img commit --help' for more information
 
 _qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
-qemu-img: unrecognized option '-U'
-Try 'qemu-img --help' for more information
+qemu-img resize: invalid option -- 'U'
+Try 'qemu-img resize --help' for more information
 
 _qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base -F qcow2
 
-- 
2.50.1


