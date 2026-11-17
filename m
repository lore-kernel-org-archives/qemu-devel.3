Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEB2606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=h30AjDFY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTEwG-0003Du-SM; Tue, 17 Nov 2026 03:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTEwF-0003DT-3o
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 03:53:15 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTEwC-0004QA-OB
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 03:53:14 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b408f2d936so6687714a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 00:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1794905591; x=1795510391; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4+6siOWoxN5F3pSHbv5cNjyTYhALCGylXW4k7C6DU1c=;
 b=h30AjDFYOl6oVLEvRsrpnMfwvjf1CtGzGf1QS34RGWXYL7BkBgyc/bu8Qos45WAZaL
 NUG2aLUT4/0AdES3eDyZUmXqiCEWZE3xYOxo9eKV423JH4N1qlFGKqf7rg4affM4EA7x
 U9x8BFHDR2AUsb2NjNcuU5e/eLxeswJM5HZVFK3QrFjycCsFtHVr4TPZPI9ZQPOaAZj8
 oT0xj6ebB4kHQHuY1ICjj9rjjF2S8M1vxNsCiT4QO6w4+LSSSj2WPt38bu27zlAJUsZM
 Dk/FmISgBwG57t/cJ+1zOx0IO8EtU1aK30hXeONJ4o/xngylPymo9Z/2EYSThX0aQbxt
 JbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794905591; x=1795510391;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4+6siOWoxN5F3pSHbv5cNjyTYhALCGylXW4k7C6DU1c=;
 b=sljut3d+BCm7+wVlGQVKpjIHCeAir8Gy979piEW0WGDInIQBWDhGs9daIl3UoIzKeG
 i8ublmt3W11d0Ka+CZMKyh7JOJ3I4LoG5KF2lgVe6ccrAjPplhCE2wsvY26SoPw3EV7w
 ggJXZJ1SBc+hqyNJ0fNsnoI+T8E541WhNYx8t7jSqZapFEcs56sN894V3MaV4FWnTfc9
 xOfzfSz26hkRtW+ZkrhXOhYMS1YR8foyixYCJI+S2bjt5dDs0k7wgQgdmeSxawkTsTFQ
 OhZLqvo6ILESHOYcKqKhV+AvTUGSBq2NUG3IgsUI3SqAFiuNH3YYNN8cbZGKXSVZ7j50
 XRYQ==
X-Gm-Message-State: APuU4Z+aP+2rTXIWVPjYuMNMh2XTEbaKSs67p5O26wmS+pMiwVQ7y1cy
 WTImj5oSLGA55i1qDqfJthb6y/qb4IpIolhQi2tniEIdql/j26b2zLiaXzWdzyExR36E9BAcdN/
 Qqb6dyNZmQt8ymosaAFdYttKqE6iFP0Scg1V9Nu21YjC2sqZKykt8dSCBwOBAq9LxGFcTcNxx4I
 AKtSFsRYS2bFMZCmygEh1CO6OT6c8WJ7EtDoHKlb8xu3E=
X-Gm-Gg: AYBFou3J/w3wezCoH4J+/ZffRfHkKjlnAzy17Bv88SdZC8swEJJJMxVDmhMA516Cyxa
 5hUYUyAQO3Ct4vP3tuZa2qZv520ukpfGV2mL1EzXN6aqk/yJ8jyM2haFdt9jvcsB8iHxLWbgz5B
 b+8p+GjQw/oaZQWpYo6JxSxLIQVCLAF5P4DPJHzVicOZ4NvjueSpLyj13D6SpfR46nQgxH70PYe
 SO2WdBw+dAlBIcx6rpgoH6OwRCPUiqhg+wlTjUSUA7+GIr9okV/WIqkbaXWJKZZRkU5oQXHwxC8
 ojiIBCg5Cmx7p0SyIQ5Shy9xvOpaaLXGdfzaaHBoCKAAlb0quMf5qVvdoPxhfaIGO5bgWGwrNPi
 7e+XCHKfNob8XQi9yBEJhER+3bdlC1EoFrfiovGmTw85huH52ZB+dlMJRN2xibYu3nfFWIIXYPw
 IMaufeu8iRo44jvYlacwdKNVUm0xw7UYAtpQQoRyg6HUgYHMRTPrKEWGWhks4i+9p+MN2NlWvt/
 Sa2+mMf9bcANgF/5aQIOumWj1IXoKW0oblZ+O4olqJLpolK0SGqFPtD2Muj3POVqQXEkImaQcJV
 tfMrh/bIWk0yH+N4Pf9Tar72Rxii4PRAvmOrZHqaPKDJcrXUAHrEFGAHBw7znL41N5A=
