Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A42C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAmp-0005Wv-T3; Wed, 12 Aug 2026 11:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuAmo-0005Mn-FB; Wed, 12 Aug 2026 11:22:34 -0400
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuAmm-0000h4-Mr; Wed, 12 Aug 2026 11:22:34 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A22C2140009E;
 Wed, 12 Aug 2026 11:22:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 12 Aug 2026 11:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786548151; x=1786634551; bh=4Bzmqiuir6MD+dTA0dffWmeCuZieHTH5
 e1B0uFmpwtQ=; b=kwMGPXTApe+kp+hajfASgLilWA1Yo2RywzQyFkiRpyIXnWZN
 YCfOFKPhkbEVSOHFk6gbLeBdmHwtiLCj2xRQoxQP5EBqK99y0Ptbffm8VrRtRnwj
 S4Kvit0chy+9MeNH8XbUZfEGJh/ohYWoVv1q/QDhng1RerdjXWeh+XTd7Xyu4UAD
 iwtwQfIYK+eUyguLlAiTrfr5oRC3Bd8w3r7EkWRbCri4Vp3BaVIuo8m7l8wbiFwu
 BINnjwUvhvaHL4m6k5n34AWimdtzSNI0iy3DkpffHFXD6P9uiUb7dOvj+gNHiJ4R
 4TgULeI3o4ncYulnRcc0Oe83DnpClpZRWgCSlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786548151; x=
 1786634551; bh=4Bzmqiuir6MD+dTA0dffWmeCuZieHTH5e1B0uFmpwtQ=; b=G
 3hyBs+Lc2YK4QSbZ4TQTE4l+hAHUv8lzV21A8fxznSDFuItMOvQ6ViSfgDuBrLBb
 qpUjPQAd7OOcHamczmh4ezoNW3REY7VMgVrXVyIDgLJr5CQXvzlk2U/aNDH1DH29
 4br3DY903cSYddcmnk/f4Ha4PnVKfC9uxrwLkNYmBRg74iA5davGDwP+iWcQRts9
 TmVS+CqWlzOxsGp5ag8NabyxhT/xOQacsLXoNHswjmx16CY19gc5AQIaeKkHYP1e
 oKxBKId342PMEkaR0sq/aKbCBKdc/QZuafe/Fpm3J/TGZvP/s331zNqi7vIiEQz9
 1NU93bXOXSsj2wLEwOzQQ==
X-ME-Sender: <xms:t498akFRXfEUWN317p9KURLSXA9KHLJ41QLAHaVadwM4o9YtZ2t47w>
 <xme:t498ajV2qrqpFBDqFstNo9WAL7TAdV7fpzXVtKmUCug0NAtFYsCsrRWnJAtunzGIx
 Yvz089NNPMTKkFKrpvEh64BEVZ0xDi_hUyLnxgWggx9FkrGWTZ3kILc>
X-ME-Received: <xmr:t498ao9bZCPxOcJEsy55EgcSyBrA8jJUAo94BKnjJSWQ4WJKT90t7-7W-5ieB93qoBdAVA>
X-ME-Proxy-Cause: dmFkZTG2ARt8DRO3A3fBFm7Vip4QpR/nUXZGWfXmvvPLO0uIsyPIQWERkRADqw426BTU5e
 NJI6GyhZuywkD7c8MecpBZ4Lc6Ceu2UlxEYqNHoKxQ/Bu5ozVgojZP51F/rC9REh3PbUkf
 mJJMRMrcxXcEAfoMYiF03Z5Otu1DsXMFERmGowuPNgR0ByIW3gbILTYsC9Bi3k2lNqyl1f
 CVP1HWJef3WFvhhYADNCwRR5pzoh2BtTjlU3MEr5GlpQlBWpZiRtpeczz2/b4T9OFvfsyV
 8Xy1W9xzv0Lxy4YcVAkcJEh687JMomZIv8v4aIgJH8VSShTmAWGoR0cBB40sl4JY0pbYCm
 NeZy2/4lvlWMppRvR6aTAaElSUYuMTqCyDlg62U62xPlTUK1zr12uiL6U0uHMRBEpqKpzn
 bywCpPoOUpC+7DdpMdmp/d0ysADnrQTzYqVclJGWBpso/iIutTYFqp96UUzJbla1TFKFlq
 drNSgtlEsKvxNGdfQELpdr1tqkS9l/PSUKQz7PSoY4E3olkIuSVwvpglnVvLrbIlNJpgaE
 jmXBZGxpf5QNcbyhDaeYNnWEWOpVJYT38dqjV9WHv4hPRm4cdcNUiLGoR/Cd2Z0NK0KYS+
 D2rpRngCVHIfuarfvsaR7KWq4fb33WrEX5WYJmVZd+S8sK5DqsyE3kqPKU9Q
X-ME-Proxy: <xmx:t498ao6GQ2jdko81CnPKQLbEDS5-txdcW0SVfjzvycmHFwzNap4DAA>
 <xmx:t498apmgBsgT7G2qa_7STXkSC3q9KTwUv89wMX3iQyxeBa22Ko4vjA>
 <xmx:t498ajFdoDy55UX-wzdRqdvRyaiCl_CK-t7lawzDgh15RMpE92M2lg>
 <xmx:t498ao_3e0IOEzbEwp10On1gd0HfhR5l_SDKygIzy8gw2S4TimTErg>
 <xmx:t498aiCeethr-pTNHzb0Ge433bDWTY9zThDM9IDIL5d_dWLWvebyDBI6>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 11:22:30 -0400 (EDT)
Message-ID: <8d6c58acb0c436e837b97f602cb06b80933a0b31.camel@alistair23.me>
Subject: Re: [PATCH v4 0/5] disas/riscv: Fix immediate decoding and extraction
From: Alistair <alistair@alistair23.me>
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>, LIU Zhiwei	
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>, Richard Henderson
 <richard.henderson@linaro.org>, qemu-riscv@nongnu.org, Alex
 =?ISO-8859-1?Q?Benn=E9e?=	 <alex.bennee@linaro.org>
In-Reply-To: <20260703-b4-disas-xthead-fix-riscv-next-v4-0-84c566330bc7@linux.alibaba.com>
References: <20260703-b4-disas-xthead-fix-riscv-next-v4-0-84c566330bc7@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 01:21:24 +1000
User-Agent: Evolution 3.60.2 (by Flathub.org) 
Received-SPF: pass client-ip=103.168.172.152;
 envelope-from=alistair@alistair23.me; helo=fhigh-a1-smtp.messagingengine.com
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

Thanks!

Applied to riscv-to-apply.next

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

