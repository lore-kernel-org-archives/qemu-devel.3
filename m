Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A1CC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 13:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdVNe-0005VK-2D; Fri, 23 Feb 2024 08:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdVJV-0002Xk-5U
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:10:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdVJT-0000EE-7u
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708693801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MRIOv4ZboQVYlj3b2mSx1U0OBCsKlWIyfE7agtEK30k=;
 b=epNJa8KBzTNH08zObsPnAoRCzJWPa5iy9i9sOl8lH/5FW4pm7M0BRIvSLZ7a7wBf9qQBDH
 ABPKALCQrclXC2s0OGeYXhxWOI9NY1qCpL4Fj5xj2yZ0I1DePOlwi4K0UoqMoMzWeN6iOA
 DlcMUx+aM3FOlH4KGG9KiV3G6v1V7Kg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660--Qrwti1FPxGFjoMxdCKRXQ-1; Fri, 23 Feb 2024 08:09:59 -0500
X-MC-Unique: -Qrwti1FPxGFjoMxdCKRXQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-512eb6918ffso145162e87.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 05:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708693797; x=1709298597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MRIOv4ZboQVYlj3b2mSx1U0OBCsKlWIyfE7agtEK30k=;
 b=SLF6bZcCSEFespCSrK9S/5RNswdivUASfmlZDXr23zoM/6dwdAY8q8oTEZUR01XYNv
 KiHrXfNPTEP5DvMtEiO6NhGm2eRLAJnxndQUCUqmRZ+eFhAr7uKr+kOkgvhKj04t4FMN
 s2xrj6xqljDBg6cRRA0UNJ2UmnYTv6MJmKK/hH1zy9BRUvwGn0glgTfbc9sHWCvIEGg+
 In9/eSlZNerA9lVVNBmRXp31mPOIL1FR920lZKXKgNIYzsocqQJIfLmWjoqAJLrDfZC4
 vb97XfN2VzVaozx5/vbm1nfyKQT46N89d18Txkx706hJ7riSliq6B9IGfwmydVfJT5rf
 IKgQ==
X-Gm-Message-State: AOJu0YwNGutHZV19xooi8Di6U/3WGBoIwhdXYe7ap33wQA90DH6zABj+
 5W3UvSgT9+gmrf3LrcjF1PNtsItct8HX2bK4hZZZEF555sXEOTe/fG4jlQSp9ItE74ap7IDb+fn
 O9l5LKegfWPpfWohtudOUUpiVBNLh5uc6bjR+Kw54L1CLyu9yyaNfCbkDOfNlkAyFvXgwra9Aq1
 wawgWBkmsjAol2lkU+fQvvQLCPtUGLYkSZwlQv
X-Received: by 2002:ac2:4842:0:b0:512:a89f:3933 with SMTP id
 2-20020ac24842000000b00512a89f3933mr1846851lfy.24.1708693796822; 
 Fri, 23 Feb 2024 05:09:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbyXI8/bhGIX9DCUPFb20uLYdjl2cELwWKjs0UhJhZOocwwcYlvsxqANiT90qMa0wLNg6W0A==
X-Received: by 2002:ac2:4842:0:b0:512:a89f:3933 with SMTP id
 2-20020ac24842000000b00512a89f3933mr1846837lfy.24.1708693796406; 
 Fri, 23 Feb 2024 05:09:56 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 a18-20020ac25052000000b00512b7990baesm1781026lfm.122.2024.02.23.05.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 05:09:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	mcb30@ipxe.org
Subject: [PATCH v2 2/7] target/i386: check validity of VMCB addresses
Date: Fri, 23 Feb 2024 14:09:43 +0100
Message-ID: <20240223130948.237186-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223130948.237186-1-pbonzini@redhat.com>
References: <20240223130948.237186-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

MSR_VM_HSAVE_PA bits 0-11 are reserved, as are the bits above the
maximum physical address width of the processor.  Setting them to
1 causes a #GP (see "15.30.4 VM_HSAVE_PA MSR" in the AMD manual).

The same is true of VMCB addresses passed to VMRUN/VMLOAD/VMSAVE,
even though the manual is not clear on that.

Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/misc_helper.c |  3 +++
 target/i386/tcg/sysemu/svm_helper.c  | 27 +++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index 7de0a6e866d..edb7c3d8940 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -212,6 +212,9 @@ void helper_wrmsr(CPUX86State *env)
         tlb_flush(cs);
         break;
     case MSR_VM_HSAVE_PA:
+        if (val & (0xfff | ((~0ULL) << env_archcpu(env)->phys_bits))) {
+            goto error;
+        }
         env->vm_hsave = val;
         break;
 #ifdef TARGET_X86_64
diff --git a/target/i386/tcg/sysemu/svm_helper.c b/target/i386/tcg/sysemu/svm_helper.c
index 32ff0dbb13c..5d6de2294fa 100644
--- a/target/i386/tcg/sysemu/svm_helper.c
+++ b/target/i386/tcg/sysemu/svm_helper.c
@@ -164,14 +164,19 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
     uint64_t new_cr3;
     uint64_t new_cr4;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_VMRUN, 0, GETPC());
-
     if (aflag == 2) {
         addr = env->regs[R_EAX];
     } else {
         addr = (uint32_t)env->regs[R_EAX];
     }
 
+    /* Exceptions are checked before the intercept.  */
+    if (addr & (0xfff | ((~0ULL) << env_archcpu(env)->phys_bits))) {
+        raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+    }
+
+    cpu_svm_check_intercept_param(env, SVM_EXIT_VMRUN, 0, GETPC());
+
     qemu_log_mask(CPU_LOG_TB_IN_ASM, "vmrun! " TARGET_FMT_lx "\n", addr);
 
     env->vm_vmcb = addr;
@@ -463,14 +468,19 @@ void helper_vmload(CPUX86State *env, int aflag)
     int mmu_idx = MMU_PHYS_IDX;
     target_ulong addr;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_VMLOAD, 0, GETPC());
-
     if (aflag == 2) {
         addr = env->regs[R_EAX];
     } else {
         addr = (uint32_t)env->regs[R_EAX];
     }
 
+    /* Exceptions are checked before the intercept.  */
+    if (addr & (0xfff | ((~0ULL) << env_archcpu(env)->phys_bits))) {
+        raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+    }
+
+    cpu_svm_check_intercept_param(env, SVM_EXIT_VMLOAD, 0, GETPC());
+
     if (virtual_vm_load_save_enabled(env, SVM_EXIT_VMLOAD, GETPC())) {
         mmu_idx = MMU_NESTED_IDX;
     }
@@ -519,14 +529,19 @@ void helper_vmsave(CPUX86State *env, int aflag)
     int mmu_idx = MMU_PHYS_IDX;
     target_ulong addr;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_VMSAVE, 0, GETPC());
-
     if (aflag == 2) {
         addr = env->regs[R_EAX];
     } else {
         addr = (uint32_t)env->regs[R_EAX];
     }
 
+    /* Exceptions are checked before the intercept.  */
+    if (addr & (0xfff | ((~0ULL) << env_archcpu(env)->phys_bits))) {
+        raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+    }
+
+    cpu_svm_check_intercept_param(env, SVM_EXIT_VMSAVE, 0, GETPC());
+
     if (virtual_vm_load_save_enabled(env, SVM_EXIT_VMSAVE, GETPC())) {
         mmu_idx = MMU_NESTED_IDX;
     }
-- 
2.43.0


