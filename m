Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD933C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7EoA-0003Ih-Dl; Thu, 17 Sep 2026 12:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x7Eo1-0003I4-W3; Thu, 17 Sep 2026 12:17:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x7Enz-0000hU-Io; Thu, 17 Sep 2026 12:17:49 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HE1PHU2710554; Thu, 17 Sep 2026 16:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NTcZgv
 p9CqGe63KcFPsIoY9G/st/4zbdhH+z3r42QAk=; b=sxX/+dGb2wb6K5wZhZQXaG
 hnKt9zRmFtrA3IDoG+yn2aqPR8WBsPI9vzhTQOk+npFtoOQ07LT17yqaou4Ced04
 PXK3O8fizgwUxQ1igUvvMAGGuLq76blfCmf2kSGE+Ssvwq87wxZNgmfJJQW1z7e+
 q+SVz4I8PdQBLGbwkxJ3z1I+g/kuPl78ZIg9iX6Dz1UqUpZV9XjyT/Eg6rbWaAWL
 2aPmGEy2U/0brkr0Y8qNOHYiItWoKEIoS6hcNlU5qGMKU2c+BJWNBfaLrKHM5mbe
 oTKaCStQmi1rAEgemo43EwWdADuf2CdqPy7mkVum1TAlnKruiV36wWauuJU2xs+Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5bgut-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 16:17:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HDa8813244819; Thu, 17 Sep 2026 16:17:44 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ffb79f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 16:17:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68HGHhBo23986842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 16:17:43 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4804058052;
 Thu, 17 Sep 2026 16:17:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7BC158045;
 Thu, 17 Sep 2026 16:17:42 +0000 (GMT)
Received: from [9.61.156.236] (unknown [9.61.156.236])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 16:17:42 +0000 (GMT)
Message-ID: <c6958a46-7609-4ba3-971e-5b7310a77dd3@linux.ibm.com>
Date: Thu, 17 Sep 2026 12:17:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] virtio-ccw: Do not overwrite existing indicators
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-3-farman@linux.ibm.com>
 <cbb1f499-7776-4066-9b96-3071cc0406d9@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <cbb1f499-7776-4066-9b96-3071cc0406d9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bMNJCs_jgySqi4wkxTqYUaGJhIlCKE4E
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIyNyBTYWx0ZWRfX7ZnqgiT3Gpbm
 NX5cYlJhei3phgOLLCrYMqFMyuukEZ/o/sdMGM6mDHEwqE5E/GPwz8ccj718WY2SkxA9+W4DP8K
 i7Q4S5cH/zI628cA/7nf5pRdaAEMFiA=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aac12a9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=95lDA4IGIJy8XsDgPBoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bMNJCs_jgySqi4wkxTqYUaGJhIlCKE4E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIyNyBTYWx0ZWRfXxxsQCb8zZKkn
 SjeradjJF7npaV9Vk9F4AHwbrmdv6eeQZwI1cFCDgocnhpePJzf9xWRdtHT3PtkS7wDCrnwdTgh
 VcEuglxagzlR2sG8IXSbB/3dyRhPBgYlJxB0D4W2VnVJbNysO6A2c/PcqAWeYid2h1jMKcj8+ly
 E37byNAJtmlumVSgs7SckG0/jGURj56qaPkMsY7/8KKvEtERSfEB0W3HilDQCaUgHHRciHkw5ho
 oziwYR14H44siIiKr42ppYPdr0CGxaFS6ElhnO6wnRjEW/MCDBj95FpX+yW1PuRYr5g0VNUkqYI
 3GWfZY8cTyE1MgXtK+6VMJ/iej4itTND6iO8wQi2PXf7LYgQLysG391u5eimVf/1+HFyFVXB6eZ
 a1bpVNwF8sYKWiHxmUOXumfdL6ON4t3GNbJqIEgcSND8pCr/VLKkiQJu0BB6jFKNsOAMvmUV9Or
 aiZtWBv2b8oKUJHeOIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170227
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 9/17/26 3:35 AM, Christian Borntraeger wrote:
> 
> 
> Am 16.09.26 um 22:32 schrieb Eric Farman:
>> The various indicators pointers allow them to be overwritten,
>> but leak any existing structs that might be there. The adapter
>> indicators path checks that it isn't converting from regular
>> to thin interrupts, but a check in the reverse direction isn't
>> performed.

I missed the check actually exists in the reverse direction,
it's just not as involved and blended in with other checks.

>>
>> Rather than unwinding the existing allocations to allow additional
>> assignments, just reject these duplicates.
>>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   hw/s390x/virtio-ccw.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> index eb6378ea4c..d700db405b 100644
>> --- a/hw/s390x/virtio-ccw.c
>> +++ b/hw/s390x/virtio-ccw.c
>> @@ -565,6 +565,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>>               ret = -EINVAL;
>>               break;
>>           }
>> +        if (dev->indicators) {
>> +            /* Do not set without un-setting first */
>> +            ret = -ENOSYS;
>> +            break;
>> +        }
>>           if (sch->thinint_active) {
>>               /* Trigger a command reject. */
>>               ret = -ENOSYS;
>> @@ -599,6 +604,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>>               ret = -EINVAL;
>>               break;
>>           }
>> +        if (dev->indicators2) {
>> +            /* Do not set without un-setting first */
>> +            ret = -ENOSYS;
>> +            break;
>> +        }
>>           if (!ccw.cda) {
>>               ret = -EFAULT;
>>           } else {
>> @@ -657,7 +667,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>>           }
>>           if (!ccw.cda) {
>>               ret = -EFAULT;
>> -        } else if (dev->indicators && !sch->thinint_active) {
>> +        } else if (dev->indicators || dev->summary_indicator) {
>>               /* Trigger a command reject. */
>>               ret = -ENOSYS;
>>           } else {
> 
> I think we have to do the full unwind.

Will do; thanks

> The Linux driver deregisters indicators by issuing SET_IND with address 0,
> or SET_IND_ADAPTER with device indicator 0. The virtio drivers reset the
> device before del_vqs, so the deregistration lands on a clean state and
> QEMU records an indicator at address 0. A later rebind or module reload
> does not reset again, so the next SET_IND_ADAPTER and the SET_IND fallback
> are both rejected and the probe fails. The old condition on SET_IND_ADAPTER
> existed precisely to let the deregistration through while thinint is 
> active.
> The fix should release the existing indicator before overwriting, or treat
> address 0 as deregistration. Releasing before overwriting also handles the
> find_vqs error path in the guest, which deregisters without a reset in 
> between.


