Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9D8C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x76eO-0004l7-5y; Thu, 17 Sep 2026 03:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x76eJ-0004kf-8k; Thu, 17 Sep 2026 03:35:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x76eH-00042i-BN; Thu, 17 Sep 2026 03:35:14 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H61dps4025533; Thu, 17 Sep 2026 07:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=U3TZ5x
 h7I9+1Db/3h5FhAHITJhm7yk3kBWDEOqUIcsM=; b=H1eTtvYs5kHf8TWBJJ/KPR
 c6OraCCdvLFcAO23hmA+L5s6hNVXr6JbXJMVaIQnqehBzowPA4Dfx/05piSGmN4o
 sxqjNGZrXo4C1gmfujbdBt7YZRW+mlAhhjxDJBIr1stE6UFgmqjv1zoY+AF7442D
 56nLPeJvr7Qlhf47ZG1PmKqBBsxbMkOjNLXOZCtC7Tv3NURkfNT1hGixPudsupbx
 boNOjQuFqIPDfiLQd2LiSD9IVkzg6yvetibFsx9gWkg4JreFmvzt50waiqXZA5Fy
 SmA69MDbLVa7OMi6JvFOV/73Ps2pWxvt4aXpaeo/950K/hII1sU0g4nF2RGFo6uw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqh10g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 07:35:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H653bw2678206; Thu, 17 Sep 2026 07:35:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa18gw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 07:35:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68H7Z3qU45547842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 07:35:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 938F620043;
 Thu, 17 Sep 2026 07:35:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45E4E20040;
 Thu, 17 Sep 2026 07:35:03 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 07:35:03 +0000 (GMT)
Message-ID: <cbb1f499-7776-4066-9b96-3071cc0406d9@linux.ibm.com>
Date: Thu, 17 Sep 2026 09:35:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] virtio-ccw: Do not overwrite existing indicators
To: Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-3-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260916203242.2509787-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwMSBTYWx0ZWRfXzB61duluMCQf
 IXdLMGcnGmUFPsl5eizFk0KZPJ7JlsWl+scNXRpJ3ijPSyDdQz6sjMIQcpX5vS9atT7ijcT2Xfq
 6UCP3zo9LY50oUKaOxJswBvPUD8ao7Y71uXS+DO3ennV9uO+F1EKuBgr6b5ooH2nyseNodMJsqV
 zV4wc3kPPPYhfVY8b2HS/GhySIzoVxbG8BdjLQhzdnqvNK0NG7n0gf8jB9Vbn4L0VhoaKYg3q8k
 Jc4QgX/3CuO0Y48UnUnwoJnL/MANYToHGJXlnEQLHHOmVJX5XMjKXSIPywZfFLMASbOyRvKPfG6
 Gq4xJ3P+l3svA7IH0MljEKpfLThhZI6ZZIiuOZHGSUJeem13v1tAa3/AftkKprSE2EMLqeAnbdZ
 n0DtlyyUvyRuTIH2B7fgrUFqAyABf2Dz0iiZi8VAkSz5v7BCjLgKZuWI28vp5w/ts0/4N3KkHBa
 7L4gsKZck5ZnZS7C/JQ==
X-Proofpoint-GUID: -Az5PpA8d_60Z_s0fGUZHe_usuPNsnU_
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aab982c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=cEUPhHmS8o58IKH7ITkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -Az5PpA8d_60Z_s0fGUZHe_usuPNsnU_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwMSBTYWx0ZWRfX3rC/JKxlE7hm
 +ysk+SULUKd+hVrQzegoq7UWop/aqSmTFCqzfUFORXJbL6SSJ3T3CigAGzFKHmM44Le1PC1oqR8
 u224po7Znhws0n5TFmZoGoK87gu+E8M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170101
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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



Am 16.09.26 um 22:32 schrieb Eric Farman:
> The various indicators pointers allow them to be overwritten,
> but leak any existing structs that might be there. The adapter
> indicators path checks that it isn't converting from regular
> to thin interrupts, but a check in the reverse direction isn't
> performed.
> 
> Rather than unwinding the existing allocations to allow additional
> assignments, just reject these duplicates.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   hw/s390x/virtio-ccw.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index eb6378ea4c..d700db405b 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -565,6 +565,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>               ret = -EINVAL;
>               break;
>           }
> +        if (dev->indicators) {
> +            /* Do not set without un-setting first */
> +            ret = -ENOSYS;
> +            break;
> +        }
>           if (sch->thinint_active) {
>               /* Trigger a command reject. */
>               ret = -ENOSYS;
> @@ -599,6 +604,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>               ret = -EINVAL;
>               break;
>           }
> +        if (dev->indicators2) {
> +            /* Do not set without un-setting first */
> +            ret = -ENOSYS;
> +            break;
> +        }
>           if (!ccw.cda) {
>               ret = -EFAULT;
>           } else {
> @@ -657,7 +667,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>           }
>           if (!ccw.cda) {
>               ret = -EFAULT;
> -        } else if (dev->indicators && !sch->thinint_active) {
> +        } else if (dev->indicators || dev->summary_indicator) {
>               /* Trigger a command reject. */
>               ret = -ENOSYS;
>           } else {

I think we have to do the full unwind.
The Linux driver deregisters indicators by issuing SET_IND with address 0,
or SET_IND_ADAPTER with device indicator 0. The virtio drivers reset the
device before del_vqs, so the deregistration lands on a clean state and
QEMU records an indicator at address 0. A later rebind or module reload
does not reset again, so the next SET_IND_ADAPTER and the SET_IND fallback
are both rejected and the probe fails. The old condition on SET_IND_ADAPTER
existed precisely to let the deregistration through while thinint is active.
The fix should release the existing indicator before overwriting, or treat
address 0 as deregistration. Releasing before overwriting also handles the
find_vqs error path in the guest, which deregisters without a reset in between.

