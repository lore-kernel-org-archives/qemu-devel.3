Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA801C83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 10:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYj7c-00089X-7m; Mon, 07 Jul 2025 06:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uYj7Y-00084k-Dt
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 06:30:48 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uYj7M-0008H8-Fo
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 06:30:38 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-611e455116aso2268182eaf.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 03:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1751884234; x=1752489034; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hbY7xsASZH5Ki71DDj7oWoVU52ZbX4v+wWPwQU08RcE=;
 b=H0TsxOI6qUzCiqs51orbA919gEshoRa1B+uxbapIpYOccdmtEUo6R91HHPJjK2ByGT
 2Jevp6/yLpy1bZJ3clDv8EkVu7RZ18fJ8cd06UyalG/9KR66ynHzlJYpvbHiSZ3rxMRy
 8hb3C3Q9MoJFrQ6b8sib/XJsvSBEcqyEYYgKr5wHDHuJVlsGARAA1pKkdre9e5cWrpPW
 jVksQK5Px9I/ppyLuwrG5N1yn8KdUtjawaOrqPcV28sCRzlKPQseCtiinBKyBr3poXtu
 VMKBkGMVpqs4VN6gL1mq6Ro1xgDlKPV5tGLy0lVRXSXPSqgSa0gS2WwErocLDZIMCKA1
 XkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751884234; x=1752489034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hbY7xsASZH5Ki71DDj7oWoVU52ZbX4v+wWPwQU08RcE=;
 b=V+dnDHUhBnKfXTBdgsOsOG6M0bHLkGDVCBNoR5vbDCXf0mhxi9agi5SOLueOVaBLK+
 XwEE4LX6CXcU+ZP53sINyNo2akHIYNNWKCLywDhBBpSNP5xzxWGFqvwynGsThrlqBH3W
 2BDtopswXZ8tEZ1RAalP1VRejN4KdKyac+KScTmBMiyDT2gLklvt32G6XywfCZOgThK/
 c9fAuGj+doV2ZLj7gds1Sm+7gGZ5OCMM1SbnY0WgtEySd8CTJpyagJu2tnxJl8Kyn8Yv
 ziftt6zdKQGk+5Ip5Hx1O+ReeT8P3jBvcL0yhF0WXB2IoTJINnNmwd7+fkaYr1LN6w17
 DVBQ==
X-Gm-Message-State: AOJu0Yw6csEHDfTsO+e/UY12IHcUrSs7yRW8W4Sv8HnJUKcPKhxCBqtS
 IpgcxEEGS2WWd60dXyoURuL7DycS+S3Rck8S+1VcJ4SVwTx7tQKob//VS4disaPfVWF4xJKU7YW
 Uf4tjMBPgrigBCXZCRAvd5hOvoilHy0y8WUaFfMZ3Tg==
X-Gm-Gg: ASbGnctlwS/YoRSMVgW/5JhFw1XRkeg3jkKOhF4CoSsycIHXCwHrUQX5PJKfkOoqBlE
 Os4VG8MtDy//VWD9SxgV0fVibtk/l53DJHOx0HFFazqswttDY6w/egcoH9Zbp9zDISKBrwgcs1S
 gGit4bSqqTG2bc16O30OE7zR1+eRcapfn/GfFnfiuqcVGA/v1D84uEimCo
X-Google-Smtp-Source: AGHT+IHBtAq/RAlSU+f8+IYVo8yDxzwxfehYwTm9QXPmhBKER1xQ5qk03tn3nFDGIGQZKDrf3cFS6+8vaZhUrGHbTpU=
X-Received: by 2002:a05:6870:a44f:b0:2c1:5fe3:22eb with SMTP id
 586e51a60fabf-2f796adb1b5mr7907278fac.15.1751884233761; Mon, 07 Jul 2025
 03:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250627132022.439315-1-max.chou@sifive.com>
 <20250627132022.439315-3-max.chou@sifive.com>
 <69d73c59-2ff6-4446-ac23-c36b0e299afc@lanxincomputing.com>
In-Reply-To: <69d73c59-2ff6-4446-ac23-c36b0e299afc@lanxincomputing.com>
From: Max Chou <max.chou@sifive.com>
Date: Mon, 7 Jul 2025 18:30:22 +0800
X-Gm-Features: Ac12FXwOJiDT55ugBmk6c6JzLrp5kTmm5uLNuXJknpheqD_tlruHMRS6kNk0h_I
Message-ID: <CANiaA1shTxcmAF2+dN-ui0nd_wnrY9kaQtMorB1hAXvF+KNjHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] target/riscv: rvv: Apply vext_check_input_eew to
 vector reduction instructions
To: Nutty Liu <liujingqi@lanxincomputing.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com
Content-Type: multipart/alternative; boundary="00000000000070ffd606395455fe"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=max.chou@sifive.com; helo=mail-oo1-xc35.google.com
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

--00000000000070ffd606395455fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nutty,

Thanks for the suggestion.
I'll provide a new version including the new description and a fix about
another EEWs issue.

Thanks,
Max


On Tue, Jul 1, 2025 at 2:43=E2=80=AFPM Nutty Liu <liujingqi@lanxincomputing=
.com>
wrote:

