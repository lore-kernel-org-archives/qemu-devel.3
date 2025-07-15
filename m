Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DF1C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublQF-0001su-3G; Tue, 15 Jul 2025 15:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkyA-0004fq-MN
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubky8-0001mQ-MA
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RIw6lN3VR9AGDzYGEU+yhTDe/xM0MVxTUdBYuPo+K04=;
 b=IOg++eACpWgaZ67/5kTC05LP04a/Y+kncYwPvAhuPABCxcpkEGgVrhwe9NpXNmXZiZWA7p
 wkt2+gONfO4i9ZFk4TrAo/n4ADuAC3Z7PLp/XwS2af7h+U/d+vkN7FDEAxTQvqdyksKkKj
 FF4Js7+HFnl6h5Ou69gaIXFnzNJRmwY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-e2DNWBeGOHuH8qMIFjebTw-1; Tue,
 15 Jul 2025 15:05:27 -0400
X-MC-Unique: e2DNWBeGOHuH8qMIFjebTw-1
X-Mimecast-MFC-AGG-ID: e2DNWBeGOHuH8qMIFjebTw_1752606327
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01BE518002A8; Tue, 15 Jul 2025 19:05:27 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76BC5197702B; Tue, 15 Jul 2025 19:05:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 52/57] qemu-img: bench: refresh options/--help
Date: Tue, 15 Jul 2025 21:03:25 +0200
Message-ID: <20250715190330.378764-53-kwolf@redhat.com>
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

Add missing long options and --help output,
reorder options for consistency.

Add missing --object option.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250531171609.197078-23-mjt@tls.msk.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 112 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 84 insertions(+), 28 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index bb10569372..17f7516a68 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4864,28 +4864,93 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
     for (;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
-            {"flush-interval", required_argument, 0, OPTION_FLUSH_INTERVAL},
+            {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"cache", required_argument, 0, 't'},
+            {"count", required_argument, 0, 'c'},
+            {"depth", required_argument, 0, 'd'},
+            {"offset", required_argument, 0, 'o'},
+            {"buffer-size", required_argument, 0, 's'},
+            {"step-size", required_argument, 0, 'S'},
+            {"write", no_argument, 0, 'w'},
             {"pattern", required_argument, 0, OPTION_PATTERN},
+            {"flush-interval", required_argument, 0, OPTION_FLUSH_INTERVAL},
             {"no-drain", no_argument, 0, OPTION_NO_DRAIN},
+            {"aio", required_argument, 0, 'i'},
+            {"native", no_argument, 0, 'n'},
             {"force-share", no_argument, 0, 'U'},
+            {"quiet", no_argument, 0, 'q'},
+            {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hc:d:f:ni:o:qs:S:t:wU", long_options,
-                        NULL);
+        c = getopt_long(argc, argv, "hf:t:c:d:o:s:S:wi:nUq",
+                        long_options, NULL);
         if (c == -1) {
             break;
         }
 
         switch (c) {
-        case ':':
-            missing_argument(argv[optind - 1]);
+        case 'h':
+            cmd_help(ccmd, "[-f FMT | --image-opts] [-t CACHE]\n"
+"        [-c COUNT] [-d DEPTH] [-o OFFSET] [-s BUFFER_SIZE] [-S STEP_SIZE]\n"
+"        [-w [--pattern PATTERN] [--flush-interval INTERVAL [--no-drain]]]\n"
+"        [-i AIO] [-n] [-U] [-q] FILE\n"
+,
+"  -f, --format FMT\n"
+"     specify FILE format explicitly\n"
+"  --image-opts\n"
+"     indicates that FILE is a complete image specification\n"
+"     instead of a file name (incompatible with --format)\n"
+"  -t, --cache CACHE\n"
+"     cache mode for FILE (default: " BDRV_DEFAULT_CACHE ")\n"
+"  -c, --count COUNT\n"
+"     number of I/O requests to perform\n"
+"  -d, --depth DEPTH\n"
+"     number of requests to perform in parallel\n"
+"  -o, --offset OFFSET\n"
+"     start first request at this OFFSET\n"
+"  -s, --buffer-size BUFFER_SIZE[bkKMGTPE]\n"
+"     size of each I/O request, with optional multiplier suffix\n"
+"     (powers of 1024, default is 4K)\n"
+"  -S, --step-size STEP_SIZE[bkKMGTPE]\n"
+"     each next request offset increment, with optional multiplier suffix\n"
+"     (powers of 1024, default is the same as BUFFER_SIZE)\n"
+"  -w, --write\n"
+"     perform write test (default is read)\n"
+"  --pattern PATTERN\n"
+"     write this pattern byte instead of zero\n"
+"  --flush-interval FLUSH_INTERVAL\n"
+"     issue flush after this number of requests\n"
+"  --no-drain\n"
+"     do not wait when flushing pending requests\n"
+"  -i, --aio AIO\n"
+"     async-io backend (threads, native, io_uring)\n"
+"  -n, --native\n"
+"     use native AIO backend if possible\n"
+"  -U, --force-share\n"
+"     open images in shared mode for concurrent access\n"
+"  -q, --quiet\n"
+"     quiet mode (produce only error messages if any)\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     name of the image file, or option string (key=value,..)\n"
+"     with --image-opts, to operate on\n"
+);
             break;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
+        case 'f':
+            fmt = optarg;
             break;
-        case 'h':
-            help();
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
+            break;
+        case 't':
+            ret = bdrv_parse_cache_mode(optarg, &flags, &writethrough);
+            if (ret < 0) {
+                error_report("Invalid cache mode");
+                ret = -1;
+                goto out;
+            }
             break;
         case 'c':
         {
@@ -4909,9 +4974,6 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
             depth = res;
             break;
         }
-        case 'f':
-            fmt = optarg;
-            break;
         case 'n':
             flags |= BDRV_O_NATIVE_AIO;
             break;
@@ -4932,9 +4994,6 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
             break;
         }
             break;
-        case 'q':
-            quiet = true;
-            break;
         case 's':
         {
             int64_t sval;
@@ -4959,21 +5018,10 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
             step = sval;
             break;
         }
-        case 't':
-            ret = bdrv_parse_cache_mode(optarg, &flags, &writethrough);
-            if (ret < 0) {
-                error_report("Invalid cache mode");
-                ret = -1;
-                goto out;
-            }
-            break;
         case 'w':
             flags |= BDRV_O_RDWR;
             is_write = true;
             break;
-        case 'U':
-            force_share = true;
-            break;
         case OPTION_PATTERN:
         {
             unsigned long res;
@@ -4999,9 +5047,17 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_NO_DRAIN:
             drain_on_flush = false;
             break;
-        case OPTION_IMAGE_OPTS:
-            image_opts = true;
+        case 'U':
+            force_share = true;
             break;
+        case 'q':
+            quiet = true;
+            break;
+        case OPTION_OBJECT:
+            user_creatable_process_cmdline(optarg);
+            break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.50.1


