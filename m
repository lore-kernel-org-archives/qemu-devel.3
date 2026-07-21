Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B000C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7w2-0000iO-Ka; Tue, 21 Jul 2026 06:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7va-0000WZ-9G
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:42:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7vX-0003L6-Jp
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:42:21 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARNdT945886
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a7QHCnzD4BF74s82zr8Injph0M3iXP/uMX3JZZIlWfo=; b=dYJUdpjNFkp76Io7
 5ArELASqgaOh74nH/yaRfAaQFW0KDKTaoq4rpBzYiojnmP6tmMoWGlNDuskh8lW9
 0j3R2Le0nBwks+1FZIEvA8++eoVPW3y14sEEYemCWBafVEvEx0sVKBcvHb/J2ZVx
 5h3rxQDb7v1DWWXwImWvb6xph+plz01zBD4W8ssOXnakb24L2cTbA1v9IbovmTCj
 n6CnhNaUi0oCZwn/X4qAfxFRX9vMAeYlzBfgPEDxy/M3HjW9RWKT1+65U8+NSMA+
 UntQ4rW/D7//IBlSp9ahGpRkSAdqm8AYiVFsfenQ8imF40KT0q79OT8sYJZgHxbU
 2KNBMw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1es1sp1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:42:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso228813861cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784630532; x=1785235332; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a7QHCnzD4BF74s82zr8Injph0M3iXP/uMX3JZZIlWfo=;
 b=Ioad8R5znpkO+Onaz8uPZcRDGqxae5VKL/0EZx7Cf5Vf28T2ojNE09zpuxUu/32eYp
 OGYPFLGKuZzfTQiT/tRdVoTU+/3NncNrierfa2BJfNt2Yn6HLREJRYC2Afr96de1uFwa
 Bf6N9kEGT2zoWNUegezwmWvRXAsp1uByCuOuuqyqIWgxwoQehJP/aqqW2e15IqB975zu
 Oa1TMqii4WSItqy7TqgoEx7CO0ykUykBMs1pGhS6WVJyI63esXWQd9zm+eUHxIFhvyGm
 6QfNudRAfSJtz//cNgyfOgK5om348N5U/i6NrbIkrpk4SykSemMqhV/JI1LFvGeh68j5
 2YGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784630532; x=1785235332;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a7QHCnzD4BF74s82zr8Injph0M3iXP/uMX3JZZIlWfo=;
 b=Ry38GuRkwyxRGIxslteX+OqZblpC6hOOq0mNV5o1LIva8IWrWLIiZ5SZyb1ypZMCr3
 9S5NMsy5dh6N7oMgltXWm+1O4XD+eX2I1p8i75XVovYWhshYvTiyUeFYjbnZ1vGAw0hl
 JzRC3CoSrM3++UE0MpJWqf9Ttb65sEPw1gdiQSkpylGlS5OcpSH/5S1oEmtJBY5Bdzah
 XUtTtH+iejpYFAt6HMfVN87lUIvkNHu6CZiHXzlfuB9n7UjC6XNyLD9ikKKOhD1Bi/B3
 88QA3LjPyJ8ADvl6upj03dT14t47De4FPwnOhwDS3Hve7dsh85UrgJOlexh0k2G/bsBc
 zlyw==
X-Gm-Message-State: AOJu0YyF/QnwKE4y05eVL97gQvGK8vXRYrU7VoP0C+89/dIGazCxI0IU
 3kovZr/jkypkfB6e/lNZvgGwF482ND3Gv50whrVju2wv3aG27tDXvDnmUobJIsHMVwHRZuQbp2j
 2jKv4XtN5YkNiPrOWyFt+IdnGHVQKNGSqMs4XrGNFnoZp0UktUJMiCRBRcjJdUqRzBA==
