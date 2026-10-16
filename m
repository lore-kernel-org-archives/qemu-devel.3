Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE23CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkK8-0008DR-Jq; Fri, 16 Oct 2026 11:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHkK7-0008Cs-9P
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:58:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHkK5-0008WF-45
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:58:23 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE69af2455449
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 15:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kYHjjDS1CtGPdN0Lw4Rsn5yAuj4FyHr9gH81uLUyfEI=; b=na4Agi+9yyNxzCL4
 UUYvPKm3/+/+29nXhfGXxh2oGxDW4f/9PeLS2Qd997MnrPiCte4oE1nGNZa5ad8s
 bkpMaahxDEpKzpQNfUs/g50hhtnxMIA9TYUOs6E2eyf/XvRedAOS3pI4IWjflBj7
 1VASzctkXuHbhHjsnTckqSugqn60es4v8ZYNNN9PKdnNjhQWZ0tSvP7Z7xmn8oCc
 6r5r7/A2FmejBlPvWG99/8wBqVpqga1NE6qcr+qocXP82PjAsA1IA8oYKRUagoGq
 gbspKOxlhct9gm5/xyGTHT+IMXoKt+YgLhe14R6DxcUrwoAu8W19XdlAKyPvOmcv
 pourQQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbg5ysr87-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 15:58:19 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-83043b8a01fso10555192a34.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 08:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792166299; cv=none;
 d=google.com; s=arc-20260327;
 b=rrmaBTlKZ3wkSmfRRbRuT/ZauFC/WNIXtVgu8oZit8E74i//T8uSMPGpI/2e7Cl0A6
 n8ySsvh7DIS0Zjs4BoOQqF6ZBmLXLAX1fjlO6S4jPBlH8XRc7ULsmfgHklpVkwWpsYyK
 5tZvj4shbj3oIWgvJmEZDs/jlO+C8xmIvnm1zFYq4f0fF2oO3fh8euWswmbD0zmHb+MH
 fVWv6wfTuFSt1WfeS6QhlhT4r3yghCtjXyj7EnYjSIipbILv5nZ0yrQYUR5LESz2TvJe
 3DgOSrDZwrq94vHplna0OyzedlRVzW6z6Bo+9+fxInsqdJOieDGNp30rG4QhqvX81Uf0
 wILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kYHjjDS1CtGPdN0Lw4Rsn5yAuj4FyHr9gH81uLUyfEI=;
 fh=BDwCUQnyOohCW2T3saAEoDn+gM7VDetp6cmJKplLvtM=;
 b=V+ZCNXygGuj60LsTx4F4Mtv96IIxV4cBE42o2fsK+3Z1smv0+4WJ5U9dlNgi+k+I0P
 R4c2vlOVZapj96t1Vla/qdZB4FDdc7cD1j84rRudqMlPAwEAMOVjalJ83J5CnRM96I7H
 npfe0pSXb/vbSdcFm8/+Z6OJgDkV84zn+hrwXRGw8DdWXX0ytmgRYA1B0RqeIfMtVVjI
 YCRtvXkOFfc6VrTgN6nGJn1mvtNTFhd0+O0Gxv6Ok/0NU9+pNV+a3FYxl3RZeTc3PMat
 zRzvR0HPkJGfdIhUV8YG4zO39dX8RAMNgDMENvdCofQDhrwvapAx2Td6JCCi5vgSH8cB
 ZKvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792166299; x=1792771099; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kYHjjDS1CtGPdN0Lw4Rsn5yAuj4FyHr9gH81uLUyfEI=;
 b=Qr+LOMg+WWVHx01GTUbJBjg/exQmB3OQhMRdOg3moTlzwwq/cmoF5Po81BAk52/AuC
 Mx/NJl987BUF23D/Ty8yqTJ0CLgYmIxEfhmYdUSpUPFAdT5fdA5Rx4EELWjzxSA1yxHX
 aSOJfO88eDxA7KwIuYkIxvIwIDFrhaOFpIP7UDnbgRtFQGeDC/KwKg5ZK5e0PSQP/Qtj
 qvjzsPz6WMNPQuXIN6qd8d6s81254n6n0oDtrhBzAoR1zsi4No0pCueOqbdrpvEPrLyV
 FjrItxlnwbk8svsK1kvq8L2JL/dHhK05yeaAfI+U5qG6jvPQJyQF6pHQLI2/VAfyVv2r
 IdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792166299; x=1792771099;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kYHjjDS1CtGPdN0Lw4Rsn5yAuj4FyHr9gH81uLUyfEI=;
 b=FObLuegqKMGasgmXrdUJ1DMr6Z5pifRhhB56mhn/khG6de8P/O0cvPRMeefUBqHxoY
 OxXd/W+vNyQn7TyDUlwzqDlaLdOamaB7scfTwg39OKCObqnMYtC7EnXU0Tmt76S3g76R
 SjvhmyUr+ak0W/nwJ0XeaVq1rLSVHZEvL8Bi5aSI/BIymBICfcxmJXdpKwrNhTmIcAyH
 4QV5JBiBe/WekQXpe5UMuqy8lziEj6LB8HyS1rOEi6glDXYasinjf6s7F28SjQJio6bo
 0jg81Jm41J9NOr8W3rMLGk2bteyVtTWYr5rfWIxV+vmLlqJ+P/ML4Am7DxCSs5DqE1St
 Pj9w==
