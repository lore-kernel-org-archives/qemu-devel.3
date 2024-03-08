Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDD3C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribeY-0003hT-50; Fri, 08 Mar 2024 09:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribeV-0003go-Uu
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribeT-0005ip-5f
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709909808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGNZVuIhxFM1n3kaB7ppDpIcYT9wBlyCHV+ALvaf7Sc=;
 b=iJDO+L+ROICvn4AoZbr7cLLNqkEKPgQWKDb2dgap+Zrwbw5aycauvr9u1bsK3Ef1VYDsqS
 XRxvXtSQDTiuG03LoimMDzUpFbxpJXkIaBLYiSi+eOHO4Zwgk+ajkmnLKW437ak/Y+7tOH
 +fj72QhDHL0DV73fCwZTqjyLbed4lgs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-Hv6xXkshMXe0lItz7DAYzg-1; Fri, 08 Mar 2024 09:56:47 -0500
X-MC-Unique: Hv6xXkshMXe0lItz7DAYzg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3fcf5b93faso119477366b.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:56:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709909786; x=1710514586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGNZVuIhxFM1n3kaB7ppDpIcYT9wBlyCHV+ALvaf7Sc=;
 b=YZoSgck5vPF25RstolD6hsVUc0ZVJQAV2uS/5yFh0MVGjQzp8RLS+4MiHNE9dBIdNA
 +nN4rFP0mdvOmKTH0781Lclx1t0mmn6o2QVqwOJCQKYYm8Snpcd/YGne9XJvKe1mIWCY
 ZSAbqAI7JFwYqLhB9XSl5GkgsOlJ09+33GwDmxqa6dS7/cs1kV2UAk078cTkDBemtLY2
 kG1WY6VQpbRSUX+RHKVRtwQ0kBsbFxMtPPjI61s0elLKKnrjQtF3F3MT063Be6eflbRz
 LGmT8CIdu9nNk2ZIgGfNdsotcis+476LyXu/4f7tS9H4AkOE4KdK+W03GViuawbUqew8
 dlIw==
X-Gm-Message-State: AOJu0YwTtbTXo6pqIm+hSq7AdFwgxQ1vUoAGL64JJhZIZkjrIAya/p1A
 L9Ckc98BtZNFVNSD6YmZNME2Ff/Zu2RSUC5MvpLU4hN89X83u2UgIu/db++kaOiCRfHIMuzswDx
 cSzXe+lI9wzq0bOFh1zveGDtyBjHJ17O/R/FAHmmeSUtRywdNiHxVIpk6ScqJ8k1R0PJI30dhfo
 ERsqwUxu8LvjRFgBmAzxisUNDgatUStgedk6db
X-Received: by 2002:a17:906:ce29:b0:a44:2218:4817 with SMTP id
 sd9-20020a170906ce2900b00a4422184817mr12867498ejb.39.1709909785905; 
 Fri, 08 Mar 2024 06:56:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxbwu78hnXKyZ3CPhiWbIRgm2JjGOw4Obgrb5PmmIfprqDrtIvLc6l7jJzmBCpnlI9Xl0gfA==
X-Received: by 2002:a17:906:ce29:b0:a44:2218:4817 with SMTP id
 sd9-20020a170906ce2900b00a4422184817mr12867489ejb.39.1709909785545; 
 Fri, 08 Mar 2024 06:56:25 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 sa24-20020a1709076d1800b00a440019ac45sm9334410ejc.69.2024.03.08.06.56.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 06:56:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/12] gitlab-ci: add manual job to run Coverity
Date: Fri,  8 Mar 2024 15:55:54 +0100
Message-ID: <20240308145554.599614-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308145554.599614-1-pbonzini@redhat.com>
References: <20240308145554.599614-1-pbonzini@redhat.com>
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


