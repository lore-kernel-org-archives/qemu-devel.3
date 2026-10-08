Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA79CA6015
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 23:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xExj9-0004fA-4b; Thu, 08 Oct 2026 19:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xExhu-0004cm-7g
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 19:39:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xExhj-0005bs-VZ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 19:39:24 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L05nQ3969601
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 23:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JW59KKHXY5TCPBZslOxNy3iltfMtJb9sxjeS/HvvO6Y=; b=UGzJ4+fpWRv9Sp3K
 W1nI+Qtv4zX8pVn40cGbMnMo9BcWO8CicB7GsAwyehXKr6gziSLoX0xXyh93Bg+2
 rh73uRd/16XuCYFrfl0jZYuCHzspuyqjM4mV65C8OWs1CtgshglnrumEA7j9Zsgv
 ztMaUaNVzwT0bdx6RVvhhqPqfL1HIzycJwoOHPp5w6xTv7niPzCabiUZU2tEzRfK
 LIf6+EWzwJSZpzFGJqUjy2szTrTlete1iS+9GnIxWsKtZXO45xaL/97ORfL2n0sN
 fUopsHWiL4VVNId4z1WgXHp6miSw4UXC86emjiCILNdFF0oZSt0j7bP1abjjQV9A
 fnjpRw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxk90s3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 23:39:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e92aad34aso750905385a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 16:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791502752; x=1792107552; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JW59KKHXY5TCPBZslOxNy3iltfMtJb9sxjeS/HvvO6Y=;
 b=Y8eldYT1Wcjm1whnZLSZGfJ4tV9Y8nkb1aNvENIUux31x2eyGZbujS8I24qtm2eFe3
 +TAYR/K+mD1Fa2yj+kltzdm2Zf53nw7uTkcgh4b0QyH53Z6KsWPlY5VfRJ5AdYbXl7yN
 Po6SSxlDE9Fob3kai21gsepANKsH/MnnWhanPzqoWMutoERHK+ABSk9dYtVRBkl2vFPZ
 OB/vE7MjTCWgazILriOyDqtnzrLfdaB77oHK7bJqY5gbMBSTx5bHwtm8MAbvGOddnoCQ
 Q9Y9wgcoz94m0XKBkzBk0zfcO1JNCWGUngUCo8zdH2m+ivmdqPMBmk5gmdSRQ14xlarj
 GCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502752; x=1792107552;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JW59KKHXY5TCPBZslOxNy3iltfMtJb9sxjeS/HvvO6Y=;
 b=xEy6r4aiNusLxcMI+ESgAaEPNQ2Izf43rZW6ZWR2L1wrBPtJTOcchPC8J1OOwZEtjd
 3OEaEbfJH9xMdcumNddYntCHsNDNh05o8s7YKgYAvZt5wiJyHkXxc1qZOSYkA2vRSNRU
 jQdld2696nsjJC1k6Y9U2Tmy2I5iQER0SqrZv6adt1vtsA8SlDPn0uz7b8Dne7xWdT06
 Na+whSWlvZGlwpvyaZjUhzzUIQ4CtMC8mSTheGtMGNXu0m+f45dWvXrNBT3I5ioROmqV
 FCEOGsRjyroVNMaI8hus288FPIE+IbsRpzId4Co86fCj3TXg5RnhAY1xLMU23wOs2iyg
 wCoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw418QrfYTwtMxBltU/oLmowjp37+P2aX2IS5PXdjy+Dz9/KDUpMQQpGtPmz1f6vGNYcWE0v9p5vtXz@nongnu.org
X-Gm-Message-State: AFuF++k709aAwZpYEC/BLmr54IdqC0XtbuspMVJbdQ+v21CU1hipTsLc
 VRenJbsfKhnUUCEBaFNptCZ/HmfB1k3FGDRty0DU42/cvfIsbkI7XOVpjqRovRPJid4a3xPMKNl
 +M2CKcOh/rvYJfbX/5GJ4FJoNeUsJ1hBShZKp0iGYKiOUL4DZ9jMKUICq0A==
X-Gm-Gg: AYBFou1l9WgFP4iPYjTBY8we0TUm9S7H6KatKugHU+3e/gBkqWKByUBRX2wZiw37aN+
 Aldppc5lYtmhz/hvcChS7OMRiIUZUSmvVOf/PFYK3+SNu5ltF8mXB9JDTBZYylqOSEXazHfiRZW
 omcvz9vZZy6nEtRy34xCSe1KdbNOdhjJUv3/Ueysp4gphGFRPnRbgjmsSWw+iEBkqkEafD9L7I8
 2qqlSZoqGCoaIys+U9ckXvFGKCAfUCql5cBfxB9UzV95oe7E8rOEA1DtWCNCwVL5Mxuy6hFCdQn
 c2D6E0S3u9fO9XT024jwjQ3UlCsU9gCFbBaRKihhgWeCLK1amIeM1VuHHiV0c7pgif9TuPadI6J
 DB/jSEqEWXEdcK01B7ycSJeDFxv48wnlbeQ==
