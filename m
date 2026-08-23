Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CCAC5DF81
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 06:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy1lb-00070l-Q5; Sun, 23 Aug 2026 02:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy1la-00070U-1B; Sun, 23 Aug 2026 02:33:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy1lY-0002F1-3c; Sun, 23 Aug 2026 02:33:13 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67N4W6Ru2178128; Sun, 23 Aug 2026 06:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=katMZt
 JizT5VMMR9fLMw5nHzQ/wQMBtUfKyiWC/y74g=; b=sk/mWe6hsZh8Kc0Io7nhk7
 DLMThkAd1CL0NKAX9Hav1YmRFfQ3s0mpiRYRDlWkS1nmO4kkH0qcllZsZpM0sGAb
 NK9evILLsJC6mshDYfdcI5vyk0anO2GhUdjYsVARmMKjveOF94MtHYqTq5/YDg7z
 OfxJW+lsAZDAT1AEGFPO2JyRk6F770NFG8bwlVXW2LDxfJAurhojk+cF3uTwhyfH
 aFV4As6ZwnZdHC0RuXT0v1NetDB1BDgojtxxSnDBzbNUo7mFyHVtRwPxhPN4Z/Ks
 pFr1USrA3DOJuEelKRGED9hHwX7md5c/CiJfIXgE/uC8LFH+QtOMNE2NKezXFv1g
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393kxcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Aug 2026 06:33:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67N6QH8a000358;
 Sun, 23 Aug 2026 06:33:08 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgrk12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Aug 2026 06:33:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67N6X5cu41026274
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 23 Aug 2026 06:33:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9533058055;
 Sun, 23 Aug 2026 06:33:05 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E45B95804B;
 Sun, 23 Aug 2026 06:33:01 +0000 (GMT)
