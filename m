Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9526BC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublVI-0005na-94; Tue, 15 Jul 2025 15:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubky4-0004c8-7I
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxy-0001jd-FZ
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yXO12lqeAejIfqZYD1cIDDsv+hSmsSqDNw0zNqDMET8=;
 b=AClOY5F/XLY6hlG3gAam83fHagSL0qolfsTe1KslUqDrccs4EOYx0qB6XOc3wPEUIijDwn
 ZCqLIkOfp8vC4qS9CXBWZzbwSyqrvqXj/5VOl/RZ80nNTh4ODzidHIRIpyPTSwOkNtUVgR
 JT/hiVHcRvOFnc7326i34NHXPFvOFpg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-JHI-nqnmPv6EFrRgVs6WLw-1; Tue,
 15 Jul 2025 15:05:19 -0400
X-MC-Unique: JHI-nqnmPv6EFrRgVs6WLw-1
X-Mimecast-MFC-AGG-ID: JHI-nqnmPv6EFrRgVs6WLw_1752606319
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F110A19560B7; Tue, 15 Jul 2025 19:05:18 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDEDF197702B; Tue, 15 Jul 2025 19:05:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 48/57] qemu-img: rebase: refresh options/--help (short option
 change)
Date: Tue, 15 Jul 2025 21:03:21 +0200
Message-ID: <20250715190330.378764-49-kwolf@redhat.com>
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

Use -B for --backing-format, keep -F for
backwards compatibility.

Options added:
 --format, --cache - for the image in question
 --backing, --backing-format, --backing-cache, --backing-unsafe -
   for the new backing file
(was eg CACHE vs SRC_CACHE, which is unclear).

Probably should rename local variables.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250531171609.197078-19-mjt@tls.msk.ru>
[kwolf: Removed command description from the argument list]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/tools/qemu-img.rst |  2 +-
 qemu-img.c              | 87 +++++++++++++++++++++++++++++------------
 2 files changed, 63 insertions(+), 26 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index a346988292..5e7b85079d 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -667,7 +667,7 @@ Command description:
 
   List, apply, create or delete snapshots in image *FILENAME*.
 
-.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] [-c] -b BACKING_FILE [-F BACKING_FMT] FILENAME
+.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] [-c] -b BACKING_FILE [-B BACKING_FMT] FILENAME
 
   Changes the backing file of an image. Only the formats ``qcow2`` and
   ``qed`` support changing the backing file.
diff --git a/qemu-img.c b/qemu-img.c
index cc26ae9100..a02d271af1 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3798,45 +3798,89 @@ static int img_rebase(const img_cmd_t *ccmd, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
-            {"object", required_argument, 0, OPTION_OBJECT},
+            {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
-            {"force-share", no_argument, 0, 'U'},
+            {"cache", required_argument, 0, 't'},
             {"compress", no_argument, 0, 'c'},
+            {"backing", required_argument, 0, 'b'},
+            {"backing-format", required_argument, 0, 'B'},
+            {"backing-cache", required_argument, 0, 'T'},
+            {"backing-unsafe", no_argument, 0, 'u'},
+            {"force-share", no_argument, 0, 'U'},
+            {"progress", no_argument, 0, 'p'},
+            {"quiet", no_argument, 0, 'q'},
+            {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:F:b:upt:T:qUc",
+        c = getopt_long(argc, argv, "hf:t:cb:F:B:T:uUpq",
                         long_options, NULL);
         if (c == -1) {
             break;
         }
-        switch(c) {
-        case ':':
-            missing_argument(argv[optind - 1]);
-            break;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
-            break;
+        switch (c) {
         case 'h':
-            help();
+            cmd_help(ccmd, "[-f FMT | --image-opts] [-t CACHE]\n"
+"        [-b BACKING_FILE [-B BACKING_FMT] [-T BACKING_CACHE]] [-u]\n"
+"        [-c] [-U] [-p] [-q] [--object OBJDEF] FILE\n"
+,
+"  -f, --format FMT\n"
+"     specify FILE format explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat FILE as an option string (key=value,..), not a file name\n"
+"     (incompatible with -f|--format)\n"
+"  -t, --cache CACHE\n"
+"     cache mode for FILE (default: " BDRV_DEFAULT_CACHE ")\n"
+"  -b, --backing BACKING_FILE|\"\"\n"
+"     rebase onto this file (specify empty name for no backing file)\n"
+"  -B, --backing-format BACKING_FMT (was -F in <=10.0)\n"
+"     specify format for BACKING_FILE explicitly (default: probing is used)\n"
+"  -T, --backing-cache CACHE\n"
+"     BACKING_FILE cache mode (default: " BDRV_DEFAULT_CACHE ")\n"
+"  -u, --backing-unsafe\n"
+"     do not fail if BACKING_FILE can not be read\n"
+"  -c, --compress\n"
+"     compress image (when image supports this)\n"
+"  -U, --force-share\n"
+"     open image in shared mode for concurrent access\n"
+"  -p, --progress\n"
+"     display progress information\n"
+"  -q, --quiet\n"
+"     quiet mode (produce only error messages if any)\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     name of the image file, or option string (key=value,..)\n"
+"     with --image-opts, to operate on\n"
+);
             return 0;
         case 'f':
             fmt = optarg;
             break;
-        case 'F':
-            out_basefmt = optarg;
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
+            break;
+        case 't':
+            cache = optarg;
             break;
         case 'b':
             out_baseimg = optarg;
             break;
+        case 'F': /* <=10.0 */
+        case 'B':
+            out_basefmt = optarg;
+            break;
         case 'u':
             unsafe = 1;
             break;
+        case 'c':
+            compress = true;
+            break;
+        case 'U':
+            force_share = true;
+            break;
         case 'p':
             progress = 1;
             break;
-        case 't':
-            cache = optarg;
-            break;
         case 'T':
             src_cache = optarg;
             break;
@@ -3846,15 +3890,8 @@ static int img_rebase(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_OBJECT:
             user_creatable_process_cmdline(optarg);
             break;
-        case OPTION_IMAGE_OPTS:
-            image_opts = true;
-            break;
-        case 'U':
-            force_share = true;
-            break;
-        case 'c':
-            compress = true;
-            break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.50.1


