Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547B5CA6004
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 02:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEe5q-0002Hz-DF; Wed, 07 Oct 2026 22:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xEe5m-0002HO-Ev
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 22:42:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xEe5k-0001Bi-AP
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 22:42:46 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6981hX1g1824421
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 02:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ghvqalr9VubbBF1UNB05zhxlvXYmpog5gp8+epdWL7o=; b=CuHmPqAhuhgA1S+j
 uQkOGkoDZyaNbVPjzAReekViysmopoONlJWq66gstWtDjBLrzJTrDzeNEqqpm8sQ
 FCsUGlSYelwkp1oi7P/ahYcwPwHRVIKdjAwesTWT0KLIhm/K/Jic3ITf0D8mV0ZF
 il4bUMfa669/YaEwmr9HelvqGCnvBeTsZzg4YSEnCjE99Cwf/ku0owvdxBuJekri
 m3LEbU6oEZ/MaPbawLyhib1dduZLu6r/8ELMAKfpTi8TWTmAKfE/FoxYKy/Qrvjs
 x9Dh54+qbGJwlHOCUnUZIyPnktaK/81OOH2zY/3JDymUfQ+ITgCymzYPGUTv5YTL
 wYZpSQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe80r9u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 02:42:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5350bf63ba3so126693531cf.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 19:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791427361; x=1792032161; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ghvqalr9VubbBF1UNB05zhxlvXYmpog5gp8+epdWL7o=;
 b=aILvOvT+a+ZwoBhsgKD9t/FUFQkvwgBB2J1V6x6ps+0xoi1aBFrunmUsiq2rHRRGey
 RYyad/jEBJLOPXqn+GZwAeLvXaiu++O09u6w0SqT+c/XqjeZEueZ/QFhsyOOEiW89dQC
 pPRYnj2UT7bU5lSnj+pInTc0qwrgabg5w90i1H3MMxncTZ8OSJOKWJutCQ5nZ60kjl0n
 p/mFVqweJAUgrpS+i/wGSOzdrBNO5jqhhh/M/v+976rNAE9u54vWvA0Cuuh6qcFzLwM6
 JIrQnB3Pa0kx8aq9hKu7aSyzoeo9nsfgWxML2dG4d8zuR2F2kA1UUK6tm690OXMXlZdf
 HCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791427361; x=1792032161;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ghvqalr9VubbBF1UNB05zhxlvXYmpog5gp8+epdWL7o=;
 b=AIhGpUcCePNBJicbo7Oywtxe0QHX9ieX+mHbpP2jfuU4ConNlm6IKTPOlb1rSlcyw1
 6FkURg1h5XHmgeQKZqgsoNM1I1JDrJqaxvfSr3wTfXhORq8Re55KJQi4qtPe3lbl5cbO
 W6kgrCv5FISHJxV5m2WlGZOSYP/y7ZKB96O5tDWfeUL0cY3DItAQd2/a7HindtGi7ggP
 IViE20N16WBQSWzAufqqdU676rnJRsMg4d16i2/WRfHHOSqoEVh/mXaKzr7DYKieYalS
 vqrPHw/Kt9npdt+HG7shgrpAjN5gC0g1CwgFj/AubZ98bZlpT/2mIXF+si7nxcsE2ULS
 UhvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0Uok5+zQ7DeTnAVogK257Lw8n4V3TGMjSaUF2wWE0SyMiCtggyv44ull9TP2U2nT/EybShFjuJlle@nongnu.org
X-Gm-Message-State: AFuF++n5JmLDmHTB0S7yyhs5CyZ7Ub5Hc5xPWwzZu5ejCdZtpbdWV9Y3
 WCiUKT5Hb8KOAy4hBTHic5NFdNcrCbdn2s0dUkZry3a6GNNNpCJX9zmHmGIYHLcuoYaD5NHKKcn
 k0KUR/dvaOAXlEc9Wnqk8gD63Z7Q1Rpx2+utKgNDDxsK6PAekG8/ZXwSIAw==
