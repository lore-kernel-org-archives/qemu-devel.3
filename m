Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C399DC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribeU-0003gN-NC; Fri, 08 Mar 2024 09:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribeA-0003Ly-2m
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribe8-0005bR-8r
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709909786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wm7tvlRtPpXlePloTVjRajx+JpxbgNJey9a3Qa3vQcU=;
 b=GRPDYqyl5OO8QURbZu/p7cxJOS0eDgujp/8gDk7iiG1n3RjfNzv/dCLjLAm1ekZtemwh8v
 iJLaVlHDS0pE3SoG3+C4vhNhxGer6C/XG54L8cUBtC3AleBn6OmsM7u5rqVJoZJH1YaS63
 xbek1PVMI0yWX3Bdc4CjRrS64Q0qkH4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-JewHBbGqOxqtRI4qrYDZXw-1; Fri, 08 Mar 2024 09:56:24 -0500
X-MC-Unique: JewHBbGqOxqtRI4qrYDZXw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d2ecf61dd7so15092481fa.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709909782; x=1710514582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wm7tvlRtPpXlePloTVjRajx+JpxbgNJey9a3Qa3vQcU=;
 b=S5xHdAj3diAZx67P/vj610ll6QQunk+RQ4N/QM13u0NU8c95LX1uJw+8GxdWCzb1Y0
 rkCbXm7mHvlAY4ure0Fh8IEsK1kNkNwNRpNF6T8/4sHQH3iUyjI1bIJ3HPBx+CVSKo7a
 jijR+1ufxeIKt6gPs6pItXf8RdQIeEJTs0lDi+GumEjNSfqlxH1RAdwmv3lPGAfW5u4P
 YGwfFhl1Ssvgc8OX5PARqaQvVUv98XjVSCE7eCFz+XbUSp4FwZAx+qr0cMa0aAoylRSi
 e2HdvWVZVxW1rlc/Zr+Qs4pbEGRbcSdfQwzRA5QQQRrxCPZ3yBz5EFpXfyWjWGuj+hHX
 hjsw==
X-Gm-Message-State: AOJu0YxwhWhus60qhkSrftNx6NS1gDuw3zOWvCo/vIYXn44arvgQfqp3
 Z/0+h3Ms8CwovLa3LT6Z1bZ8lu0HEDvt7fwKBWoUoquQguY1aGu6j9jIR9ojQAl745vMJ1W+IIF
 rTD9vn2welF7DnYrBlIIooi33lVs1COeKXB6hY3iu7/UYiTWHQw+aHIsiRTauwLSTT/BI7yqoGa
 ybudjT9yjRSLxpxfCOb0tjZYssH8BCiyPJDSuF
X-Received: by 2002:a2e:98d8:0:b0:2d2:6193:6d53 with SMTP id
 s24-20020a2e98d8000000b002d261936d53mr3514922ljj.13.1709909782712; 
 Fri, 08 Mar 2024 06:56:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwM6VxHqNi+nfJ6KWr6+b5WwKDyp2mvPKzxeZsrTFBUE/LTYcHSNJj/Pz0TyBhqY8GlPKGlQ==
X-Received: by 2002:a2e:98d8:0:b0:2d2:6193:6d53 with SMTP id
 s24-20020a2e98d8000000b002d261936d53mr3514908ljj.13.1709909782362; 
 Fri, 08 Mar 2024 06:56:22 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 a11-20020a1709064a4b00b00a44a04aa3cfsm7968176ejv.225.2024.03.08.06.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 06:56:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 11/12] run-coverity-scan: add --check-upload-only option
Date: Fri,  8 Mar 2024 15:55:53 +0100
Message-ID: <20240308145554.599614-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308145554.599614-1-pbonzini@redhat.com>
References: <20240308145554.599614-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add an option to check if upload is permitted without actually
attempting a build.  This can be useful to add a third outcome
beyond success and failure---namely, a CI job can self-cancel
if the uploading quota has been reached.

There is a small change here in that a failure to do the upload
check changes the exit code from 1 to 99.  99 was chosen because
it is what Autotools and Meson use to represent a problem in the
setup (as opposed to a failure in the test).

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/run-coverity-scan | 59 ++++++++++++++++++-------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
index d56c9b66776..43cf770f5e3 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -28,6 +28,7 @@
 # project settings, if you have maintainer access there.
 
 # Command line options:
+#   --check-upload-only : return success if upload is possible
 #   --dry-run : run the tools, but don't actually do the upload
 #   --docker : create and work inside a container
 #   --docker-engine : specify the container engine to use (docker/podman/auto);
@@ -57,18 +58,18 @@
 # putting it in a file and using --tokenfile. Everything else has
 # a reasonable default if this is run from a git tree.
 
-check_upload_permissions() {
-    # Check whether we can do an upload to the server; will exit the script
-    # with status 1 if the check failed (usually a bad token);
-    # will exit the script with status 0 if the check indicated that we
-    # can't upload yet (ie we are at quota)
-    # Assumes that COVERITY_TOKEN, PROJNAME and DRYRUN have been initialized.
+upload_permitted() {
+    # Check whether we can do an upload to the server; will exit *the script*
+    # with status 99 if the check failed (usually a bad token);
+    # will return from the function with status 1 if the check indicated
+    # that we can't upload yet (ie we are at quota)
+    # Assumes that COVERITY_TOKEN and PROJNAME have been initialized.
 
     echo "Checking upload permissions..."
 
     if ! up_perm="$(wget https://scan.coverity.com/api/upload_permitted --post-data "token=$COVERITY_TOKEN&project=$PROJNAME" -q -O -)"; then
         echo "Coverity Scan API access denied: bad token?"
-        exit 1
+        exit 99
     fi
 
     # Really up_perm is a JSON response with either
@@ -76,25 +77,40 @@ check_upload_permissions() {
     # We do some hacky string parsing instead of properly parsing it.
     case "$up_perm" in
         *upload_permitted*true*)
-            echo "Coverity Scan: upload permitted"
+            return 0
             ;;
         *next_upload_permitted_at*)
-            if [ "$DRYRUN" = yes ]; then
-                echo "Coverity Scan: upload quota reached, continuing dry run"
-            else
-                echo "Coverity Scan: upload quota reached; stopping here"
-                # Exit success as this isn't a build error.
-                exit 0
-            fi
+            return 1
             ;;
         *)
             echo "Coverity Scan upload check: unexpected result $up_perm"
-            exit 1
+            exit 99
             ;;
     esac
 }
 
 
+check_upload_permissions() {
+    # Check whether we can do an upload to the server; will exit the script
+    # with status 99 if the check failed (usually a bad token);
+    # will exit the script with status 0 if the check indicated that we
+    # can't upload yet (ie we are at quota)
+    # Assumes that COVERITY_TOKEN, PROJNAME and DRYRUN have been initialized.
+
+    if upload_permitted; then
+        echo "Coverity Scan: upload permitted"
+    else
+        if [ "$DRYRUN" = yes ]; then
+            echo "Coverity Scan: upload quota reached, continuing dry run"
+        else
+            echo "Coverity Scan: upload quota reached; stopping here"
+            # Exit success as this isn't a build error.
+            exit 0
+        fi
+    fi
+}
+
+
 build_docker_image() {
     # build docker container including the coverity-scan tools
     echo "Building docker container..."
@@ -152,9 +168,14 @@ update_coverity_tools () {
 DRYRUN=no
 UPDATE=yes
 DOCKER=no
+PROJNAME=QEMU
 
 while [ "$#" -ge 1 ]; do
     case "$1" in
+        --check-upload-only)
+            shift
+            DRYRUN=check
+            ;;
         --dry-run)
             shift
             DRYRUN=yes
@@ -251,6 +272,11 @@ if [ -z "$COVERITY_TOKEN" ]; then
     exit 1
 fi
 
+if [ "$DRYRUN" = check ]; then
+    upload_permitted
+    exit $?
+fi
+
 if [ -z "$COVERITY_BUILD_CMD" ]; then
     NPROC=$(nproc)
     COVERITY_BUILD_CMD="make -j$NPROC"
@@ -266,7 +292,6 @@ if [ -z "$SRCDIR" ]; then
     SRCDIR="$PWD"
 fi
 
-PROJNAME=QEMU
 TARBALL=cov-int.tar.xz
 
 if [ "$UPDATE" = only ]; then
-- 
2.43.2


