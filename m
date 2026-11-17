Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B92F606A339
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=jdI12/x/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTFmn-0008SF-RO; Tue, 17 Nov 2026 04:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFmk-0008ND-T8
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:47:30 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTFmi-000312-52
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:47:30 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c4322d310e7so796742166b.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1794908847; x=1795513647; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T9HOzm3M9cLpync32tJKKs1YxtWdpkq8avoVTfhwtUw=;
 b=jdI12/x/pxh0VdKF3q+nWDpquTN1CE5tRqxivy547fc1iJDw8jzFUELwP5vLY9iBRM
 wxFpIvLbG7GkzhOIyohfodQVryGwjy8O86JpHdPGOqYV1cDKxp41ZPILJmqx0TbGoofG
 o3NGe4ySXp8qr2af69EdQjSv7FkLWQnrwGkklrWDT9xfH5yFc+HkkN+PcwmgW87r5jd6
 dH4KHSg0dR+aNdDFGrYQ3OQy5IaOR8m/RHxBaWVALO90kr22JThzxIqS0DLQ1kaaLQ+2
 a/8RBK3nX9ciJmAgDyqdtobTmhpvX0u9speNXCDqV9oxQep8NmWIJuvwRZ3R3HhMEscm
 +QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794908847; x=1795513647;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T9HOzm3M9cLpync32tJKKs1YxtWdpkq8avoVTfhwtUw=;
 b=hafDK7p+A9jdfrfR8DKcOV2p0CHDas7ZQfQOhRYbYwLFK0C4nS/eSY5lMbF3JxjM7o
 od9aUGw90eX1LG725K2XUZSBG/55AO9SBqviISMWEnlk2bRgPkaMwe09tniRaltwuMxr
 hFNp3VwBD+eIzJCHCdxRaBhKMClUZUfaUo34w92hS2w9Yq+a4o5w2mNVBTe3OHo8uHSL
 rFT9csGxj3/9qn/CcPpIGMT/0IGJHLTQrWtjFUeWMn3dgQJg6pLt8qrLbPkt3N+JZ/Jw
 /snb076yFpB+8JFHbpbcsVNkZtQQHe12I5Tgfjm2nYi9nlKdStpNI+7XMj1jFv+wn3Xs
 MAMw==
X-Gm-Message-State: APuU4Z9k7YtKC4JnDtVA4Og7UCtwyS2cNAqLerjxH5Fe1TBYGXbuAlyL
 QIl1gS2+DfwF5gTuiZtAnbSyABHzUuqW/VpZYMD1ey25c4/SKxkIb06fW6vpi2rZ5aQBXbBZBMA
 VLFtNPtkbZTP/nr7aW9Ixw2l4JX9Z9HJwi6TCBkACsGkumQQWjHfZFdZZ8tw3d7dN9l+RG1fjXz
 k/50AsYt8yzf9MODl7yaHn+EuY6+J+QVyNKldjlQQ2f0w=
X-Gm-Gg: AYBFou0cb57EL8lO0bXA0wH0DNxERXcXOKoxPIh/JcnwYhIrfLWIgUyKzbfce35DGxb
 5B3u2Ln4IvEmWt/Y1wG/caxPb2+ZTSpwwg6u0vPNNd+hzYmfDXPGDe5xvdEljuTbi/OhdKFgBgd
 2cwhew3T/ZMQRH7/M4Ad4dOjlyRSnObPOB10iQix0jbH46KuUB/2uAmF4hvOuw4rPdAcpErCh/r
 Jv4VXhNmTJujagX7DUOr1I8fMqtL2IwmZrLvWSN0axiZmIY4TkZohO05Snwl5rVfVJFNcFhqU4m
 rccz5g1l31cXLTsE7gIeUo6gRnIQlT1wZ+WhtkbQqpH558zMogfYS8u/CpUE6ka8bVfZ6jIKHCA
 phzAXeqqIjgH4G2RUm2R89rs/fmUg12WJPJTVAwU4/Uk1qE7P+1Wksm7S/EaJmFM/ZRoB/X3l/y
 QyZISPvN7vBN4wbR8LvzmeSWZfvTcwGM88b3FCEN+6awv+JtBxFSS56WLc1tGbQKZHLsTuruGhm
 NWTZKIi0xD9Ee/7H4nDPAK+4m8tozA6tFGubyFkNT/JeeckTjvhv7OzFGePXh7WeVVHii1VeaIg
 wLl45rHZcF0yuIp2GvLoTxuLq6k/unrBozGjZvBk84kvq3Z0lmBhl+2sR0z9iMX7jvk=
