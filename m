Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE37C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukQ39-0006MQ-9x; Fri, 08 Aug 2025 12:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukQ36-00064D-2q
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:34:32 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukQ33-0004NV-Tb
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:34:31 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-617d24e7246so3123367a12.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754670868; x=1755275668; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JGQHR3LwlWFXqRVnBhF10osURSIlyt3G5Y4D5+vjC4=;
 b=gj3HpwqoCYPRLbQleq/HjzVp+LlfxoMmoYFzfBo/2zsM43MUHPUHEX0MuoltP4nozC
 kFMJ7gjdFNkzJs90dGekI/39+DS4QOpLaC813DrERsLJoXZbiJHOCH8srGkrkWQKnQQl
 UYzeODX0lirtUprwe4mHzA8wo+HfC24iiF6dfDO/ZrsGGQrZrEjKKMEevAe36i9S6B9Q
 0JPC+5egShPq9Gzb5Tee6OHQC4/WQyHRCoJKl62WaapsSX5WX46wxGWaalRtFxdGgEGc
 IzcOAS0+wLBqewuglacWbJWIJJQxuE5ByS75AfyzxhqIXejKHjqy6hc0FKK8RlHXXtgX
 Q05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754670868; x=1755275668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JGQHR3LwlWFXqRVnBhF10osURSIlyt3G5Y4D5+vjC4=;
 b=Z8ywsWVTbgfJ2y6ivScgubogzFofFaoMnMmOUumUKKD+SjO8PDG/pVURuIIn3aWkJM
 bioUIebn8kd3HOT7J/XEN2xXdp+6cLvmtNJWJOF//GhZSN6+yQC6zI+k422n3o/3yCuG
 pTqLM7NvpKqVmTbF7qa/q5xFVg/DL5ZcZK8KKaAHG1SBgXDQ2/H9dHYKUPMv8js6hjM4
 1DtD2P3EXnZEP130qRdaVccQorz64sz30UJ7j1DBoZwcNqBF6t7MEZspWlH0C63yFq2A
 27yPtGEFOuzV5L3Dwhi/b8wENmRWWfqPeV8sqL9olvyYWEPJnku6DvL+DS1upGEQQSnZ
 05hg==
X-Gm-Message-State: AOJu0YzQ4iIRu7RXymuDUSQW9Jnt7xx16k/AQfcx1aJ/7ob86/HhpMol
 TxL+Truw8R6m1oTsT4YCQAjpgRl1ixjTqIoCbyRaZgrL13HFrqkDqLovEw8iJ+1Nc9yTyTpIB1c
 wVBKWWMj5bVUFr117muItsuO+9nSGmJ7FXKVqoLrsLg==
X-Gm-Gg: ASbGncsrDzvbm/0G7emtttydolG0oBjy+nNom6nMam77cJ/dAKDJiPgGSBSAFeVoznv
 KjJGjlxDvmqJid6qh7IJ6C9jm/nFhOQabU8oyIge/JgBKxG2zBwhZHoB1CTOacDq8OoaqYMjarL
 bYJgMIh+CRe6XXwqtu5zOLARzNu1pQNzZmc0X76ixvmDTAxeJEF2xfAuz2apr7w0Bw50tP2bSP/
 4104q1H
X-Google-Smtp-Source: AGHT+IEVqJ0uTXw2pnUGgRM9Q2XotMbvXutKatuRAGaDSKV6B7Ok7J5ovYvITDm2qmTIp4lSQ1MfKj0gDS9WXjlRhrE=
X-Received: by 2002:a05:6402:35c8:b0:615:c5a9:4caf with SMTP id
 4fb4d7f45d1cf-617e2b7097fmr2877715a12.7.1754670867967; Fri, 08 Aug 2025
 09:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-2-pierrick.bouvier@linaro.org>
 <t0o24e.37nl0tbfod6ih@linaro.org>
 <09a8120a-051c-4d39-9506-5922f5d65697@linaro.org>
