Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2BBC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 05:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7TNz-0003vh-73; Thu, 16 May 2024 01:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s7TNr-0003uz-NQ; Thu, 16 May 2024 01:10:28 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s7TNp-0006AK-DW; Thu, 16 May 2024 01:10:27 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-4e1513b8829so369544e0c.3; 
 Wed, 15 May 2024 22:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715836224; x=1716441024; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWiglJg0pVMLpd6q+xzywXY5WHRF0H5vl6FEj4Kvizc=;
 b=AY/4X1kiozXDM91+NC0AEZfL9nzydvW5xUKCUZ/3WdAtTY0lsFcAJ2HOBiDkhSTq9y
 0toCh2eBFcuCOI5T90DRNGUTymJ2qaKIdgGJ1CKlWkgPhe9gtyfKnwAzUvlz41yteBgk
 x8UUG3qFmfMPEMob6vTiXwd+iGM2Nym9gnW5MYy5cJ2IA9JIBfZAtgITq6ApzPq1dPVt
 Zw3QH3A3kceWZV+3E5uQszNDfihdyHetSrFS4sWv2g1G+5uI0vONDldmqST1rq6Thd99
 vV6OqLXEhUplOQmpjL8oTQYHHLKu0AJXUVBi1ixrMBJDqW0TJMVgQZ0rYGzaTriYAlkY
 1fGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715836224; x=1716441024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mWiglJg0pVMLpd6q+xzywXY5WHRF0H5vl6FEj4Kvizc=;
 b=TZLHT0vZBX6C7ZZcz4OX575Tbu4+r6ebg5fgcMUbvs6OiTmEcMtcFH0Niu1+A/Wm0b
 RsKPl9IeYOR9rxsUM3SqSeUTLUfDzah8hec7oCO/sGaFQgKZCNIyLvTsN7O0993il5o2
 f0sR2zhQ3n8oDUYpVGZm4iAdxUKcZpKCTpWbF7YzjzHQrz3Egg8vOXRKFaul+RL9/xxt
 sB8DMb2IbE4kalAMYcoKs60Dy1cBq+9Ysf36UO66GQUQTKRfmYzBpF5Hml3bzaSl3KFb
 SGOFTYw0jgXXqTa+yet4u8BEQCZxk63BWyadjz4e0RK6k9ohEZMTjBAb+YaU8QF9LPr2
 6hHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE13KFNRUdcg7fMbxr+zcrdfg17S83eoQ1c2mcFLE1xW+dsh8wBhE0sOdPdvH9Zkfm45qCzXcuI0WXDSh3TVzS1fKWLrk=
X-Gm-Message-State: AOJu0Yww7mDBX1nzWV4OmXxtcAr1E298bK+Ir8rckfk2pryHiXf5hTca
 jZ8ySQrI3yF735fzAdXhnuFJB0CmjU7ZS9hwHOrO3cDyzQ4ZYHcN5qzR1QighGyEp7NGjLPhg+K
 7fF/rkrjDnufq8cQ5kUZnFRyjx2A=
X-Google-Smtp-Source: AGHT+IFMAWzRprTfVJoZWJFJrJQpRTRy2OHM1ehKdpGdzXImib9kJ3yH5Q2eV7Ox6WYEroEXitmn1xWiKwIy+TT4vNE=
X-Received: by 2002:a05:6122:2018:b0:4d3:3846:73bb with SMTP id
 71dfb90a1353d-4df882c5cd8mr16886290e0c.7.1715836223738; Wed, 15 May 2024
 22:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240514023910.301766-1-alistair.francis@wdc.com>
 <14e88990-963c-45ef-bf51-662d54857c6e@ventanamicro.com>
In-Reply-To: <14e88990-963c-45ef-bf51-662d54857c6e@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 May 2024 15:09:57 +1000
Message-ID: <CAKmqyKP5dwLnvuXDbJkDV=CCGAsoVuyES7m+NB=7KceFEHoKzQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: rvzicbo: Fixup CBO extension register
 calculation
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@dabbelt.com, bin.meng@windriver.com, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, fabian.thomas@cispa.de, 
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, May 14, 2024 at 7:11=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 5/13/24 23:39, Alistair Francis wrote:
> > When running the instruction
> >
> > ```
> >      cbo.flush 0(x0)
> > ```
> >
> > QEMU would segfault.
> >
> > The issue was in cpu_gpr[a->rs1] as QEMU does not have cpu_gpr[0]
> > allocated.
> >
> > In order to fix this let's use the existing get_address()
> > helper. This also has the benefit of performing pointer mask
> > calculations on the address specified in rs1.
> >
> > The pointer masking specificiation specifically states:
> >
> > """
> > Cache Management Operations: All instructions in Zicbom, Zicbop and Zic=
boz
> > """
> >
> > So this is the correct behaviour and we previously have been incorrectl=
y
> > not masking the address.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reported-by: Fabian Thomas <fabian.thomas@cispa.de>
> > Fixes: e05da09b7cfd ("target/riscv: implement Zicbom extension")
> > ---
>
> LGTM but I wonder if this is the same fix as this one sent by Phil a mont=
h
> ago or so:
>
> https://lore.kernel.org/qemu-riscv/20240419110514.69697-1-philmd@linaro.o=
rg/
> ("[PATCH] target/riscv: Use get_address() to get address with Zicbom exte=
nsions")

It is the same fix!

I somehow missed that patch at the time. Sorry Philippe!

I'm going to merge this one as it includes the details about pointer
masking, which I think is useful as that's why we are using
get_address() instead of get_gpr()

Alistair

>
>
> Thanks,
>
> Daniel
>
> >   target/riscv/insn_trans/trans_rvzicbo.c.inc | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv=
/insn_trans/trans_rvzicbo.c.inc
> > index d5d7095903..15711c3140 100644
> > --- a/target/riscv/insn_trans/trans_rvzicbo.c.inc
> > +++ b/target/riscv/insn_trans/trans_rvzicbo.c.inc
> > @@ -31,27 +31,35 @@
> >   static bool trans_cbo_clean(DisasContext *ctx, arg_cbo_clean *a)
> >   {
> >       REQUIRE_ZICBOM(ctx);
> > -    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
> > +    TCGv src =3D get_address(ctx, a->rs1, 0);
> > +
> > +    gen_helper_cbo_clean_flush(tcg_env, src);
> >       return true;
> >   }
> >
> >   static bool trans_cbo_flush(DisasContext *ctx, arg_cbo_flush *a)
> >   {
> >       REQUIRE_ZICBOM(ctx);
> > -    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
> > +    TCGv src =3D get_address(ctx, a->rs1, 0);
> > +
> > +    gen_helper_cbo_clean_flush(tcg_env, src);
> >       return true;
> >   }
> >
> >   static bool trans_cbo_inval(DisasContext *ctx, arg_cbo_inval *a)
> >   {
> >       REQUIRE_ZICBOM(ctx);
> > -    gen_helper_cbo_inval(tcg_env, cpu_gpr[a->rs1]);
> > +    TCGv src =3D get_address(ctx, a->rs1, 0);
> > +
> > +    gen_helper_cbo_inval(tcg_env, src);
> >       return true;
> >   }
> >
> >   static bool trans_cbo_zero(DisasContext *ctx, arg_cbo_zero *a)
> >   {
> >       REQUIRE_ZICBOZ(ctx);
> > -    gen_helper_cbo_zero(tcg_env, cpu_gpr[a->rs1]);
> > +    TCGv src =3D get_address(ctx, a->rs1, 0);
> > +
> > +    gen_helper_cbo_zero(tcg_env, src);
> >       return true;
> >   }