X-Received: by 2002:a05:620a:2681:b0:939:bc7c:15c8 with SMTP id
 af79cd13be357-93ebd237079mr30598185a.45.1791502752487; 
 Thu, 08 Oct 2026 16:39:12 -0700 (PDT)
X-Received: by 2002:a05:620a:2681:b0:939:bc7c:15c8 with SMTP id
 af79cd13be357-93ebd237079mr30588785a.45.1791502750815; 
 Thu, 08 Oct 2026 16:39:10 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9acc936sm741567f8f.44.2026.10.08.16.38.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 16:38:56 -0700 (PDT)
Message-ID: <8460c0a8-f68c-403f-bc6f-0477430c31de@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 01:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/hvf: Retry RAM write faults only for dirty
 logging
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 "Scott J . Goldman" <scottjgo@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-stable@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20261007093001.74476-1-philmd@oss.qualcomm.com>
 <f0c07762-c115-41a0-b713-a47bdaa1f218@rsg.ci.i.u-tokyo.ac.jp>
 <478c0311-b31e-4d38-af65-79508fca3021@oss.qualcomm.com>
 <6f694401-3cc9-4c76-aa2d-3625773823c7@oss.qualcomm.com>
 <be98c53b-d01f-4beb-8915-cc73f22e839a@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <be98c53b-d01f-4beb-8915-cc73f22e839a@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0Mk5w7bA1g4vW2jG2AwrkfYV5q08-mCg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA5MyBTYWx0ZWRfX1nPeJyAHXBJL
 VVgfSTLqoPuw9aqr6PDnsnyZKuAGfaCJyH+YeF1w1y3J/EU4PJrNcZq+VhiqC9u1j6zEBzjF1RW
 nkc0pEUy2VpNW3AD7tzz8v7G3YiWD2s=
X-Authority-Analysis: v=2.4 cv=Cs0q4X4D c=1 sm=1 tr=0 ts=6ac829a1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=_3kiw-qOTz70AaG6LiUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA5MyBTYWx0ZWRfX2GD79D2ZxRtD
 n0Cr2O1daHVL5KdfNG51f3/3tiZuw7v2KYfvkSXs774tlkQmvxz29+clNS3X00XBv2ZfMeGt9Zs
 mBVgqsQQdIKwbzg0wGyTrG440FyvQ3hMrmfbc2WjJ8NUd0TorxHKPy1CVlyA0A0SGHbby1XhOE1
 EE4A5aM8RlqZLwaMzQAepNXfxyfC0uWKov5X7vE5b+qwlQgp0SjrwlWPIZhUhq4qCC6mFqXg+B8
 P83fAuY2qBsxLJCxUuA04cMvOrtadI4aG33yku/Wc31TJbUade0KffZ5Tv2vK9RcdbNawFyA7/h
 gajWGKDRu5cGE0F2DHKDUbqjmK1G+Tt0sJWXzNOpLb5fNZfO74J9iAiUAxls7ZUjWtIipmqUzlq
 htCZiUTKYnQaKW8MPmEpsE/0D5oerwifIC2UOzova8KNbpDPvlED4JRhKcIK9hbK1Cyu8ZRb4yD
 vtVKxqROywi39DmpTRg==
X-Proofpoint-ORIG-GUID: 0Mk5w7bA1g4vW2jG2AwrkfYV5q08-mCg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 8/10/26 07:52, Akihiko Odaki wrote:
> On 2026/10/08 7:05, Philippe Mathieu-Daudé wrote:
>> On 7/10/26 21:50, Philippe Mathieu-DaudÃ© wrote:
>>> On 2026-10-07 16:50, Akihiko Odaki wrote:
>>>> On 2026/10/07 18:30, Philippe Mathieu-Daudé wrote:
>>>>> From: Mark Burton <mburton@qti.qualcomm.com>
>>>>>
>>>>> Dirty-page logging handles a RAM write fault by marking the page 
>>>>> dirty,
>>>>> restoring write permission, and retrying the guest instruction.
>>>>>
>>>>> The handler also retried when the resolved RAM region had no dirty-log
>>>>> client.  This path neither restores permission nor advances the PC, so
>>>>> the instruction can repeatedly exit to QEMU.
>>>>>
>>>>> Retry only after marking the page dirty and restoring write 
>>>>> permission.
>>>>> Otherwise, use the existing emulation path to complete the access and
>>>>> advance the guest PC.
>>>>
>>>> I can identify three cases of RAM write faults. The existing code
>>>> handles all three, but this patch breaks the third:
>>>>
>>>> 1. The RAM is read-only. assert(!mr->readonly) trips in this case.
>>>>
>>>> 2. Dirty logging is enabled. The vCPU marks the page dirty, restores
>>>>     write permission, and retries the write.
>>>>
>>>> 3. Dirty logging is enabled when the fault occurs, but another thread
>>>>     disables it before the vCPU acquires the BQL. The vCPU then 
>>>> observes
>>>>     a zero dirty-log mask. The write still needs to be retried because
>>>>     write permission has already been restored. The existing code does
>>>>     this correctly, but this patch falls through to emulation instead.
>>>>
>>>> This patch is useful only if there is another case that the existing
>>>> code does not handle correctly. Please describe that case and preserve
>>>> the retry behavior in case 3.
>>> Thanks for the deep review.
>>>
>>> The reporter said:
>>>
>>>    We reproduced is a level-2 translation fault, DFSC 0x06, on a
>>>    dynamic DMI RAM leaf that has no corresponding HVF mapping.
>>>    address_space_translate() resolves the leaf as RAM, but the dirty-log
>>>    mask is zero, no page is marked or unprotected, and the unconditional
>>>    retry makes no progress.
>>>
>>> That would be another case:
>>>
>>>    4. FlatView says RAM, but HVF has no mapping (nothing has changed
>>>       to make retry succeed).
>>>
>>> So to prevent retrying a known translation miss that cannot make any
>>> progress checking DFSC could be sufficient:

