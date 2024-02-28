Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA1FC54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 08:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfEyJ-0001VY-9O; Wed, 28 Feb 2024 03:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEyH-0001V0-SJ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEy8-0000Ug-1X
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709107630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s1yTfF9AGvoZg3IPbtvgG6CiruJp7O4UqyUWNdatiPc=;
 b=PTQgNSVXfEnUhffUNxTpO2EPWk6XQic4Bt2W+f9jf5cTgzkc2Go8C2z/5j4FebdaicxEoc
 C8KywFBn1gFx1Hu+ENlzbRmq+Jd1HqRY7rDdFxly2H8PNpbdI1RGjG6YZNX4BTdRVvZ/MI
 cCkGG2e/TZWi8+016hTW6tnXcndgS9A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-aD5WQxfwMl64t6Ifk6vqww-1; Wed, 28 Feb 2024 03:07:09 -0500
X-MC-Unique: aD5WQxfwMl64t6Ifk6vqww-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-56588555f0bso2381467a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 00:07:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709107627; x=1709712427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s1yTfF9AGvoZg3IPbtvgG6CiruJp7O4UqyUWNdatiPc=;
 b=RxgcxTfe8VtYDEVBcOk9W15FYctybXLs1Uh0LrQSNFPk7b0yoqSYigO6D3GTXIPW5l
 jvlF0TFDu4cAcHj35fULYvE2OMzLSuE7G0PWiWNbdyj7PQ0cKOpPPy3fMj9o8y6gzs3C
 Q4zjAzY+W7oSU3ol97KVywuYDX/+dMNTWAIlumTQpJIuE1ljJY9kntLEMaQQDwv4PIK2
 UB1o59mMH6kUieuSnI9qtEtwlGiiu52Q7NDH+LPGPY0k7gy0PGlNMOK9mBN2eKcqGjDG
 bW8KFR/jOL0/nEhDJIEZTonTxanl521PLLkAqpYvCizPx1YnKZ92UQRNe/zES7713RYz
 zluw==
X-Gm-Message-State: AOJu0YxeNYXO8cnekLEcKMRws3sX3bRNi9+oKOCxMUwB5izXMSq8r54W
 2hrtWc48VJh+EJJEc+0WIfkmMegy4Bu3RhcVdl+6qG9CsMVOaOlruHNPQnVmday1hzwR2o4F5kE
 nQ3xwdKwsqDNi6w7M+gB8rVw+hoq5If3gO8LTug036iqeSWTqJ1iIu+E68P7SJpI9rV30YQK+8O
 0tn+VgQG/KfeOCSMeR7kRWLxhTLrYllmCsMQMz
X-Received: by 2002:aa7:d512:0:b0:566:3f3e:3a23 with SMTP id
 y18-20020aa7d512000000b005663f3e3a23mr2669150edq.1.1709107627738; 
 Wed, 28 Feb 2024 00:07:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU8vtr1k3uZioNqXPSfBOX5lv+ZTqbemj61B0odAq3Ro9tEzJOwU8X4frSry+4MkFO4l4MJg==
X-Received: by 2002:aa7:d512:0:b0:566:3f3e:3a23 with SMTP id
 y18-20020aa7d512000000b005663f3e3a23mr2669133edq.1.1709107627360; 
 Wed, 28 Feb 2024 00:07:07 -0800 (PST)
Received: from [192.168.10.118] ([93.56.170.180])
 by smtp.gmail.com with ESMTPSA id
 ec31-20020a0564020d5f00b0056650cd0156sm860084edb.66.2024.02.28.00.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 00:07:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 03/10] target/i386: check validity of VMCB addresses
Date: Wed, 28 Feb 2024 09:06:39 +0100
Message-ID: <20240228080646.261365-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228080646.261365-1-pbonzini@redhat.com>
References: <20240228080646.261365-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

Cc: qemu-stable@nongnu.org
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
2.43.2


