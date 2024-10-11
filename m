Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2865BD24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4U-0001AL-JH; Fri, 11 Oct 2024 13:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szJ4R-0000hD-0j
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szHe8-0007Gs-2g
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728660819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQtmuw2xMVAabxXMNCF1evpW+a0kJgwO3J3KK4HJSHE=;
 b=JzU/tPQvLQCNbDrIHYUMtf27bSAhT77sW1LDHzsayrtNPGOccid7JsJE+hQgCjIQiVERKW
 JZ9bqYtJLv5zdDccGDl9PdHiP1XOQ+4l5mpeqENH49UpZVKjAmJouzwIyj1dea3LmIKjSx
 vuCzln3HkrPPhAA43UUDoM1kNmDdg2A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-Bt7RkumMOoW_wKQoLKH_9w-1; Fri, 11 Oct 2024 11:33:38 -0400
X-MC-Unique: Bt7RkumMOoW_wKQoLKH_9w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a99d1730c26so21792566b.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728660817; x=1729265617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQtmuw2xMVAabxXMNCF1evpW+a0kJgwO3J3KK4HJSHE=;
 b=Z6bpvfc3Pc6JQ6eRkJo/YQoJ7HcZGjSmhUrPrLDJCUOnpfOwjIL+Sk3I/gai49Ityk
 rXmjNCJgSydLjamXgpyqxCVY7Fhble7ytUzQpCKqP53+uqpnUBsM1LdJPvz9VagE6Gob
 zoRNU7v1CWxkVE+Sr+JZxkHmiRMCVyP+TYYTsj1T4jpl7D/CUI3dft8K0927LdOUx5sE
 VNg66fCJPRH6CBbz388tuqovJkw0cCeuS/vQCyHwdmd5Lz/I4XRXWQ8tZGb2ZKIXfSUY
 rJH9EC6i/0sl3XIGKdaiOVlSX6AXDY9IdkEhMB4uuoVwkGC+6IRM6gsZQlXbgUE157aH
 05WA==
X-Gm-Message-State: AOJu0YwkKiHUu0OWZN2WOYytgMuOiddPbNwT6rpCczKV2p1GVNTnadpS
 NL3d6tiQpy9jiGbNuoSpx5Q1mhl+KfdSdLbCBBJA1Mb4SJhNqa3P4XQiW4xwDHSKN4u5rsPMGv8
 VyxZkx/hoNP2CUsBWIKYER4CpyxG5S01lm0twn1erEGwJdeaIR40JsaAbZKVNiRi1KihHxE2cQL
 sOjQwhdGuIB3KDNIIXa1Br+KJ3P6AuxHFEsVYZMpc=
X-Received: by 2002:a17:907:7ea1:b0:a8d:250a:52a8 with SMTP id
 a640c23a62f3a-a99b93a8506mr240095166b.3.1728660816732; 
 Fri, 11 Oct 2024 08:33:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhy0k8oQ+ywfujnrXt/UJo2cW2dY0m+WYz+ikTS6WVY/CFqAaIXXwS1Jx7CSIRiQy3TTJ4/Q==
X-Received: by 2002:a17:907:7ea1:b0:a8d:250a:52a8 with SMTP id
 a640c23a62f3a-a99b93a8506mr240092766b.3.1728660816224; 
 Fri, 11 Oct 2024 08:33:36 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80dcdc3sm226855066b.172.2024.10.11.08.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:33:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v3 15/18] gitlab-ci: add Rust-enabled CI job
Date: Fri, 11 Oct 2024 17:32:23 +0200
Message-ID: <20241011153227.81770-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011153227.81770-1-pbonzini@redhat.com>
References: <20241011153227.81770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Acked-by: Alex Bennée <alex.bennee@linaro.org>
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


