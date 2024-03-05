Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2214FC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 19:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhaA7-0001lZ-Tp; Tue, 05 Mar 2024 14:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhaA6-0001lO-34
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:09:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhaA4-0002Bv-Bm
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709665751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WNBwNyP93UNETTCQt7HxqHOcuB/TSrwLC8yZ1GgpcbY=;
 b=SwCQia0wRLwf0P9xBguGSRZdBbTBX97GQjSO1M2YVwZqP2sIViEtEaxgIWXAjOgCwKczoS
 Ncke6B4QSM3Pxsozzsndh+RvyWEKvfS28DLfIIr+7cxcLdxxuQhGwYhNvqkjYJSJfW4D8M
 D/HVpyM45xAVj9sshsU7LN/ZZCIMb9k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-pQQPJwSmNGGsL-XZJQ1plw-1; Tue, 05 Mar 2024 14:09:10 -0500
X-MC-Unique: pQQPJwSmNGGsL-XZJQ1plw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a4533388b03so153277066b.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 11:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709665747; x=1710270547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WNBwNyP93UNETTCQt7HxqHOcuB/TSrwLC8yZ1GgpcbY=;
 b=wyEutdtcrA6qB/NejydKnlZ8CvHK3JhC0vw+xw9Vc06dC3ZPCq6wmMXimWyPEZ7yH5
 o4z6DEQLFUwrz6EM++FGTG9NYEORgBh7FfayuEvLzY1ilMh619lNTymHpstUnCpEYYuD
 222n9mPkkR2xnWdLNQD2X03BGHq17OzZootDTy3NUvtsA7vzBG95yC12k5RXC59Q6gkl
 nZPFm/NATa4ol49Z5T/RbQKtUWeJze0cEG8DyUFRALpIKmFO+mCGIogt2abHK7v7IxW4
 2/63+835tKlomiIhgJMAxr7WsDYTOLF8YLdtaoGfHPlC2DV/cEputTmJjlJtvhDcnfeQ
 up3g==
X-Gm-Message-State: AOJu0YyxXm4At7p7l8C5HjtoTIxm7qniVzaQkAKoDNYgDytCEKPzYCFB
 RYFLBDkldLMjiA/g+oR6EqWAYjnKBVaLO/9ZSC7Xu3t+9eDuhlT6BTiRqDooFk2S2MLLYvBxo0c
 p2PL2/vTrAdbopK1JOpomcvlDLAPBHtQUP2NBF8++Gq4bbiIjfV6YYOGekrLplOYT176EklK/GK
 ShFl8W28s80jq4sQRPcx4GQULju/WtuiIVWV+X
X-Received: by 2002:a17:906:29cd:b0:a45:b10a:9fe9 with SMTP id
 y13-20020a17090629cd00b00a45b10a9fe9mr861102eje.2.1709665747285; 
 Tue, 05 Mar 2024 11:09:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFGFL6uxVaA/dv+UkVyjfHJb3PJeUb7XnGRpkDqrj/ksiL0pLdIJ9gSM44Sgrs37ow7PT3Pg==
X-Received: by 2002:a17:906:29cd:b0:a45:b10a:9fe9 with SMTP id
 y13-20020a17090629cd00b00a45b10a9fe9mr861088eje.2.1709665746877; 
 Tue, 05 Mar 2024 11:09:06 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a17090611c400b00a458d85f9d9sm1515008eja.142.2024.03.05.11.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 11:09:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	berrange@redhat.com
Subject: [PATCH 1/2] run-coverity-scan: add --check-upload-only option
Date: Tue,  5 Mar 2024 20:09:01 +0100
Message-ID: <20240305190902.364753-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240305190902.364753-1-pbonzini@redhat.com>
References: <20240305190902.364753-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/run-coverity-scan | 51 ++++++++++++++++++-------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
index d56c9b66776..4bc991f70fd 100755
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
+upload_permitted() {
     # Check whether we can do an upload to the server; will exit the script
     # with status 1 if the check failed (usually a bad token);
     # will exit the script with status 0 if the check indicated that we
     # can't upload yet (ie we are at quota)
-    # Assumes that COVERITY_TOKEN, PROJNAME and DRYRUN have been initialized.
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


