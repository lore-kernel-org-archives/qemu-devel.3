Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24864C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZXG-0004Bu-3s; Fri, 07 Mar 2025 10:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZXE-00047k-32
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:22:48 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZXC-0007Ug-4V
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:22:47 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bdc607c16so15516285e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360964; x=1741965764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mb//xinM30vegk6aHiJzczJ1WiKP8BqLuew4qetSOXA=;
 b=l9uE5TCKZ7h3xRsCVTM3jKHI9L1VDvYSEIsulkBVKA77rqpVc7wVwrnYEcbHq+MNOv
 GZDV+d5LT25LqvVj2Zj5Fy6grbdxUWLZJ+EYgvgwGRcbp3jRzL1JulPwiKnxOk+Un02B
 RiRpOdjKruRr6LHzi1p/Ijph6dNwP5kmUVNop1o/4u8r81xe6QS+pOK3AGmJT2xb3qIi
 Bb8iySpx0ApfjoqeSZ351D6PNVGTscRSg0nqUgoOg6KsBkrD+iBvCr2NQrXpJRXarR9U
 hpAIg5dGAVUp42M0mDrffzI7lnCQTegNC1A48ajylR/dmgOc3BfOLTm0Jftt88Bom8B2
 4BRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360964; x=1741965764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mb//xinM30vegk6aHiJzczJ1WiKP8BqLuew4qetSOXA=;
 b=aKT9XA0y7Nzb0/Xng/GsoEtKYtZ8p0qPEkvj42h9/v8xxaHuR58vaKWiT/HIXRiy0w
 rcvQyaAo0tO7xg3fzt3rHHRJUAHyKzHDsbf62OtYpanUuTfawneXSvB/wdg0t2naqal7
 bO1eTaVrdmBlfQrNXy90Jy0cdMrb6JywfJORRS4ZwOhA2N8bGBExEluWoWrpXKJm6ETj
 x0JUNV5QkrR+qOytnixI/ehrLucXzOi80+pZCBXleBdO52C4MZkxAstJXuhyA9g3oo8s
 f10YYcAvdo3l9DnfCIdj1163cy392bKlbqIXLqwZOnBWAzgeDomSbsemlEvasVRyvJXr
 Ck6w==
X-Gm-Message-State: AOJu0Yx1Mg49UKxbqZdtCMLvvj/Dc7ggbBV2qIqI7m9Bx/jMT8oMZtd5
 FxYMVpdl6KYm0ZXjHfdORtGwgNMTmb8tGR8JklCXnSG5vC5Z525Z5+iQt+sfmIDmSKp+iIeh4gb
 5b1M=
X-Gm-Gg: ASbGncu0pFj+XXy0m+mqEdO1Xgv2qpa7OaOkNxL48Z/2FmYsA2kJnWDCvOF+PBiW6La
 KjgdtXj/8ORK0NLa1YyDhpl21KhHQIHYHz9dT1XQL3BN0V0YARh5s4gzBIoiruO7cHdqIErnYmx
 4RnsbXvDjWPYOj5+tXkN1/D/+ipsL2x4p+Ic6tYY4/DXS2L3FdpHFOb4Owh3UPK0kPfqHdsLfwF
 RmN1zQzkqozZQpdG3J2ghGdZa2vrOZYHj4XnWGqKVO6mU9g41m+jfsEtIFfW3qmaEDGnBp6vAHy
 X4khkqPvi/Jh9DlL0+6DAzzyMZyv+fyZU9yMDGPLxcyR6P+ZpyiB/LflYTbpdjp1YkR59rpfJgV
 39IFPrJI/lCs0
X-Google-Smtp-Source: AGHT+IGYTf13AgRJtYOw4VyCe0wasR5FMIv68Exbnwm55qmFOXmsK/g0vLBLMqIuRczM+ualfpnn1A==
X-Received: by 2002:a5d:6d8a:0:b0:38d:d371:e04d with SMTP id
 ffacd0b85a97d-39132dacb85mr2714324f8f.34.1741360963752; 
 Fri, 07 Mar 2025 07:22:43 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8b03cesm54097885e9.7.2025.03.07.07.22.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 07:22:43 -0800 (PST)
Message-ID: <3bff4d7a-56c8-44a4-8093-9a7a10699d2b@linaro.org>
Date: Fri, 7 Mar 2025 16:22:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] ppc/amigaone: Add default environment
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <cover.1740673173.git.balaton@eik.bme.hu>
 <4d63f88191612329e0ca8102c7c0d4fc626dc372.1740673173.git.balaton@eik.bme.hu>
 <84151f43-d952-4515-aee5-04f339baa546@linaro.org>
 <33e3ef97-749e-4701-4955-0e88d0eb2199@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <33e3ef97-749e-4701-4955-0e88d0eb2199@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/3/25 15:46, BALATON Zoltan wrote:
> On Fri, 7 Mar 2025, Philippe Mathieu-Daudé wrote:
>> Hi Zoltan,
>>
>> Minor review comments in case you respin (not blocking).
>>
>> On 27/2/25 17:39, BALATON Zoltan wrote:
>>> Initialise empty NVRAM with default values. This also enables IDE UDMA
>>> mode in AmigaOS that is faster but has to be enabled in environment
>>> due to problems with real hardware but that does not affect emulation
>>> so we can use faster defaults here.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/ppc/amigaone.c | 37 ++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 36 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
>>> index 849c9fc6e0..5c5585d39a 100644
>>> --- a/hw/ppc/amigaone.c
>>> +++ b/hw/ppc/amigaone.c
>>> @@ -52,6 +52,28 @@ static const char dummy_fw[] = {
>>>   #define NVRAM_ADDR 0xfd0e0000
>>>   #define NVRAM_SIZE (4 * KiB)
>>>   +static char default_env[] =
>>
>> 'const'
> 
> OK. Could be fixed up on merge by Nick or I can send a new version if 
> needed.
> 
>>> +    "baudrate=115200\0"
>>> +    "stdout=vga\0"
>>> +    "stdin=ps2kbd\0"
>>> +    "bootcmd=boota; menu; run menuboot_cmd\0"
>>> +    "boot1=ide\0"
>>> +    "boot2=cdrom\0"
>>> +    "boota_timeout=3\0"
>>> +    "ide_doreset=on\0"
>>> +    "pci_irqa=9\0"
>>> +    "pci_irqa_select=level\0"
>>> +    "pci_irqb=10\0"
>>> +    "pci_irqb_select=level\0"
>>> +    "pci_irqc=11\0"
>>> +    "pci_irqc_select=level\0"
>>> +    "pci_irqd=7\0"
>>> +    "pci_irqd_select=level\0"
>>> +    "a1ide_irq=1111\0"
>>> +    "a1ide_xfer=FFFF\0";
>>> +#define CRC32_DEFAULT_ENV 0xb5548481
>>> +#define CRC32_ALL_ZEROS   0x603b0489
>>
>>> +
>>>   #define TYPE_A1_NVRAM "a1-nvram"
>>>   OBJECT_DECLARE_SIMPLE_TYPE(A1NVRAMState, A1_NVRAM)
>>>   @@ -94,7 +116,7 @@ static void nvram_realize(DeviceState *dev, 
>>> Error **errp)
>>>   {
>>>       A1NVRAMState *s = A1_NVRAM(dev);
>>>       void *p;
>>> -    uint32_t *c;
>>> +    uint32_t crc, *c;
>>>         memory_region_init_rom_device(&s->mr, NULL, &nvram_ops, s, 
>>> "nvram",
>>>                                     NVRAM_SIZE, &error_fatal);
>>> @@ -113,12 +135,25 @@ static void nvram_realize(DeviceState *dev, 
>>> Error **errp)
>>>               return;
>>>           }
>>>       }
>>> +    crc = crc32(0, p + 4, NVRAM_SIZE - 4);
>>> +    if (crc == CRC32_ALL_ZEROS) { /* If env is uninitialized set 
>>> default */
>>> +        *c = cpu_to_be32(CRC32_DEFAULT_ENV);
>>
>> Prefer the ld/st API over cpu_to/from:
>>
>>           stl_be_p(c, CRC32_DEFAULT_ENV);
>>
>>> +        /* Also copies terminating \0 as env is terminated by \0\0 */
>>> +        memcpy(p + 4, default_env, sizeof(default_env));
>>> +        if (s->blk) {
>>> +            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), 
>>> p, 0);
>>> +        }
>>> +        return;
>>> +    }
>>>       if (*c == 0) {
>>>           *c = cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
>>>           if (s->blk) {
>>>               blk_pwrite(s->blk, 0, 4, p, 0);
>>>           }
>>>       }
>>> +    if (be32_to_cpu(*c) != crc) {
>>
>>       if (ldl_be_p(c) != crc) {
> 
> Why? Here we want to convert a value from host CPU endianness to a 
> specific endianness and vice versa in code running on the host. (We are 
> not accessing guest memory, we operate on the memory region pointer. The 
> guest is not even running yet.)
> 
> Also:
> 
> static inline int ldl_be_p(const void *ptr)
> {
>      return be_bswap(ldl_he_p(ptr), 32);
> }
> 
> static inline int ldl_he_p(const void *ptr)
> {
>      int32_t r;
>      __builtin_memcpy(&r, ptr, sizeof(r));
>      return r;
> }
> 
> #define be_bswap(v, size) glue(__builtin_bswap, size)(v)
> 
> so this is
> 
> int32_t r;
> __builtin_memcpy(&r, c, sizeof(r));

This call makes the address alignment access safe.

Sometimes we use similar API doing unaligned access and static
analyzers complain [*]. Rather than maintaining 2 differents APIs
with some corner cases in one, we could always use the reliable
one.

[*] see for example commit 5814c084679 ("hw/net/virtio-net.c: Don't 
assume IP length field is aligned")

> __builtin_bswap32(r);
> 
> versus
> 
> static inline type endian ## size ## _to_cpu(type v)
> {
>      return glue(endian, _bswap)(v, size);
> }
> 
> which is just
> 
> __builtin_bswap32(*c);
> 
> The second one makes more sense to me and don't see why I'd want to do 
> it in a more cumbersome way when we end up with the same result but 
> simpler.
> 
> Regards,
> BALATON Zoltan
> 
>>> +        warn_report("NVRAM checksum mismatch");
>>> +    }
>>>   }


