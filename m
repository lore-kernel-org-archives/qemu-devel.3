Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90362CED628
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 09:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sySa9-0008OB-Af; Wed, 09 Oct 2024 05:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sySa7-0008Nl-BE
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sySa5-0003l5-NE
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728464524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jbMmTbZ6Gn3a4nXl+2n8f98G484vu+dgfTitnQfWbxQ=;
 b=QUP21HzIugCf/Xu1vDc4YLuJSSHUgovs2bXZtThGKVShEKNVi1DOQPbduYrYyjdX2oOneQ
 2yq1GnBvaowHctqc4DWnIxnWbMEzJzHtku6tb9MzWp7IaV+AUb0oIFuxNmlvDgUU7NKXV8
 Y9zRPadWbbtFclo3vDCLyUW9gxwgjeQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-STUk421eOPqlNtJCRiSI_g-1; Wed, 09 Oct 2024 05:02:03 -0400
X-MC-Unique: STUk421eOPqlNtJCRiSI_g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb830ea86so51274675e9.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 02:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728464521; x=1729069321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbMmTbZ6Gn3a4nXl+2n8f98G484vu+dgfTitnQfWbxQ=;
 b=hdp70IMZiBCiJqmoao3RJIOZB6huNmTw5Sb9YlxczDn9JK6HHNpUNXB/KHMEbfUN9t
 Iv6+lvBAeDezgi14qKHx+VAZOLE/RpyiT4B0QiMZwy0vJqs5CZHLiIIm6DsOEAyW/If2
 w9fL12wKMv4TSbMA4Xwq4K3Agjmrz18veT4JIrNGyGPZJxjYNekm4H9briZoF3zeTjB/
 2hz9IB0tI4+DiAmzAV10MzDFHZ9y+r6FiEARnCNssS0uSMta/L2f+rJrOJH+OpoiG0St
 0ZpT7EP35OAWwENpwCEWtmVbzZB2ZJkYQGGC8EqZh9DCyQGzULV32sfaZDDZOKG1UEDk
 TNvw==
X-Gm-Message-State: AOJu0YwaX3Xu86QSnFM5u3SND5HI/PurdRUuY5W0GXkDaWEXSvxF4cy5
 jc5KUM+xXjLCoRmjJttIKxWfMV12zBq4JtA1uJFHUQdqLAnZ8TQjjqms/xJq2o3MxkBjSFsa2Ci
 nnyV/ed8LiP+oOwjylIIZaMeJJ1Oga1xdrFHX3asVCtVoIeKY4usW5SSLJ7bT+89QMUQha3KPYD
 eTKgcJQJqrkeYU6fT4ad+9w1D1iKFP2dhaPm54W+c=
X-Received: by 2002:a05:600c:1c8b:b0:42c:b961:c902 with SMTP id
 5b1f17b1804b1-430ccf0f0eamr12910865e9.12.1728464521127; 
 Wed, 09 Oct 2024 02:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlBXwQdh4ZMaTYXeqLU9CFTciDpn8oEsfXriXKSD1YsLU6WADsZpFOCCBpLiZija6KkjFtUA==
X-Received: by 2002:a05:600c:1c8b:b0:42c:b961:c902 with SMTP id
 5b1f17b1804b1-430ccf0f0eamr12910575e9.12.1728464520713; 
 Wed, 09 Oct 2024 02:02:00 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf60b2bsm13706895e9.28.2024.10.09.02.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 02:01:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/2] gitlab-ci: add Rust-enabled CI job
Date: Wed,  9 Oct 2024 11:01:50 +0200
Message-ID: <20241009090151.1643088-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009090151.1643088-1-pbonzini@redhat.com>
References: <20241009090151.1643088-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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


