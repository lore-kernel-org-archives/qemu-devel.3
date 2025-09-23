Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBC4CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 11:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v11fQ-00036H-3M; Tue, 23 Sep 2025 07:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1v11fI-00035K-Q7; Tue, 23 Sep 2025 07:58:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1v11f9-0002qe-5q; Tue, 23 Sep 2025 07:58:36 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N7W6i2000347;
 Tue, 23 Sep 2025 11:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=phO2wD
 Ds7qCgTaPE8vy6eb1BG9ediV3iBpzjEFndvDE=; b=BkuLmIRiN8i0olvY+J7SUC
 BW++jIXShkagx5In1kWLVzi/5Dv3LX7zyxod8NdHW+BJYPIAeaMrkvsYTz2gclRw
 D0BYrGsxEFaOKX8mnGmdM1u5JpwMXzbEx92S4X5gC8Qrw6r8NlvoAg9VZ2Z3n4bR
 lAyz4k5h5h8ScffJOAVCAkSnyGkwOQDd10vil8L9RH9VY49JAxViapc+zkygrDqG
 7lxEm6di+raxxOALZ4ysEHOj5HmzdGLfes3msGfj5ZaakxYNLBf/ItDzWhzcnzl5
 rfPSbPfvZ8Sh/ZcMdIfc2GxNEKKXKCpO2dOhFTXN1wF5PmcPvTQCl2DyzZqdjQSw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksbrwtq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 11:58:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58N9AdwK018464;
 Tue, 23 Sep 2025 11:58:11 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a7kmk6t8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 11:58:11 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58NBwAjL29164218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Sep 2025 11:58:10 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3F4658045;
 Tue, 23 Sep 2025 11:58:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54F6E58050;
 Tue, 23 Sep 2025 11:58:06 +0000 (GMT)
Received: from [9.61.250.51] (unknown [9.61.250.51])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Sep 2025 11:58:06 +0000 (GMT)
Message-ID: <d88cf6bc-16d5-4263-ae7a-da09b051bc70@linux.ibm.com>
Date: Tue, 23 Sep 2025 17:28:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: fix potential shift overflow by using 64-bit
 constant
To: Denis Rastyogin <gerben@altlinux.org>
References: <20250722101721.16458-1-gerben@altlinux.org>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, anushree.mathur@linux.ibm.com
In-Reply-To: <20250722101721.16458-1-gerben@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qAKyoj9ZglzjdNBUrtlf_Y2J4uU8zOqp
X-Proofpoint-GUID: qAKyoj9ZglzjdNBUrtlf_Y2J4uU8zOqp
X-Authority-Analysis: v=2.4 cv=SdH3duRu c=1 sm=1 tr=0 ts=68d28b54 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=HH5vDtPzAAAA:8 a=bH78PYQqAAAA:8
 a=VnNF1IyMAAAA:8 a=sCpkdgFk9pa2aazyWyYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=QM_-zKB-Ew0MsOlNKMB5:22 a=TrXR8j8ql9YpJ1_1srv2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX7w/PAvz15E95
 Amkzu8DZPoshW9XJVREvSDAY+/QyotIsOJ+GLKMoYhnYgMdO3oltaNfDCaRCCi7eyUMvlWnvIKL
 Mu+jwW5xonHjOT/cUldgOnul70wERF70bfX8DbRoj0vNjNqzinRTjDz4vZg/NRje0LZiSpA/+q2
 JZk5kRRBrXqgQzcVCUzRnMtn/4gSpl6pGtSVn7HmNPCOaRJ7LhVsmWxLp9nXww+7wx5Q7DpW1bh
 kaCrkPjAkf2+TPHUHmjhC31fvBwFm9qMf4MCJ6af4g4wSzwqDNxzuwZPBuApfejqukkWgc1nIzH
 dLVCMOIxxJsrXu8D1tMG7Tmz9ybVSFAPOGR2Hge9ttBkKkMJ9/3L3df0JtovajPMu5EZ4UYCv2J
 LnGA4K7/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 22/07/25 3:46 PM, Denis Rastyogin wrote:
> Change shift operand from 32-bit literal `1` to 64-bit `1ULL` to avoid undefined behavior
> when shifting bits beyond the width of a 32-bit integer.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>   target/ppc/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 27f90c3cc5..8e69c4cb48 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2998,7 +2998,7 @@ static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
>   
>       /* RT = (t != t2 ? t : u = 1<<(s*8-1)) */
>       tcg_gen_movcond_tl(cond, cpu_gpr[rD(ctx->opcode)], t, t2, t,
> -                       tcg_constant_tl(1 << (memop_size(memop) * 8 - 1)));
> +                       tcg_constant_tl(1ULL << (memop_size(memop) * 8 - 1)));
>   }
>   
>   static void gen_ld_atomic(DisasContext *ctx, MemOp memop)
Hi Denis,
  I have tested this by applying the patch and bringing up the guest
in tcg mode and it worked perfectly fine.

Qemu commandline used:

./qemu-system-ppc64 -name test -smp 8 -m 10G -vga none -nographic -accel 
tcg,thread=multi -device virtio-scsi-pci -drive 
file=/home/anu_new.qcow2,if=none,format=qcow2,id=hd0 -device 
scsi-hd,drive=hd0 -boot c

Came to the login prompt:

localhost login:

Tried running basic commands too on the guest, everything worked fine.

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>

Thanks,
Anushree Mathur

