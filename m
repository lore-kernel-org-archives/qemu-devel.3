Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED71EF417E0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbua-0000qM-LE; Mon, 09 Mar 2026 10:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuM-0000p4-KU
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuK-0005D5-LC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:34 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629EAWOZ1249054
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=+hzBbUhw5RW
 srJb8/VqVO5CpfIJ2x9S79N1d8maJfcw=; b=OPa004NkOaaA+LQriBXnDmsH+9I
 cOX2yHd/3TM5bHWyNnlOtUKc8G5H61ttGQ1KMBETzKAWVzYiXl/Q74pbTFKjetwl
 usSpkr/ji5vEX+g6cXQKBkoLgLyZrmhIIAC3oYa0esEhBPtDF3NiEjiz1wjbqnKx
 XgWKooekQVGaJFoujb7366zPTTTueWsG0da7G2/C+Xc3IPdaP+bSLzN45b7f9F7d
 La40C4Vq8bPjA9//eTzdkxp9pMElOoWDXy9+N7I34H7aVVeodbd13Kq1EW1GOwYf
 Jpk67/1+bAjsVXh7EIclY/eNEKRTQ5kwSTCmF4WLVgAlB7KpZdYarMQ+mtA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyr403rv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:29 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2be47f2899aso47126855eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067708; x=1773672508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+hzBbUhw5RWsrJb8/VqVO5CpfIJ2x9S79N1d8maJfcw=;
 b=MuGC3f3oD6qk1DYT3FtpujQnCS8HQLU+sKXqhZiFcVwV2hA+4fOluWG4LNjY+6b46q
 coiVOeMWWdxftluilNcdavUb9ikkUzX4dDZweEdclPsLpNVAwoIaUJE2X7ThipQISDsm
 /U7qJ4nxZSUx3kGwtxTzXTJQYcFbStD7rIZXnG+pYDcXHCOd2K82Cp0JMlQ03GokzN89
 HPyl4P07JFrSmdX/iPUrgB/8u7eHVdZjZnpSguGbFmwlzedNRzbQEQ7NobUOHhGg8UjN
 9YRO8BbpUd+Uuthh0BFq7jlJnaWShPI2Cl+0ZBz8SC4zgcARdo6qHnWRUFHlAuVO6zqd
 F6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067708; x=1773672508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+hzBbUhw5RWsrJb8/VqVO5CpfIJ2x9S79N1d8maJfcw=;
 b=XKTugOBqhfFTqcksRGD+7hpN+oz5mAIOGlwup4kdQ85MiPKOphFCtEopZ+fAmtz09u
 izUds1TbRguw/kOXyWGhJ9QgpAis59fk9vMr9itwh2eDKnDFOug46e0xVqH/U4y8VzgX
 tNyGO2zkJT8JrhyRNhpKr4pLNSIuoAnhRDUjmC0IN37R5Y4bKgSF7DNsbLCPrLQRDSWq
 5YYLq6vvyf47rcoW7Pf7MrZ2k04zZ+1CdRc/pX8WpzcddxGyEYWIM6/BrGgPSUsImg5v
 CrNHYdvV3iuBkj3kvex/SdpUA/ugqfbF83d4Jc40F+/BR0nsZb84Pda6BlzbMuHuMYHN
 DK+g==
X-Gm-Message-State: AOJu0YwCSsoGYgU6Hth+sqAXpUdzD139WFg8oooqcUx+mQe4Xn441jdi
 VeOSq7Z3QE5rd46ICaLLiVePqjzNKEf+zWCIDYLZFp+4pxJSFcexG95IwJF3aA8X5yxHTcDajqt
 mWz/DYbioSVljsNGo4U15SHMsqmZppT0Jh1z0xxFxfDCpYJ+hTg+QIOO2daJX+Isi7A==
X-Gm-Gg: ATEYQzz94ACenupnqs3XTt1Y16twV03HESlK9Gw1I6wn7I4tasHDVMV7oPJCP8UTatn
 I8qvQI73klepNTZEMWc72vDTMTQD+Zyd5cmaq2uJ4Hyu6DmubxhWvWZn8WambdVsZ3Zqn4k8v66
 Cd25aSCFZvjJOCTKuzu9NZ/QzGiJRKlNta8HdlyRVZfv2UGlOmWlga3zJwhlQbmd/w+K8vXNIcM
 CKy/loEkKElBqA/aUxOXDNEmLDAGtNlcdg70XtMt3ZkECqfCFvaT52gu9oDQIchGIPp5ZgZMhF5
 cuQkwELlBCjVnRd6UVI9ydlghFbzL+V3IyMMjb4Ps1nCOnfpB6RklEqyreaRaLvuPv6dro7WezG
 Col8GCQJ9gGfLsXVdrfKK0l5TstiwYtcR8+sM8rhsTPPj1+1FpBGyk8CtzCCZCsabrVadww==
