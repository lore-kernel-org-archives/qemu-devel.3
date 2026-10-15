Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BF5CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 02:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHBgV-0008JS-55; Wed, 14 Oct 2026 22:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xHBgP-0008JB-JE
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 22:59:05 -0400
Received: from st-2004c-snip6-11.eps.apple.com ([2a01:b747:3001:201::1f]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xHBgL-0004w0-Qs
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 22:59:03 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-8 (Postfix) with ESMTPS id
 F31D418001AA; Thu, 15 Oct 2026 02:58:53 +0000 (UTC)
X-ICL-RepId: 01a13d7f-9506-7501-a56b-c3255c2982dc
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0BWFsIWwQPH0wMUQJCBVZeSgwdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkQPTQVYDigAXQlNdlgaXwUyAVULVHMtH0UJPQZdclNwNAlLBi1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792033135; x=1823569135;
 bh=lIvg6fI6B+ApLbnMAkf1UcIUGclGWlCEPPKyBUcfH5E=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=eRG/aLNxU2EG5H0HBdm5k9A5sSSMlz246GU3pxYo8DcF2eEtUwPwoqsgK0TAQd10p4j+ovliYG8I78P0qo6U4kNWVwy/lax1WoeEhklIyPHhd/mFif6VqGkT7vK9H2JJilO4W1HRwU9QvU+GVHHfLOWmqZ0PDG1FNXyhA0S7RNr8RJR8+2UCuWIvB2qEbS7jA1VoqZEDJaEKgKmH83fZGUOxtYmt7neuC3MSFp2HgSd8ulUxdPrRn0JSJl2cKayWpfQ9/fc/9HBZQ/Aoj4sbIInBX+q8l7mrClhAh/KI5vhYCxyCeOwqubBWSEVJ0TsJLQoSGlneXTAMchwWQ/d29A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-8 (Postfix) with ESMTPSA id
 6A8AD1800092; Thu, 15 Oct 2026 02:58:52 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 00/12] Hexagon: Add support for v83, v85
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 04:58:40 +0200
Cc: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <465659C2-05E5-47B8-89DF-50E50E8BD035@unpredictable.fr>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)
X-Authority-Info-Out: v=2.4 cv=BY7VE7t2 c=1 sm=1 tr=0 ts=6ad0416e
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=9iD3GqkVbZ9UQp4sfz8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAxMSBTYWx0ZWRfX/ahmjhcK3lMQ
 xRvg8QPzqNpHjppgwVeSOldQq4XihEsQiahrlzhAZ51dG+90Y1saHteK8L8JJf7J4OUYazYG54I
 Cq56f6OnvJU+o/a6SpQmcv3Nextgar/jm4sN2ZLqLi9tHCZUhCj8citS4ZGoSgZaNMPYuilccN+
 ijV6qQTtHYxNBzxe+tWQuWi5GosIxyjeJTD9lStihM2xJZFemwUuWhF8mxSlceKpcI6qUMTOuyp
 wDgMCn6HWzL3YityiiAG0zgUSmzYx4sK726IeYQZSr44rghKF3Dn8dQP5Syy9OFvpr5wO9B3RcQ
 2XR35p+UVgsQ8/RAZVJEO2zo6WA0JQysnr1RDJB+4E0BFzUVyhi/aXbS7uKzuA=
