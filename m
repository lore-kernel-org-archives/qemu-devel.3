Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CF9C3600E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 20:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txAT4-0000ee-DH; Tue, 25 Mar 2025 16:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txASj-0000XH-4x
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 16:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txASd-0002jY-Bu
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 16:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742932878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fv7s8G624YmEy1VbJqOHq/CAZDI22pfZqn0fmq+hM7I=;
 b=ecvvQtCpaCyHpljAtvdXB3lq4UNEvRrDXdlMqw29dOkIWzSh3vSHys/TjLDDkC0SHLB1MT
 0qIutBsiDyMyF02+65g/FwBZKK9yL5V6tDCjAy3OcoMKH5wTMvLMP9GQXGe6Kmm+G42RjY
 uy8QpR0BnJYZG+c/jrnNPK7TophaU90=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-k5xfUF_aOnmpkVdXGQuo3g-1; Tue,
 25 Mar 2025 16:01:14 -0400
X-MC-Unique: k5xfUF_aOnmpkVdXGQuo3g-1
X-Mimecast-MFC-AGG-ID: k5xfUF_aOnmpkVdXGQuo3g_1742932873
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A26F6196D2D2; Tue, 25 Mar 2025 20:01:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.142])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F1AD180175F; Tue, 25 Mar 2025 20:01:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 14/15] gitlab-ci: Update QEMU_JOB_AVOCADO and
 QEMU_CI_AVOCADO_TESTING
Date: Tue, 25 Mar 2025 21:00:22 +0100
Message-ID: <20250325200026.344006-15-thuth@redhat.com>
In-Reply-To: <20250325200026.344006-1-thuth@redhat.com>
References: <20250325200026.344006-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Since we don't run the Avocado jobs in the CI anymore, rename
these variables to QEMU_JOB_FUNCTIONAL and QEMU_CI_FUNCTIONAL_TESTING.

Also, there was a mismatch between the documentation and the
implementation of QEMU_CI_AVOCADO_TESTING: While the documentation
said that you had to "Set this variable to have the tests using the
Avocado framework run automatically", you indeed needed to set it
to make the pipelines appear in your dashboard - but they were never
run automatically in forks and had to be triggered manually. Let's
improve this now: No need to hide these pipelines from the users
by default anymore (the functional tests should be stable enough
nowadays), and rather allow the users to run the pipelines auto-
matically with this switch now instead, as was documented.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing/ci-jobs.rst.inc  | 19 +++++++++----------
 .gitlab-ci.d/base.yml               |  8 ++------
 .gitlab-ci.d/buildtest-template.yml |  2 +-
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/docs/devel/testing/ci-jobs.rst.inc b/docs/devel/testing/ci-jobs.rst.inc
index 3756bbe3554..4f4c96dd883 100644
--- a/docs/devel/testing/ci-jobs.rst.inc
+++ b/docs/devel/testing/ci-jobs.rst.inc
@@ -126,10 +126,10 @@ QEMU_JOB_PUBLISH
 The job is for publishing content after a branch has been
 merged into the upstream default branch.
 
-QEMU_JOB_AVOCADO
-~~~~~~~~~~~~~~~~
+QEMU_JOB_FUNCTIONAL
+~~~~~~~~~~~~~~~~~~~
 
-The job runs the Avocado integration test suite
+The job runs the functional test suite
 
 Contributor controlled runtime variables
 ----------------------------------------
@@ -149,13 +149,12 @@ the jobs to be manually started from the UI
 Set this variable to 2 to create the pipelines and run all
 the jobs immediately, as was the historical behaviour
 
-QEMU_CI_AVOCADO_TESTING
-~~~~~~~~~~~~~~~~~~~~~~~
-By default, tests using the Avocado framework are not run automatically in
-the pipelines (because multiple artifacts have to be downloaded, and if
-these artifacts are not already cached, downloading them make the jobs
-reach the timeout limit). Set this variable to have the tests using the
-Avocado framework run automatically.
+QEMU_CI_FUNCTIONAL_TESTING
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+By default, tests using the functional framework are not run automatically
+in the pipelines (because multiple artifacts have to be downloaded, which
+might cause a lot of network traffic). Set this variable to have the tests
+using the functional framework run automatically.
 
 Other misc variables
 --------------------
diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 25b88aaa06a..172028e1731 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -69,10 +69,6 @@ variables:
     - if: '$QEMU_CI != "1" && $QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
       when: never
 
-    # Avocado jobs don't run in forks unless $QEMU_CI_AVOCADO_TESTING is set
-    - if: '$QEMU_JOB_AVOCADO && $QEMU_CI_AVOCADO_TESTING != "1" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
-      when: never
-
 
     #############################################################
     # Stage 2: fine tune execution of jobs in specific scenarios
@@ -101,8 +97,8 @@ variables:
       when: manual
       allow_failure: true
 
-    # Avocado jobs can be manually start in forks if $QEMU_CI_AVOCADO_TESTING is unset
-    - if: '$QEMU_JOB_AVOCADO && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
+    # Functional jobs can be manually started in forks
+    - if: '$QEMU_JOB_FUNCTIONAL && $QEMU_CI_FUNCTIONAL_TESTING != "1" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
       when: manual
       allow_failure: true
 
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 13fa4f4a4fc..d4f145fdb58 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -114,4 +114,4 @@
     - cd build
     - du -chs ${CI_PROJECT_DIR}/*-cache
   variables:
-    QEMU_JOB_AVOCADO: 1
+    QEMU_JOB_FUNCTIONAL: 1
-- 
2.49.0