X-Gm-Message-State: AFq9FYKPSiafIncCn+LoMc9ZRM5iiFNYvKCNm6s/udHeoRt5ZLEWEX75
 9JKR8pbqsYXfn0NaJT3hGVQDD77gktWizlAE6wPITpqMI8QtZYE0Ep+s9K4YXBVzo5QB4b9+d19
 tqJD1LXJV8d77kgOLqrKbVpc5FPwXTEwtPigx6c0kub6KzNW0hsnRJaqjYyeEqgKAvonblPviZu
 TqzaZdlKB/04XeslShGvDkxeoc8XHBd2sj
X-Gm-Gg: AYBFou3hGL4ckte0IA8/Il0Cggbtq6Kk0tGvt7Dy6g3Fjj5HbQx76zKa69beARbKrHU
 uRCbb1gE/tFwTrvGNqD+XmefmLVBUS8cnnXgE4OVRIHzs7RMvIWi8nGpOymmMracSUIImUFBUzI
 oyGn4JFsRJlBvLHiZQoYSzRDIJrWU3ci9C/PyHxhZ2oAE8vT6uDXFeutt/RCi2ySwLijyFTzVQI
 jcwGNuRip6ADbD3oXk=
X-Received: by 2002:a05:6808:6b8a:b0:4d6:90f4:48ab with SMTP id
 5614622812f47-53ccfba424emr39199b6e.45.1792166298680; 
 Fri, 16 Oct 2026 08:58:18 -0700 (PDT)
X-Received: by 2002:a05:6808:6b8a:b0:4d6:90f4:48ab with SMTP id
 5614622812f47-53ccfba424emr39179b6e.45.1792166298026; Fri, 16 Oct 2026
 08:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 10:58:06 -0500
X-Gm-Features: AclHuK9LTh7cNhig5g7hP0w1dw1WMLPeRDj28tAJVDDmREDR9wwO_xr7uEsSiyQ
Message-ID: <CAJ+KCYOhsLckWC0sazhOx=Tf21pEYesasuE=tutjrK6fXCUnSg@mail.gmail.com>
Subject: Re: [PATCH 00/12] Hexagon: Add support for v83, v85
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: irwBAw7vjjzDMgraHa167MIm0VT07O7n
X-Authority-Analysis: v=2.4 cv=M+HYuCws c=1 sm=1 tr=0 ts=6ad2499b cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=c9aC0V95KU61Ie_0dx0A:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2MyBTYWx0ZWRfXwWbkL7c1vTs/
 GP2cT4J364ctMI8BCWWcFFUijFqFW5CBXmYGWB9ync7YqZ7IaxGWQ5ncav5WAMKe9y4ZzZwsYqr
 oFjmdZx5Hhyz8JRMqSV1cmTiA8w/znY=
