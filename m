Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F4FC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzp4u-0003hD-S0; Fri, 28 Aug 2026 01:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1wzp4t-0003gw-CQ; Fri, 28 Aug 2026 01:24:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1wzp4r-00029P-AG; Fri, 28 Aug 2026 01:24:35 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S22QVi2941526; Fri, 28 Aug 2026 05:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/9MDzp
 5zpHGQZs60af0Nuv1vvjvn58hagr6Hc+B8+NA=; b=if0jgclzI3n4X2GnR3I4zu
 GcRcfSU8fyeu0ZtePBtNq+mB6XFKaV2k8HxvaSmPg7ezH15MxowAw6Sh3R8X9efE
 UPiephqlLeQNgihzeWlov28d0vjgfD/NFD36G/QNmc8UwF7IMjMpvccRbIOAfnsi
 9KmPZwtoFw0dbbQQrbAtmoTw9gUQJIr1DY4SuQiQJDGe8KNNmlfwItNZ0Xr4ZJ9Y
 /XLUTr41HnohS+4AZeIFYir9a19FX2g//XsROzn6BP4/i4/a/CFqwXPol3Soj5WY
 xss2IhkBv42mu9vfbMI7ZboqcvKZLjeo+Kw8RQy/uQT3YrlQFsuZ/zilaXijbp6Q
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73era50u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 05:24:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5BG5j002458;
 Fri, 28 Aug 2026 05:24:02 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragvaqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 05:24:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S5O1TV31523546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 05:24:01 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 565515805B;
 Fri, 28 Aug 2026 05:24:01 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C72CF58059;
 Fri, 28 Aug 2026 05:23:53 +0000 (GMT)
Received: from [9.39.23.39] (unknown [9.39.23.39])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 05:23:53 +0000 (GMT)
Message-ID: <e7ca0e25-ce39-4766-a36b-1c38e43e440d@linux.ibm.com>
Date: Fri, 28 Aug 2026 10:53:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/37] target/ppc: PPC TCG Improvements (decodetree
 migrations + ISA 2.07 flag updates)
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com, milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 asahu1x@linux.ibm.com
References: <20260827133010.278889-1-rathc@linux.ibm.com>
Content-Language: en-US
From: Aniket Sahu <asahu1x@linux.ibm.com>
In-Reply-To: <20260827133010.278889-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _QcVDNyEb07AtUOFDmS0601W0frWGOxO
X-Proofpoint-ORIG-GUID: 6nEq-gMnja8J6gsTVCxLPXMgt4ifFVkn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA0MSBTYWx0ZWRfX2YqdD9/+Nz9c
 opPwV5yc1iPqVYMOjlXTUqPi6kTuKRncxDKHvFJcvV/lC50/ob1AtvJpbWSZS0aoYvC98iwfziJ
 Vj03tuZvSE3wMf/AWxaar0BuPzkOM/cZ2vM5K/JmiWpPf2PafjhxKnYY7oXNmTFsQDrI0pVMyCe
 uchv5IzyeX2pG/qBy4bysLt+DAZkILPeeWlOiBrukVYbHHPoLiDVJOBQngCGHQlcYkkk0Yj6Hdv
 e5Qfd2YV2Eh44GhFUrxuCx5CfuC6uQwscaA+ZszdlyNAzZn7Xw6ZAge02iBrkWD+aR1/rEc8h0M
 eCyLRxa2xRVIaOse/fEAsL2zK/9ngrLlIHF8KY3p0PlKj1sCB2S/jJvqpbGDuMRiIM6NnUi3Mra
 R5IGt+7azIUdHdTmjZdFlf4xwR0cx3VxVPVTEe171ij7ioCY9rljj197CkWNvq7Ub4HWX6iBBXk
 TRPL5869zbqo1i0HD3A==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a911b73 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=HTI-n6VGEuHaiOF8ZKoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA0MSBTYWx0ZWRfX/kzWy4vJ/ULW
 Yja/ag57VP786rtgN6AoHGnj2HTGboD9TLxJEK4TUw4Ec4WRreFRBwLH8ZwS0KKr6564iHcaaJb
 mVSH4e0hXM3O1ogRX3ht4WwHVSG1Nxo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280041
