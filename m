Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED708606A890
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=kJ0S4Sxv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTF13-0004Dy-SM; Tue, 17 Nov 2026 03:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTF12-0004Df-M3
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 03:58:12 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xTF10-0008UU-Fl
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 03:58:12 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c505186727fso242923266b.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 00:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1794905889; x=1795510689; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xrx2aASjqtzCZtcmbyEDZtYppb1iQk8pPRelgP4kkAI=;
 b=kJ0S4SxvpOTIV+5N8D5XCuKT4kSu2XIYVYwXRfExTZcRJaecTVoVwaHcaGTtCium+o
 xvLovT6tobc5+sS/MLYRNGBaiC30Y3/wGNvaybvdciGE+74YkX+eheQKfzkKLRIyZZhK
 0jrrl6JT7KoqaFuzugaI1CyJpxAEBfoH60tfs4w7wWk3xa7tH5ygOXt5hUIJIA9fsea4
 rQitwwd3fG1Mfzp6vQojOx9JTChKzdl0qojSInJd/H/hzEGlCz5tGoiagirP31diCVwB
 HzKl0xgz2Wbno76pxkJivKKP9BPHBnIG+7tqHyEejMpAKWyLaEN3nOfhleWBEN68k7Jw
 aIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794905889; x=1795510689;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xrx2aASjqtzCZtcmbyEDZtYppb1iQk8pPRelgP4kkAI=;
 b=xGddDZN/S9Lnsc0xqdqNlf1okvo9oe1HMmnH1ga8BckTUpdEuCswr0YYHJbm6ThCme
 3hmc0O3kHYZ/NTNMgdLB//F+4AjsUKjAd2sUGz7UwXvT4L8L+a9QaIniQQWNP6CiNu6r
 RpiqVdbppnhA2dKbIpGJf7iRFEsPGDxl9nX+yvITwutORCpfDboediq3kQf/xzX5Yw3b
 XJkjU2mb032SlLnJtl1VPuepL7PFRecyBZ1sZVKqk2q0QoYsN4NrliIlOijQQ/u+a6AJ
 45Y0xyUQtlf0Yp+I/84tVO7lgEe839PTadN1ggTxzUy/0nI8P+4vTqcTq7aqiEueKF7h
 0Kww==
X-Gm-Message-State: APuU4Z9oNzh+kxMO3us19SEOAJcka5SwTxOihxto6fARrlzjWXR/wUIN
 VI4f/vde3CN4H+KpNi0mys47onVJuad4VPtnWIG6lXSkt0CuOttbCuWWDtDj/J0BXm6xFeLU5wT
 C1ybBLLwU7scq3+nfRAcDbPFTvjAz2figz5IEMVQ8V/U+Y+KA7pWVBhpl+RsLU3inOMYLkhnRik
 ddB+pc90n7MoZfigCEWQaHxGXf+VjvsQ3xze3s8iQ14mw=
X-Gm-Gg: AYBFou3FLZCkauIFWly8aA5qgXSCnRPe05MTP5wxP62VPL2OCC/s1wJTzsz0hPo+xf9
 jPHbJFGWipUeXaVuO1KUxjIe/Gh2EduG5HCwF1cVUgvY9sI6eV1WJJ8kW1606dGwp3X2499mqAh
 6qkeBSrvnHV0zlMdVyjElUEFgCQKWUeBBh30ECLnKdCdEwrZ35fbbh4SQwR2SpnmJD1NSZwILdG
 INneVofXCCoaX7kHU0b0ao8SH3oW/htUQX7mXUOtkDk0m6wfOUYKP+yVFNDKJ2lUBpbjy+KjBHn
 YzNdeB2UcrENuNne01AtwPZ03yboE+YI99ygfF8QRhT9tzZ4hGW0WFfTfnANukW+FU6Cei0K+4+
 sbHFOqhpM0l5cPAwt7+fOhg25oIqFDqi3ZceJm6wscpKUXyKo3WUjble8IzpDw10j5qQycr4ZgD
 7L9GAGAMfelbiW+cnwWEZ/f8LyX2oc/qBOXUw+BKdobcohUFAlX8Nf54jhbXlpwdPUCpBFKOOHF
 mLKWhN6Bp7Y9tEYHuVdBZkIeHb4wtVa1kvJ1JB5FDqqX1U5Dl3s54h8TgmTW5lGPcYwiboJzo7J
 2WiOiJ4F7yr6hx21xPYvjdBGnAL9P5zdPW+pgOWL++oe/kSYwMCKyKBui/X1b+k41RA=
X-Received: by 2002:a17:907:3f02:b0:c50:5186:6dc2 with SMTP id
 a640c23a62f3a-c509636b5f5mr1227491866b.24.1794905888679; 
 Tue, 17 Nov 2026 00:58:08 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com.
 [209.85.218.52]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b23b1fsm520246066b.21.2026.11.17.00.58.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 00:58:07 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c505186727fso242916866b.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 00:58:06 -0800 (PST)
