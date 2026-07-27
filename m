Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A16C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woMsR-0006qm-OU; Mon, 27 Jul 2026 11:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1woMsQ-0006qY-2Y; Mon, 27 Jul 2026 11:04:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1woMsO-0007Gw-Kl; Mon, 27 Jul 2026 11:04:21 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDnOZl2298531; Mon, 27 Jul 2026 15:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UXUCeZ
 ZE2O5H4dzJ3KnJAwNt9hYvLbh2wJM+6s74HtA=; b=LDqrCK/2VoPHbX1IHjd7kk
 6HwaS1Y2+y5JvV4TYYJM86UUj2SaWLUiqCBjSaTe3lm43Vody4HVCRBP/MtebyKR
 v1kmWplnComHSqNgISQXdB3K9wM7Yr+M0LM7cuupsdParn83GzXcOqqIWStn4gAb
 YW7nxF6uFLZsN6tT9z1U0MORC42pfv0YJ3JAjRaPQARRr74dNo+gn5ij1SKsjYRB
 smG7QnMY33zRzgAlnBiwNVnW5D5E+ZpZk2AqSWiayZEOQxFuYwtw39BRaWWIFOtf
 MT/tTACGcUbaEkVnDnk8PqYvqlQuZby3JMvjRXSj994jpqj/AvnXPfSxBjwZ+C1A
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj076m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 15:04:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REuPIu007504;
 Mon, 27 Jul 2026 15:04:15 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xwjfs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 15:04:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66RF4EAu30671464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 15:04:14 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 874BA58052;
 Mon, 27 Jul 2026 15:04:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84DB05805A;
 Mon, 27 Jul 2026 15:04:13 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 15:04:13 +0000 (GMT)
Message-ID: <2ad0edd9-4e63-4edf-b036-ad9ed618d02b@linux.ibm.com>
Date: Mon, 27 Jul 2026 11:04:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] s390x/ipl: validate num_comp against iplb length
 before iterating
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260727115052.24289-1-borntraeger@linux.ibm.com>
 <20260727115052.24289-3-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260727115052.24289-3-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX41+erDOLSsSJ
 dWfX1PHZFbsgmELvomCz5yRjx5mcT3JTBjEXeVa/1xnZYxdwW6dK7jxZPLyRzcRUDkTM1P1L4+4
 7bWEHn/LGx0iOrmEh3v8AnWy5NfqHnA=
X-Proofpoint-GUID: pwolQJzhijxvHgCaGSQXXhsqqHDdjk2S
X-Proofpoint-ORIG-GUID: pwolQJzhijxvHgCaGSQXXhsqqHDdjk2S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX8ABUUV5VLUdO
 6vYobZ9v9ULX7B/4PNklm9pluDZ/+KQ6jGuXe3DKgtjvKov+FHRV1/IyVvHoloLDLx+ze6JSWWs
 c1vAQQ/iXXZ+nHc1LJo1tOWI4KivZH16n7Yk3d7pvBsfl5Vh3MJAzwxaa9uJn0mqyAX0vG9QAnM
 Ee2LtOVCmJtzJ7UiIMOa/Y1mskH2Yjq6NQsZ7oVylB6rKO2avZ2B/Z5FbxuX4IG0773s7cvAknf
 Iv05OTWekPh2DfCK7UwKnQuVXwUcwNJ4nj090WO9qvupIhAHxT/h0+PFn9H9/RV8iqronanNkei
 PmCBrryrVNY2X/MdMZDAdDQgnJopH/7Qmen7azFQNYWiLxhktGq6HHgmA/1ybPnPV69bBItIftT
 UYWTuTpT7aHrcQkoMlz4GAnIOUvczahb4a+V7d2FuGB6SASw9Hk4xlhKRrG56j7M7nmE5tM5Ek3
 ECIcsDFgR2FClCjM20w==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a677370 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=hY-Focd3OprVRNE3PgAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270140
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 7/27/26 7:50 AM, Christian Borntraeger wrote:
> From: Joshua Daley <jdaley@linux.ibm.com>
> 
> In ipl_valid_pv_components(), the upper bound of the for loop,
> ipib_pv->num_comp, is read from guest memory. Before iterating, verify
> that its value will not cause a read beyond the end of the
> IplParameterBlock.
> 
> Fixes: c3347ed0d2ee42a7 ("s390x: protvirt: Support unpack facility")
> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  hw/s390x/ipl.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index fac30763df..ef9c063d90 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -124,6 +124,12 @@ static inline bool ipl_valid_pv_components(IplParameterBlock *iplb)
>          return false;
>      }
>  
> +    if (offsetof(IplParameterBlock, pv.components) +
> +        ipib_pv->num_comp * sizeof(IPLBlockPVComp) >
> +        be32_to_cpu(iplb->len)) {
> +        return false;
> +    }
> +
>      for (i = 0; i < ipib_pv->num_comp; i++) {
>          /* Addr must be 4k aligned */
>          if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {


