Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6CBD58E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 06:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwwWy-0005LJ-JT; Mon, 02 Mar 2026 01:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vwwWw-0005Jw-Ai; Mon, 02 Mar 2026 01:13:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vwwWu-0004gs-3r; Mon, 02 Mar 2026 01:13:22 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 621NekOi2154446; Mon, 2 Mar 2026 06:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gu3czR
 7+YNpKvYpfUZ6PTkcLRk1kiXduPQ8soYpquF8=; b=bcWacR5aoN2dNFx5ck+Kqe
 wI6Hz/pS+FKuWJrhUJappnC32FRQostVQE8MbUNn8UkV1wrjvWu7f8XuZDBCkfDF
 bmWvGmgOwJ0jRY5uP39BpLI9vRHFUuAo/DOUgXEgvbtwuVoB9zf5uNj9awDvWjR9
 elzCkWh1n568r6XbJu3fUcnBEsvEwOLGOJSLmKBRjjsS+agHSPT75SwNDha+2f4z
 fwbSqFDsOiJeO6oFspWUXy9hglPyRuaoe+M8IZiNSQg5pbEffszrTQwwQkompnjo
 ByTwD3BiXZnGAkBjkWCISFM3Kkbh6wj0SeWD8DaS6AklkhY1YTqkHdyaKoPI9gzQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbmydh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 06:13:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6225a2rm016384;
 Mon, 2 Mar 2026 06:13:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmbpmvhwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 06:13:17 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6226DGB125494042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Mar 2026 06:13:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A5D558065;
 Mon,  2 Mar 2026 06:13:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8363D58055;
 Mon,  2 Mar 2026 06:13:14 +0000 (GMT)
Received: from [9.124.211.120] (unknown [9.124.211.120])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Mar 2026 06:13:14 +0000 (GMT)
Message-ID: <78551801-d949-425b-a436-c6310e47223e@linux.ibm.com>
Date: Mon, 2 Mar 2026 11:43:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add self as reviewer for PowerPC TCG
Content-Language: en-GB
To: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: rathc@linux.ibm.com
References: <20260225162118.914008-1-milesg@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260225162118.914008-1-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: minR9nw6sGY0Uo769-X54xznG8NyPuO3
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a52a7e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=dWE89HiImbqLqgQUz2IA:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA1MiBTYWx0ZWRfX+FfxyOBQidO/
 XvIYUpvOiKR3cf91ECPPov/xeJ4sXqwjL/UpDhKwtBt6/Qvq42gOvD5nn5TN2+4O3z0G/zvl2kD
 FDZu/5srOBbpsSObNb1uoXWfmyaIOvGOk3PHz0ChPzpfteoRoCoAD8G5RKaWcHDgF2PmnsbUPib
 yWvXb9WW+UKpl5+Ki5pgVJk2F/Q5TTd038u7W/qAUv4whyT8fo1boyOeulYBGOCW1DwB8T9KpBl
 gP0XRSvDOqwS+FqZYKrl4ra63rrIVJagdzbQFnVd2mSALJIh821xKBPp3uhU99k5BiFd0GRw9ny
 tiM2zlaqW0/Mua9yAE14zdi6PYmI36UA6wL0qOlKFir0jiKt9ZWYpFh9FdOPoELGvWd1B/OeSbG
 xcR9pnNtmRLTPfDxNXAV5S83/l0TiRny7PaYYH6Gr9dMF1bzwHTQooypQj0rGtfqaJIsprEA/KX
 muIHLSxoXkqYqCwUDlQ==
X-Proofpoint-GUID: minR9nw6sGY0Uo769-X54xznG8NyPuO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020052
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 25/02/26 9:51 pm, Glenn Miles wrote:
> Added myself as a reviewer for PowerPC TCG
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 233d2a5e71..7aa8516d69 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -312,6 +312,7 @@ F: tests/tcg/or1k/
>   PowerPC TCG CPUs
>   M: Nicholas Piggin <npiggin@gmail.com>
>   R: Chinmay Rath <rathc@linux.ibm.com>
> +R: Glenn Miles <milesg@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: target/ppc/

Queued.