X-Received: by 2002:a17:907:9492:b0:c2e:52d6:1fb7 with SMTP id
 a640c23a62f3a-c509636a2ffmr988069066b.22.1794905886301; Tue, 17 Nov 2026
 00:58:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
 <20260825-upstream-ntrace_core-v1-2-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-2-f8be2f40d2fd@gmail.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 17 Nov 2026 16:57:55 +0800
X-Gmail-Original-Message-ID: <CAMXXpfaWB7ThMhMwWGPswVhbNO8WoN9zbF5msp9k9XHj54UUQw@mail.gmail.com>
X-Gm-Features: AclHuK-7e_E-nSEAQU92XKWBNlv37GKi9q3dN3M77frFQiApyxepb3L_cGdSbfk
Message-ID: <CAMXXpfaWB7ThMhMwWGPswVhbNO8WoN9zbF5msp9k9XHj54UUQw@mail.gmail.com>
Subject: Re: [PATCH 02/13] hw/riscv/trace-encoder.c: add trace ntrace/etrace
 selection logic
To: Konstantin Semichastnov <antikostya2@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexei Filippov <halip0503@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000c2275406607517ea"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=jay.chang@sifive.com; helo=mail-ej1-x636.google.com
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c2275406607517ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Jay Chang<jay.chang@sifive.com>
Thanks


On Tue, Aug 25, 2026 at 10:49=E2=80=AFPM Konstantin Semichastnov <
antikostya2@gmail.com> wrote:

> Selecting trace message format rely on `TraceEncoder->ntrace` flag.
> This flag mirrors trTeFormat bit.
>
> For now only two values supported:
>
>  - E-Trace (trTeFormat =3D 0), trace format, described by Efficient trace
> spec.
>
>  - N-Trace (trTeFormat =3D 1), trace format, described by Nexus trace spe=
c.
>
> For now we not yet implemented any N-Trace messages, so currently
> `ntrace` field only disables E-Trace messages competely. We will reuse
> this field in following commits, when N-Trace messages added.
>
> Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
> ---
>  hw/riscv/trace-encoder.c    | 29 +++++++++++++++++++++++++----
>  target/riscv/trace_helper.c |  8 ++++++--
>  2 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
> index 53345a478c..34c8f60ce1 100644
> --- a/hw/riscv/trace-encoder.c
> +++ b/hw/riscv/trace-encoder.c
> @@ -254,7 +254,11 @@ static void trencoder_te_ctrl_postw(RegisterInfo
> *reg, uint64_t val)
>
>      if (!te->trace_running && trTeInstTracing) {
>          /* Starting trace. Ask the CPU for the first trace insn */
> -        te->trace_next_insn =3D true;
> +        if (te->ntrace) {
> +            /* send ProgTraceSync message */
> +        } else {
> +            te->trace_next_insn =3D true;
> +        }
>
>          te->ramsink_ramstart =3D trencoder_read_ramsink_writep(te);
>          te->ramsink_ramlimit =3D trencoder_read_ramsink_ramlimit(te);
> @@ -442,6 +446,8 @@ static void trencoder_send_sync_msg(Object
> *trencoder_obj, uint64_t pc)
>      uint8_t msg_size;
>      bool is_branch_taken;
>
> +    g_assert(!trencoder->ntrace);
> +
>      trencoder->first_pc =3D pc;
>      is_branch_taken =3D trencoder_addr_is_branch_taken(trencoder, pc);
>      msg_size =3D rv_etrace_gen_encoded_sync_msg(msg, pc, priv,
> @@ -458,6 +464,8 @@ static void trencoder_send_updiscon(TraceEncoder
> *trencoder, uint64_t pc)
>      bool updiscon =3D !notify;
>      uint8_t msg_size;
>
> +    g_assert(!trencoder->ntrace);
> +
>      if (trencoder->branches > 0) {
>          msg_size =3D rv_etrace_gen_encoded_format1(format2_msg,
>                                                   trencoder->branches,
> @@ -485,6 +493,8 @@ void trencoder_set_first_trace_insn(Object
> *trencoder_obj, uint64_t pc)
>      uint8_t msg_size;
>      bool is_branch_taken;
>
> +    g_assert(!trencoder->ntrace);
> +
>      if (trencoder->updiscon_pending) {
>          trencoder_send_updiscon(trencoder, pc);
>      }
> @@ -508,6 +518,11 @@ void trencoder_trace_trap_insn(Object *trencoder_obj=
,
>      g_autofree uint8_t *msg =3D g_malloc0(TRACE_MSG_MAX_SIZE);
>      uint8_t msg_size;
>
> +    if (trencoder->ntrace) {
> +        /* send IndirectBranchHist message */
> +        return;
> +    }
> +
>      if (trencoder->updiscon_pending) {
>          trencoder_send_updiscon(trencoder, pc);
>      }
> @@ -525,9 +540,15 @@ static void trencoder_send_branch_map(Object
> *trencoder_obj)
>      g_autofree uint8_t *msg =3D g_malloc0(TRACE_MSG_MAX_SIZE);
>      uint8_t msg_size;
>
> -    msg_size =3D rv_etrace_gen_encoded_format1_noaddr(msg,
> -                                                    te->branches,
> -                                                    te->branch_map);
> +    if (te->ntrace) {
> +        /* send ResourceFull message */
> +        return;
> +    } else {
> +        msg_size =3D rv_etrace_gen_encoded_format1_noaddr(msg,
> +                                                        te->branches,
> +                                                        te->branch_map);
> +    }
> +
>      trencoder_send_message_smem(te, msg, msg_size);
>  }
>
> diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c
> index cd57641d9b..9b43aeac09 100644
> --- a/target/riscv/trace_helper.c
> +++ b/target/riscv/trace_helper.c
> @@ -34,8 +34,12 @@ void helper_trace_updiscon(CPURISCVState *env)
>      RISCVCPU *cpu =3D env_archcpu(env);
>      TraceEncoder *te =3D TRACE_ENCODER(cpu->trencoder);
>
> -    te->updiscon_pending =3D true;
> -    te->trace_next_insn =3D true;
> +    if (te->ntrace) {
> +        /* send IndirectBranchHist message */
> +    } else {
> +        te->updiscon_pending =3D true;
> +        te->trace_next_insn =3D true;
> +    }
>  }
>
>  void helper_trace_branch(CPURISCVState *env, target_ulong pc, int taken)
>
> --
> 2.43.0
>
>
>

--000000000000c2275406607517ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div class=3D"gmail-gs" style=3D"margin:0px;min-width=
:0px;padding:0px 0px 20px;width:auto;font-family:&quot;Google Sans&quot;,Ro=
boto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:medium"><div class=3D=
"gmail-"><div class=3D"gmail-ii gmail-gt gmail-adO" id=3D"gmail-:15l" style=
=3D"direction:ltr;margin:8px 0px 0px;padding:0px;font-size:0.875rem;overflo=
w-x:hidden"><div class=3D"gmail-a3s gmail-aiL" id=3D"gmail-:15k" style=3D"d=
irection:ltr;font-style:normal;font-variant:normal;font-size-adjust:none;fo=
nt-kerning:auto;font-feature-settings:normal;font-stretch:normal;font-size:=
small;line-height:1.5;font-family:Arial,Helvetica,sans-serif;overflow:auto =
hidden"><div id=3D"gmail-avWBGd-82"><div dir=3D"ltr">Reviewed-by: Jay Chang=
&lt;<a href=3D"mailto:jay.chang@sifive.com" target=3D"_blank">jay.chang@sif=
ive.com</a>&gt;<div>Thanks</div></div></div></div></div><div class=3D"gmail=
-WhmR8e" id=3D"gmail-avWBGd-83" style=3D"clear:both"></div></div></div><br =
class=3D"gmail-Apple-interchange-newline"></div></div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tu=
e, Aug 25, 2026 at 10:49=E2=80=AFPM Konstantin Semichastnov &lt;<a href=3D"=
mailto:antikostya2@gmail.com">antikostya2@gmail.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">Selecting trace message =
format rely on `TraceEncoder-&gt;ntrace` flag.<br>
This flag mirrors trTeFormat bit.<br>
<br>
For now only two values supported:<br>
<br>
=C2=A0- E-Trace (trTeFormat =3D 0), trace format, described by Efficient tr=
ace spec.<br>
<br>
=C2=A0- N-Trace (trTeFormat =3D 1), trace format, described by Nexus trace =
spec.<br>
<br>
For now we not yet implemented any N-Trace messages, so currently<br>
`ntrace` field only disables E-Trace messages competely. We will reuse<br>
this field in following commits, when N-Trace messages added.<br>
<br>
Signed-off-by: Konstantin Semichastnov &lt;<a href=3D"mailto:antikostya2@gm=
ail.com" target=3D"_blank">antikostya2@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/riscv/trace-encoder.c=C2=A0 =C2=A0 | 29 +++++++++++++++++++++++++-=
---<br>
=C2=A0target/riscv/trace_helper.c |=C2=A0 8 ++++++--<br>
=C2=A02 files changed, 31 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c<br>
index 53345a478c..34c8f60ce1 100644<br>
--- a/hw/riscv/trace-encoder.c<br>
+++ b/hw/riscv/trace-encoder.c<br>
@@ -254,7 +254,11 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg,=
 uint64_t val)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!te-&gt;trace_running &amp;&amp; trTeInstTracing) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Starting trace. Ask the CPU for the fi=
rst trace insn */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;trace_next_insn =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (te-&gt;ntrace) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* send ProgTraceSync message */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;trace_next_insn =3D true;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0te-&gt;ramsink_ramstart =3D trencoder_rea=
d_ramsink_writep(te);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0te-&gt;ramsink_ramlimit =3D trencoder_rea=
d_ramsink_ramlimit(te);<br>
@@ -442,6 +446,8 @@ static void trencoder_send_sync_msg(Object *trencoder_o=
bj, uint64_t pc)<br>
=C2=A0 =C2=A0 =C2=A0uint8_t msg_size;<br>
=C2=A0 =C2=A0 =C2=A0bool is_branch_taken;<br>
<br>
+=C2=A0 =C2=A0 g_assert(!trencoder-&gt;ntrace);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0trencoder-&gt;first_pc =3D pc;<br>
=C2=A0 =C2=A0 =C2=A0is_branch_taken =3D trencoder_addr_is_branch_taken(tren=
coder, pc);<br>
=C2=A0 =C2=A0 =C2=A0msg_size =3D rv_etrace_gen_encoded_sync_msg(msg, pc, pr=
iv,<br>
@@ -458,6 +464,8 @@ static void trencoder_send_updiscon(TraceEncoder *trenc=
oder, uint64_t pc)<br>
=C2=A0 =C2=A0 =C2=A0bool updiscon =3D !notify;<br>
=C2=A0 =C2=A0 =C2=A0uint8_t msg_size;<br>
<br>
+=C2=A0 =C2=A0 g_assert(!trencoder-&gt;ntrace);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (trencoder-&gt;branches &gt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg_size =3D rv_etrace_gen_encoded_format=
1(format2_msg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 trencoder-&gt;branches,<br>
@@ -485,6 +493,8 @@ void trencoder_set_first_trace_insn(Object *trencoder_o=
bj, uint64_t pc)<br>
=C2=A0 =C2=A0 =C2=A0uint8_t msg_size;<br>
=C2=A0 =C2=A0 =C2=A0bool is_branch_taken;<br>
<br>
+=C2=A0 =C2=A0 g_assert(!trencoder-&gt;ntrace);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (trencoder-&gt;updiscon_pending) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trencoder_send_updiscon(trencoder, pc);<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -508,6 +518,11 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,<=
br>
=C2=A0 =C2=A0 =C2=A0g_autofree uint8_t *msg =3D g_malloc0(TRACE_MSG_MAX_SIZ=
E);<br>
=C2=A0 =C2=A0 =C2=A0uint8_t msg_size;<br>
<br>
+=C2=A0 =C2=A0 if (trencoder-&gt;ntrace) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* send IndirectBranchHist message */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (trencoder-&gt;updiscon_pending) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trencoder_send_updiscon(trencoder, pc);<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -525,9 +540,15 @@ static void trencoder_send_branch_map(Object *trencode=
r_obj)<br>
=C2=A0 =C2=A0 =C2=A0g_autofree uint8_t *msg =3D g_malloc0(TRACE_MSG_MAX_SIZ=
E);<br>
=C2=A0 =C2=A0 =C2=A0uint8_t msg_size;<br>
<br>
-=C2=A0 =C2=A0 msg_size =3D rv_etrace_gen_encoded_format1_noaddr(msg,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;branches,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;branch_map);<br>
+=C2=A0 =C2=A0 if (te-&gt;ntrace) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* send ResourceFull message */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_size =3D rv_etrace_gen_encoded_format1_noa=
ddr(msg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;branches,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;branch_map);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0trencoder_send_message_smem(te, msg, msg_size);<br>
=C2=A0}<br>
<br>
diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c<br>
index cd57641d9b..9b43aeac09 100644<br>
--- a/target/riscv/trace_helper.c<br>
+++ b/target/riscv/trace_helper.c<br>
@@ -34,8 +34,12 @@ void helper_trace_updiscon(CPURISCVState *env)<br>
=C2=A0 =C2=A0 =C2=A0RISCVCPU *cpu =3D env_archcpu(env);<br>
=C2=A0 =C2=A0 =C2=A0TraceEncoder *te =3D TRACE_ENCODER(cpu-&gt;trencoder);<=
br>
<br>
-=C2=A0 =C2=A0 te-&gt;updiscon_pending =3D true;<br>
-=C2=A0 =C2=A0 te-&gt;trace_next_insn =3D true;<br>
+=C2=A0 =C2=A0 if (te-&gt;ntrace) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* send IndirectBranchHist message */<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;updiscon_pending =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 te-&gt;trace_next_insn =3D true;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0void helper_trace_branch(CPURISCVState *env, target_ulong pc, int tak=
en)<br>
<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div>

--000000000000c2275406607517ea--