X-Gm-Gg: AfdE7cmRtgbK3XzCs5rgXfz69qtDcXllP0XSVVFkcMKOR3BU0NvXgvILwndakEmnuvD
 yz8Vo+0kCyqnel3iMkH9R6mj5BOPaWpj0z+durjkgoeKJMpiUTz+XsvMtbX89/G5M1aRw7fd8q/
 ll4fAhITy2gTdb8H624ooonPmfg2TrGIgTJdAvjD9ej+ranax26FWf3iwFYQPxDsDEBHGnyhs8w
 WSVSWjKYW+lm0aOvA4nCQvVA2yg0Jp70yuoHJ2t8fUm9FNBF/zJnhoyTegqFV35oofhJ1BnJI8t
 yr35gM5aPSKTxgvIKO6gqyUzh1+ty9QORQMt++GrOBHHO7uJZuD1LnKkg0cz/ygILdyDM+xHYir
 oLMQ7+1eQP9gwCXn/bTvdBMP4TuOYlaOfIGR85RI4eJKLZTjCtTk=
X-Received: by 2002:ac8:5a83:0:b0:51c:2022:cf0b with SMTP id
 d75a77b69052e-5213e08255fmr168019801cf.56.1784630532317; 
 Tue, 21 Jul 2026 03:42:12 -0700 (PDT)
X-Received: by 2002:ac8:5a83:0:b0:51c:2022:cf0b with SMTP id
 d75a77b69052e-5213e08255fmr168019561cf.56.1784630531828; 
 Tue, 21 Jul 2026 03:42:11 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm62038735e9.3.2026.07.21.03.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 03:42:10 -0700 (PDT)
Message-ID: <26ad904f-7f15-4ccb-a9c0-3c3bc279a283@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 12:42:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/sd/sdhci: Extract uSDHC-specific quirk
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, qemu-block@nongnu.org
References: <20260719211923.1079282-1-shentey@gmail.com>
 <20260719211923.1079282-3-shentey@gmail.com>
 <CAEUhbmWhqc+_7MQA3Y9ZG9vwBjsbE4-w3tsx7Ep1CbBHze3Mcw@mail.gmail.com>
 <897E12B2-A6E5-4524-9983-FA861A7FDDD3@gmail.com>
 <CAEUhbmXT9ajeFMz8_1GsCWZJU-FmkYXTPZd-pfYQ2A45Qm7hFQ@mail.gmail.com>
 <D1B4AD96-B24C-4448-9B83-8D319997E768@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <D1B4AD96-B24C-4448-9B83-8D319997E768@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SPZykuvH c=1 sm=1 tr=0 ts=6a5f4d05 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=proTBXr5w31yIQllR1sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: tXWU1Ixi5CrGGgH0bFlojpE0MUqPyNac
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExMyBTYWx0ZWRfX7gzMjG1vDWzm
 e6HPjlApvw4XWHi8RlGlya9x6chkJ2l9IMhrK8Nh2axJc1UTBMZb0nPek4Thg1nscaJ8YCU1/ZP
 u4KUgVH1CXe9VOFzWEElz1OOGX6aDk65z2cInTvpemgUoCZqgP44vc5iUI3IdBjr4mcHakbZ060
 7SwwSB9Flploq4drQ570Ls8qW4gdZE0TrVxd+bDh2282qbmRCtN9kp3m2IdAwGOILEIH1SAAZ7q
 4YwU1l922zFi0DbcJkBTPkEA9U5jQvS6TwwFOLm5g8Q2ev43g6N4dNe3qoihue/WHgI1FZyCBM+
 7SBj3vFDu33i9HHFLzk1wt7zAEx9XSXTga4OvndS0F2UucJkLntldwLg0hFwsaOh9ipgkAsazvM
 8usWONV+E8PKb6fEtkOISl0cfqtp4l5V0Woi7qAxdTjN9qohtgHtrXCjfLISfDnWCIOZzPMOJnz
 M7yIAqTDZQ68DKkzanQ==