X-Received: by 2002:a17:907:1c8f:b0:c31:fb29:a137 with SMTP id
 a640c23a62f3a-c5096313a83mr1138853666b.21.1794908846634; 
 Tue, 17 Nov 2026 01:47:26 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com.
 [209.85.208.45]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c50c041600asm342338166b.10.2026.11.17.01.47.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 01:47:25 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6b87a92c17eso189461a12.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:47:25 -0800 (PST)
X-Received: by 2002:a17:906:dc8c:b0:c44:3006:5c3 with SMTP id
 a640c23a62f3a-c5096348260mr1109100366b.28.1794908844897; Tue, 17 Nov 2026
 01:47:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
 <20260825-upstream-ntrace_core-v1-13-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-13-f8be2f40d2fd@gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 17 Nov 2026 17:47:13 +0800
X-Gmail-Original-Message-ID: <CAMXXpfZUYqy3-28Tr2j0wmwraVPkuGcSsYH63ZKcP3A-iucc7g@mail.gmail.com>
X-Gm-Features: AclHuK_XnHCAIwzDI3qClywmNhwfelffXxhWZUqR2K3PqhR3sqfIvhiyULCX_Ck
Message-ID: <CAMXXpfZUYqy3-28Tr2j0wmwraVPkuGcSsYH63ZKcP3A-iucc7g@mail.gmail.com>
Subject: Re: [PATCH 13/13] hw/riscv/trace-encoder: refactor register accesses
To: Konstantin Semichastnov <antikostya2@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexei Filippov <halip0503@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000001abc1d066075c84e"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=jay.chang@sifive.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000001abc1d066075c84e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Jay Chang<jay.chang@sifive.com>
Thanks

On Wed, Aug 26, 2026 at 1:42=E2=80=AFAM Konstantin Semichastnov <
antikostya2@gmail.com> wrote:

> Refactor pre-write and post-write trace register accesses.
> Remove unused `enabled` flag.
>
> Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
> ---
>  hw/riscv/trace-encoder.c | 79
> +++++++++++++++++++++---------------------------
>  hw/riscv/trace-encoder.h |  9 +++---
>  2 files changed, 39 insertions(+), 49 deletions(-)
>
> diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
> index 58ed4b2646..7fd5c3a578 100644
> --- a/hw/riscv/trace-encoder.c
> +++ b/hw/riscv/trace-encoder.c
> @@ -161,6 +161,7 @@ static hwaddr
> trencoder_read_ramsink_ramlimit(TraceEncoder *te)
>
>  static uint64_t trencoder_te_ctrl_set_hardwire_vals(uint64_t input)
>  {
> +    input =3D FIELD_DP32(input, TR_TE_CONTROL, EMPTY, 1);
>      input =3D FIELD_DP32(input, TR_TE_CONTROL, INST_MODE, 0x6);
>      input =3D FIELD_DP32(input, TR_TE_CONTROL, CONTEXT, 0);
>      input =3D FIELD_DP32(input, TR_TE_CONTROL, INST_TRIG_ENABLE, 0);
> @@ -179,6 +180,7 @@ static uint64_t trencoder_te_ctrl_prew(RegisterInfo
> *reg, uint64_t val)
>  {
>      TraceEncoder *te =3D TRACE_ENCODER(reg->opaque);
>      uint32_t trTeActive =3D ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
> ACTIVE);
> +    uint32_t trTeEnable =3D ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
> ENABLE);
>      uint32_t trTeInstTracing =3D ARRAY_FIELD_EX32(te->regs, TR_TE_CONTRO=
L,
>                                                  INST_TRACING);
>      uint32_t trTeFormat =3D ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
> FORMAT);
> @@ -187,40 +189,30 @@ static uint64_t trencoder_te_ctrl_prew(RegisterInfo
> *reg, uint64_t val)
>      val =3D trencoder_te_ctrl_set_hardwire_vals(val);
>
>      if (!trTeActive) {
> -        /*
> -         * 11.2 Reset and discovery, table 58, trTeControl =3D 0x1
> -         * means "Release from reset and set all defaults." Do
> -         * that only if trTeActive is 0.
> -         */
> -        if (val =3D=3D 0x1) {
> -            val =3D FIELD_DP32(val, TR_TE_CONTROL, EMPTY, 1);
> -
> -            return val;
> -        }
> -
>          /*
>           * 11.3 Enabling and Disabling hints that the device must
>           * be activated first (trTeActive =3D 1), then enabled.
>           * Do not enable the device if it's not active
>           * beforehand.
>           */
> -        temp =3D FIELD_EX32(val, TR_TE_CONTROL, ENABLE);
> -        if (temp) {
> +        if (FIELD_EX32(val, TR_TE_CONTROL, ENABLE)) {
>              val =3D FIELD_DP32(val, TR_TE_CONTROL, ENABLE, 0);
>          }
>      }
>
> -    /*
> -     * Do not allow inst tracing to start if the device isn't
> -     * already enabled. Do not allow enabling the devince and
> -     * and enable tracing at the same time.
> -     */
> -    if (!te->enabled && trTeInstTracing) {
> -        val =3D FIELD_DP32(val, TR_TE_CONTROL, INST_TRACING, 0);
> +    if (FIELD_EX32(val, TR_TE_CONTROL, INST_TRACING)) {
> +        /*
> +         * Do not allow inst tracing to start if the device isn't
> +         * already enabled. Do not allow enabling the device and
> +         * and enable tracing at the same time.
> +         */
> +        if (!trTeEnable) {
> +            val =3D FIELD_DP32(val, TR_TE_CONTROL, INST_TRACING, 0);
> +        }
>      }
>
>      temp =3D FIELD_EX32(val, TR_TE_CONTROL, FORMAT);
> -    if (te->trace_running) {
> +    if (trTeInstTracing) {
>          /* Do not allow to change tracing format while tracing is
> enabled. */
>          val =3D FIELD_DP32(val, TR_TE_CONTROL, FORMAT, trTeFormat);
>      } else if (temp !=3D TR_TE_CONTROL_FORMAT_ETRACE &&
> @@ -232,6 +224,15 @@ static uint64_t trencoder_te_ctrl_prew(RegisterInfo
> *reg, uint64_t val)
>          val =3D FIELD_DP32(val, TR_TE_CONTROL, FORMAT, trTeFormat);
>      }
>
> +    if (!FIELD_EX32(val, TR_TE_CONTROL, ACTIVE)) {
> +        /* Disable trace encoder if it becoming not active */
> +        val =3D FIELD_DP32(val, TR_TE_CONTROL, ENABLE, 0);
> +    }
> +    if (!FIELD_EX32(val, TR_TE_CONTROL, ENABLE)) {
> +        /* Disable tracing if trace incoder being disabled */
> +        val =3D FIELD_DP32(val, TR_TE_CONTROL, INST_TRACING, 0);
> +    }
> +
>      return val;
>  }
>
> @@ -263,35 +264,27 @@ static void trencoder_te_ctrl_postw(RegisterInfo
> *reg, uint64_t val)
>      RISCVCPU *cpu =3D te->cpu;
>      CPURISCVState *env =3D &cpu->env;
>
> +    bool trace_disabled =3D !trTeActive || !trTeEnable || !trTeInstTraci=
ng;
>
> -    if (te->ntrace && te->enabled) {
> -        if (!trTeActive || !trTeEnable || !trTeInstTracing) {
> -            uint32_t inst_len =3D get_inst_len_at(env->pc);
> +    if (te->trace_running && trace_disabled) {
> +        /* Stopping trace. */
> +        /* TODO: this should cause a pending trace data flush. */
> +        te->trace_next_insn =3D false;
>
> +        if (te->ntrace) {
> +            uint32_t inst_len =3D get_inst_len_at(env->pc);
>              trencoder_send_prog_trace_correlation(OBJECT(te), env->pc,
> inst_len,
>
>  CORRELATION_TRACE_DISABLED);
>          }
>      }
>
> -    if (!trTeActive) {
> -        te->enabled =3D false;
> -        te->trace_running =3D false;
> -        te->trace_next_insn =3D false;
> -
> -        env->trace_running =3D false;
> -        return;
> -    }
> -
> -    if (te->enabled && !trTeEnable) {
> -        /* TODO: this should cause a pending trace data flush. */
> -    }
> -
> -    te->enabled =3D trTeEnable ? true : false;
> -
>      te->ntrace =3D (trTeFormat =3D=3D TR_TE_CONTROL_FORMAT_NTRACE);
>
>      if (!te->trace_running && trTeInstTracing) {
>          /* Starting trace. Ask the CPU for the first trace insn */
> +        te->ramsink_ramstart =3D trencoder_read_ramsink_writep(te);
> +        te->ramsink_ramlimit =3D trencoder_read_ramsink_ramlimit(te);
> +
>          if (te->ntrace) {
>              /*
>               * N-Trace require to trace from very first instruction,
> @@ -305,13 +298,10 @@ static void trencoder_te_ctrl_postw(RegisterInfo
> *reg, uint64_t val)
>          } else {
>              te->trace_next_insn =3D true;
>          }
> -
> -        te->ramsink_ramstart =3D trencoder_read_ramsink_writep(te);
> -        te->ramsink_ramlimit =3D trencoder_read_ramsink_ramlimit(te);
>      }
>
> -    te->trace_running =3D trTeInstTracing ? true : false;
> -    env->trace_running =3D te->trace_running;
> +    te->trace_running =3D trTeInstTracing;
> +    env->trace_running =3D trTeInstTracing;
>  }
>
>  static RegisterAccessInfo trencoder_regs_info[] =3D {
> @@ -380,7 +370,6 @@ static void trencoder_reset(DeviceState *dev)
>          register_reset(&te->regs_info[i]);
>      }
>
> -    te->enabled =3D false;
>      te->trace_running =3D false;
>      te->trace_next_insn =3D false;
>      te->ntrace =3D false;
> diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
> index 55d53c2582..b3cdbf9374 100644
> --- a/hw/riscv/trace-encoder.h
> +++ b/hw/riscv/trace-encoder.h
> @@ -39,13 +39,14 @@ struct TraceEncoder {
>      uint32_t regs[TRACE_R_MAX];
>      RegisterInfo regs_info[TRACE_R_MAX];
>
> -    bool updiscon_pending;
> -
> -    bool enabled;
> +    bool ntrace;
>      bool trace_running;
> +
> +    /* etrace specific */
> +    bool updiscon_pending;
>      bool trace_next_insn;
>
> -    bool ntrace;
> +    /* ntrace specific */
>      uint64_t last_addr_reported;
>      uint64_t last_icnt_reset;
>      uint64_t icnt_accumulated;
>
> --
> 2.43.0
>
>

--0000000000001abc1d066075c84e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Jay Chang&lt;<a href=3D"mailto:jay.chang@sifi=
ve.com" target=3D"_blank">jay.chang@sifive.com</a>&gt;<div>Thanks</div></di=
v><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Wed, Aug 26, 2026 at 1:42=E2=80=AFAM Konstantin Semich=
astnov &lt;<a href=3D"mailto:antikostya2@gmail.com">antikostya2@gmail.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Re=
factor pre-write and post-write trace register accesses.<br>
Remove unused `enabled` flag.<br>
<br>
Signed-off-by: Konstantin Semichastnov &lt;<a href=3D"mailto:antikostya2@gm=
ail.com" target=3D"_blank">antikostya2@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/riscv/trace-encoder.c | 79 +++++++++++++++++++++------------------=
---------<br>
=C2=A0hw/riscv/trace-encoder.h |=C2=A0 9 +++---<br>
=C2=A02 files changed, 39 insertions(+), 49 deletions(-)<br>
<br>
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c<br>
index 58ed4b2646..7fd5c3a578 100644<br>
--- a/hw/riscv/trace-encoder.c<br>
+++ b/hw/riscv/trace-encoder.c<br>
@@ -161,6 +161,7 @@ static hwaddr trencoder_read_ramsink_ramlimit(TraceEnco=
der *te)<br>
<br>
=C2=A0static uint64_t trencoder_te_ctrl_set_hardwire_vals(uint64_t input)<b=
r>
=C2=A0{<br>
+=C2=A0 =C2=A0 input =3D FIELD_DP32(input, TR_TE_CONTROL, EMPTY, 1);<br>
=C2=A0 =C2=A0 =C2=A0input =3D FIELD_DP32(input, TR_TE_CONTROL, INST_MODE, 0=
x6);<br>
=C2=A0 =C2=A0 =C2=A0input =3D FIELD_DP32(input, TR_TE_CONTROL, CONTEXT, 0);=
<br>
=C2=A0 =C2=A0 =C2=A0input =3D FIELD_DP32(input, TR_TE_CONTROL, INST_TRIG_EN=
ABLE, 0);<br>
@@ -179,6 +180,7 @@ static uint64_t trencoder_te_ctrl_prew(RegisterInfo *re=
g, uint64_t val)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TraceEncoder *te =3D TRACE_ENCODER(reg-&gt;opaque);<br>
=C2=A0 =C2=A0 =C2=A0uint32_t trTeActive =3D ARRAY_FIELD_EX32(te-&gt;regs, T=
R_TE_CONTROL, ACTIVE);<br>
+=C2=A0 =C2=A0 uint32_t trTeEnable =3D ARRAY_FIELD_EX32(te-&gt;regs, TR_TE_=
CONTROL, ENABLE);<br>
=C2=A0 =C2=A0 =C2=A0uint32_t trTeInstTracing =3D ARRAY_FIELD_EX32(te-&gt;re=
gs, TR_TE_CONTROL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0INST_TRACING);<br>
=C2=A0 =C2=A0 =C2=A0uint32_t trTeFormat =3D ARRAY_FIELD_EX32(te-&gt;regs, T=
R_TE_CONTROL, FORMAT);<br>
@@ -187,40 +189,30 @@ static uint64_t trencoder_te_ctrl_prew(RegisterInfo *=
reg, uint64_t val)<br>
=C2=A0 =C2=A0 =C2=A0val =3D trencoder_te_ctrl_set_hardwire_vals(val);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!trTeActive) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 11.2 Reset and discovery, table 58, tr=
TeControl =3D 0x1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* means &quot;Release from reset and set=
 all defaults.&quot; Do<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* that only if trTeActive is 0.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val =3D=3D 0x1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D FIELD_DP32(val, TR_TE_CO=
NTROL, EMPTY, 1);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return val;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * 11.3 Enabling and Disabling hints that=
 the device must<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * be activated first (trTeActive =3D 1),=
 then enabled.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Do not enable the device if it&#39;s n=
ot active<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * beforehand.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 temp =3D FIELD_EX32(val, TR_TE_CONTROL, ENABLE=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (temp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FIELD_EX32(val, TR_TE_CONTROL, ENABLE)) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D FIELD_DP32(val, TR_=
TE_CONTROL, ENABLE, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* Do not allow inst tracing to start if the device isn=
&#39;t<br>
-=C2=A0 =C2=A0 =C2=A0* already enabled. Do not allow enabling the devince a=
nd<br>
-=C2=A0 =C2=A0 =C2=A0* and enable tracing at the same time.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 if (!te-&gt;enabled &amp;&amp; trTeInstTracing) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D FIELD_DP32(val, TR_TE_CONTROL, INST_TR=
ACING, 0);<br>
+=C2=A0 =C2=A0 if (FIELD_EX32(val, TR_TE_CONTROL, INST_TRACING)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Do not allow inst tracing to start if =
the device isn&#39;t<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* already enabled. Do not allow enabling=
 the device and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* and enable tracing at the same time.<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!trTeEnable) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D FIELD_DP32(val, TR_TE_CO=
NTROL, INST_TRACING, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0temp =3D FIELD_EX32(val, TR_TE_CONTROL, FORMAT);<br>
-=C2=A0 =C2=A0 if (te-&gt;trace_running) {<br>
+=C2=A0 =C2=A0 if (trTeInstTracing) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Do not allow to change tracing format =
while tracing is enabled. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D FIELD_DP32(val, TR_TE_CONTROL, FO=
RMAT, trTeFormat);<br>
=C2=A0 =C2=A0 =C2=A0} else if (temp !=3D TR_TE_CONTROL_FORMAT_ETRACE &amp;&=
amp;<br>
@@ -232,6 +224,15 @@ static uint64_t trencoder_te_ctrl_prew(RegisterInfo *r=
eg, uint64_t val)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D FIELD_DP32(val, TR_TE_CONTROL, FO=
RMAT, trTeFormat);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (!FIELD_EX32(val, TR_TE_CONTROL, ACTIVE)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Disable trace encoder if it becoming not ac=
tive */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D FIELD_DP32(val, TR_TE_CONTROL, ENABLE,=
 0);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (!FIELD_EX32(val, TR_TE_CONTROL, ENABLE)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Disable tracing if trace incoder being disa=
bled */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D FIELD_DP32(val, TR_TE_CONTROL, INST_TR=
ACING, 0);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return val;<br>
=C2=A0}<br>
<br>
@@ -263,35 +264,27 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg=
, uint64_t val)<br>
=C2=A0 =C2=A0 =C2=A0RISCVCPU *cpu =3D te-&gt;cpu;<br>
=C2=A0 =C2=A0 =C2=A0CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
<br>
+=C2=A0 =C2=A0 bool trace_disabled =3D !trTeActive || !trTeEnable || !trTeI=
nstTracing;<br>
<br>
-=C2=A0 =C2=A0 if (te-&gt;ntrace &amp;&amp; te-&gt;enabled) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!trTeActive || !trTeEnable || !trTeInstTra=
cing) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t inst_len =3D get_inst_l=
en_at(env-&gt;pc);<br>
+=C2=A0 =C2=A0 if (te-&gt;trace_running &amp;&amp; trace_disabled) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Stopping trace. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: this should cause a pending trace dat=
a flush. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;trace_next_insn =3D false;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (te-&gt;ntrace) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t inst_len =3D get_inst_l=
en_at(env-&gt;pc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trencoder_send_prog_trace_c=
orrelation(OBJECT(te), env-&gt;pc, inst_len,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CORRELATION_TRACE_DISABLED);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!trTeActive) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;enabled =3D false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;trace_running =3D false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;trace_next_insn =3D false;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;trace_running =3D false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (te-&gt;enabled &amp;&amp; !trTeEnable) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: this should cause a pending trace dat=
a flush. */<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 te-&gt;enabled =3D trTeEnable ? true : false;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0te-&gt;ntrace =3D (trTeFormat =3D=3D TR_TE_CONTROL_FORM=
AT_NTRACE);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!te-&gt;trace_running &amp;&amp; trTeInstTracing) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Starting trace. Ask the CPU for the fi=
rst trace insn */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;ramsink_ramstart =3D trencoder_read_ram=
sink_writep(te);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;ramsink_ramlimit =3D trencoder_read_ram=
sink_ramlimit(te);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (te-&gt;ntrace) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * N-Trace require to trace=
 from very first instruction,<br>
@@ -305,13 +298,10 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg=
, uint64_t val)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0te-&gt;trace_next_insn =3D =
true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;ramsink_ramstart =3D trencoder_read_ram=
sink_writep(te);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;ramsink_ramlimit =3D trencoder_read_ram=
sink_ramlimit(te);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 te-&gt;trace_running =3D trTeInstTracing ? true : false;<br>
-=C2=A0 =C2=A0 env-&gt;trace_running =3D te-&gt;trace_running;<br>
+=C2=A0 =C2=A0 te-&gt;trace_running =3D trTeInstTracing;<br>
+=C2=A0 =C2=A0 env-&gt;trace_running =3D trTeInstTracing;<br>
=C2=A0}<br>
<br>
=C2=A0static RegisterAccessInfo trencoder_regs_info[] =3D {<br>
@@ -380,7 +370,6 @@ static void trencoder_reset(DeviceState *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0register_reset(&amp;te-&gt;regs_info[i]);=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 te-&gt;enabled =3D false;<br>
=C2=A0 =C2=A0 =C2=A0te-&gt;trace_running =3D false;<br>
=C2=A0 =C2=A0 =C2=A0te-&gt;trace_next_insn =3D false;<br>
=C2=A0 =C2=A0 =C2=A0te-&gt;ntrace =3D false;<br>
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h<br>
index 55d53c2582..b3cdbf9374 100644<br>
--- a/hw/riscv/trace-encoder.h<br>
+++ b/hw/riscv/trace-encoder.h<br>
@@ -39,13 +39,14 @@ struct TraceEncoder {<br>
=C2=A0 =C2=A0 =C2=A0uint32_t regs[TRACE_R_MAX];<br>
=C2=A0 =C2=A0 =C2=A0RegisterInfo regs_info[TRACE_R_MAX];<br>
<br>
-=C2=A0 =C2=A0 bool updiscon_pending;<br>
-<br>
-=C2=A0 =C2=A0 bool enabled;<br>
+=C2=A0 =C2=A0 bool ntrace;<br>
=C2=A0 =C2=A0 =C2=A0bool trace_running;<br>
+<br>
+=C2=A0 =C2=A0 /* etrace specific */<br>
+=C2=A0 =C2=A0 bool updiscon_pending;<br>
=C2=A0 =C2=A0 =C2=A0bool trace_next_insn;<br>
<br>
-=C2=A0 =C2=A0 bool ntrace;<br>
+=C2=A0 =C2=A0 /* ntrace specific */<br>
=C2=A0 =C2=A0 =C2=A0uint64_t last_addr_reported;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t last_icnt_reset;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t icnt_accumulated;<br>
<br>
--<br>
2.43.0<br>
<br>
</blockquote></div>

--0000000000001abc1d066075c84e--