> On 6/27/2025 9:20 PM, Max Chou wrote:
> > From: Anton Blanchard <antonb@tenstorrent.com>
> >
> > Handle the overlap of source registers with different EEWs.
>
> Above description is the same as [patch v2 1/3].
> They are different functions.
> Maybe need to add some different description.
>
> Otherwise,
> Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>
>
> Thanks,
> Nutty
>
> >
> > Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> > Signed-off-by: Max Chou <max.chou@sifive.com>
> > ---
> >   target/riscv/insn_trans/trans_rvv.c.inc | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/insn_trans/trans_rvv.c.inc
> b/target/riscv/insn_trans/trans_rvv.c.inc
> > index ec34d0d8c47..ac6f1d04c6d 100644
> > --- a/target/riscv/insn_trans/trans_rvv.c.inc
> > +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> > @@ -3293,6 +3293,7 @@ static bool reduction_check(DisasContext *s,
> arg_rmrr *a)
> >   {
> >       return require_rvv(s) &&
> >              vext_check_isa_ill(s) &&
> > +           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew,
> a->vm) &&
> >              vext_check_reduction(s, a->rs2);
> >   }
> >
> > @@ -3309,7 +3310,8 @@ GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
> >   static bool reduction_widen_check(DisasContext *s, arg_rmrr *a)
> >   {
> >       return reduction_check(s, a) && (s->sew < MO_64) &&
> > -           ((s->sew + 1) <=3D (s->cfg_ptr->elen >> 4));
> > +           ((s->sew + 1) <=3D (s->cfg_ptr->elen >> 4)) &&
> > +           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew + 1,
> a->vm);
> >   }
> >
> >   GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_widen_check)
>

--00000000000070ffd606395455fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Nutty,</div><div><br></div><div>Thanks for th=
e suggestion.</div><div>I&#39;ll provide a new version including the new de=
scription and a fix about another EEWs issue.</div><div><br></div><div><div=
 dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><=
div dir=3D"ltr">Thanks,<br>Max</div></div></div><br></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Tue, Jul 1, 2025 at 2:43=E2=80=AFPM Nutty Liu &lt;<a href=3D"mailto:liuji=
ngqi@lanxincomputing.com">liujingqi@lanxincomputing.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,2=
04);padding-left:1ex">On 6/27/2025 9:20 PM, Max Chou wrote:<br>
&gt; From: Anton Blanchard &lt;<a href=3D"mailto:antonb@tenstorrent.com" ta=
rget=3D"_blank">antonb@tenstorrent.com</a>&gt;<br>
&gt;<br>
&gt; Handle the overlap of source registers with different EEWs.<br>
<br>
Above description is the same as [patch v2 1/3].<br>
They are different functions.<br>
Maybe need to add some different description.<br>
<br>
Otherwise,<br>
Reviewed-by: Nutty Liu&lt;<a href=3D"mailto:liujingqi@lanxincomputing.com" =
target=3D"_blank">liujingqi@lanxincomputing.com</a>&gt;<br>
<br>
Thanks,<br>
Nutty<br>
<br>
&gt;<br>
&gt; Signed-off-by: Anton Blanchard &lt;<a href=3D"mailto:antonb@tenstorren=
t.com" target=3D"_blank">antonb@tenstorrent.com</a>&gt;<br>
&gt; Signed-off-by: Max Chou &lt;<a href=3D"mailto:max.chou@sifive.com" tar=
get=3D"_blank">max.chou@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/insn_trans/trans_rvv.c.inc | 4 +++-<br>
&gt;=C2=A0 =C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/in=
sn_trans/trans_rvv.c.inc<br>
&gt; index ec34d0d8c47..ac6f1d04c6d 100644<br>
&gt; --- a/target/riscv/insn_trans/trans_rvv.c.inc<br>
&gt; +++ b/target/riscv/insn_trans/trans_rvv.c.inc<br>
&gt; @@ -3293,6 +3293,7 @@ static bool reduction_check(DisasContext *s, arg=
_rmrr *a)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return require_rvv(s) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vext_check_isa_ill(s) =
&amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vext_check_input_eew(s, a-&g=
t;rs1, s-&gt;sew, a-&gt;rs2, s-&gt;sew, a-&gt;vm) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vext_check_reduction(s=
, a-&gt;rs2);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -3309,7 +3310,8 @@ GEN_OPIVV_TRANS(vredxor_vs, reduction_check)<br>
&gt;=C2=A0 =C2=A0static bool reduction_widen_check(DisasContext *s, arg_rmr=
r *a)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return reduction_check(s, a) &amp;&amp; (s-&=
gt;sew &lt; MO_64) &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((s-&gt;sew + 1) &lt;=3D (s-=
&gt;cfg_ptr-&gt;elen &gt;&gt; 4));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((s-&gt;sew + 1) &lt;=3D (s-=
&gt;cfg_ptr-&gt;elen &gt;&gt; 4)) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vext_check_input_eew(s, a-&g=
t;rs1, s-&gt;sew, a-&gt;rs2, s-&gt;sew + 1, a-&gt;vm);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_widen_check)<=
br>
</blockquote></div>

--00000000000070ffd606395455fe--

