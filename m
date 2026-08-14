Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8718DC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wutq7-0008Vl-DD; Fri, 14 Aug 2026 11:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wutq6-0008VW-5z; Fri, 14 Aug 2026 11:28:58 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wutq4-0005Pg-2j; Fri, 14 Aug 2026 11:28:57 -0400
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 963F4EC013B;
 Fri, 14 Aug 2026 11:28:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Fri, 14 Aug 2026 11:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786721334; x=1786807734; bh=k5txefdKVlBQTruGaTnr4/IznN2uBx9D
 txM/DOqgE0o=; b=GmYlaSG0eLg8lHwDUC9IhASf9S+tYK+NuoNrxcFaoh+eUmPr
 dvJLrwS5E3W0VUs24IOGv9sqLDJR63KlExA6h8fUOcim1iDKA5O0fcc8KnskVHhv
 oRixEzcxIok/r7MYI9/+Ppl5bFZNwT7jUauRrssQXlFS7/OBkeNHKWxaZCnmqgVQ
 UEsqilFufYmu/SPjFV9OSIE0AWgj07CcDEnIQgAsXY7RwBjeVWkvpJOdZap4VWhd
 K6qit1Uy/Frp4k6eF9JfOiWz3AggP6dtlvYG2R7EKEKUqD63n056y4vplRA2s6jI
 jsjr0ddcxvmkXusIuP7/G3VShmn9YS0GYBkP9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786721334; x=
 1786807734; bh=k5txefdKVlBQTruGaTnr4/IznN2uBx9DtxM/DOqgE0o=; b=H
 89nYy/Ovn5JGOhm+Y0pB0VKjB9Ba82bAaWWJE6EHHXIfeucMssG2QqYu4JNFDF4/
 GhfvF/3rQVGX3usM4oAjGH3jOzBA5+1hdJj2w27o466JSDcZcvsORsB6uoRA+zWr
 5/E1SpYvweVL/QTHpTFQQKx287JCAQLVzLry4cUwaOKjH+00YK4wOG1YK8+qB2tP
 SlXEDFVfiEeGwL106YqTZ9/sUDy6nK42s4kxuPGv/fWVt26MpuBusxPwCnDQc6LY
 QZGjYqkc1+uBJwbw00GVHptBaQTuz6y4cXp8wdmi6IyvM19TgQF7KcAkg5nEqEh+
 vtoF1CVhPuTpUYuWCruzA==
X-ME-Sender: <xms:NjR_atzmY0MN9SvqRMSzfKi9HSgz9c5m3R4bb1IsjHuEyrLSdiToTw>
 <xme:NjR_atZ0VBiYM5V1IX-wsldqDB0FI07wFiwktruNZvUkDYIPACQDONssMWg2-fq7W
 MMrJrzVWro3n-cEZMj-5x3UQDajEnbbvYYPJKh0Uw5jg0hMw1VMRx7G>
X-ME-Received: <xmr:NjR_avQMCfQfpzGuXBYH2qm1lI9xjYYEet_TGPJFQIOz67KjCt21byjua471Ye_X6OA86g>
X-ME-Proxy-Cause: dmFkZTFlcj0k83MDKof4hWght9wvWbkOEwpuDE0fkMrVuocNeArmHJvdtT3rMdqqS6m02n
 7G9VwTmOi+iFCwtEEtGd5g+HURCZegAA3VRKonw6oNd9hCxrBsSdMb5WcJxoxnocI1jCs0
 LjVabEAzdNLrkARToj04UtE1/VO8+PN1epJRjYUcf3ArmuxMm5RJIT4Yt+xZbVBidK8PbN
 wwoA5U9URoTlQlh4RcNcswyv+srWLgMXTBQUhLL0uGD0WJmcf5qKks7Jma28s6ep1TiN8o
 gNaImo+biO3HSch2MzzB7c6Ah++9GMQjO7ZiFNRFf78KMv6sxke13FdjYxkStrg/08hDmz
 FHH2AYbXoHcDOr1MMoZJ8b5UcE2+kt7Dh2wInlBpKXQKjZrQUdfdQBMhXtO3YoTYC8xgvY
 KKINEzOsZSh49VWzaJecCc4qtKgN0ZKJWUUGlklCNHWxbSwzARkLkCR5M/7x5EFnw+m37o
 lu997ih6/t62mAWWFkgJGnKgXz/avw+MIC/MZ+07UihBcSpWJArejM097K2fhwFCqYeJ/N
 SnNPf6kVkac/DtqSKkcdhN3ZsXmj3JAzAr2Nh2H10C4KOBlGnMhvr4mBjg3QWKjGDD4vaF
 waeX67j7ac3tjsf9EajQpBLslWrSyrHBfO/Dmh2rmNZLTxGDtCkd0xAyVkCQ
X-ME-Proxy: <xmx:NjR_anx8nPV_i1MxzAiM0rNNHovZFAySx9Zd_IesEgsGrIZNkU8YGg>
 <xmx:NjR_ap12suOpRHhduf-3-gINcqyxZX9g8sNKnKtTy1sQp7_7ZDD3Ew>
 <xmx:NjR_at6caaH0Ium77K0AxXCgBmN1QzrLJVVo-_NgtIhfeMqb8sOimA>
 <xmx:NjR_akV00GqbHHJXZ25f1RuRaG7c-vYliRF5sQUGJGugtF4EdJ1u2g>
 <xmx:NjR_aiak4Qk7B4DS-38mf9vtb0J_1os2oZ5vakhi7TcMUMO-P27TToXw>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 11:28:54 -0400 (EDT)
Message-ID: <544d0aec6fc1edc1fd3d16f2f2adc659b9c57715.camel@alistair23.me>
Subject: Re: [PATCH v2 00/52] disas/riscv: Reorganize the disassembler
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com
Date: Sat, 15 Aug 2026 01:28:53 +1000
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.145;
 envelope-from=alistair@alistair23.me; helo=fout-a2-smtp.messagingengine.com
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

On Wed, 2026-08-12 at 15:30 -0700, Richard Henderson wrote:
> One of my pet peeves is the non-automatic addition of indexes to
> rv_op
> which must match entries in rvi_opcode_data[].
>=20
> Reorganize the disassembler to pass around pointers to individual
> opcodes
> rather than pointer to table + index.=C2=A0 To do that, rewrite how pseud=
o
> ops
> are processed, replacing indexes with pointers.=C2=A0 Merge the
> decompression
> of compressed opcodes into the pseudo ops mechanism.
>=20
> Fix quite a few bugs found in the process, mostly related to isa
> level.
>=20
> Changes for v2:
> =C2=A0 - Rebase on riscv-to-apply.next, which now contains Tiancheng's
> fixes.
> =C2=A0 - Adjust the DECOMP macro to make clang happy.
> =C2=A0 - new patch: "disas/riscv: Skip post-processing of illegal insns"
>=20
> The only unreviewed patch is the new one.
>=20
>=20
> r~
>=20
>=20
> Richard Henderson (52):
> =C2=A0 disas/riscv: Move operand extractors earlier in file
> =C2=A0 disas/riscv: Reduce rv_insn to uint32_t
> =C2=A0 disas/riscv: Tidy dec initialization in disasm_inst
> =C2=A0 disas/riscv: Pass rv_opcode_data pointer to decode_inst_operands
> =C2=A0 disas/riscv: Pass rv_opcode_data pointer to/from
> =C2=A0=C2=A0=C2=A0 decode_inst_decompress
> =C2=A0 disas/riscv: Pass rv_opcode_data pointer to/from
> =C2=A0=C2=A0=C2=A0 decode_inst_lift_pseudo
> =C2=A0 disas/riscv: Pass rv_opcode_data pointer to format_inst
> =C2=A0 disas/riscv: Tidy disasm_inst main loop
> =C2=A0 disas/riscv: Set dec->opcode_data in decode function
> =C2=A0 disas/riscv: Drop explicit zero of rv_opcode_data fields
> =C2=A0 disas/riscv: Drop useless const in structures
> =C2=A0 disas/riscv: Drop codec from rv_decode
> =C2=A0 disas/riscv: Handle c.addi4spn imm !=3D 0 during decode
> =C2=A0 disas/riscv: Simplify c.addi
> =C2=A0 disas/riscv: Handle c.lui imm !=3D 0 during decode
> =C2=A0 disas/riscv: Handle c.{srli,srai} imm during decode
> =C2=A0 disas/riscv: Handle c.slli imm !=3D 0 during decode
> =C2=A0 disas/riscv: Do not recognize c.{addw,subw} with rv32
> =C2=A0 disas/riscv: Remove rvcd_imm_nz
> =C2=A0 disas/riscv: Unify decomp_rv{32,64,128}
> =C2=A0 disas/riscv: Drop always true branch pseudos
> =C2=A0 disas/riscv: Handle aliases of csrrw during decode
> =C2=A0 disas/riscv: Handle aliases of csrrs during decode
> =C2=A0 disas/riscv: Handle aliases of csrrwi during decode
> =C2=A0 disas/riscv: Break pseudo loop for jal and jalr
> =C2=A0 disas/riscv: Allow decode_inst_lift_pseudo to loop
> =C2=A0 disas/riscv: Handle decompression via decode_inst_lift_pseudo
> =C2=A0 disas/riscv: Drop format from DECOMP insns
> =C2=A0 disas/riscv: Tidy rv_comp_data terminators
> =C2=A0 disas/riscv: Chain "ret" pseudo off "jr" pseudo
> =C2=A0 disas/riscv: Chain "nop" pseudo off "mv" pseudo
> =C2=A0 disas/riscv: Use rv_codec_illegal for pseudos
> =C2=A0 disas/riscv: Simplify some insn decompressions
> =C2=A0 disas/riscv: Store op pointer in rv_comp_data
> =C2=A0 disas/riscv: Return rv_opcode_data pointer from decoders
> =C2=A0 disas/riscv: Skip post-processing of illegal insns
> =C2=A0 disas/riscv: Reject all of OP-32 and OP-IMM-32 for RV32
> =C2=A0 disas/riscv: Fix rv32 encoding of zext.h
> =C2=A0 disas/riscv: Fix isa decoding of rev8
> =C2=A0 disas/riscv: Fix typo in th.lbib format
> =C2=A0 disas/riscv: Split ventana_opcode_data
> =C2=A0 disas/riscv: Split xlrbr_opcode_data
> =C2=A0 disas/riscv: Split xthead_opcode_data
> =C2=A0 disas/riscv: Move rv_op_illegal to riscv.c
> =C2=A0 disas/riscv: Split out riscv-op.c.inc
> =C2=A0 disas/riscv: Merge all mop.r.n to one pattern
> =C2=A0 disas/riscv: Merge all mop.rr.n to one pattern
> =C2=A0 disas/riscv: Merge all c.mop.n to one pattern
> =C2=A0 disas/riscv: Tidy decode of c.mop.n
> =C2=A0 disas/riscv: Tidy decode of mop.r.n and mop.rr.n
> =C2=A0 disas/riscv: Split rvi_opcode_data
> =C2=A0 disas/riscv: Sort riscv-op.c.inc

Thanks!

Applied to riscv-to-apply.next

Alistair

>=20
> =C2=A0disas/riscv-xlrbr.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 4 +-
> =C2=A0disas/riscv-xthead.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 24 +-
> =C2=A0disas/riscv-xventana.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0 4 +-
> =C2=A0disas/riscv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 46 +-
> =C2=A0disas/riscv-xlrbr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 57 +-
> =C2=A0disas/riscv-xthead.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 503 +--
> =C2=A0disas/riscv-xventana.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 23 +-
> =C2=A0disas/riscv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6390 +++++++++++--------------=
------
> --
> =C2=A0disas/riscv-op.c.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 913 +++++
> =C2=A0disas/riscv-xlrbr-op.c.inc=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 8 =
+
> =C2=A0disas/riscv-xthead-op.c.inc=C2=A0=C2=A0 |=C2=A0 125 +
> =C2=A0disas/riscv-xventana-op.c.inc |=C2=A0=C2=A0=C2=A0 2 +
> =C2=A012 files changed, 3411 insertions(+), 4688 deletions(-)
> =C2=A0create mode 100644 disas/riscv-op.c.inc
> =C2=A0create mode 100644 disas/riscv-xlrbr-op.c.inc
> =C2=A0create mode 100644 disas/riscv-xthead-op.c.inc
> =C2=A0create mode 100644 disas/riscv-xventana-op.c.inc

