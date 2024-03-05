Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74673C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 19:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhaAE-0001mM-UZ; Tue, 05 Mar 2024 14:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhaAD-0001lx-IL
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:09:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhaAB-0002CH-T1
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709665759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tAn3BPw9Rj/HBNoW+GN/JnNR0QESXgEweD9Y1fNZnNA=;
 b=JmFY92SLXZkZ06jm0qohT/FIreN5zfaLM7HViszdBVrEOubEcQvbMWYwuVttNEuId9wO5T
 Iin6n3tso6+pkBIZa9eAafENnIlfonQeaXgw3Y6a6IGQWPXtN0qeSi1jSvySQH39A2xNnP
 b6izE08dB64WrPEOXOPLh7tfNjFdWGM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-k6Oo7C5OPRCfDuOkArxl4Q-1; Tue, 05 Mar 2024 14:09:15 -0500
X-MC-Unique: k6Oo7C5OPRCfDuOkArxl4Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-51337da375dso3612780e87.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 11:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709665750; x=1710270550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tAn3BPw9Rj/HBNoW+GN/JnNR0QESXgEweD9Y1fNZnNA=;
 b=tpyS8tbhsgpNaVCHgzmeoNA1fiw7QV9+QZqoyu+WsZomHytMOEiCGf+3K2ekcH99Vj
 y4s1Pm2H7G/Rc6ZLTEhsomM6QdFIpuJqyyEJkcLUa5opsH1S9IcZvE9bZyOZ56u5TN54
 /c0HE9PuFryXOJSQj6SdJ5iQQ6vDIOhhMhJV0jJPrET1KH/UmKchZLQlYmuHRHfkjm6F
 uSrKuobB9lrBTkSaPc9nRbdfeuBUDnL9Yioc3/PFev/ONF54fOJ73RMT6SP4sCRNLRVL
 oCCjqXAZwY+tUKB/oxK6AZjRwhKzlXkKOFZvOiYYrt0I1OCFSvug2SWGdThBRU8hDxg0
 OgCg==
X-Gm-Message-State: AOJu0YxroEbCON1s6xZUE3V2pTqKX41SPDoBi5/pIgCr1OyBJqn9h1rD
 qsYHAqOmSiuxySfUWYru2zcyhyRajlOGEwayaS+gpfcLpVhrQtoYyqhPbgP8W4gaHbsXZPRxXBr
 ZWI2HgmJLL5LAGAIsdBcFiDXAScw+mwek/8Ta/Byq9sySAlih00Od55gHi1tZ0jyvfdThJkumWk
 kNGQRmDsF1g6Q/bPJeiQLsz/O5qCmaKccn6VdF
X-Received: by 2002:a05:6512:4db:b0:513:26e7:440c with SMTP id
 w27-20020a05651204db00b0051326e7440cmr1970179lfq.61.1709665750687; 
 Tue, 05 Mar 2024 11:09:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6I+sSTq3iLMaIAU45h5vw+RAc7+Flqqnj7ZyBAC9MPWEF1AIJQxadCh1TaELbDrt4xcR4iw==
X-Received: by 2002:a05:6512:4db:b0:513:26e7:440c with SMTP id
 w27-20020a05651204db00b0051326e7440cmr1970162lfq.61.1709665750227; 
 Tue, 05 Mar 2024 11:09:10 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 kw11-20020a170907770b00b00a43f170ad9asm6270079ejc.152.2024.03.05.11.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 11:09:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	berrange@redhat.com
Subject: [PATCH 2/2] gitlab-ci: add manual job to run Coverity
Date: Tue,  5 Mar 2024 20:09:02 +0100
Message-ID: <20240305190902.364753-3-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
RFC->v1:
- disable opensbi job in scheduled pipelines
- fix exit codes by using {} compound statements instead of () subshells
- do not limit to master branch since anyway we have only one schedule
  (i.e. make it the problem of whoever creates a second schedule's)

 .gitlab-ci.d/base.yml      |  4 ++++
 .gitlab-ci.d/buildtest.yml | 38 ++++++++++++++++++++++++++++++++++++++
 .gitlab-ci.d/opensbi.yml   |  4 ++++
 3 files changed, 46 insertions(+)

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
index 901265af95d..7832c7ff3a8 100644
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


