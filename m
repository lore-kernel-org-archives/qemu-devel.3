Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A7FC982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Ava-0005Br-6N; Thu, 17 Sep 2026 08:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x7AvY-0005BV-I1; Thu, 17 Sep 2026 08:09:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x7AvW-00051R-HM; Thu, 17 Sep 2026 08:09:20 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HA1wIU2206706; Thu, 17 Sep 2026 12:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GSqzNY
 shc8oqPUkR85gIwZRhc83VF3P2+tI1ay/t0js=; b=Ns+wjQb9p/EVw7AHE8zVPc
 cQAFnL2hMKnFnmobBS4AF72VRKvusJd2+SW3WoAY2kkCZFpx1DWCp397tQt7edic
 BOJ6EdpWalPFO3uPSuUE4Ca692KXb5/sb2CO3SIgmSTCVy07/2q4BkepuO/OGP6Q
 c50BOaBSj1V/PFqS4V1MKBEViCU1xwibzw34iuR77JP6Sa8XkP5uRfCZsP+pyxNA
 pz8wpZj73+KdEA0Yv75F3tT3+2tAeKPtSxKKEJ4N2FsHkNEq2XYL7PnJ2wXBlJj7
 1jpD2PZc2LJgiwJBDIEzPzz/GMAkhVL6fr6Mf37DBxuh5m81Cqmfu53NMjjIbbUA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5a80a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 12:09:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H9aLOU2879609; Thu, 17 Sep 2026 12:09:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3f9bkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 12:09:14 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68HC9D4033620578
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 12:09:13 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E87E958045;
 Thu, 17 Sep 2026 12:09:12 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 603BA5805E;
 Thu, 17 Sep 2026 12:09:12 +0000 (GMT)
Received: from [9.61.156.236] (unknown [9.61.156.236])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 12:09:12 +0000 (GMT)
Message-ID: <e668c819-b682-49fd-ac82-bd81b2fdc0bd@linux.ibm.com>
Date: Thu, 17 Sep 2026 08:09:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] virtio-ccw: Limit ISC to MAX_ISC
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-2-farman@linux.ibm.com>
 <bdec4140-8d65-4480-9723-9c04595431d1@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <bdec4140-8d65-4480-9723-9c04595431d1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gA1OGycuvupTIdjKa7EqoCxy37fmxxs5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE2OCBTYWx0ZWRfX7XEYoE7oWiqd
 fHl8iVG9d7jBKiWat+ugxBCbBXbg6Xt2DoVqwY1p5KQ09vWGFbkSlfkiJreAa3v9DKxkQFhF3iG
 zmUeJtKNnz5q31Ecv4ZhGZ1JA40yJw4=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aabd86b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=c84zAlJ4oS4KRIEuEZgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gA1OGycuvupTIdjKa7EqoCxy37fmxxs5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE2OCBTYWx0ZWRfXx7bxO1B2jaIU
 lFM82/1ELoiSFXPvk7AxiW/1Z0OP0NWTQlkbj1hsLaAMRZjlaGBvhZePp8LgXOmvisR/3G8vMN2
 vkxymouxmiZYZ9Ma9rJY++e9qdyeStv8OvVCDnb65OAHUfUL/PLQS5G7YKL4ZTml7PYnRRiSeNn
 jbfXi2Po7w+NElWEs/OaVf+CLkESTlNGlXEkR2df6AEmlWI6LLhKh4SASL3kXCipjEcjONelcB8
 XxFy8awzB4TidguAZ2iJRYjWVVSPOFkBRLTZ0m2A7vcyOoPnlwZXL2c5AV/YnqIj4yDyQdD/PJ0
 wpoVaO9F4GAa9nHQGomHbBlzqiz3M7JT544EHhunudW7AtjNuyKeQ05QuLIE2HR8BnPGBg28LSp
 5soo5eeC4Mq9F+prbobXhYAAMw16HyhcFZAodGge2iYFaGndtZWCTj01q/jqIGass+dBdHeVs4U
 q1A8MlJtzjJd/a+iqsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170168
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



On 9/16/26 7:15 PM, Matthew Rosato wrote:
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

Ack.

> 
> The initial support didn't have the concept of MAX_ISC, it showed up in
> 
> dde522bbc5 ("s390x: register I/O adapters per ISC during init")
> 
> Frankly I think at that point we should have started fencing
> registration > MAX_ISC already, but that patch DID locally fence its new
> array indexes against MAX_ISC.  It wasn't until
> 
> 25a08b8ded ("s390x/css: update css_adapter_interrupt")
> 
> when the above array index was added without the fence that you are now
> adding.  So I think 25a08b8ded is really the culprit.

I was considering 25a08b8ded, since the array indexing was the impetus 
for this patch. So will go with that.

> 
>> +    IoAdapter *adapter;
>> +
>> +    if (type >= CSS_IO_ADAPTER_TYPE_NUMS || isc > MAX_ISC) {
>> +        return;
>> +    }
>>   
>> +    adapter = channel_subsys.io_adapters[type][isc];
>>       if (!adapter) {
>>           return;
>>       }
>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> index 30fb2c0681..eb6378ea4c 100644
>> --- a/hw/s390x/virtio-ccw.c
>> +++ b/hw/s390x/virtio-ccw.c
>> @@ -46,6 +46,10 @@ static int virtio_ccw_dev_post_load(void *opaque, int version_id)
>>       CcwDevice *ccw_dev = CCW_DEVICE(dev);
>>       CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
>>   
>> +    if (dev->thinint_isc > MAX_ISC) {
>> +        return -EINVAL;
>> +    }
> 
> Is this safe to check before thinint_active?
> 
> I guess if we get here before an ISC was ever set it would just be
> zero-initialized so it wouldn't erroneously trigger this check.

That was my reasoning. I thought that adding it outside the 
thinint_active block would highlight potential shenanigans, even though 
that variable would end up being ignored in that case. Of course...

> 
> Assuming your reasoning matches mine:
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
>> +
>>       ccw_dev->sch->driver_data = dev;
>>       if (ccw_dev->sch->thinint_active) {
>>           dev->routes.adapter.adapter_id = css_get_adapter_id(

... the above css_get_adapter_id() call will already check that it's 
within MAX_ISC, so it's probably unnecessary.

>> @@ -659,6 +663,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>>           } else {
>>               if (ccw_dstream_read(&sch->cds, thinint)) {
>>                   ret = -EFAULT;
>> +            } else if (thinint.isc > MAX_ISC) {
>> +                ret = -ENOSYS;
>>               } else {
>>                   thinint.ind_bit = be64_to_cpu(thinint.ind_bit);
>>                   thinint.summary_indicator =
> 


