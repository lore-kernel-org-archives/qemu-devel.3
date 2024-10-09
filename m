Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600CCCED63E
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 09:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syTHx-0001f5-TK; Wed, 09 Oct 2024 05:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHq-0001PQ-Mo
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHp-000050-8Y
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728467236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bHDwptPmZyCMm+nAgUAk6HAoWxCUuLrONEbch+MjGqo=;
 b=YQH+XV1KA5W8gzdIbVdgRRi5eNwDz9NV+UjijZSr42smJ8RSwbGo3Z55hXdDIYl26Trwae
 M3zHbdEu6tOEQu/zems0aYnWow5gd1psfNK5Hl+IViyC5l3iShaTlFegb754Bimir6iTVM
 p+3aERaZtGb1S7N4jUJeqH0EhW9adVQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-H2NT2SBMOHSPRglIWf4IoQ-1; Wed, 09 Oct 2024 05:47:15 -0400
X-MC-Unique: H2NT2SBMOHSPRglIWf4IoQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43057c9b32bso7828965e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 02:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728467233; x=1729072033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bHDwptPmZyCMm+nAgUAk6HAoWxCUuLrONEbch+MjGqo=;
 b=mnq+lSsoEA2rCrrvlAQQW/u1SBJzpjM9zBDorH4GNxzODEnH5yru43NeaxDI3egJba
 8wg52wXC6FBTRrDa0QZnuPgYNPB673IJVvYrLVhlHdMOBW9Lb8J76qHKOKqiIPP9he4f
 UkkNl1O/UY45kZc2GKMVF/CqwMRPTYBkW7r/Zgz8/nTYnFiMdPpmZlMmn+HioRc5HS3g
 eFHzysmUf7qPAl8I0GaJQ5h8epDsRmzCYZhCxX6qPonbZmHzVFlmIGci8B99FQmHaNO5
 TdfJV5IkbJNxPDc8tMV939Qkxw0oq7ytooqrJi2dOn4TBf2Xph5KwU7blphabFw1Z6n1
 U7Qg==
X-Gm-Message-State: AOJu0Ywq1Gp4wnigdEpGPQcAJWa7rewsn+0rrHSoOxVoNox9fXhZoWnh
 D5ZvxRnJehxvTga07sS3z1/yuF+M1uyu4375e46vbqxzKPZV+q/wGFiuTtuqnGpfXbZk5YtUvY+
 AhnzrXC79XIZGPBgAmq/dNujcmWhfw3Uyoj3E8swjtvmaBypZEOcsf73W5XrUZRnQ8wcTiGyhpq
 EE3x3jm8/Hc+t7zKgEBhyMgSkSDvwq/Hjq83+nI6E=
X-Received: by 2002:adf:fa06:0:b0:37c:c832:cf9c with SMTP id
 ffacd0b85a97d-37d3aa916d0mr1230510f8f.50.1728467233223; 
 Wed, 09 Oct 2024 02:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM3GBPvqufzvfADELHDRHI74Y2YGac9OePah6jHP3QV3uH7uWv8S0lVG6krboVEM163VbMzg==
X-Received: by 2002:adf:fa06:0:b0:37c:c832:cf9c with SMTP id
 ffacd0b85a97d-37d3aa916d0mr1230487f8f.50.1728467232743; 
 Wed, 09 Oct 2024 02:47:12 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1695e3e7sm9981636f8f.72.2024.10.09.02.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 02:47:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 14/14] gitlab-ci: add Rust-enabled CI job
Date: Wed,  9 Oct 2024 11:46:15 +0200
Message-ID: <20241009094616.1648511-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009094616.1648511-1-pbonzini@redhat.com>
References: <20241009094616.1648511-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a job using --enable-rust, to ensure that the toolchain is installed
correctly by the Dockerfile and that QEMU builds with Rust enabled on
at least one platform.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml  | 13 +++++++++++++
 .gitlab-ci.d/containers.yml |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 669c980c4b4..6af7920b355 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -120,6 +120,19 @@ build-system-fedora:
       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
     MAKE_CHECK_ARGS: check-build
 
+build-system-fedora-rust-nightly:
+  extends:
+    - .native_build_job_template
+    - .native_build_artifact_template
+  needs:
+    job: amd64-fedora-rust-nightly-container
+  variables:
+    IMAGE: fedora-rust-nightly
+    CONFIGURE_ARGS: --disable-docs --enable-rust
+    TARGETS: aarch64-softmmu
+    MAKE_CHECK_ARGS: check-build
+  allow_failure: true
+
 check-system-fedora:
   extends: .native_test_job_template
   needs:
diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index ae79d4c58bc..db9b4d5e57f 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -27,3 +27,9 @@ python-container:
   extends: .container_job_template
   variables:
     NAME: python
+
+amd64-fedora-rust-nightly-container:
+  extends: .container_job_template
+  variables:
+    NAME: fedora-rust-nightly
+  allow_failure: true
-- 
2.46.2


