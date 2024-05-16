Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A04C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 17:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7eWW-0006E3-Ap; Thu, 16 May 2024 13:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1s7eWU-0006Dv-BR
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1s7eWS-0005Ao-Hx
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715879042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+nQAVrOJxNP42VoG6IKoq8gVTV0PH5iDHxJe1gtiuo8=;
 b=GdgLv64onikP5Uz3KoAa4lS6Eqrx1zJFf6cmzB1aw2lC1vWRJxlUNe58/wVSkhXoNmjRcC
 4iwhDHN/pJGK0o+G1vN7A3JIrE+R4/bQnmglKJtRXcN7ryLSLsRgitfOsKpYyXBFFqlfsl
 G4GYSUnl1MfrXAdTg+tyMUKSZFacFro=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-PszJ0psYMIyHsjCBv1erWw-1; Thu, 16 May 2024 13:02:15 -0400
X-MC-Unique: PszJ0psYMIyHsjCBv1erWw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a15390ceceso104963506d6.2
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 10:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715878934; x=1716483734;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+nQAVrOJxNP42VoG6IKoq8gVTV0PH5iDHxJe1gtiuo8=;
 b=Igkmt6NTgjnfmdUSPkTl9Y4KY7coODqGJdtxyKvG36koJJpZNx0LDMf8//M3zaN7LY
 iOKQDaTbywmxYekjANUp6glqeJonpHjHVdz/FTun9TIFM4ZVz5OFvM28akqdeLUWRtCe
 EvVFfauNj6ESCsm8Db1b7STN03fOiaD2/S3QpNfC99tZ+3tt+/AsSE3x08KLE/HNlbvR
 EeFxmJndrbPRyyAq6PouBW7y+ccuqfNl9W1Q3ar14qhinxMfwJ0NzggypfYls1vk6y4/
 HWHv+EcIqWbtuzyAEBZgX88/rWv9aFsFIS7U7mh9ySSUEYbhAvStkeVhCF7tGylurKcR
 DY5g==
X-Gm-Message-State: AOJu0YxnRvX2j+O5ZZOLNttARZ+a4myd2+MgdXo71msfSBWUAGR6wCIs
 Z9tGFNuk1B5YYhg0fCJJ1NBvZ+P7Tm6P/LN+kei4aVBaEP5PRCbFqifiT0OPYm3n2hQlKFP24DX
 Kz3Yx0mbCQmTN3kjdJbRqVBRT+RRqxmqtwlz09miNpqiizN5Ft0G9vZSvJ+KtBNJA39zCg1qPCo
 bVJbvU5yhhGwfRcZGyqUcLv1OlSnCKjgIVqCp6
X-Received: by 2002:a05:6214:5502:b0:6a3:5e6b:1b85 with SMTP id
 6a1803df08f44-6a35e6b1d4cmr30299176d6.57.1715878934494; 
 Thu, 16 May 2024 10:02:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBeIPLw3HXhY6geg22uXEuweld+qXbe2+gDQQxoGmPEdgf+ALzON+Fea6aSt8yTYagNMzP4w==
X-Received: by 2002:a05:6214:5502:b0:6a3:5e6b:1b85 with SMTP id
 6a1803df08f44-6a35e6b1d4cmr30298786d6.57.1715878934038; 
 Thu, 16 May 2024 10:02:14 -0700 (PDT)
Received: from toolbox.redhat.com ([2001:b07:ad4:d988:9d0:f1f0:af07:9889])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f194e2dsm77703746d6.70.2024.05.16.10.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 10:02:13 -0700 (PDT)
From: Camilla Conte <cconte@redhat.com>
To: qemu-devel@nongnu.org
Cc: Camilla Conte <cconte@redhat.com>, berrange@redhat.com,
 richard.henderson@linaro.org, alex.bennee@linaro.org
Subject: [PATCH] gitlab-ci: Replace Docker with Kaniko
Date: Thu, 16 May 2024 17:52:43 +0100
Message-ID: <20240516165410.28800-3-cconte@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cconte@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Enables caching from the qemu-project repository.

Uses a dedicated "$NAME-cache" tag for caching, to address limitations.
See issue "when using --cache=true, kaniko fail to push cache layer [...]":
https://github.com/GoogleContainerTools/kaniko/issues/1459

Does not specify a context since no Dockerfile is using COPY or ADD instructions.

Does not enable reproducible builds as
that results in builds failing with an out of memory error.
See issue "Using --reproducible loads entire image into memory":
https://github.com/GoogleContainerTools/kaniko/issues/862

Previous attempts, for the records:
  - Alex Bennée: https://lore.kernel.org/qemu-devel/20230330101141.30199-12-alex.bennee@linaro.org/
  - Camilla Conte (me): https://lore.kernel.org/qemu-devel/20230531150824.32349-6-cconte@redhat.com/

Signed-off-by: Camilla Conte <cconte@redhat.com>
---
 .gitlab-ci.d/container-template.yml | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index 4eec72f383..066f253dd5 100644
--- a/.gitlab-ci.d/container-template.yml
+++ b/.gitlab-ci.d/container-template.yml
@@ -1,21 +1,18 @@
 .container_job_template:
   extends: .base_job_template
-  image: docker:latest
   stage: containers
-  services:
-    - docker:dind
+  image:
+    name: gcr.io/kaniko-project/executor:debug
+    entrypoint: [""]
+  variables:
+    DOCKERFILE: "$CI_PROJECT_DIR/tests/docker/dockerfiles/$NAME.docker"
+    CACHE_REPO: "$CI_REGISTRY/qemu-project/qemu/qemu/$NAME-cache"
   before_script:
     - export TAG="$CI_REGISTRY_IMAGE/qemu/$NAME:$QEMU_CI_CONTAINER_TAG"
-    # Always ':latest' because we always use upstream as a common cache source
-    - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
-    - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
-    - until docker info; do sleep 1; done
   script:
     - echo "TAG:$TAG"
-    - echo "COMMON_TAG:$COMMON_TAG"
-    - docker build --tag "$TAG" --cache-from "$TAG" --cache-from "$COMMON_TAG"
-      --build-arg BUILDKIT_INLINE_CACHE=1
-      -f "tests/docker/dockerfiles/$NAME.docker" "."
-    - docker push "$TAG"
-  after_script:
-    - docker logout
+    - /kaniko/executor
+      --dockerfile "$DOCKERFILE"
+      --destination "$TAG"
+      --cache=true
+      --cache-repo="$CACHE_REPO"
-- 
2.45.0


