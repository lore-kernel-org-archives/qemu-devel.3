Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE92CC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukQ5F-0001Y1-0l; Fri, 08 Aug 2025 12:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukQ5D-0001X5-4m
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:36:43 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukQ59-0004rX-I0
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:36:42 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-af91a6b7a06so415273266b.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754670997; x=1755275797; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4dBseBu3uyUdrnjiwdgQkYh8xs+kD8DMk0Vh6l1XLKE=;
 b=nvHSfCwZtLPECCJ4zdCE+QVOiQIBUaaoqo1CTk1O14clD3lOaY4vLtrmWi9t087/oT
 9rXh3WXe6/75jzPAkkDeJZ8Yk6FdDY9Ta91uQQXtB5xcTQD5zN0gkWmyI9xwfd85g+I9
 De85gL10YWsTL/YTu8r9OAuLPozTIORP2qmw2D4QsZsAIKZ6IHRXiyeSHyS0wCyJi/ss
 /lmhFx/XtLtUNd2zS25vpkKRB08xBnOOTHfIAI4WoMkz24H/LMdDlKZXXRz2nLMl1z0X
 XeQc4+98NDOCbQYgv0JaR5bU4i3rQVEITcdsFj6+1dNcTzn9Bs0MwEKPmCQ8O7M79knl
 GrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754670997; x=1755275797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4dBseBu3uyUdrnjiwdgQkYh8xs+kD8DMk0Vh6l1XLKE=;
 b=JL6stmeqgd/F6PNCkLT3HTuU/RTwt7xFivJi65z0VV54+Vtun/XlO3CCkwveoVAlro
 sJIUXZjcCYGwyq0Cz6SvLoHW3OqxB28WFHfXNhNr0axnNJpxdMzpIG+m5p/1VlyTt29k
 IzmOC4TATQcbpJIg1cH/2rz4OlHa4owzZycVsEMbfmfQ7hPYGY29KprEfHzn4udPYFip
 RmIW0CExduLkk4rmrgwNiiK9o8UkYAIZ5JY0w4l71pwpMlbGBQcXc7w/fPyEJ1v0s7fN
 M+1u5UwPo1skCvgK24IP9mHKjmylrJd4n26yq8ZnO9rOEMAtg2OHxH0dJcye9cX7MBfU
 PBHQ==
X-Gm-Message-State: AOJu0YxmDbiWYiZB3TNGVXdAzVUTWllt2+2ynmuP4gEeyzbeWanBBm6R
 a9ViSMNwLcjGWLbPkEbi1lBsr2CijQN94ETXRn96WVDqV/aw0EaRtfFl2u9AuL7ntgHU8/Qosnb
 +NG5UAiK27ITVGwnYK5TLxn4otTCw4xp9XLQKC7PxjQ==
X-Gm-Gg: ASbGncu4oayfWDPYHNcTlWAPTd96qxWI6LHwHHABax+ypkgH5r5mHtO0toj8nKR19Hh
 zOnmK4kvQPeT5kw+bnRbDOGCK7T4JWUjcsRIpWk4rO37rAkFZ1WidxDyfdMY+n4R0Zb8tYD2kq9
 NjANGl1wXco8t5pCHu7/CJgFxiRY+AVfQaz9o19NN6JG0G8ug1NUqybpjaLbld+ZRCvWwLzJ1Si
 oYM4tkt
X-Google-Smtp-Source: AGHT+IGDPXn1c0aGCdYKRHiBJq3hLJPowO941AhFjXirxrJMUTGJ5JQpPSf4Dc/ZDB9OUeP9k2C4MT6e32FAnTXg6iw=
X-Received: by 2002:a17:907:6ea5:b0:ae3:b654:165b with SMTP id
 a640c23a62f3a-af9c6370eb8mr342460766b.24.1754670997428; Fri, 08 Aug 2025
 09:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-3-pierrick.bouvier@linaro.org>
 <t0o32w.19lmgtfzlutzr@linaro.org>
 <55a99df1-616f-4ac5-8bd1-fd2b47755df4@linaro.org>
In-Reply-To: <55a99df1-616f-4ac5-8bd1-fd2b47755df4@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 8 Aug 2025 19:36:10 +0300
X-Gm-Features: Ac12FXzfIoyheUlkBvbXkVxT4nlbItN3awcVsFRBf-cfvUSrhuaROW0mPLWrNvI
Message-ID: <CAAjaMXahOCMcMeHxA9W7kVgZOvFizC=jhh0RhYpm_d6P777csA@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] contrib/plugins/uftrace: define cpu operations and
 implement aarch64
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud_=C3=A9?= <philmd@linaro.org>, 
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62e.google.com
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

