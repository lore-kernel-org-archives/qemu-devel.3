Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1CCC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk1Z8-0000nN-Am; Wed, 15 Jul 2026 11:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk1Z2-0000mw-Po
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:30:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk1Z0-0001zX-B0
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:30:24 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FE4Th84025767
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 15:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5xJg4LXlBSIiAxL5knxJDRRvUc7MWPyaYrTcMLIM7bY=; b=Wcssuzo2DDh/S1EY
 YncFp6JrUyYFT2bJ+TkvKievDPFvSKULbjKHMQGO26rTqj/cJqnJomKLDBDhvG9D
 4JIdWuylHCpScQbCTnGmrCcDelZOpCv5JvUmEyNAdKVEVXzfCGNVFxEiW+0c3DkV
 6HXl9bAggcPw0C23iOJLpifZ/8QXKhMLMSeBn9mYxwyJoGo/BOe43MsJ6spYCJvU
 +o6P/UOYWgbF7ms+EPON8oJewMBiXNfezwEu0I3btXaSIeiAOHoYIbUKF2TcGtfC
 NGpN0VsfAdZBsfYsGFS878NjySTSJ4WZ74Uty5Ls2MhI3wyILMnTbvdMtZvNCP7S
 sm5hBQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe03vk2b6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 15:30:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc7e86e7c5so104357055ad.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 08:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784129417; x=1784734217; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5xJg4LXlBSIiAxL5knxJDRRvUc7MWPyaYrTcMLIM7bY=;
 b=KZgSwbpGq1OKdWHYi/ELX/0htbGBzfvFdAHTDo3Stacp8+O1nhQTb9K0u1B3hvL8E7
 DUdIZmW07kagcNPPvV1LPowp0xagL7nOYHBn9L+6FAf+AVK41tQdniVXMP/sMcj2AAZz
 ty5jGF9VpBo5b3bERMLAxDQM54BiG71eYjy/xGG5HVu+c3KdoiLKqoK9VaMmSqYoXc2v
 G4l7fSw3EBK/QQmPpOiClb/07PBTXXEptwjddi9MUm5bFZWpob85RhL7i/kyTuQTkY/u
 Q3m271SthLr1OVb/t0A9FrdoeM8UO4nMpqf7ktZEQthOsx8OIPgVs7Go2Rs31abgz/QI
 nUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784129417; x=1784734217;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5xJg4LXlBSIiAxL5knxJDRRvUc7MWPyaYrTcMLIM7bY=;
 b=pcBTb8OPR0GyEsfmAam/c9cips+mvLJtyeAGKv3v23+nHbpxQ7egmG8Is/1Y7uyJSR
 IHwHgISiuKeFOW0OsdpR8Mz3Yn5Bunu2mc44GYuJzrbkShGYriD5J1xygFxcuAO5aZEi
 o11X9BtsLhDJClfwX5+NW0yd2cSJi+6INzgQ6hWPfg+F8FcYPdWqjGmqWBtize+6OXd+
 d305lTiklFpNjdMgIVSHpYqYDGI2XqATfM/b+8cfGSMx8dPBAMeJSsnZENW/roDuRAVi
 tshNDwMmkpDxgznVVSsuj66jEowRC1poSxRhnQxxlnHogxqq87BXzDSe4SA6Bm8q74L2
 loAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYnB7bcKEFCBEifb006f+B/ouX58KcqC88prnMbmXaWUpsC8VEKTQmPPfSWojZIYaoR1Mak2ASpUiv@nongnu.org
X-Gm-Message-State: AOJu0YzhK97wSsyDpmZzclnW7Jd6FOB9v5Y2WLKRQSb5UextgI9Bj9UP
 //PkRKywJ62pjsWKoVo3L3YzYfatF6nolfMe6DXVUFh8sVjwMutSXmuVdAVhSWCFs8L1HmHtt/c
 auVdRwheFv5/T9oCdDST06vIiZ1Bk21yc2a6/l7jVK6Us59MzQP81kYvQxg==
X-Gm-Gg: AfdE7cnoXDje6TSt87SrsAh1X2sPPMDqjJGNZ7qVjOCriTU1Q3fhXugSryXiXUMQSLA
 6sty9pdTGIhXHhMezNdiZinsqbjvdxuwZbOX/a+ALdWmJwirqnISj6XZSQrELUVZhGs3mhnMvcG
 KRZt2CgizX194v1n29R/489/Mq4KuNcztQsps1FP0R9DO/0pIGc2vYe1SbwlfTHqkagYaN7vsaU
 S0pkWULuKC+4EqeT9TryxGJSeisGAt3v8G/OcQouTq9HTFEebvr70pseynK2sojfe6uOg3JwGXA
 JCVCBF4fPUDwPipCtFM4O6omf14kHGKtuGQn1kno6Ib7JQP0UndlxCCYuuvuYbkMZelv2dvnR0T
 SS/FQdYZmK8oiTw0qrUHB8Oz9+SOmrwHb0eteGC4hM+sb0Sxtw/8maKn3h2PvksGmNg==
X-Received: by 2002:a17:903:3886:b0:2ce:e75f:b713 with SMTP id
 d9443c01a7336-2cf03cef5a9mr29858865ad.23.1784129416727; 
 Wed, 15 Jul 2026 08:30:16 -0700 (PDT)
