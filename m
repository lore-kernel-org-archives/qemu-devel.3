Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD262C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 18:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riehw-0007GJ-5n; Fri, 08 Mar 2024 13:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riehu-0007Fv-V9
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rieht-0005qU-9Y
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709921552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFcOcpwXgUreDcP7/fCdgESL2rGpCnlA8DYZygfuJgc=;
 b=dChZNZk4jl53ylN1aG2Y6xiB47yWD35hqn8wsl0K+jVGhab2KB7sD6WDJ4Myw9e499N8O5
 7lTNZ3qhln+KMCeI8xPxRi2U0yJO8kX1M8t1HE8U3lg1S2zAcoRlD98qcgzZ9jR3soMrPI
 xel0/8JHLMz+xPR7hcOom1au3uuJ1uA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-8IJbH3YpOvSnyNviJPUQcg-1; Fri, 08 Mar 2024 13:12:31 -0500
X-MC-Unique: 8IJbH3YpOvSnyNviJPUQcg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a45f6ae4f58so27935366b.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 10:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709921549; x=1710526349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hFcOcpwXgUreDcP7/fCdgESL2rGpCnlA8DYZygfuJgc=;
 b=v086NdkWh6r1/U8wK6H2ewtERMGy4euWNLTUNzh5HHX9IMN+0JNJHeYJSWHV6Q9bgu
 I+KeVMGA2TNEhXz4FqBuwkBjTdnOM7g8sKr5cpoiAXPV6QefyhFTd8lGb7tDJjPPZdvF
 0/W5KP3rgEIQiV1bttS155K79/AsVqfoFFAd3CFCp/1eeYHk2IFsTZxTK7Vlp8atTE+I
 iM7Bj7IZ5AuV6DQsVIpTwRvQxGiG5YEKLMI1vMID2FOeWOPTlgR0QSeFQzH9Cl4t5bSn
 OSQhkVdVMC7+vI2zBuFkAK26va2LAo245tPgJyQ/17s32jj1UzpnXZ+NMbUpB9IuZE1N
 nnDQ==
X-Gm-Message-State: AOJu0YzMPXoEXAuov2f2TOIeQIsiA93xoriAMSxjxCxYz5cFJmMUbPMr
 C+HCB9TasgKzOvZ2rMyaq0byuKF180ApYsttnxiJNZ7VpAnY/VHdvOG9xKpPddsTbp0jUzyDzKV
 KYPGTOvJIrv6AnHsTOFDoTP16dqjJgXh/3ww0Lf5h4NU2OKV4oI5B4Y6y945e7D+x/3wqwB9zYY
 ScXxBqfJ4FGpzNwaKB1JqEPfl9B4TIKICiukDl
X-Received: by 2002:a17:906:e002:b0:a45:b5a0:f3a with SMTP id
 cu2-20020a170906e00200b00a45b5a00f3amr5468332ejb.17.1709921549251; 
 Fri, 08 Mar 2024 10:12:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBnTN8k36SpZNmLJU4kr3iGyfQK+UPJux5qDSbHHb2RLUxUjFoscBgv5ssBV2edR18F+Xgjg==
X-Received: by 2002:a17:906:e002:b0:a45:b5a0:f3a with SMTP id
 cu2-20020a170906e00200b00a45b5a00f3amr5468316ejb.17.1709921548856; 
 Fri, 08 Mar 2024 10:12:28 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 qu21-20020a170907111500b00a45d17148a3sm42178ejb.13.2024.03.08.10.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 10:12:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 9/9] gitlab-ci: add manual job to run Coverity
Date: Fri,  8 Mar 2024 19:12:01 +0100
Message-ID: <20240308181202.617329-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308181202.617329-1-pbonzini@redhat.com>
References: <20240308181202.617329-1-pbonzini@redhat.com>
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

Add a job that can be run, either manually or on a schedule, to upload
a build to Coverity Scan.  The job uses the run-coverity-scan script
in multiple phases of check, download tools and upload, in order to
avoid both wasting time (skip everything if you are above the upload
quota) and avoid filling the log with the progress of downloading
the tools.

The job is intended to run on a scheduled pipeline run, and scheduled
runs will not get any other job.  It requires two variables to be in
GitLab CI, COVERITY_TOKEN and COVERITY_EMAIL.  Those are already set up
in qemu-project's configuration as protected and masked variables.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/base.yml      |  4 ++++
 .gitlab-ci.d/buildtest.yml | 37 +++++++++++++++++++++++++++++++++++++
 .gitlab-ci.d/opensbi.yml   |  4 ++++
 3 files changed, 45 insertions(+)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index ef173a34e63..2dd8a9b57cb 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -41,6 +41,10 @@ variables:
     - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_TAG'
       when: never
 
+    # Scheduled runs on mainline don't get pipelines except for the special Coverity job
+    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_PIPELINE_SOURCE == "schedule"'
+      when: never
+
     # Cirrus jobs can't run unless the creds / target repo are set
     - if: '$QEMU_JOB_CIRRUS && ($CIRRUS_GITHUB_REPO == null || $CIRRUS_API_TOKEN == null)'
       when: never
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 901265af95d..c7d92fc3018 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -729,3 +729,40 @@ pages:
       - public
   variables:
     QEMU_JOB_PUBLISH: 1
+
+coverity:
+  image: $CI_REGISTRY_IMAGE/qemu/fedora:$QEMU_CI_CONTAINER_TAG
+  stage: build
+  allow_failure: true
+  timeout: 3h
+  needs:
+    - job: amd64-fedora-container
+      optional: true
+  before_script:
+    - dnf install -y curl wget
+  script:
+    # would be nice to cancel the job if over quota (https://gitlab.com/gitlab-org/gitlab/-/issues/256089)
+    # for example:
+    #   curl --request POST --header "PRIVATE-TOKEN: $CI_JOB_TOKEN" "${CI_SERVER_URL}/api/v4/projects/${CI_PROJECT_ID}/jobs/${CI_JOB_ID}/cancel
+    - 'scripts/coverity-scan/run-coverity-scan --check-upload-only || { exitcode=$?; if test $exitcode = 1; then
+        exit 0;
+      else
+        exit $exitcode;
+      fi; };
+      scripts/coverity-scan/run-coverity-scan --update-tools-only > update-tools.log 2>&1 || { cat update-tools.log; exit 1; };
+      scripts/coverity-scan/run-coverity-scan --no-update-tools'
+  rules:
+    - if: '$COVERITY_TOKEN == null'
+      when: never
+    - if: '$COVERITY_EMAIL == null'
+      when: never
+    # Never included on upstream pipelines, except for schedules
+    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_PIPELINE_SOURCE == "schedule"'
+      when: on_success
+    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM'
+      when: never
+    # Forks don't get any pipeline unless QEMU_CI=1 or QEMU_CI=2 is set
+    - if: '$QEMU_CI != "1" && $QEMU_CI != "2"'
+      when: never
+    # Always manual on forks even if $QEMU_CI == "2"
+    - when: manual
diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index fd293e6c317..42f137d624e 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -24,6 +24,10 @@
     - if: '$QEMU_CI == "1" && $CI_PROJECT_NAMESPACE != "qemu-project" && $CI_COMMIT_MESSAGE =~ /opensbi/i'
       when: manual
 
+    # Scheduled runs on mainline don't get pipelines except for the special Coverity job
+    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_PIPELINE_SOURCE == "schedule"'
+      when: never
+
     # Run if any files affecting the build output are touched
     - changes:
         - .gitlab-ci.d/opensbi.yml
-- 
2.43.2