In-Reply-To: <09a8120a-051c-4d39-9506-5922f5d65697@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 8 Aug 2025 19:34:01 +0300
X-Gm-Features: Ac12FXxlNzPdGXx9UbX1BuRLVyPyvbdScdHm64O4xMLQaIc0VLErgE3PQGANC20
Message-ID: <CAAjaMXbNXYqvAsX9n057f9aO-weUt0v-eUi+=qPkysC2p_f6_A@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] contrib/plugins/uftrace: skeleton file
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud_=C3=A9?= <philmd@linaro.org>, 
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, Aug 8, 2025 at 7:19=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 8/8/25 1:14 AM, Manos Pitsidianakis wrote:
> > On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.or=
g> wrote:
> >> We define a scoreboard that will hold our data per cpu. As well, we
> >> define a buffer per cpu that will be used to read registers and memori=
es
> >> in a thread-safe way.
> >>
> >> For now, we just instrument all instructions with an empty callback.
> >>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >> ---
> >> contrib/plugins/uftrace.c   | 74 +++++++++++++++++++++++++++++++++++++
> >> contrib/plugins/meson.build |  3 +-
> >> 2 files changed, 76 insertions(+), 1 deletion(-)
> >> create mode 100644 contrib/plugins/uftrace.c
> >>
> >> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
> >> new file mode 100644
> >> index 00000000000..d60c1077496
> >> --- /dev/null
> >> +++ b/contrib/plugins/uftrace.c
> >> @@ -0,0 +1,74 @@
> >> +/*
> >> + * Copyright (C) 2025, Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >> + *
> >> + * Generates a trace compatible with uftrace (similar to uftrace reco=
rd).
> >> + * https://github.com/namhyung/uftrace
> >> + *
> >> + * See docs/about/emulation.rst|Uftrace for details and examples.
> >> + *
> >> + * SPDX-License-Identifier: GPL-2.0-or-later
> >> + */
> >> +
> >> +#include <qemu-plugin.h>
> >> +#include <glib.h>
> >> +
> >> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> >> +
> >> +typedef struct Cpu {
> >> +    GByteArray *buf;
> >> +} Cpu;
> >> +
> >> +static struct qemu_plugin_scoreboard *score;
> >> +
> >> +static void track_callstack(unsigned int cpu_index, void *udata)
> >> +{
> >> +}
> >> +
> >> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb =
*tb)
> >> +{
> >> +    size_t n_insns =3D qemu_plugin_tb_n_insns(tb);
> >> +
> >> +    for (int i =3D 0; i < n_insns; i++) {
> >
> > s/int i/size_t i/
> >
>
> Yep, that's better.
>
> >> +        struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb,=
 i);
> >
> > This can return NULL,
> >
>
> It will return NULL only if i is out of the tb range, which will never
> happen here, because i < n_insns.
> As you can see in all other plugins we have, there is never a NULL check
> for the return of qemu_plugin_tb_get_insn.
> It points a good thing in the API though, that maybe we should simply
> assert i is in the range, because there is no reason for a user to use a
> random index that may fall out of the tb range.

Ah thanks for pointing that out. Keep my r-b

>
> >> +
> >> +        uintptr_t pc =3D qemu_plugin_insn_vaddr(insn);
> >
> > And this would lead to a NULL dereference (it performs insn->vaddr
> > access)
> >
> >> +        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
> >> +                QEMU_PLUGIN_CB_R_REGS,
> >> +                (void *) pc);
> >
> > Hm indentation got broken here, should be
> >
>
> Thanks, probably when I created the intermediate series of patches.
>
> >
> > +        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
> > +                                               QEMU_PLUGIN_CB_R_REGS,
> > +                                               (void *)pc);
> >
> >> +
> >> +    }
> >> +}
> >> +
> >> +static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
> >> +{
> >> +    Cpu *cpu =3D qemu_plugin_scoreboard_find(score, vcpu_index);
> >> +    cpu->buf =3D g_byte_array_new();
> >> +}
> >> +
> >> +static void vcpu_end(unsigned int vcpu_index)
> >> +{
> >> +    Cpu *cpu =3D qemu_plugin_scoreboard_find(score, vcpu_index);
> >> +    g_byte_array_free(cpu->buf, true);
> >> +    memset(cpu, 0, sizeof(Cpu));
> >
> > Nitpick, cpu->buf =3D NULL; is easier to understand (suggestion)
> >
>
> Yes, it does not hurt, I'll add it.
>
> >> +}
> >> +
> >> +static void at_exit(qemu_plugin_id_t id, void *data)
> >> +{
> >> +    for (size_t i =3D 0; i < qemu_plugin_num_vcpus(); ++i) {
> >> +        vcpu_end(i);
> >> +    }
> >> +
> >> +    qemu_plugin_scoreboard_free(score);
> >> +}
> >> +
> >> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> >> +                                           const qemu_info_t *info,
> >> +                                           int argc, char **argv)
> >> +{
> >> +    score =3D qemu_plugin_scoreboard_new(sizeof(Cpu));
> >> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
> >> +    qemu_plugin_register_atexit_cb(id, at_exit, NULL);
> >> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> >> +
> >> +    return 0;
> >> +}
> >> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> >> index 1876bc78438..7eb3629c95d 100644
> >> --- a/contrib/plugins/meson.build
> >> +++ b/contrib/plugins/meson.build
> >> @@ -1,5 +1,6 @@
> >> contrib_plugins =3D ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hot=
blocks',
> >> -                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptri=
gger']
> >> +                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptri=
gger',
> >> +                   'uftrace']
> >> if host_os !=3D 'windows'
> >>    # lockstep uses socket.h
> >>    contrib_plugins +=3D 'lockstep'
> >> --
> >> 2.47.2
> >>
> >
> > If no other comments rise for this patch, you can add my r-b after
> > fixing the NULL check:
> >
> > Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>

