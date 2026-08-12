Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6135EC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAj8-0006rx-7x; Wed, 12 Aug 2026 11:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuAiv-0006hP-LT; Wed, 12 Aug 2026 11:18:35 -0400
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuAit-0007hB-Oy; Wed, 12 Aug 2026 11:18:33 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id A9CF3EC01F2;
 Wed, 12 Aug 2026 11:18:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Wed, 12 Aug 2026 11:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786547910; x=1786634310; bh=oJwEXy3fbEcrYkPilZkWijtFdlvNkbQD
 o533dlgFzl0=; b=LpVNychX19GZULLXXRL+zmJmy+GyqfWuv7CHsfd5QVgDMpBC
 ovQicO/r/vi98tT4qhdbUyfbj9mNn/xid2ZHW4a5n6Pa3WzxjetH6I9B0LM1xO1v
 5KUFHY83K6JDRUlVjALSoe0CeQKKaF1NllaIPRpnySe9YIlgcJwE8ebEfdCl4RPq
 njgpkDTf1X1aBsMVd3V6/gBfaFnsBrtLO9G48HHQLRhYei+2USiPXQ+U9N+jU1vh
 yNTi/aVSNDVln7GOJYkhSGMdyHBC5MgnWetOXCfRMJbWvrDuDng1r063WTHmS1c0
 +bwyWou7typIDjBstTBvM/hx6ORPtw1Y1SipvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786547910; x=
 1786634310; bh=oJwEXy3fbEcrYkPilZkWijtFdlvNkbQDo533dlgFzl0=; b=B
 do9WO+2iXZm3wJE72D7n0KK8b0nSUHkSaD6s83NN2hRMwtk71uFPQRD/SbX10PMW
 Z4+56WKW09Yg6vhsr4pleKMe8NSwfrxgmypiINVel6Aj4owytOsrasBfMMyI/Clp
 mHk94WHIaubHTk7c50TNS/O9y77qJGuUEwTIxjJ68gShc6/svqf04HukM6bgSP41
 ywDcTc5+Ng4eEGjtkVEuiUNbx/bUeTCBmw5nBWMQ6N5CmoNwMVcEaOpYaWgFAzDR
 9n/Kco2yVuDKxsjOI1KZ8roKhpoox3mGwrk/gwMmaOTBwJ9GKjcfLy9A7jMnswIF
 zcBRi/a66+QI851idQhIw==
X-ME-Sender: <xms:xY58anTdVXjIATXy0mMEZC_QtWZE0Ak1z4cwJHVGAWOoZmxiX4Io0g>
 <xme:xY58auz5d_km4l5imlvAF_gB1uQgl8yVRyEsS8-0QevAVB6-FVCZ-NFXcD1rgmRDY
 GAsL_Osb7EO2N0hr6IPJgAP3B3r59OU8XXhtgv_Y2DTbcejLUKEHgU>
X-ME-Received: <xmr:xY58anra76PbAHTjq5AZpLUK7SCsmNEdxE3WfG--h1YN0KzhCE9UFs5AaorAesi6Oxcdmg>
X-ME-Proxy-Cause: dmFkZTEo8X8ob/iPc7sRjBu8nuzFvJKrct9hp5bW6vDLbMOQ1dkiBg5WwUWTPh5eAZYfWw
 u4CognJeHyRkb24z7rocDSF8f81o5Ka4a9WZ/fQglmGtowfVbbrFYE7pCi4imRSXf8HWY/
 TrGRwgPf0dgt60pm6s0IxqjAxR543RJtZlr6v0VHAtGp7Kag+hK9DePAsjBu4mdnOf8ibh
 pwrTS0+jk3+9KkmP+VaHqIOs8WW9PjsZi/NDQy2pjqIRPTUf+lwU1rKUY27OJSkSYXyq0O
 dlJ0pMCQvHwSMgZahC8cDzryAIhAq6fHChOJtbuar13EITzu7JaBrpF4y+54751VVIgNPp
 bvSNWL6ExtMy3VsRCGVOSp0BRIxxQGwO82L+qnxFgcXR8IRArP2HC6m9DfQ0EG737i8a/C
 tj0URwOuhA3OYJMrwozeF1JT91Hw1weUdryjhitiSIpiYflbSZPN5rmTLXzbvfsDWgJOmo
 pRXrVY3PT56MmY9+d+4DsYKjM29CLsmo4A74wCeOCFjQHnaYQ85NIw0LGzwNZr09OXkmwn
 0BAzcEJ2KFDo7TezRByC8lmfY688pT1kRix0pOh7dNKz4FXoOkktQLuI5T3RZ3BDFUWgAx
 k1M35IXJUc4vVTHoY605UVchOaHWmNM1PrevQLzGZEmIMPTJRPhlbM680TJw
X-ME-Proxy: <xmx:xY58ap2yU0IY7yeRjfsVHhhHt4uizl5T3ACYmxk8oEZ-hOfLoYMPVw>
 <xmx:xo58avzcUsg31JrfCB4O0dmvTDMWIMwbxTCgRU_iMBPlfdbtMzvh2g>
 <xmx:xo58algFm2B9Usz6akmSiSsQgon86mkomKmHzGPdAB3AcDRrwYSwAw>
 <xmx:xo58aiqaPJ1luz7XtGu94YDsFURlxr-DKUlKG121eedqZ0gdUBH6hg>
 <xmx:xo58avu5AmkTf2s7vlGfeyHqzzvEqCWVA0fyFvmtntoW8f4W1rKBymXz>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 11:18:29 -0400 (EDT)
