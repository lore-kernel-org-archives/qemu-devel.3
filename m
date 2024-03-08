Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4B2C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riZut-0006Cc-BV; Fri, 08 Mar 2024 08:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riZuj-0006Bq-EL
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:05:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riZuY-00055h-7y
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709903116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jqVMWKpeXwC4Ylciagl3B8Eo/ho05hURMDmohc/QMjM=;
 b=fumqM6/kSktQEoMYhZFyoM52O/r0x7N6IliBvDqirrpWbfEmZ9lRPIcHQRtfWvXy+hsGnX
 mRrKcizyEe+Pkt6rU3ws1XL8/NiQyALOWubdcA1oSjIKAV3nOlaS0mGcXptg1Q8ie+edW9
 4ARCWN+NGsXmjf7pTBKlLG/sBuBfXaY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-ICUD7BT6OmiRkxYOxnY3iQ-1; Fri, 08 Mar 2024 08:05:14 -0500
X-MC-Unique: ICUD7BT6OmiRkxYOxnY3iQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d3fb557a1cso6097141fa.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 05:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709903112; x=1710507912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqVMWKpeXwC4Ylciagl3B8Eo/ho05hURMDmohc/QMjM=;
 b=XzfX2oUvUGOQ1d9X0j8uUKMFCcosxMjR3bEd5RLQcm4kD9msRf7WVdT6qRWa6W+vCC
 1rTaY4TbM3e5FUWohGLoM1K1OYh7oMdO/Z6vmY1kulX5Y9WcPpjfnG7seSgRmouBImLe
 Tlz9Pkf3FLPymqYZI/qf6TH/E/6PyY3LngcCYpAt2l+je7andE3a3bo9DF5MR7sJgXm9
 H+07t2rjdAfc5DyLud8UNuo4uZYHyu8nZirYCGal6jyq4+85o2WVc/z5z3LpPj7t43kA
 bFUlu2/jlLpa62+zYIb09Mpis9lxCwZuQkyGQnGjpgg35kXmX7NDI4wXY2wytRqnDF3o
 NBgw==
X-Gm-Message-State: AOJu0YxCWqOQLNKgmj1jG+nfXTdnH4jXd7AW2If0PiiwoF4p+Eu4R2Kc
 vHCgZHI7rdiXLUy40KnXCac2OxRu3Sj6xT2PHkx13/nU2qUC2Sqx6sv32/NnC8J+QCPoJCnPl4N
 K6BJnclpOIgLzx/By0Hsfs+Gs32t9vTbN2GrL5eGWpxyx8d7l9uExsWlciu6uCdD3EJGJM+L6Od
 kv6DslzCG8MK1DA1i1wJzoNxVBpSHeVdllv8P/
X-Received: by 2002:a2e:3c0a:0:b0:2d2:d815:c894 with SMTP id
 j10-20020a2e3c0a000000b002d2d815c894mr3107625lja.51.1709903112260; 
 Fri, 08 Mar 2024 05:05:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExjCSFAcPOirjaGbcbKC3Yo1CYAmuB6b7PtsOPW/Rl4JC87ruAzPfJ+BMkIYabPA6KkOhp3A==
X-Received: by 2002:a2e:3c0a:0:b0:2d2:d815:c894 with SMTP id
 j10-20020a2e3c0a000000b002d2d815c894mr3107596lja.51.1709903111683; 
 Fri, 08 Mar 2024 05:05:11 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a05640243c800b00567fd12c7f8sm2390587edc.60.2024.03.08.05.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 05:05:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 1/2] run-coverity-scan: add --check-upload-only option
Date: Fri,  8 Mar 2024 14:05:06 +0100
Message-ID: <20240308130507.582097-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308130507.582097-1-pbonzini@redhat.com>
References: <20240308130507.582097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/run-coverity-scan | 59 ++++++++++++++++++-------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
index d56c9b66776..96d852aa362 100755
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
+    # with status 1 if the check failed (usually a bad token);
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


