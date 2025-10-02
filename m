Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76903CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mvq-0001DD-0W; Thu, 02 Oct 2025 13:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvF-0000vI-IE
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Muz-0005oT-Fz
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIPVW/vreV6f3fNXGaXrbRU4fqOOeANYsAJB3x/TZdo=;
 b=R2qCwEy7PLS2rgCSnnrsJJ9wkJOojGgfIgD2lvmVC14QQDC/jIxzg2lHspKouYQYOAGYKw
 k+ni3v9pyjVPaa2Qmkz//Yn62N0e/KK+PMsb4vhwWFDsGbJZcQA7Q2XdvD6zUnJ1QTpQD2
 QcPTMSz5zOzbfgW1r3Xvp9fAkq+6qOs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-_uk_FHBCNYeV2vF8ocRzYw-1; Thu, 02 Oct 2025 13:16:29 -0400
X-MC-Unique: _uk_FHBCNYeV2vF8ocRzYw-1
X-Mimecast-MFC-AGG-ID: _uk_FHBCNYeV2vF8ocRzYw_1759425388
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b3d73e1ed87so165390666b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425387; x=1760030187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uIPVW/vreV6f3fNXGaXrbRU4fqOOeANYsAJB3x/TZdo=;
 b=RUVFvR5PK1u74uY130hzKy1IAS7aUtv2LKF2GUqOHZzqV9qXXxUx7f+DI6IIrNvFgN
 hpZOHlwfh2aZ87ASL6hIN3BITn2NpdUpIHr4zn/uMHPfpgmbW1hRHQHw1sLjrwpMraID
 v4IQ4LT+IvcYe7L4WbQ/DLasU5wKt1IPBC+azPcHJks8DtQoqvuA0EiUVum3nZkgk+lW
 /YvQICRk36ot8msMuDqMG7suMqQKb9xtOMC5pBr/VXHCCnE7F/gCHkn8LwTy4WeZRLKT
 ITy5ENYW329TcKV4ED52VwjUigl6vSooo+pOg51T3x8zry1sZIs0FKgcQGSQjGB5KfAM
 J3rQ==
X-Gm-Message-State: AOJu0YzA8kz6lLh8QTnTYsggK9hEaj/vQ/tIF4SLoqFbzoDOS6Xy+lrW
 4qXCh3YqNmf4W7mxG2obgRs0cKKArkz9Gm1XFRTlkCGjMybDTmmClSIZi6vftdCr0gABSX9+bPJ
 VDVJlKJQWCTiZJYZTMOSXjgwbExyTHmQmCIcGQsxojxvD6g1m0NSHitgdYFmLblqwtWospqg2jo
 G+1MgoEaTNUfq7Nw/N9W/FzCeMVtWSbNksZy2v96dN
X-Gm-Gg: ASbGncsJ5B/xcm49XLmzk2vdShcXjwxI2Vpq/55J0oibTzLszsAabpHlUrGHbWTj7OM
 4qBqQL7/JiZkLXB225QJKc1r8MZw+4+INAOdWgUdu4ELBxSVjiYIjRPdPdEEVeucKjfPc3Viu1O
 bXWOppHKjRSvXu59Pql/E1EcW7KCTDowhak1c+9DemCS7Fc2A7O8OG3eRn71aVfidJbeB7mbN/J
 Yu9ikIy3259O8GFh8hv0jDtv4mL+uq0EITGQzLljO3MxU5BaYZ/TK19mcxuyQ0u3ZgeV4oHb06X
 hB35DiaDbWLPZ7tlV6Vv75g5f4/Um4NvOf6XfajZKDmvEJspPAb6prR9fodgBhfEkIREDjcg1ny
 kugkM+wb965OVUGvaQOoC8BDw/4X3qhQnbgZoC8p11p/ZMgKu