X-Received: by 2002:a17:903:3886:b0:2ce:e75f:b713 with SMTP id
 d9443c01a7336-2cf03cef5a9mr29858385ad.23.1784129416264; 
 Wed, 15 Jul 2026 08:30:16 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf105b244asm4243315ad.61.2026.07.15.08.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 08:30:15 -0700 (PDT)
Message-ID: <100b70e6-9b5a-4dc7-967c-924a80c09cef@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 08:30:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] bitops.h: Add find_first_bit32()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 ltaylorsimpson@gmail.com, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 philmd@oss.qualcomm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
References: <20260714155126.3509544-1-brian.cain@oss.qualcomm.com>
 <20260714155126.3509544-4-brian.cain@oss.qualcomm.com>
 <32acc813-37ae-4708-a842-7d7958b7d388@oss.qualcomm.com>
 <CAFEAcA9Smft=r25PJEDiSg6sF-006xLvq56iFWKW+WHWwATUSg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA9Smft=r25PJEDiSg6sF-006xLvq56iFWKW+WHWwATUSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ife3n2qa c=1 sm=1 tr=0 ts=6a57a789 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=m4EvXZsGAIpaEwscJbEA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: Gvk1jwndjPdykDq3GI11kUW9RJ9lrmWj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE1NCBTYWx0ZWRfX7bDeVzzteN3q
 B+chZnCIYTqPEPuRxc1tbif4vXMoTplvV6Nh//sAyJ4PjIJlsRTCPt5f6iFprntY6kSm1ET36mG
 Vy1++vuvXip785ox5/2kZVXU4/RfJ3WM9Io4wy1d/uDSXPuBh12POOSHwYoSEWJtWY49IA8DJST
 pS3lWvzSqkrrtyjofPbde0LeDAiWSTteyXVsZUZ3JGs7vGpXGpnkS4eWS2nSgMc+nZ/sS9IpRR1
 nKwKnSQL5LeSSVlo4cqS3NxiSJPbIhrDgVTuE08yuZt8k5yGlHIV1KlMVMnVJkt5MJsPJtzhBBx
 pI1aGZRTgrnUYAxoFHr3KHSjnybWoM5AdzNLf8ms/qekZ3JNvtEmtkpoqczW2GH7kYOkhwA+4j1
 elQo4eHfl32Q0o9HDmj94tyBI2TH+f+IMX19rmeL6f/YCheJ3tEvGKq+4FeHvRmjki2D6WT7pBW
 JZuLCe6tUgqOpaV7z8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE1NCBTYWx0ZWRfXw+SQ+uJcAytb
 etZm14rITBh7aBtpBZPsVEHgGR6IU6Fq29EEUMEc2yIeQJIaXM81ACreAPELfwi0G2NSgQhOB4y
 KghQZX9p0tEdO4iTCDtDpjgEB4hD8NE=
X-Proofpoint-GUID: Gvk1jwndjPdykDq3GI11kUW9RJ9lrmWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150154
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

On 7/15/26 3:01 AM, Peter Maydell wrote:
> On Wed, 15 Jul 2026 at 02:18, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 7/14/2026 8:51 AM, Brian Cain wrote:
>>> set_bit32()/test_bit32()/etc already let devices operate on
>>> guest-visible uint32_t register arrays without depending on the
>>> host's 'unsigned long' size. find_first_bit() has no such
>>> equivalent, which pushes callers towards casting a uint32_t array
>>> to 'unsigned long *'.
>>>
>>> Add find_first_bit32(), implemented the same way as find_first_bit().
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> 
>>> +/**
>>> + * find_first_bit32 - find the first set bit in a memory region
>>> + * @addr: The address to start the search at
>>> + * @size: The maximum size to search
>>> + *
>>> + * Returns the bit number of the first set bit,
>>> + * or @size if there is no set bit in the bitmap.
>>> + */
>>> +static inline uint32_t find_first_bit32(const uint32_t *addr, uint32_t size)
>>> +{
>>> +    uint32_t result;
>>> +
>>> +    for (result = 0; result < size; result += 32) {
>>> +        uint32_t tmp = *addr++;
>>> +        if (tmp) {
>>> +            result += ctz32(tmp);
>>> +            return result < size ? result : size;
>>> +        }
>>> +    }
>>> +    /* Not found */
>>> +    return size;
>>> +}
>>
>> Either we should express size in terms of number of elements, or add an
>> explicit check if size is not a multiple of 32.
> 
> I think we should follow the API of the existing find_first_bit()
> function here, which defines the size in terms of number of bits.
> 
> Sizes not a multiple of 32 should work fine -- the representation
> is "bit 0 in LSB of first 32 bit word, working upwards". So e.g.
> an bitmap of 16 bits has the representation "a single 32 bit word,
> and the bits are in bits 0..15". The code correctly handles this
> with the "return result < size ? result : size" logic: even if
> bit 17 is set, we will return 16 to indicate "no set bit in bitmap".
> (This also follows the existing find_first_bit() handling.)
>

What I had in mind with 'add an explicit check', was to make sure we 
don't read the last entry if size is not a multiple of 32.
In case addr is a buffer, we might read past its last entry.
But maybe it's not a concern.

> thanks
> -- PMM

Regards,
Pierrick

