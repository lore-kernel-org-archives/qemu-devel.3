Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69E8C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 21:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMZSP-0004xc-5N; Tue, 03 Jun 2025 17:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZSK-0004wo-5O
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZSH-00067h-CR
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748987156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zt4+xOD2JOJaGI09uyl2+blZDob3oG7L89LptgXnbA8=;
 b=WaP2LoxlbrYhoW9rrOSUht3S7CRZqkjkWIDafcRjMZxdFE9AZ7P6U3zrov7COmyqssfHFy
 RQ0xgWZtbih/ELTEtP3TaZLCwIuA4WaC7SvmYQpVmlcZXHCLZsQdreMmrBWgU4qdi9FjxB
 Ghr1bQKlyh5dsimNLrzmWVfrvqNl5Vs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-0sfpcdbNPumjtSKFuJsBjg-1; Tue, 03 Jun 2025 17:45:55 -0400
X-MC-Unique: 0sfpcdbNPumjtSKFuJsBjg-1
X-Mimecast-MFC-AGG-ID: 0sfpcdbNPumjtSKFuJsBjg_1748987154
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4ea7e46dfso1938802f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 14:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748987153; x=1749591953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zt4+xOD2JOJaGI09uyl2+blZDob3oG7L89LptgXnbA8=;
 b=kPmdCqdumCKKyFgVAZPMt/uiExQP6XMMm552ISOsgVzSAEOlNbOaPVFGdvQYJsWQPB
 zuCS/4myniqN9VwOsyQnYfZu8rdrqhmFGYk5po1wB0mtUq7frrkfv59/MIcjqubryPNH
 h+HJqOc5dfI8zaW1VXbZP9sjgKUGy6/zil+G8wPpuOZqiPPK2ci1P6Y60OSQu6CRjjk2
 JO/z5jjO7n6CXIa3NVUf+b6OqOxKMOP8Ip4sAQRlFTf5dIhfRiUM47RFzr+6MlIB0M9H
 KTR5yEglY20nx7v1qNzcZQWfnp+TsMGBs8zV22/ohCuEEeewbJbMebl3bhw1Veb6M1LK
 XHHg==
X-Gm-Message-State: AOJu0Yy49SE+2oTpJIii0n6TaW14Fwb/E2EFY1gQR+ZEeOapoYWfF/8D
 HELKtp4tVwLiW6EcCAx+KuXfx9gqoTKxkyZcEDxF1HgULwsR9ePKnHYCaITYM4qTiQZNa+E6cHn
 ALa1F0OjovIRTR3GQURC2E5KCR/HmC89pTNJdnfbFs6IXCcOGU063EP5OGV3y9hQAGHPwho6LU2
 wxX2ArabS6nLqyLn0ggoNxRLSeBwjn7/0sOTeWi01R
X-Gm-Gg: ASbGnctitnfZ3/eTmUAZaSwTgxeYWXD8sSm+oLdtywfjkzt05B9t8CzEsvaArUGXLep
 7uVcT7p/dJgxSNQRF2v8rG+/B8U2na1KYbYY6ZeuzC2/enY/9g/dLbcakn8e9LVUUgewWJJlQjg
 UAQFf9jS27JlG8SV5y3kdwKI62wvCnQnNfhk4YQ/7YA2chURVtp6tIJkdYSSZXHImMEdC78tbqN
 ICd2Fp7g16fqPbDMFR/N+Ixf9RHwyo1+AosyrGx3OF3UUwaiNgjRtWpaPtTFwXX4zfqFpGGJiji
 Hia9Zlp3Ndcj7w==
X-Received: by 2002:a05:6000:1a8a:b0:3a4:e8bc:5aa with SMTP id
 ffacd0b85a97d-3a51d8f698dmr302927f8f.11.1748987152909; 
 Tue, 03 Jun 2025 14:45:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExLFVSRX0TeppTiYevkt7dKUZoAqteg4RBq8dEAmD0X6xVlvOJPEnQ5Taf3C0dN49N3nKsNg==
X-Received: by 2002:a05:6000:1a8a:b0:3a4:e8bc:5aa with SMTP id
 ffacd0b85a97d-3a51d8f698dmr302911f8f.11.1748987152469; 
 Tue, 03 Jun 2025 14:45:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b892sm19825593f8f.17.2025.06.03.14.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 14:45:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 12/16] i386/tdx: Fix build on 32-bit host
Date: Tue,  3 Jun 2025 23:45:19 +0200
Message-ID: <20250603214523.131185-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603214523.131185-1-pbonzini@redhat.com>
References: <20250603214523.131185-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

From: Cédric Le Goater <clg@redhat.com>

Use PRI formats where required and fix pointer cast.

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20250602173101.1052983-2-clg@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 0a21ae555c5..820ca3614e2 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -284,7 +284,7 @@ static void tdx_post_init_vcpus(void)
 
     hob = tdx_get_hob_entry(tdx_guest);
     CPU_FOREACH(cpu) {
-        tdx_vcpu_ioctl(cpu, KVM_TDX_INIT_VCPU, 0, (void *)hob->address,
+        tdx_vcpu_ioctl(cpu, KVM_TDX_INIT_VCPU, 0, (void *)(uintptr_t)hob->address,
                        &error_fatal);
     }
 }
@@ -339,7 +339,7 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
         uint32_t flags;
 
         region = (struct kvm_tdx_init_mem_region) {
-            .source_addr = (uint64_t)entry->mem_ptr,
+            .source_addr = (uintptr_t)entry->mem_ptr,
             .gpa = entry->address,
             .nr_pages = entry->size >> 12,
         };
@@ -893,16 +893,16 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
 static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
 {
     if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
-        error_setg(errp, "Invalid attributes 0x%lx for TDX VM "
-                   "(KVM supported: 0x%llx)", tdx->attributes,
-                   tdx_caps->supported_attrs);
+        error_setg(errp, "Invalid attributes 0x%"PRIx64" for TDX VM "
+                   "(KVM supported: 0x%"PRIx64")", tdx->attributes,
+                   (uint64_t)tdx_caps->supported_attrs);
         return -1;
     }
 
     if (tdx->attributes & ~TDX_SUPPORTED_TD_ATTRS) {
         error_setg(errp, "Some QEMU unsupported TD attribute bits being "
-                    "requested: 0x%lx (QEMU supported: 0x%llx)",
-                    tdx->attributes, TDX_SUPPORTED_TD_ATTRS);
+                    "requested: 0x%"PRIx64" (QEMU supported: 0x%"PRIx64")",
+                    tdx->attributes, (uint64_t)TDX_SUPPORTED_TD_ATTRS);
         return -1;
     }
 
@@ -931,8 +931,8 @@ static int setup_td_xfam(X86CPU *x86cpu, Error **errp)
            env->features[FEAT_XSAVE_XSS_HI];
 
     if (xfam & ~tdx_caps->supported_xfam) {
-        error_setg(errp, "Invalid XFAM 0x%lx for TDX VM (supported: 0x%llx))",
-                   xfam, tdx_caps->supported_xfam);
+        error_setg(errp, "Invalid XFAM 0x%"PRIx64" for TDX VM (supported: 0x%"PRIx64"))",
+                   xfam, (uint64_t)tdx_caps->supported_xfam);
         return -1;
     }
 
@@ -999,14 +999,14 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
 
     if (env->tsc_khz && (env->tsc_khz < TDX_MIN_TSC_FREQUENCY_KHZ ||
                          env->tsc_khz > TDX_MAX_TSC_FREQUENCY_KHZ)) {
-        error_setg(errp, "Invalid TSC %ld KHz, must specify cpu_frequency "
+        error_setg(errp, "Invalid TSC %"PRId64" KHz, must specify cpu_frequency "
                          "between [%d, %d] kHz", env->tsc_khz,
                          TDX_MIN_TSC_FREQUENCY_KHZ, TDX_MAX_TSC_FREQUENCY_KHZ);
        return -EINVAL;
     }
 
     if (env->tsc_khz % (25 * 1000)) {
-        error_setg(errp, "Invalid TSC %ld KHz, it must be multiple of 25MHz",
+        error_setg(errp, "Invalid TSC %"PRId64" KHz, it must be multiple of 25MHz",
                    env->tsc_khz);
         return -EINVAL;
     }
@@ -1014,7 +1014,7 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     /* it's safe even env->tsc_khz is 0. KVM uses host's tsc_khz in this case */
     r = kvm_vm_ioctl(kvm_state, KVM_SET_TSC_KHZ, env->tsc_khz);
     if (r < 0) {
-        error_setg_errno(errp, -r, "Unable to set TSC frequency to %ld kHz",
+        error_setg_errno(errp, -r, "Unable to set TSC frequency to %"PRId64" kHz",
                          env->tsc_khz);
         return r;
     }
@@ -1139,7 +1139,7 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
     uint64_t gpa = -1ull;
 
     if (error_code & 0xffff) {
-        error_report("TDX: REPORT_FATAL_ERROR: invalid error code: 0x%lx",
+        error_report("TDX: REPORT_FATAL_ERROR: invalid error code: 0x%"PRIx64,
                      error_code);
         return -1;
     }
-- 
2.49.0


