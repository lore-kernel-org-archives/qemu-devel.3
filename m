Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65138C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 18:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riehu-0007Fd-B3; Fri, 08 Mar 2024 13:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riehs-0007Ds-SG
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riehr-0005qF-1J
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709921550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wm7tvlRtPpXlePloTVjRajx+JpxbgNJey9a3Qa3vQcU=;
 b=dhxu0xCN71SuqofWqGWggFIyXm8mDsKjmBAMwJO5AKchGLqd2meJME6AXZZ6Lb+Q6TZNch
 9Rgk6ub/TndScO5egb0SXJMlz3QGNhR1zeMdsopbILr+qlqLD5qRPcsj1iwOdPJ+wJZJZa
 j/oqmc8BYcegIis/YV7zunHLs5uMQiY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-1CleVlx5OgytrLIznhq_gA-1; Fri, 08 Mar 2024 13:12:29 -0500
X-MC-Unique: 1CleVlx5OgytrLIznhq_gA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a45ac612a4dso363314166b.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 10:12:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709921545; x=1710526345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wm7tvlRtPpXlePloTVjRajx+JpxbgNJey9a3Qa3vQcU=;
 b=tOLmAvKc+hV+pXaWqNHGEnPIdv5ycWGxwlL4TuSPfOVoHj1hyyXoJ5APbk4vPb3DrC
 a1Dr8FrivppOtcFxtRnm52TGZOPog9rniWnuUN7gWWfbvAtTI7EBZ9iWTVob+6mFYWJb
 qyqpg/jS2HXjK9f2SELZl5vIqLj158l2E7G9eo7vtfjpONJDvkvqNktoh124ECr4jcoJ
 i+v4Hgqje2NxHe7lV1DNzTFhKWjA7dUlKosj9GcETLA+EHnc+JRXM/DxIcme4Oh/JAYH
 m18elgQILS5De536+qcr/BaAk3556izsDV2OnZyEhYi9Xvx6v+gNWFG7YygqaUEcVaT2
 YnpA==
X-Gm-Message-State: AOJu0YyU7/4HR3g0xu9AgpLZ1xWesWvgwNk8lS/Ei0jfDy9Ld+P1pPNT
 c9k5iiQ2DZECrF5nrPSF5Dl83R9gJD2+YnKC49RHC2xaoPGAKT0nqBRfdqWoswTzn7SwT3pD9CF
 fVe8VzBFyHXrIxmPWzlNKYjBrouzr0JFuCwy/+SqWoUcRyuGyZatf2BdSKJ/8J8LUXTnXUwCnVd
 2DeCzEzCHYV3mESWaG1pFyroWH+deKufbsegSI
X-Received: by 2002:a17:906:68cd:b0:a45:af32:5e04 with SMTP id
 y13-20020a17090668cd00b00a45af325e04mr932649ejr.30.1709921545333; 
 Fri, 08 Mar 2024 10:12:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoKUVenB5vA3VAfgooEXYtn6mNCEfmcVmEISv/gHiJ7o8U/9ZpLQtOH+7LnWWZJhZYbU+xug==
X-Received: by 2002:a17:906:68cd:b0:a45:af32:5e04 with SMTP id
 y13-20020a17090668cd00b00a45af325e04mr932636ejr.30.1709921544992; 
 Fri, 08 Mar 2024 10:12:24 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a1709061cca00b00a3f28bf94f8sm33677ejh.199.2024.03.08.10.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 10:12:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 8/9] run-coverity-scan: add --check-upload-only option
Date: Fri,  8 Mar 2024 19:12:00 +0100
Message-ID: <20240308181202.617329-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308181202.617329-1-pbonzini@redhat.com>
References: <20240308181202.617329-1-pbonzini@redhat.com>
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


