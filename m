Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E72ACCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 13:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBYnw-0005ZM-Ms; Wed, 22 Oct 2025 09:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vBYnq-0005Yj-UZ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 09:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vBYnl-0005bw-Qt
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 09:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761139371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NNQNqxq5bVrFUHowZoIoQEwT/bvzcdn+gMhvpD8sfgQ=;
 b=U0Q+Wp4F8xxIKDR26gfmXz3zrd3qo96DiBjk1UdQA4D6HPtnoEpj0QtoEnA+JitY6HP0tl
 ShIbDK1nGYT8NQ/YYZn6GKwKdduviTZOnQerXG9n/Om83KtU27MLPJ0OjcII2EPaOn8OFJ
 JDtRqXtEXR0BrHxZW+4lWe454tlZNBA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-7rrb-Q6vPIyTL6DbqlGIkA-1; Wed, 22 Oct 2025 09:22:49 -0400
X-MC-Unique: 7rrb-Q6vPIyTL6DbqlGIkA-1
X-Mimecast-MFC-AGG-ID: 7rrb-Q6vPIyTL6DbqlGIkA_1761139368
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-88f7eff9d5fso1188696385a.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 06:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761139368; x=1761744168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNQNqxq5bVrFUHowZoIoQEwT/bvzcdn+gMhvpD8sfgQ=;
 b=PJzDSnOWbkrockKHSwKBUvg/tW61PLyuCslOGp+O53XvkrWKDdlFJQd4fUOLReITc2
 tW0SuMEijWZVXEGXFolM6DyJNbnfn3PmNynPVHh0LuE0/rsIZKvCa4h0Q1m0xlMf+yTK
 8dxOA/dq34HVAIfWDMb7H45gK37+tweqa9PzahknqV9pA4CMWbaWbCgIQM8fnIdM5ZHa
 rRRV0c3GLy+RU0RKwYncWBUUKKvwwU7H0twBN+ydq7MZVDqXoJ2wAWIo9ukYzoGR9fMp
 Ygrc4UFDCafG0j56lbCdMalU69UH61ogi8789125HpuzHulvK+p6kqQkJ1A4h8+eShyH
 k6TA==
X-Gm-Message-State: AOJu0Yz2+gqZYCi9lWGSd1vdjUOpkQt5G4g/Ftn/Kg3HxSKz5AFNhZpc
 vyWBWTM4q3unopkwJPjdR4dGPa8wEXhJmHssVofwJ1xdhtApwAiuAl2hk1GslddoDYRR3u4kB1b
 dIEYGJBcsrAyypVG8rXGMlrrF1cCx544l0wX/wR0tkx2lY3iWOhhexV4L
X-Gm-Gg: ASbGncsMaTaLbInPbKD6VL+7tr0zOhGHdOe4ilh8YxRumZyBmHx6DpGqQVmfCiGNVBS
 jgm6WUQouzfMxtfyLp8WU73fd6PwFSo33Gya/SDV8YRRVVELz45Y6QYayDMP6PL8rFR8pPDZfsL
 SGj/THugbjeB+o6LuQnVJv38ijflv3/73a1iCa5XqL6bp/TFnZV+XY5xiHQvfzJUOfcn2FdwXR3
 E3JXMcL351ZvBuP8yKjSb3SSKjhZj/SvNlVQ2Zig6qC60YHHhIkXRFr48NQJLpZyrv7v0sf1jr5
 7faS+pc9Ny7pTFTBfj1H3M4ggif9T1MwDiEebR6rf39Gl6tyBODyJPa4jDRuWlLlm5wQb+Wtn4N
 Fo6w=
X-Received: by 2002:a05:620a:29d3:b0:88f:c0e1:ec2 with SMTP id
 af79cd13be357-890707f9b52mr2677931085a.60.1761139368456; 
 Wed, 22 Oct 2025 06:22:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUfPQwMW7ugMaV3OJfIP6t4ROWbJuzmZq/sb85k1vlpfegJlZShRsXcBDNp90dPQLVklPR7Q==
X-Received: by 2002:a05:620a:29d3:b0:88f:c0e1:ec2 with SMTP id
 af79cd13be357-890707f9b52mr2677872485a.60.1761139361211; 
 Wed, 22 Oct 2025 06:22:41 -0700 (PDT)