X-Received: by 2002:a05:7301:1008:b0:2ba:7b0b:e205 with SMTP id
 5a478bee46e88-2be4e03b3d5mr4348972eec.20.1773067707630; 
 Mon, 09 Mar 2026 07:48:27 -0700 (PDT)
X-Received: by 2002:a05:7301:1008:b0:2ba:7b0b:e205 with SMTP id
 5a478bee46e88-2be4e03b3d5mr4348939eec.20.1773067706951; 
 Mon, 09 Mar 2026 07:48:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v4 00/35] Hexagon system emulation - Part 1/3
Date: Mon,  9 Mar 2026 07:47:47 -0700
Message-Id: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfXzoIhZhabSLvk
 sZrmYvm2txmhYfK23UUtl2WzAM8hi3CCQ2jqlYJrP8MS1yd2WIraMA7CQRjEoiBe3Ct1cLk9jEj
 hklrS9Bx3SEv2hJu5SkDnOtkhe5M40OqX5tHcV/wFWpnzIL8OZ7tyCO6IlDwpQ8eN+we9TL7Juf
 tojIwGcugAiMilcVpND9bhgOQLj4d5UnCbcDvOU2un3eNUZWvpjBQ12a/BAL+whuZ4TAVcTsQru
 2X/Dss1BRIfSj6cM65dB+CPAhfqowTJ9yUSsftJXgF68zB6u5c47J5OKvwo3gfCplumK7MXqrPC
 xTj4VhSJfHhpuzs8O5VwHq6LzFKDFjeS1ERRMDap9TMhq5I3aTqh/hnrW1gmQXLd/HajcCWke+b
 YvubpS8oyRkRevfYSdhc7afrTox87KoVKinXzM/AiD1sfD/NRqx51GVVuzkcmkES/oC+MIcvcuD
 r7UKAANqXfjX8cDzX8w==
X-Proofpoint-GUID: 90UNrX0h3e0BigmkVT9ZS6sPcCouru0Y
X-Proofpoint-ORIG-GUID: 90UNrX0h3e0BigmkVT9ZS6sPcCouru0Y
X-Authority-Analysis: v=2.4 cv=KNRXzVFo c=1 sm=1 tr=0 ts=69aeddbd cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4azlsQMGSF3UK1F-O_AA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is Part 1 of the hexagon system emulation (sysemu) patch series,
providing the foundational target infrastructure needed for full-system
emulation of the Qualcomm Hexagon DSP.

Changes since v3:
  - Folded "Add system event, cause codes" into "Add privilege check,
    use tag_ignore()" so the definitions and their first consumer are
    introduced together
  - Folded "Add a TLB count property" and "Add {TLB,k0}lock, cause
    code, wait_next_pc" into nearby patches to reduce small standalone
    commits
  - Split the TLB QOM device (hexagon_tlb.[ch]) out of "Add stubs for
    modify_ssr/get_exe_mode" into its own patch ("hw/hexagon: Introduce
    hexagon TLB device")
  - Broke "Suppress unused-variable warnings for sysemu source regs"
    out to its own commit

Previous versions:
  v3: https://lore.kernel.org/qemu-devel/20260227203627.932864-1-brian.cain@oss.qualcomm.com/
  v2: https://lore.kernel.org/qemu-devel/20250902034715.1947718-1-brian.cain@oss.qualcomm.com/
  v1: https://lore.kernel.org/qemu-devel/20250301052628.1011210-1-brian.cain@oss.qualcomm.com/

