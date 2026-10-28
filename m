Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D4E606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=Fc/4pgP5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLuFw-0001VJ-V3; Tue, 27 Oct 2026 23:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLuFs-0001Ut-PR
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 23:23:13 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLuFr-00043a-1o
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 23:23:12 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c418e215671so57452366b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 20:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793157789; x=1793762589; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mk3I4P3qvt9cpCXVVANHB7X1V9r2M3jD6i2IEfgksoA=;
 b=Fc/4pgP5RRhxSHEyru4TxmAXUzj8qh3RKqEBSuaLVDKW/7Rn9YsR7QPX7AZNo1xpla
 MeWIFgoVlnL7aaWsMPqeMl+9zHi+qrLH3wdpPo/Ih2SE1vB4uGUGrTTYaSS8kdlhLkIV
 fG/TIu4bZbOLwpWGOH5so7lgyuP3o1q88nYduVm0JKYvK/kQ2umi6J8/L2zTepq1eYsp
 yuyCkwh0uVTz8bQjRmKCON83sV+l9RH3SnzkGAhy8bvIASM08sqVutjwu/QbyCMiAbNp
 v0pwjnhdUhYhR/gxK6zrDTqNP38FrqXBiGgu0P2cxf4vSpn1YgJtcEILTOWPBgGddXpI
 oGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793157789; x=1793762589;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mk3I4P3qvt9cpCXVVANHB7X1V9r2M3jD6i2IEfgksoA=;
 b=lTBA5uArYlNNj8CCsTqkfAGUavZw+DCah1qTBIm3fl2tz+UYMVxuQfarYgS7KrMgsh
 jcAD0L+Ac3dDD+MqjYoMwM/4Tp9XBxR9/+WIXC3soJAyPZa6Lq8mw025oVne2qdcB5Yk
 pACkUAaMX3l9WUZaqcVu9zjBTot/s3Wit8y41+XFXWaV8NcG82Ul1rldSS2EiVyOJsyT
 m/iFDSoM2NeSX6etP2W0qNZtTHinPYqoQQ+MjJPuCKzlcDRHnqBW5L9S3azFOLwGJG36
 5jHHeZq3jYWPbqkGAbvbNOrqOKtQ379KTi8qq7g+uEkmaZ6b2YjgAJ21gTKEzR/1OIhF
 OJCg==
X-Gm-Message-State: AFq9FYLrjYRhJHSsu5FQcU9QOgfusdOS1DwUsz94xDAbECl/PJZAtD+M
 Tyrlm2r62JE7NKkaJg6W4mtfw/GC6idRTkNYklWHwwk4GmNJt1xP8YsMCi4/wZwQ2CIt8nYZ1F/
 FLCdu++brl+jqoVBzlcJ/K/uUsSS67QkJOOJlvrziikQa66F1gMPAb4gVWovoFsUUTAy2l5xbXP
 nGg8N3yxPhXhgnFdxmDnlOAsiXyLkL5QTtSJRe9eHxCxw=
X-Gm-Gg: AYBFou2HeBApLg91ttWXIhcXK27k3MYS9cCAj/mDQKPiWpOKb1s1Kw4i3/8BX+u74aK
 yEJ11i/lLvJeEmKSuoEN9Bq75IXtIS38oHmXIl6zkkR+yuTxZxa1y0Q1f43nLPhBqtjlwq6Z7UM
 lX59GegTrec3erVa4GiqitP2eaD/vBOGD6W1TfVJE07e+MDE6kjlOi4I7sxPtxe2fqJ914d8DOs
 8/rt3wJSc/obsfB1vxLPDFNA1CKdUNpNow0PigM4NJD5pfoEoyvJTmlo/O2V92FIYc0lKNiPQ+M
 gJA4nxS8C1prVERT7vmbzkRZqXdMDZ5fAEuGHQaI9Z0j1ZpIERAs4E/WkY0gYUbr8mEjQxQ6uux
 J9A+wugVoTZuOsiQ9xnZAgrH4Vx9lypeXtZbJ3GL0DnDo3qT0RL9UwaU+BIys9Ma99LvfKv1GrM
 62afa2BpAgea5ZKwz7+tzoP9bVYiWC64QA0GgLQVhpzItGiLCodv6X/L09eD0iEsgCwAkzkKYjw
 Yj4Le1F4aQEJiosygSKB4jsNV8lxwWJTYk69JND+GBsAMVi+wnUAYMc1fyQABCCqXq2AfEqOccE
 PqAu5iq2G7S7CcuTDw==
