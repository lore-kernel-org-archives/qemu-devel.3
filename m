Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8F7CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mvz-0001JW-GN; Thu, 02 Oct 2025 13:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvS-0000zr-C1
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvB-0005rT-Ql
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6w7VzOtHR3BZVmb/GNxbKkCwO8qv7ohv9fFtyVvBzo=;
 b=T0cdcuu/9QZ+BMsTP32/xbinatrIDMcBv60JgvIzvcKJb4jJCEyftJ6B5ap/1BbQB/zrbg
 VkDIvLbST5BMTyxCut+NdcXgoQv/J9L+g5/4EC5tfHhmEAvlY2H3F70v7ckp+1p5GZyN/w
 F9A4a0TMhzXv5Fp88rxOgoj3vcnlnxM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-won1apSuPgqudhVEtBBhaw-1; Thu, 02 Oct 2025 13:16:44 -0400
X-MC-Unique: won1apSuPgqudhVEtBBhaw-1
X-Mimecast-MFC-AGG-ID: won1apSuPgqudhVEtBBhaw_1759425403
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-afe81959e5cso181301566b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425403; x=1760030203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6w7VzOtHR3BZVmb/GNxbKkCwO8qv7ohv9fFtyVvBzo=;
 b=DblP86WPGFAZE4BstqTpczOBlfEL2iKgLgloRhBynOS4dD+j4X2Y2swQgepXbun1xl
 dM/YNl/ofKIXvvC4TfA3BcPTlOAvLlPyqgy7xyB601NJ0ZcKl5tn4aD9P+sqPtyp1xYp
 AN2WiTDTLr7SOQ8SAeucALmQFfqvdYC8w5ExPhriJkOn/JvD0uiIMERpywq+6mS++bd8
 Pg4foTUiMkliv0e1H5TBJoUjHCupf7ShbvS+GQtl9aWg32kgsqN8CygJtRh354YSOkuw
 SFsr+U6cr4CTXFvLbClNiS1hBld2OUrqSQOCx1b49d9//DRnlpT4XAlAwBDX7jCxJ/Kk
 Exrw==
X-Gm-Message-State: AOJu0YxmksNbsn+1Y94FezkGnHkHdJEgjy3LbM5ARlKje8Ad80ipPsuK
 s5g76NauR+jBUatUXwtB0x9TukFsIN+WQ4KkjWUPVuXQw0T5qnoqLH1rPfaDmtZ+cTmlI5weThi
 QP3l/J+wpaTp3e7A/B+o3A/xaPbITGERN9Q1FYX/9bP9dLlUu72OtlDhO1KA+hvnmB0ayviAdf3
 sAh9xSE8AcshItN+udp8712+DE0iA3CH+BBCs9U7Uc
X-Gm-Gg: ASbGncukka+q24PruHLrztIXnP4IEW7UU6ETLKEwarcCT0HtZ0NGw7L+KXM8NIxW/jd
 fjnla2xAarr0IksCfkyKbb3LQnhH5Uok0h2bk22/EAAAEclBP+rx8FgtWcFbxU2sCBdozn8+2Lp
 6kcDz7ZGevy7udLLmMpbYcUi05UPIX9E0UJHbO/PXfl2eUK1Msf+ZPRg69VwFm9EPLYk80reCnd
 35uYtWAhuWwC55kSt0Dn+T0asAkia1gWyH/dEVaozSWl54dRHp7bgDOVEJf53d6vfH3MahN0RAk
 YKzGXhwiIpzgBYB8aCLCuwLZv+a4EvbaSh0sAwt5ovQoxbvKgZqe2wED0R6jrXUgVcpfc0H6h1l
 gTwVc7FQfB7VNWVqu0OOOp5YRoctiju3gmLlRcXdAY7HmCX8q
X-Received: by 2002:a17:907:7e8c:b0:b0b:20e5:89f6 with SMTP id
 a640c23a62f3a-b49c449a236mr22455666b.60.1759425402586; 
 Thu, 02 Oct 2025 10:16:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpZQZ7eo755/kgLUhcoMIhNP4s91mCZ9+Jj7uQwoe8SgbkgcW0iRrWgumKZIBqvJ+aJe+wKg==
X-Received: by 2002:a17:907:7e8c:b0:b0b:20e5:89f6 with SMTP id
 a640c23a62f3a-b49c449a236mr22449966b.60.1759425401955; 
 Thu, 02 Oct 2025 10:16:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b486a178605sm242102566b.96.2025.10.02.10.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 21/27] target/i386/mshv: Write MSRs to the hypervisor
Date: Thu,  2 Oct 2025 19:15:30 +0200
Message-ID: <20251002171536.1460049-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Push current model-specific register (MSR) values to MSHV's vCPUs as
part of setting state to the hypervisor.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-22-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 68 +++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 424ebdb1228..33a3ce8b110 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -998,6 +998,65 @@ static int put_regs(const CPUState *cpu)
     return 0;
 }
 
+struct MsrPair {
+    uint32_t index;
+    uint64_t value;
+};
+
+static int put_msrs(const CPUState *cpu)
+{
+    int ret = 0;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    MshvMsrEntries *msrs = g_malloc0(sizeof(MshvMsrEntries));
+
+    struct MsrPair pairs[] = {
+        { MSR_IA32_SYSENTER_CS,    env->sysenter_cs },
+        { MSR_IA32_SYSENTER_ESP,   env->sysenter_esp },
+        { MSR_IA32_SYSENTER_EIP,   env->sysenter_eip },
+        { MSR_EFER,                env->efer },
+        { MSR_PAT,                 env->pat },
+        { MSR_STAR,                env->star },
+        { MSR_CSTAR,               env->cstar },
+        { MSR_LSTAR,               env->lstar },
+        { MSR_KERNELGSBASE,        env->kernelgsbase },
+        { MSR_FMASK,               env->fmask },
+        { MSR_MTRRdefType,         env->mtrr_deftype },
+        { MSR_VM_HSAVE_PA,         env->vm_hsave },
+        { MSR_SMI_COUNT,           env->msr_smi_count },
+        { MSR_IA32_PKRS,           env->pkrs },
+        { MSR_IA32_BNDCFGS,        env->msr_bndcfgs },
+        { MSR_IA32_XSS,            env->xss },
+        { MSR_IA32_UMWAIT_CONTROL, env->umwait },
+        { MSR_IA32_TSX_CTRL,       env->tsx_ctrl },
+        { MSR_AMD64_TSC_RATIO,     env->amd_tsc_scale_msr },
+        { MSR_TSC_AUX,             env->tsc_aux },
+        { MSR_TSC_ADJUST,          env->tsc_adjust },
+        { MSR_IA32_SMBASE,         env->smbase },
+        { MSR_IA32_SPEC_CTRL,      env->spec_ctrl },
+        { MSR_VIRT_SSBD,           env->virt_ssbd },
+    };
+
+    if (ARRAY_SIZE(pairs) > MSHV_MSR_ENTRIES_COUNT) {
+        error_report("MSR entries exceed maximum size");
+        g_free(msrs);
+        return -1;
+    }
+
+    for (size_t i = 0; i < ARRAY_SIZE(pairs); i++) {
+        MshvMsrEntry *entry = &msrs->entries[i];
+        entry->index = pairs[i].index;
+        entry->reserved = 0;
+        entry->data = pairs[i].value;
+        msrs->nmsrs++;
+    }
+
+    ret = mshv_configure_msr(cpu, &msrs->entries[0], msrs->nmsrs);
+    g_free(msrs);
+    return ret;
+}
+
+
 int mshv_arch_put_registers(const CPUState *cpu)
 {
     int ret;
@@ -1008,8 +1067,13 @@ int mshv_arch_put_registers(const CPUState *cpu)
         return -1;
     }
 
-    error_report("unimplemented");
-    abort();
+    ret = put_msrs(cpu);
+    if (ret < 0) {
+        error_report("Failed to put msrs");
+        return -1;
+    }
+
+    return 0;
 }
 
 void mshv_arch_amend_proc_features(
-- 
2.51.0


