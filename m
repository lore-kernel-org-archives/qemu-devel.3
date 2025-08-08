Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE89C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukIlJ-0003bO-Bt; Fri, 08 Aug 2025 04:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukIlG-0003aI-3I
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:47:38 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukIl4-0003my-7l
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:47:29 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-458aee6e86aso11461445e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 01:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754642842; x=1755247642; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zXwNKmnko2/AYlR9DsU3B2PeYMyf9/XW40u2WUn77cE=;
 b=S4Gv87woLA7iKMwQm4XVlSF9Y+W8xWwOdoQG6JZ2mnGnG2LXnP3yxN7d6ixAqeSKTP
 w2y9e1pfAD/QDPI0FAW1FwCcmW9Jryu6OPCutGwbAcV5u33fMNgClm2EG4TJSskHuoDo
 rItwmTGu3tS6R9Gzc2bWg7RTVSOE3lR01BfLZSXXeDlLWeOlAcEWeF3tBpIoj8od6RNX
 Zk+KQ8Y0gxSRmAypbqls9Yhq0pF1sVIf3eAsIqqrBgpboWDguDE7zdNY10NM2zBWsgF9
 /SdHnrClrY56LK1YwTzg2Xzwaral5acD6wFq8NZPfrtQpcdiEa6whGQzXUberELJGHSA
 WZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754642842; x=1755247642;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXwNKmnko2/AYlR9DsU3B2PeYMyf9/XW40u2WUn77cE=;
 b=AOe5I0NDNplxlr3PYkI6lb2+7sjtTTbF4uNSwlHbYs+RvM48NCIkanB2xszDYhSEnu
 ARnOl4sV8NauXakim6nvcgm9phYJBV9kCZbgtDsuhGGMq1fQWssaSM7CHBY94JdPoiPY
 WVMPOLNTOQBZbt+4LfDU7GHGU1p0YhuJ3km3CNnnyLjB4ZPVkocWIqAaBoFhU+8LmQfG
 oIkgpBZh3epuND4JyGBcZxnvZZ5gWvGdNPUGfy1bWdOZOobkVtRdqBiFnwfIInaX73+B
 sEPDN9rjqJiW745jnr3qeKFUviT1Na5jwGDEINMDqk4vFLTOKq8yA5HZpl9b2QL/3wDb
 jJrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3GJHb8nCRSI9qQ+E2JJQsc55V/JhG2RHQ/GoggisSeliZWA4o/UgEjczvEznCdZ4tSg3p02Hh8oZ0@nongnu.org
X-Gm-Message-State: AOJu0YzycavNnQstIELbv8mzQMZmcZmlbZ1QDcylohqZD7KZimFHuRTO
 eniSsszTrOhIKBhHr2YA4v3AKR50NKoJTGwNccoYmI4RrYmCEG8O8PWHWMCGMVDMYV0=
X-Gm-Gg: ASbGncsGAFCTiCIGjNvV8hiS/uBCZ+ugK2c2U4ZpcaMFQ503o5OE0v1seCz3fI8M2NW
 ljKuYfz3i4fM/NR+3usNmKPrlP7bcFBNyFDEQWocBcNVNfEyovSdsXuIchpPyjy5Jtq7jcMxkyi
 uMMV0SNwvVl7Q37iJIpZybruQYEnAioeRMeDCufodzJ1DbBA/tChDGI3PUyL4AYApnuJgf2g67L
 xs0ldcgc0P/ZQ/ZRE/xniVDDLylh/RyslvyHXsbQNhwUMzevXbIgULafdnArlSondkYvA+g44f0
 Hvy1Yj0RfolmAExvdh3oIr//IXBtbEX3LFP3UMxWNNw4RHNUELnVDrOoggmdNVz2pG4ZVeAiOyU
 KwP8ew3MGJ04pE9jemNUXYq5POOEUcVDWt1sViA7nOW+smlrdBJ0fhWvNPusAdGGqyicMYX/r
X-Google-Smtp-Source: AGHT+IFQXtuLqMeyGmRFVIPwvBegw7RbosSuY0m6miCV8N8GKrdT4ReIaI+g+8EB5gpFrn/r4hpQ4A==
X-Received: by 2002:a05:6000:40cc:b0:3b8:ffd1:136e with SMTP id
 ffacd0b85a97d-3b9008c7094mr1883287f8f.0.1754642841922; 
 Fri, 08 Aug 2025 01:47:21 -0700 (PDT)