X-Received: by 2002:a17:907:2d09:b0:c3f:7270:10ab with SMTP id
 a640c23a62f3a-c49c633bf32mr6792466b.14.1793157789218; 
 Tue, 27 Oct 2026 20:23:09 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com.
 [209.85.208.53]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd5202d9sm544253266b.32.2026.10.27.20.23.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 20:23:06 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b3dc272dcfso783151a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 20:23:06 -0700 (PDT)
X-Received: by 2002:aa7:c6d5:0:b0:6b4:16be:4fa with SMTP id
 4fb4d7f45d1cf-6b49cbd6cd0mr385557a12.15.1793157785664; Tue, 27 Oct 2026
 20:23:05 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
 <20261021231346.2452179-13-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261021231346.2452179-13-daniel.barboza@oss.qualcomm.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Wed, 28 Oct 2026 11:22:54 +0800
X-Gmail-Original-Message-ID: <CAMXXpfZB8w_pJso4M4_ufOm99VbV6gfbUSKDNz4twFwfcTPgpw@mail.gmail.com>
X-Gm-Features: AclHuK9QdqaG-U3lqaLxdAeYzqbWYte2s4CGaiaJf8-nn3ySE5RrbwA2I8B6HtE
Message-ID: <CAMXXpfZB8w_pJso4M4_ufOm99VbV6gfbUSKDNz4twFwfcTPgpw@mail.gmail.com>
Subject: Re: [PATCH v4 12/18] target/riscv, hw/riscv: send trace ppccd packets
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, antikostya2@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>, frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="000000000000d741b4065ede1435"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=jay.chang@sifive.com; helo=mail-ej1-x635.google.com
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000d741b4065ede1435
Content-Type: text/plain; charset="UTF-8"

>
> -- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -943,11 +943,22 @@ void riscv_cpu_set_mode(CPURISCVState *env,
> privilege_mode_t newpriv,
>  {
>      g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
>
> +    CPUState *cs = env_cpu(env);
> +
>      if (newpriv != env->priv || env->virt_enabled != virt_en) {
>          if (icount_enabled()) {
>              riscv_itrigger_update_priv(env);
>          }
>
> +        if (newpriv != env->priv) {
> +            RISCVCPU *cpu = RISCV_CPU(cs);
> +
> +            if (cpu->trencoder &&
> +                TRACE_ENCODER(cpu->trencoder)->trace_running) {
> +                trencoder_trace_ppccd(cpu->trencoder, env->pc);
> +            }
> +        }
>
On the trap-entry path, env->pc has already been updated to the handler
address, but env->priv still holds the previous privilege level.
Emitting a PPCCD sync packet here therefore pairs the handler PC with
the old privilege level.

--000000000000d741b4065ede1435
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">-- a/target/riscv/tcg/cpu_helper.c=
<br>
+++ b/target/riscv/tcg/cpu_helper.c<br>
@@ -943,11 +943,22 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege=
_mode_t newpriv,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0g_assert(newpriv &lt;=3D PRV_M &amp;&amp; newpriv !=3D =
PRV_RESERVED);<br>
<br>
+=C2=A0 =C2=A0 CPUState *cs =3D env_cpu(env);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (newpriv !=3D env-&gt;priv || env-&gt;virt_enabled !=
=3D virt_en) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (icount_enabled()) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_itrigger_update_priv(=
env);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (newpriv !=3D env-&gt;priv) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCVCPU *cpu =3D RISCV_CPU(cs);=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu-&gt;trencoder &amp;&amp;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TRACE_ENCODER(cpu-=
&gt;trencoder)-&gt;trace_running) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trencoder_trace_pp=
ccd(cpu-&gt;trencoder, env-&gt;pc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div>On the trap-entry path,=
 env-&gt;pc has already been updated to the handler<br>address, but env-&gt=
;priv still holds the previous privilege level.<br>Emitting a PPCCD sync pa=
cket here therefore pairs the handler PC with<br>the old privilege level.</=
div><div>=C2=A0</div></div></div>

--000000000000d741b4065ede1435--

