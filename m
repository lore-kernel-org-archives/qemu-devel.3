Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B94BC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 09:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukJe4-0001fr-7p; Fri, 08 Aug 2025 05:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukJe2-0001f7-Me
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:44:14 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukJe0-00034J-TJ
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:44:14 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-af95b919093so294462166b.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754646251; x=1755251051; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l1+HnhaNBrcMVmfRMAv6DTbpFaIokMaqjl/qHmHLjPQ=;
 b=EGhb2CN29Da31wr4+NsmCn78NlyCcp0ILU/QauKh92uoGsXyYH/CuU4a75mkhYMmu7
 ZnFcC52n6Bc7B/MTk66mbYhzGSeRWadFrAfS0173yd2jTmMf/vAEUgorIpR1PJAE5I6r
 BCtKhQi/HNveFNca88/c4SSG3ZJltD+VRmAWtxl+nPMziWiYDowXMAzyCIeV9Oi8kn0q
 qX29NB9tcfqFVNABzTtk/r97MAUg+NoOk5X1iw6D5h+Ve+lD5bftXJofeO8jz2K/Kfn4
 iY987yglRgD1A45hjmBdP4OmPQ9cAABmeZkSIBP15lujTEqaNN/JBo8V2E8iv7t7g+1D
 l92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754646251; x=1755251051;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1+HnhaNBrcMVmfRMAv6DTbpFaIokMaqjl/qHmHLjPQ=;
 b=b657CW0bl5QvkWoBPXIdzHgNAlUeBKwgF4vIxV/Ur259iIiTuDkkOZuIvKGSVgtNGs
 1G1kEEdNB40ef5aci4Ln1H5NMaAv5IdnjgahtUO7XKEItvMVonIG5VqP8Gw6T3bQXq+q
 Mqgpg2ZRp/LOHp7rzoJTr110rfzETzh8szbUdR4hKd3TI3zwp9RO8GAh5ZtCwfPexRIP
 8rNNsyZwh2Mi96pU9u94n/bDybHR+6XVFH0D8mzdsA0cOHKwl12H/LwFbo0JKAuTcBcj
 OTQ3NO0e5V23oIbBkKpv2lhRmkEsttE9qZyPEAOgrd8jOORn40rfeUc/SY22qXpcHcd9
 yAgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrFlgKA72uXtbyz7LKpJUlog/ZxDl5HpY3XIUd7hEYCusGLYtzyPCrax6vUutOP9cmb1Ith3Cc25cL@nongnu.org
X-Gm-Message-State: AOJu0YxwLn+/ysWkqJZoN7Gu/Z8rpo7CTVx/xmpfYJ2qbUul+6uDxcfW
 IuwACwdulLvfjONzR9EhDYVyiCiij8J2VFwNGVm4gHzId//DyWtYmicefCmLjuhaG7w=
X-Gm-Gg: ASbGncuU9PD4Ho5P84SB/3mVrN4CtGbXpjBD3F9kCX3zmmVn8jx08hNxFu+t51BA2Wt
 /qaWHos5ga55uI/UQSXeWgVBslEEfvxzJGG8nBRuF5EjarxxlfXA3S5NuvBB5V0HXjIpVDRW3GP
 FL33px44qNlA/P0PEq+agCnh+TEVn3tTc4160sxVoC5RL51RYPyI53iEcJjbgd0aLlNRICXfCPQ
 /2GegtMvdwX+YxxDgsj9nZhwsJfDjE6D2QB6vB1Qas/29sS3BbufBWq9YCi0HU9WXVJNsZmB16s
 2M+iYu5JiZkvHrKHhIczhghGp9ukw0p2/JdQjDbAwJj+QaG++twiP91giCP0kwtqOyveOOZZNKs
 VXnheMPIGtfaIwJAsNjEe0RoQn72BMEZ9cVNznI6gTKpNIm5z8IRH9KoE9YJ9I2ptML7/zXUl
X-Google-Smtp-Source: AGHT+IHdayUIpcKPpbFk7ik2OZaVFKDtuJdsoFle0mrjh65cUtofjvecvQcizBJVaSPYHDJTjZTiOA==
X-Received: by 2002:a17:907:a4d:b0:ae3:74be:4998 with SMTP id
 a640c23a62f3a-af9c640dd23mr189830666b.11.1754646250533; 
 Fri, 08 Aug 2025 02:44:10 -0700 (PDT)
Received: from meli-email.org (athedsl-4440194.home.otenet.gr.
 [79.129.176.114]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af986a477c4sm616167466b.56.2025.08.08.02.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 02:44:10 -0700 (PDT)
Date: Fri, 08 Aug 2025 12:42:38 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 7/9] contrib/plugins/uftrace: implement x64 support
User-Agent: meli/0.8.12
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-8-pierrick.bouvier@linaro.org>
In-Reply-To: <20250808020702.410109-8-pierrick.bouvier@linaro.org>
Message-ID: <t0o5pl.3rum11rfv1tyj@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62b.google.com
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

On Fri, 08 Aug 2025 05:07, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>It's trivial to implement x64 support, as it's the same stack layout
>than aarch64.

s/than/as

>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---
> contrib/plugins/uftrace.c | 85 +++++++++++++++++++++++++++++++++++++++
> 1 file changed, 85 insertions(+)
>
>diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>index 6628b4256fd..f10172eed10 100644
>--- a/contrib/plugins/uftrace.c
>+++ b/contrib/plugins/uftrace.c
>@@ -79,6 +79,20 @@ typedef struct {
>     struct qemu_plugin_register *reg_scr_el3;
> } Aarch64Cpu;
> 
>+typedef enum {
>+    X64_RING0,
>+    X64_RING1,
>+    X64_RING2,
>+    X64_RING3,
>+    X64_REAL_MODE,
>+} X64PrivilegeLevel;
>+
>+typedef struct {
>+    struct qemu_plugin_register *reg_rbp;
>+    struct qemu_plugin_register *reg_cs;
>+    struct qemu_plugin_register *reg_cr0;
>+} X64Cpu;
>+
> typedef struct {
>     uint64_t timestamp;
>     uint64_t data;
>@@ -565,6 +579,75 @@ static CpuOps aarch64_ops = {
>     .does_insn_modify_frame_pointer = aarch64_does_insn_modify_frame_pointer,
> };
> 
>+static uint8_t x64_num_privilege_levels(void)
>+{
>+    return X64_REAL_MODE + 1;
>+}
>+
>+static const char *x64_get_privilege_level_name(uint8_t pl)
>+{
>+    switch (pl) {
>+    case X64_RING0: return "Ring0";
>+    case X64_RING1: return "Ring1";
>+    case X64_RING2: return "Ring2";
>+    case X64_RING3: return "Ring3";
>+    case X64_REAL_MODE: return "RealMode";
>+    default:
>+        g_assert_not_reached();
>+    }
>+}
>+
>+static uint8_t x64_get_privilege_level(Cpu *cpu_)
>+{
>+    X64Cpu *cpu = cpu_->arch;
>+    uint64_t cr0 = cpu_read_register64(cpu_, cpu->reg_cr0);
>+    uint64_t protected_mode = (cr0 >> 0) & 0b1;
>+    if (!protected_mode) {
>+        return X64_REAL_MODE;
>+    }
>+    uint32_t cs = cpu_read_register32(cpu_, cpu->reg_cs);
>+    uint32_t ring_level = (cs >> 0) & 0b11;
>+    return ring_level;
>+}
>+
>+static uint64_t x64_get_frame_pointer(Cpu *cpu_)
>+{
>+    X64Cpu *cpu = cpu_->arch;
>+    return cpu_read_register64(cpu_, cpu->reg_rbp);
>+}
>+
>+static void x64_init(Cpu *cpu_)
>+{
>+    X64Cpu *cpu = g_new0(X64Cpu, 1);
>+    cpu_->arch = cpu;
>+    cpu->reg_rbp = plugin_find_register("rbp");
>+    g_assert(cpu->reg_rbp);
>+    cpu->reg_cs = plugin_find_register("cs");
>+    g_assert(cpu->reg_cs);
>+    cpu->reg_cr0 = plugin_find_register("cr0");
>+    g_assert(cpu->reg_cr0);
>+}
>+
>+static void x64_end(Cpu *cpu)
>+{
>+    g_free(cpu->arch);
>+}
>+
>+static bool x64_does_insn_modify_frame_pointer(const char *disas)
>+{
>+    return strstr(disas, "rbp");
>+}
>+
>+static CpuOps x64_ops = {
>+    .init = x64_init,
>+    .end = x64_end,
>+    .get_frame_pointer = x64_get_frame_pointer,
>+    .get_privilege_level = x64_get_privilege_level,
>+    .num_privilege_levels = x64_num_privilege_levels,
>+    .get_privilege_level_name = x64_get_privilege_level_name,
>+    .does_insn_modify_frame_pointer = x64_does_insn_modify_frame_pointer,
>+};
>+
> static void track_privilege_change(unsigned int cpu_index, void *udata)
> {
>     Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
>@@ -771,6 +854,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> 
>     if (!strcmp(info->target_name, "aarch64")) {
>         arch_ops = aarch64_ops;
>+    } else if (!strcmp(info->target_name, "x86_64")) {
>+        arch_ops = x64_ops;
>     } else {
>         fprintf(stderr, "plugin uftrace: %s target is not supported\n",
>                 info->target_name);
>-- 
>2.47.2
>

No idea about x86 assembly tbh but this looks correct to me.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