X-Proofpoint-ORIG-GUID: 4us76RNZ7MuQYY4DBitYlZCbteyaGlfJ
X-Proofpoint-GUID: 4us76RNZ7MuQYY4DBitYlZCbteyaGlfJ
X-JNJ: AAAAAAABVG4AyF+wFMwGhK0Hn+nqPSvkur/TLEXjjsX1IbCbnzdRN6MEb2bsfeEN+vFlHjItz85bb57WDSE2ofvNGFiv+QoPrwQ0nxBkkP+WAw3LCa1iT1tdj6yUuHOoo74/ejoCNf1+rfpjTnyLX849uSrxERRu+TgiDBO9juQXkxrLm17a9ey0pvU6hKAxaCduSTvXi6I0V4135r8h59nHSbm8XRS5NsIuRkSLvtlt9wI69BAZ8kHqbBr962l/wmT+ZX4Fpppo0sfzqx0Q8mIOnsimZ7ZA6Uj2GTQV+Krcs5Y8w6nsj/SONst8zfJkRp2saZOXp6jbCFQtNPi8+FD0Gvr1wrQ7FXVXQ+JTm9pQvAyu3wGJEF4XbLenUi64nFXASsEGmGsw7qie+3znz4eSbNRz75pF2+N5KoKHVcbuFI6SZM8dMsxFUwk0wmqHMXJegioG0GOtjnnOeiEARlXlyHYDm3mQgjWk28wArl7+7gPOBf9rCKeiWpJfWw1MkDmws8jZCL6FRc+PBNaLVIpEkFw/6Glemj6czy/x9irjDkLD1Y7KOd4Lir+UQMnC3DaCsKGtEGpJsup0Nuw1FMWcXawDMP6RJjs/Nyqt4Ndo7iV71f+oHeVYJn4ecH/C9+phrS48rCaNLhqLTQNl/iZ+rYazgsqvOA3/SrzysdMWUKAjS3eEhObnYFv40bR4YDsDoK2S1wHHduJ+d4naapUEh+hEdgeHnWyxsYAzdbETxQ6C7KRhaIsrI7QISboU7WtdpCVzSwS4PZgbKnjAOSV9xWRxYDM3mtJfpph0EO8mLJzUOPJ8xW9pWhjkGXqfC3ePconGpnponwJVKZ1q7B8WK8HPdDjg0M9PRq7oyIrRD/rMPMkvn8bFMsJC0zmvlM/7P6nak0IwXvFIsk/5Mzo1qlMK3O990+t85dkCx1U3KEL4YiL7SZlTI2FJRHmIdYRCD9IjXeniJp1gr1tv4/sITJonFuD
 YZ77MQA5mmG17ZSeXPuwxIN/1e+VDkliggcZvyRHxv1xaVYPnzmJSbzcYCWJC6JrjFkfW3c/mwkJuQCDHMt77fMOmVu8B6U33pnxClWNwudRj0BSifjAFoU911xJ2sub3l91dy0D5gE5tWNzlyEPPMZQvjnZ61kxTbgI8w9j9TFx0raQXMskK8T6HqyF4Y1lrlLRMIBt5n1a+E39+j4khyC9LpR9Vmk4+wDiUL1lRh3S6Q1nDJ9iqD0mImlF8oSOdhaqbFLOWlDLcu0/TBt9usP/pZEFAI3Ql048eAd9qhUQEv4oYUtKdDEHkCrhOkrom8jQ7bSoq+0GEYdynKpc7bdC8ltuI5NqYpxcmTGQOD9L/K0iP4Nv7stTbllK+LmCXQ9xpZWoBMVQ4T4ZTSD3NRqYVwv7hFOch2avAqec5A2ro/M6mSz7XfrVe5cieCX6UOwc0SNXngxnwvDdObXHps1F3I1SwqWMwgYg=
Received-SPF: pass client-ip=2a01:b747:3001:201::1f;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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



> On 14. Oct 2026, at 21:52, Brian Cain <brian.cain@oss.qualcomm.com> =
wrote:
>=20
> v83 and v85 introduce new ISA extensions:
> - CFI/restricted branches
> - scalar atomic operations

Hi,

Probably not possible to emulate nicely but the TRM for those says:

> V85 ERRATA: Atomicity may be lost if a competing instruction is not an =
atomic. To guarantee atomicity, only atomic instructions should be used =
for the memory location

Given that is it expected to be used on v85? Or is it a footgun best =
unexposed for that generation?

Would also note that the user-mode DMA spec is still behind the NDA =
wall, which
makes no sense whatsoever when everybody on the platform is using it =
anyway...

