Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE24C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsbb-0004AR-WB; Tue, 11 Aug 2026 15:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsbK-00049A-20; Tue, 11 Aug 2026 15:57:31 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsbG-00008f-Bx; Tue, 11 Aug 2026 15:57:29 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5C56214000D7;
 Tue, 11 Aug 2026 15:57:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 11 Aug 2026 15:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786478245; x=1786564645; bh=ko4paPbrdNStriHXQmvmoanWH++pnFYX
 7MZ22F2vrmo=; b=0lhrR82152iK/lh/Zo42TEGiSpPc6miU3YkVnE5SqKyQGFcr
 aZclwrboTFSxBbfOeKTGi6mY6DyppUP9JhHAZApxqc7nMFpalh+as6DKzBmE7STI
 6faCZcw9mKHM1gZFfCkXE1JH1Ft11OYhIXRhYpcjPmT5acTVG5k98srrEExqeeHU
 ka5aB/dey5zw2lOowQpubOOHoQHbalVZ10pcecKLh7wMgX/UT0GQ8otAj7f3nW7q
 clflWAX3EJ5yy01p9gairhAWkR5wKMM4FW5Zogh+c9xposfC+TBQ4MwIDX1y6bZV
 2OoiLsEw2VGKx/Qw+W20tDIPyQGT50NQdvyu1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786478245; x=
 1786564645; bh=ko4paPbrdNStriHXQmvmoanWH++pnFYX7MZ22F2vrmo=; b=N
 HPR+TrsWJEDI8VCqazsays7E4PRKuLMwfsN0NsPgSiU0kyPwVsnv9helYwiUyIcP
 /9l+61ly5s1vB6lqPeh5hTkn9oa7VyTZeWnEGtJMBcwfWRbqR0m45bB5F5SUoO8x
 YX7UXdInfuHHCZseHT7DZ0J9FbQYKHqCUSLOl4qC5r8HELf4tyx7teWNb3o7AHlq
 2/O+jjfTLCAGl8XygQdw/1G1ehb5Z3HnWcQY+4HWG9sUXGo/e+9SlTFuoD0nEucu
 hyx1cgPnp4OvVbcLl3+OP2bxc9o1PdgDzL9KDbbgW6B5HKugp0l76R94TnCly/zf
 g3DmwoZW2mqdvqIQcnP2Q==
X-ME-Sender: <xms:pX57ag3k19pJoV0wOEzQp8g_FHBfXcZFEyEdXzkSq6Yehn4Ol6K9Vg>
 <xme:pX57asnxbCyeUeestaBlQk-i8x_Gk91dzV9zKTlMHIWblPdgOrwrDC1rZmplMTS10
 Hp4EvFgSe5ba9yCsBKq6LF4e2NafMytv-e_X7qo2OvEGyOEESwPJg>
X-ME-Received: <xmr:pX57ao9F_zM3ltwoJAJ4we8h2XWYlCZ0NDBF1p7YX7H9VxX59_U1WQzsc8nhiqNla8wXhg>
X-ME-Proxy-Cause: dmFkZTG022mVQphzI7AWPJwf5iH2zrR/m6qBn9XfRmKRpHDMJFydYTJQKVsM1QV+rwV6La
 5lrePzwx4fvDAbuWGvHeRfj/XXR7cRigp+VFqRksAUG14iVvyA71KFanGk670lEqM8JVu4
 s34RyOYIIjP0W8WBcm0e1tPVBp/pNSsHcdVX1Ks29W2b9Vr5JvJeEXiSndrwW6yXxb4+J4
 eZfRbt29FtMtF3dLgjNB6mepufrYu6ZS9dF46cYmkr7C0VornlkrAZTNc8V+Abmi0Y7yME
 8S+ZxumAgsgCiVLwzI8RB5uG9SF/jOVVCcorsE69lSTOl6wZGe9l8hpUAF/XNdPBWsb4Bp
 1F+pgEn0pIeKp7cKnKCucj2vl3ayWLY9L0d/pHyqdtf+GjSUwqerv6uTeZ+Bp8J5A5K4Ss
 7axhpSFE00EjG2iEhFeq6mcz+qoW26+BQTy4bjBZVzD/jG73Z/pSYAIObAm6LwnRjD9CvJ
 dQ1Bs4uPdGlO/IB5r38PxiComS0VJsASNHPxOV0Jg3Kx1soT08rzgUwoPAVLBhxYimACX9
 3Rzv52hf8G/nmvXOMFdC8meszp7bs5tkK7kg1+WueQALeoBceS/wO6HyDc1Nd/4YHz9lMn
 BytTcz/sKGFDB6ArYQFQDlKIClKMFKxLRj4YqC7KK4JbmUu7zwBJ2Q4+/7ag
