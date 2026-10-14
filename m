Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD31C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH2bX-0006Cq-2x; Wed, 14 Oct 2026 13:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH2bU-0006CP-C7
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 13:17:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH2bS-00045R-7z
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 13:17:23 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbFwW301175
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 78ZdV65SoleogM/N2XjmXXQOaJs4bcu9NkcN3rQHZE0=; b=FycU8QoLm1ExLKzx
 KPxQEzPnfZzQNQ1NCgDL9fEFl5tSXss5cE5uYxenzHcSw8HYPx1/O7ANNIkRGAe3
 PqjKh5dwR4wKHpFHrBh6lbe2Lr1r6n808a/neHONdK22ErTDoEbk86qh+2dNCZJ9
 rny1hD05Rcn4omMXki0orUXjjmnpkps4nE5fJGfZb9jFbml5e8nkITcrRQIBn/dY
 Epy40k4qX6OeMublelgge3GWpwL96Xi8lQWl8nAXdetW8BeuL7Z0PwUn6eWtc1gY
 y8p+ypNUcxS4HI/W4wQzDYCPey0abiQeqXqtUpYWLtR/95gPMhpDeFT0AvlopQd0
 SOG7wQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4622qvw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:17:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-351788121cfso8015813eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 10:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791998239; x=1792603039; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=78ZdV65SoleogM/N2XjmXXQOaJs4bcu9NkcN3rQHZE0=;
 b=Eh5zvzRVZkp589Ip5B9oq8jE1F69lCPvYvEQ+9rKtjPdvdmeWSo4749txr/h+44h5B
 beDDeonYa0rUBpCZwKsDxADgdmqea8nLAGA7a/LVa0QD8n1zDGVvgg/lcPIR5+qd6qSF
 +Z+1A3Qkco1WRNlzNoeE2Y3t0hcsmhCdTWW58XUdkXqRupGy0Yd21Qv0xWWSPrvhjpo7
 NH443ck74VyPpBrfP57s2Luoix0R5Ws//DpdcoMMwwS/YIsiG2bQodadioxYLQXnKIlu
 fkTgt0YwVkRzhaAvqAfU0KzHp8eYpAJ++Z18sdb7u25MRn4HRNixFqmMEy4qGSrI830g
 hmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791998239; x=1792603039;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=78ZdV65SoleogM/N2XjmXXQOaJs4bcu9NkcN3rQHZE0=;
 b=T6obu/qxq7qrKikr3gYV5mlTzUUWujqibTu8d1IGhlH6Drgix+xf7XT6t2GNebB5Af
 wqU6NSOFrhS05TMkzupEMaB4gotVksmgRAOuVbP6a4u6ZoRF74rRM56cHSl5yKEyO4o7
 zEormfrianvrPcCtiACrgDYxPMNB+0TA2xsrQRvctp41hQZ/SBdiCDaiCwX5DQwsydvW
 XXoWAuJHSrAJvMNqE3OMYX8NZh/PiJJok+awSomEXwGmPlB2muVw5GZI0iNsuDes1tcJ
 rwjXsn5/SJRLnl7h4wDRiRxScWyaCDeKQJNeme5xHNvd/AqAs16A+DwmUCOqs8rimB3U
 eLhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAbcjw6QTppl5dZvnevgtXZIQ6eqHTHFEz3+d+LRz2G5Dgn02gZ8SZxUpSzVl89LTDjIz/36v62q9F@nongnu.org
X-Gm-Message-State: AFq9FYI5fuh5crilbA35wo1es4DJrxo4/J2mpJEJiA9J2Emx3S/c/rWn
 umfREdYr3I+HO9lHqjnl49u9Se4C7oqZorgRKaUjLkaO8IJoDz/bC2z0mBgZ0W5m0mjyRZlBciB
 tB88rMY2087+D0xy/ibsZn8iRASNfgkWedeDYT/rMepazrgPTf/ciGqhnZw==
X-Gm-Gg: AYBFou1ECmwRBYv278VDppKz3ik1VT30hy9WQIYYivAHMWRklbNcpJQf8VXpwQ5Vc6e
 Kl/Qvi7/1l+LNmy6ehbVYQTKTDBEmVm5EogYq7+kRyHuFZ6meTGh/7pUX3e0Nv65NL0gV5wvYKf
 D49feGuWxgfghlBUpqpGVXTm7sfBZEsCqGKjuWTIcrgw0/pg1FCGKdT3Sdy1FMJ+i8TckSc0Mfc
 dl/lopKIzONqSHSr8zhWDTobFAmIczE+3Jwz0s3ywaAMMrJeEDByjq1buB4g3MzHH50RxpUkIWF
 FKLgWLRssfg78cd6780NgODmXMlkBJ5JA5+OA/4iwhmDhEEgBcC9b2og+BiYMpSsPqLSuvrtBfp
 PwKgUr4vmJ65ceCsLqsBXhU/P8Q4dXtPySD44+VMbasP+mj4B9T9BPqY2YQ7HWIk0RbUvBg==
X-Received: by 2002:a05:7301:221b:b0:342:645a:5cf with SMTP id
 5a478bee46e88-3537dde8888mr21996689eec.1.1791998239076; 
 Wed, 14 Oct 2026 10:17:19 -0700 (PDT)