=20
> - scalar float operations
> - trap2 instruction
> - vector stack, used by HLX
>=20
> The HLX vector coprocessor, also introduced by these new revisions, is
> not included in this series.
>=20
> The cross-toolchain doesn't yet support these opcodes.  So in our =
tests,
> we've manually encoded the instructions using ".word" directives and =
we
> invoke the tests with the explicit '-cpu'.  The directives will be =
replaced
> with the mnemonics and explicit '-cpu' removed once the assembler has =
the
> necessary support.  I expect LLVM 24.x will include these =
instructions.
>=20
> Brian Cain (12):
>  target/hexagon: sort tag_rev_info entries by version
>  Hexagon: add v85 CPU model
>  hw/hexagon: add v85 machines
>  linux-user/hexagon: report ISA HWCAP through v85
>  target/hexagon: add v85 scalar atomics
>  target/hexagon: add v83 trap2 and vector stack instructions
>  target/hexagon: generate vector frame instructions with IDEF parser
>  target/hexagon: reject reserved L4_loadw_phys encoding from v83
>  target/hexagon: preserve callr target when Rs is LR
>  target/hexagon: implement control flow integrity (CFI)
>  target/hexagon: add vsf* instructions
>  tests/tcg/hexagon: add v85 scalar tests
>=20
> docs/system/hexagon/emulation.rst           |   2 +-
> include/hw/hexagon/hexagon.h                |   6 +-
> linux-user/hexagon/target_elf.h             |   2 +
> target/hexagon/cpu-qom.h                    |   4 +
> target/hexagon/cpu.h                        |   3 +
> target/hexagon/cpu_bits.h                   |   2 +
> target/hexagon/gen_tcg.h                    |  93 +++++++++++-
> target/hexagon/gen_tcg_sys.h                |   6 +
> target/hexagon/genptr.h                     |  12 ++
> target/hexagon/helper.h                     |   5 +
> target/hexagon/hex_regs.h                   |   2 +
> target/hexagon/idef-parser/parser-helpers.h |   1 +
> target/hexagon/macros.h                     |  12 ++
> target/hexagon/translate.h                  |   4 +
> tests/tcg/hexagon/cfi_tgts.h                |  16 ++
> hw/hexagon/machine_cfg_v85na_1.h.inc        |  50 +++++++
> hw/hexagon/machine_cfg_v85qa_1.h.inc        |  51 +++++++
> target/hexagon/attribs_def.h.inc            |   2 +
> target/hexagon/reg_fields_def.h.inc         |   1 +
> hw/hexagon/hexagon_dsp.c                    |  48 +++++-
> linux-user/hexagon/cpu_loop.c               |  10 ++
> linux-user/hexagon/elfload.c                |  10 ++
> target/hexagon/cpu.c                        |  10 +-
> target/hexagon/decode.c                     |   5 +
> target/hexagon/genptr.c                     |  95 +++++++++++-
> target/hexagon/hex_interrupts.c             |   3 +
> target/hexagon/hexswi.c                     |  16 ++
> target/hexagon/idef-parser/parser-helpers.c |  14 ++
> target/hexagon/machine.c                    |   3 +-
> target/hexagon/op_helper.c                  |  73 +++++++++
> target/hexagon/translate.c                  |  53 ++++++-
> tests/tcg/hexagon/atomics.c                 | 102 +++++++++++++
> tests/tcg/hexagon/cfi_user.c                |  63 ++++++++
> tests/tcg/hexagon/check_rev_gating.c        |  10 ++
> tests/tcg/hexagon/invalid-encoding.c        |  20 +++
> tests/tcg/hexagon/trap2.c                   |  34 +++++
> tests/tcg/hexagon/v83_scalar_fp.c           |  98 ++++++++++++
> tests/tcg/hexagon/vallocframe.c             | 111 ++++++++++++++
> target/hexagon/tag_rev_info.c.inc           |  82 ++++++++--
> target/hexagon/gen_idef_parser_funcs.py     |   4 +-
> target/hexagon/idef-parser/idef-parser.lex  |   8 +
> target/hexagon/idef-parser/idef-parser.y    |   9 +-
> target/hexagon/imported/alu.idef            |   3 +
> target/hexagon/imported/branch.idef         |  38 +++++
> target/hexagon/imported/encode_pp.def       |  43 +++++-
> target/hexagon/imported/encode_subinsn.def  |   1 +
> target/hexagon/imported/float.idef          |  49 ++++++
> target/hexagon/imported/ldst.idef           |  15 ++
> target/hexagon/imported/macros.def          |  10 ++
> target/hexagon/imported/subinsns.idef       |   2 +
> target/hexagon/imported/system.idef         |   9 ++
> tests/tcg/hexagon/cfi_tgts.S                | 157 ++++++++++++++++++++
> tests/tcg/hexagon/meson.build               |  19 ++-
> 53 files changed, 1470 insertions(+), 31 deletions(-)
> create mode 100644 tests/tcg/hexagon/cfi_tgts.h
> create mode 100644 hw/hexagon/machine_cfg_v85na_1.h.inc
> create mode 100644 hw/hexagon/machine_cfg_v85qa_1.h.inc
> create mode 100644 tests/tcg/hexagon/cfi_user.c
> create mode 100644 tests/tcg/hexagon/trap2.c
> create mode 100644 tests/tcg/hexagon/v83_scalar_fp.c
> create mode 100644 tests/tcg/hexagon/vallocframe.c
> create mode 100644 tests/tcg/hexagon/cfi_tgts.S
>=20
> --=20
> 2.34.1
>=20


