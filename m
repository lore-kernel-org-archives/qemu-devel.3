Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84910C44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 17:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wklvb-00019i-DG; Fri, 17 Jul 2026 13:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wklvU-00014F-W3; Fri, 17 Jul 2026 13:00:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wklvS-0004Iu-JA; Fri, 17 Jul 2026 13:00:40 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HEBrgh360443; Fri, 17 Jul 2026 17:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Slfq83
 9Nzrww98FCFFubwt3Bxogsbz1jAN6acQigG0w=; b=lCc0xezX1+eDU3F6N8Xwm7
 XwWjAK7DqsuIYDqz8mHu2sWGkRpQA1E0Y1v2a9gbHZFdfquMPsiED67Hbqt60csX
 LKqeDhZpxXR7RLhmqmcxEAAkrlkoRwqCGKLYsRVopBDChEom78Ig5dFwXtpsRAYr
 FpBSAIU38AMbEAOOnv7VK409oFwgfg9/29CUAH8lUTa7ccw/KZV3CG6Xexu/y6E+
 KZbRhfVbYqyK2z9mz7vTReJbJKM9QWnUBHZ7wTU3qorpBh9FJe9Nj1Pr/DFcNi0u
 dJeI6aD/Iw1lXYtR90Dw0SGhZJc/YYa5hxZMJWxYSEz2OEQMi/+q0FdsZPPt0jNg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33r2st-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 17:00:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HGo3Tr009383;
 Fri, 17 Jul 2026 17:00:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qjqw6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 17:00:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66HH0UPg45809972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jul 2026 17:00:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C03472004D;
 Fri, 17 Jul 2026 17:00:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CADB20040;
 Fri, 17 Jul 2026 17:00:30 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.138.123])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jul 2026 17:00:30 +0000 (GMT)
Message-ID: <d47df378-d920-443e-8f5b-10373d63a3ab@linux.ibm.com>
Date: Fri, 17 Jul 2026 19:00:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/51] accel/tcg: Pass watchpoint hit to
 debug_excp_handler
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-27-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE3MCBTYWx0ZWRfXxFzf6J5S5vZP
 X4NspMJi3W4ZTO/lkFPt0GW6XSLLK+6lF6SzD6rrvbLIRyn0GkWbB2JS23lrvmGMtWdlGlPuUQT
 yKexEqSg+szAVVrY4tSAIwEU3ukfIkM=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5a5fb1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=cI_4PblpzWkclxkKpuAA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: BYD7u2F6qi_G8lrxLahAO8Y7GSnzLYQ6
X-Proofpoint-ORIG-GUID: XVto-0vhxi-M4o1VRfFwvgnTqzIozN_g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE3MCBTYWx0ZWRfX5/deiisFAgks
 y1ePaANntl9Ol8oP4UjpSFXqG29sqjcjK4wGMEVgHVJOlijr1aHfHBaTBDkDILUXypXt7tcmUGU
 Ohk+TbHMCVamknvk0XeJLEM/vbKVQjScyGLg4A2zXKB2hP/CsU2rx/Bm4FyKa5zo3AceoTyaAvq
 Z+/r6Es8F10p3v4gSgk4vkCwlLhcH1XhzINOB9sUF/PXFiiNfpet0fdgN/oOx2mlPzvVUjsuGeV
 OSzvAEeA7OEbqkLjzoPgjhNeSt7loFfRUgR+1TyWH4Q1gg+VvYDmQ0LXU2NLlQtmJrowMowrNa3
 3vR4nDcsuAQDVy4DTtaEqPWzFac9wNQTLbia3ByXDM+ADH0jVljlM4ASjdlfQcBkW9cn27BOZCj
 YznFkavMiYL4U2OxepVMfnkr/az37SJ0WfNncYmj0yIU6ds8441X8W7PMAHyUpej8NsH3zwloIb
 CdWq2o0h95v/KMBJKrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170170
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 7/10/26 22:53, Richard Henderson wrote:
> Allow the breakpoint/watchpoint causing the exception
> to be passed to the target hook.  Unused so far.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h         | 2 +-
>   target/arm/internals.h              | 2 +-
>   target/i386/tcg/helper-tcg.h        | 2 +-
>   target/ppc/internal.h               | 2 +-
>   target/riscv/debug.h                | 2 +-
>   target/s390x/tcg/tcg_s390x.h        | 2 +-
>   target/xtensa/cpu.h                 | 2 +-
>   accel/tcg/cpu-exec.c                | 2 +-
>   target/arm/tcg/debug.c              | 2 +-
>   target/i386/tcg/system/bpt_helper.c | 2 +-
>   target/ppc/tcg-excp_helper.c        | 2 +-
>   target/riscv/debug.c                | 2 +-
>   target/s390x/tcg/debug.c            | 2 +-
>   target/xtensa/helper.c              | 2 +-
>   14 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



