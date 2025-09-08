Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EF2CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 19:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvhFA-0004xz-M8; Mon, 08 Sep 2025 15:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvhF8-0004wT-D4
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 15:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvhEx-0000To-28
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 15:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757358554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+Im5N2Dto7A9aHsvKU9/Rj1gPYGpA2mGRAysL7LKwM=;
 b=J2nUgtMdi+2Ev4pYC7NDCR4WeqVbq10R07JP5qEfWtuDSwzirjFXXlJzoBToD6e6AxE6yD
 yDxuPo60TbamsM4NhmXl198/U7+tTY0PHCXfeQY8IFUqrq2SlC+9CSmRxz63t8plFlhNbL
 kxkba6et1Xm9LGaFhA9GeSlBDRPKg0U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-cM_v-Yx1MDCiGzsoHdC_yg-1; Mon,
 08 Sep 2025 15:09:12 -0400
X-MC-Unique: cM_v-Yx1MDCiGzsoHdC_yg-1
X-Mimecast-MFC-AGG-ID: cM_v-Yx1MDCiGzsoHdC_yg_1757358550
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3B951955F2A; Mon,  8 Sep 2025 19:09:10 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6217B19560A2; Mon,  8 Sep 2025 19:09:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/4] gitlab: always include entire of meson-logs directory
Date: Mon,  8 Sep 2025 20:08:59 +0100
Message-ID: <20250908190901.3571859-3-berrange@redhat.com>
In-Reply-To: <20250908190901.3571859-1-berrange@redhat.com>
References: <20250908190901.3571859-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

There are files besides testlog.txt that may be useful as published
CI artifacts.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml  | 4 ++--
 .gitlab-ci.d/buildtest.yml           | 2 +-
 .gitlab-ci.d/crossbuild-template.yml | 2 +-
 .gitlab-ci.d/windows.yml             | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 4672298214..4cc5b20790 100644
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
index d888a60063..778289267f 100644
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
index 303943f818..7e70376cfc 100644
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
index beac39e5bd..f14e9ca134 100644
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
2.50.1