Received-SPF: pass client-ip=148.163.156.1; envelope-from=asahu1x@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 27/08/26 6:59 PM, Chinmay Rath wrote:
> This series primarily contains 3 changes :
>
> 1. PPC instructions movement to decodetree specification
> Changes from v2 :
> - Addressed review comments from Amit, as discussed in the v2 series.
> - Retained Rbs received.
>
> 2. PPC ISA 2.07 flag cleanup and updates
> This series is based on top the above decodetree series.
> - No changes. Only Rbs added.
>
> 3. Stepping up as an active maintainer for PowerPC TCG CPUs module.
>
> Link to v2: https://lore.kernel.org/qemu-devel/20260826050923.74756-1-rathc@linux.ibm.com/
>
> Aboorva Devarajan (3):
>    target/ppc: Move vector merge instructions to decodetree
>    target/ppc: Move vector pack instructions to decodetree
>    target/ppc: Move GPR atomic load/store instructions to decodetree
>
> Amit Machhiwal (2):
>    target/ppc: Move fixed-point Shift insns to decodetree
>    target/ppc: Move fixed-point byte-reversal store insns to decodetree
>
> Chinmay Rath (9):
>    target/ppc: make do_ea_calc_ra available for 32 bit builds
>    target/ppc: Replace PPC2_VSX207 flag with PPC2_ISA207
>    target/ppc: Use PPC2_ISA207 instead of PPC2_BCTAR_ISA207
>    target/ppc: Use PPC2_ISA207 instead of PPC2_LSQ_ISA207
>    target/ppc: Use PPC2_ISA207 instead of PPC2_ALTIVEC_207
>    target/ppc: Use PPC2_ISA207 instead of PPC2_ISA207S
>    target/ppc: Reorder PPC2 flags
>    target/ppc: Add ICBT support for ISA version 2.07
>    target/ppc: Add self as maintainer for PowerPC TCG CPUs
>
> Mukesh Kumar Chaurasiya (IBM) (2):
>    target/ppc: convert slw, srw instruction via decode spec
>    target/ppc: convert sraw[i] instruction via decode spec
>
> Nikhil Kumar Singh (3):
>    target/ppc: Migrate extswsli to decodetree
>    target/ppc: Migrate atomic loads to decodetree
>    target/ppc: Convert cache instructions to decodetree
>
> Ojaswin Mujoo (7):
>    target/ppc: Move isync instruction to decodetree
>    target/ppc: Convert b{a, l, la} to decode tree
>    target/ppc: move various conditional branch insns to decodetree
>    target/ppc: Fix TRANS* macro variadic arguments handling
>    target/ppc: Move wait instruction to decodetree
>    target/ppc: Move sleep & friends to decodetree
>    target/ppc: Refactor sleep and its variants to use a common helper
>
> Shivang Upadhyay (4):
>    target/ppc: Move Condition Register access instructions to decodetree.
>    target/ppc: Move Condition Register logical instructions to
>      decodetree.
>    target/ppc: Move Fixed-Point Load/Store String instructions to
>      decodetree.
>    target/ppc: Move VMX integer arithmetic and BCD instructions to
>      decodetree.
>
> Shivani Nittor (1):
>    target/ppc: Convert mcrf to decode tree
>
> Tanushree Shah (2):
>    target/ppc: Move rlwimi, rlwinm instructions to decodetree
>    target/ppc: Move lmw, stmw instructions to decodetree
>
> Utkarsh Verma (1):
>    target/ppc: Move st{b, h, w, d, q}cx instructions to decodetree
>
> Vishal Chourasia (3):
>    target/ppc: Move mfmsr, mtmsr[d] instructions to decodetree
>    target/ppc: Move byte-reverse instructions to decodetree
>    target/ppc: Move system call and rfi instructions to decodetree

Ran my tests on the v3 patch, here are the findings:
- Built qemu with all 37 patches applied with no issues
- All relevant selftests are passing without errors
- Guest boots and runs in TCG mode, checked with SLES16.1 RC2 guest on 
an Ubuntu 26.10 host
- Basic functionality checks done for guest, no issues found

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>

>
>   MAINTAINERS                                   |    2 +-
>   hw/ppc/spapr_caps.c                           |    2 +-
>   linux-user/ppc/elfload.c                      |    6 +-
>   target/ppc/cpu.h                              |   38 +-
>   target/ppc/cpu_init.c                         |    6 +-
>   target/ppc/cpu_init.h                         |    7 +-
>   target/ppc/helper.h                           |   96 +-
>   target/ppc/insn32.decode                      |  252 ++
>   target/ppc/int_helper.c                       |   76 +-
>   target/ppc/internal.h                         |    7 -
>   target/ppc/mem_helper.c                       |   14 +-
>   target/ppc/tcg-excp_helper.c                  |   18 +-
>   target/ppc/translate.c                        | 2258 +++--------------
>   target/ppc/translate/bhrb-impl.c.inc          |    4 +-
>   target/ppc/translate/branch-impl.c.inc        |  182 +-
>   target/ppc/translate/fixedpoint-impl.c.inc    |  947 ++++++-
>   target/ppc/translate/fp-impl.c.inc            |    4 +-
>   target/ppc/translate/misc-impl.c.inc          |  172 ++
>   .../ppc/translate/processor-ctrl-impl.c.inc   |   39 +-
>   target/ppc/translate/storage-ctrl-impl.c.inc  |  116 +
>   target/ppc/translate/vmx-impl.c.inc           |  457 ++--
>   target/ppc/translate/vmx-ops.c.inc            |   59 +-
>   target/ppc/translate/vsx-impl.c.inc           |   56 +-
>   target/ppc/translate/vsx-ops.c.inc            |   24 +-
>   24 files changed, 2473 insertions(+), 2369 deletions(-)
>

