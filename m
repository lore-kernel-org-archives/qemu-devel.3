Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244F4C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4MUU-0007ao-S7; Wed, 09 Sep 2026 13:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x4MUS-0007Zj-E5; Wed, 09 Sep 2026 13:53:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x4MUQ-00044X-OQ; Wed, 09 Sep 2026 13:53:44 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689HVZ3p307733; Wed, 9 Sep 2026 17:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VCEsCZ
 qN9ugYd/9ws763/TczK20n91+Mmr7Wvotf0es=; b=hzfOn0ASrk37rDVFbh67EB
 RlCalaLAUy1SW+tUynUmN4aiEHYy42roO4xThLDIpbSjF9qmuURAO32fmKFdkB1u
 Cw+tptatYvDxVlxdkmeeTeosqXjgk56rkZYrLTC2vHSkBa/gDdtWLhfuMZTVXJk0
 InQA+b9VrtyZD/xOInPraPeUyuC9o6vqEKXL4Swkk98THsZf6GxHb2qj+MLNR5Nr
 SNvz5S3fqYZbLGiHyAnOpVXtkZpBJffZG+3/35eniUjMGHMaFObLX9JAlEyjbmts
 t+cs+c77LuQc0ep7SZR29SLM9uUSXMb1Mean+aj3fW6hQWQkY5ST+zCwXKOKwe7w
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj8f5f9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 17:53:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689HfFNv001666;
 Wed, 9 Sep 2026 17:53:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymgkjtg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 17:53:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 689Hqu793998382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Sep 2026 17:52:56 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80AFF58065;
 Wed,  9 Sep 2026 17:53:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E4EE58066;
 Wed,  9 Sep 2026 17:53:37 +0000 (GMT)
Received: from [9.61.48.189] (unknown [9.61.48.189])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  9 Sep 2026 17:53:36 +0000 (GMT)
Message-ID: <e349d8fe-d460-4069-b3aa-14d23ac53d73@linux.ibm.com>
Date: Wed, 9 Sep 2026 09:30:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] hw/virtio: Add "loadparm" property to virtio net
 PCI devices booting on s390x
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 jdaley@linux.ibm.com, pbonzini@redhat.com
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
 <20260903162449.2588271-6-zycai@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260903162449.2588271-6-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eL8X_xczHQsaPfgSj5lTT3DCosbHK9ED
X-Proofpoint-ORIG-GUID: eL8X_xczHQsaPfgSj5lTT3DCosbHK9ED
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6aa19d25 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=qN506RqINZ981zxnCPAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE5NSBTYWx0ZWRfX6T0cq57UMfE3
 XDog76sxWXMHzodWeaABTt7ADGuRo/SARvIV8F6Il7Qzdvv3uk2IYSERI+71pKipFGGHtf5O+9Z
 BGdcZpLaeyHG49170ufy/ZTY2/jCohY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE5NSBTYWx0ZWRfX9F+5lJre9Fb1
 A7saGuZzPgSuiKkFtqqA2uYDY8Ps715UcA2jhQicZcPtlTSBrSv0UXEJ/Xa+MMhRUti+LGrPuPp
 IWYMyd9kOowqdVdf15KmRIgbpi2hF7FcAKaYTY1MvedQD+nJwRic/lCtpwViqELTsSesr5jHTjg
 +Vp94NwJNYeWRAM9bBvOEUiCJ4fraO1Y0R41fHxYigKUjpFxCrgt8W6d0m8aDA/Mk9S6zFIp69o
 0Y+ozjeR/Ih5RacVTLiKLwhN9MewUquG6HSo2blxJaWB7Ry5LwgpahEXWSat/K4WRkPpC2xuoKz
 wayhd8gsqa+t/L70ACIlG2XewLijQ25pj9O3FGYHqKGSn7dzSGLEtPjboX8oUiSNFBpMm1w47IC
 e2owsY9zNFDL1xcydKmtOzwFda4nudRThSLs9fLFCRzlt0iNPMjqZNphzcgPqiUHTjv8wGyQvzp
 p1M/XRbFYMjJl/C5XZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jjherne@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 9/3/26 12:24 PM, Zhuoying Cai wrote:
> Add optional loadparm property to virtio-net-pci to allow boot entry
> selection on s390x, consistent with virtio-blk-pci.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   hw/virtio/virtio-net-pci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
> index fd3e0303f5..893d1905a9 100644
> --- a/hw/virtio/virtio-net-pci.c
> +++ b/hw/virtio/virtio-net-pci.c
> @@ -77,6 +77,7 @@ static void virtio_net_pci_class_init(ObjectClass *klass, const void *data)
>       k->sriov_vf_user_creatable = true;
>       set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
>       device_class_set_props(dc, virtio_net_properties);
> +    pci_qdev_property_add_specifics(dc);
>       vpciklass->realize = virtio_net_pci_realize;
>   }
>   

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

