Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE57C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukIR4-0006Je-3a; Fri, 08 Aug 2025 04:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukIR2-0006IU-Cg
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:26:44 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukIR0-0000z2-2B
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:26:44 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-af90fd52147so287411566b.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 01:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754641600; x=1755246400; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F7MnF48tkyi8ftEE3o79HV8m3sxNi/ax7oXpAjnZ1nI=;
 b=HnZ7fdf7nSzsbBwVKbwbuJ/ud9y0t35ljxy6jt55iP3ODnV/U07Y/0DPJLrItLsFox
 aycf26ejW7IyyRmO8nrm6rZKWie4sc2KkNFA10ldsonoFuf38GhaO0T6JD692bV9kk/z
 491Im5Uc9EzmndChr1zvZKqpTO+hINLh4bZ6Zz6KIAzjGCqDCMmq6ANyAas+zcpZelEm
 g5j77NQku4cCdzRve3612mZ//oWXo6kz8JOGyvCNEPnNodrZsvR+SP1fivz9LEWsMPIO
 CFLmrzixwRIm7Ecw5uO6A56nDAYx2CMaQgoocMdJeS2bhXYmLCRplgaIQDLkVp9gEA41
 /Log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754641600; x=1755246400;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7MnF48tkyi8ftEE3o79HV8m3sxNi/ax7oXpAjnZ1nI=;
 b=J4CnHwOHIyV99oITr07yRLgupNj8fdDWIqSZrnHsaYK9qXboKwb/P2RY2UKSxxu3Hq
 H9PpuEL4pJE95OZV9cRm3v9680cO9Qu+ygcAM1BYa1+mJuw2YaejQ51URR2Kv51lOTdq
 zZoa5goazQ59UdmZpY9zlMXKVmP0UvPXWBknMejpjRIB7wTsKU2NdPWoWjOmUB3xa3Aa
 X5sNl3+n71a3pj5TPNU2cvyZlylaconjwyFP5Ret43P/wOLvEQqwhzStC6RS/5qqVVqp
 Frn9tj/hJXuk+9hDoilaPNXfP6T31D4yPA2a9uPPbxHWnoKS4DsJi4BsTCWF4kRxUX5I
 A6Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiPyzEbC7mvIRCI29rdFFDJ6L7DLR7xiOD3Iynl9N+pbqRgn9/hHxIK9a+hmBIpNZ4Ct/pf45WNlxE@nongnu.org
X-Gm-Message-State: AOJu0YxjePAg4RueslBpsB3Yw1bjJoF56MXeg4kIGkUE99rjgAA3v2cQ
 xue2QpKlsuacgEQD90Cf+f2B8oQpXzhsmLypMEtUCzeny8vLuslj5rYl4eSytTKYOOw=
X-Gm-Gg: ASbGncs6oarl6ggITET2Q0Q+Ho6N8ZN/HCXfZWJyuEXrCenxBt6q0kWRGlGPFLZkDlZ
 QnJn3nrdjU42wrM6Y3eLRXtc1CxTVG5KL97VlTN2tkYdyQyYwrht5iDBpBfg27yhf2CjVaTbs+v
 gxWLoFS6CiY+35fIvx37e9dLg1jsj1ES4HRx2FvEr8Y6AkAXfdcJ4AdRY03V9iCmR3wHA+HeMeT
 GTLhWlNQ3kKuhZHsb5H8HTSeFNGvdQLH/KnYbjyd0SY3kut5PS8D8hXC4QHCm0aFYMsV9mWquEy
 nSay29IyOxJAfXaCMOVj9LDJ4fhGVzj8/5si0SJWw+MzvuTTK06AewdBX7Cb+4FxKtsFe++4u4f
 HBFoMlH+0ANDL4ii5XzzE0uhsLAfFW6fDohk0pyW9Ra3gDxvHOcbCSCafKtkiyzOd55psLOIA
X-Google-Smtp-Source: AGHT+IHbt7t4uXKPbRS1gB8grVinQYi36HM/i12e/oQYw9DTxmcFUAjrBV0J+9wwawzjJQoR/TL2Hg==
X-Received: by 2002:a17:907:968f:b0:ae0:ab3f:36b5 with SMTP id
 a640c23a62f3a-af9c63754e6mr178808766b.4.1754641599908; 
 Fri, 08 Aug 2025 01:26:39 -0700 (PDT)