X-Received: by 2002:a17:907:1c90:b0:b2e:7614:d92d with SMTP id
 a640c23a62f3a-b4856904eb4mr298084866b.0.1759425387271; 
 Thu, 02 Oct 2025 10:16:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnLmQaAge+jJFRoWwNSeKF9cIOkAABpLIloN3Vz/h9dEYkQzse9s0/qyM9HMLxPPur1RHW2A==
X-Received: by 2002:a17:907:1c90:b0:b2e:7614:d92d with SMTP id
 a640c23a62f3a-b4856904eb4mr298080366b.0.1759425386784; 
 Thu, 02 Oct 2025 10:16:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b4865986505sm238625866b.23.2025.10.02.10.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 16/27] target/i386/mshv: Implement mshv_arch_put_registers()
Date: Thu,  2 Oct 2025 19:15:25 +0200
Message-ID: <20251002171536.1460049-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Write CPU register state to MSHV vCPUs. Various mapping functions to
prepare the payload for the HV call have been implemented.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-17-magnuskulke@linux.microsoft.com
[mshv.h/mshv_int.h split. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   |  15 +++
 target/i386/mshv/mshv-cpu.c | 237 ++++++++++++++++++++++++++++++++++++
 2 files changed, 252 insertions(+)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index c6e6e8af307..0ea8d504fa5 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -49,6 +49,20 @@ typedef struct MshvMsiControl {
 #define mshv_vcpufd(cpu) (cpu->accel->cpufd)
 
 /* cpu */
+typedef struct MshvFPU {
+    uint8_t fpr[8][16];
+    uint16_t fcw;
+    uint16_t fsw;
+    uint8_t ftwx;
+    uint8_t pad1;
+    uint16_t last_opcode;
+    uint64_t last_ip;
+    uint64_t last_dp;
+    uint8_t xmm[16][16];
+    uint32_t mxcsr;
+    uint32_t pad2;
+} MshvFPU;
+
 typedef enum MshvVmExit {
     MshvVmExitIgnore   = 0,
     MshvVmExitShutdown = 1,
@@ -58,6 +72,7 @@ typedef enum MshvVmExit {
 void mshv_init_mmio_emu(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
+int mshv_configure_vcpu(const CPUState *cpu, const MshvFPU *fpu, uint64_t xcr0);
 int mshv_get_standard_regs(CPUState *cpu);
 int mshv_get_special_regs(CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index bc75686f828..8b10c79e547 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -73,6 +73,35 @@ static enum hv_register_name SPECIAL_REGISTER_NAMES[17] = {
     HV_X64_REGISTER_APIC_BASE,
 };
 
+static enum hv_register_name FPU_REGISTER_NAMES[26] = {
+    HV_X64_REGISTER_XMM0,
+    HV_X64_REGISTER_XMM1,
+    HV_X64_REGISTER_XMM2,
+    HV_X64_REGISTER_XMM3,
+    HV_X64_REGISTER_XMM4,
+    HV_X64_REGISTER_XMM5,
+    HV_X64_REGISTER_XMM6,
+    HV_X64_REGISTER_XMM7,
+    HV_X64_REGISTER_XMM8,
+    HV_X64_REGISTER_XMM9,
+    HV_X64_REGISTER_XMM10,
+    HV_X64_REGISTER_XMM11,
+    HV_X64_REGISTER_XMM12,
+    HV_X64_REGISTER_XMM13,
+    HV_X64_REGISTER_XMM14,
+    HV_X64_REGISTER_XMM15,
+    HV_X64_REGISTER_FP_MMX0,
+    HV_X64_REGISTER_FP_MMX1,
+    HV_X64_REGISTER_FP_MMX2,
+    HV_X64_REGISTER_FP_MMX3,
+    HV_X64_REGISTER_FP_MMX4,
+    HV_X64_REGISTER_FP_MMX5,
+    HV_X64_REGISTER_FP_MMX6,
+    HV_X64_REGISTER_FP_MMX7,
+    HV_X64_REGISTER_FP_CONTROL_STATUS,
+    HV_X64_REGISTER_XMM_CONTROL_STATUS,
+};
+
 int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
                           size_t n_regs)
 {
@@ -372,8 +401,216 @@ int mshv_load_regs(CPUState *cpu)
     return 0;
 }
 
+static inline void populate_hv_segment_reg(SegmentCache *seg,
+                                           hv_x64_segment_register *hv_reg)
+{
+    uint32_t flags = seg->flags;
+
+    hv_reg->base = seg->base;
+    hv_reg->limit = seg->limit;
+    hv_reg->selector = seg->selector;
+    hv_reg->segment_type = (flags >> DESC_TYPE_SHIFT) & 0xF;
+    hv_reg->non_system_segment = (flags & DESC_S_MASK) != 0;
+    hv_reg->descriptor_privilege_level = (flags >> DESC_DPL_SHIFT) & 0x3;
+    hv_reg->present = (flags & DESC_P_MASK) != 0;
+    hv_reg->reserved = 0;
+    hv_reg->available = (flags & DESC_AVL_MASK) != 0;
+    hv_reg->_long = (flags >> DESC_L_SHIFT) & 0x1;
+    hv_reg->_default = (flags >> DESC_B_SHIFT) & 0x1;
+    hv_reg->granularity = (flags & DESC_G_MASK) != 0;
+}
+
+static inline void populate_hv_table_reg(const struct SegmentCache *seg,
+                                         hv_x64_table_register *hv_reg)
+{
+    memset(hv_reg, 0, sizeof(*hv_reg));
+
+    hv_reg->base = seg->base;
+    hv_reg->limit = seg->limit;
+}
+
+static int set_special_regs(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    struct hv_register_assoc assocs[ARRAY_SIZE(SPECIAL_REGISTER_NAMES)];
+    size_t n_regs = ARRAY_SIZE(SPECIAL_REGISTER_NAMES);
+    int ret;
+
+    /* set names */
+    for (size_t i = 0; i < n_regs; i++) {
+        assocs[i].name = SPECIAL_REGISTER_NAMES[i];
+    }
+    populate_hv_segment_reg(&env->segs[R_CS], &assocs[0].value.segment);
+    populate_hv_segment_reg(&env->segs[R_DS], &assocs[1].value.segment);
+    populate_hv_segment_reg(&env->segs[R_ES], &assocs[2].value.segment);
+    populate_hv_segment_reg(&env->segs[R_FS], &assocs[3].value.segment);
+    populate_hv_segment_reg(&env->segs[R_GS], &assocs[4].value.segment);
+    populate_hv_segment_reg(&env->segs[R_SS], &assocs[5].value.segment);
+    populate_hv_segment_reg(&env->tr, &assocs[6].value.segment);
+    populate_hv_segment_reg(&env->ldt, &assocs[7].value.segment);
+
+    populate_hv_table_reg(&env->gdt, &assocs[8].value.table);
+    populate_hv_table_reg(&env->idt, &assocs[9].value.table);
+
+    assocs[10].value.reg64 = env->cr[0];
+    assocs[11].value.reg64 = env->cr[2];
+    assocs[12].value.reg64 = env->cr[3];
+    assocs[13].value.reg64 = env->cr[4];
+    assocs[14].value.reg64 = cpu_get_apic_tpr(x86cpu->apic_state);
+    assocs[15].value.reg64 = env->efer;
+    assocs[16].value.reg64 = cpu_get_apic_base(x86cpu->apic_state);
+
+    ret = mshv_set_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to set special registers");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_fpu(const CPUState *cpu, const struct MshvFPU *regs)
+{
+    struct hv_register_assoc assocs[ARRAY_SIZE(FPU_REGISTER_NAMES)];
+    union hv_register_value *value;
+    size_t fp_i;
+    union hv_x64_fp_control_status_register *ctrl_status;
+    union hv_x64_xmm_control_status_register *xmm_ctrl_status;
+    int ret;
+    size_t n_regs = ARRAY_SIZE(FPU_REGISTER_NAMES);
+
+    /* first 16 registers are xmm0-xmm15 */
+    for (size_t i = 0; i < 16; i++) {
+        assocs[i].name = FPU_REGISTER_NAMES[i];
+        value = &assocs[i].value;
+        memcpy(&value->reg128, &regs->xmm[i], 16);
+    }
+
+    /* next 8 registers are fp_mmx0-fp_mmx7 */
+    for (size_t i = 16; i < 24; i++) {
+        assocs[i].name = FPU_REGISTER_NAMES[i];
+        fp_i = (i - 16);
+        value = &assocs[i].value;
+        memcpy(&value->reg128, &regs->fpr[fp_i], 16);
+    }
+
+    /* last two registers are fp_control_status and xmm_control_status */
+    assocs[24].name = FPU_REGISTER_NAMES[24];
+    value = &assocs[24].value;
+    ctrl_status = &value->fp_control_status;
+    ctrl_status->fp_control = regs->fcw;
+    ctrl_status->fp_status = regs->fsw;
+    ctrl_status->fp_tag = regs->ftwx;
+    ctrl_status->reserved = 0;
+    ctrl_status->last_fp_op = regs->last_opcode;
+    ctrl_status->last_fp_rip = regs->last_ip;
+
+    assocs[25].name = FPU_REGISTER_NAMES[25];
+    value = &assocs[25].value;
+    xmm_ctrl_status = &value->xmm_control_status;
+    xmm_ctrl_status->xmm_status_control = regs->mxcsr;
+    xmm_ctrl_status->xmm_status_control_mask = 0;
+    xmm_ctrl_status->last_fp_rdp = regs->last_dp;
+
+    ret = mshv_set_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to set fpu registers");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_xc_reg(const CPUState *cpu, uint64_t xcr0)
+{
+    int ret;
+    struct hv_register_assoc assoc = {
+        .name = HV_X64_REGISTER_XFEM,
+        .value.reg64 = xcr0,
+    };
+
+    ret = mshv_set_generic_regs(cpu, &assoc, 1);
+    if (ret < 0) {
+        error_report("failed to set xcr0");
+        return -errno;
+    }
+    return 0;
+}
+
+static int set_cpu_state(const CPUState *cpu, const MshvFPU *fpu_regs,
+                         uint64_t xcr0)
+{
+    int ret;
+
+    ret = set_standard_regs(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+    ret = set_special_regs(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+    ret = set_fpu(cpu, fpu_regs);
+    if (ret < 0) {
+        return ret;
+    }
+    ret = set_xc_reg(cpu, xcr0);
+    if (ret < 0) {
+        return ret;
+    }
+    return 0;
+}
+
+/*
+ * TODO: populate topology info:
+ *
+ * X86CPU *x86cpu = X86_CPU(cpu);
+ * CPUX86State *env = &x86cpu->env;
+ * X86CPUTopoInfo *topo_info = &env->topo_info;
+ */
+int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
+                        uint64_t xcr0)
+{
+    int ret;
+
+    ret = set_cpu_state(cpu, fpu, xcr0);
+    if (ret < 0) {
+        error_report("failed to set cpu state");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int put_regs(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    MshvFPU fpu = {0};
+    int ret;
+
+    memset(&fpu, 0, sizeof(fpu));
+
+    ret = mshv_configure_vcpu(cpu, &fpu, env->xcr0);
+    if (ret < 0) {
+        error_report("failed to configure vcpu");
+        return ret;
+    }
+
+    return 0;
+}
+
 int mshv_arch_put_registers(const CPUState *cpu)
 {
+    int ret;
+
+    ret = put_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to put registers");
+        return -1;
+    }
+
     error_report("unimplemented");
     abort();
 }
-- 
2.51.0


