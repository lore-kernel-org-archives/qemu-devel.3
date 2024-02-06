Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8598CC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 17:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOsx-0001eT-V9; Tue, 06 Feb 2024 12:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1rXOsw-0001bN-Gi
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 12:05:26 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1rXOsu-0001qn-OO
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 12:05:26 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5114fa38434so1422217e87.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 09:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1707239122; x=1707843922; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ronLFcwGuGPm3HRm7AEekZEu+FgU/Z5wgEror0nYXKc=;
 b=O6SBn54iKb1Qk+jCI8/30A86hqZSBhqBcXa+R2SS7ZcKgxxg2il+uTvU7PuQ3rkbxV
 TBg7d12Xhfl0x+1upTa7sJPf3H6W9XRDzgFOCmvLbGA3wEzoaDC1kKxtfVnRA1/6x351
 AAZu5FwEg4g/Ldl39jd0Idj2KdlCQkoX36JR5AZkqDLx0UNrlkm8+bqJ3WzQcvUivrb5
 tq+mNAiPwicg8XyNST/7E1laiuxIZ2AmMkn8z0kDWuCSIIri5Bsu+u/pZXxqbTbRZL4k
 XWTVNQ4Rcfxp3HXKzDmUpX/0JiM/1ezsT6SaaHZt5pDTioR9LQlwZ9NpimnW0V9vqPHF
 4ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707239122; x=1707843922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ronLFcwGuGPm3HRm7AEekZEu+FgU/Z5wgEror0nYXKc=;
 b=BBeWUhqImOW/wMsmWBtrlRAAEAfK+R917552ryojUX4dhHa3bxEWaKOra/PpxtQb2w
 CA8JMQEtC8oYx1x8TgrzJ+iZlkCMS0Cr5dP0l9P6D1NzV/ouoPrFy8eBGs+dgqyKmW5I
 VbOuHS94trxT7VPArFWf/QPM/7AnlJKGNa4EFZv47HnDOukcaqfuFrozYL1re6QdkmHg
 doXD3CtPDENlEmmqPOxtYnmrQMYbolad+5ZiPGdSZ6T+x6vwhKjUKGrG5JBy5Wa4k7OS
 j+h2PSpFKWO9ngCUgsxAGwdh74Qqqcz4p8R0V6KqnyxOjI3TbUrC/31OCP/q5vFPkoDe
 YXig==
X-Gm-Message-State: AOJu0Yx+41gALXoiVziSfVSbazr86qAtzv6PZ9Xu5cS8MUM9d4HXsl3U
 S3M74zMjtrfbnjoQQqqAMRxcmyWzvmGyw6hIK497ixjLxMuMWeqkQKeIu/rkUEdLDAL9FX0eJT7
 uhZu/ciZW6OhfG/CM0pj13vhdlNVgStYNel3+Wb66T73RRCc+j4zKof/IgCXhylxVUosz1JlIe2
 4LjrHghjVW3wZfrGl6wBCNkisHHguvN6Uyzw1t2Yz9gA==
X-Google-Smtp-Source: AGHT+IFJ1PjEjXy+1vO5SXhnBZsmerKyQM0Vr6xL75n4WjM62F/hKvfMLN2vwQzXOQsnwQ+vj40N9Q==
X-Received: by 2002:ac2:5e24:0:b0:511:5757:633f with SMTP id
 o4-20020ac25e24000000b005115757633fmr2178633lfg.17.1707239122164; 
 Tue, 06 Feb 2024 09:05:22 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWsu8344A3wR+SyvMzlXOT+hceJVPBn25ASy5XC05TStMB7H3cuXxSybzUULYXcFFxQpiQURLIdX8YyQmxragVM/GN7Zj0=
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com.
 [209.85.167.41]) by smtp.gmail.com with ESMTPSA id
 p2-20020a056512328200b005101bbbfc2bsm285742lfe.263.2024.02.06.09.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 09:05:21 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-51160b0ecd9so860357e87.2; 
 Tue, 06 Feb 2024 09:05:21 -0800 (PST)
X-Received: by 2002:a05:6512:3084:b0:511:4cc9:33a4 with SMTP id
 z4-20020a056512308400b005114cc933a4mr3109063lfd.52.1707239121374; Tue, 06 Feb
 2024 09:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20240206131911.10998-1-jason.chien@sifive.com>
In-Reply-To: <20240206131911.10998-1-jason.chien@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Wed, 7 Feb 2024 01:05:09 +0800
X-Gmail-Original-Message-ID: <CANzO1D0Bhdugi6gbL-sLsW5yF-Fd=oV699-zw2PqpJ7DTt_PMw@mail.gmail.com>
Message-ID: <CANzO1D0Bhdugi6gbL-sLsW5yF-Fd=oV699-zw2PqpJ7DTt_PMw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Update $pc after linking to $ra in
 trans_cm_jalt()
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000060562c0610b995bb"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--00000000000060562c0610b995bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Frank Chang <frank.chang@sifive.com>