Received: from [9.39.19.238] (unknown [9.39.19.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 23 Aug 2026 06:33:01 +0000 (GMT)
Message-ID: <36ec32f6-f79d-4039-9a0c-e856d297b9a4@linux.ibm.com>
Date: Sun, 23 Aug 2026 12:02:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] target/ppc: PPC ISA 2.07 flag cleanup and updates
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, milesg@linux.ibm.com,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260820142717.337686-1-rathc@linux.ibm.com>
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260820142717.337686-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: NDW97o5OiwurGGrYUumOqy1l7SMt2kHQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDA1NyBTYWx0ZWRfX9AdKnWsW5JGK
 ndwQmH0+tGMyP96XCF98zRphOLQglGtv0ECkxhShH+JLXU60YegsEshUgVvQbqkYWuKV+w2vRiG
 V5SMahsMaBehW38FB8Gvc24hi468y/chlF51ZxsoJP23Va7/U97DMO3ysbtArrUQ0jQugYNouCq
 eWOiVxIncR18rfQxbYWcx5Ys2y0/9glomfiwUVWPnrMsKkONHCVWlBkc+XEa9wapS1dx5piMTk1
 iP48hUWWQahjOjn4d73DM9lCpvne5MP4rIldeHSAjxGi/AE9m0E/reGbkLvhNzExy1nB1MDHRhY
 yYZljx2gECOKi2GSiHdXgF7gQ8Xo7JDimnOa7oj/ntT4ZHBtYUmvcQwwF1di/LTUSZZzy8d6wV4
 c0ckCULz34HJ/F//c3v6+wkNSuZcQFZBUo20W+62P9jfPeAhiBW5DHaOPG/t44t9pMyUg0KsCg+
 JEnQfmKGPavUwFXSzOw==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8a9425 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=p0WdMEafAAAA:8 a=aWvmHB4EVBvjFA1lbNcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDA1NyBTYWx0ZWRfX7Fb8S/FY9AS2
 qIr8wtv8lDrZxsrJjm7hJ+TCf7v+6ifryLB57oASDnZ90tZD9FoW38MRjCtjnnI00O4ZZjK8J62
 +R80J4cvP252/et+fN4Pf7xzfGm3kI4=
X-Proofpoint-ORIG-GUID: Fw9CrgVJyDFXxyxsg0Ke7HWjzH9Q9RJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230057
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

Hi Chinmay,

On 20/08/26 7:56 pm, Chinmay Rath wrote:
> While working with some PPC instructions from a ISA 2.07 POV, I observed
> the following :
> 
> 1. Unlike ISA versions 2.05, 3.0 and 3.1 which have one specific flag
> for usage in the insns_flags2 field in the CPUPPCState struct, ISA 2.07
> and 2.06 have multiple flags. Upon further investigation, I see that
> during CPU intialization (POWER 8+), all those variations of the ISA 2.07
> flags are only ever used all together. There is no instance in the code
> where a CPU is initialzed in a more granular level, using only a subset
> of the ISA 2.07 flag variations.
> This patch series hence consolidates the different 2.07 flags, and frees
> up bits in the insns_flags2 field for future use. I intend to do the
> same analysis for the ISA 2.06 flags as well.
> 
> 2. The "Summary of changes in Power ISA 2.07B" section in the ISA
> version 2.07B mentions : "The icbt instruction has been moved from
> the Embedded category to the Base category."
> This change has not been incorporated in the QEMU code resulting in
> illegal instruction exception upon encountering ICBT instruction in
> Power VMs where it should be recognized. Hence adding the necessary
> flag to the instruction. Also correcting the invalid mask for the
> decoding as per the ISA.
> 
> This series is based on top of the patches from another series that I
> had posted :
> [A] : https://lore.kernel.org/qemu-devel/20260820140114.327023-1-rathc@linux.ibm.com/

Thanks for these improvements.
I see the pre-req decodetree series is still undergoing review by Glenn
and others while this is reviewed already, therefore this needs to wait
a little more.

regards,
Harsh
> 
> Link to Gitlab CI with patches :
> https://gitlab.com/rathc/qemu/-/pipelines/2776338293
> 
> Changes in v2 :
> -Retained all 'Reviewed-by's and 'Tested-by's received.
> 
> -In patch 2: Change instruction flag in BCTAR instruction.
> The above series [A] now incorpates the following review comment
> received on its respective RFC series :
> https://lore.kernel.org/qemu-devel/46867b5b-bb66-4378-8722-d918fd720037@linux.ibm.com/
> Due to this. Doing the necessary change in patch 2.
> 
> 
> Chinmay Rath (7):
>    target/ppc: Replace PPC2_VSX207 flag with PPC2_ISA207
>    target/ppc: Use PPC2_ISA207 instead of PPC2_BCTAR_ISA207
>    target/ppc: Use PPC2_ISA207 instead of PPC2_LSQ_ISA207
>    target/ppc: Use PPC2_ISA207 instead of PPC2_ALTIVEC_207
>    target/ppc: Use PPC2_ISA207 instead of PPC2_ISA207S
>    target/ppc: Reorder PPC2 flags
>    target/ppc: Add ICBT support for ISA version 2.07
> 
>   hw/ppc/spapr_caps.c                           |   2 +-
>   linux-user/ppc/elfload.c                      |   6 +-
>   target/ppc/cpu.h                              |  38 +++----
>   target/ppc/cpu_init.c                         |   6 +-
>   target/ppc/cpu_init.h                         |   7 +-
>   target/ppc/tcg-excp_helper.c                  |   8 +-
>   target/ppc/translate.c                        |  10 +-
>   target/ppc/translate/bhrb-impl.c.inc          |   4 +-
>   target/ppc/translate/branch-impl.c.inc        |   4 +-
>   target/ppc/translate/fixedpoint-impl.c.inc    |   4 +-
>   target/ppc/translate/fp-impl.c.inc            |   4 +-
>   .../ppc/translate/processor-ctrl-impl.c.inc   |   8 +-
>   target/ppc/translate/vmx-impl.c.inc           | 102 +++++++++---------
>   target/ppc/translate/vmx-ops.c.inc            |  18 ++--
>   target/ppc/translate/vsx-impl.c.inc           |  56 +++++-----
>   target/ppc/translate/vsx-ops.c.inc            |  24 ++---
>   16 files changed, 143 insertions(+), 158 deletions(-)
> 


