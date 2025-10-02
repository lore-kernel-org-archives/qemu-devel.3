Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A6ECAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mvq-0001FJ-PB; Thu, 02 Oct 2025 13:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvF-0000vk-PY
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Muz-0005nx-Kz
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hORXZXs3nBLx9w7TUsCj+3ttCe8oEF72vZas/IkNe60=;
 b=b2GC2cLSNFVmmjo8wYTJ18sQRmXXBWxKqJyv2PL5fKRvCTcvZJWHMzXPXd9/zadxaVutL1
 9xv7Yhe2ddPpmAhnMlDYLXlLFm2ZFvgS1g4ImZVMr/pKCgkXvEBpS1uw1xIM+7jTVpgb0I
 Vs8P9QwnYC8w369FhaAIz9Yk7vvYs8w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-6mn5IeelNWmUb7JquMQkRQ-1; Thu, 02 Oct 2025 13:16:22 -0400
X-MC-Unique: 6mn5IeelNWmUb7JquMQkRQ-1
X-Mimecast-MFC-AGG-ID: 6mn5IeelNWmUb7JquMQkRQ_1759425381
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b3d6645acd3so126604066b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425379; x=1760030179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hORXZXs3nBLx9w7TUsCj+3ttCe8oEF72vZas/IkNe60=;
 b=m2ENHK/RuJT0KoDgXha6MuokMqlQLACz+MFrBb6doONpA+pg/aT+EGC9gLvMFUNypO
 f6ChF8QfbAMzaKHFjmmyOQtk8TvOu+TGhNcBxNTqLnwfw20bRRsllAsOozjr9YPiRkOK
 R3Q+1Aucct5SQ+Zio7Ye3Q5vmiXxtYVjmEIR31KoaEZgWfDWGw4GfYqwniv2G+GTc41Y
 ocxROPjPjpBrLCQbb1HEH4PSqyZHgFVVvkAFY/jRWUDvAycxQcuRyiL7ZUaVAZOonjqD
 +5qo/GZxMW3ve89ul7JzvyY3fqAdFFvYsKBRYylrOQ4bG8BQx7gZ24xDccI+ORyxL8e3
 QVKw==
X-Gm-Message-State: AOJu0Yz2h5IW1Gh6FY4+2ZJB7ShGZi9mrowFpDnF203w2t00mfdj3bVT
 DGUer1fYmlpctg2BR5WY0YDp/vSCq1w0z/Pm2DjF/WMvijkrcV6Feo1f9y96aW2GBYnG2yr3nTt
 PlLeJKA27b2xZHPt3GT01MU4sFPuT5xjyl5V8TmofvC9j9ZuO1uEkc3yvcHFd78hl37DMm6qbwa
 yLYA1qbBrE12xX35231UjQpGBII7TO4y4p5f2PxSQJ
X-Gm-Gg: ASbGncse9lQ2sWZmSndHeCdqvGqNx/nTPWOQgbIqXzZH8rt6gfL03rTKhOsu97VvD+u
 20BwHQB/0pXqD+oIH7NBLXTxc5MU5CubMKc9XpXKv84PUlS6onWBvAJEAx91Xyxe8UK8px6s92S
 Bv0wxh8jx6xzsDVFosf1JPO1PvUPGt9j4GNrEPX9bFC5CDyMn/7Q0WWOOxWtzzdCAtgfKqQ1wKy
 qQUXwOZxyx7vpWJRS/C+9oYYO6AvtTr/H6FUVcZL1G5fFOdHoVP2RCZEgU9AKEeLgdg93A9EA07
 aYqyu1IjC54KMq042iCX/oY4OWYHb4k2v2K8v7um4lG74Oun2UyoHAO1qDwLAubQqMbNOfElb0Z
 DhHy9scubI6ivp7/fISAvv9/njk7gJIodEMoEyDaij5uFSx1e
X-Received: by 2002:a17:907:3d91:b0:b2a:10a3:7113 with SMTP id
 a640c23a62f3a-b49c1f54862mr25208266b.29.1759425379118; 
 Thu, 02 Oct 2025 10:16:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB8PPLEgViWFT5XQrpZMjJa8vdl+h8E9PQkRGU6Njqkev9ycnaA05WKMjpyc7bViU9yDCXug==
X-Received: by 2002:a17:907:3d91:b0:b2a:10a3:7113 with SMTP id
 a640c23a62f3a-b49c1f54862mr25203366b.29.1759425378555; 
 Thu, 02 Oct 2025 10:16:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b486970b32bsm249142966b.50.2025.10.02.10.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 14/27] target/i386/mshv: Implement mshv_get_standard_regs()
Date: Thu,  2 Oct 2025 19:15:23 +0200
Message-ID: <20251002171536.1460049-15-pbonzini@redhat.com>
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

Fetch standard register state from MSHV vCPUs to support debugging,
migration, and other introspection features in QEMU.

