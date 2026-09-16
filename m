Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4468C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6yqn-00086z-Nl; Wed, 16 Sep 2026 19:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yqj-00086R-3j; Wed, 16 Sep 2026 19:15:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yqh-0002eu-GK; Wed, 16 Sep 2026 19:15:32 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1cgc2330021; Wed, 16 Sep 2026 23:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rz8GKn
 Pd1nx89rdlmESLj0UbOBVwUJ4WLvcKWcLkeOs=; b=sylz4TvveBKmrAPcwerRGM
 qlmmHPg30kUZpaMnC6uO/u3i7ZCOs+TU14YXyVYRB9dVsqm493qpeWyKO4z/dJXD
 JUfUwOrLWuAYZB+1+KVP0aqT1TBCnx+GzqmWA32WwOkP7AnFLB3fjLXoWv3s6Acj
 hplAp+igh+SkRC+8CyolfQktK5WZI7W3S7L+VyX1rPBOhDdbl6UdZvXBQTf1T1PP
 oNLYODNV0ICj4g+daqkEUEVzVB3xqmbOxwI6ZoURtBTzeYdS6/MU/Ln1sxCWZ2kx
 m1JhXJj8fEFKNs7B7tfAzdHfxWOtvysqGYFlwPPJkVDw9Q9MVJ0lNiXfoWeV3ztQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqfds8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:15:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GMrtNe2599742; Wed, 16 Sep 2026 23:15:28 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpw6d9eu3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:15:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GNFRcv3473944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 23:15:27 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E19058054;
 Wed, 16 Sep 2026 23:15:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F09158045;
 Wed, 16 Sep 2026 23:15:26 +0000 (GMT)
Received: from [9.61.177.109] (unknown [9.61.177.109])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Sep 2026 23:15:26 +0000 (GMT)
Message-ID: <09ef9c95-1114-4bb4-aea6-e556eb6725be@linux.ibm.com>
Date: Wed, 16 Sep 2026 19:15:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] vfio/ap: Clear error object pointer after non-fatal
 errors
To: Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Anthony Krowiak <akrowiak@linux.ibm.com>,
 qemu-stable@nongnu.org
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-5-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260916203242.2509787-5-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX+I1Amn/barbB
 MjNtAJ63ITvdx0JRKf+omZRC2bU/8WbW6v3ny11C7cmY/RnyDHctDKNcp89pEwvnskAIVIbielf
 oa+425n1x8o1XTLzuHB4W3qwWiXjFgcc+SeMrLsKaHZ8HZ0ovyD50g5xWRzzdWeEIDrQoPM91vw
 wA4kUBcSEsAIEZMBxB8h5sMsQ0L65rC5ipHUl9melcd6cgE8Vy7uQUJq3/kGRqgqaHLO4oeMquV
 1ubkW8cZZQR5Pt1jzV7+8dNBsUX4BR1hNeMqHfGri8X5GPUCq4e9hSWc+Ia/8wbp1/vaEquzay7
 YtzbpX1rIMHaViS5i3KrxkbOm2c9WZbG0G6a5vAmImhuEw71VfF0fbimLQ6Uiu2vz0/O10EKRPa
 jQ3HRR7Gyuz/lUZpaz9ISqWhLipfFvpJChtnzbOI5kWTssUB5Ct4nVoscR0e4PhDmVEBGYoRTRo
 1THfbQbYE6/9f+BKA8A==
X-Proofpoint-GUID: sXsEaRfftvfWFIa1Ek-24k62SvyXw4Cb
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aab2311 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=N8LUZ6RLmRbKLffE-xMA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: sXsEaRfftvfWFIa1Ek-24k62SvyXw4Cb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX5r9MB5FHfqKw
 W3xlBaLwSl2cmBy27c/6rOtG1Q0Vb+lkQN/wL13iTKwy3vBclXNtddheqR4USdvA85EBXWY39B9
 tUmH+UjJ4eTJLJ+rG4e57SWaiXVkX1Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160322
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 9/16/26 4:32 PM, Eric Farman wrote:
> Registering a new IRQ notifier will allocate an error object if needed,
> and warn_report_err() will release that memory once it's finished.
> The pointer remains, however, so subsequent errors after the non-fatal
> errors in vfio_ap_realize() would cause an assertion failure for a
> non-NULL pointer.
> 
> Fix this by clearing the pointer once the warning has been reported,
> to reset the state of the error objects.
> 
> Cc: Anthony Krowiak <akrowiak@linux.ibm.com>
> Cc: qemu-stable@nongnu.org
> Fixes: 1360b2ad1f ("s390x/ap: Wire up the device request notifier interface")
> Fixes: 0fb8a62fe4 ("hw/vfio/ap: notification handler for AP config changed event")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  hw/vfio/ap.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 6e2a1223ea..2926e04ad4 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -247,8 +247,10 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>          /*
>           * Report this error, but do not make it a failing condition.
>           * Lack of this IRQ in the host does not prevent normal operation.
> +         * Clear the pointer, since the warning will release it.
>           */
>          warn_report_err(err);
> +        err = NULL;
>      }
>  
>      if (!vfio_ap_register_irq_notifier(vapdev, VFIO_AP_CFG_CHG_IRQ_INDEX, &err))
> @@ -256,8 +258,10 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>          /*
>           * Report this error, but do not make it a failing condition.
>           * Lack of this IRQ in the host does not prevent normal operation.
> +         * Clear the pointer, since the warning will release it.
>           */
>          warn_report_err(err);
> +        err = NULL;

Technically this one is unnecessary since we're about to return, but I
like it for future-proofing:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



