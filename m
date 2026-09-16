Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBA0C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6yr3-0008Ce-G9; Wed, 16 Sep 2026 19:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yqx-0008B2-Ux; Wed, 16 Sep 2026 19:15:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yqw-0002gS-DF; Wed, 16 Sep 2026 19:15:47 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1cKW018021; Wed, 16 Sep 2026 23:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Si/evG
 laHjVOh9kWyaR+BuhhCsoedixG6Umi8pY7KEg=; b=mHBdPo162pVRNcBImQ9fdU
 c1m18rscnk5nQKdJc4MErQqVsBvgdpvTn2dC6/Hn0t1klErtK3vTZ0coOv4uBSI/
 Sp83D6ZehkBM+HKhy33JLUcM0sakBPZqr4wrODRh3xRjFa9UG2/s+l4dhwG3UpgO
 PLU9LmMu0Yy7QBfvZU9koVi3waQD9yoHXS3WWzqoS57kMfQ06BropS2HkDYIGI8w
 7DlRDxFcrCHU62thIVPuboeIBKysvCRdAPMD8uiaqjFJ8UQhFLxA1m4oQbak0kmd
 N5DJlOyNczI0jDfEDPbRe/wuSb2xTYoa7HS300p2UlL4gXQF/TcAheqGyJTMBCGQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf57edw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:15:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GN0AGW1699615; Wed, 16 Sep 2026 23:15:43 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gq03vgv2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:15:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GNFgTV2753248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 23:15:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 292BD58045;
 Wed, 16 Sep 2026 23:15:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D3AC58050;
 Wed, 16 Sep 2026 23:15:41 +0000 (GMT)
Received: from [9.61.177.109] (unknown [9.61.177.109])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Sep 2026 23:15:41 +0000 (GMT)
Message-ID: <544951fb-1346-4180-9a25-0817cba4e38f@linux.ibm.com>
Date: Wed, 16 Sep 2026 19:15:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] vfio/ccw: Clear error object pointer after non-fatal
 errors
To: Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-6-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260916203242.2509787-6-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JgGSN0Cf2GO9Bwufjc_Ylr9hJWjVgZsK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX01M1eVA8b0oO
 nMFxTAyV+D18W3GfqkUF4AQT2rivyRMf1dzI+W5f0DAG4zIjYY/zNHH2gM0DXrkJOAudUSCRp75
 YMKuwLpDXy8X23S6izeoyh1E2OiNr/Q=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aab2320 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=xb4UEb0xBE66edQEJr8A:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: JgGSN0Cf2GO9Bwufjc_Ylr9hJWjVgZsK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX/g9hoCM693Bh
 fOOR45AmGdfGMCnKXLieUmn4Wc3Q2IiTIBZ9M8nEkaak2kk7XspEp+m75IjqarWMmw25dKAzKQJ
 pnnhwzq1v5ZXzdQX1yUhBsBtMxIsf4Z5JBBer+dQ54UackA52IxjtjrZ1UhrMbRKCDTfFdjrBkP
 koi9gLkH1E3TPocf0/CM/CqYe0iGi/EbuXILbQhYvwa4aeYTbJsGMJWeCZICnmJMmk8oCCYUu4c
 oFu49N1m54H1upVfPpXsP/yD48g5Mnnbvl5MtAHdoHvzcOHiqy31HyvIFxYr5Ko1T17WyT6bZMF
 0j8b7kba+4lJxqwNRnbRgYfedvkGd0MfAwpwzjRFseLxrYn5yk1jWnhIb3Bo8dMqKUXCK52hPqj
 A2glRjVaaELt8jUdce+nufgI3iU8j20jHHJCWfKVdxfiamT9rMHezF8q+m2horla1oDmGm+7G6z
 hOsY+/RlaaK6UNoOQqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160322
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
> Just like in vfio/ap, there is a non-fatal message that could be
> generated, with a stale pointer in the error object variable.
> 
> Unlike vfio/ap, there is no secondary message that could attempt
> to use it. Clear it in the same way, in case that ever changes.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 6178d4689a ("vfio-ccw: Permit missing IRQs")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  hw/vfio/ccw.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index c3dc7c1962..8e29a3ae61 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -604,8 +604,10 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>          /*
>           * Report this error, but do not make it a failing condition.
>           * Lack of this IRQ in the host does not prevent normal operation.
> +         * Clear the pointer, since the warning will release it.
>           */
>          warn_report_err(err);
> +        err = NULL;

OK, so this patch is ONLY a future-proofing change since err goes out of
scope right after this.
I'm OK with the change from a future-proofing perspective, but IMO it
does not merit a Fixes or a CC stable.

With those removed:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

>      }
>  
>      return;