X-ME-Proxy: <xmx:pX57appx_6EOGOn_KFLveFH26mtg8b9nR60IF6ZGm_YK8iR0kt18yQ>
 <xmx:pX57apkCBRb49rys9d9LGE3jpwbEZ20U2XI0SrJMyPmFGlho7IR3Qw>
 <xmx:pX57aojS9Oo1lnna19cEStItE5i_tTgvYrX-RdOJSsKEGsFC_iQYJA>
 <xmx:pX57apcuh02cRoH8kQCwIvDW1t0rfiGGvvuQHjD09NDGxUcCAtIn4Q>
 <xmx:pX57aj0JF9UmgYUkrOzz99Axxku_Naai0ktGoyEAcUgqFuRP--DbDpU7>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 15:57:24 -0400 (EDT)
Message-ID: <d234c0fb6f6b09f30492c75331e4f0c74442d4c4.camel@alistair23.me>
Subject: Re: [PATCH 04/56] disas/riscv: Decode unsigned vector immediates as
 unsigned
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>
Date: Wed, 12 Aug 2026 05:57:24 +1000
In-Reply-To: <20260809223545.730664-5-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=alistair@alistair23.me; helo=fhigh-a6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Sun, 2026-08-09 at 15:34 -0700, Richard Henderson wrote:
> From: TANG Tiancheng <lyndra@linux.alibaba.com>
>=20
> rv_codec_v_i decodes all .vi operands with operand_vimm(), which
> sign-extends bits 19:15. That matches spec operands named imm, but
> not the
> .vi forms whose operand is uimm; uimm=3D31 is decoded as -1 and printed
> by
> the shared 6-bit 'u' formatter as 63.
>=20
> Add rv_codec_v_i_u/operand_vuimm() for the 5-bit uimm forms: vsll.vi,
> vsrl.vi, vsra.vi, vnsrl.wi, vnsra.wi, vssrl.vi, vssra.vi, vnclipu.wi,
> vnclip.wi, vslideup.vi, vslidedown.vi, vrgather.vi, vaeskf1.vi,
> vaeskf2.vi, vsm3c.vi, vsm4k.vi and vwsll.vi. The remaining
> rv_codec_v_i
> entries are the signed imm forms.
>=20
> Fixes: 07f4964d1785 ("disas/riscv.c: rvv: Add disas support for
> vector instructions")
> Fixes: 9d92f56d4a44 ("disas/riscv: Add support for vector crypto
> extensions")
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Message-Id:
> <20260703-b4-disas-xthead-fix-riscv-next-v4-4-84c566330bc7@linux.alib
> aba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.h |=C2=A0 1 +
> =C2=A0disas/riscv.c | 45 ++++++++++++++++++++++++++++-----------------
> =C2=A02 files changed, 29 insertions(+), 17 deletions(-)
>=20
> diff --git a/disas/riscv.h b/disas/riscv.h
> index 379e642ec8..91ada8b531 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -149,6 +149,7 @@ typedef enum {
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_codec_v_r,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_codec_v_ldst,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_codec_v_i,
> +=C2=A0=C2=A0=C2=A0 rv_codec_v_i_u,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_codec_vsetvli,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_codec_vsetivli,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_codec_vror_vi,
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 967739bdbb..82b962dc71 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -1803,19 +1803,19 @@ const rv_opcode_data rvi_opcode_data[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vxor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm,=
 NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm,=
 NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm,=
 NULL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsll.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NUL=
L, 0, 0, 0
> },
> +=C2=A0=C2=A0=C2=A0 { "vsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, N=
ULL, 0, 0,
> 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vsrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm,=
 NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vsrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm,=
 NULL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsrl.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NUL=
L, 0, 0, 0
> },
> +=C2=A0=C2=A0=C2=A0 { "vsrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, N=
ULL, 0, 0,
> 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vsra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm,=
 NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vsra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm,=
 NULL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsra.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NUL=
L, 0, 0, 0
> },
> +=C2=A0=C2=A0=C2=A0 { "vsra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, N=
ULL, 0, 0,
> 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vnsrl.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm=
, NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vnsrl.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm=
, NULL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vnsrl.wi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NU=
LL, 0, 0, 0
> },
> +=C2=A0=C2=A0=C2=A0 { "vnsrl.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, =
NULL, 0, 0,
> 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vnsra.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm=
, NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vnsra.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm=
, NULL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vnsra.wi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NU=
LL, 0, 0, 0
> },
> +=C2=A0=C2=A0=C2=A0 { "vnsra.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, =
NULL, 0, 0,
> 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vmseq.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm=
, NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vmseq.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm=
, NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vmseq.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm=
, NULL, 0, 0, 0
> },
> @@ -1909,16 +1909,16 @@ const rv_opcode_data rvi_opcode_data[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vsmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm=
, NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vssrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm=
, NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vssrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm=
, NULL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vssrl.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NU=
LL, 0, 0, 0
> },
> +=C2=A0=C2=A0=C2=A0 { "vssrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, =
NULL, 0, 0,
> 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vssra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm=
, NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vssra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm=
, NULL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vssra.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NU=
LL, 0, 0, 0
> },
> +=C2=A0=C2=A0=C2=A0 { "vssra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, =
NULL, 0, 0,
> 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vnclipu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_=
vm, NULL, 0, 0,
> 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vnclipu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_=
vm, NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vnclipu.wi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, =
NULL, 0, 0,
> 0 },
> +=C2=A0=C2=A0=C2=A0 { "vnclipu.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm=
, NULL, 0,
> 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vnclip.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_v=
m, NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vnclip.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_v=
m, NULL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vnclip.wi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, N=
ULL, 0, 0,
> 0 },
> +=C2=A0=C2=A0=C2=A0 { "vnclip.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm,=
 NULL, 0,
> 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vfadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm=
, NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vfadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm=
, NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vfsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm=
, NULL, 0, 0, 0
> },
> @@ -2048,15 +2048,15 @@ const rv_opcode_data rvi_opcode_data[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vfmv.f.s", rv_codec_v_r, rv_fmt_fd_vs2, NULL,=
 0, 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vfmv.s.f", rv_codec_v_r, rv_fmt_vd_fs1, NULL,=
 0, 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vslideup.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1=
_vm, NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vslideup.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm,=
 NULL, 0,
> 0, 0 },
> +=C2=A0=C2=A0=C2=A0 { "vslideup.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_v=
m, NULL, 0,
> 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vslide1up.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs=
1_vm, NULL, 0,
> 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vslidedown.vx", rv_codec_v_r, rv_fmt_vd_vs2_r=
s1_vm, NULL, 0,
> 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vslidedown.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_v=
m, NULL, 0,
> 0, 0 },
> +=C2=A0=C2=A0=C2=A0 { "vslidedown.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm=
_vm, NULL,
> 0, 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vslide1down.vx", rv_codec_v_r, rv_fmt_vd_vs2_=
rs1_vm, NULL, 0,
> 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vrgather.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1=
_vm, NULL, 0, 0,
> 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vrgatherei16.vv", rv_codec_v_r, rv_fmt_vd_vs2=
_vs1_vm, NULL,
> 0, 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vrgather.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1=
_vm, NULL, 0, 0,
> 0 },
> -=C2=A0=C2=A0=C2=A0 { "vrgather.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm,=
 NULL, 0,
> 0, 0 },
> +=C2=A0=C2=A0=C2=A0 { "vrgather.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_v=
m, NULL, 0,
> 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vcompress.vm", rv_codec_v_r, rv_fmt_vd_vs2_vs=
1, NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vmv1r.v", rv_codec_v_r, rv_fmt_vd_vs2, NULL, =
0, 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vmv2r.v", rv_codec_v_r, rv_fmt_vd_vs2, NULL, =
0, 0, 0 },
> @@ -2144,8 +2144,8 @@ const rv_opcode_data rvi_opcode_data[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vaesef.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL=
, 0, 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vaesem.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL=
, 0, 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vaesem.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL=
, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vaeskf1.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm, NUL=
L, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vaeskf2.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm, NUL=
L, 0, 0, 0
> },
> +=C2=A0=C2=A0=C2=A0 { "vaeskf1.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm, N=
ULL, 0, 0,
> 0 },
> +=C2=A0=C2=A0=C2=A0 { "vaeskf2.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm, N=
ULL, 0, 0,
> 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vaesz.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL,=
 0, 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vandn.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm=
, NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vandn.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm=
, NULL, 0, 0, 0
> },
> @@ -2169,14 +2169,14 @@ const rv_opcode_data rvi_opcode_data[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vsha2ch.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1,=
 NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vsha2cl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1,=
 NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vsha2ms.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1,=
 NULL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vsm3c.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm, NULL,=
 0, 0, 0 },
> +=C2=A0=C2=A0=C2=A0 { "vsm3c.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm, NUL=
L, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vsm3me.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, =
NULL, 0, 0, 0 },
> -=C2=A0=C2=A0=C2=A0 { "vsm4k.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm, NULL,=
 0, 0, 0 },
> +=C2=A0=C2=A0=C2=A0 { "vsm4k.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm, NUL=
L, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vsm4r.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL,=
 0, 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vsm4r.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL,=
 0, 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vwsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm=
, NULL, 0, 0, 0
> },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "vwsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm=
, NULL, 0, 0, 0
> },
> -=C2=A0=C2=A0=C2=A0 { "vwsll.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NU=
LL, 0, 0, 0
> },
> +=C2=A0=C2=A0=C2=A0 { "vwsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, =
NULL, 0, 0,
> 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_r=
s1, NULL, 0, 0,
> 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_r=
s1, NULL, 0, 0,
> 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_r=
s1, NULL, 0, 0,
> 0 },
> @@ -4492,6 +4492,11 @@ static int32_t operand_vimm(rv_inst inst)
> =C2=A0=C2=A0=C2=A0=C2=A0 return (int64_t)(inst << 44) >> 59;
> =C2=A0}
> =C2=A0
> +static uint32_t operand_vuimm(rv_inst inst)
> +{
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 15, 5);
> +}
> +
> =C2=A0static uint32_t operand_vzimm11(rv_inst inst)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 return (inst << 33) >> 53;
> @@ -4895,6 +4900,12 @@ static void decode_inst_operands(rv_decode
> *dec, rv_isa isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->imm =3D operand_vim=
m(inst);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->vm =3D operand_vm(i=
nst);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0 case rv_codec_v_i_u:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->rd =3D operand_rd(inst);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->rs2 =3D operand_rs2(inst=
);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->imm =3D operand_vuimm(in=
st);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->vm =3D operand_vm(inst);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 case rv_codec_vror_vi:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->rd =3D operand_rd(i=
nst);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dec->rs2 =3D operand_rs2=
(inst);

