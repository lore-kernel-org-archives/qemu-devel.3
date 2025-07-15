Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6782FC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublV7-0004sU-Mh; Tue, 15 Jul 2025 15:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubky4-0004cP-R2
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubky1-0001kR-EE
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uCRQHqcaIupLbmBWoiFd2iNSs6s7kpg5Vp92ZSuOuY=;
 b=LxbQb8oTRvnt13FenoIW+pl4nvLzG+49Q1bchWbrpTqkXvIfZr8DufGdCPekXs35XtnNQn
 qKGxBD4++nqFyzNv6Xr3BoF9BRVGnExV8XfxUDqGKZ3VYcu/N22VKJkTw0WwxWHF21yv0G
 U3b6gI/zIZ5AYGzTWmJQs7OqmXtg1Mc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-pAkKV5qzNqqY-YBUYroUxQ-1; Tue,
 15 Jul 2025 15:05:25 -0400
X-MC-Unique: pAkKV5qzNqqY-YBUYroUxQ-1
X-Mimecast-MFC-AGG-ID: pAkKV5qzNqqY-YBUYroUxQ_1752606325
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02CF41956087; Tue, 15 Jul 2025 19:05:25 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 75B8E197702F; Tue, 15 Jul 2025 19:05:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 51/57] qemu-img: amend: refresh options/--help
Date: Tue, 15 Jul 2025 21:03:24 +0200
Message-ID: <20250715190330.378764-52-kwolf@redhat.com>
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
Message-ID: <20250531171609.197078-22-mjt@tls.msk.ru>
[kwolf: Fixed up qemu-iotests]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c                 | 54 +++++++++++++++++++++++++++-----------
 tests/qemu-iotests/153.out | 12 ++++-----
 2 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index c16de265e0..bb10569372 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4564,26 +4564,48 @@ static int img_amend(const img_cmd_t *ccmd, int argc, char **argv)
     for (;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
-            {"object", required_argument, 0, OPTION_OBJECT},
+            {"options", required_argument, 0, 'o'},
+            {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"cache", required_argument, 0, 't'},
             {"force", no_argument, 0, OPTION_FORCE},
+            {"progress", no_argument, 0, 'p'},
+            {"quiet", no_argument, 0, 'q'},
+            {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":ho:f:t:pq",
+        c = getopt_long(argc, argv, "ho:f:t:pq",
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
+            cmd_help(ccmd, "-o FMT_OPTS [-f FMT | --image-opts]\n"
+"        [-t CACHE] [--force] [-p] [-q] [--object OBJDEF] FILE\n"
+,
+"  -o, --options FMT_OPTS\n"
+"     FMT-specfic format options (required)\n"
+"  -f, --format FMT\n"
+"     specify FILE format explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat FILE as an option string (key=value,..), not a file name\n"
+"     (incompatible with -f|--format)\n"
+"  -t, --cache CACHE\n"
+"     cache mode for FILE (default: " BDRV_DEFAULT_CACHE ")\n"
+"  --force\n"
+"     allow certain unsafe operations\n"
+"  -p, --progres\n"
+"     show operation progress\n"
+"  -q, --quiet\n"
+"     quiet mode (produce only error messages if any)\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     name of the image file, or option string (key=value,..)\n"
+"     with --image-opts, to operate on\n"
+);
             break;
         case 'o':
             if (accumulate_options(&options, optarg) < 0) {
@@ -4594,9 +4616,15 @@ static int img_amend(const img_cmd_t *ccmd, int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
+            break;
         case 't':
             cache = optarg;
             break;
+        case OPTION_FORCE:
+            force = true;
+            break;
         case 'p':
             progress = true;
             break;
@@ -4606,12 +4634,8 @@ static int img_amend(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_OBJECT:
             user_creatable_process_cmdline(optarg);
             break;
-        case OPTION_IMAGE_OPTS:
-            image_opts = true;
-            break;
-        case OPTION_FORCE:
-            force = true;
-            break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index ac3e340e15..28e1a22952 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -120,8 +120,8 @@ _qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
 _qemu_img_wrapper map -U TEST_DIR/t.qcow2
 
 _qemu_img_wrapper amend -o size=32M -U TEST_DIR/t.qcow2
-qemu-img: unrecognized option '-U'
-Try 'qemu-img --help' for more information
+qemu-img amend: invalid option -- 'U'
+Try 'qemu-img amend --help' for more information
 
 _qemu_img_wrapper commit -U TEST_DIR/t.qcow2
 qemu-img commit: invalid option -- 'U'
@@ -244,8 +244,8 @@ _qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
 _qemu_img_wrapper map -U TEST_DIR/t.qcow2
 
 _qemu_img_wrapper amend -o size=32M -U TEST_DIR/t.qcow2
-qemu-img: unrecognized option '-U'
-Try 'qemu-img --help' for more information
+qemu-img amend: invalid option -- 'U'
+Try 'qemu-img amend --help' for more information
 
 _qemu_img_wrapper commit -U TEST_DIR/t.qcow2
 qemu-img commit: invalid option -- 'U'
@@ -349,8 +349,8 @@ _qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
 _qemu_img_wrapper map -U TEST_DIR/t.qcow2
 
 _qemu_img_wrapper amend -o size=32M -U TEST_DIR/t.qcow2
-qemu-img: unrecognized option '-U'
-Try 'qemu-img --help' for more information
+qemu-img amend: invalid option -- 'U'
+Try 'qemu-img amend --help' for more information
 
 _qemu_img_wrapper commit -U TEST_DIR/t.qcow2
 qemu-img commit: invalid option -- 'U'
-- 
2.50.1


