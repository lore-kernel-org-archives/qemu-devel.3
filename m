Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17152C44514
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkTP1-0006rk-KD; Thu, 16 Jul 2026 17:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wkTOw-0006rB-By; Thu, 16 Jul 2026 17:13:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wkTOu-0002or-Q6; Thu, 16 Jul 2026 17:13:50 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GKBuvv013177; Thu, 16 Jul 2026 21:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9kf6TK
 o2X9dk1+tdxDVhKkGNG8nX3776hSfDw9WQ9CE=; b=ohvHfRHyVP0R4oaKFk7SsZ
 yw3kMfQ8TNPmCPUBJdtDVDjLyqCsJStqo+fHYMJVELXfybhFRBcHVU2PYMULt0eS
 QQdrRo5+qM1jcmZhc0anHB7NZi+FW9xHfjCrvM3cPwLsZTMrTUUTetRBdvzSaVwx
 2VHWCacomeIbX6oXMLIh+zYJfFFHCH7S5D7m5TT2IxoVtBEhuIaDZwWJ+4JZYZ9r
 yML0AFAiW+oeHe//8ibJU3UaUHJQ4hpT9n8/9X8EYMsuyshk7+EOYopfhX6jMdmy
 Gf65v3nY0pZpcaW9vQxkH9hfmyGJUYP64ZTEz5E+P4lua0/mMXWY/C2hqc23HC/w
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxu4kc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 21:13:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GL4bVm012529;
 Thu, 16 Jul 2026 21:13:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qf2h5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 21:13:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GLDgZd49480090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 21:13:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45AAC2004B;
 Thu, 16 Jul 2026 21:13:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E955320040;
 Thu, 16 Jul 2026 21:13:41 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.65.221])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 21:13:41 +0000 (GMT)
Message-ID: <b18f0a7a-d0c4-4166-b88e-bd871b5e5ff2@linux.ibm.com>
Date: Thu, 16 Jul 2026 23:13:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/51] exec/breakpoint: Merge CPUBreakpoint and
 CPUWatchpoint
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-26-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: NgEgFfJz5Bvy7ISvezU1KTm-WMWxXQfA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIxNiBTYWx0ZWRfXw/j6kslvhzwd
 zgzXsCP/TwEpdZ8H+O5ps64ysLXbHyu2MphU76cl7/9TPpNJE1RE36GjT+7unCwoFyzgvKoiEjs
 2MN19PxAtqDu2pfu/0qBvrHj00VAxlk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxNiBTYWx0ZWRfX+11viB9vc3rJ
 SwKpkc2179gxi89ScSJasUw+1rnqPlFK3bzj1qZhfxMZctvrT2EJEWwkVgTPJsb1ju6cwFcDmW8
 TdWpPsRO4JbJpYg0vpmUmcTHF0SWfVA4w/Yhz5ayT1Rgs8vdjUPBnDpsMuL0E2kaIraDzYQv9lt
 9K+m4iGGj7r5bTkacREJLSKgvm5S+VfnVWKvxil3oYBXJKw83TLzBoEum3UtzjUWye4TgXdGm8f
 F6Ntpg8PuSLPO32aaagBhHmzkDPeVK00I5im2xJWj6wHpBxFj5G8yiQuCM6cw76G+jrT9wPKzZ8
 sGJ+xn6GeCMMXrWSDMKAytWiB5YnNDdG2BPwBGn7DZuwiNspw89QlkwCPOYHXuM3F/dKUnUKGrH
 sxtYdeQSJKiklXasgcb4qTU+p921D0SBBJCs2/19MmgOgLLMFhre0wd7wtcML//8k5FMQ8qgFV9
 fFT6YBYkM6Hs+t2RIQA==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a594989 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=7c5n3m91VUN4t1GCEA0A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ANQFxZX6v_1ZWtRNGLDVI9CWUj1UzJ24
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160216
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
> Drop the CPUBreakpoint structure and rename
> CPUWatchpoint to CPUBreakpoint.
> 
> Mechanical change to adjust all uses.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h  |  2 +-
>   include/exec/breakpoint.h    | 10 ++--------
>   include/hw/core/cpu.h        |  2 +-
>   include/qemu/typedefs.h      |  1 -
>   target/arm/cpu.h             |  2 +-
>   target/arm/internals.h       |  8 ++++----
>   target/i386/cpu.h            |  2 +-
>   target/ppc/cpu.h             |  2 +-
>   target/ppc/internal.h        |  2 +-
>   target/riscv/cpu.h           |  2 +-
>   target/riscv/debug.h         |  2 +-
>   target/xtensa/cpu.h          |  2 +-
>   accel/tcg/cpu-exec.c         |  2 +-
>   accel/tcg/user-exec-stub.c   |  4 ++--
>   accel/tcg/watchpoint.c       |  8 ++++----
>   system/watchpoint.c          | 12 ++++++------
>   target/arm/hvf/hvf.c         |  2 +-
>   target/arm/hyp_gdbstub.c     |  2 +-
>   target/arm/kvm.c             |  2 +-
>   target/arm/tcg/debug.c       |  4 ++--
>   target/i386/kvm/kvm.c        |  2 +-
>   target/ppc/kvm.c             |  2 +-
>   target/ppc/tcg-excp_helper.c |  2 +-
>   target/riscv/debug.c         |  4 ++--
>   target/s390x/kvm/kvm.c       |  2 +-
>   target/s390x/tcg/debug.c     |  2 +-
>   26 files changed, 40 insertions(+), 47 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


