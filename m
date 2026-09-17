Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA7AC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x76fY-0005JI-Dt; Thu, 17 Sep 2026 03:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x76fW-0005F5-GN; Thu, 17 Sep 2026 03:36:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x76fU-00047s-Sd; Thu, 17 Sep 2026 03:36:30 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H61jBS4025613; Thu, 17 Sep 2026 07:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fnM0Vi
 4vCnfpWOfbmjl6sOTNGyjp/Kb8JuaTy+uSfOE=; b=nktJ/lNNZnYi9WBYUg0G6I
 YtsOXlCIq6n9sapoYpBYWHH8npbLRlFGOVXV5WHScZOdL4X6Ef8rahN3lBbpgaSN
 AkyySQrpyPljcs9rCS7IQtpLDr0XbQpBR5RHfnGCXs2U7jfxvy5m7Hj6inh4DodN
 gJiuspLBoF2rELokTWS5oNRVpSvdhRTadRUS5uYWY4FvsdZRuzGqheR2vNh+4czG
 usE1v63xpzXrNHkuuwwdc7J1tWOodkhQarchcdBElXPEYv0XFrOX3P9xvpRu4MXP
 TMUASmPiSjamA7xCAbp7EohJmjQdZKfzdsGcqNwEz/aKiMsM/Wz4SdIo3vSXe/0g
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqh14t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 07:36:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H65Bmd2638636; Thu, 17 Sep 2026 07:36:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3f8dnc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 07:36:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68H7aM4s52036002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 07:36:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AC3820043;
 Thu, 17 Sep 2026 07:36:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E92FF20040;
 Thu, 17 Sep 2026 07:36:21 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 07:36:21 +0000 (GMT)
Message-ID: <fe70daf7-bf89-46ea-81d1-a3de6eda0692@linux.ibm.com>
Date: Thu, 17 Sep 2026 09:36:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] virtio-ccw: Limit ISC to MAX_ISC
To: Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-2-farman@linux.ibm.com>
 <bdec4140-8d65-4480-9723-9c04595431d1@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <bdec4140-8d65-4480-9723-9c04595431d1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwMSBTYWx0ZWRfX9eUIBOPDmiyl
 UtqAqFK181HC6fMmnmEqtdaPZb9eWQC+XrTz2oZbHTKjBZLodz1nVb/puK5D0TJThuqYBoGyHOe
 xrYH1WsL0offLFXXRSzA2SYHZoAE5OS2IrQr/GMkS2wt3cB34j36XfWFV9LFPj4QIZqis73TCnj
 Zqg8AG7BsHgA5Xaxjp2cUvZJHyr9+Wr5FXtF4+dJc60RHlAi0qcCrADELaROtiIsKmd51owBYl+
 9lEvHf5IBZE+zX0NVQcamjmOPFai8kFqSlGADosPmlHaLbCFFvygwwGkmrwMVyzRtnzDmGz3i+n
 QmxR3zZwYb3k5xH7VfNFFU0LkiaHM7e39RRp5aiPGkV+zGGXb1sjQAD4aA8VOm+xvu0PWM8Fn20
 sjieqNlCrdazKYmnhARg6fA+C6eoVeFYoSyaFJqJdReuBmxxZ6+UHgZH6Rl00dxhU++B4NHMrrp
 snCDD3nrhfQ1+OBjFQA==
X-Proofpoint-GUID: boonySYsOp9-JedvQ2zAwk4z56gLeJfk
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aab987b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Na_xMrO-gH8wGSdr7SoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: boonySYsOp9-JedvQ2zAwk4z56gLeJfk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwMSBTYWx0ZWRfXx3XJQzBbOMGc
 Pem4xnT9EGvOPwkL/jaGbls3LwGK2rmidXRrNixxBYEv1AGAB9ImtJnO4Wx21+9e3EbwlUZUcFx
 Y8YzGfOH8+4RAsEaDtpM5wbglVKFIqE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1011 adultscore=0 bulkscore=0 lowpriorityscore=0
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



Am 17.09.26 um 01:15 schrieb Matthew Rosato:
> On 9/16/26 4:32 PM, Eric Farman wrote:
>> The interrupt subclass is often defined as a uint8, though in practice
>> it will be within the range of just 0-7. Ensure that a guest-supplied
>> subclass does not extend beyond its expected range, especially when
>> used as an array index.
>>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   hw/s390x/css.c        | 7 ++++++-
>>   hw/s390x/virtio-ccw.c | 6 ++++++
>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index 76dbca3bb9..9da9128d88 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -654,8 +654,13 @@ void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc)
>>       S390FLICState *fs = s390_get_flic();
>>       S390FLICStateClass *fsc = s390_get_flic_class(fs);
>>       uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;
>> -    IoAdapter *adapter = channel_subsys.io_adapters[type][isc];
> 
> I think this deserve a fixes/cc stable.  This would have been an
> out-of-range access before this patch.
> 
> The initial support didn't have the concept of MAX_ISC, it showed up in
> 
> dde522bbc5 ("s390x: register I/O adapters per ISC during init")

Yes.

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>