Received: from meli-email.org (athedsl-4440194.home.otenet.gr.
 [79.129.176.114]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a0a3b77sm1453714966b.51.2025.08.08.01.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 01:26:39 -0700 (PDT)
Date: Fri, 08 Aug 2025 11:14:27 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 1/9] contrib/plugins/uftrace: skeleton file
User-Agent: meli/0.8.12
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-2-pierrick.bouvier@linaro.org>
In-Reply-To: <20250808020702.410109-2-pierrick.bouvier@linaro.org>
Message-ID: <t0o24e.37nl0tbfod6ih@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
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
>We define a scoreboard that will hold our data per cpu. As well, we
>define a buffer per cpu that will be used to read registers and memories
>in a thread-safe way.
>
>For now, we just instrument all instructions with an empty callback.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---
> contrib/plugins/uftrace.c   | 74 +++++++++++++++++++++++++++++++++++++
> contrib/plugins/meson.build |  3 +-
> 2 files changed, 76 insertions(+), 1 deletion(-)
> create mode 100644 contrib/plugins/uftrace.c
>
>diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>new file mode 100644
>index 00000000000..d60c1077496
>--- /dev/null
>+++ b/contrib/plugins/uftrace.c
>@@ -0,0 +1,74 @@
>+/*
>+ * Copyright (C) 2025, Pierrick Bouvier <pierrick.bouvier@linaro.org>
>+ *
>+ * Generates a trace compatible with uftrace (similar to uftrace record).
>+ * https://github.com/namhyung/uftrace
>+ *
>+ * See docs/about/emulation.rst|Uftrace for details and examples.
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later
>+ */
>+
>+#include <qemu-plugin.h>
>+#include <glib.h>
>+
>+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>+
>+typedef struct Cpu {
>+    GByteArray *buf;
>+} Cpu;
>+
>+static struct qemu_plugin_scoreboard *score;
>+
>+static void track_callstack(unsigned int cpu_index, void *udata)
>+{
>+}
>+
>+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>+{
>+    size_t n_insns = qemu_plugin_tb_n_insns(tb);
>+
>+    for (int i = 0; i < n_insns; i++) {

s/int i/size_t i/

>+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);

This can return NULL,

>+
>+        uintptr_t pc = qemu_plugin_insn_vaddr(insn);

And this would lead to a NULL dereference (it performs insn->vaddr 
access)

>+        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
>+                QEMU_PLUGIN_CB_R_REGS,
>+                (void *) pc);

Hm indentation got broken here, should be 


+        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
+                                               QEMU_PLUGIN_CB_R_REGS,
+                                               (void *)pc);

>+
>+    }
>+}
>+
>+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>+{
>+    Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>+    cpu->buf = g_byte_array_new();
>+}
>+
>+static void vcpu_end(unsigned int vcpu_index)
>+{
>+    Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>+    g_byte_array_free(cpu->buf, true);
>+    memset(cpu, 0, sizeof(Cpu));

Nitpick, cpu->buf = NULL; is easier to understand (suggestion)

>+}
>+
>+static void at_exit(qemu_plugin_id_t id, void *data)
>+{
>+    for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
>+        vcpu_end(i);
>+    }
>+
>+    qemu_plugin_scoreboard_free(score);
>+}
>+
>+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>+                                           const qemu_info_t *info,
>+                                           int argc, char **argv)
>+{
>+    score = qemu_plugin_scoreboard_new(sizeof(Cpu));
>+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>+    qemu_plugin_register_atexit_cb(id, at_exit, NULL);
>+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>+
>+    return 0;
>+}
>diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>index 1876bc78438..7eb3629c95d 100644
>--- a/contrib/plugins/meson.build
>+++ b/contrib/plugins/meson.build
>@@ -1,5 +1,6 @@
> contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
>-                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger']
>+                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
>+                   'uftrace']
> if host_os != 'windows'
>   # lockstep uses socket.h
>   contrib_plugins += 'lockstep'
>-- 
>2.47.2
>

If no other comments rise for this patch, you can add my r-b after 
fixing the NULL check:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