Message-ID: <7312e5f5d1f763aa1accb2764878827d6a10db4a.camel@alistair23.me>
Subject: Re: [PATCH v4 0/5] disas/riscv: Fix immediate decoding and extraction
From: Alistair <alistair@alistair23.me>
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>, LIU Zhiwei	
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>, Richard Henderson
 <richard.henderson@linaro.org>, qemu-riscv@nongnu.org, Alex
 =?ISO-8859-1?Q?Benn=E9e?=	 <alex.bennee@linaro.org>
Date: Thu, 13 Aug 2026 01:18:13 +1000
In-Reply-To: <20260703-b4-disas-xthead-fix-riscv-next-v4-0-84c566330bc7@linux.alibaba.com>
References: <20260703-b4-disas-xthead-fix-riscv-next-v4-0-84c566330bc7@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.151;
 envelope-from=alistair@alistair23.me; helo=fout-a8-smtp.messagingengine.com
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

On Fri, 2026-07-03 at 13:03 +0800, TANG Tiancheng wrote:
> Fix two XThead immediate decoding issues in the RISC-V disassembler,
> fix
> vector immediate signedness handling, and make operand extraction
> more
> explicit.
>=20
> The first patch aligns th.srri decoding with
> target/riscv/xthead.decode:
> th_srri uses bits 31:26 as 000100 and bit 25 as shamt[5], while the
> disassembler switches on bits 31:25.
>=20
> The second patch extracts the full 6-bit immediate field for
> rv_codec_r2_imm6, which fixes the immediate printed for th.srri and
> th.tst.
>=20
> The third patch makes operand_vimm() return int32_t, matching the
> signed
> 5-bit vector immediate value it extracts.
>=20
> The fourth patch decodes unsigned 5-bit vector immediates with a
> separate
> codec, matching the target translator paths that zero-extend or
> truncate
> those fields.
>=20
> The fifth patch follows Richard's review suggestion by converting
> operand
> helper bit extraction to extract32() or sextract32(). Signed
> immediates use
> sextract32() on the sign-bearing field and combine it with the
> remaining
> extract32() fields.
>=20
> This series is based on Alistair's riscv-to-apply.next branch:
> 64ce9ac18757 ("hw/riscv/riscv-iommu.c: always fault with SADE=3D0 and
> A=3D0")
>=20
> Testing:
> - Applied and tested on top of Alistair's riscv-to-apply.next branch.
> - Verified with an external test branch that adds unit coverage:
> =C2=A0 https://github.com/LLyndra/qemu.git=C2=A0b4-disas-riscv-v2-tests
>=20
> =C2=A0 The added tests cover XThead th.srri/th.tst immediate decoding,
> =C2=A0 signed vector immediates, unsigned vector immediate operands, and
> =C2=A0 signed base ISA I-immediate extraction.
> - Commands run:
> =C2=A0=C2=A0=C2=A0 ./configure --target-list=3Driscv64-softmmu --disable-=
docs \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --prefix=3D/tmp/qemu-riscv-dis=
as-test --cross-prefix=3D
> =C2=A0=C2=A0=C2=A0 ninja -C build tests/unit/test-riscv-disas
> =C2=A0=C2=A0=C2=A0 build/tests/unit/test-riscv-disas --tap -k
> - Result:
> =C2=A0=C2=A0=C2=A0 test-riscv-disas passed: 37/37 TAP tests ok.
>=20
> ---
> Changes in v4:
> - Rebased on current Alistair's riscv-to-apply.next branch.
> - Folded Alex's extract32() suggestion into the 6-bit immediate
> =C2=A0 fix patch, so it directly uses extract32(inst, 20, 6).
> - Link to v3:
> https://lore.kernel.org/qemu-devel/20260701-b4-disas-xthead-fix-riscv-nex=
t-v3-0-fc4f5f1b6c15@linux.alibaba.com
>=20
> Changes in v3:
> - Updated the extract-helper cleanup patch to use sextract32() on the
> =C2=A0 sign-bearing field directly, as suggested by Richard.
> - Link to v2:
> https://lore.kernel.org/qemu-devel/20260701-b4-disas-xthead-fix-riscv-nex=
t-v2-0-e6e4ff5a7847@linux.alibaba.com
>=20
> Changes in v2:
> - Collected Reviewed-by tags from Daniel.
> - Kept the 6-bit immediate fix as a minimal correctness change.
> - Added a patch making the signed vector immediate helper return a
> signed
> =C2=A0 type.
> - Added a patch decoding unsigned vector immediates separately from
> signed
> =C2=A0 vector immediates.
> - Added a cleanup patch using extract32()/sextract32() for
> replaceable
> =C2=A0 operand helper field extraction, including split immediates, as
> =C2=A0 suggested by Richard.
> - Link to v1:
> https://lore.kernel.org/qemu-devel/20260626-b4-disas-xthead-fix-riscv-nex=
t-v1-0-74228a3c1b21@linux.alibaba.com
>=20
> ---
> TANG Tiancheng (5):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disas/riscv: Fix th.srri decoding
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disas/riscv: Fix 6-bit immediate extractio=
n
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disas/riscv: Use signed type for vector im=
mediates
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disas/riscv: Decode unsigned vector immedi=
ates as unsigned
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disas/riscv: Use extract helpers for opera=
nd fields

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>=20
> =C2=A0disas/riscv-xthead.c |=C2=A0=C2=A0 6 +-
> =C2=A0disas/riscv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 263 +++++=
++++++++++++++++++++++--------------
> ----------
> =C2=A0disas/riscv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> =C2=A03 files changed, 142 insertions(+), 128 deletions(-)
> ---
> base-commit: 64ce9ac18757d79f3b5b337f7bcbdd0dabef3ce1
> change-id: 20260623-b4-disas-xthead-fix-riscv-next-c6af6a09d2dc
>=20
> Best regards,