Received: from meli-email.org (athedsl-4440194.home.otenet.gr.
 [79.129.176.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8fc28a830sm5066561f8f.16.2025.08.08.01.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 01:47:21 -0700 (PDT)
Date: Fri, 08 Aug 2025 11:28:16 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 2/9] contrib/plugins/uftrace: define cpu operations and
 implement aarch64
User-Agent: meli/0.8.12
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-3-pierrick.bouvier@linaro.org>
In-Reply-To: <20250808020702.410109-3-pierrick.bouvier@linaro.org>
Message-ID: <t0o32w.19lmgtfzlutzr@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>We define a new CpuOps structure that will be used to implement tracking
>independently of guest architecture.
>
>As well, we now instrument only instructions following ones that might
>have touch the frame pointer.

s/touch/touched

>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---
> contrib/plugins/uftrace.c | 112 ++++++++++++++++++++++++++++++++++++--
> 1 file changed, 108 insertions(+), 4 deletions(-)
>
>diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>index d60c1077496..4b1a2f38143 100644
>--- a/contrib/plugins/uftrace.c
>+++ b/contrib/plugins/uftrace.c
>@@ -11,14 +11,94 @@
> 
> #include <qemu-plugin.h>
> #include <glib.h>
>+#include <stdio.h>
> 
> QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> 
>+typedef struct Cpu Cpu;
>+
>+typedef struct {
>+    void (*init)(Cpu *cpu);
>+    void (*end)(Cpu *cpu);
>+    uint64_t (*get_frame_pointer)(Cpu *cpu);
>+    bool (*does_insn_modify_frame_pointer)(const char *disas);
>+} CpuOps;
>+
> typedef struct Cpu {
>     GByteArray *buf;
>+    CpuOps ops;
>+    void *arch;
> } Cpu;
> 
>+typedef struct {
>+    struct qemu_plugin_register *reg_fp;
>+} Aarch64Cpu;
>+
> static struct qemu_plugin_scoreboard *score;
>+static CpuOps arch_ops;
>+
>+static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
>+{
>+    GByteArray *buf = cpu->buf;
>+    g_byte_array_set_size(buf, 0);
>+    size_t sz = qemu_plugin_read_register(reg, buf);
>+    g_assert(sz == 8);
>+    g_assert(buf->len == 8);
>+    return *((uint64_t *) buf->data);
>+}
>+
>+static struct qemu_plugin_register *plugin_find_register(const char *name)
>+{
>+    g_autoptr(GArray) regs = qemu_plugin_get_registers();

Question about the plugin API and not this patch per se, if the cpu is 
in a32/thumb mode does it still return the aarch64 registers?

>+    for (int i = 0; i < regs->len; ++i) {
>+        qemu_plugin_reg_descriptor *reg;
>+        reg = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
>+        if (!strcmp(reg->name, name)) {
>+            return reg->handle;
>+        }
>+    }
>+    return NULL;
>+}
>+
>+static uint64_t aarch64_get_frame_pointer(Cpu *cpu_)
>+{
>+    Aarch64Cpu *cpu = cpu_->arch;
>+    return cpu_read_register64(cpu_, cpu->reg_fp);
>+}
>+
>+static void aarch64_init(Cpu *cpu_)
>+{
>+    Aarch64Cpu *cpu = g_new0(Aarch64Cpu, 1);
>+    cpu_->arch = cpu;
>+    cpu->reg_fp = plugin_find_register("x29");
>+    if (!cpu->reg_fp) {
>+        fprintf(stderr, "uftrace plugin: frame pointer register (x29) is not "
>+                        "available. Please use an AArch64 cpu (or -cpu max).\n");
>+        g_abort();
>+    }
>+}
>+
>+static void aarch64_end(Cpu *cpu)
>+{
>+    g_free(cpu->arch);
>+}
>+
>+static bool aarch64_does_insn_modify_frame_pointer(const char *disas)
>+{
>+    /*
>+     * Check if current instruction concerns fp register "x29".
>+     * We add a prefix space to make sure we don't match addresses dump
>+     * in disassembly.
>+     */
>+    return strstr(disas, " x29");

Hm is the whitespace before x29 guaranteed? Neat trick otherwise.

>+}
>+
>+static CpuOps aarch64_ops = {
>+    .init = aarch64_init,
>+    .end = aarch64_end,
>+    .get_frame_pointer = aarch64_get_frame_pointer,
>+    .does_insn_modify_frame_pointer = aarch64_does_insn_modify_frame_pointer,
>+};
> 
> static void track_callstack(unsigned int cpu_index, void *udata)
> {
>@@ -28,20 +108,36 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> {
>     size_t n_insns = qemu_plugin_tb_n_insns(tb);
> 
>+    /*
>+     * We instrument all instructions following one that might have updated
>+     * the frame pointer. We always instrument first instruction in block, as
>+     * last executed instruction, in previous tb, may have modified it.

Modified it how?

>+     */
>+    bool instrument_insn = true;
>     for (int i = 0; i < n_insns; i++) {
>         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> 
>-        uintptr_t pc = qemu_plugin_insn_vaddr(insn);
>-        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
>-                QEMU_PLUGIN_CB_R_REGS,
>-                (void *) pc);
>+        if (instrument_insn) {
>+            uintptr_t pc = qemu_plugin_insn_vaddr(insn);
>+            qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
>+                                                   QEMU_PLUGIN_CB_R_REGS,
>+                                                   (void *) pc);
>+            instrument_insn = false;
>+        }
> 
>+        char *disas = qemu_plugin_insn_disas(insn);
>+        if (arch_ops.does_insn_modify_frame_pointer(disas)) {
>+            instrument_insn = true;
>+        }

So if I understand correctly you check if an instruction needs to be 
instrumented and then do it in the next forloop. This means if the last 
insn needs to be instrumented too it is not done, is that ok?

>     }
> }
> 
> static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
> {
>     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>+    cpu->ops = arch_ops;
>+
>+    cpu->ops.init(cpu);
>     cpu->buf = g_byte_array_new();
> }
> 
>@@ -65,6 +161,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                            const qemu_info_t *info,
>                                            int argc, char **argv)
> {
>+    if (!strcmp(info->target_name, "aarch64")) {
>+        arch_ops = aarch64_ops;
>+    } else {
>+        fprintf(stderr, "plugin uftrace: %s target is not supported\n",
>+                info->target_name);
>+        return 1;
>+    }
>+
>     score = qemu_plugin_scoreboard_new(sizeof(Cpu));
>     qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>     qemu_plugin_register_atexit_cb(id, at_exit, NULL);
>-- 
>2.47.2
>

LGTM overall, it makes sense.

