Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589FEC982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7BZ8-0005Wv-QV; Thu, 17 Sep 2026 08:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1x7BZ6-0005TK-VT; Thu, 17 Sep 2026 08:50:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1x7BZ3-0003ok-9c; Thu, 17 Sep 2026 08:50:12 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HA1XgS322365; Thu, 17 Sep 2026 12:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=05QlLp
 gU4BdB0oz2LhEfoik151zVn1F+TF4VOO9YTd8=; b=Cs2OvXSHzY9aY+iMw1E+lj
 0yD6lPu0QzHSO+fx2t3X21DmjZXrWGK4r1Bz2IVMuF2Mrk0ftFuxp/yaSasPLR49
 kRT5myHjvHC/o8Dz5KSBHBzs2vAYJIy9o0DWQtp0fJ+LiQ4FOL+VHlT4iN7Rv9cJ
 H4JWSGrnoPEP/eFdsF0Mv0hRQnYhPzI/mwWB7wbpn+a1K9zkmW9EXq/6gDRYJOaP
 jLAFwMmpvAgZ/QKlcWDc4lvR2+LxYCEs7yfq36P6nqxm3AZZIAAd+WPRvhkvw+MQ
 dL3O9x7kFwTCl1aNyGG0qyHIX6w3HQCA/sNLtB6mCiYLaBOHDvHyJz5Ms287/IGQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqjdjx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 12:50:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H9aNfE2917760; Thu, 17 Sep 2026 12:50:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa2b09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 12:50:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68HCo2SG33030866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 12:50:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC6CA58067;
 Thu, 17 Sep 2026 12:50:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1EDB658066;
 Thu, 17 Sep 2026 12:50:01 +0000 (GMT)
Received: from [9.61.41.188] (unknown [9.61.41.188])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 12:50:00 +0000 (GMT)
Message-ID: <c055ba38-62a7-4883-a4f5-48f5a88125ef@linux.ibm.com>
Date: Thu, 17 Sep 2026 08:50:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] vfio/ap: Clear error object pointer after non-fatal
 errors
To: Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-5-farman@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260916203242.2509787-5-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE3NSBTYWx0ZWRfX4laWzq3bmg5Z
 4ghGX7HN/gPVsdSy2lNwcXmEQl/3VVzoyiU2CF331fRaUsSDn5xfmtmD8OEufawwS35MK+QEjn2
 1Jo2M/h0S/X+ebQr1urjEH8PppNe4nA4frgmDsqXKTLhtV4mvMT98AjEDZTvuQjlu+HxVrJ/sDq
 iKugv/1lD1j6q78SCvloe1AMiVABIbZqAnIKLwxPmu8CcnuN1hR3hrVuk+F/00PnzN4KZX7UPLT
 X2E1MF6kaPSGWY7QRJNKQoL+njbAVqCYUMrb9uaegGS4XNac8GEw4Lgh/XjeYSC1aYQaUmvd0KW
 BZStzOZSXzC/u9YttyF1XiPnWpgZAm/wWiMz2VcL6sx4VYlFk0ol2ooWjGxsrTxm69v85Ca3DoE
 kbzM4zNKIz94MqFqzT+o8odB2GCuaNaLIKeWxzryduXR/m8NGzfVk/d96YIZYbH7mOu2HFotpZ9
 jV2WC+C+daS1jFclOVg==
X-Proofpoint-GUID: chjBUGX98E2nl0dndc86XJ3RR2HpUmUZ
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aabe1fc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=txLobOXyLioU0aAi3V8A:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: chjBUGX98E2nl0dndc86XJ3RR2HpUmUZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE3NSBTYWx0ZWRfX0J2c16jPp4H7
 MSlN9ZlLIOyHml0U571tWJyEAuUlk/6hZMxtIuC5NQP0Fsy0RLG6XatitvurBB/XpArEN4wqFhM
 aquAK24vPK70Y1CEtchYRWMi8sW1+Ok=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1011 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170175
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

> ---
>   hw/vfio/ap.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 6e2a1223ea..2926e04ad4 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -247,8 +247,10 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>           /*
>            * Report this error, but do not make it a failing condition.
>            * Lack of this IRQ in the host does not prevent normal operation.
> +         * Clear the pointer, since the warning will release it.
>            */
>           warn_report_err(err);
> +        err = NULL;
>       }
>   
>       if (!vfio_ap_register_irq_notifier(vapdev, VFIO_AP_CFG_CHG_IRQ_INDEX, &err))
> @@ -256,8 +258,10 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>           /*
>            * Report this error, but do not make it a failing condition.
>            * Lack of this IRQ in the host does not prevent normal operation.
> +         * Clear the pointer, since the warning will release it.
>            */
>           warn_report_err(err);
> +        err = NULL;
>       }
>   
>       return;


