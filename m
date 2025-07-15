Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE542C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublV2-0004Ly-Ug; Tue, 15 Jul 2025 15:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubky0-0004XW-Bi
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxr-0001j1-FW
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NeOFjbUAUkbawhAGEAoI45uP3K98VPQeRTW+1GJ6km0=;
 b=Oa8vJ0NjDB4t3dwUhQCCTkcRX1ha80IOxzQo4OLtCyWn4GFvZr6rr7ATeDvMKbA4sp3Zgo
 YvMpYn5OMsaqGSlsWEeXCwIirCSoIJKLvsKQb/2LpHRfL4SweZM7n8RcQpyhb9TfVhdo98
 dBO0dXO+6CX951Pa5fz14RkTuUA80dA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-5xLuTCxHNzaBqpsCNJWiYA-1; Tue,
 15 Jul 2025 15:05:17 -0400
X-MC-Unique: 5xLuTCxHNzaBqpsCNJWiYA-1
X-Mimecast-MFC-AGG-ID: 5xLuTCxHNzaBqpsCNJWiYA_1752606316
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 797D21800368; Tue, 15 Jul 2025 19:05:16 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDCC2197702B; Tue, 15 Jul 2025 19:05:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 47/57] qemu-img: snapshot: refresh options/--help
Date: Tue, 15 Jul 2025 21:03:20 +0200
Message-ID: <20250715190330.378764-48-kwolf@redhat.com>
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
Message-ID: <20250531171609.197078-18-mjt@tls.msk.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 60 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index f117efe687..cc26ae9100 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3611,29 +3611,58 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
-            {"object", required_argument, 0, OPTION_OBJECT},
+            {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"list", no_argument, 0, SNAPSHOT_LIST},
+            {"apply", required_argument, 0, SNAPSHOT_APPLY},
+            {"create", required_argument, 0, SNAPSHOT_CREATE},
+            {"delete", required_argument, 0, SNAPSHOT_DELETE},
             {"force-share", no_argument, 0, 'U'},
+            {"quiet", no_argument, 0, 'q'},
+            {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":la:c:d:f:hqU",
+        c = getopt_long(argc, argv, "hf:la:c:d:Uq",
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
-            return 0;
+            cmd_help(ccmd, "[-f FMT | --image-opts] [-l | -a|-c|-d SNAPSHOT]\n"
+"        [-U] [-q] [--object OBJDEF] FILE\n"
+,
+"  -f, --format FMT\n"
+"     specify FILE format explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat FILE as an option string (key=value,..), not a file name\n"
+"     (incompatible with -f|--format)\n"
+"  -l, --list\n"
+"     list snapshots in FILE (default action if no -l|-c|-a|-d is given)\n"
+"  -c, --create SNAPSHOT\n"
+"     create named snapshot\n"
+"  -a, --apply SNAPSHOT\n"
+"     apply named snapshot to the base\n"
+"  -d, --delete SNAPSHOT\n"
+"     delete named snapshot\n"
+"  (only one of -l|-c|-a|-d can be specified)\n"
+"  -U, --force-share\n"
+"     open image in shared mode for concurrent access\n"
+"  -q, --quiet\n"
+"     quiet mode (produce only error messages if any)\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     name of the image file, or option string (key=value,..)\n"
+"     with --image-opts) to operate on\n"
+);
+            break;
         case 'f':
             fmt = optarg;
             break;
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
+            break;
         case SNAPSHOT_LIST:
         case SNAPSHOT_APPLY:
         case SNAPSHOT_CREATE:
@@ -3645,18 +3674,17 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
             action = c;
             snapshot_name = optarg;
             break;
-        case 'q':
-            quiet = true;
-            break;
         case 'U':
             force_share = true;
             break;
+        case 'q':
+            quiet = true;
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