X-Proofpoint-ORIG-GUID: tXWU1Ixi5CrGGgH0bFlojpE0MUqPyNac
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExMyBTYWx0ZWRfXwJmfHWNVInUr
 scCdbv30n5Xi7yqXcUC57HSozExCeSsApwyhGdKMetkgFZsV9VER7AgkTFKdyhS0rL/bakXzEsQ
 91HXyNjskUxMvmJunEug3y1FIE52UZg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210113
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 21/7/26 12:29, Bernhard Beschow wrote:
> 
> 
> Am 21. Juli 2026 08:38:19 UTC schrieb Bin Meng <bmeng.cn@gmail.com>:
>> Hi Bernhard,
>>
>> On Tue, Jul 21, 2026 at 5:11 AM Bernhard Beschow <shentey@gmail.com> wrote:
>>>
>>>
>>>
>>> Am 20. Juli 2026 14:50:24 UTC schrieb Bin Meng <bmeng.cn@gmail.com>:
>>>
>>> Hi Bin,
>>>
>>> Thanks for yor reviews and R-b tags!
>>>
>>>> On Mon, Jul 20, 2026 at 5:19 AM Bernhard Beschow <shentey@gmail.com> wrote:
>>>>>
>>>>> In Linux, the ESDHC_MIX_CTRL qirk is guarded by esdhc_is_usdhc() while
>>>>> the eSDHC code path uses the standard SDHC interface. Extract the quirk
>>>>> into a new `usdhc_write()` function.
>>>>>
>>>>> Fixes file system corruption on emulated i.MX53 where Linux'
>>>>> esdhc_is_usdhc() returns false. The same likely happens on e500 and
>>>>> imx25-pdk machines.
>>>>>
>>>>> Fixes: 75e98bc4f859 ("hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE")
>>>>> cc: qemu-stable
>>>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>>>> ---
>>>>>   hw/sd/sdhci.c | 73 +++++++++++++++++++++++++++++++--------------------
>>>>>   1 file changed, 44 insertions(+), 29 deletions(-)
>>>>>
>>>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>>>> index c86dfa281f..e58a610397 100644
>>>>> --- a/hw/sd/sdhci.c
>>>>> +++ b/hw/sd/sdhci.c
>>>>> @@ -1795,34 +1795,6 @@ esdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>>>>>           sdhci_write(opaque, offset, value, size);
>>>>>           break;
>>>>>
>>>>> -    case ESDHC_MIX_CTRL:
>>>>> -        /*
>>>>> -         * So, when SD/MMC stack in Linux tries to write to "Transfer
>>>>> -         * Mode Register", ESDHC i.MX quirk code will translate it
>>>>> -         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
>>>>> -         * order to get where we started
>>>>> -         *
>>>>> -         * Note that Auto CMD23 Enable bit is located in a wrong place
>>>>> -         * on i.MX, but since it is not used by QEMU we do not care.
>>>>> -         *
>>>>> -         * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
>>>>> -         * here because it will result in a call to
>>>>> -         * sdhci_send_command(s) which we don't want.
>>>>> -         *
>>>>> -         */
>>>>> -        s->trnmod = value & UINT16_MAX;
>>>>> -        break;
>>>>> -    case SDHC_TRNMOD:
>>>>
>>>> Looks like this register is not eSDHC specific?
>>>
>>> Not quite sure what you mean exactly. The SDHC_TRNMOD isn't eSDHC specific but as per the comment above trnmod partial handling is deferred here, i.e. needs to be intercepted.
>>
>> If I read the Linux driver correctly, I think we should do something
>> like below when writing to SDHC_TRNMOD:
>>
>>   case SDHC_TRNMOD:
>>       if (is_usdhc) {
>>           val |= s->trnmod;
>>       }
>>       sdhci_write(opaque, offset, val, size);
>>       break;
>>
>> Because for eSDHC, the transfer mode is already passed in the value,
>> and oring previous s->trnmod may cause some bits being set to old
>> previous value unexpectedly. Please double check.
> 
> By moving out of esdhc_write() into a dedicated usdhc_write() method we achieve exactly that, no?

