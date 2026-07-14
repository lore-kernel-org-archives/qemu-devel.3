Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07CCC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjc7G-0000ci-Er; Tue, 14 Jul 2026 08:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjc7F-0000bd-2J; Tue, 14 Jul 2026 08:20:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjc7D-0003Kz-Hg; Tue, 14 Jul 2026 08:20:00 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EBgSNQ1129823; Tue, 14 Jul 2026 12:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tZUa2S
 ZJ4u9IBdHN+/4sVARAIrrl3FZztpNELo5LBtI=; b=W1AYEmyvhcw1zLMZyeT8LI
 P2N47SkqXYJUHPIlzTLrAEUgZNxGAZywuyfzSse2G+NWxEaGuZckqUtLz8v82dKD
 qwbphV+BfBO3Xvpy2hc+xq9Z+seeUxC7yV4Hbr8ro/+o/HiAb9ZP9VC6o1rTibMP
 92U3ef/tzyF+07TXdTJHwyxL6PEgQ4MRVqVCNBfE/NtYmL/3dnpIv83YoDE4JToX
 45sW+lRuh+rZcHb1qkqXPqhMBmv+1k9kkob1irgBhGyaLn2glE51DikhTBvYEqur
 SQhVJiY5jLZB5BpC5kA7M4+F3nSdDgoK8IlM9wRYA/j1xjUQyIm8Z4tw9pheKwBg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwngwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:19:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ECJdt8011095;
 Tue, 14 Jul 2026 12:19:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgafs8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:19:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ECJrMj44106090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 12:19:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C676D2004E;
 Tue, 14 Jul 2026 12:19:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 831B72004B;
 Tue, 14 Jul 2026 12:19:53 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 12:19:53 +0000 (GMT)
Message-ID: <b870bb0d-a250-4205-a98a-19ace8a7a112@linux.ibm.com>
Date: Tue, 14 Jul 2026 14:19:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/51] hw/core/cpu: Remove exec/breakpoint.h include
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-6-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: N4Z4IC_45wKutS98Bwh-j1lMBWQ6pC7X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfX2wzej4iQ7KyG
 6unmHQRXYcmAWBfgvxoEvsn2Mal1T4ADpZMeIFW4+zGxAyqCDgPiOPh0dAN+7Y+gJeq59odfher
 h7LwFkMl5u4g4SJL8VkI27BFdxH5/3MReBKW1M2WlLv2Qc6cRtCRnIbV0CZaZ1M+Mm6G1dWSPhS
 7AnAITDF7jshQdnnviIIDVv+qaX894lnXWBCzbgDk+NvBXupnkdTarrYRycR8TAAbvvC/x+XWqt
 LWEkm22p1WK67bHUSJLR8zpkv7rn/kHsRjmfPqsSStnj9rFhmgYDW6eH+14qyH7uy+Sxhu0+CdG
 s3pTrECWITUqQuBOT9g2U9qAjgCmZfSMeXvMStR8PeRgrvcjA8GGquWdkdxQz7fyL4bSqTuwfmq
 vsu7yrCCx3KNyQpZJc2WWIyIr9FtDZlkdoNxn35x6+L3ke8LeT1d168QDoREm8RXe7bN5vXExM8
 At20itz819dmQgqKKKQ==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a56296c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=5LDmkNhjwu5g9ayeu9AA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: KPuAc_6kOxVl8nIAVrXGcPj6tdj7nEkM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyNyBTYWx0ZWRfXw6HSnMX526N5
 6xqhsa8U3So7IMQGs2ln/s8E9bRo1bCpiiNfiFdSNZZD1LYrZoBp91zMm2nDKE/em2aU48hXjpZ
 I6ZpMHbULT629psOTfjbHV8Acw5BpVI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140127
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
> This is no longer required in the generic header.  Add includes
> where required elsewhere in the code base.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h     | 1 -
>   accel/tcg/tcg-accel-ops.c | 1 +
>   cpu-common.c              | 1 +
>   gdbstub/system.c          | 1 +
>   gdbstub/user.c            | 1 +
>   target/i386/kvm/kvm.c     | 1 +
>   target/ppc/kvm.c          | 1 +
>   target/s390x/kvm/kvm.c    | 1 +
>   target/xtensa/helper.c    | 1 +
>   9 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Ilya Leoskevich <iii@linux.ibm.com>


