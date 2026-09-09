Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093CEC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Prv-00079O-5l; Wed, 09 Sep 2026 17:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1x4Prt-000756-5i; Wed, 09 Sep 2026 17:30:10 -0400
Received: from mail-07.mail-europe.com ([37.187.220.204])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1x4Prn-0003C2-N5; Wed, 09 Sep 2026 17:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=5hrwh5ecj5e37oycfptl43ouuy.protonmail; t=1788989395; x=1789248595;
 bh=PW59cMrmwWyr6MGeEwGaszieMNWIiortXadVDHe7r/k=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=E7CN/mBnhEfsdtofH/MaUxs58ZjtT93C0c47knr/MG4o2lX522do/ZmNm8WUnyOCy
 AOEseR1LbXy5NbIs0EMRWTlmKD+FqUU92bCzHDaCvKAA6PsOQqUJsco8U081Ionj23
 810o+SPG3unI/D2VymqyACtJRjK56kNj32YPYRMV2TKiGBA7yQiP96GgPbXPGPDGIS
 tLRMX3976gMbICxS1uYERo5nudsAsnzI1t09sl5zXDIHRXWmQGZzARNkOnjRHqqF0A
 gncaN9HH1iWFtFO1jJkI/4de8Mq0lAwlwSceLKEy/SGUMq/kox+tytfr1nVjAJKeWG
 KoH7Ug6Zn0x/A==
Date: Wed, 09 Sep 2026 21:29:46 +0000
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
From: Christian <christianslima@proton.me>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: Re: [PATCH] target/riscv/tcg: svinval instructions raise virtual
 instruction
Message-ID: <tg7qNQGvNyXBGgDnONN58iemm20yWr5lyZ8tCdhJ-HqZm8aiqHd6Ru-K-E325IoYPLUY7H0CWyc8l8mHo-Lsg1g6vqh3vQgNkxGKb8AM0dY=@proton.me>
In-Reply-To: <ee67fe57-7098-4905-8eda-24175bb889fa@oss.qualcomm.com>
References: <20260908222825.84642-1-christianslima@proton.me>
 <ee67fe57-7098-4905-8eda-24175bb889fa@oss.qualcomm.com>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: 16b9793c0a4ec4bf5298b18ac21f68393d0c1832
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=37.187.220.204;
 envelope-from=christianslima@proton.me; helo=mail-07.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi, Daniel

> Hi,
>=20
> On 9/8/2026 7:28 PM, Christian S. Lima wrote:
> > The risc v privileged specification requires hinval.vvma, hinval.gvma,
> > sfence.w.inval and sfence.inval.ir should raise a virtual instruction
> > exception when executed in the vu-mode. This patch add the check to
> > raise the virtual instruction exception when is in the vu-mode.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3621
> >
> > Signed-off-by: Christian S. Lima <christianslima@proton.me>
> > ---
> >   target/riscv/tcg/insn_trans/trans_svinval.c.inc |  4 ++++
> >   target/riscv/tcg/insn_trans/trans_xthead.c.inc  | 13 ++++++++-----
> >   2 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/target/riscv/tcg/insn_trans/trans_svinval.c.inc b/target/r=
iscv/tcg/insn_trans/trans_svinval.c.inc
> > index 4614c1489c..251d9c5815 100644
> > --- a/target/riscv/tcg/insn_trans/trans_svinval.c.inc
> > +++ b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
> > @@ -25,8 +25,12 @@
> >   /* Test if priv level is M or S. */
> >   #define REQUIRE_PRIV_MS(ctx) do {          \
> >       if (ctx->priv =3D=3D PRV_U) {              \
> > +        if (ctx->virt_enabled) {           \
> > +            ctx->virt_inst_excp =3D true;    \
> > +        }                                  \
> >           return false;                      \
> >       }                                      \
> > +    return true;                           \
>=20
> We can't 'return true' in this macro.  This is a "return false if wrong, =
otherwise
> do nothing" macro that this file uses.  It works like REQUIRE_SVINVAL():
>=20
> #define REQUIRE_SVINVAL(ctx) do {          \
>      if (!ctx->cfg_ptr->ext_svinval) {      \
>          return false;                      \
>      }                                      \
> } while (0)
>=20
>=20
> If you look at trans_sinval_vma(), adding a 'return true' in REQUIRE_PRIV=
_MS() will
> cause an early exit right after the macro, short-circuiting everything af=
ter it:
>=20
> static bool trans_sinval_vma(DisasContext *ctx, arg_sinval_vma *a)
> {
>      REQUIRE_SVINVAL(ctx);
>      /* Do the same as sfence.vma currently */
>      REQUIRE_EXT(ctx, RVS);
>      REQUIRE_PRIV_MS(ctx);  <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> #ifndef CONFIG_USER_ONLY
>      decode_save_opc(ctx, 0);
>      gen_helper_tlb_flush(tcg_env);
>      return true;
> #endif
>      return false;
>=20
>=20
> Same thing with REQUIRE_PRIV_MS(ctx) in trans_xthead.c.inc down below: we=
 can't add a
> 'return true' in it too.

I see, I did tests again without the `return true;` and the code works as e=
xpected. I'll fix this in the v2.

>=20
>=20
>=20
> Cheers,
> Daniel
>=20
> >   } while (0)
> >
> >   static bool trans_sinval_vma(DisasContext *ctx, arg_sinval_vma *a)
> > diff --git a/target/riscv/tcg/insn_trans/trans_xthead.c.inc b/target/ri=
scv/tcg/insn_trans/trans_xthead.c.inc
> > index f4e3051000..c00b007895 100644
> > --- a/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> > +++ b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> > @@ -267,11 +267,14 @@ static bool trans_th_tst(DisasContext *ctx, arg_t=
h_tst *a)
> >   #define REQUIRE_PRIV_MSU(ctx)
> >
> >   /* Test if priv level is M or S. */
> > -#define REQUIRE_PRIV_MS(ctx)                                    \
> > -do {                                                            \
> > -    if (ctx->priv =3D=3D PRV_U) {                                   \
> > -        return false;                                           \
> > -    }                                                           \
> > +#define REQUIRE_PRIV_MS(ctx) do {          \
> > +    if (ctx->priv =3D=3D PRV_U) {              \
> > +        if (ctx->virt_enabled) {           \
> > +            ctx->virt_inst_excp =3D true;    \
> > +        }                                  \
> > +        return false;                      \
> > +    }                                      \
> > +    return true;                           \
> >   } while (0)
> >
> >   #define NOP_PRIVCHECK(insn, extcheck, privcheck)                \
>=20
>=20

Thanks,
Christian

