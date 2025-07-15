Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F91C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublPB-0006jz-Jo; Tue, 15 Jul 2025 15:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxd-0004R8-N6
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxa-0001Uj-Sd
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bM/ndj+zs+ovWmu1zKPcZ9oQv4zNM2g/RteAdcjIdXM=;
 b=GcZjmGDUlJ1hjIT1pGE4QuEu0b+pta4tLydNyL0Biv7LCRcl42EEiihkCbOtvdxubWPW8r
 ibGAQPgWGuwFoF8T14aEiBSk0/TbnsKjL1i4OJbxK43a/cNM/Irt3ft45BSs7Sm/81n7qB
 7Vd6I+SkDgoVprxkQ1a1ywbwwRrqP3s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683--FvOFCagNkuz38nNL-dYEQ-1; Tue,
 15 Jul 2025 15:05:00 -0400
X-MC-Unique: -FvOFCagNkuz38nNL-dYEQ-1
X-Mimecast-MFC-AGG-ID: -FvOFCagNkuz38nNL-dYEQ_1752606299
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC6AF18001D6; Tue, 15 Jul 2025 19:04:59 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18ED0197702B; Tue, 15 Jul 2025 19:04:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 39/57] qemu-img: commit: refresh options/--help
Date: Tue, 15 Jul 2025 21:03:12 +0200
Message-ID: <20250715190330.378764-40-kwolf@redhat.com>
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
Message-ID: <20250531171609.197078-10-mjt@tls.msk.ru>
[kwolf: Fixed up qemu-iotests]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c                 | 68 +++++++++++++++++++++++++++-----------
 tests/qemu-iotests/153     |  2 +-
 tests/qemu-iotests/153.out | 12 +++----
 3 files changed, 55 insertions(+), 27 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index ec6802b03b..9d2eba3b36 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1047,38 +1047,73 @@ static int img_commit(const img_cmd_t *ccmd, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
-            {"object", required_argument, 0, OPTION_OBJECT},
+            {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"cache", required_argument, 0, 't'},
+            {"drop", no_argument, 0, 'd'},
+            {"base", required_argument, 0, 'b'},
+            {"rate-limit", required_argument, 0, 'r'},
+            {"progress", no_argument, 0, 'p'},
+            {"quiet", no_argument, 0, 'q'},
+            {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:ht:b:dpqr:",
+        c = getopt_long(argc, argv, "hf:t:db:r:pq",
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
+            cmd_help(ccmd, "[-f FMT | --image-opts] [-t CACHE_MODE] [-b BASE_IMG]\n"
+"        [-d] [-r RATE] [-q] [--object OBJDEF] FILE\n"
+,
+"  -f, --format FMT\n"
+"     specify FILE image format explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat FILE as an option string (key=value,..), not a file name\n"
+"     (incompatible with -f|--format)\n"
+"  -t, --cache CACHE_MODE image cache mode (default: " BDRV_DEFAULT_CACHE ")\n"
+"  -d, --drop\n"
+"     skip emptying FILE on completion\n"
+"  -b, --base BASE_IMG\n"
+"     image in the backing chain to commit change to\n"
+"     (default: immediate backing file; implies --drop)\n"
+"  -r, --rate-limit RATE\n"
+"     I/O rate limit, in bytes per second\n"
+"  -p, --progress\n"
+"     display progress information\n"
+"  -q, --quiet\n"
+"     quiet mode (produce only error messages if any)\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     name of the image file, or an option string (key=value,..)\n"
+"     with --image-opts, to operate on\n"
+);
             break;
         case 'f':
             fmt = optarg;
             break;
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
+            break;
         case 't':
             cache = optarg;
             break;
+        case 'd':
+            drop = true;
+            break;
         case 'b':
             base = optarg;
             /* -b implies -d */
             drop = true;
             break;
-        case 'd':
-            drop = true;
+        case 'r':
+            rate_limit = cvtnum("rate limit", optarg);
+            if (rate_limit < 0) {
+                return 1;
+            }
             break;
         case 'p':
             progress = true;
@@ -1086,18 +1121,11 @@ static int img_commit(const img_cmd_t *ccmd, int argc, char **argv)
         case 'q':
             quiet = true;
             break;
-        case 'r':
-            rate_limit = cvtnum("rate limit", optarg);
-            if (rate_limit < 0) {
-                return 1;
-            }
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
 
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 9bc3be8f75..1e02f6a6e3 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -63,7 +63,7 @@ _supported_proto file
 _run_cmd()
 {
     echo
-    (echo "$@"; "$@" 2>&1 1>/dev/null) | _filter_testdir
+    (echo "$@"; "$@" 2>&1 1>/dev/null) | _filter_testdir | _filter_qemu_img
 }
 
 _do_run_qemu()
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index ff8e55864a..a8ffd01266 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -124,8 +124,8 @@ qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information
 
 _qemu_img_wrapper commit -U TEST_DIR/t.qcow2
-qemu-img: unrecognized option '-U'
-Try 'qemu-img --help' for more information
+qemu-img commit: invalid option -- 'U'
+Try 'qemu-img commit --help' for more information
 
 _qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
 qemu-img: unrecognized option '-U'
@@ -248,8 +248,8 @@ qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information
 
 _qemu_img_wrapper commit -U TEST_DIR/t.qcow2
-qemu-img: unrecognized option '-U'
-Try 'qemu-img --help' for more information
+qemu-img commit: invalid option -- 'U'
+Try 'qemu-img commit --help' for more information
 
 _qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
 qemu-img: unrecognized option '-U'
@@ -353,8 +353,8 @@ qemu-img: unrecognized option '-U'
 Try 'qemu-img --help' for more information
 
 _qemu_img_wrapper commit -U TEST_DIR/t.qcow2
-qemu-img: unrecognized option '-U'
-Try 'qemu-img --help' for more information
+qemu-img commit: invalid option -- 'U'
+Try 'qemu-img commit --help' for more information
 
 _qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
 qemu-img: unrecognized option '-U'
-- 
2.50.1