X-Proofpoint-GUID: irwBAw7vjjzDMgraHa167MIm0VT07O7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2MyBTYWx0ZWRfX1aSq2Kz2LJck
 8q/Wiak0ATZQaouoU23mYwEbqIi/KjgpGmHbT4ifTxTFkVskssnB3KfPE0rwoRGS13NO4LP0W/I
 8Bu0iWsyZiZh7qjQBvVreQSiXyfOWrXjYOm3MpruEqXo12LbZjmZh4EbbJywwUqjlC/d/zPXrDP
 sxaj4MIyd4gjW95zkxTfqWhbiQB/39FRsHomWAUxkKvPR24Xy8Rj+rDN4vlbW15dBmrAJNSJFUw
 PwOEo931ytwBClmm+QNvIYoKqAfmiC0nlv8d55E1uDCC1xdq84bYypDURWREYbAY0/L54bVJD7a
 5X8NP2+bJkVgQe4pPfQT6H5IseRJvwoH62A0KzZ4ODeMQDN+V72rjlqoYkfxjuvbkdVIhN2iyK+
 WhLAkBVt+EumhZTgYNB4loPFF2scEaNd1+W+dvyERTzk7EAUdvTJiW/MgjkqLKBuLOJgGOUpjsu
 6Nb32Rx3gEtKD1g/KAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Wed, Oct 14, 2026 at 2:52=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> v83 and v85 introduce new ISA extensions:
> - CFI/restricted branches
> - scalar atomic operations
> - scalar float operations
> - trap2 instruction
> - vector stack, used by HLX
>
> The HLX vector coprocessor, also introduced by these new revisions, is
> not included in this series.
>
> The cross-toolchain doesn't yet support these opcodes.  So in our tests,
> we've manually encoded the instructions using ".word" directives and we
> invoke the tests with the explicit '-cpu'.  The directives will be replac=
ed
> with the mnemonics and explicit '-cpu' removed once the assembler has the
> necessary support.  I expect LLVM 24.x will include these instructions.
>
> Brian Cain (12):
>   target/hexagon: sort tag_rev_info entries by version
>   Hexagon: add v85 CPU model
>   hw/hexagon: add v85 machines
>   linux-user/hexagon: report ISA HWCAP through v85
>   target/hexagon: add v85 scalar atomics
>   target/hexagon: add v83 trap2 and vector stack instructions
>   target/hexagon: generate vector frame instructions with IDEF parser
>   target/hexagon: reject reserved L4_loadw_phys encoding from v83
>   target/hexagon: preserve callr target when Rs is LR
>   target/hexagon: implement control flow integrity (CFI)
>   target/hexagon: add vsf* instructions
>   tests/tcg/hexagon: add v85 scalar tests
>
>  docs/system/hexagon/emulation.rst           |   2 +-
>  include/hw/hexagon/hexagon.h                |   6 +-
>  linux-user/hexagon/target_elf.h             |   2 +
>  target/hexagon/cpu-qom.h                    |   4 +
>  target/hexagon/cpu.h                        |   3 +
>  target/hexagon/cpu_bits.h                   |   2 +
>  target/hexagon/gen_tcg.h                    |  93 +++++++++++-
>  target/hexagon/gen_tcg_sys.h                |   6 +
>  target/hexagon/genptr.h                     |  12 ++
>  target/hexagon/helper.h                     |   5 +
>  target/hexagon/hex_regs.h                   |   2 +
>  target/hexagon/idef-parser/parser-helpers.h |   1 +
>  target/hexagon/macros.h                     |  12 ++
>  target/hexagon/translate.h                  |   4 +
>  tests/tcg/hexagon/cfi_tgts.h                |  16 ++
>  hw/hexagon/machine_cfg_v85na_1.h.inc        |  50 +++++++
>  hw/hexagon/machine_cfg_v85qa_1.h.inc        |  51 +++++++
>  target/hexagon/attribs_def.h.inc            |   2 +
>  target/hexagon/reg_fields_def.h.inc         |   1 +
>  hw/hexagon/hexagon_dsp.c                    |  48 +++++-
>  linux-user/hexagon/cpu_loop.c               |  10 ++
>  linux-user/hexagon/elfload.c                |  10 ++
>  target/hexagon/cpu.c                        |  10 +-
>  target/hexagon/decode.c                     |   5 +
>  target/hexagon/genptr.c                     |  95 +++++++++++-
>  target/hexagon/hex_interrupts.c             |   3 +
>  target/hexagon/hexswi.c                     |  16 ++
>  target/hexagon/idef-parser/parser-helpers.c |  14 ++
>  target/hexagon/machine.c                    |   3 +-
>  target/hexagon/op_helper.c                  |  73 +++++++++
>  target/hexagon/translate.c                  |  53 ++++++-
>  tests/tcg/hexagon/atomics.c                 | 102 +++++++++++++
>  tests/tcg/hexagon/cfi_user.c                |  63 ++++++++
>  tests/tcg/hexagon/check_rev_gating.c        |  10 ++
>  tests/tcg/hexagon/invalid-encoding.c        |  20 +++
>  tests/tcg/hexagon/trap2.c                   |  34 +++++
>  tests/tcg/hexagon/v83_scalar_fp.c           |  98 ++++++++++++
>  tests/tcg/hexagon/vallocframe.c             | 111 ++++++++++++++
>  target/hexagon/tag_rev_info.c.inc           |  82 ++++++++--
>  target/hexagon/gen_idef_parser_funcs.py     |   4 +-
>  target/hexagon/idef-parser/idef-parser.lex  |   8 +
>  target/hexagon/idef-parser/idef-parser.y    |   9 +-
>  target/hexagon/imported/alu.idef            |   3 +
>  target/hexagon/imported/branch.idef         |  38 +++++
>  target/hexagon/imported/encode_pp.def       |  43 +++++-
>  target/hexagon/imported/encode_subinsn.def  |   1 +
>  target/hexagon/imported/float.idef          |  49 ++++++
>  target/hexagon/imported/ldst.idef           |  15 ++
>  target/hexagon/imported/macros.def          |  10 ++
>  target/hexagon/imported/subinsns.idef       |   2 +
>  target/hexagon/imported/system.idef         |   9 ++
>  tests/tcg/hexagon/cfi_tgts.S                | 157 ++++++++++++++++++++
>  tests/tcg/hexagon/meson.build               |  19 ++-
>  53 files changed, 1470 insertions(+), 31 deletions(-)
>  create mode 100644 tests/tcg/hexagon/cfi_tgts.h
>  create mode 100644 hw/hexagon/machine_cfg_v85na_1.h.inc
>  create mode 100644 hw/hexagon/machine_cfg_v85qa_1.h.inc
>  create mode 100644 tests/tcg/hexagon/cfi_user.c
>  create mode 100644 tests/tcg/hexagon/trap2.c
>  create mode 100644 tests/tcg/hexagon/v83_scalar_fp.c
>  create mode 100644 tests/tcg/hexagon/vallocframe.c
>  create mode 100644 tests/tcg/hexagon/cfi_tgts.S
>
> --
> 2.34.1
>

General notes:

1. The series does not bisect (Patches 5-9):
A_RESTRICT_TARGET is undeclared. Patch 5 adds
S2_allocframe_rb to ldst.idef, but the attribute comes in patch 10.
Moving those two lines to patch 10 fixes it.

2. The no idef parser build is broken after commit 7 (Patches 7-12):
patch 7 drops the fGEN_TCG_V2_v{,de}allocframe_* overrides, and
patch 10 adds S2/SS2_allocframe_rb without overrides. Should we
keep the ones in commit 7 and add some for the additions in commit 10?