On Tue, Feb 6, 2024 at 9:19=E2=80=AFPM Jason Chien <jason.chien@sifive.com>=
 wrote:

> The original implementation sets $pc to the address read from the jump
> vector table first and links $ra with the address of the next instruction
> after the updated $pc. After jumping to the updated $pc and executing the
> next ret instruction, the program jumps to $ra, which is in the same
> function currently executing, which results in an infinite loop.
> This commit reverses the two action. Firstly, $ra is updated with the
> address of the next instruction after $pc, and sets $pc to the address
> read from the jump vector table.
>
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvzce.c.inc | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc
> b/target/riscv/insn_trans/trans_rvzce.c.inc
> index 8d8a64f493..a185e2315f 100644
> --- a/target/riscv/insn_trans/trans_rvzce.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
> @@ -293,13 +293,6 @@ static bool trans_cm_jalt(DisasContext *ctx,
> arg_cm_jalt *a)
>  {
>      REQUIRE_ZCMT(ctx);
>
> -    /*
> -     * Update pc to current for the non-unwinding exception
> -     * that might come from cpu_ld*_code() in the helper.
> -     */
> -    gen_update_pc(ctx, 0);
> -    gen_helper_cm_jalt(cpu_pc, cpu_env, tcg_constant_i32(a->index));
> -
>      /* c.jt vs c.jalt depends on the index. */
>      if (a->index >=3D 32) {
>          TCGv succ_pc =3D dest_gpr(ctx, xRA);
> @@ -307,6 +300,13 @@ static bool trans_cm_jalt(DisasContext *ctx,
> arg_cm_jalt *a)
>          gen_set_gpr(ctx, xRA, succ_pc);
>      }
>
> +    /*
> +     * Update pc to current for the non-unwinding exception
> +     * that might come from cpu_ld*_code() in the helper.
> +     */
> +    gen_update_pc(ctx, 0);
> +    gen_helper_cm_jalt(cpu_pc, cpu_env, tcg_constant_i32(a->index));
> +
>      tcg_gen_lookup_and_goto_ptr();
>      ctx->base.is_jmp =3D DISAS_NORETURN;
>      return true;
> --
> 2.43.0
>
>
>

--00000000000060562c0610b995bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang=
@sifive.com">frank.chang@sifive.com</a>&gt;</div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 6, 2024 at 9:19=E2=
=80=AFPM Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.com">jason.ch=
ien@sifive.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">The original implementation sets $pc to the address read from=
 the jump<br>
vector table first and links $ra with the address of the next instruction<b=
r>
after the updated $pc. After jumping to the updated $pc and executing the<b=
r>
next ret instruction, the program jumps to $ra, which is in the same<br>
function currently executing, which results in an infinite loop.<br>
This commit reverses the two action. Firstly, $ra is updated with the<br>
address of the next instruction after $pc, and sets $pc to the address<br>
read from the jump vector table.<br>
<br>
Signed-off-by: Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.com" ta=
rget=3D"_blank">jason.chien@sifive.com</a>&gt;<br>
---<br>
=C2=A0target/riscv/insn_trans/trans_rvzce.c.inc | 14 +++++++-------<br>
=C2=A01 file changed, 7 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_=
trans/trans_rvzce.c.inc<br>
index 8d8a64f493..a185e2315f 100644<br>
--- a/target/riscv/insn_trans/trans_rvzce.c.inc<br>
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc<br>
@@ -293,13 +293,6 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm_ja=
lt *a)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0REQUIRE_ZCMT(ctx);<br>
<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* Update pc to current for the non-unwinding exception=
<br>
-=C2=A0 =C2=A0 =C2=A0* that might come from cpu_ld*_code() in the helper.<b=
r>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 gen_update_pc(ctx, 0);<br>
-=C2=A0 =C2=A0 gen_helper_cm_jalt(cpu_pc, cpu_env, tcg_constant_i32(a-&gt;i=
ndex));<br>
-<br>
=C2=A0 =C2=A0 =C2=A0/* c.jt vs c.jalt depends on the index. */<br>
=C2=A0 =C2=A0 =C2=A0if (a-&gt;index &gt;=3D 32) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv succ_pc =3D dest_gpr(ctx, xRA);<br>
@@ -307,6 +300,13 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm_ja=
lt *a)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_set_gpr(ctx, xRA, succ_pc);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Update pc to current for the non-unwinding exception=
<br>
+=C2=A0 =C2=A0 =C2=A0* that might come from cpu_ld*_code() in the helper.<b=
r>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 gen_update_pc(ctx, 0);<br>
+=C2=A0 =C2=A0 gen_helper_cm_jalt(cpu_pc, cpu_env, tcg_constant_i32(a-&gt;i=
ndex));<br>
+<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_lookup_and_goto_ptr();<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;base.is_jmp =3D DISAS_NORETURN;<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div>

--00000000000060562c0610b995bb--

