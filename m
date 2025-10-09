Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0FECCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lR5-000051-5x; Thu, 09 Oct 2025 03:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lR2-0008WE-9q
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQz-0004Sr-3O
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6w7VzOtHR3BZVmb/GNxbKkCwO8qv7ohv9fFtyVvBzo=;
 b=fF3u0NcF/L+AMWLWLbCHLEvKxB6a7MlLsQQWQgDbs4ZFrXRNiBiwQhSjrdmQDJJ+6PpO8i
 I/3BKYjrokVymYYGylRYqy57vfdkO7KCrumVrF1zCuLQmWliaPoFLEaypDcVFLiiJFe559
 LDfzw+mMag51G5z2v+p3qRy2xWNvIMU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-nhAa99paNgCdjevK9p0Icw-1; Thu, 09 Oct 2025 03:51:30 -0400
X-MC-Unique: nhAa99paNgCdjevK9p0Icw-1
X-Mimecast-MFC-AGG-ID: nhAa99paNgCdjevK9p0Icw_1759996289
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e3ed6540fso4538915e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996288; x=1760601088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6w7VzOtHR3BZVmb/GNxbKkCwO8qv7ohv9fFtyVvBzo=;
 b=bH2dCTFZrI6AzAxbjpeeKhUkKYohGbEnotJg+SLYSc9aql4gid6vo0yyLYKLi3dS1J
 PxCTsdHBFHRdsFRNQdkbK0spYQhUEk5GFGaDGsuO1OhfFI3BJ6nRncd+asqdqoOwpI1n
 IvKxyeek++BtadaAI50HSjKQMvZ5pgKA7LegEUsKA059eB/dv4GNf26IVhziG0BGefIy
 MZVl0R9yAvXs33QFcWRpLV7ET4LZSmRHZYGdWw0y/dzr4mInfSJn+2cwbJAgyetX126X
 YibyjrVlAb2N0129NvNKk0LS7wADB1sxaTF7c0KSp+jU77SnTwAW5Vq6n/9e3oo74QRz
 h1bw==
X-Gm-Message-State: AOJu0Yzu544ACCRTLAs6ejSanNApmYeeGh9EHje6KzDXP+nnley7sb/G
 /nbysaAE8J8SY0vUmGysmHaLljG2hmEjwCQxfLUXG7VZz3gqxn8+d3Nh92nuOzb5d+UeFaW7Eaq
 A6fE/O7YK499Ita7uEyUKbT6sGWVA32qY1OU/khIDX/AvMelUy0sHeVKbR4cYbUIDmoZ4PLP7ql
 UERnAxmi1RlbH4vX2KR1JGz587PjFfG120nS9hI96s1C4=
X-Gm-Gg: ASbGncvlfKxEk4Pa9MWGIF8Il+iMS+qqNENRy0/NrOlBUYyy8LnrPanIaV/2Rf7GG7X
 5Bw062SRGa+fXcvk8nWg/b7WFUWoowNaXMDH0nG96y06FDZ7W9sWH9x+oDSca/qOB4+5HfBc/Tt
 KUKqDi4wP28ve55os63dYMLQiENoI9P5ACGiJR31uPaLaYvxIiwRyRA9NB4wR6duPMJH8sTg+9j
 T9YniX2J/iuaeIUK0AIZi33FAQj1ofZnjV0nQ1pRpMt5AsfnqdO5OWBu4Qm2wWjdvFcFWHiehXA
 tZ62pMjAQNy3iafx7KhdlzqNxghZHap/53lMegPJR/MizQz/iIYnBCms186NMlJ82uLXZHmOlGC
 Vt8e+TuLG8lUc4zVS8JZ4GKMYZytwG8dZw4N87WeQ1ln98oF+
X-Received: by 2002:a05:600c:6a07:b0:46e:74bb:6bd with SMTP id
 5b1f17b1804b1-46fa2952c89mr55072155e9.4.1759996288557; 
 Thu, 09 Oct 2025 00:51:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuKEhRlcHDyUNZBk8Ba7Kh4nkdjuEb3sxsQGHMtqJXZJgKXBD4e7miOQaZD/nsjWlgQvKPnA==
X-Received: by 2002:a05:600c:6a07:b0:46e:74bb:6bd with SMTP id
 5b1f17b1804b1-46fa2952c89mr55071985e9.4.1759996288058; 
 Thu, 09 Oct 2025 00:51:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf17b82bsm33438305e9.15.2025.10.09.00.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 27/35] target/i386/mshv: Write MSRs to the hypervisor
Date: Thu,  9 Oct 2025 09:50:17 +0200
Message-ID: <20251009075026.505715-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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


