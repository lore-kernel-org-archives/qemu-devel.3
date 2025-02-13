Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51277C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibfb-0001AE-N5; Thu, 13 Feb 2025 11:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibfT-00019P-EV
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibfL-0005fy-UR
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FiozA6Zxf3TwsQBbLHJRuHW2pdcPG+mDIT1dc3xOVEE=;
 b=Ifa76a396QMDyY3giPeGSsfqNXsYBBzxnHda6MGKHu7pWIpqPyKkNO7FE/ONRsjE6N3pYQ
 Xr0Be01wTxG9FPH12FDulJCuZ5x93L0/Kmpy3X43Sv959od+b4wDPLgYAjIFswLxdmp9Ux
 cSTZtzEAGLnZzX+A+z2uNBPxqxjuVMM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-3VerhEtrMCCVe-x2YRCjpw-1; Thu, 13 Feb 2025 11:02:12 -0500
X-MC-Unique: 3VerhEtrMCCVe-x2YRCjpw-1
X-Mimecast-MFC-AGG-ID: 3VerhEtrMCCVe-x2YRCjpw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38dc709f938so1255130f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462531; x=1740067331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FiozA6Zxf3TwsQBbLHJRuHW2pdcPG+mDIT1dc3xOVEE=;
 b=OtejCeB6cYvgm0MDwjBIfc/ODKsXfafGPKzFs/IuydY6SoDikyHYkWE7r0k6HLLfHc
 4ZaVU9t9kUxK95FczpuZqHm3lV4UQjy1WaZSmVTHpGixFQwFfPR1/ZkMbj+tIuB1jZbV
 z923FfA9uVM2dv/iR74sIRgPqK4lYBMuXMAMNKZrmxGh+aPy9yh6PmdTJB/YLucJmEGm
 UT5N/zO5qok3VPvmAeUx9wHPLbTPEK2RkXDxjv3OQM1Xc9Hh9wFB8xyYeW3CL9beYJJU
 HiGf+Zt8iuqZxy7TO78DwEkV2tmJmesj+eU+T9TsW3vz/Zo/+rgHr5YjC1cxjAut9dkc
 poag==
X-Gm-Message-State: AOJu0YzwmNnUN/xKTpwXqpf9TrVl2C5yriSg5RoZ7w8H8KpUFbJVuAEE
 iPXL3iVO5VodGDuLMOsQij7N/VJuqbzrvqb5o7Mx72wmMDKdkLwec53oIzYk9pby75Kl+YVrPWn
 +NJeXwpAetzxTBoDOXm7C1h27+K7gxaMq5gUl4s66Es26OHmxLPnZRe2kswvAADXOSr1vOFj24T
 HJXwOhp5qyTpPv8IWeEZH5b6xRKJ9qKYNmGSvcRN4=
X-Gm-Gg: ASbGncsA5s9emdtykPTcMtga/WPwQD3kKRWmOTx80Ff+SgCOsPQF6Cmc6RtmG7zSCt3
 00ud8A9PFhau17k7M7WJPuAn52veNysgflfXhgHSZqsBPg+f0ypdMKxhhvNcXfWiUez41tYqbdz
 pPDQeXFjMRm7NIWCWFGprppcIto3N59sScRg3KcGT3OMVoko8CAycaAX2NslP8NkyyqSs3yTJb1
 3zgZNdFG9O4URF7AhN1CrjoFsGCNf/ANNKPFelXudN6Cgw+Fw0Jwb2NPi9i3L7vDBfJmGZGLd7T
 GcvoB4QVfrQPZBq7on0mMHcQzYbUY4TpinewcsPANiaOtQ==
X-Received: by 2002:a05:6000:4024:b0:38d:afc8:954e with SMTP id
 ffacd0b85a97d-38f24cfa3dbmr4104954f8f.11.1739462530918; 
 Thu, 13 Feb 2025 08:02:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEV4OUQ/3/DgIPhVyruiRKMRNKMkh6IS9gsA4K/+aJPxOSKPdA6FrwWqAUWbI/N2C4eqqxBRQ==
X-Received: by 2002:a05:6000:4024:b0:38d:afc8:954e with SMTP id
 ffacd0b85a97d-38f24cfa3dbmr4104859f8f.11.1739462530162; 
 Thu, 13 Feb 2025 08:02:10 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a06d1f2sm52061765e9.18.2025.02.13.08.02.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:02:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/27] rust: fix doctests
Date: Thu, 13 Feb 2025 17:00:53 +0100
Message-ID: <20250213160054.3937012-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Doctests were not being run by CI, and have broken. Fix them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml    | 6 ++++++
 rust/qemu-api/src/vmstate.rs  | 2 +-
 rust/qemu-api/src/zeroable.rs | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 4265a577834..00f4bfcd9f3 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -131,6 +131,12 @@ build-system-fedora-rust-nightly:
     CONFIGURE_ARGS: --disable-docs --enable-rust --enable-strict-rust-lints
     TARGETS: aarch64-softmmu
     MAKE_CHECK_ARGS: check-build
+  after_script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start test "Running Rust doctests"
+    - cd build
+    - pyvenv/bin/meson devenv -w ../rust ${CARGO-cargo} test --doc -p qemu_api
+
   allow_failure: true
 
 check-system-fedora:
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index c6dfb609356..24a4dc81e7f 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -294,7 +294,7 @@ pub const fn with_varray_multiply(mut self, num: u32) -> VMStateField {
 /// # Examples
 ///
 /// ```
-/// # use qemu_api::vmstate::impl_vmstate_forward;
+/// # use qemu_api::impl_vmstate_forward;
 /// pub struct Fifo([u8; 16]);
 /// impl_vmstate_forward!(Fifo);
 /// ```
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index a2356cb2f24..47b6977828d 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -7,7 +7,7 @@
 /// behavior.  This trait in principle could be implemented as just:
 ///
 /// ```
-/// pub unsafe trait Zeroable {
+/// pub unsafe trait Zeroable: Default {
 ///     const ZERO: Self = unsafe { ::core::mem::MaybeUninit::<Self>::zeroed().assume_init() };
 /// }
 /// ```
-- 
2.48.1


