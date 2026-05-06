Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980ADCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 20:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKiem-0006nu-K5; Wed, 06 May 2026 16:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wKieX-0006jx-23; Wed, 06 May 2026 16:15:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wKieV-00068y-Bq; Wed, 06 May 2026 16:15:28 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646C2h1S3012905; Wed, 6 May 2026 20:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5dhNaU
 q8//GqCG5LY7aD2wrZBqXEhDx2mFaQjguoDqo=; b=GA70t9oYQzBZF/tzeKqA93
 97EvjLWJ5hqpm2W6g7Lv8G9RJXDvtNUapHreK1qNaWO8WPchP4kUR0RnqO6IzvxS
 bxQrvvzjVDETPjY4e/yDPR1sswkOn+6jLvshZ0b2QaGibcxHEXSxOjX+/Ii55CjP
 pwJjje9CdZwNdBgESWtb5D2q/EVMRhsfX/sUbc9GQ+zqXMCk8mzaXldV+tRT/saW
 nRJPKEEViUcaxx0cdF+X9D0ijBdu4N5TwWLGnpE2V0VC91Vrmgb4vxZ0bW9+jbxF
 RnmkCVXRqYJfNj7QLr6mrxxbN073mpMdZ0wXkY1KqZ09aiKYAJ1oZcF7iFQ/yPLA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4sua9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 20:15:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646Jsat4015986;
 Wed, 6 May 2026 20:15:23 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw7xfg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 20:15:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 646KFLdW62521852
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 May 2026 20:15:21 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86D265805B;
 Wed,  6 May 2026 20:15:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACA5D58058;
 Wed,  6 May 2026 20:15:20 +0000 (GMT)
Received: from [9.61.255.243] (unknown [9.61.255.243])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 May 2026 20:15:20 +0000 (GMT)
Message-ID: <20d06898-95fc-4e6c-9c92-6de8e9f7f68f@linux.ibm.com>
Date: Wed, 6 May 2026 13:15:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Fix memory leaks after removing elements with
 QTAILQ_REMOVE
To: Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
References: <20260506174135.2630613-1-thuth@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260506174135.2630613-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE5NyBTYWx0ZWRfX0NL/p8Cg1Zpj
 M6p6d6m+YJ/fJe77bERLX2ozgmsZVTdZnDlBo2HdH5aDrWVO0E8gHaQpr/xhtfmh5DJlqNYQ+Mh
 ZCbBIY+/Qf2b98fcNEeAnJ26itCM9e7LJx19apHgORNZMDrsJVhyT1eTySGsQLDlkE7XRdU5m0V
 bydlZdY9kQxIKAijFlKcshTV6TGvp+DpVnpAvP77X+A21y+g4dI7TM/kPHj4AHB1pC8hL2sbb2M
 o6PmiSnHCx+K0qXP9MBt7sPZ/574025ZypcXmT/u6eFQyDEdpUW4OlINCfLDfBp6l38XhwD0jci
 HIc4ZG8ZVkFX5k97W6T0tFC3xmcsQS+59jMyoxptFlIpzZ4oSdmsHPAUUWlUJ/jQjv+jHnOdcse
 MyrHrbqiOvF0n5mbPFY86QdZSXuNMKbvDIcn710hVG6gPbmvE+hz0CUozNdF2dm47z6+fQP+V5r
 Wnn8knf37E9tA+QDfBg==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fba15b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=Nx961GGavPmN8L6er0kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SNM5t0_YQpi0jcHDqn3QwR-DyxL_Ccuo
X-Proofpoint-ORIG-GUID: SNM5t0_YQpi0jcHDqn3QwR-DyxL_Ccuo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060197
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 5/6/2026 10:41 AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>
> The elements that get removed with QTAILQ_REMOVE are never referenced
> afterwards anymore, so the corresponding memory should get freed.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-pci-bus.c  | 1 +
>   hw/s390x/s390-pci-vfio.c | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 4de7b587e8a..d45e08a69fd 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -911,6 +911,7 @@ static void s390_pcihost_unrealize(DeviceState *dev)
>       while (!QTAILQ_EMPTY(&s->zpci_groups)) {
>           group = QTAILQ_FIRST(&s->zpci_groups);
>           QTAILQ_REMOVE(&s->zpci_groups, group, link);
> +        g_free(group);
>       }
>   }
>   
> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> index 7c754b656da..db6de00bd28 100644
> --- a/hw/s390x/s390-pci-vfio.c
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -101,6 +101,7 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
>       cnt->users--;
>       if (cnt->users == 0) {
>           QTAILQ_REMOVE(&s->zpci_dma_limit, cnt, link);
> +        g_free(cnt);
>       }
>   }
>   

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



