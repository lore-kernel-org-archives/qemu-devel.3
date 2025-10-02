Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E740CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mvj-00018w-F4; Thu, 02 Oct 2025 13:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvH-0000vu-TA
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Muy-0005oe-GX
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybg7xeLuE7xqCSx05hiU1cBvGy3lci2b+snhEgiPC5w=;
 b=VN22ugeDQxEGpRKbfP4WSlPGl7rL0zu5ys1U03gvZ0Zgsy0A3Aozn9jkKPa8JuY0NL1ORh
 Jo+iijA+5koe+ecsfN4gk5k3U56qIYjjSf+qCimp0ErIzJg7gEk+6QR9kJS12ieSl1ScW7
 uEPc0n+x3cevGkGAbLmD4Jb90hvTCVg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-FBXnPKBkMCmgJt4xNVbIFQ-1; Thu, 02 Oct 2025 13:16:25 -0400
X-MC-Unique: FBXnPKBkMCmgJt4xNVbIFQ-1
X-Mimecast-MFC-AGG-ID: FBXnPKBkMCmgJt4xNVbIFQ_1759425384
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b3d6645acd3so126609566b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425383; x=1760030183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ybg7xeLuE7xqCSx05hiU1cBvGy3lci2b+snhEgiPC5w=;
 b=YBDVyWDJNtDwaFOZjgItm2aTtgF8AxFABgTB9AEPV8hfC1VLOHaTCHx4FSdX0hiCny
 1/ugVNYR0ZjCHv03wES3CNzKCRyjQavyI65g8WtT+Jb9Sq2U6liUx/GBmd9Fm94r/qAX
 Lxqld0Jjm4qdWsCqI9f+IOTUaSpTds4EJOGPFetgwCuoSRtSQgn3A7K3AiOCKowOwDOo
 7iiWmoiPlsDB2YGV60aicId6UdKbhanw88aM7gvjXEeoB+NE8jZvPMwrc6YoHYf/tNOQ
 RBcNIfYDqQNRZF3V/5ACMc17Q0OWZj6KIbzzo/IiJ0w4UDgK7k3pwKxY6QLN/ekOdJWp
 cxYA==
X-Gm-Message-State: AOJu0YzGDiPPGlMjwDFNUeVVCK3uXCA2O9CBeFtn7asapoXvWgJuQtDS
 zVyDL6PIz6fwvdblNCR377C5TflbDrXDUaq4BMeImGpSx0UQfqXNhgNQD9fIuG4aFmv47gb7Udr
 OZPqLBLpKLeeLrOUEMaEP2j6YGnwFnCozf+Ixv1BnunYbFMUgINmm3vhOgVjuVkPgl1fBrDHxya
 NaBv2g2JHDQFg0OHeO+MquKL9OE4ebBcAxU5V+3lnk
X-Gm-Gg: ASbGncsfi4mtGl560hOkXOj1RIvYIQKjzM5oJlhKoTb+3E6oeY6u1vkhVKAA2YKzX9A
 M2i85gOvYKxHg3WoZxlhMuEqJjo3aacy9331b0SIRavZxZ1W097QcQyRl5xo1pnp3pcF3tFknVF
 2NdQV/m1hxJ8iLszNoKzistK60h7CTuPSzv/4bcF8GVt55C8dWLvISNqcut9MdteQiKtejlQcdh
 RQ8GaVDJCReSslhz65i9O5RhXOFtmL4PoU6fFd8NkWiPh/i/KZuOIry2Ae76O1Q6X6qB72BQkQa
 NkJVL8EbUGMb+RjdAixPLVUL+dR71EbyuK3BZiqQ2+9ZTqwgQbxu17oahdK4YgsFd7HzyFaicWq
 1iPzJRM7VgKDm0tIMkxwg8zPqXcGNG2PVRTk0ev5c9c51oSAA
X-Received: by 2002:a17:907:3d05:b0:b3f:5513:5cd0 with SMTP id
 a640c23a62f3a-b49c19769fbmr28438166b.19.1759425383250; 
 Thu, 02 Oct 2025 10:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOKYwJE2prvNSYTyuJZvp6VBfA3z00kdE1BnJ89CfNxmDDA1OxRQdR51MvHoQcSeM/gqdh+g==
X-Received: by 2002:a17:907:3d05:b0:b3f:5513:5cd0 with SMTP id
 a640c23a62f3a-b49c19769fbmr28433866b.19.1759425382723; 
 Thu, 02 Oct 2025 10:16:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b48652a9ebbsm239922566b.7.2025.10.02.10.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 15/27] target/i386/mshv: Implement mshv_get_special_regs()
Date: Thu,  2 Oct 2025 19:15:24 +0200
Message-ID: <20251002171536.1460049-16-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Retrieve special registers (e.g. segment, control, and descriptor
table registers) from MSHV vCPUs.

Various helper functions to map register state representations between
Qemu and MSHV are introduced.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-16-magnuskulke@linux.microsoft.com
[mshv.h/mshv_int.h split. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   |   1 +
 target/i386/mshv/mshv-cpu.c | 104 ++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index b0a79296ad9..c6e6e8af307 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -59,6 +59,7 @@ void mshv_init_mmio_emu(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
 int mshv_get_standard_regs(CPUState *cpu);
+int mshv_get_special_regs(CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_load_regs(CPUState *cpu);
 int mshv_store_regs(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 4e3eee113bb..bc75686f828 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -53,6 +53,26 @@ static enum hv_register_name STANDARD_REGISTER_NAMES[18] = {
     HV_X64_REGISTER_RFLAGS,
 };
 
+static enum hv_register_name SPECIAL_REGISTER_NAMES[17] = {
+    HV_X64_REGISTER_CS,
+    HV_X64_REGISTER_DS,
+    HV_X64_REGISTER_ES,
+    HV_X64_REGISTER_FS,
+    HV_X64_REGISTER_GS,
+    HV_X64_REGISTER_SS,
+    HV_X64_REGISTER_TR,
+    HV_X64_REGISTER_LDTR,
+    HV_X64_REGISTER_GDTR,
+    HV_X64_REGISTER_IDTR,
+    HV_X64_REGISTER_CR0,
+    HV_X64_REGISTER_CR2,
+    HV_X64_REGISTER_CR3,
+    HV_X64_REGISTER_CR4,
+    HV_X64_REGISTER_CR8,
+    HV_X64_REGISTER_EFER,
+    HV_X64_REGISTER_APIC_BASE,
+};
+
 int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
                           size_t n_regs)
 {
@@ -255,6 +275,84 @@ int mshv_get_standard_regs(CPUState *cpu)
     return 0;
 }
 
+static inline void populate_segment_reg(const hv_x64_segment_register *hv_seg,
+                                        SegmentCache *seg)
+{
+    memset(seg, 0, sizeof(SegmentCache));
+
+    seg->base = hv_seg->base;
+    seg->limit = hv_seg->limit;
+    seg->selector = hv_seg->selector;
+
+    seg->flags = (hv_seg->segment_type << DESC_TYPE_SHIFT)
+                 | (hv_seg->present * DESC_P_MASK)
+                 | (hv_seg->descriptor_privilege_level << DESC_DPL_SHIFT)
+                 | (hv_seg->_default << DESC_B_SHIFT)
+                 | (hv_seg->non_system_segment * DESC_S_MASK)
+                 | (hv_seg->_long << DESC_L_SHIFT)
+                 | (hv_seg->granularity * DESC_G_MASK)
+                 | (hv_seg->available * DESC_AVL_MASK);
+
+}
+
+static inline void populate_table_reg(const hv_x64_table_register *hv_seg,
+                                      SegmentCache *tbl)
+{
+    memset(tbl, 0, sizeof(SegmentCache));
+
+    tbl->base = hv_seg->base;
+    tbl->limit = hv_seg->limit;
+}
+
+static void populate_special_regs(const hv_register_assoc *assocs,
+                                  X86CPU *x86cpu)
+{
+    CPUX86State *env = &x86cpu->env;
+
+    populate_segment_reg(&assocs[0].value.segment, &env->segs[R_CS]);
+    populate_segment_reg(&assocs[1].value.segment, &env->segs[R_DS]);
+    populate_segment_reg(&assocs[2].value.segment, &env->segs[R_ES]);
+    populate_segment_reg(&assocs[3].value.segment, &env->segs[R_FS]);
+    populate_segment_reg(&assocs[4].value.segment, &env->segs[R_GS]);
+    populate_segment_reg(&assocs[5].value.segment, &env->segs[R_SS]);
+
+    populate_segment_reg(&assocs[6].value.segment, &env->tr);
+    populate_segment_reg(&assocs[7].value.segment, &env->ldt);
+
+    populate_table_reg(&assocs[8].value.table, &env->gdt);
+    populate_table_reg(&assocs[9].value.table, &env->idt);
+
+    env->cr[0] = assocs[10].value.reg64;
+    env->cr[2] = assocs[11].value.reg64;
+    env->cr[3] = assocs[12].value.reg64;
+    env->cr[4] = assocs[13].value.reg64;
+
+    cpu_set_apic_tpr(x86cpu->apic_state, assocs[14].value.reg64);
+    env->efer = assocs[15].value.reg64;
+    cpu_set_apic_base(x86cpu->apic_state, assocs[16].value.reg64);
+}
+
+
+int mshv_get_special_regs(CPUState *cpu)
+{
+    struct hv_register_assoc assocs[ARRAY_SIZE(SPECIAL_REGISTER_NAMES)];
+    int ret;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    size_t n_regs = ARRAY_SIZE(SPECIAL_REGISTER_NAMES);
+
+    for (size_t i = 0; i < n_regs; i++) {
+        assocs[i].name = SPECIAL_REGISTER_NAMES[i];
+    }
+    ret = get_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to get special registers");
+        return -errno;
+    }
+
+    populate_special_regs(assocs, x86cpu);
+    return 0;
+}
+
 int mshv_load_regs(CPUState *cpu)
 {
     int ret;
@@ -265,6 +363,12 @@ int mshv_load_regs(CPUState *cpu)
         return -1;
     }
 
+    ret = mshv_get_special_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to load special registers");
+        return -1;
+    }
+
     return 0;
 }
 
-- 
2.51.0