Brian Cain (35):
  docs: Add hexagon sysemu docs
  docs/system: Add hexagon CPU emulation
  target/hexagon: Fix badva reference, delete CAUSE
  target/hexagon: Add missing A_CALL attr, hintjumpr to multi_cof
  target/hexagon: Handle system/guest registers in gen_analyze_funcs.py
    and hex_common.py
  target/hexagon: Suppress unused-variable warnings for sysemu source
    regs
  target/hexagon: Make gen_exception_end_tb non-static
  target/hexagon: Switch to tag_ignore(), generate via
    get_{user,sys}_tags()
  target/hexagon: Add privilege check, use tag_ignore()
  target/hexagon: Add a placeholder fp exception
  target/hexagon: Add guest, system reg number defs
  target/hexagon: Add guest, system reg number state
  target/hexagon: Add TCG values for sreg, greg
  target/hexagon: Add guest/sys reg writes to DisasContext
  target/hexagon: Add imported macro, attr defs for sysemu
  target/hexagon: Add new macro definitions for sysemu
  target/hexagon: Add handlers for guest/sysreg r/w
  target/hexagon: Add placeholder greg/sreg r/w helpers
  target/hexagon: Add vmstate representation
  target/hexagon: Make A_PRIV, "J2_trap*" insts need_env()
  target/hexagon: Define register fields for system regs
  target/hexagon: Implement do_raise_exception()
  target/hexagon: Add system reg insns
  target/hexagon: Add sysemu TCG overrides
  target/hexagon: Add implicit attributes to sysemu macros
  target/hexagon: Add TCG overrides for int handler insts
  target/hexagon: Add TCG overrides for thread ctl
  target/hexagon: Add TCG overrides for rte, nmi
  target/hexagon: Add sreg_{read,write} helpers
  target/hexagon: Add locks, id, next_PC to state
  hw/hexagon: Introduce hexagon TLB device
  target/hexagon: Add stubs for modify_ssr/get_exe_mode
  target/hexagon: Add clear_wait_mode() definition
  target/hexagon: Define f{S,G}ET_FIELD macros
  target/hexagon: Add hex_interrupts support

 MAINTAINERS                             |   3 +
 docs/devel/hexagon-sys.rst              | 112 ++++++
 docs/devel/index-internals.rst          |   1 +
 docs/system/hexagon/cdsp.rst            |  12 +
 docs/system/hexagon/emulation.rst       |  15 +
 docs/system/target-hexagon.rst          | 103 +++++
 docs/system/targets.rst                 |   1 +
 include/hw/hexagon/hexagon_tlb.h        |  45 +++
 target/hexagon/cpu-param.h              |   4 +
 target/hexagon/cpu.h                    |  73 +++-
 target/hexagon/cpu_bits.h               |  75 +++-
 target/hexagon/cpu_helper.h             |  21 ++
 target/hexagon/gen_tcg.h                |   9 +
 target/hexagon/gen_tcg_sys.h            | 102 +++++
 target/hexagon/helper.h                 |  22 ++
 target/hexagon/hex_interrupts.h         |  15 +
 target/hexagon/hex_mmu.h                |  25 ++
 target/hexagon/hex_regs.h               | 117 ++++++
 target/hexagon/internal.h               |  18 +
 target/hexagon/macros.h                 |  35 +-
 target/hexagon/sys_macros.h             | 237 ++++++++++++
 target/hexagon/translate.h              |  43 +++
 target/hexagon/attribs_def.h.inc        |  49 ++-
 target/hexagon/reg_fields_def.h.inc     |  96 +++++
 hw/hexagon/hexagon_tlb.c                | 463 +++++++++++++++++++++++
 linux-user/hexagon/cpu_loop.c           |  16 +
 target/hexagon/arch.c                   |   5 +
 target/hexagon/cpu.c                    |  57 ++-
 target/hexagon/cpu_helper.c             |  85 +++++
 target/hexagon/genptr.c                 | 151 ++++++++
 target/hexagon/hex_interrupts.c         | 375 ++++++++++++++++++
 target/hexagon/hex_mmu.c                | 277 ++++++++++++++
 target/hexagon/machine.c                |  32 ++
 target/hexagon/op_helper.c              | 141 ++++++-
 target/hexagon/translate.c              |  30 +-
 target/hexagon/gen_analyze_funcs.py     |  14 +-
 target/hexagon/gen_helper_funcs.py      |  26 +-
 target/hexagon/gen_helper_protos.py     |  23 +-
 target/hexagon/gen_idef_parser_funcs.py |   2 +
 target/hexagon/gen_op_attribs.py        |   2 +-
 target/hexagon/gen_opcodes_def.py       |   5 +-
 target/hexagon/gen_tcg_funcs.py         |  35 +-
 target/hexagon/hex_common.py            | 173 ++++++++-
 target/hexagon/imported/encode_pp.def   | 128 ++++++-
 target/hexagon/imported/macros.def      | 482 +++++++++++++++++++++++-
 target/hexagon/imported/system.idef     | 244 +++++++++++-
 target/hexagon/meson.build              |  13 +-
 47 files changed, 3902 insertions(+), 110 deletions(-)
 create mode 100644 docs/devel/hexagon-sys.rst
 create mode 100644 docs/system/hexagon/cdsp.rst
 create mode 100644 docs/system/hexagon/emulation.rst
 create mode 100644 docs/system/target-hexagon.rst
 create mode 100644 include/hw/hexagon/hexagon_tlb.h
 create mode 100644 target/hexagon/cpu_helper.h
 create mode 100644 target/hexagon/gen_tcg_sys.h
 create mode 100644 target/hexagon/hex_interrupts.h
 create mode 100644 target/hexagon/hex_mmu.h
 create mode 100644 target/hexagon/sys_macros.h
 create mode 100644 hw/hexagon/hexagon_tlb.c
 create mode 100644 target/hexagon/cpu_helper.c
 create mode 100644 target/hexagon/hex_interrupts.c
 create mode 100644 target/hexagon/hex_mmu.c
 create mode 100644 target/hexagon/machine.c
 mode change 100755 => 100644 target/hexagon/imported/macros.def

-- 
2.34.1


