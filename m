Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7F0C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvHB-00043O-Ao; Fri, 28 Aug 2026 08:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liumingliang.dev@bytedance.com>)
 id 1wzvH4-0003xx-EG
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:01:35 -0400
Received: from va-1-114.ptr.blmpb.com ([209.127.230.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liumingliang.dev@bytedance.com>)
 id 1wzvGy-0000rq-9r
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787918478; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=cmkpcGoKPgxevNKBFdQTRdSCicl6GwGpvzSSWTybcLs=;
 b=Ze9YcznDvp7P3rBx0rMFYGpJgrO94j6B1AGi0brOtan4kkeg8Gyx4s5aaP5cL5Eas2IJqd
 znktMfEgXiBkJ+xrGCsmZwSrOFTP170wx6aOcak5OYmvW0z6HsVg//PDZYj6KJOZcKS6fV
 LdZoXvZBOQcik/rfWZCWIV5j975xBAUpM4k+4CdrNFc8g6X9sZsg74KlAAVxCl8WCi2e3A
 iirYZZdgLWQuBAh5GhVYtvfE8UuhOCfZvdJYKAARC1bJAacFK0gnWkf4zi843B54Aoh4k0
 6h0VbtxokyUkrd5yc1/bgcXhXK7ybz7HDgW3JXaoXs+fHsNmV5t0vBr1dQ26dQ==
Date: Fri, 28 Aug 2026 20:01:14 +0800
Message-Id: <ee7ee3a1f02a7e7cbb15b78aec59fd82060d2306.450f9d23.be8a.4745.93e4.f94f8b9058aa@bytedance.com>
To: "Daniel Henrique Barboza" <daniel.barboza@oss.qualcomm.com>
Mime-Version: 1.0
References: <20260828092053.3787517-1-liumingliang.dev@bytedance.com>
 <11e5ab2c-b87e-4033-a424-028e42dc9954@oss.qualcomm.com>
In-Reply-To: <11e5ab2c-b87e-4033-a424-028e42dc9954@oss.qualcomm.com>
X-Lms-Return-Path: <lba+16a91788c+40b488+nongnu.org+liumingliang.dev@bytedance.com>
Content-Type: multipart/alternative;
 boundary=ad8fb322d1c23b556c768fb458fc4fb8702cd956827b899f757d42dc30af
Cc: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, 
 <Alistair.Francis@wdc.com>, <zhiwei_liu@linux.alibaba.com>, 
 <liwei1518@gmail.com>, <chao.liu@processmission.com>, 
 "Zhibo Hong" <hongzhibo@bytedance.com>
Subject: Re: [PATCH] target/riscv: Add experimental Zvabd extension support
From: =?utf-8?q?=E5=88=98=E9=B8=A3=E4=BA=AE?= <liumingliang.dev@bytedance.com>
Received-SPF: pass client-ip=209.127.230.114;
 envelope-from=liumingliang.dev@bytedance.com; helo=va-1-114.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--ad8fb322d1c23b556c768fb458fc4fb8702cd956827b899f757d42dc30af
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Daniel,
Thanks for your advice. I=E2=80=99ll add more tests for this patch.

In the latest specification, vabs.v is defined as a pseudo-instruction that=
 aliases vabd.vx rd, vs2, x0, similar to how vneg.v aliases vrsub.vx rd, vs=
2, x0. I think we don't need add vabs.v as a separate instruction, since th=
ey share the same encoding.

See the vabs.v at: https://github.com/riscv/riscv-isa-manual/pull/3279/chan=
ges#diff-c4a6db324416cc1f52c849a8cd5a20b5d8b5e422ffca6dcb6f341b5f1df48a15R1=
10

> From: "Daniel Henrique Barboza"<daniel.barboza@oss.qualcomm.com>
> Date:  Fri, Aug 28, 2026, 19:34
> Subject:  Re: [PATCH] target/riscv: Add experimental Zvabd extension supp=
ort
> To: "liumingliang"<liumingliang.dev@bytedance.com>, <qemu-devel@nongnu.or=
g>
> Cc: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <Alistair.Francis@wdc.=
com>, <zhiwei_liu@linux.alibaba.com>, <liwei1518@gmail.com>, <chao.liu@proc=
essmission.com>, "Zhibo Hong"<hongzhibo@bytedance.com>
> Hi,
>=20
> This patch is missing vabs.v, which is also part of the specification.
>=20
> I added vabs.v, and a .S test file for this new insns, using Zhibo's orig=
inal
> patch, in this branch:
>=20
> https://gitlab.com/danielhb/qemu/-/tree/zvabd
>=20
> vabs.v implementation:
>=20
> https://gitlab.com/danielhb/qemu/-/commit/1ce5701e737f885f2e32248c1587614=
ea3435d76
>=20
> test file:
>=20
> https://gitlab.com/danielhb/qemu/-/commit/9f4626bc8e55c0768ff474037e29143=
1d4deb0fb
>=20
>=20
> Feel free to add these 2 commits in this work. =C2=A0It's already rebased=
 on a recent code
> base so shouldn't be much of a problem.
>=20
>=20
> Also, I believe we'll want tests for the other zvabd insns too, so we'll =
need extra
> code in test-zvabd.S.
>=20
>=20
> Thanks,
> Daniel
>=20
> On 8/28/2026 6:20 AM, liumingliang wrote:
> > From: Zhibo Hong <hongzhibo@bytedance.com>
> >=C2=A0
> > The draft Zvabd extension provides vector integer absolute-difference
> > operations for image, video, and other data-processing workloads. It
> > introduces eight new intructions:
> >=C2=A0
> > =C2=A0 =C2=A0- vabd.vv, vabd.vx, vabdu.vv, and vabdu.vx support SEW val=
ues from
> > =C2=A0 =C2=A0 =C2=A08 through ELEN, with SEW 64 requiring Zve64x.
> > =C2=A0 =C2=A0- vwabda.vv, vwabda.vx, vwabdau.vv, and vwabdau.vx support=
 SEW 8
> > =C2=A0 =C2=A0 =C2=A0and 16 and accumulate into a double-width destinati=
on.
> >=C2=A0
> > This patch implement this instruction extension, including instruction
> > decoder, TCG translation, and helpers, etc. The specification is under
> > review at:
> > https://github.com/riscv/riscv-isa-manual/pull/3279
> >=C2=A0
> > Signed-off-by: Mingliang Liu <liumingliang.dev@bytedance.com>
> > ---
> > =C2=A0 disas/riscv-op.c.inc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A08 +++
> > =C2=A0 disas/riscv.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A08 +++
> > =C2=A0 target/riscv/cpu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A01 +
> > =C2=A0 target/riscv/cpu_cfg_fields.h.inc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | =C2=A01 +
> > =C2=A0 target/riscv/helper.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 26 ++++++++++
> > =C2=A0 target/riscv/insn32.decode =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ++++
> > =C2=A0 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 45 +++++++++++++++=
++
> > =C2=A0 target/riscv/tcg/tcg-cpu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A06 +++
> > =C2=A0 target/riscv/tcg/vector_helper.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 56 +++++++++++++++++++++
> > =C2=A0 9 files changed, 161 insertions(+)
> >=C2=A0
> > diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> > index 1d334e4857..07b56f5d52 100644
> > --- a/disas/riscv-op.c.inc
> > +++ b/disas/riscv-op.c.inc
> > @@ -490,6 +490,10 @@ OP(vaadd_vv, "vaadd.vv", rv_codec_v_r, rv_fmt_vd_v=
s2_vs1_vm)
> > =C2=A0 OP(vaadd_vx, "vaadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> > =C2=A0 OP(vaaddu_vv, "vaaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> > =C2=A0 OP(vaaddu_vx, "vaaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> > +OP(vabd_vv, "vabd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> > +OP(vabd_vx, "vabd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> > +OP(vabdu_vv, "vabdu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> > +OP(vabdu_vx, "vabdu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> > =C2=A0 OP(vadc_vim, "vadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl)
> > =C2=A0 OP(vadc_vvm, "vadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
> > =C2=A0 OP(vadc_vxm, "vadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
> > @@ -861,6 +865,10 @@ OP(vsuxei16_v, "vsuxei16.v", rv_codec_v_r, rv_fmt_=
ldst_vd_rs1_vs2_vm)
> > =C2=A0 OP(vsuxei32_v, "vsuxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs=
2_vm)
> > =C2=A0 OP(vsuxei64_v, "vsuxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs=
2_vm)
> > =C2=A0 OP(vsuxei8_v, "vsuxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm)
> > +OP(vwabda_vv, "vwabda.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> > +OP(vwabda_vx, "vwabda.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> > +OP(vwabdau_vv, "vwabdau.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> > +OP(vwabdau_vx, "vwabdau.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> > =C2=A0 OP(vwadd_vv, "vwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> > =C2=A0 OP(vwadd_vx, "vwadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> > =C2=A0 OP(vwadd_wv, "vwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> > diff --git a/disas/riscv.c b/disas/riscv.c
> > index b8099cbdf8..e0a8b3a756 100644
> > --- a/disas/riscv.c
> > +++ b/disas/riscv.c
> > @@ -2022,6 +2022,8 @@ static const rv_opcode_data *decode_inst_opcode(r=
v_decode *dec, rv_isa isa)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 48:=
 return &op_vwredsumu_vs;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 49:=
 return &op_vwredsum_vs;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 53:=
 return &op_vwsll_vv;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 61: retur=
n &op_vwabda_vv;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 62: retur=
n &op_vwabdau_vv;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 1:
> > @@ -2164,6 +2166,8 @@ static const rv_opcode_data *decode_inst_opcode(r=
v_decode *dec, rv_isa isa)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 break;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 21: retur=
n &op_vabd_vv;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 22: retur=
n &op_vabdu_vv;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 23:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if ((inst >> 25) & 1) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return &op_vcompress_vm;
> > @@ -2349,6 +2353,8 @@ static const rv_opcode_data *decode_inst_opcode(r=
v_decode *dec, rv_isa isa)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 46:=
 return &op_vnclipu_wx;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 47:=
 return &op_vnclip_wx;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 53:=
 return &op_vwsll_vx;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 61: retur=
n &op_vwabda_vx;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 62: retur=
n &op_vwabdau_vx;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 5:
> > @@ -2417,6 +2423,8 @@ static const rv_opcode_data *decode_inst_opcode(r=
v_decode *dec, rv_isa isa)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 13:=
 return &op_vclmulh_vx;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 14:=
 return &op_vslide1up_vx;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 15:=
 return &op_vslide1down_vx;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 21: retur=
n &op_vabd_vx;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 22: retur=
n &op_vabdu_vx;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 16:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 switch ((inst >> 20) & 0b11111) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 case 0:
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index a13177b7b7..4b8944b051 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -220,6 +220,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> > =C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(zksh, PRIV_VERSION_1_12_0, ext_=
zksh),
> > =C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(zkt, PRIV_VERSION_1_12_0, ext_z=
kt),
> > =C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(ztso, PRIV_VERSION_1_12_0, ext_=
ztso),
> > + =C2=A0 =C2=A0ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvabd, PRIV_VERSION_1_13=
_0, ext_zvabd),
> > =C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(zvbb, PRIV_VERSION_1_12_0, ext_=
zvbb),
> > =C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_=
zvbc),
> > =C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ex=
t_zve32f),
> > diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_f=
ields.h.inc
> > index f8c27a574f..6018e58195 100644
> > --- a/target/riscv/cpu_cfg_fields.h.inc
> > +++ b/target/riscv/cpu_cfg_fields.h.inc
> > @@ -83,6 +83,7 @@ BOOL_FIELD(ext_zve32x)
> > =C2=A0 BOOL_FIELD(ext_zve64f)
> > =C2=A0 BOOL_FIELD(ext_zve64d)
> > =C2=A0 BOOL_FIELD(ext_zve64x)
> > +BOOL_FIELD(ext_zvabd)
> > =C2=A0 BOOL_FIELD(ext_zvbb)
> > =C2=A0 BOOL_FIELD(ext_zvbc)
> > =C2=A0 BOOL_FIELD(ext_zvkb)
> > diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> > index 4fc2d3a155..3aef6e0e3e 100644
> > --- a/target/riscv/helper.h
> > +++ b/target/riscv/helper.h
> > @@ -1350,6 +1350,32 @@ DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env,=
 i32)
> > =C2=A0 DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)
> > =C2=A0 DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
> > =C2=A0=C2=A0
> > +/* Zvabd Extension */
> > +DEF_HELPER_6(vabd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_6(vabd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_6(vabd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_6(vabd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_6(vabd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> > +DEF_HELPER_6(vabd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> > +DEF_HELPER_6(vabd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> > +DEF_HELPER_6(vabd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> > +DEF_HELPER_6(vabdu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_6(vabdu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_6(vabdu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_6(vabdu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_6(vabdu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> > +DEF_HELPER_6(vabdu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> > +DEF_HELPER_6(vabdu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> > +DEF_HELPER_6(vabdu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> > +DEF_HELPER_6(vwabda_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_6(vwabda_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_6(vwabda_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> > +DEF_HELPER_6(vwabda_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> > +DEF_HELPER_6(vwabdau_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_6(vwabdau_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> > +DEF_HELPER_6(vwabdau_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> > +DEF_HELPER_6(vwabdau_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> > +
> > =C2=A0 /* CFI (zicfiss) helpers */
> > =C2=A0 #ifndef CONFIG_USER_ONLY
> > =C2=A0 DEF_HELPER_1(ssamoswap_disabled, void, env)
> > diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> > index 21272fdb50..1c991a6f42 100644
> > --- a/target/riscv/insn32.decode
> > +++ b/target/riscv/insn32.decode
> > @@ -1084,3 +1084,13 @@ sb_aqrl =C2=A000111 . . ..... ..... 000 ..... 01=
01111 @atom_st
> > =C2=A0 sh_aqrl =C2=A000111 . . ..... ..... 001 ..... 0101111 @atom_st
> > =C2=A0 sw_aqrl =C2=A000111 . . ..... ..... 010 ..... 0101111 @atom_st
> > =C2=A0 sd_aqrl =C2=A000111 . . ..... ..... 011 ..... 0101111 @atom_st
> > +
> > +# *** Zvabd Extension ***
> > +vabd_vv =C2=A0 =C2=A0 =C2=A0 010101 . ..... ..... 010 ..... 1010111 @r=
_vm
> > +vabd_vx =C2=A0 =C2=A0 =C2=A0 010101 . ..... ..... 110 ..... 1010111 @r=
_vm
> > +vabdu_vv =C2=A0 =C2=A0 =C2=A0010110 . ..... ..... 010 ..... 1010111 @r=
_vm
> > +vabdu_vx =C2=A0 =C2=A0 =C2=A0010110 . ..... ..... 110 ..... 1010111 @r=
_vm
> > +vwabda_vv =C2=A0 =C2=A0 111101 . ..... ..... 000 ..... 1010111 @r_vm
> > +vwabda_vx =C2=A0 =C2=A0 111101 . ..... ..... 100 ..... 1010111 @r_vm
> > +vwabdau_vv =C2=A0 =C2=A0111110 . ..... ..... 000 ..... 1010111 @r_vm
> > +vwabdau_vx =C2=A0 =C2=A0111110 . ..... ..... 100 ..... 1010111 @r_vm
> > diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv=
/tcg/insn_trans/trans_rvv.c.inc
> > index a22e2cae6c..14ef961607 100644
> > --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> > +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> > @@ -4091,3 +4091,48 @@ GEN_INT_EXT_TRANS(vzext_vf8, 3, 2)
> > =C2=A0 GEN_INT_EXT_TRANS(vsext_vf2, 1, 3)
> > =C2=A0 GEN_INT_EXT_TRANS(vsext_vf4, 2, 4)
> > =C2=A0 GEN_INT_EXT_TRANS(vsext_vf8, 3, 5)
> > +
> > +/* Zvabd Extension */
> > +#define GEN_ABD_CHECK(NAME, CHECK_FN, MAX_SEW) =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > +static bool NAME(DisasContext *s, arg_rmrr *a) =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > +{ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0\
> > + =C2=A0 =C2=A0return CHECK_FN(s, a) && s->cfg_ptr->ext_zvabd && =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s->sew <=3D MAX_SEW && =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (s->sew !=3D MO_64 || s->cfg_ptr->=
ext_zve64x); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > +}
> > +GEN_ABD_CHECK(vabd_vv_check, opivv_check, MO_64)
> > +GEN_ABD_CHECK(vabd_vx_check, opivx_check, MO_64)
> > +GEN_ABD_CHECK(vwabd_vv_check, opivv_overwrite_widen_check, MO_16)
> > +GEN_ABD_CHECK(vwabd_vx_check, opivx_overwrite_widen_check, MO_16)
> > +
> > +GEN_OPIVV_TRANS(vabd_vv, vabd_vv_check)
> > +GEN_OPIVX_TRANS(vabd_vx, vabd_vx_check)
> > +GEN_OPIVV_TRANS(vabdu_vv, vabd_vv_check)
> > +GEN_OPIVX_TRANS(vabdu_vx, vabd_vx_check)
> > +
> > +#define GEN_ABD_OPIVV_WIDEN_TRANS(NAME, CHECK) =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > +static bool trans_##NAME(DisasContext *s, arg_rmrr *a) =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > +{ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > + =C2=A0 =C2=A0static gen_helper_gvec_4_ptr * const fns[2] =3D { =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_helper_##NAME##_b, gen_helper_##NAME##=
_h, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > + =C2=A0 =C2=A0}; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > + =C2=A0 =C2=A0return s->sew <=3D MO_16 && do_opivv_widen(s, a, fns[s->=
sew], CHECK); \
> > +}
> > +
> > +#define GEN_ABD_OPIVX_WIDEN_TRANS(NAME, CHECK) =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > +static bool trans_##NAME(DisasContext *s, arg_rmrr *a) =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > +{ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > + =C2=A0 =C2=A0if (CHECK(s, a)) { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0static gen_helper_opivx * const fns[2] =3D=
 { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0\
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_helper_##NAME##_b, gen_h=
elper_##NAME##_h, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0}; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0return opivx_trans(a->rd, a->rs1, a->rs2, =
a->vm, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 fns[s->sew], s); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > + =C2=A0 =C2=A0} =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > + =C2=A0 =C2=A0return false; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > +}
> > +
> > +GEN_ABD_OPIVV_WIDEN_TRANS(vwabda_vv, vwabd_vv_check)
> > +GEN_ABD_OPIVX_WIDEN_TRANS(vwabda_vx, vwabd_vx_check)
> > +GEN_ABD_OPIVV_WIDEN_TRANS(vwabdau_vv, vwabd_vv_check)
> > +GEN_ABD_OPIVX_WIDEN_TRANS(vwabdau_vx, vwabd_vx_check)
> > diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> > index 9e3cc87f8a..4c2fb6f063 100644
> > --- a/target/riscv/tcg/tcg-cpu.c
> > +++ b/target/riscv/tcg/tcg-cpu.c
> > @@ -732,6 +732,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *c=
pu, Error **errp)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> > =C2=A0 =C2=A0 =C2=A0 }
> > =C2=A0=C2=A0
> > + =C2=A0 =C2=A0if ((cpu->cfg.ext_zvabd) && !cpu->cfg.ext_zve32x) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Zvabd=
 extensions require V or Zve* extensions");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> > + =C2=A0 =C2=A0}
> > +
> > =C2=A0 =C2=A0 =C2=A0 if (cpu->cfg.ext_zicntr && !cpu->cfg.ext_zicsr) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_cfg_ext_is_user_set(CPU_CFG_=
OFFSET(ext_zicntr))) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, "zicn=
tr requires zicsr");
> > diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector=
_helper.c
> > index e28d8a3d9f..bdb1efcebc 100644
> > --- a/target/riscv/tcg/vector_helper.c
> > +++ b/target/riscv/tcg/vector_helper.c
> > @@ -5906,3 +5906,59 @@ GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, =
H8, H4)
> > =C2=A0 GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t, =C2=A0H4, H1)
> > =C2=A0 GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)
> > =C2=A0 GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t, =C2=A0H8, H1)
> > +
> > +/* Zvabd Extension */
> > +#define DO_ABD(N, M) =C2=A0(N > M ? N - M : M - N)
> > +#define DO_ABDACC(N, M, D) (DO_ABD(N, M) + D)
> > +
> > +RVVCALL(OPIVV2, vabd_vv_b, OP_SSS_B, H1, H1, H1, DO_ABD)
> > +RVVCALL(OPIVV2, vabd_vv_h, OP_SSS_H, H2, H2, H2, DO_ABD)
> > +RVVCALL(OPIVV2, vabd_vv_w, OP_SSS_W, H4, H4, H4, DO_ABD)
> > +RVVCALL(OPIVV2, vabd_vv_d, OP_SSS_D, H8, H8, H8, DO_ABD)
> > +RVVCALL(OPIVX2, vabd_vx_b, OP_SSS_B, H1, H1, DO_ABD)
> > +RVVCALL(OPIVX2, vabd_vx_h, OP_SSS_H, H2, H2, DO_ABD)
> > +RVVCALL(OPIVX2, vabd_vx_w, OP_SSS_W, H4, H4, DO_ABD)
> > +RVVCALL(OPIVX2, vabd_vx_d, OP_SSS_D, H8, H8, DO_ABD)
> > +RVVCALL(OPIVV2, vabdu_vv_b, OP_UUU_B, H1, H1, H1, DO_ABD)
> > +RVVCALL(OPIVV2, vabdu_vv_h, OP_UUU_H, H2, H2, H2, DO_ABD)
> > +RVVCALL(OPIVV2, vabdu_vv_w, OP_UUU_W, H4, H4, H4, DO_ABD)
> > +RVVCALL(OPIVV2, vabdu_vv_d, OP_UUU_D, H8, H8, H8, DO_ABD)
> > +RVVCALL(OPIVX2, vabdu_vx_b, OP_UUU_B, H1, H1, DO_ABD)
> > +RVVCALL(OPIVX2, vabdu_vx_h, OP_UUU_H, H2, H2, DO_ABD)
> > +RVVCALL(OPIVX2, vabdu_vx_w, OP_UUU_W, H4, H4, DO_ABD)
> > +RVVCALL(OPIVX2, vabdu_vx_d, OP_UUU_D, H8, H8, DO_ABD)
> > +
> > +RVVCALL(OPIVV3, vwabda_vv_b, WOP_SSS_B, H2, H1, H1, DO_ABDACC)
> > +RVVCALL(OPIVV3, vwabda_vv_h, WOP_SSS_H, H4, H2, H2, DO_ABDACC)
> > +RVVCALL(OPIVX3, vwabda_vx_b, WOP_SSS_B, H2, H1, DO_ABDACC)
> > +RVVCALL(OPIVX3, vwabda_vx_h, WOP_SSS_H, H4, H2, DO_ABDACC)
> > +RVVCALL(OPIVV3, vwabdau_vv_b, WOP_UUU_B, H2, H1, H1, DO_ABDACC)
> > +RVVCALL(OPIVV3, vwabdau_vv_h, WOP_UUU_H, H4, H2, H2, DO_ABDACC)
> > +RVVCALL(OPIVX3, vwabdau_vx_b, WOP_UUU_B, H2, H1, DO_ABDACC)
> > +RVVCALL(OPIVX3, vwabdau_vx_h, WOP_UUU_H, H4, H2, DO_ABDACC)
> > +
> > +GEN_VEXT_VV(vabd_vv_b, 1)
> > +GEN_VEXT_VV(vabd_vv_h, 2)
> > +GEN_VEXT_VV(vabd_vv_w, 4)
> > +GEN_VEXT_VV(vabd_vv_d, 8)
> > +GEN_VEXT_VX(vabd_vx_b, 1)
> > +GEN_VEXT_VX(vabd_vx_h, 2)
> > +GEN_VEXT_VX(vabd_vx_w, 4)
> > +GEN_VEXT_VX(vabd_vx_d, 8)
> > +GEN_VEXT_VV(vabdu_vv_b, 1)
> > +GEN_VEXT_VV(vabdu_vv_h, 2)
> > +GEN_VEXT_VV(vabdu_vv_w, 4)
> > +GEN_VEXT_VV(vabdu_vv_d, 8)
> > +GEN_VEXT_VX(vabdu_vx_b, 1)
> > +GEN_VEXT_VX(vabdu_vx_h, 2)
> > +GEN_VEXT_VX(vabdu_vx_w, 4)
> > +GEN_VEXT_VX(vabdu_vx_d, 8)
> > +
> > +GEN_VEXT_VV(vwabda_vv_b, 2)
> > +GEN_VEXT_VV(vwabda_vv_h, 4)
> > +GEN_VEXT_VX(vwabda_vx_b, 2)
> > +GEN_VEXT_VX(vwabda_vx_h, 4)
> > +GEN_VEXT_VV(vwabdau_vv_b, 2)
> > +GEN_VEXT_VV(vwabdau_vv_h, 4)
> > +GEN_VEXT_VX(vwabdau_vx_b, 2)
> > +GEN_VEXT_VX(vwabdau_vx_h, 4)
>=20
--ad8fb322d1c23b556c768fb458fc4fb8702cd956827b899f757d42dc30af
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head></head><body><div id=3D"editor_version_7.72.1_FGiQTTmz" style=
=3D"word-break:break-word;"><div data-zone-id=3D"0" data-line-index=3D"0" d=
ata-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height=
: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;">Hi Daniel,</div></div>=
<div data-zone-id=3D"0" data-line-index=3D"1" data-line=3D"true" style=3D"m=
argin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div style=3D"text-i=
ndent: 2em; font-size: 14px;" class=3D"text-indent" dir=3D"auto">Thanks for=
 your advice. I=E2=80=99ll add more tests for this patch.</div></div><div d=
ata-zone-id=3D"0" data-line-index=3D"2" data-line=3D"true" style=3D"margin-=
top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D=
"font-size: 14px;"><br/></div></div><div data-zone-id=3D"0" data-line-index=
=3D"3" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; lin=
e-height: 1.6;"><div style=3D"text-indent: 2em; font-size: 14px;" class=3D"=
text-indent" dir=3D"auto">In the latest specification, vabs.v is defined as=
 a pseudo-instruction that aliases vabd.vx rd, vs2, x0, similar to how vneg=
.v aliases vrsub.vx rd, vs2, x0. I think we don&#39;t need add vabs.v as a =
separate instruction, since they share the same encoding.</div></div><div d=
ata-zone-id=3D"0" data-line-index=3D"4" data-line=3D"true" style=3D"margin-=
top: 4px; margin-bottom: 4px; line-height: 1.6;"><div style=3D"text-indent:=
 2em; font-size: 14px;" class=3D"text-indent" dir=3D"auto"><br/></div></div=
><div data-zone-id=3D"0" data-line-index=3D"5" data-line=3D"true" style=3D"=
margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div style=3D"text-=
indent: 2em; font-size: 14px;" class=3D"text-indent" dir=3D"auto">See the <=
span style=3D"font-size: 14px;">vabs.v </span>at: <a class=3D"not-doclink" =
href=3D"https://github.com/riscv/riscv-isa-manual/pull/3279/changes#diff-c4=
a6db324416cc1f52c849a8cd5a20b5d8b5e422ffca6dcb6f341b5f1df48a15R110" linkid=
=3D"IXSAIvBgAG" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"tran=
sition: color 0.3s; cursor: pointer; text-decoration: none; color: rgb(20, =
86, 240);">https://github.com/riscv/riscv-isa-manual/pull/3279/changes#diff=
-c4a6db324416cc1f52c849a8cd5a20b5d8b5e422ffca6dcb6f341b5f1df48a15R110</a></=
div></div><div data-zone-id=3D"0" data-line-index=3D"6" data-line=3D"true" =
style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div style=
=3D"text-indent: 2em; font-size: 14px;" class=3D"text-indent" dir=3D"auto">=
<br/></div></div></div><div class=3D"history-quote-wrapper" id=3D"lark-mail=
-quote-178791846"><div data-html-block=3D"quote" data-mail-html-ignore=3D""=
><div id=3D"lark-mail-quote-178791832" class=3D"history-quote-wrapper"><div=
 class=3D"adit-html-block adit-html-block--collapsed" style=3D"border-left:=
 none; padding-left: 0px;"><div><div id=3D"lark-mail-quote-63212af051f686bc=
b2dd0e4e1b18b957"><div style=3D"padding: 12px; background: rgb(245, 246, 24=
7); color: rgb(31, 35, 41); border-radius: 4px; margin-top: 24px; margin-bo=
ttom: 12px;" id=3D"lark-mail-meta-9aiv9HH5L" class=3D"adit-html-block__attr=
 history-quote-meta-wrapper history-quote-gap-tag"><div style=3D"word-break=
: break-word;"><div class=3D"lme-line-signal" style=3D""><span>From: </span=
> <span>&#34;Daniel Henrique Barboza&#34;&lt;<a href=3D"mailto:daniel.barbo=
za@oss.qualcomm.com" style=3D"overflow-wrap: break-word; white-space: pre-w=
rap; hyphens: none; word-break: break-word; cursor: pointer; text-decoratio=
n: none; color: inherit;" class=3D"quote-head-meta-mailto" data-mailto=3D"m=
ailto:daniel.barboza@oss.qualcomm.com">daniel.barboza@oss.qualcomm.com</a>&=
gt;</span></div><div class=3D"lme-line-signal" style=3D""><span>Date: </spa=
n> Fri, Aug 28, 2026, 19:34</div><div class=3D"lme-line-signal" style=3D"">=
<span>Subject: </span> Re: [PATCH] target/riscv: Add experimental Zvabd ext=
ension support</div><div class=3D"lme-line-signal" style=3D""><span>To: </s=
pan> <span>&#34;liumingliang&#34;&lt;<a href=3D"mailto:liumingliang.dev@byt=
edance.com" style=3D"overflow-wrap: break-word; white-space: pre-wrap; hyph=
ens: none; word-break: break-word; cursor: pointer; text-decoration: none; =
color: inherit;" class=3D"quote-head-meta-mailto" data-mailto=3D"mailto:liu=
mingliang.dev@bytedance.com">liumingliang.dev@bytedance.com</a>&gt;</span>,=
 <span>&lt;<a href=3D"mailto:qemu-devel@nongnu.org" style=3D"overflow-wrap:=
 break-word; white-space: pre-wrap; hyphens: none; word-break: break-word; =
cursor: pointer; text-decoration: none; color: inherit;" class=3D"quote-hea=
d-meta-mailto" data-mailto=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nong=
nu.org</a>&gt;</span></div><div class=3D"lme-line-signal" style=3D""><span>=
Cc: </span> <span>&lt;<a href=3D"mailto:qemu-riscv@nongnu.org" style=3D"ove=
rflow-wrap: break-word; white-space: pre-wrap; hyphens: none; word-break: b=
reak-word; cursor: pointer; text-decoration: none; color: inherit;" class=
=3D"quote-head-meta-mailto" data-mailto=3D"mailto:qemu-riscv@nongnu.org">qe=
mu-riscv@nongnu.org</a>&gt;</span>, <span>&lt;<a href=3D"mailto:palmer@dabb=
elt.com" style=3D"overflow-wrap: break-word; white-space: pre-wrap; hyphens=
: none; word-break: break-word; cursor: pointer; text-decoration: none; col=
or: inherit;" class=3D"quote-head-meta-mailto" data-mailto=3D"mailto:palmer=
@dabbelt.com">palmer@dabbelt.com</a>&gt;</span>, <span>&lt;<a href=3D"mailt=
o:Alistair.Francis@wdc.com" style=3D"overflow-wrap: break-word; white-space=
: pre-wrap; hyphens: none; word-break: break-word; cursor: pointer; text-de=
coration: none; color: inherit;" class=3D"quote-head-meta-mailto" data-mail=
to=3D"mailto:Alistair.Francis@wdc.com">Alistair.Francis@wdc.com</a>&gt;</sp=
an>, <span>&lt;<a href=3D"mailto:zhiwei_liu@linux.alibaba.com" style=3D"ove=
rflow-wrap: break-word; white-space: pre-wrap; hyphens: none; word-break: b=
reak-word; cursor: pointer; text-decoration: none; color: inherit;" class=
=3D"quote-head-meta-mailto" data-mailto=3D"mailto:zhiwei_liu@linux.alibaba.=
com">zhiwei_liu@linux.alibaba.com</a>&gt;</span>, <span>&lt;<a href=3D"mail=
to:liwei1518@gmail.com" style=3D"overflow-wrap: break-word; white-space: pr=
e-wrap; hyphens: none; word-break: break-word; cursor: pointer; text-decora=
tion: none; color: inherit;" class=3D"quote-head-meta-mailto" data-mailto=
=3D"mailto:liwei1518@gmail.com">liwei1518@gmail.com</a>&gt;</span>, <span>&=
lt;<a href=3D"mailto:chao.liu@processmission.com" style=3D"overflow-wrap: b=
reak-word; white-space: pre-wrap; hyphens: none; word-break: break-word; cu=
rsor: pointer; text-decoration: none; color: inherit;" class=3D"quote-head-=
meta-mailto" data-mailto=3D"mailto:chao.liu@processmission.com">chao.liu@pr=
ocessmission.com</a>&gt;</span>, <span>&#34;Zhibo Hong&#34;&lt;<a href=3D"m=
ailto:hongzhibo@bytedance.com" style=3D"overflow-wrap: break-word; white-sp=
ace: pre-wrap; hyphens: none; word-break: break-word; cursor: pointer; text=
-decoration: none; color: inherit;" class=3D"quote-head-meta-mailto" data-m=
ailto=3D"mailto:hongzhibo@bytedance.com">hongzhibo@bytedance.com</a>&gt;</s=
pan></div></div></div><div><div class=3D"lme-line-signal" data-type=3D"plai=
nText">Hi,<br/><br/>This patch is missing vabs.v, which is also part of the=
 specification.<br/><br/>I added vabs.v, and a .S test file for this new in=
sns, using Zhibo&#39;s original<br/>patch, in this branch:<br/><br/><span><=
a href=3D"https://gitlab.com/danielhb/qemu/-/tree/zvabd" target=3D"_blank" =
ref=3D"noopener noreferrer">https://gitlab.com/danielhb/qemu/-/tree/zvabd</=
a></span><br/><br/>vabs.v implementation:<br/><br/><span><a href=3D"https:/=
/gitlab.com/danielhb/qemu/-/commit/1ce5701e737f885f2e32248c1587614ea3435d76=
" target=3D"_blank" ref=3D"noopener noreferrer">https://gitlab.com/danielhb=
/qemu/-/commit/1ce5701e737f885f2e32248c1587614ea3435d76</a></span><br/><br/=
>test file:<br/><br/><span><a href=3D"https://gitlab.com/danielhb/qemu/-/co=
mmit/9f4626bc8e55c0768ff474037e291431d4deb0fb" target=3D"_blank" ref=3D"noo=
pener noreferrer">https://gitlab.com/danielhb/qemu/-/commit/9f4626bc8e55c07=
68ff474037e291431d4deb0fb</a></span><br/><br/><br/>Feel free to add these 2=
 commits in this work. =C2=A0It&#39;s already rebased on a recent code<br/>=
base so shouldn&#39;t be much of a problem.<br/><br/><br/>Also, I believe w=
e&#39;ll want tests for the other zvabd insns too, so we&#39;ll need extra<=
br/>code in test-zvabd.S.<br/><br/><br/>Thanks,<br/>Daniel<br/><br/>On 8/28=
/2026 6:20 AM, liumingliang wrote:<br/><span>&gt; From: Zhibo Hong &lt;<a h=
ref=3D"mailto:hongzhibo@bytedance.com" target=3D"_blank" ref=3D"noopener no=
referrer">hongzhibo@bytedance.com</a>&gt;</span><br/>&gt;=C2=A0<br/>&gt; Th=
e draft Zvabd extension provides vector integer absolute-difference<br/>&gt=
; operations for image, video, and other data-processing workloads. It<br/>=
&gt; introduces eight new intructions:<br/>&gt;=C2=A0<br/>&gt; =C2=A0 =C2=
=A0- vabd.vv, vabd.vx, vabdu.vv, and vabdu.vx support SEW values from<br/>&=
gt; =C2=A0 =C2=A0 =C2=A08 through ELEN, with SEW 64 requiring Zve64x.<br/>&=
gt; =C2=A0 =C2=A0- vwabda.vv, vwabda.vx, vwabdau.vv, and vwabdau.vx support=
 SEW 8<br/>&gt; =C2=A0 =C2=A0 =C2=A0and 16 and accumulate into a double-wid=
th destination.<br/>&gt;=C2=A0<br/>&gt; This patch implement this instructi=
on extension, including instruction<br/>&gt; decoder, TCG translation, and =
helpers, etc. The specification is under<br/>&gt; review at:<br/><span>&gt;=
 <a href=3D"https://github.com/riscv/riscv-isa-manual/pull/3279" target=3D"=
_blank" ref=3D"noopener noreferrer">https://github.com/riscv/riscv-isa-manu=
al/pull/3279</a></span><br/>&gt;=C2=A0<br/><span>&gt; Signed-off-by: Mingli=
ang Liu &lt;<a href=3D"mailto:liumingliang.dev@bytedance.com" target=3D"_bl=
ank" ref=3D"noopener noreferrer">liumingliang.dev@bytedance.com</a>&gt;</sp=
an><br/>&gt; ---<br/>&gt; =C2=A0 disas/riscv-op.c.inc =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A08 +++=
<br/>&gt; =C2=A0 disas/riscv.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A08 ++=
+<br/>&gt; =C2=A0 target/riscv/cpu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A01 +<br/>&gt; =
=C2=A0 target/riscv/cpu_cfg_fields.h.inc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A01 +<br/>&gt; =C2=A0 target/riscv/helper.h =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 26 ++++++++++<br/>&g=
t; =C2=A0 target/riscv/insn32.decode =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 10 ++++<br/>&gt; =C2=A0 target/riscv/tcg/insn_tra=
ns/trans_rvv.c.inc | 45 +++++++++++++++++<br/>&gt; =C2=A0 target/riscv/tcg/=
tcg-cpu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A06 +++<br/>&gt; =C2=A0 target/riscv/tcg/vector_helper.c =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 56 +++++++++++++++++++++<br/>&gt; =C2=A0 9 fil=
es changed, 161 insertions(+)<br/>&gt;=C2=A0<br/>&gt; diff --git a/disas/ri=
scv-op.c.inc b/disas/riscv-op.c.inc<br/>&gt; index 1d334e4857..07b56f5d52 1=
00644<br/>&gt; --- a/disas/riscv-op.c.inc<br/>&gt; +++ b/disas/riscv-op.c.i=
nc<br/>&gt; @@ -490,6 +490,10 @@ OP(vaadd_vv, &#34;vaadd.vv&#34;, rv_codec_=
v_r, rv_fmt_vd_vs2_vs1_vm)<br/>&gt; =C2=A0 OP(vaadd_vx, &#34;vaadd.vx&#34;,=
 rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)<br/>&gt; =C2=A0 OP(vaaddu_vv, &#34;vaa=
ddu.vv&#34;, rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)<br/>&gt; =C2=A0 OP(vaaddu_=
vx, &#34;vaaddu.vx&#34;, rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)<br/>&gt; +OP(v=
abd_vv, &#34;vabd.vv&#34;, rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)<br/>&gt; +OP=
(vabd_vx, &#34;vabd.vx&#34;, rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)<br/>&gt; +=
OP(vabdu_vv, &#34;vabdu.vv&#34;, rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)<br/>&g=
t; +OP(vabdu_vx, &#34;vabdu.vx&#34;, rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)<br=
/>&gt; =C2=A0 OP(vadc_vim, &#34;vadc.vim&#34;, rv_codec_v_i, rv_fmt_vd_vs2_=
imm_vl)<br/>&gt; =C2=A0 OP(vadc_vvm, &#34;vadc.vvm&#34;, rv_codec_v_r, rv_f=
mt_vd_vs2_vs1_vl)<br/>&gt; =C2=A0 OP(vadc_vxm, &#34;vadc.vxm&#34;, rv_codec=
_v_r, rv_fmt_vd_vs2_rs1_vl)<br/>&gt; @@ -861,6 +865,10 @@ OP(vsuxei16_v, &#=
34;vsuxei16.v&#34;, rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)<br/>&gt; =C2=
=A0 OP(vsuxei32_v, &#34;vsuxei32.v&#34;, rv_codec_v_r, rv_fmt_ldst_vd_rs1_v=
s2_vm)<br/>&gt; =C2=A0 OP(vsuxei64_v, &#34;vsuxei64.v&#34;, rv_codec_v_r, r=
v_fmt_ldst_vd_rs1_vs2_vm)<br/>&gt; =C2=A0 OP(vsuxei8_v, &#34;vsuxei8.v&#34;=
, rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)<br/>&gt; +OP(vwabda_vv, &#34;vwa=
bda.vv&#34;, rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)<br/>&gt; +OP(vwabda_vx, &#=
34;vwabda.vx&#34;, rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)<br/>&gt; +OP(vwabdau=
_vv, &#34;vwabdau.vv&#34;, rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)<br/>&gt; +OP=
(vwabdau_vx, &#34;vwabdau.vx&#34;, rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)<br/>=
&gt; =C2=A0 OP(vwadd_vv, &#34;vwadd.vv&#34;, rv_codec_v_r, rv_fmt_vd_vs2_vs=
1_vm)<br/>&gt; =C2=A0 OP(vwadd_vx, &#34;vwadd.vx&#34;, rv_codec_v_r, rv_fmt=
_vd_vs2_rs1_vm)<br/>&gt; =C2=A0 OP(vwadd_wv, &#34;vwadd.wv&#34;, rv_codec_v=
_r, rv_fmt_vd_vs2_vs1_vm)<br/>&gt; diff --git a/disas/riscv.c b/disas/riscv=
.c<br/>&gt; index b8099cbdf8..e0a8b3a756 100644<br/>&gt; --- a/disas/riscv.=
c<br/>&gt; +++ b/disas/riscv.c<br/>&gt; @@ -2022,6 +2022,8 @@ static const =
rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)<br/>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 48: return=
 &amp;op_vwredsumu_vs;<br/>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 case 49: return &amp;op_vwredsum_vs;<br/>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 53: return &am=
p;op_vwsll_vv;<br/>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0case 61: return &amp;op_vwabda_vv;<br/>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 62: return &amp;op_vwabdau_vv;<br/>&=
gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br/>&g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br=
/>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 1:<br/>&gt; @@=
 -2164,6 +2166,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_deco=
de *dec, rv_isa isa)<br/>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br/>&gt; =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br/>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break;<br/>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0case 21: return &amp;op_vabd_vv;<br/>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0case 22: return &amp;op_vabdu_vv;<br/>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 23:<br/>&g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if ((inst &gt;&gt; 25) &amp; 1) {<br/>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &=
amp;op_vcompress_vm;<br/>&gt; @@ -2349,6 +2353,8 @@ static const rv_opcode_=
data *decode_inst_opcode(rv_decode *dec, rv_isa isa)<br/>&gt; =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 46: return &amp;op_v=
nclipu_wx;<br/>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 case 47: return &amp;op_vnclip_wx;<br/>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 53: return &amp;op_vwsll_vx;=
<br/>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 61:=
 return &amp;op_vwabda_vx;<br/>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0case 62: return &amp;op_vwabdau_vx;<br/>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br/>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br/>&gt; =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 5:<br/>&gt; @@ -2417,6 +242=
3,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_i=
sa isa)<br/>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 case 13: return &amp;op_vclmulh_vx;<br/>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 14: return &amp;op_vslide1up=
_vx;<br/>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 case 15: return &amp;op_vslide1down_vx;<br/>&gt; + =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 21: return &amp;op_vabd_vx;<br/>&gt=
; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 22: return =
&amp;op_vabdu_vx;<br/>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 case 16:<br/>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch ((inst &gt;&gt; 20) &amp; 0b11111=
) {<br/>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 case 0:<br/>&gt; diff --git a/target/riscv/cpu.c b/target/ri=
scv/cpu.c<br/>&gt; index a13177b7b7..4b8944b051 100644<br/>&gt; --- a/targe=
t/riscv/cpu.c<br/>&gt; +++ b/target/riscv/cpu.c<br/>&gt; @@ -220,6 +220,7 @=
@ const RISCVIsaExtData isa_edata_arr[] =3D {<br/>&gt; =C2=A0 =C2=A0 =C2=A0=
 ISA_EXT_DATA_ENTRY(zksh, PRIV_VERSION_1_12_0, ext_zksh),<br/>&gt; =C2=A0 =
=C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(zkt, PRIV_VERSION_1_12_0, ext_zkt),<br/>&g=
t; =C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(ztso, PRIV_VERSION_1_12_0, ext_z=
tso),<br/>&gt; + =C2=A0 =C2=A0ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvabd, PRIV_V=
ERSION_1_13_0, ext_zvabd),<br/>&gt; =C2=A0 =C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY=
(zvbb, PRIV_VERSION_1_12_0, ext_zvbb),<br/>&gt; =C2=A0 =C2=A0 =C2=A0 ISA_EX=
T_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),<br/>&gt; =C2=A0 =C2=A0 =
=C2=A0 ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),<br/>&gt=
; diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc<br/>&gt; index f8c27a574f..6018e58195 100644<br/>&gt; --- a/targe=
t/riscv/cpu_cfg_fields.h.inc<br/>&gt; +++ b/target/riscv/cpu_cfg_fields.h.i=
nc<br/>&gt; @@ -83,6 +83,7 @@ BOOL_FIELD(ext_zve32x)<br/>&gt; =C2=A0 BOOL_F=
IELD(ext_zve64f)<br/>&gt; =C2=A0 BOOL_FIELD(ext_zve64d)<br/>&gt; =C2=A0 BOO=
L_FIELD(ext_zve64x)<br/>&gt; +BOOL_FIELD(ext_zvabd)<br/>&gt; =C2=A0 BOOL_FI=
ELD(ext_zvbb)<br/>&gt; =C2=A0 BOOL_FIELD(ext_zvbc)<br/>&gt; =C2=A0 BOOL_FIE=
LD(ext_zvkb)<br/>&gt; diff --git a/target/riscv/helper.h b/target/riscv/hel=
per.h<br/>&gt; index 4fc2d3a155..3aef6e0e3e 100644<br/>&gt; --- a/target/ri=
scv/helper.h<br/>&gt; +++ b/target/riscv/helper.h<br/>&gt; @@ -1350,6 +1350=
,32 @@ DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env, i32)<br/>&gt; =C2=
=A0 DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)<br/>&gt; =C2=A0 DEF_HE=
LPER_4(vsm4r_vs, void, ptr, ptr, env, i32)<br/>&gt; =C2=A0=C2=A0<br/>&gt; +=
/* Zvabd Extension */<br/>&gt; +DEF_HELPER_6(vabd_vv_b, void, ptr, ptr, ptr=
, ptr, env, i32)<br/>&gt; +DEF_HELPER_6(vabd_vv_h, void, ptr, ptr, ptr, ptr=
, env, i32)<br/>&gt; +DEF_HELPER_6(vabd_vv_w, void, ptr, ptr, ptr, ptr, env=
, i32)<br/>&gt; +DEF_HELPER_6(vabd_vv_d, void, ptr, ptr, ptr, ptr, env, i32=
)<br/>&gt; +DEF_HELPER_6(vabd_vx_b, void, ptr, ptr, tl, ptr, env, i32)<br/>=
&gt; +DEF_HELPER_6(vabd_vx_h, void, ptr, ptr, tl, ptr, env, i32)<br/>&gt; +=
DEF_HELPER_6(vabd_vx_w, void, ptr, ptr, tl, ptr, env, i32)<br/>&gt; +DEF_HE=
LPER_6(vabd_vx_d, void, ptr, ptr, tl, ptr, env, i32)<br/>&gt; +DEF_HELPER_6=
(vabdu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)<br/>&gt; +DEF_HELPER_6(vab=
du_vv_h, void, ptr, ptr, ptr, ptr, env, i32)<br/>&gt; +DEF_HELPER_6(vabdu_v=
v_w, void, ptr, ptr, ptr, ptr, env, i32)<br/>&gt; +DEF_HELPER_6(vabdu_vv_d,=
 void, ptr, ptr, ptr, ptr, env, i32)<br/>&gt; +DEF_HELPER_6(vabdu_vx_b, voi=
d, ptr, ptr, tl, ptr, env, i32)<br/>&gt; +DEF_HELPER_6(vabdu_vx_h, void, pt=
r, ptr, tl, ptr, env, i32)<br/>&gt; +DEF_HELPER_6(vabdu_vx_w, void, ptr, pt=
r, tl, ptr, env, i32)<br/>&gt; +DEF_HELPER_6(vabdu_vx_d, void, ptr, ptr, tl=
, ptr, env, i32)<br/>&gt; +DEF_HELPER_6(vwabda_vv_b, void, ptr, ptr, ptr, p=
tr, env, i32)<br/>&gt; +DEF_HELPER_6(vwabda_vv_h, void, ptr, ptr, ptr, ptr,=
 env, i32)<br/>&gt; +DEF_HELPER_6(vwabda_vx_b, void, ptr, ptr, tl, ptr, env=
, i32)<br/>&gt; +DEF_HELPER_6(vwabda_vx_h, void, ptr, ptr, tl, ptr, env, i3=
2)<br/>&gt; +DEF_HELPER_6(vwabdau_vv_b, void, ptr, ptr, ptr, ptr, env, i32)=
<br/>&gt; +DEF_HELPER_6(vwabdau_vv_h, void, ptr, ptr, ptr, ptr, env, i32)<b=
r/>&gt; +DEF_HELPER_6(vwabdau_vx_b, void, ptr, ptr, tl, ptr, env, i32)<br/>=
&gt; +DEF_HELPER_6(vwabdau_vx_h, void, ptr, ptr, tl, ptr, env, i32)<br/>&gt=
; +<br/>&gt; =C2=A0 /* CFI (zicfiss) helpers */<br/>&gt; =C2=A0 #ifndef CON=
FIG_USER_ONLY<br/>&gt; =C2=A0 DEF_HELPER_1(ssamoswap_disabled, void, env)<b=
r/>&gt; diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decod=
e<br/>&gt; index 21272fdb50..1c991a6f42 100644<br/>&gt; --- a/target/riscv/=
insn32.decode<br/>&gt; +++ b/target/riscv/insn32.decode<br/>&gt; @@ -1084,3=
 +1084,13 @@ sb_aqrl =C2=A000111 . . ..... ..... 000 ..... 0101111 @atom_st=
<br/>&gt; =C2=A0 sh_aqrl =C2=A000111 . . ..... ..... 001 ..... 0101111 @ato=
m_st<br/>&gt; =C2=A0 sw_aqrl =C2=A000111 . . ..... ..... 010 ..... 0101111 =
@atom_st<br/>&gt; =C2=A0 sd_aqrl =C2=A000111 . . ..... ..... 011 ..... 0101=
111 @atom_st<br/>&gt; +<br/>&gt; +# *** Zvabd Extension ***<br/>&gt; +vabd_=
vv =C2=A0 =C2=A0 =C2=A0 010101 . ..... ..... 010 ..... 1010111 @r_vm<br/>&g=
t; +vabd_vx =C2=A0 =C2=A0 =C2=A0 010101 . ..... ..... 110 ..... 1010111 @r_=
vm<br/>&gt; +vabdu_vv =C2=A0 =C2=A0 =C2=A0010110 . ..... ..... 010 ..... 10=
10111 @r_vm<br/>&gt; +vabdu_vx =C2=A0 =C2=A0 =C2=A0010110 . ..... ..... 110=
 ..... 1010111 @r_vm<br/>&gt; +vwabda_vv =C2=A0 =C2=A0 111101 . ..... .....=
 000 ..... 1010111 @r_vm<br/>&gt; +vwabda_vx =C2=A0 =C2=A0 111101 . ..... .=
.... 100 ..... 1010111 @r_vm<br/>&gt; +vwabdau_vv =C2=A0 =C2=A0111110 . ...=
.. ..... 000 ..... 1010111 @r_vm<br/>&gt; +vwabdau_vx =C2=A0 =C2=A0111110 .=
 ..... ..... 100 ..... 1010111 @r_vm<br/>&gt; diff --git a/target/riscv/tcg=
/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc<b=
r/>&gt; index a22e2cae6c..14ef961607 100644<br/>&gt; --- a/target/riscv/tcg=
/insn_trans/trans_rvv.c.inc<br/>&gt; +++ b/target/riscv/tcg/insn_trans/tran=
s_rvv.c.inc<br/>&gt; @@ -4091,3 +4091,48 @@ GEN_INT_EXT_TRANS(vzext_vf8, 3,=
 2)<br/>&gt; =C2=A0 GEN_INT_EXT_TRANS(vsext_vf2, 1, 3)<br/>&gt; =C2=A0 GEN_=
INT_EXT_TRANS(vsext_vf4, 2, 4)<br/>&gt; =C2=A0 GEN_INT_EXT_TRANS(vsext_vf8,=
 3, 5)<br/>&gt; +<br/>&gt; +/* Zvabd Extension */<br/>&gt; +#define GEN_ABD=
_CHECK(NAME, CHECK_FN, MAX_SEW) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br/>&gt; +static bool NAME(DisasContex=
t *s, arg_rmrr *a) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \<br/>&gt; +{ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br/>&gt; + =C2=A0 =C2=
=A0return CHECK_FN(s, a) &amp;&amp; s-&gt;cfg_ptr-&gt;ext_zvabd &amp;&amp; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br/>&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;sew &lt;=3D MAX_SEW &amp;&amp; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br/>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 (s-&gt;sew !=3D MO_64 || s-&gt;cfg_ptr-&gt;ext_zve64x)=
; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br/>&gt; +}<br/>&gt; +G=
EN_ABD_CHECK(vabd_vv_check, opivv_check, MO_64)<br/>&gt; +GEN_ABD_CHECK(vab=
d_vx_check, opivx_check, MO_64)<br/>&gt; +GEN_ABD_CHECK(vwabd_vv_check, opi=
vv_overwrite_widen_check, MO_16)<br/>&gt; +GEN_ABD_CHECK(vwabd_vx_check, op=
ivx_overwrite_widen_check, MO_16)<br/>&gt; +<br/>&gt; +GEN_OPIVV_TRANS(vabd=
_vv, vabd_vv_check)<br/>&gt; +GEN_OPIVX_TRANS(vabd_vx, vabd_vx_check)<br/>&=
gt; +GEN_OPIVV_TRANS(vabdu_vv, vabd_vv_check)<br/>&gt; +GEN_OPIVX_TRANS(vab=
du_vx, vabd_vx_check)<br/>&gt; +<br/>&gt; +#define GEN_ABD_OPIVV_WIDEN_TRAN=
S(NAME, CHECK) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br/>&gt; +static bool trans_##NAME(DisasCo=
ntext *s, arg_rmrr *a) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br/>&gt; +{ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br/>&gt; + =C2=A0 =C2=A0=
static gen_helper_gvec_4_ptr * const fns[2] =3D { =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br/>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0gen_helper_##NAME##_b, gen_helper_##NAME##_h, =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br/>&gt; + =C2=A0 =C2=A0=
}; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br/>&gt; + =C2=A0 =C2=A0return s-&gt;sew &lt;=3D MO_16 &amp;=
&amp; do_opivv_widen(s, a, fns[s-&gt;sew], CHECK); \<br/>&gt; +}<br/>&gt; +=
<br/>&gt; +#define GEN_ABD_OPIVX_WIDEN_TRANS(NAME, CHECK) =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br/>&gt; +static bool trans_##NAME(DisasContext *s, arg_rmrr *a) =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br/>&gt; +{ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \<br/>&gt; + =C2=A0 =C2=A0if (CHECK(s, a)) { =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0\<br/>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0static gen_helper_=
opivx * const fns[2] =3D { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br/>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0gen_helper_##NAME##_b, gen_helper_##NAME##_h, =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br/>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br/>&gt=
; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return opivx_trans(a-&gt;rd, a-&gt;rs1, a-&g=
t;rs2, a-&gt;vm, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<b=
r/>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fns[s-&gt;sew], s); =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br=
/>&gt; + =C2=A0 =C2=A0} =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br/>&gt; + =C2=A0 =C2=A0return false; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br/>&gt; +}<br/>&gt; +<br/>&gt;=
 +GEN_ABD_OPIVV_WIDEN_TRANS(vwabda_vv, vwabd_vv_check)<br/>&gt; +GEN_ABD_OP=
IVX_WIDEN_TRANS(vwabda_vx, vwabd_vx_check)<br/>&gt; +GEN_ABD_OPIVV_WIDEN_TR=
ANS(vwabdau_vv, vwabd_vv_check)<br/>&gt; +GEN_ABD_OPIVX_WIDEN_TRANS(vwabdau=
_vx, vwabd_vx_check)<br/>&gt; diff --git a/target/riscv/tcg/tcg-cpu.c b/tar=
get/riscv/tcg/tcg-cpu.c<br/>&gt; index 9e3cc87f8a..4c2fb6f063 100644<br/>&g=
t; --- a/target/riscv/tcg/tcg-cpu.c<br/>&gt; +++ b/target/riscv/tcg/tcg-cpu=
.c<br/>&gt; @@ -732,6 +732,12 @@ void riscv_cpu_validate_set_extensions(RIS=
CVCPU *cpu, Error **errp)<br/>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retur=
n;<br/>&gt; =C2=A0 =C2=A0 =C2=A0 }<br/>&gt; =C2=A0=C2=A0<br/>&gt; + =C2=A0 =
=C2=A0if ((cpu-&gt;cfg.ext_zvabd) &amp;&amp; !cpu-&gt;cfg.ext_zve32x) {<br/=
>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp,<br/>&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#34;Zvabd extensions =
require V or Zve* extensions&#34;);<br/>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn;<br/>&gt; + =C2=A0 =C2=A0}<br/>&gt; +<br/>&gt; =C2=A0 =C2=A0 =C2=A0 i=
f (cpu-&gt;cfg.ext_zicntr &amp;&amp; !cpu-&gt;cfg.ext_zicsr) {<br/>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(=
ext_zicntr))) {<br/>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e=
rror_setg(errp, &#34;zicntr requires zicsr&#34;);<br/>&gt; diff --git a/tar=
get/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c<br/>&gt; i=
ndex e28d8a3d9f..bdb1efcebc 100644<br/>&gt; --- a/target/riscv/tcg/vector_h=
elper.c<br/>&gt; +++ b/target/riscv/tcg/vector_helper.c<br/>&gt; @@ -5906,3=
 +5906,59 @@ GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)<br/>&g=
t; =C2=A0 GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t, =C2=A0H4, H1)<br/>=
&gt; =C2=A0 GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)<br/>&gt=
; =C2=A0 GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t, =C2=A0H8, H1)<br/>&=
gt; +<br/>&gt; +/* Zvabd Extension */<br/>&gt; +#define DO_ABD(N, M) =C2=A0=
(N &gt; M ? N - M : M - N)<br/>&gt; +#define DO_ABDACC(N, M, D) (DO_ABD(N, =
M) + D)<br/>&gt; +<br/>&gt; +RVVCALL(OPIVV2, vabd_vv_b, OP_SSS_B, H1, H1, H=
1, DO_ABD)<br/>&gt; +RVVCALL(OPIVV2, vabd_vv_h, OP_SSS_H, H2, H2, H2, DO_AB=
D)<br/>&gt; +RVVCALL(OPIVV2, vabd_vv_w, OP_SSS_W, H4, H4, H4, DO_ABD)<br/>&=
gt; +RVVCALL(OPIVV2, vabd_vv_d, OP_SSS_D, H8, H8, H8, DO_ABD)<br/>&gt; +RVV=
CALL(OPIVX2, vabd_vx_b, OP_SSS_B, H1, H1, DO_ABD)<br/>&gt; +RVVCALL(OPIVX2,=
 vabd_vx_h, OP_SSS_H, H2, H2, DO_ABD)<br/>&gt; +RVVCALL(OPIVX2, vabd_vx_w, =
OP_SSS_W, H4, H4, DO_ABD)<br/>&gt; +RVVCALL(OPIVX2, vabd_vx_d, OP_SSS_D, H8=
, H8, DO_ABD)<br/>&gt; +RVVCALL(OPIVV2, vabdu_vv_b, OP_UUU_B, H1, H1, H1, D=
O_ABD)<br/>&gt; +RVVCALL(OPIVV2, vabdu_vv_h, OP_UUU_H, H2, H2, H2, DO_ABD)<=
br/>&gt; +RVVCALL(OPIVV2, vabdu_vv_w, OP_UUU_W, H4, H4, H4, DO_ABD)<br/>&gt=
; +RVVCALL(OPIVV2, vabdu_vv_d, OP_UUU_D, H8, H8, H8, DO_ABD)<br/>&gt; +RVVC=
ALL(OPIVX2, vabdu_vx_b, OP_UUU_B, H1, H1, DO_ABD)<br/>&gt; +RVVCALL(OPIVX2,=
 vabdu_vx_h, OP_UUU_H, H2, H2, DO_ABD)<br/>&gt; +RVVCALL(OPIVX2, vabdu_vx_w=
, OP_UUU_W, H4, H4, DO_ABD)<br/>&gt; +RVVCALL(OPIVX2, vabdu_vx_d, OP_UUU_D,=
 H8, H8, DO_ABD)<br/>&gt; +<br/>&gt; +RVVCALL(OPIVV3, vwabda_vv_b, WOP_SSS_=
B, H2, H1, H1, DO_ABDACC)<br/>&gt; +RVVCALL(OPIVV3, vwabda_vv_h, WOP_SSS_H,=
 H4, H2, H2, DO_ABDACC)<br/>&gt; +RVVCALL(OPIVX3, vwabda_vx_b, WOP_SSS_B, H=
2, H1, DO_ABDACC)<br/>&gt; +RVVCALL(OPIVX3, vwabda_vx_h, WOP_SSS_H, H4, H2,=
 DO_ABDACC)<br/>&gt; +RVVCALL(OPIVV3, vwabdau_vv_b, WOP_UUU_B, H2, H1, H1, =
DO_ABDACC)<br/>&gt; +RVVCALL(OPIVV3, vwabdau_vv_h, WOP_UUU_H, H4, H2, H2, D=
O_ABDACC)<br/>&gt; +RVVCALL(OPIVX3, vwabdau_vx_b, WOP_UUU_B, H2, H1, DO_ABD=
ACC)<br/>&gt; +RVVCALL(OPIVX3, vwabdau_vx_h, WOP_UUU_H, H4, H2, DO_ABDACC)<=
br/>&gt; +<br/>&gt; +GEN_VEXT_VV(vabd_vv_b, 1)<br/>&gt; +GEN_VEXT_VV(vabd_v=
v_h, 2)<br/>&gt; +GEN_VEXT_VV(vabd_vv_w, 4)<br/>&gt; +GEN_VEXT_VV(vabd_vv_d=
, 8)<br/>&gt; +GEN_VEXT_VX(vabd_vx_b, 1)<br/>&gt; +GEN_VEXT_VX(vabd_vx_h, 2=
)<br/>&gt; +GEN_VEXT_VX(vabd_vx_w, 4)<br/>&gt; +GEN_VEXT_VX(vabd_vx_d, 8)<b=
r/>&gt; +GEN_VEXT_VV(vabdu_vv_b, 1)<br/>&gt; +GEN_VEXT_VV(vabdu_vv_h, 2)<br=
/>&gt; +GEN_VEXT_VV(vabdu_vv_w, 4)<br/>&gt; +GEN_VEXT_VV(vabdu_vv_d, 8)<br/=
>&gt; +GEN_VEXT_VX(vabdu_vx_b, 1)<br/>&gt; +GEN_VEXT_VX(vabdu_vx_h, 2)<br/>=
&gt; +GEN_VEXT_VX(vabdu_vx_w, 4)<br/>&gt; +GEN_VEXT_VX(vabdu_vx_d, 8)<br/>&=
gt; +<br/>&gt; +GEN_VEXT_VV(vwabda_vv_b, 2)<br/>&gt; +GEN_VEXT_VV(vwabda_vv=
_h, 4)<br/>&gt; +GEN_VEXT_VX(vwabda_vx_b, 2)<br/>&gt; +GEN_VEXT_VX(vwabda_v=
x_h, 4)<br/>&gt; +GEN_VEXT_VV(vwabdau_vv_b, 2)<br/>&gt; +GEN_VEXT_VV(vwabda=
u_vv_h, 4)<br/>&gt; +GEN_VEXT_VX(vwabdau_vx_b, 2)<br/>&gt; +GEN_VEXT_VX(vwa=
bdau_vx_h, 4)<br/></div></div></div></div></div></div></div></div></body></=
html>
--ad8fb322d1c23b556c768fb458fc4fb8702cd956827b899f757d42dc30af--

