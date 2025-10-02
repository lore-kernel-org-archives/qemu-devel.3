Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E822CCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mve-00014X-EG; Thu, 02 Oct 2025 13:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Muy-0000oO-HY
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Mul-0005mo-Sx
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=011a463v1dGyOKFiUiQNsEioHBlxgPsH4SJpYihX+aE=;
 b=g9PZ0aMEBhouMUGWHysTZxKxWW6hHDxuzryMTaNG0iiFHTv8b5YB1/rDSyRbXmNwXtk+Uw
 Uh8tPFARXBFz9i5f8/hlAFBEcBpAFMOxAdYGZ18HkpKJ84/47bTYi4kMJqhv16J/5+EE2M
 E/VD0rLmLHsJnH/mKLacjFw00Rdl9YE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-Uva_w47fMtOCag3PeVFPOg-1; Thu, 02 Oct 2025 13:16:18 -0400
X-MC-Unique: Uva_w47fMtOCag3PeVFPOg-1
X-Mimecast-MFC-AGG-ID: Uva_w47fMtOCag3PeVFPOg_1759425377
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6215a926e31so1165903a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425376; x=1760030176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=011a463v1dGyOKFiUiQNsEioHBlxgPsH4SJpYihX+aE=;
 b=FHkaB2qJqzPDCuQpD1o8cqdNcdOYV9F2xUdBCgEauIAnkdSD1vC+MoXYftiwMjg16l
 5t8YJIJsTSwnWlVIZT3iwIC2HGb3vCVGyKofh53DiANn0RMYtG11RhrrdcPhsFyBSvUQ
 IVqfldIdb3wBZgSQ8zzG4FKp9b4HEzp2kXfuHlk4MHaX32FrJUN/7mxraTBfMF0jTX8A
 ZLG5uR97MrVldh+2cVzuYquSCOyd0vb6U1vrbOen38MePPIExknmIK/9VfO2VI6GLRde
 q0HxJId58mftK2WzvhqnLjVjYENe9bOddJCZtn3NweM9tUjRAc5w80N8nwGnW7dgizTg
 sRdA==
X-Gm-Message-State: AOJu0Yy6Iv4LSCFmvljgft+bt8TsFytvmru80UmB9dhfQHRyvgFV7T7r
 LRRos9kDvw6qvTUMJLAau8KsurG7+0Xc4ld+K5ShU2RTHfWjXTaKXpm9XbHRNc81Y2ujyz+tyEN
 wwnuyG0l53ykBRaZMcDhIhrw4z18isrgxkoGoa4vkMeP5dCVMSnuqqKvp7RYX1IBmNAHuFYjFXO
 93brpRY4Xr3A9uQE0qgc6wbUO5LGkIzmKLGW+1DX1H
X-Gm-Gg: ASbGncswzqSA02C8RQaXmSDAFf+dOS7eNcm3NbBb763eQXQJKbCVzrajVlD4aVSA2jo
 Gg5xGNZL3xQXixQ7sJLjrUOYhqqk+qnnUSbXa8/V2N61vAvkAIfMWFm1QdBAJVfkZujBFA/XKNT
 4uIVHw1wHFWVXIpS3+csyjfQQ3lHg5A/hQNY/XrOmxInX2INZJ7a095WPEhexInRGvv5ZKQ8ueE
 AR85c8f4A6yDGLJ2Pcv5w+9q9C7BrLDY8L0lBizLpqekShmmsc7uL30VWHw5zHdYHyvflX7/bPi
 g7HSKqSAL5UMVdu4uCRg1sC1KYfMTi/jkCtY9LqyHUtdWoZ8/FXB3eq3unnPF06YG32R7HEGd0d
 Hu/khS+LxzAbpYxj5x4cZQoXeLLqL8cTNP+NcqN9kKNdoI+6V
X-Received: by 2002:a05:6402:518d:b0:61c:cf8d:e51d with SMTP id
 4fb4d7f45d1cf-63678c4cfa6mr9386529a12.22.1759425376124; 
 Thu, 02 Oct 2025 10:16:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwIJX2DeuBdWDzoI7wUsCYx4QsIwzuxpRC0y690e/rmcjD86TTqRRbFJfsy+tHlmyJMnXR5A==
X-Received: by 2002:a05:6402:518d:b0:61c:cf8d:e51d with SMTP id
 4fb4d7f45d1cf-63678c4cfa6mr9386482a12.22.1759425375538; 
 Thu, 02 Oct 2025 10:16:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6378811f198sm2196489a12.47.2025.10.02.10.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 13/27] target/i386/mshv: Implement mshv_store_regs()
