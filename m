Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D253C61DC7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzWl0-0005iJ-VG; Thu, 27 Aug 2026 05:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1wzWkz-0005hf-AG; Thu, 27 Aug 2026 05:50:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1wzWks-0005oT-SZ; Thu, 27 Aug 2026 05:50:44 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R9VbJV2607581; Thu, 27 Aug 2026 09:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VTx0cE
 NKebsDU7M54XO492fPjwAYP/3GjpO90e490hc=; b=CMHdIyDa2VBQ3teM3vlZje
 QQQZiBDxcDfv8XLA3BYbaO3wnnHSGA5UyXsNRmqIwU0Fho5aeMS4IYSDNXfoR5Bd
 VIf74HMtcmvlGsgOEkq5aku6Cpx0rxlxmji9VfdfyBVbUOIxb3JHiD+QSmH2tB5b
 ufQaLLINSIH9JXY6vah5wxm1FMvv5V49ZBTSmCP51IqJiKPKLxPnc3UXBNeyAxxN
 bCMpspk4u7wVqDifivhRkAvDQGq+oaga/TzbP/euOY4WKzkRX+0NSJ5fBK1POeYd
 m9VilXbzE+mY4/wb5Rs4IvMrqQ8+V4PUm5L5a4W6G6SfkS5UpzW1OwC9YAGNovmA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g54kd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 09:50:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R9QgVi023252;
 Thu, 27 Aug 2026 09:50:38 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhf8xt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 09:50:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67R9oa5u4850418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 09:50:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D86E958056;
 Thu, 27 Aug 2026 09:50:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D351E58062;
 Thu, 27 Aug 2026 09:50:29 +0000 (GMT)
Received: from [9.39.21.199] (unknown [9.39.21.199])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 09:50:29 +0000 (GMT)
Message-ID: <a6eb78f8-9586-44c2-a012-6fbf12c6c469@linux.ibm.com>
Date: Thu, 27 Aug 2026 15:20:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/37] target/ppc: PPC TCG Improvements (decodetree
 migrations + ISA 2.07 flag updates)
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com, milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 asahu1x@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
Content-Language: en-US
From: Aniket Sahu <asahu1x@linux.ibm.com>
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: gP2HR-AdgE5UQbOGfK0QLwRT0xGn3dIb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3OCBTYWx0ZWRfX9Ig1AVntyU65
 5h6hBrno2VSCr8ywrfqmNPWvbJVNIGEU9+BO1Xfu6bnYd0qB721Nf/bJUgujfetg0vHQ1VZriBW
 n8vHNDd4SHKg/c8yDAcjM8DpMCx1Y3o=
X-Proofpoint-GUID: OCPEFx0PgK2kN_aGuqMUpmIyZofaHKAj
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a900870 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gcxaAFmBryHoqIWBXxoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3OCBTYWx0ZWRfXzq5qRQvFM0H9
 mFTweQJNvWXTcJVCJ4mBuzqkDBuTBjxoOxfsnLQ5sFoa4gOlM9pftDKI+DS8NuLOc5Zg6OrCa1/
 EY+O5w9OaAuoycpQayuXodVKcsYhY7S9YydTj/120B2lBsCiPzgLfU/Iw17ufVdMmhLaEGH7d2T
 UHztQENoToqZgs9dvEWPReC7vFQkIBwgzZ4zQvWmX9sVu94X7piTpV3/0xqXyQ0grx4eCOlJMPb
 plt209FWRXRRNfrXqqR416SpNph4OOtiFVubdNCCk54YT5GDH9PN4cP4k3g34Gc3N7GYSzu4tnV
 fxWOLnWZQdHQyHH1wIcmHpfrZwfxMmdJ6wvzb3X0QiMU3hUuTIXrDhMUiCyq8VHq5H7zLkdeFPb
 kGPfabvQuSxEJV0FxQCz26JgZEnxUZqHdXBdhkYQ4S5oZ/ZQe8BUbsJv7t3Nzs0Tzes4t29Dyni
 Zq7aqRGDECU51pEhONQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270078
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


On 26/08/26 10:38 AM, Chinmay Rath wrote:
> This series primarily contains 3 changes :
>
> 1. PPC instructions movement to decodetree specification (Only patch 19 needs Rb)
> Link to the original v1 : https://lore.kernel.org/qemu-devel/20260820140114.327023-1-rathc@linux.ibm.com/
> Changes from v1 :
> - Patch 19 commit log updated as suggested by Glenn.
> - Retained Rbs received.
>
> 2. PPC ISA 2.07 flag cleanup and updates (Already reviewed)
> Link to the original v2 : https://lore.kernel.org/qemu-devel/20260820142717.337686-1-rathc@linux.ibm.com/
> This series is based on top the above decodetree series.
> - No changes. Only Rbs added.

Please feel free to add:

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>

Tested on a POWER10 LPAR (Ubuntu 26.10 host):
- Built QEMU successfully with all 37 patches applied
- Verified qemu-system-ppc64 functionality with SLES 16.1 RC2 guest in 
TCG mode
- Guest boots and runs without issues
- Tested basic functionality tests in guest, no issues or regressions 
observed

>
> 3. Stepping up as an active maintainer for PowerPC TCG CPUs module.
>
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
>    target/ppc: Move isync instruction to decodetree.
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
>
>   MAINTAINERS                                   |    2 +-
>   hw/ppc/spapr_caps.c                           |    2 +-
>   linux-user/ppc/elfload.c                      |    6 +-
>   target/ppc/cpu.h                              |   38 +-
>   target/ppc/cpu_init.c                         |    6 +-
>   target/ppc/cpu_init.h                         |    7 +-
>   target/ppc/helper.h                           |  100 +-
>   target/ppc/insn32.decode                      |  254 ++
>   target/ppc/int_helper.c                       |   76 +-
>   target/ppc/internal.h                         |    7 -
>   target/ppc/mem_helper.c                       |   18 +-
>   target/ppc/tcg-excp_helper.c                  |   18 +-
>   target/ppc/translate.c                        | 2297 +++--------------
>   target/ppc/translate/bhrb-impl.c.inc          |    4 +-
>   target/ppc/translate/branch-impl.c.inc        |  183 +-
>   target/ppc/translate/fixedpoint-impl.c.inc    |  938 ++++++-
>   target/ppc/translate/fp-impl.c.inc            |    4 +-
>   target/ppc/translate/misc-impl.c.inc          |  170 ++
>   .../ppc/translate/processor-ctrl-impl.c.inc   |   38 +-
>   target/ppc/translate/storage-ctrl-impl.c.inc  |  117 +
>   target/ppc/translate/vmx-impl.c.inc           |  457 ++--
>   target/ppc/translate/vmx-ops.c.inc            |   59 +-
>   target/ppc/translate/vsx-impl.c.inc           |   56 +-
>   target/ppc/translate/vsx-ops.c.inc            |   24 +-
>   24 files changed, 2494 insertions(+), 2387 deletions(-)
>

