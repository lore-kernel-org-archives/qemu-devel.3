Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602C5CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvymE-000120-3v; Tue, 09 Sep 2025 09:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvylx-0000qV-95
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvylp-0005Hq-HW
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757425946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3QODTbIvSVZeI8u/Ur5zEVlHPelZvpjyoUmh9COTQQ=;
 b=Cmk65Q8mX6M93jnbBVw6XPbkqc5V32n7ZzmJDAL/KtG6sy4td1o1+iPPyCUdZqstN0YHRo
 Iqj5Jy5phrzxgcLP3Bsgu4doyBGen619GSrc+BlIcMGeF1tjecwCdt7HKWE/P7W15P/Yos
 heyV7WmHJm0X1K4bVY7O1KLOkUUInkY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-O3_D-ntxPRKBJ2StNWOIeg-1; Tue,
 09 Sep 2025 09:52:25 -0400
X-MC-Unique: O3_D-ntxPRKBJ2StNWOIeg-1
X-Mimecast-MFC-AGG-ID: O3_D-ntxPRKBJ2StNWOIeg_1757425944
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C03F1956095; Tue,  9 Sep 2025 13:52:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A7761800447; Tue,  9 Sep 2025 13:52:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 15/23] gitlab: always include entire of meson-logs directory
Date: Tue,  9 Sep 2025 15:51:39 +0200
Message-ID: <20250909135147.612345-16-thuth@redhat.com>
In-Reply-To: <20250909135147.612345-1-thuth@redhat.com>
References: <20250909135147.612345-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

There are files besides testlog.txt that may be useful as published
CI artifacts.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250908190901.3571859-3-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml  | 4 ++--
 .gitlab-ci.d/buildtest.yml           | 2 +-
 .gitlab-ci.d/crossbuild-template.yml | 2 +-
 .gitlab-ci.d/windows.yml             | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 46722982149..4cc5b20790f 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -88,7 +88,7 @@
     when: always
     expire_in: 7 days
     paths:
-      - build/meson-logs/testlog.txt
+      - build/meson-logs
     reports:
       junit: build/meson-logs/testlog.junit.xml
 
@@ -104,7 +104,7 @@
     when: always
     expire_in: 7 days
     paths:
-      - build/meson-logs/testlog.txt
+      - build/meson-logs
       - build/tests/functional/*/*/*.log
     reports:
       junit: build/meson-logs/testlog.junit.xml
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index d888a600637..778289267f1 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -613,7 +613,7 @@ gcov:
     when: always
     expire_in: 2 days
     paths:
-      - build/meson-logs/testlog.txt
+      - build/meson-logs
     reports:
       junit: build/meson-logs/testlog.junit.xml
       coverage_report:
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index 303943f818f..7e70376cfcc 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -128,6 +128,6 @@
     when: always
     expire_in: 7 days
     paths:
-      - build/meson-logs/testlog.txt
+      - build/meson-logs
     reports:
       junit: build/meson-logs/testlog.junit.xml
diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index beac39e5bde..f14e9ca1341 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -24,7 +24,7 @@ msys2-64bit:
     name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
     expire_in: 7 days
     paths:
-      - build/meson-logs/testlog.txt
+      - build/meson-logs
     reports:
       junit: "build/meson-logs/testlog.junit.xml"
   before_script:
-- 
2.51.0