Indeed this is kind of hidden, see below.

> 
> Best regards,
> Bernhard
> 
>>
>>>
>>>> I looked at linux
>>>> driver source codes and suspect we may need some more turning here
>>>> other than uSDHC only.
>>>
>>> Yeah, there is certainly a lot of room for improvement. I have some clock-related and SDMA buffer boundary patches in the pipeline which are necessary for satisfying U-Boot. But that's a story for another day.
>>>
>>> Best regards,
>>> Bernhard
>>>
>>>>
>>>>
>>>>> -        /*
>>>>> -         * Similar to above, but this time a write to "Command
>>>>> -         * Register" will be translated into a 4-byte write to
>>>>> -         * "Transfer Mode register" where lower 16-bit of value would
>>>>> -         * be set to zero. So what we do is fill those bits with
>>>>> -         * cached value from s->trnmod and let the SDHCI
>>>>> -         * infrastructure handle the rest
>>>>> -         */
>>>>> -        sdhci_write(opaque, offset, val | s->trnmod, size);
>>>>> -        break;
>>>>>       case SDHC_BLKSIZE:
>>>>>           /*
>>>>>            * ESDHCI does not implement "Host SDMA Buffer Boundary", and
>>>>> @@ -1891,9 +1863,52 @@ static void fsl_esdhc_le_init(Object *obj)
>>>>>       qdev_prop_set_uint8(dev, "sd-spec-version", 2);
>>>>>   }
>>>>>
>>>>> +static void
>>>>> +usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>>>>> +{
>>>>> +    SDHCIState *s = SYSBUS_SDHCI(opaque);
>>>>> +    uint32_t value = (uint32_t)val;
>>>>> +
>>>>> +    switch (offset) {
>>>>> +    case ESDHC_MIX_CTRL:
>>>>> +        /*
>>>>> +         * So, when SD/MMC stack in Linux tries to write to "Transfer
>>>>> +         * Mode Register", uSDHC i.MX quirk code will translate it
>>>>> +         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
>>>>> +         * order to get where we started.
>>>>> +         *
>>>>> +         * Note that Auto CMD23 Enable bit is located in a wrong place
>>>>> +         * on i.MX, but since it is not used by QEMU we do not care.
>>>>> +         *
>>>>> +         * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
>>>>> +         * here because it will result in a call to
>>>>> +         * sdhci_send_command(s) which we don't want.
>>>>> +         *
>>>>> +         */
>>>>> +        s->trnmod = value & UINT16_MAX;
>>>>> +        break;
>>>>> +
>>>>> +    case SDHC_TRNMOD:
>>>>> +        /*
>>>>> +         * Similar to above, but this time a write to "Command
>>>>> +         * Register" will be translated into a 4-byte write to
>>>>> +         * "Transfer Mode register" where lower 16-bit of value would
>>>>> +         * be set to zero. So what we do is fill those bits with
>>>>> +         * cached value from s->trnmod and let the SDHCI
>>>>> +         * infrastructure handle the rest
>>>>> +         */
>>>>> +        sdhci_write(opaque, offset, val | s->trnmod, size);

                                            ^^^^^^^^^^^^^^^

>>>>> +        break;
>>>>> +
>>>>> +    default:
>>>>> +        esdhc_write(opaque, offset, val, size);
>>>>> +        break;
>>>>> +    }
>>>>> +}
>>>>> +
>>>>>   static const MemoryRegionOps usdhc_mmio_ops = {
>>>>>       .read = esdhc_read,
>>>>> -    .write = esdhc_write,
>>>>> +    .write = usdhc_write,
>>>>>       .valid = {
>>>>>           .min_access_size = 1,
>>>>>           .max_access_size = 4,
>>>>> --
>>
>> Regards,
>> Bin
> 