X-Gm-Gg: AYBFou0l5jASgcWs6PCYU6IPeoDlBwuflr9z6U3JZnb2g33GDJPuYO/1Tuz8oOWac3/
 QYXqRPAe+EzCBmeuphY/qACA/da+WcEDc2jNXmvgQwXRpQQ5jtL3loDEIuIX92T930BQHZ4gXYK
 Cmjsnzb8SbawI52llV8AZSXqrh1r8ue8GQOmmj5pSK5AHjpPK+2KmY2w+yjvGZjXaiVY69ztqGv
 zKmUgzj0B1gMVmT7olEVCZBYeQphc1nnt3DgmzO+3+MEKt2PAwsNiHJY0A29ouqGrSNLna+QiX8
 ncU3AqaOEI09n0mOPIF/elS2s21nntj8cpBzhDjWqeB5tRxiaxtOdywXPReTwomRMDGooekDRb6
 B6WLDCR7glsN749YZEjn0bR6SY2FYG6q7CS0O
X-Received: by 2002:a05:622a:1b02:b0:535:52c:a2e7 with SMTP id
 d75a77b69052e-535755c3374mr81312041cf.44.1791427361531; 
 Wed, 07 Oct 2026 19:42:41 -0700 (PDT)
X-Received: by 2002:a05:622a:1b02:b0:535:52c:a2e7 with SMTP id
 d75a77b69052e-535755c3374mr81311761cf.44.1791427361042; 
 Wed, 07 Oct 2026 19:42:41 -0700 (PDT)
Received: from [192.168.10.208] ([185.243.168.149])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53571d0e9d4sm35011191cf.0.2026.10.07.19.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 19:42:40 -0700 (PDT)
Message-ID: <73bc69a4-a3e6-47c8-9c7f-92443706b250@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 23:42:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/11] target/riscv: Implement Smsdid and Smmpt
 extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org, rahul@summations.net,
 xiangyi.zeng@linux.alibaba.com, cxx194832@alibaba-inc.com
References: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAxMCBTYWx0ZWRfX++HbFIyCwKkz
 2HQ8VeFQB2RJ5wWqqGFsebLBfcTxFUAWNdLhRCrKqXEUFqp/Axbg26iAGOYgw2AP+H9vbyxa1vi
 /TIPr8RzAsOtVVEHIdCoUsxp+OGc1Bxz6AEbk1xAbZDMMe7JXdcMa2PLYK8CejEmsN1t2XhWHjK
 +aOrvomvnmFVW1TpDSeg7p08lMmZUd41NJuMIdWKcOt6bUgTVKEfaSRI3MmWSQNROVdYi/4adwx
 vhWZ3n2rwKc8L2HpA9svW2Lj+ubkMMmrq8jrVIdDTrcDWvpgDao2YYN3NlidHWuuyVp3PNPNvIM
 q3ChZkoRhjlqAwVLZapTOfRm7GaKrPx5KIWB7WXNjzrIMWIOHY60snlroXPhhUQVfctHg/WgklO
 0xizgJddCRGlWrwRcILPYLWlpwVz/Pk3uLAqhqDMJ2UrIkLMIBaqs0/Y51UnQjIZuuacVpOg4m2
 gzY0xHfPPJqmD/lLPQw==