(also reproduced DFSC 0x07, but now irrelevant).

> Checking DFSC specifically for a translation fault feels arbitrary. The 
> broader lesson from case 3 is that the faulting condition can be 
> resolved concurrently before acquiring the BQL. That same race window 
> applies to case 4. Instead of matching on DFSC, we should re-check 
> whether the faulting condition persists after acquiring the BQL.

I don't have direct contact with the reporter, so guessed from the
"dynamic DMI RAM" report which misguided me (no clue what is DMI btw).

> 
> Filtering out s1ptw also seems extraneous. If the page-table memory 
> requires dirty logging, we should handle dirty-page tracking for it 
> rather than skipping it with an additional guard.

Done (IIUC) as a separate patch.

>> However I had to do this change in hvf_set_phys_mem():
>>
>> -- >8 --
>> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
>> index 8bd9154a50b..7b34a5f586d 100644
>> --- a/accel/hvf/hvf-all.c
>> +++ b/accel/hvf/hvf-all.c
>> @@ -113,8 +113,14 @@ static void hvf_set_phys_mem(MemoryRegionSection 
>> *section, bool add)
>>
>>       if (!QEMU_IS_ALIGNED(size, page_size) ||
>>           !QEMU_IS_ALIGNED(gpa, page_size)) {
>> -        /* Not page aligned, so we can not map as RAM */
>> -        add = false;
>> +        return;
>>       }

>> hvf_vm_unmap paddr:0x0000000010001000 size:0x00001000
>> qemu-system-aarch64: Error: ret = HV_BAD_ARGUMENT (0xfae94003, 
>> at ../../ accel/hvf/hvf-all.c:123)
>> Abort trap: 6

> The change to hvf_set_phys_mem() fixes error handling for misaligned
> memory mappings and is worth submitting as a separate patch.

Yep, done.

> This also implies case 4 isn't fully understood yet. Ideally, whenever 
> FlatView resolves a region as RAM, HVF should have a mapping for it. A 
> host-page-misaligned region is one scenario where HVF cannot create a 
> mapping, but that previously triggered an assert (HV_BAD_ARGUMENT), 
> ruling it out as the reporter's original root cause.
> 
> Please investigate why case 4 occurs and whether HVF can map the RAM
> directly. If emulation is required, we should check for the specific
> condition that requires it rather than treating a translation fault
> alone as sufficient.
> 
> Please investigate why case 4 occurs in practice and consider adding a 
> missing mapping rather than relying on emulation. If emulation is 
> genuinely required, we should check for that specific condition rather 
> than assuming it for a translation fault.
Per the report QEMU v10.2.0 works and v11.0.0 doesn't. From there it was
easy to test up to the 6d0a5a44560..58bc47fd1c6 range. Testing commits
d1f4ba9d94c and 7d7654a643f was painful due to the amount of changes but
in the end bisection pointed at commit 58bc47fd1c6.

I followed your "Instead of matching on DFSC, we should re-check whether
the faulting condition persists after acquiring the BQL" suggestion,
since DFSC is only an indirect indication of a missing HVF mapping.

We are already with the BQL but now we assert it. Add added mapping
tracking in hvf_set_phys_mem() using an IntervalTree so can check that
back in the dabort handler before emulating. I am not checking vs
FlatView because I don't understand yet if this is necessary. Also I
need to implement the begin/commit MemoryListener handlers so the
hvf_set_phys_mem() is protected, but I might leave that as TODO and
post a v2. Testing is hard.

Thanks for your review and guidance :)

Phil.


