Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050BFCD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXF3i-00008g-Kz; Wed, 10 Jun 2026 05:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXF3h-00008Y-Av
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 05:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXF3f-0006Ep-HB
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 05:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781083028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M6p6wolqqJjtqCCIkPWiUcVXhVbyi1g2eLV3swiHlYM=;
 b=QiVVivh0Oc2FmXrC0JVVDEuMmavH4P+2X/TcVKP8fEL7BISMeSeE3w4BbTc62K7Oge1ASr
 u1xISfDRzWMcXkNkgDivCRevbjP2GpPqwVT92TVMSZsdD5CSsCejlxPc+fVwuAjkwoSJFE
 P6UYV5Yk0mflHSZbEBYdh1d8loRXqkc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-UnEmCfxDObuMsO8xXP1CNQ-1; Wed,
 10 Jun 2026 05:17:05 -0400
X-MC-Unique: UnEmCfxDObuMsO8xXP1CNQ-1
X-Mimecast-MFC-AGG-ID: UnEmCfxDObuMsO8xXP1CNQ_1781083024
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 297851800A36; Wed, 10 Jun 2026 09:17:04 +0000 (UTC)
Received: from berrange.com (unknown [10.44.50.112])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D0E61800347; Wed, 10 Jun 2026 09:17:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] gitlab: disable macOS jobs in forks
Date: Wed, 10 Jun 2026 10:17:00 +0100
Message-ID: <20260610091700.2772973-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The GitLab macOS runners are only available in Premium and Ultimate
tier projects. This permits their use in QEMU upstream via the OSS
Program membership perk, but this does not extend to forks of QEMU.
The macOS jobs thus need to be disabled in forks, otherwise all
pipelines will immediately report a failure due to inability to
access a runner.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/base.yml              | 5 +++++
 .gitlab-ci.d/macos.yml             | 2 ++
 docs/devel/testing/ci-jobs.rst.inc | 7 +++++++
 3 files changed, 14 insertions(+)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 72eadc8073..714d2ed8a6 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -52,6 +52,11 @@ variables:
     - if: '$CI_PIPELINE_SOURCE == "schedule"'
       when: never
 
+    # macOS jobs can't run in forks until gitlab opens up runner availability
+    # to all tiers https://gitlab.com/groups/gitlab-org/-/work_items/8267
+    - if: '$QEMU_JOB_MACOS == "1" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
+      when: never
+
     # Publishing jobs should only run on the default branch in upstream
     - if: '$QEMU_JOB_PUBLISH == "1" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH != $CI_DEFAULT_BRANCH'
       when: never
diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index 8366b4ad56..84ad2492ca 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -36,6 +36,7 @@ aarch64-macos-15-build:
   extends: .macos_job_template
   image: macos-15-xcode-16
   variables:
+    QEMU_JOB_MACOS: 1
     NAME: macos-15
     PATH_EXTRA: /opt/homebrew/gettext/bin
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
@@ -52,6 +53,7 @@ aarch64-macos-26-build:
   extends: .macos_job_template
   image: macos-26-xcode-26
   variables:
+    QEMU_JOB_MACOS: 1
     NAME: macos-26
     DYLD_LIBRARY_PATH: /opt/homebrew/opt/expat/lib/
     PATH_EXTRA: /opt/homebrew/gettext/bin
diff --git a/docs/devel/testing/ci-jobs.rst.inc b/docs/devel/testing/ci-jobs.rst.inc
index d5b081978a..d747a7ad13 100644
--- a/docs/devel/testing/ci-jobs.rst.inc
+++ b/docs/devel/testing/ci-jobs.rst.inc
@@ -125,6 +125,13 @@ QEMU_JOB_FUNCTIONAL
 
 The job runs the functional test suite
 
+QEMU_JOB_MACOS
+~~~~~~~~~~~~~~
+
+The job requires access to the macOS shared runners, which are
+only available to Premium/Ultimate tiers. This includes OSS project
+members, but not forks.
+
 Contributor controlled runtime variables
 ----------------------------------------
 
-- 
2.54.0