On Fri, Aug 8, 2025 at 7:27=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 8/8/25 1:28 AM, Manos Pitsidianakis wrote:
> > On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.or=
g> wrote:
> >> We define a new CpuOps structure that will be used to implement tracki=
ng
> >> independently of guest architecture.
> >>
> >> As well, we now instrument only instructions following ones that might
> >> have touch the frame pointer.
> >
> > s/touch/touched
> >
> >>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >> ---
> >> contrib/plugins/uftrace.c | 112 ++++++++++++++++++++++++++++++++++++--
> >> 1 file changed, 108 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
> >> index d60c1077496..4b1a2f38143 100644
> >> --- a/contrib/plugins/uftrace.c
> >> +++ b/contrib/plugins/uftrace.c
> >> @@ -11,14 +11,94 @@
> >>
> >> #include <qemu-plugin.h>
> >> #include <glib.h>
> >> +#include <stdio.h>
> >>
> >> QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> >>
> >> +typedef struct Cpu Cpu;
> >> +
> >> +typedef struct {
> >> +    void (*init)(Cpu *cpu);
> >> +    void (*end)(Cpu *cpu);
> >> +    uint64_t (*get_frame_pointer)(Cpu *cpu);
> >> +    bool (*does_insn_modify_frame_pointer)(const char *disas);
> >> +} CpuOps;
> >> +
> >> typedef struct Cpu {
> >>      GByteArray *buf;
> >> +    CpuOps ops;
> >> +    void *arch;
> >> } Cpu;
> >>
> >> +typedef struct {
> >> +    struct qemu_plugin_register *reg_fp;
> >> +} Aarch64Cpu;
> >> +
> >> static struct qemu_plugin_scoreboard *score;
> >> +static CpuOps arch_ops;
> >> +
> >> +static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_regi=
ster *reg)
> >> +{
> >> +    GByteArray *buf =3D cpu->buf;
> >> +    g_byte_array_set_size(buf, 0);
> >> +    size_t sz =3D qemu_plugin_read_register(reg, buf);
> >> +    g_assert(sz =3D=3D 8);
> >> +    g_assert(buf->len =3D=3D 8);
> >> +    return *((uint64_t *) buf->data);
> >> +}
> >> +
> >> +static struct qemu_plugin_register *plugin_find_register(const char *=
name)
> >> +{
> >> +    g_autoptr(GArray) regs =3D qemu_plugin_get_registers();
> >
> > Question about the plugin API and not this patch per se, if the cpu is
> > in a32/thumb mode does it still return the aarch64 registers?
> >
>
> I didn't check this part, and it's a good question though.
> It would be a massive headache from plugins point of view if registers
> list could vary along execution.
>
> >> +    for (int i =3D 0; i < regs->len; ++i) {
> >> +        qemu_plugin_reg_descriptor *reg;
> >> +        reg =3D &g_array_index(regs, qemu_plugin_reg_descriptor, i);
> >> +        if (!strcmp(reg->name, name)) {
> >> +            return reg->handle;
> >> +        }
> >> +    }
> >> +    return NULL;
> >> +}
> >> +
> >> +static uint64_t aarch64_get_frame_pointer(Cpu *cpu_)
> >> +{
> >> +    Aarch64Cpu *cpu =3D cpu_->arch;
> >> +    return cpu_read_register64(cpu_, cpu->reg_fp);
> >> +}
> >> +
> >> +static void aarch64_init(Cpu *cpu_)
> >> +{
> >> +    Aarch64Cpu *cpu =3D g_new0(Aarch64Cpu, 1);
> >> +    cpu_->arch =3D cpu;
> >> +    cpu->reg_fp =3D plugin_find_register("x29");
> >> +    if (!cpu->reg_fp) {
> >> +        fprintf(stderr, "uftrace plugin: frame pointer register (x29)=
 is not "
> >> +                        "available. Please use an AArch64 cpu (or -cp=
u max).\n");
> >> +        g_abort();
> >> +    }
> >> +}
> >> +
> >> +static void aarch64_end(Cpu *cpu)
> >> +{
> >> +    g_free(cpu->arch);
> >> +}
> >> +
> >> +static bool aarch64_does_insn_modify_frame_pointer(const char *disas)
> >> +{
> >> +    /*
> >> +     * Check if current instruction concerns fp register "x29".
> >> +     * We add a prefix space to make sure we don't match addresses du=
mp
> >> +     * in disassembly.
> >> +     */
> >> +    return strstr(disas, " x29");
> >
> > Hm is the whitespace before x29 guaranteed? Neat trick otherwise.
> >
>
> At least for aarch64 disassembler, yes, from what I saw.
> Either it's the first operand, and then there is a whitespace between
> instruction name and it. Or it's another operand, and we always have a
> whitespace after ','.
> I don't think we'll change disassembler soon, but in case this looks too
> fragile, we can always simply return yes if x29 is fine. In worst case,
> we match some additional instructions, but it should not have a huge
> performance hit.
>
> >> +}
> >> +
> >> +static CpuOps aarch64_ops =3D {
> >> +    .init =3D aarch64_init,
> >> +    .end =3D aarch64_end,
> >> +    .get_frame_pointer =3D aarch64_get_frame_pointer,
> >> +    .does_insn_modify_frame_pointer =3D aarch64_does_insn_modify_fram=
e_pointer,
> >> +};
> >>
> >> static void track_callstack(unsigned int cpu_index, void *udata)
> >> {
> >> @@ -28,20 +108,36 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, st=
ruct qemu_plugin_tb *tb)
> >> {
> >>      size_t n_insns =3D qemu_plugin_tb_n_insns(tb);
> >>
> >> +    /*
> >> +     * We instrument all instructions following one that might have u=
pdated
> >> +     * the frame pointer. We always instrument first instruction in b=
lock, as
> >> +     * last executed instruction, in previous tb, may have modified i=
t.
> >
> > Modified it how?
> >
>
> I ran an assert that latest instruction of a block never contained "
> x29", and it was triggered quickly. I don't remember exactly which
> instruction triggered the assert.
>
> >> +     */
> >> +    bool instrument_insn =3D true;
> >>      for (int i =3D 0; i < n_insns; i++) {
> >>          struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb,=
 i);
> >>
> >> -        uintptr_t pc =3D qemu_plugin_insn_vaddr(insn);
> >> -        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
> >> -                QEMU_PLUGIN_CB_R_REGS,
> >> -                (void *) pc);
> >> +        if (instrument_insn) {
> >> +            uintptr_t pc =3D qemu_plugin_insn_vaddr(insn);
> >> +            qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callst=
ack,
> >> +                                                   QEMU_PLUGIN_CB_R_R=
EGS,
> >> +                                                   (void *) pc);
> >> +            instrument_insn =3D false;
> >> +        }
> >>
> >> +        char *disas =3D qemu_plugin_insn_disas(insn);
> >> +        if (arch_ops.does_insn_modify_frame_pointer(disas)) {
> >> +            instrument_insn =3D true;
> >> +        }
> >
> > So if I understand correctly you check if an instruction needs to be
> > instrumented and then do it in the next forloop. This means if the last
> > insn needs to be instrumented too it is not done, is that ok?
> >
>
> Yes, that is why we always instrument the first, to catch this.
> There is no (current) way to instrument *after* instruction, and
> probably hard to implement, considering an instruction might generate a
> fault. So the only safe choice left is to instrument the first one of
> any tb.
>

Fair enough, thanks for the explanation :)

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> >>      }
> >> }
> >>
> >> static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
> >> {
> >>      Cpu *cpu =3D qemu_plugin_scoreboard_find(score, vcpu_index);
> >> +    cpu->ops =3D arch_ops;
> >> +
> >> +    cpu->ops.init(cpu);
> >>      cpu->buf =3D g_byte_array_new();
> >> }
> >>
> >> @@ -65,6 +161,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_pl=
ugin_id_t id,
> >>                                             const qemu_info_t *info,
> >>                                             int argc, char **argv)
> >> {
> >> +    if (!strcmp(info->target_name, "aarch64")) {
> >> +        arch_ops =3D aarch64_ops;
> >> +    } else {
> >> +        fprintf(stderr, "plugin uftrace: %s target is not supported\n=
",
> >> +                info->target_name);
> >> +        return 1;
> >> +    }
> >> +
> >>      score =3D qemu_plugin_scoreboard_new(sizeof(Cpu));
> >>      qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
> >>      qemu_plugin_register_atexit_cb(id, at_exit, NULL);
> >> --
> >> 2.47.2
> >>
> >
> > LGTM overall, it makes sense.
>

