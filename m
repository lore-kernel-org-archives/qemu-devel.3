Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B7BC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8fXU-0005td-6O; Mon, 21 Sep 2026 11:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8fXM-0005t4-Gd; Mon, 21 Sep 2026 11:02:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8fXJ-000454-JD; Mon, 21 Sep 2026 11:02:32 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LEZVKP1791087; Mon, 21 Sep 2026 15:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tfvH89
 H2F0XVUQaMC1dqFLRnD1qoQqyOhJKC23cAsNc=; b=GpCzjYDwh5xN0SMpWmXBfg
 j3gmoFK9ZWdjNWbxL+A0MihnGv+b97fN910PJi3Dd5GiPVA55C9GHstg6bDVoHLr
 FwukkxH+FE3FYdrVJZgj6DocxCOOaeZMl+eH+/z6XI2GWquyGLe3bm3z5wI09GBO
 Q4oKSXxo7aa/3e857Ffq+XeIUp5CZdz0G3TskeLA613IQkCgLFIc7mPwAgeeW1Db
 dVJdY7Fo6x8CpYGIj0K1TC+UNYqXb8HFh+SXPIEstP8s7GrA4UVOELPQxYKhI7ea
 Pgm7S9y4r9Ky8YMY/kPUuvR7Ep9wWeRpOohA8jxh/rSod+zz2QYOcK2uE7O+qm+A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg29824-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 15:02:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LEJ1GI1371197; Mon, 21 Sep 2026 15:02:25 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gnr25-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 15:02:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LF2Ocm30016070
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 15:02:24 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FD865805C;
 Mon, 21 Sep 2026 15:02:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93C7158054;
 Mon, 21 Sep 2026 15:02:23 +0000 (GMT)
Received: from [9.61.69.195] (unknown [9.61.69.195])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 15:02:23 +0000 (GMT)
Message-ID: <30a875f6-3016-4217-bc9c-76b146e81630@linux.ibm.com>
Date: Mon, 21 Sep 2026 11:02:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] virtio-ccw: Limit ISC to MAX_ISC
From: Eric Farman <farman@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-2-farman@linux.ibm.com>
 <bdec4140-8d65-4480-9723-9c04595431d1@linux.ibm.com>
 <e668c819-b682-49fd-ac82-bd81b2fdc0bd@linux.ibm.com>
Content-Language: en-US
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <e668c819-b682-49fd-ac82-bd81b2fdc0bd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RzNqFjl1bvRdpeXeJCsEZPpl3GOX0CwN
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab14702 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=XLC1eZyTMhUgqWPpPoUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIxMiBTYWx0ZWRfX/LWo5xjuVo10
 +Fno2+92YriJTAZSSyNZ0lnkL6vFEWRi/vmy2q/JBlSgPU06OWMoI0BHzAqpwYQqTQt66QzcAvg
 CMSoi4oFJmo4sOv3q8diA3fHzuHO4eODakAhpu2Ok4hqClKvifdR/daOi8o2PAs/4ZhVW9irjRI
 S6L7lAC1VVeHcAbLXRTOkUiYvI60SngCrUFOtT0bbFUuCVsDZw039C34JvSrP5sMu4xN2ereY8M
 AnnX6CVZ3mrxlaGJn+Gc1kbZxUqKB9S0T7Nu+4qVBAztIU+H6G6UcQJHbhLWZ8XfAquwlYuujPX
 3OOEhcDiHg8MHEnE5Un8QPufHO6uLoftN5TxCIm5uWla6lcyn5sxYQKPrCehXOLupDGrCtqJaDr
 uty5y8CM5VjJmQ892EWA2alen680y9dvwnnamIGVJVNwmfOYTSjzWo7xrwebfUBE9DduJ966ih1
 SkNXUOFcHN+ue08844A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIxMiBTYWx0ZWRfXzRnahVz32BAI
 2V/eFYpurVaM5XSaXO8ulWEFHLq73kzDJVGjYFjoqwxgKIn1fpH78R7pV6FBZ3XN7hk934PMfgj
 HaSQ6jYK3oxicrb0yx+NpmP3b+IhIhY=
X-Proofpoint-GUID: RzNqFjl1bvRdpeXeJCsEZPpl3GOX0CwN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210212
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