Date: Thu,  2 Oct 2025 19:15:22 +0200
Message-ID: <20251002171536.1460049-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add support for writing general-purpose registers to MSHV vCPUs
during initialization or migration using the MSHV register interface. A
generic set_register call is introduced to abstract the HV call over
the various register types.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-14-magnuskulke@linux.microsoft.com
[mshv.h/mshv_int.h split. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv.h       |   1 +
 include/system/mshv_int.h   |   2 +
 target/i386/mshv/mshv-cpu.c | 116 +++++++++++++++++++++++++++++++++++-
 3 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index bbc42f4dc3a..8b1fc20c80d 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -18,6 +18,7 @@
 #include "qemu/accel.h"
 #include "hw/hyperv/hyperv-proto.h"
 #include "hw/hyperv/hvhdk.h"
+#include "hw/hyperv/hvgdk_mini.h"
 #include "qapi/qapi-types-common.h"
 #include "system/memory.h"
 #include "accel/accel-ops.h"
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index fb80f69772b..731841af929 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -61,6 +61,8 @@ void mshv_remove_vcpu(int vm_fd, int cpu_fd);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_load_regs(CPUState *cpu);
 int mshv_store_regs(CPUState *cpu);
+int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
+                          size_t n_regs);
 int mshv_arch_put_registers(const CPUState *cpu);
 void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 5069ab7a22f..9ead03ca2d8 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -32,12 +32,124 @@
 
 #include <sys/ioctl.h>
 
+static enum hv_register_name STANDARD_REGISTER_NAMES[18] = {
+    HV_X64_REGISTER_RAX,
+    HV_X64_REGISTER_RBX,
+    HV_X64_REGISTER_RCX,
+    HV_X64_REGISTER_RDX,
+    HV_X64_REGISTER_RSI,
+    HV_X64_REGISTER_RDI,
+    HV_X64_REGISTER_RSP,
+    HV_X64_REGISTER_RBP,
+    HV_X64_REGISTER_R8,
+    HV_X64_REGISTER_R9,
+    HV_X64_REGISTER_R10,
+    HV_X64_REGISTER_R11,
+    HV_X64_REGISTER_R12,
+    HV_X64_REGISTER_R13,
+    HV_X64_REGISTER_R14,
+    HV_X64_REGISTER_R15,
+    HV_X64_REGISTER_RIP,
+    HV_X64_REGISTER_RFLAGS,
+};
+
+int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
+                          size_t n_regs)
+{
+    int cpu_fd = mshv_vcpufd(cpu);
+    int vp_index = cpu->cpu_index;
+    size_t in_sz, assocs_sz;
+    hv_input_set_vp_registers *in;
+    struct mshv_root_hvcall args = {0};
+    int ret;
+
+    /* find out the size of the struct w/ a flexible array at the tail */
+    assocs_sz = n_regs * sizeof(hv_register_assoc);
+    in_sz = sizeof(hv_input_set_vp_registers) + assocs_sz;
+
+    /* fill the input struct */
+    in = g_malloc0(in_sz);
+    in->vp_index = vp_index;
+    memcpy(in->elements, assocs, assocs_sz);
+
+    /* create the hvcall envelope */
+    args.code = HVCALL_SET_VP_REGISTERS;
+    args.in_sz = in_sz;
+    args.in_ptr = (uint64_t) in;
+    args.reps = (uint16_t) n_regs;
+
+    /* perform the call */
+    ret = mshv_hvcall(cpu_fd, &args);
+    g_free(in);
+    if (ret < 0) {
+        error_report("Failed to set registers");
+        return -1;
+    }
+
+    /* assert we set all registers */
+    if (args.reps != n_regs) {
+        error_report("Failed to set registers: expected %zu elements"
+                     ", got %u", n_regs, args.reps);
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_standard_regs(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    hv_register_assoc assocs[ARRAY_SIZE(STANDARD_REGISTER_NAMES)];
+    int ret;
+    size_t n_regs = ARRAY_SIZE(STANDARD_REGISTER_NAMES);
+
+    /* set names */
+    for (size_t i = 0; i < ARRAY_SIZE(STANDARD_REGISTER_NAMES); i++) {
+        assocs[i].name = STANDARD_REGISTER_NAMES[i];
+    }
+    assocs[0].value.reg64 = env->regs[R_EAX];
+    assocs[1].value.reg64 = env->regs[R_EBX];
+    assocs[2].value.reg64 = env->regs[R_ECX];
+    assocs[3].value.reg64 = env->regs[R_EDX];
+    assocs[4].value.reg64 = env->regs[R_ESI];
+    assocs[5].value.reg64 = env->regs[R_EDI];
+    assocs[6].value.reg64 = env->regs[R_ESP];
+    assocs[7].value.reg64 = env->regs[R_EBP];
+    assocs[8].value.reg64 = env->regs[R_R8];
+    assocs[9].value.reg64 = env->regs[R_R9];
+    assocs[10].value.reg64 = env->regs[R_R10];
+    assocs[11].value.reg64 = env->regs[R_R11];
+    assocs[12].value.reg64 = env->regs[R_R12];
+    assocs[13].value.reg64 = env->regs[R_R13];
+    assocs[14].value.reg64 = env->regs[R_R14];
+    assocs[15].value.reg64 = env->regs[R_R15];
+    assocs[16].value.reg64 = env->eip;
+    lflags_to_rflags(env);
+    assocs[17].value.reg64 = env->eflags;
+
+    ret = mshv_set_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to set standard registers");
+        return -errno;
+    }
+    return 0;
+}
+
 int mshv_store_regs(CPUState *cpu)
 {
-    error_report("unimplemented");
-    abort();
+    int ret;
+
+    ret = set_standard_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to store standard registers");
+        return -1;
+    }
+
+    return 0;
 }
 
+
 int mshv_load_regs(CPUState *cpu)
 {
     error_report("unimplemented");
-- 
2.51.0