X-Received: by 2002:a05:7301:221b:b0:342:645a:5cf with SMTP id
 5a478bee46e88-3537dde8888mr21996646eec.1.1791998238272; 
 Wed, 14 Oct 2026 10:17:18 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35ea672d82esm2462382eec.9.2026.10.14.10.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 10:17:17 -0700 (PDT)
Message-ID: <b2874ade-3cd2-48aa-9f46-4bd3bbfcdc45@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 10:17:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/hexagon: model PCYCLE counter
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009003521.2227155-1-brian.cain@oss.qualcomm.com>
 <20261009003521.2227155-2-brian.cain@oss.qualcomm.com>
 <cf93c914-b533-4468-bea1-b0cecdd3fa93@oss.qualcomm.com>
 <cfa6d466-c686-4693-a3b3-7f754b4ba906@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cfa6d466-c686-4693-a3b3-7f754b4ba906@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jHU3h49rPjNZ6O_BYchG85lRmgZRTj8z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2OCBTYWx0ZWRfX+nfXXBZ4Y5uc
 ynfd/3uG77LbSTkPjbk4kyq7smYr3rnMpocWOTzgi7RzmvSs3SudLoHlYiWObugy9ENeom8UY2c
 O+yxYQHkHzpzfXggCJmGq9J3xttVzl2DMjy4cxoQqBbhykHKleIMDq3IyehI+Au0uqP1enrMNo6
 51IZQDej0uoscr73/BocbZ62b41Cj6zanEwWLeHTJVugLy1ya1y3I3qaosvMDEs3FCsb/XflMLO
 J14vK892rLgaC8D9JDW/FWVtRa1NXp6G4NKbfFEpanNQ7TVdFLqoA3zjaIgmTyeWz3EArVvfZtB
 9mzPBzmUE3CNu4/UuKz04borAMtHmSTZCd0nOBTyWJXsQej+IxaPa3PHRk3arGIQwOm+ajR4v65
 5tfiPorHlCoFfD30yXy46eQJSLTk1h30mWh2zlKr6MPtHOilmmh4C0r+UWLau1XdQxKzC0uChBV
 BMi7j/blcR3SV+omlrg==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acfb920 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Uag-G_HgZKDh-R2DNDQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2OCBTYWx0ZWRfX3EDGHf0Q2eOC
 Q/d+wHJjT4t2vsWAvu2m5arQ6svwCL6ibBqXVMViSWNZZeAnGVta0CGoSBeecL5PI12UDE1tsYF
 kyWYcTAHNOYHnj8IIR/WVKqsENN+w5E=
X-Proofpoint-GUID: jHU3h49rPjNZ6O_BYchG85lRmgZRTj8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 10/13/2026 5:39 PM, Brian Cain wrote:
> 
> On 10/13/2026 5:34 PM, Pierrick Bouvier wrote:
>> On 10/8/2026 5:35 PM, Brian Cain wrote:
>>> {U,G,}PCYCLE now use a shared virtual-clock counter.  This is closer
>>> to how
>>> the real PCYCLE behaves and avoids the extra work that was being done on
>>> every single TB.
>>>
>>> Handle SYSCFG.PCYCLEEN and the semihosting PCYCLE read.
>>>
>>> Remove the work-in-progress implementation that summed the TB
>>> instructions
>>> into a counter.
>>>
>>  From what I understand, PCYCLE is different from RDTSC (x86) or
>> CNTVCT_EL0 (aarch64) since it tracks cycles per thread, compared to
> 
> https://docs.qualcomm.com/doc/80-N2040-60/topic/registers.html#cycle-
> count-registers
> 
> PCYCLE is a global (per-core) cycle counter, not per-thread.  The WIP
> implementation accumulated counts of packets per TB during that TB
> (accounting for just that thread's activity).  The previous
> implementation on our fork summed the counters among vCPUs on PCYCLE
> register reads.  This was "good enough" for a first generation but is a
> less appropriate model than provided in this series and required more
> work with every TB.  The one nice thing was that it was stable and
> consistent among hosts.
> 
> 
>> globals ticks on cpu, independently of its frequency.
>> Pushing a bit further, I also see that aarch64 has PMCCNTR_EL0, which
>> models something similar to PCYCLE.
>>
>> In the case of aarch64, it's implemented based on time also, so hexagon
>> mimics this approach.
>>
>> ```
>> static uint64_t cycles_get_count(CPUARMState *env)
>> {
>> #ifndef CONFIG_USER_ONLY
>>      return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
>>                     ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
>> #else
>>      return cpu_get_host_ticks();
>> #endif
>> }
>> ```
>>
>> So, since we are not accurate anyway, and depend on host cpu speed
>> through time elapsed, is there any reason to have a pcycle_freq_hz
>> property instead of a fixed number?
>>
>> ---
> 
> That property was sort of an "apology" to any user who might long for
> the stability of the implementation on the fork - allowing them to
> calibrate as needed.  I am definitely not attached to it and happy to
> get rid of it.
>

I think it would be better yes.

> 
>>
>> The rest looks good to me. It would be slightly easier to see the change
>> by removing the count based wip first, and then introduce the time based
>> implementation, but it's not a big deal.
> 
> 
> Good idea - will do.
> 
>> Regards,
>> Pierrick