On 9/17/26 8:09 AM, Eric Farman wrote:
> 
> 
> On 9/16/26 7:15 PM, Matthew Rosato wrote:
>> On 9/16/26 4:32 PM, Eric Farman wrote:
>>> The interrupt subclass is often defined as a uint8, though in practice
>>> it will be within the range of just 0-7. Ensure that a guest-supplied
>>> subclass does not extend beyond its expected range, especially when
>>> used as an array index.
>>>
>>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>>> ---
>>>   hw/s390x/css.c        | 7 ++++++-
>>>   hw/s390x/virtio-ccw.c | 6 ++++++
>>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>> index 76dbca3bb9..9da9128d88 100644
>>> --- a/hw/s390x/css.c
>>> +++ b/hw/s390x/css.c
>>> @@ -654,8 +654,13 @@ void css_adapter_interrupt(CssIoAdapterType 
>>> type, uint8_t isc)
>>>       S390FLICState *fs = s390_get_flic();
>>>       S390FLICStateClass *fsc = s390_get_flic_class(fs);
>>>       uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;
>>> -    IoAdapter *adapter = channel_subsys.io_adapters[type][isc];
>>
>> I think this deserve a fixes/cc stable.  This would have been an
>> out-of-range access before this patch.
> 
> Ack.
> 
>>
>> The initial support didn't have the concept of MAX_ISC, it showed up in
>>
>> dde522bbc5 ("s390x: register I/O adapters per ISC during init")
>>
>> Frankly I think at that point we should have started fencing
>> registration > MAX_ISC already, but that patch DID locally fence its new
>> array indexes against MAX_ISC.  It wasn't until
>>
>> 25a08b8ded ("s390x/css: update css_adapter_interrupt")
>>
>> when the above array index was added without the fence that you are now
>> adding.  So I think 25a08b8ded is really the culprit.
> 
> I was considering 25a08b8ded, since the array indexing was the impetus 
> for this patch. So will go with that.
> 
>>
>>> +    IoAdapter *adapter;
>>> +
>>> +    if (type >= CSS_IO_ADAPTER_TYPE_NUMS || isc > MAX_ISC) {
>>> +        return;
>>> +    }
>>> +    adapter = channel_subsys.io_adapters[type][isc];
>>>       if (!adapter) {
>>>           return;
>>>       }
>>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>>> index 30fb2c0681..eb6378ea4c 100644
>>> --- a/hw/s390x/virtio-ccw.c
>>> +++ b/hw/s390x/virtio-ccw.c
>>> @@ -46,6 +46,10 @@ static int virtio_ccw_dev_post_load(void *opaque, 
>>> int version_id)
>>>       CcwDevice *ccw_dev = CCW_DEVICE(dev);
>>>       CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
>>> +    if (dev->thinint_isc > MAX_ISC) {
>>> +        return -EINVAL;
>>> +    }
>>
>> Is this safe to check before thinint_active?
>>
>> I guess if we get here before an ISC was ever set it would just be
>> zero-initialized so it wouldn't erroneously trigger this check.
> 
> That was my reasoning. I thought that adding it outside the 
> thinint_active block would highlight potential shenanigans, even though 
> that variable would end up being ignored in that case. Of course...
> 
>>
>> Assuming your reasoning matches mine:
>>
>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Ack; thanks.

>>
>>> +
>>>       ccw_dev->sch->driver_data = dev;
>>>       if (ccw_dev->sch->thinint_active) {
>>>           dev->routes.adapter.adapter_id = css_get_adapter_id(
> 
> ... the above css_get_adapter_id() call will already check that it's 
> within MAX_ISC, so it's probably unnecessary.

Just to revisit this comment of my own, this won't reference outside of 
the array, but it would leave the adapter_id set to -1, which is going 
to be a bit confusing. So blocking it as I have it above is more correct.

> 
>>> @@ -659,6 +663,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>>>           } else {
>>>               if (ccw_dstream_read(&sch->cds, thinint)) {
>>>                   ret = -EFAULT;
>>> +            } else if (thinint.isc > MAX_ISC) {
>>> +                ret = -ENOSYS;
>>>               } else {
>>>                   thinint.ind_bit = be64_to_cpu(thinint.ind_bit);
>>>                   thinint.summary_indicator =
>>
> 