Received: from leonardi-redhat ([151.29.47.252])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cd098328sm976862585a.17.2025.10.22.06.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 06:22:40 -0700 (PDT)
Date: Wed, 22 Oct 2025 15:22:37 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: Re: [PATCH v4 4/5] igvm: add support for initial register state load
 in native mode
Message-ID: <ijrybqltievczxvugi4hhnftqqeg42o6vshhnirrz2ugeotplf@cq62mc5seswc>
References: <20251022084439.242476-1-kraxel@redhat.com>
 <20251022084439.242476-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251022084439.242476-5-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Oct 22, 2025 at 10:44:38AM +0200, Gerd Hoffmann wrote:
>Add IgvmNativeVpContextX64 struct holding the register state (see igvm
>spec), and the qigvm_x86_load_context() function to load the register
>state.
>
>Wire up using two new functions: qigvm_x86_set_vp_context() is called
>from igvm file handling code and stores the boot processor context.
>qigvm_x86_bsp_reset() is called from i386 target cpu reset code and
>loads the context into the cpu registers.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> include/system/igvm.h |   2 +
> target/i386/cpu.h     |   3 +
> backends/igvm.c       |  30 +++++-----
> stubs/igvm.c          |   5 ++
> target/i386/cpu.c     |   6 ++
> target/i386/igvm.c    | 134 ++++++++++++++++++++++++++++++++++++++++++
> 6 files changed, 165 insertions(+), 15 deletions(-)
>
>diff --git a/include/system/igvm.h b/include/system/igvm.h
>index 3f72a40b8897..48ce20604259 100644
>--- a/include/system/igvm.h
>+++ b/include/system/igvm.h
>@@ -23,5 +23,7 @@ int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
> int qigvm_x86_get_mem_map_entry(int index,
>                                 ConfidentialGuestMemoryMapEntry *entry,
>                                 Error **errp);
>+int qigvm_x86_set_vp_context(void *data, int index,
>+                             Error **errp);
>
> #endif
>diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>index ce948861a765..78d4b427c67a 100644
>--- a/target/i386/cpu.h
>+++ b/target/i386/cpu.h
>@@ -2867,6 +2867,9 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, int flags);
>
> #endif
>
>+/* igvm.c */
>+void qigvm_x86_bsp_reset(CPUX86State *env);
>+
> /* cpu.c */
> bool cpu_is_bsp(X86CPU *cpu);
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 2ab7a9d96565..905bd8d98994 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -432,18 +432,6 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
>         return 0;
>     }
>
>-    /*
>-     * A confidential guest support object must be provided for setting
>-     * a VP context.
>-     */
>-    if (!ctx->cgs) {
>-        error_setg(
>-            errp,
>-            "A VP context is present in the IGVM file but is not supported "
>-            "by the current system.");
>-        return -1;
>-    }
>-
>     data_handle = igvm_get_header_data(ctx->file, IGVM_HEADER_SECTION_DIRECTIVE,
>                                        ctx->current_header_index);
>     if (data_handle < 0) {
>@@ -453,9 +441,21 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
>     }
>
>     data = (uint8_t *)igvm_get_buffer(ctx->file, data_handle);
>-    result = ctx->cgsc->set_guest_state(
>-        vp_context->gpa, data, igvm_get_buffer_size(ctx->file, data_handle),
>-        CGS_PAGE_TYPE_VMSA, vp_context->vp_index, errp);
>+
>+    if (ctx->cgs) {
>+        result = ctx->cgsc->set_guest_state(
>+            vp_context->gpa, data, igvm_get_buffer_size(ctx->file, data_handle),
>+            CGS_PAGE_TYPE_VMSA, vp_context->vp_index, errp);
>+    } else if (target_arch() == SYS_EMU_TARGET_X86_64) {
>+        result = qigvm_x86_set_vp_context(data, vp_context->vp_index, errp);
>+    } else {
>+        error_setg(
>+            errp,
>+            "A VP context is present in the IGVM file but is not supported "
>+            "by the current system.");
>+        result = -1;
>+    }
>+
>     igvm_free_buffer(ctx->file, data_handle);
>     if (result < 0) {
>         return result;
>diff --git a/stubs/igvm.c b/stubs/igvm.c
>index c32058eb2a6e..17cd1e903e35 100644
>--- a/stubs/igvm.c
>+++ b/stubs/igvm.c
>@@ -19,3 +19,8 @@ int qigvm_x86_get_mem_map_entry(int index,
> {
>     return -1;
> }
>+
>+int qigvm_x86_set_vp_context(void *data, int index, Error **errp)
>+{
>+    return -1;
>+}
>diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>index 455caff6b230..e00936e4b542 100644
>--- a/target/i386/cpu.c
>+++ b/target/i386/cpu.c
>@@ -8770,6 +8770,12 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
>
>     cs->halted = !cpu_is_bsp(cpu);
>
>+#if defined(CONFIG_IGVM)
>+    if (cpu_is_bsp(cpu)) {
>+        qigvm_x86_bsp_reset(env);
>+    }
>+#endif
>+
>     if (kvm_enabled()) {
>         kvm_arch_reset_vcpu(cpu);
>     }
>diff --git a/target/i386/igvm.c b/target/i386/igvm.c
>index 2ed6cd052c79..457c253b030c 100644
>--- a/target/i386/igvm.c
>+++ b/target/i386/igvm.c
>@@ -11,9 +11,115 @@
>
> #include "qemu/osdep.h"
>
>+#include "cpu.h"
> #include "hw/i386/e820_memory_layout.h"
> #include "system/igvm.h"
>
>+struct IgvmNativeVpContextX64 {
>+    uint64_t rax;
>+    uint64_t rcx;
>+    uint64_t rdx;
>+    uint64_t rbx;
>+    uint64_t rsp;
>+    uint64_t rbp;
>+    uint64_t rsi;
>+    uint64_t rdi;
>+    uint64_t r8;
>+    uint64_t r9;
>+    uint64_t r10;
>+    uint64_t r11;
>+    uint64_t r12;
>+    uint64_t r13;
>+    uint64_t r14;
>+    uint64_t r15;
>+    uint64_t rip;
>+    uint64_t rflags;
>+    uint64_t idtr_base;
>+    uint16_t idtr_limit;
>+    uint16_t reserved[2];
>+    uint16_t gdtr_limit;
>+    uint64_t gdtr_base;
>+
>+    uint16_t code_selector;
>+    uint16_t code_attributes;
>+    uint32_t code_base;
>+    uint32_t code_limit;
>+
>+    uint16_t data_selector;
>+    uint16_t data_attributes;
>+    uint32_t data_base;
>+    uint32_t data_limit;
>+
>+    uint64_t gs_base;
>+    uint64_t cr0;
>+    uint64_t cr3;
>+    uint64_t cr4;
>+    uint64_t efer;
>+};
>+
>+#define FLAGS_TO_SEGCACHE(flags)                \
>+    (((unsigned int)flags) << 8)
>+
>+static void qigvm_x86_load_context(struct IgvmNativeVpContextX64 *context,
>+                                   CPUX86State *env)
>+{
>+    cpu_load_efer(env, context->efer);
>+    cpu_x86_update_cr4(env, context->cr4);
>+    cpu_x86_update_cr0(env, context->cr0);
>+    cpu_x86_update_cr3(env, context->cr3);
>+
>+    cpu_x86_load_seg_cache(
>+        env, R_CS, context->code_selector,
>+        context->code_base, context->code_limit,
>+        FLAGS_TO_SEGCACHE(context->code_attributes));
>+    cpu_x86_load_seg_cache(
>+        env, R_DS, context->data_selector,
>+        context->data_base, context->data_limit,
>+        FLAGS_TO_SEGCACHE(context->data_attributes));
>+    cpu_x86_load_seg_cache(
>+        env, R_ES, context->data_selector,
>+        context->data_base, context->data_limit,
>+        FLAGS_TO_SEGCACHE(context->data_attributes));
>+    cpu_x86_load_seg_cache(
>+        env, R_FS, context->data_selector,
>+        context->data_base, context->data_limit,
>+        FLAGS_TO_SEGCACHE(context->data_attributes));
>+    cpu_x86_load_seg_cache(
>+        env, R_GS, context->data_selector,
>+        context->data_base, context->data_limit,
>+        FLAGS_TO_SEGCACHE(context->data_attributes));
>+    cpu_x86_load_seg_cache(
>+        env, R_SS, context->data_selector,
>+        context->data_base, context->data_limit,
>+        FLAGS_TO_SEGCACHE(context->data_attributes));

IIUC `R_TR` and `R_LDTR` are used by HVF in QEMU. Is there a reason why 
you didn't add them here?

Rest LGTM!

Thanks,
Luigi