X-Received: by 2002:a17:907:72c8:b0:c50:73bd:ed25 with SMTP id
 a640c23a62f3a-c50964287eemr1007449966b.49.1794905590496; 
 Tue, 17 Nov 2026 00:53:10 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com.
 [209.85.208.54]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b58b66sm515568666b.50.2026.11.17.00.53.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 00:53:09 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6b7bffb5b8fso5485255a12.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 00:53:08 -0800 (PST)
X-Received: by 2002:a05:6402:44dc:b0:6b7:1c:eae0 with SMTP id
 4fb4d7f45d1cf-6b7c0c1ff32mr8009779a12.24.1794905588364; Tue, 17 Nov 2026
 00:53:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
 <20260825-upstream-ntrace_core-v1-1-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-1-f8be2f40d2fd@gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 17 Nov 2026 16:52:57 +0800
X-Gmail-Original-Message-ID: <CAMXXpfaYax-65nOrxMj0pEA3bgq3Ujz72iUbCZs0UhH6zSU5dw@mail.gmail.com>
X-Gm-Features: AclHuK8MQoklHcAganw1PuQpM5tkim66BL6V-uC6bhC-WKRB_ndxl63hYNk5e6U
Message-ID: <CAMXXpfaYax-65nOrxMj0pEA3bgq3Ujz72iUbCZs0UhH6zSU5dw@mail.gmail.com>
Subject: Re: [PATCH 01/13] hw/riscv/trace-encoder: add ntrace enable flag
To: Konstantin Semichastnov <antikostya2@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexei Filippov <halip0503@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000fff9b806607505ef"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=jay.chang@sifive.com; helo=mail-ed1-x531.google.com
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

--000000000000fff9b806607505ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Jay Chang<jay.chang@sifive.com>
Thanks

On Tue, Aug 25, 2026 at 10:49=E2=80=AFPM Konstantin Semichastnov <
antikostya2@gmail.com> wrote:

> Initial commit of N-Trace support patch series based on "RISC-V n-trace
> (Nexus-based Trace) Specification" Version 1.0.
> With Trace control devices based on "RISC-V Trace Control Interface
> Specification" Version 1.0.
>
> Selecting trace message format rely on trTeFormat bit of trTeControl
> trace encoder register.
>
> We will mirror trTeFormat value in trace encoder in `ntrace` field to
> simplify checking of current format in trace encoder logic.
>
> This commit only mirrors register value in field, logic based on this
> field value is added in next commit.
>
> Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
> ---
>  hw/riscv/trace-encoder.c | 22 +++++++++++++++++++++-
>  hw/riscv/trace-encoder.h |  2 ++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
> index 55acb1f2ae..53345a478c 100644
> --- a/hw/riscv/trace-encoder.c
> +++ b/hw/riscv/trace-encoder.c
> @@ -84,6 +84,9 @@ REG32(TR_TE_CONTROL, 0x0)
>  #define R_TR_TE_CONTROL_RESET R_TR_TE_CONTROL_EMPTY_MASK
>  #define R_TR_TE_CONTROL_RO_BITS R_TR_TE_CONTROL_EMPTY_MASK
>
> +#define TR_TE_CONTROL_FORMAT_ETRACE 0
> +#define TR_TE_CONTROL_FORMAT_NTRACE 1
> +
>  /*
>   * trTeImpl register fields
>   */
> @@ -153,7 +156,6 @@ static uint64_t
> trencoder_te_ctrl_set_hardwire_vals(uint64_t input)
>      input =3D FIELD_DP32(input, TR_TE_CONTROL, CONTEXT, 0);
>      input =3D FIELD_DP32(input, TR_TE_CONTROL, INST_STALL_ENA, 0);
>      input =3D FIELD_DP32(input, TR_TE_CONTROL, INHIBIT_SRC, 1);
> -    input =3D FIELD_DP32(input, TR_TE_CONTROL, FORMAT, 0);
>
>      /* SYNC_MODE and SYNC_MAX will be revisited */
>      input =3D FIELD_DP32(input, TR_TE_CONTROL, INST_SYNC_MODE, 0);
> @@ -168,6 +170,7 @@ static uint64_t trencoder_te_ctrl_prew(RegisterInfo
> *reg, uint64_t val)
>      uint32_t trTeActive =3D ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
> ACTIVE);
>      uint32_t trTeInstTracing =3D ARRAY_FIELD_EX32(te->regs, TR_TE_CONTRO=
L,
>                                                  INST_TRACING);
> +    uint32_t trTeFormat =3D ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
> FORMAT);
>      uint32_t temp;
>
>      val =3D trencoder_te_ctrl_set_hardwire_vals(val);
> @@ -205,6 +208,19 @@ static uint64_t trencoder_te_ctrl_prew(RegisterInfo
> *reg, uint64_t val)
>          val =3D FIELD_DP32(val, TR_TE_CONTROL, INST_TRACING, 0);
>      }
>
> +    temp =3D FIELD_EX32(val, TR_TE_CONTROL, FORMAT);
> +    if (te->trace_running) {
> +        /* Do not allow to change tracing format while tracing is
> enabled. */
> +        val =3D FIELD_DP32(val, TR_TE_CONTROL, FORMAT, trTeFormat);
> +    } else if (temp !=3D TR_TE_CONTROL_FORMAT_ETRACE &&
> +               temp !=3D TR_TE_CONTROL_FORMAT_NTRACE) {
> +        /*
> +         * Do not change format, if requested format is not supported
> +         * (only E-Trace and N-Trace formats are supported for now)
> +         */
> +        val =3D FIELD_DP32(val, TR_TE_CONTROL, FORMAT, trTeFormat);
> +    }
> +
>      return val;
>  }
>
> @@ -215,6 +231,7 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg=
,
> uint64_t val)
>      uint32_t trTeEnable =3D ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
> ENABLE);
>      uint32_t trTeInstTracing =3D ARRAY_FIELD_EX32(te->regs, TR_TE_CONTRO=
L,
>                                                  INST_TRACING);
> +    uint32_t trTeFormat =3D ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
> FORMAT);
>      RISCVCPU *cpu =3D te->cpu;
>      CPURISCVState *env =3D &cpu->env;
>
> @@ -233,6 +250,8 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg=
,
> uint64_t val)
>
>      te->enabled =3D trTeEnable ? true : false;
>
> +    te->ntrace =3D (trTeFormat =3D=3D TR_TE_CONTROL_FORMAT_NTRACE);
> +
>      if (!te->trace_running && trTeInstTracing) {
>          /* Starting trace. Ask the CPU for the first trace insn */
>          te->trace_next_insn =3D true;
> @@ -314,6 +333,7 @@ static void trencoder_reset(DeviceState *dev)
>      te->enabled =3D false;
>      te->trace_running =3D false;
>      te->trace_next_insn =3D false;
> +    te->ntrace =3D false;
>      env->trace_running =3D false;
>
>      te->branch_map =3D 0;
> diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
> index 48cf8366ee..fed0ef9a48 100644
> --- a/hw/riscv/trace-encoder.h
> +++ b/hw/riscv/trace-encoder.h
> @@ -44,6 +44,8 @@ struct TraceEncoder {
>      bool enabled;
>      bool trace_running;
>      bool trace_next_insn;
> +
> +    bool ntrace;
>  };
>
>  #define TYPE_TRACE_ENCODER "trace-encoder"
>
> --
> 2.43.0
>
>
>

--000000000000fff9b806607505ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span class=3D"gmail-il">Reviewed</span>-by: Jay Chang&lt;=
<a href=3D"mailto:jay.chang@sifive.com">jay.chang@sifive.com</a>&gt;<div>Th=
anks</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25, 2026 at 10:49=E2=80=AFPM Ko=
nstantin Semichastnov &lt;<a href=3D"mailto:antikostya2@gmail.com">antikost=
ya2@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Initial commit of N-Trace support patch series based on &quot;=
RISC-V n-trace<br>
(Nexus-based Trace) Specification&quot; Version 1.0.<br>
With Trace control devices based on &quot;RISC-V Trace Control Interface<br=
>
Specification&quot; Version 1.0.<br>
<br>
Selecting trace message format rely on trTeFormat bit of trTeControl<br>
trace encoder register.<br>
<br>
We will mirror trTeFormat value in trace encoder in `ntrace` field to<br>
simplify checking of current format in trace encoder logic.<br>
<br>
This commit only mirrors register value in field, logic based on this<br>
field value is added in next commit.<br>
<br>
Signed-off-by: Konstantin Semichastnov &lt;<a href=3D"mailto:antikostya2@gm=
ail.com" target=3D"_blank">antikostya2@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/riscv/trace-encoder.c | 22 +++++++++++++++++++++-<br>
=C2=A0hw/riscv/trace-encoder.h |=C2=A0 2 ++<br>
=C2=A02 files changed, 23 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c<br>
index 55acb1f2ae..53345a478c 100644<br>
--- a/hw/riscv/trace-encoder.c<br>
+++ b/hw/riscv/trace-encoder.c<br>
@@ -84,6 +84,9 @@ REG32(TR_TE_CONTROL, 0x0)<br>
=C2=A0#define R_TR_TE_CONTROL_RESET R_TR_TE_CONTROL_EMPTY_MASK<br>
=C2=A0#define R_TR_TE_CONTROL_RO_BITS R_TR_TE_CONTROL_EMPTY_MASK<br>
<br>
+#define TR_TE_CONTROL_FORMAT_ETRACE 0<br>
+#define TR_TE_CONTROL_FORMAT_NTRACE 1<br>
+<br>
=C2=A0/*<br>
=C2=A0 * trTeImpl register fields<br>
=C2=A0 */<br>
@@ -153,7 +156,6 @@ static uint64_t trencoder_te_ctrl_set_hardwire_vals(uin=
t64_t input)<br>
=C2=A0 =C2=A0 =C2=A0input =3D FIELD_DP32(input, TR_TE_CONTROL, CONTEXT, 0);=
<br>
=C2=A0 =C2=A0 =C2=A0input =3D FIELD_DP32(input, TR_TE_CONTROL, INST_STALL_E=
NA, 0);<br>
=C2=A0 =C2=A0 =C2=A0input =3D FIELD_DP32(input, TR_TE_CONTROL, INHIBIT_SRC,=
 1);<br>
-=C2=A0 =C2=A0 input =3D FIELD_DP32(input, TR_TE_CONTROL, FORMAT, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* SYNC_MODE and SYNC_MAX will be revisited */<br>
=C2=A0 =C2=A0 =C2=A0input =3D FIELD_DP32(input, TR_TE_CONTROL, INST_SYNC_MO=
DE, 0);<br>
@@ -168,6 +170,7 @@ static uint64_t trencoder_te_ctrl_prew(RegisterInfo *re=
g, uint64_t val)<br>
=C2=A0 =C2=A0 =C2=A0uint32_t trTeActive =3D ARRAY_FIELD_EX32(te-&gt;regs, T=
R_TE_CONTROL, ACTIVE);<br>
=C2=A0 =C2=A0 =C2=A0uint32_t trTeInstTracing =3D ARRAY_FIELD_EX32(te-&gt;re=
gs, TR_TE_CONTROL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0INST_TRACING);<br>
+=C2=A0 =C2=A0 uint32_t trTeFormat =3D ARRAY_FIELD_EX32(te-&gt;regs, TR_TE_=
CONTROL, FORMAT);<br>
=C2=A0 =C2=A0 =C2=A0uint32_t temp;<br>
<br>
=C2=A0 =C2=A0 =C2=A0val =3D trencoder_te_ctrl_set_hardwire_vals(val);<br>
@@ -205,6 +208,19 @@ static uint64_t trencoder_te_ctrl_prew(RegisterInfo *r=
eg, uint64_t val)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D FIELD_DP32(val, TR_TE_CONTROL, IN=
ST_TRACING, 0);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 temp =3D FIELD_EX32(val, TR_TE_CONTROL, FORMAT);<br>
+=C2=A0 =C2=A0 if (te-&gt;trace_running) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Do not allow to change tracing format while=
 tracing is enabled. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D FIELD_DP32(val, TR_TE_CONTROL, FORMAT,=
 trTeFormat);<br>
+=C2=A0 =C2=A0 } else if (temp !=3D TR_TE_CONTROL_FORMAT_ETRACE &amp;&amp;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp !=3D TR_TE_CON=
TROL_FORMAT_NTRACE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Do not change format, if requested for=
mat is not supported<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* (only E-Trace and N-Trace formats are =
supported for now)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D FIELD_DP32(val, TR_TE_CONTROL, FORMAT,=
 trTeFormat);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return val;<br>
=C2=A0}<br>
<br>
@@ -215,6 +231,7 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, =
uint64_t val)<br>
=C2=A0 =C2=A0 =C2=A0uint32_t trTeEnable =3D ARRAY_FIELD_EX32(te-&gt;regs, T=
R_TE_CONTROL, ENABLE);<br>
=C2=A0 =C2=A0 =C2=A0uint32_t trTeInstTracing =3D ARRAY_FIELD_EX32(te-&gt;re=
gs, TR_TE_CONTROL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0INST_TRACING);<br>
+=C2=A0 =C2=A0 uint32_t trTeFormat =3D ARRAY_FIELD_EX32(te-&gt;regs, TR_TE_=
CONTROL, FORMAT);<br>
=C2=A0 =C2=A0 =C2=A0RISCVCPU *cpu =3D te-&gt;cpu;<br>
=C2=A0 =C2=A0 =C2=A0CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
<br>
@@ -233,6 +250,8 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, =
uint64_t val)<br>
<br>
=C2=A0 =C2=A0 =C2=A0te-&gt;enabled =3D trTeEnable ? true : false;<br>
<br>
+=C2=A0 =C2=A0 te-&gt;ntrace =3D (trTeFormat =3D=3D TR_TE_CONTROL_FORMAT_NT=
RACE);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (!te-&gt;trace_running &amp;&amp; trTeInstTracing) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Starting trace. Ask the CPU for the fi=
rst trace insn */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0te-&gt;trace_next_insn =3D true;<br>
@@ -314,6 +333,7 @@ static void trencoder_reset(DeviceState *dev)<br>
=C2=A0 =C2=A0 =C2=A0te-&gt;enabled =3D false;<br>
=C2=A0 =C2=A0 =C2=A0te-&gt;trace_running =3D false;<br>
=C2=A0 =C2=A0 =C2=A0te-&gt;trace_next_insn =3D false;<br>
+=C2=A0 =C2=A0 te-&gt;ntrace =3D false;<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;trace_running =3D false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0te-&gt;branch_map =3D 0;<br>
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h<br>
index 48cf8366ee..fed0ef9a48 100644<br>
--- a/hw/riscv/trace-encoder.h<br>
+++ b/hw/riscv/trace-encoder.h<br>
@@ -44,6 +44,8 @@ struct TraceEncoder {<br>
=C2=A0 =C2=A0 =C2=A0bool enabled;<br>
=C2=A0 =C2=A0 =C2=A0bool trace_running;<br>
=C2=A0 =C2=A0 =C2=A0bool trace_next_insn;<br>
+<br>
+=C2=A0 =C2=A0 bool ntrace;<br>
=C2=A0};<br>
<br>
=C2=A0#define TYPE_TRACE_ENCODER &quot;trace-encoder&quot;<br>
<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div>

--000000000000fff9b806607505ef--