X-Proofpoint-GUID: -dbC9wn5DgSN1zV5XOhaMqNFzhkcCQds
X-Proofpoint-ORIG-GUID: -dbC9wn5DgSN1zV5XOhaMqNFzhkcCQds
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAxMCBTYWx0ZWRfXzuJne5JO/HR1
 04HWFCpFLdCRfTcYnXeooemiETn3xVbzD/S+5xYyMSupmpYgCLv1Z9LKFOekP6w0khnJTakcXEC
 RvgfgMYtcUB4FKsesqK9wL6Mwe5yPHQ=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac70322 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Adc43iEMMYzOb2FTIT2GVQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=xvfqbYfxAAAA:20 a=mDV3o1hIAAAA:8 a=JfrnYn6hAAAA:8 a=NEAV23lmAAAA:8
 a=GaQpPoNlAAAA:8 a=SRrdq9N9AAAA:8 a=bHPTYyKsEsybeaz2o74A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=1CNFftbPRP8L7MoqJWF3:22 a=xF5q_uoM5gZT5J3czcBi:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_01,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080010
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=ham autolearn_force=no
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

Hi Zhiwei,


Sorry from taking this long to take a look at this work.  I am afraid I'll
need to ask you to send a v9 due to the following upstream changes, aside
from some review comments I made:

- upstream changed how tcg tests are invoked (we use meson now), i.e. you
need to add changes in tests/tcg/riscv64/system/meson.build instead of
Makefile.softmmu-target;

- upstream also changed how we declare things in disas/riscv.c.


If you send a v9 I'll prioritize it for review.  We can get this done for
11.2.


Cheers,
Daniel