Fetch standard register state from a MHSV vCPU's. A generic get_regs()
function and a mapper to map the different register representations are
introduced.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-15-magnuskulke@linux.microsoft.com
[mshv.h/mshv_int.h split. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   |   1 +
 target/i386/mshv/mshv-cpu.c | 116 +++++++++++++++++++++++++++++++++++-
 2 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 731841af929..b0a79296ad9 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -58,6 +58,7 @@ typedef enum MshvVmExit {
 void mshv_init_mmio_emu(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
+int mshv_get_standard_regs(CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_load_regs(CPUState *cpu);
 int mshv_store_regs(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 9ead03ca2d8..4e3eee113bb 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -96,6 +96,66 @@ int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
     return 0;
 }
 
+static int get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
+                            size_t n_regs)
+{
+    int cpu_fd = mshv_vcpufd(cpu);
+    int vp_index = cpu->cpu_index;
+    hv_input_get_vp_registers *in;
+    hv_register_value *values;
+    size_t in_sz, names_sz, values_sz;
+    int i, ret;
+    struct mshv_root_hvcall args = {0};
+
+    /* find out the size of the struct w/ a flexible array at the tail */
+    names_sz = n_regs * sizeof(hv_register_name);
+    in_sz = sizeof(hv_input_get_vp_registers) + names_sz;
+
+    /* fill the input struct */
+    in = g_malloc0(in_sz);
+    in->vp_index = vp_index;
+    for (i = 0; i < n_regs; i++) {
+        in->names[i] = assocs[i].name;
+    }
+
+    /* allocate value output buffer */
+    values_sz = n_regs * sizeof(union hv_register_value);
+    values = g_malloc0(values_sz);
+
+    /* create the hvcall envelope */
+    args.code = HVCALL_GET_VP_REGISTERS;
+    args.in_sz = in_sz;
+    args.in_ptr = (uint64_t) in;
+    args.out_sz = values_sz;
+    args.out_ptr = (uint64_t) values;
+    args.reps = (uint16_t) n_regs;
+
+    /* perform the call */
+    ret = mshv_hvcall(cpu_fd, &args);
+    g_free(in);
+    if (ret < 0) {
+        g_free(values);
+        error_report("Failed to retrieve registers");
+        return -1;
+    }
+
+    /* assert we got all registers */
+    if (args.reps != n_regs) {
+        g_free(values);
+        error_report("Failed to retrieve registers: expected %zu elements"
+                     ", got %u", n_regs, args.reps);
+        return -1;
+    }
+
+    /* copy values into assoc */
+    for (i = 0; i < n_regs; i++) {
+        assocs[i].value = values[i];
+    }
+    g_free(values);
+
+    return 0;
+}
+
 static int set_standard_regs(const CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
@@ -149,11 +209,63 @@ int mshv_store_regs(CPUState *cpu)
     return 0;
 }
 
+static void populate_standard_regs(const hv_register_assoc *assocs,
+                                   CPUX86State *env)
+{
+    env->regs[R_EAX] = assocs[0].value.reg64;
+    env->regs[R_EBX] = assocs[1].value.reg64;
+    env->regs[R_ECX] = assocs[2].value.reg64;
+    env->regs[R_EDX] = assocs[3].value.reg64;
+    env->regs[R_ESI] = assocs[4].value.reg64;
+    env->regs[R_EDI] = assocs[5].value.reg64;
+    env->regs[R_ESP] = assocs[6].value.reg64;
+    env->regs[R_EBP] = assocs[7].value.reg64;
+    env->regs[R_R8]  = assocs[8].value.reg64;
+    env->regs[R_R9]  = assocs[9].value.reg64;
+    env->regs[R_R10] = assocs[10].value.reg64;
+    env->regs[R_R11] = assocs[11].value.reg64;
+    env->regs[R_R12] = assocs[12].value.reg64;
+    env->regs[R_R13] = assocs[13].value.reg64;
+    env->regs[R_R14] = assocs[14].value.reg64;
+    env->regs[R_R15] = assocs[15].value.reg64;
+
+    env->eip = assocs[16].value.reg64;
+    env->eflags = assocs[17].value.reg64;
+    rflags_to_lflags(env);
+}
+
+int mshv_get_standard_regs(CPUState *cpu)
+{
+    struct hv_register_assoc assocs[ARRAY_SIZE(STANDARD_REGISTER_NAMES)];
+    int ret;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    size_t n_regs = ARRAY_SIZE(STANDARD_REGISTER_NAMES);
+
+    for (size_t i = 0; i < n_regs; i++) {
+        assocs[i].name = STANDARD_REGISTER_NAMES[i];
+    }
+    ret = get_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to get standard registers");
+        return -1;
+    }
+
+    populate_standard_regs(assocs, env);
+    return 0;
+}
 
 int mshv_load_regs(CPUState *cpu)
 {
-    error_report("unimplemented");
-    abort();
+    int ret;
+
+    ret = mshv_get_standard_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to load standard registers");
+        return -1;
+    }
+
+    return 0;
 }
 
 int mshv_arch_put_registers(const CPUState *cpu)
-- 
2.51.0