On 7/23/2026 5:03 PM, LIU Zhiwei wrote:
> This patch set introduces support for the RISC-V Smsdid and Smmpt
> (Supervisor Domain Identifier and Memory Protection Table) extensions
> v0.4.9(https://github.com/riscv/riscv-smmtt/releases/tag/v0.4.9).
> Smmpt provides a hardware mechanism for fine-grained memory protection,
> checked after address translation, which is particularly useful for
> supervisor-level sandboxing and security monitoring.
> 
> The rfc patch set:
> https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html
> 
> Rahul Pathak is working on SMMPT OpenSBI support -
> https://lists.infradead.org/pipermail/opensbi/2026-July/010235.html
> 
> based on his QEMU SMMPT branch -
> https://github.com/pathakraul/qemu/tree/rpathak_smmpt_v1
> 
> As we all agree -
> https://patchew.org/QEMU/20260715145016.17369-1-zhiwei._5Fliu@linux.alibaba.com/
> , we will collaborate on this work and not duplicate efforts. Rahul will
> focus on OpenSBI upstream and I will update the QEMU patch set to v8.
> 
> Xiangyi will review the OpenSBI SMMPT patch set and may collaborate to
> upstream the other parts, such as SMSDIA and IOMPT.
> 
> v7->v8:
>      1. Update the mfence.pa and minval.pa instruction encodings to match the
>         upstream riscv-opcodes definition
>         (https://github.com/riscv/riscv-opcodes/pull/389/): mfence.pa now uses
>         funct7=0b0011001 and minval.pa uses funct7=0b0011011. The decoder,
>         disassembler and the system test are updated accordingly.
> 
> v6->v7:
>      The implementation is updated from the v0.3.4 specification to
>      v0.4.9. The main changes are:
>      1. Update the mmpt CSR number to 0x382 and msdcfg to 0x74E.
>      2. Update the mmpt register layout: the SDID and PPN field positions
>         changed and the RV64 PPN is now 44 bits.
>      3. Rework the MPTE format: the N (NAPOT) bit now lives at bit 2, the
>         non-leaf NAPOT form is removed, NAPOT leaf entries encode a single
>         XWR tuple plus a G granularity field, and non-NAPOT leaf entries
>         hold per-page XWR tuples.
>      4. Treat XWR=000 as "no access" and a non-leaf entry with N=1 as a
>         fault.
>      5. Enforce the Smmpt64 root-table PPN alignment (low 3 bits zero).
>      6. Rename the fence instructions mfence.spa/minval.spa to
>         mfence.pa/minval.pa.
>      7. Drop stale Reviewed-by tags on the substantially reworked patches.
>      8. Introduce the configurable "smmpt-sdidlen" CPU property.
>      9. Add disassembly support for the Smmpt.
>      10. Add bare-metal M-mode system tests.
>      11. Rebase to master.
> 
> v5->v6:
>      1. Use explicitly bit fields extract instead of mpte_union_t.
>      2. Use the same exception behavior for MPT valiation as PMP
>         valiation.
>      3. Use PAGE_* instead of MPT_ACCESS_* as they have same value.
>      4. Use address_space_*_le instead of address_space_* for SMMPT.
>      5. Only print SMMPT address check log when SMMPT is enabled.
>      6. Add implied rule for SMMPT as it depends on SMSDID.
>      7. Rebase to master.
> 
> v4->v5:
>      1. Rebase to master.
> v3->v4:
>      1. Add missing review tags.
> v2->v3:
>      1. Fix build error in patch 2.
>      2. Rebase to master.
> 
> rfc->v2:
>      1. When ext_smmpt is false or BARE mode, make other fields in mmpt
>         CSR zero.
>      2. Add patch 5 to fix smrnmi ISA string order.
>      3. Fix patch 6 smmpt and smsdid ISA string order.
>      4. Make smmpt and smsdid experiment extensions.
>      5. Add review tags.
> 
> LIU Zhiwei (11):
>    target/riscv: Add basic definitions and CSRs for SMMPT
>    target/riscv: Add smmpt-sdidlen property for the mmpt SDID field
>    target/riscv: Implement core SMMPT lookup logic
>    target/riscv: Integrate SMMPT checks into MMU and TLB fill
>    target/riscv: Implement SMMPT fence instructions
>    target/riscv: Fix smrnmi isa alphabetical order
>    target/riscv: Add disassembly for Smmpt instructions and CSRs
>    target/riscv: Enable SMMPT extension
>    target/riscv: Add system test for SMMPT extension
>    target/riscv: Add system tests for Smmpt52 and Smmpt64
>    target/riscv: Add system test for Smmpt34
> 
>   disas/riscv.c                                 |   9 +-
>   target/riscv/cpu.c                            |  60 +++-
>   target/riscv/cpu.h                            |   8 +
>   target/riscv/cpu_bits.h                       |  27 ++
>   target/riscv/cpu_cfg_fields.h.inc             |   3 +
>   target/riscv/insn32.decode                    |   2 +
>   target/riscv/meson.build                      |   1 +
>   target/riscv/riscv_smmpt.c                    | 339 ++++++++++++++++++
>   target/riscv/riscv_smmpt.h                    |  26 ++
>   target/riscv/tcg/cpu_helper.c                 | 119 +++++-
>   target/riscv/tcg/csr.c                        | 106 ++++++
>   .../tcg/insn_trans/trans_privileged.c.inc     |  30 ++
>   target/riscv/tcg/pmp.h                        |   3 +
>   tests/tcg/riscv64/Makefile.softmmu-target     |  12 +
>   tests/tcg/riscv64/smmpt-common.S              | 257 +++++++++++++
>   tests/tcg/riscv64/test-smmpt.S                |  85 +++++
>   tests/tcg/riscv64/test-smmpt34.S              |  97 +++++
>   tests/tcg/riscv64/test-smmpt52.S              |  91 +++++
>   tests/tcg/riscv64/test-smmpt64.S              |  98 +++++
>   19 files changed, 1354 insertions(+), 19 deletions(-)
>   create mode 100644 target/riscv/riscv_smmpt.c
>   create mode 100644 target/riscv/riscv_smmpt.h
>   create mode 100644 tests/tcg/riscv64/smmpt-common.S
>   create mode 100644 tests/tcg/riscv64/test-smmpt.S
>   create mode 100644 tests/tcg/riscv64/test-smmpt34.S
>   create mode 100644 tests/tcg/riscv64/test-smmpt52.S
>   create mode 100644 tests/tcg/riscv64/test-smmpt64.S
> 
> 
> base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05


