Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35E2C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 18:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trhxk-0006rc-AD; Mon, 10 Mar 2025 14:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trhxe-0006qa-Oi
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 14:34:48 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trhxc-0006Ya-D2
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 14:34:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43bc63876f1so39423015e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741631682; x=1742236482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ig1QLeUzWhgICseKHBkmFF5Dr6h85FznjTxwtYpR7WQ=;
 b=FHDePD4yvOyIAQxScjHHxQTwy2opQDg7oTmRQI+/O0KjKBqsFCL1T7CkWwJWL6Bo8Z
 uISqF5y2Ot9Xk4BI4+GqkNKFFZZaDshf5MW8JHJJQPZULn7/z6oxLiy1Si3vhpGVMZNh
 g1/JHRyBUtdcm3KJy9MfGb5QVML255MBHFUffTOHJBxiXLTPbyBs3Byf/4M//1ticLKw
 Gu6M8AYZ53mvSkYojhHwtsOCoh9bfxAuoDEIxe5BmHd5QXhEIoRNSOT/GhDlPsy1aPhH
 fHF11Pn0LbEbRtuNc8eYQcOUMPaP9/7KJhISUdf73M+OgqqWh5asrmg6jda84us/gvMJ
 9Ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741631682; x=1742236482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ig1QLeUzWhgICseKHBkmFF5Dr6h85FznjTxwtYpR7WQ=;
 b=vHJguv5eDkSHBjHTSzAMPgfgaScil0Jla2XVgxi2udCv7F6AwIVKUM9gD7APj2GNQm
 7mjMxNomuwFPQZnPHMY1ghgoUKM4o/Xtf7hgsLGpOR3QxgHdbmIcpLOwlNtJ3F4EI1ab
 8f3Zm7sBZMa1p0ul+slePhI4kzJyCr3b05Izgr9r8DYMx8RTBSPOgVLhZ/1e4TwrPXAj
 6qv51k9GX+6PN50xWHP6QpVfw3ONbAtPWqW2cu9AOlTde52LzxiGtFgg5jXh3yAxmIWz
 r1Dopohendp8sIsEYShq3C/bWEr3PK8R7nWZdMKYHHPvcfNLTCo8q5MDRcdqPHDHgOIH
 5lJw==
X-Gm-Message-State: AOJu0YySdxAt62rWnvJKqBzRxJ+MAiSL+m+eBYvQs1t89On2aof2HVYR
 HGX3P48cFqh0xpaDj5S1Dzm8rs58VZcIi4QaFfI9tYOUexUFutoFizyNZfNMrMw=
X-Gm-Gg: ASbGncsLqhjIkyLRMTkwa5Ig066VZvRakBfwgfYfJuH0U6kZ1I6iWXxbnlavsc981Qp
 bJcGFHTIRjL04unMWBI6EvFxlRN5DZwBZhL6cLpQTQhTOcySgjqvlrzDIIKbrOoNzOxR6t21hUG
 PIYB7/8M/0ONhabGBN0UvK0qZS0zf7+SnlYZoq095x3UVP/cfTnpWj5Ik4szR+R6rGSDsVmL+ex
 jWpnhOacjAcyYF1mPyfCORRQjxsPm3gdMMV60ry8zi73STtPFfmzpAwCJqG4GUk6Dw62JOR5GyS
 TGiFOe8ENufrKxyPZoKkaROQUSOovRFB8nmJtz3AnfHew880WmDQCknfEHEAucHW7GaRtmwdhEr
 OnJldDDy5I8Oa
X-Google-Smtp-Source: AGHT+IET2UYFUO0ZcvRvSCC5+6R8CcR6v8yeLgEkOYpLWGpc0TkN/14GrAgQG2ziXJ7GfjZf2Hv+1g==
X-Received: by 2002:a05:600c:1f92:b0:43c:e5c2:394 with SMTP id
 5b1f17b1804b1-43ce5c2054emr80264665e9.0.1741631682368; 
 Mon, 10 Mar 2025 11:34:42 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c588dsm179071945e9.21.2025.03.10.11.34.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 11:34:41 -0700 (PDT)
Message-ID: <d1162824-4326-4ac2-b24f-fa18a3ee91cb@linaro.org>
Date: Mon, 10 Mar 2025 19:34:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/14] hw/sd/sdhci: Remove unnecessary 'endianness'
 property
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-block@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>
References: <20250310000620.70120-1-philmd@linaro.org>
 <20250310000620.70120-15-philmd@linaro.org>
 <d97b9dd5-e569-636d-8ee7-b1a48c402429@eik.bme.hu>
 <0fa157de-ee4e-4b7f-b08e-bdf65e1840ad@linaro.org>
 <6ecc3790-e5a1-4d02-aefa-c6d632936a6a@roeck-us.net>
 <e58acfaf-5255-4710-ad34-7331401ffa86@linaro.org>
 <E66E09F3-0E28-44D7-972C-1E72D789E9E0@gmail.com>
 <20adfeac-df39-45d1-9c5b-95fe7cafbbde@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20adfeac-df39-45d1-9c5b-95fe7cafbbde@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 10/3/25 19:24, Cédric Le Goater wrote:
> On 3/10/25 18:38, Bernhard Beschow wrote:
>>
>>
>> Am 10. März 2025 17:31:57 UTC schrieb "Philippe Mathieu-Daudé" 
>> <philmd@linaro.org>:
>>> On 10/3/25 16:56, Guenter Roeck wrote:
>>>> On 3/10/25 08:27, Philippe Mathieu-Daudé wrote:
>>>>> On 10/3/25 15:09, BALATON Zoltan wrote:
>>>>>> On Mon, 10 Mar 2025, Philippe Mathieu-Daudé wrote:
>>>>>>> The previous commit removed the single use of instance
>>>>>>> setting the "endianness" property.
>>>>>>>
>>>>>>> Since classes can register their io_ops with correct
>>>>>>> endianness, no need to support different ones.
>>>>>>>
>>>>>>> Remove the code related to SDHCIState::endianess field.
>>>>>>>
>>>>>>> Remove the now unused SDHCIState::io_ops field, since we
>>>>>>> directly use the class one.
>>>>>>>
>>>>>>> Suggested-by: Bernhard Beschow <shentey@gmail.com>
>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>> ---
>>>>>>> hw/sd/sdhci-internal.h |  1 -
>>>>>>> include/hw/sd/sdhci.h  |  2 --
>>>>>>> hw/sd/sdhci.c          | 33 +++------------------------------
>>>>>>> 3 files changed, 3 insertions(+), 33 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
>>>>>>> index d99a8493db2..e4da6c831d1 100644
>>>>>>> --- a/hw/sd/sdhci-internal.h
>>>>>>> +++ b/hw/sd/sdhci-internal.h
>>>>>>> @@ -308,7 +308,6 @@ extern const VMStateDescription sdhci_vmstate;
>>>>>>> #define SDHC_CAPAB_REG_DEFAULT 0x057834b4
>>>>>>>
>>>>>>> #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
>>>>>>> -    DEFINE_PROP_UINT8("endianness", _state, endianness, 
>>>>>>> DEVICE_LITTLE_ENDIAN), \
>>>>>>>      DEFINE_PROP_UINT8("sd-spec-version", _state, 
>>>>>>> sd_spec_version, 2), \
>>>>>>>      DEFINE_PROP_UINT8("uhs", _state, uhs_mode, 
>>>>>>> UHS_NOT_SUPPORTED), \
>>>>>>>      \
>>>>>>> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
>>>>>>> index e8fced5eedc..1016a5b5b77 100644
>>>>>>> --- a/include/hw/sd/sdhci.h
>>>>>>> +++ b/include/hw/sd/sdhci.h
>>>>>>> @@ -54,7 +54,6 @@ struct SDHCIState {
>>>>>>>      AddressSpace sysbus_dma_as;
>>>>>>>      AddressSpace *dma_as;
>>>>>>>      MemoryRegion *dma_mr;
>>>>>>> -    const MemoryRegionOps *io_ops;
>>>>>>>
>>>>>>>      QEMUTimer *insert_timer;       /* timer for 'changing' sd 
>>>>>>> card. */
>>>>>>>      QEMUTimer *transfer_timer;
>>>>>>> @@ -105,7 +104,6 @@ struct SDHCIState {
>>>>>>>
>>>>>>>      /* Configurable properties */
>>>>>>>      uint32_t quirks;
>>>>>>> -    uint8_t endianness;
>>>>>>>      uint8_t sd_spec_version;
>>>>>>>      uint8_t uhs_mode;
>>>>>>> };
>>>>>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>>>>>> index 47e4bd1a610..cbb9f4ae8c0 100644
>>>>>>> --- a/hw/sd/sdhci.c
>>>>>>> +++ b/hw/sd/sdhci.c
>>>>>>> @@ -1391,17 +1391,6 @@ sdhci_write(void *opaque, hwaddr offset, 
>>>>>>> uint64_t val, unsigned size)
>>>>>>> }
>>>>>>>
>>>>>>> static const MemoryRegionOps sdhci_mmio_le_ops = {
>>>>>>> -    .read = sdhci_read,
>>>>>>> -    .write = sdhci_write,
>>>>>>> -    .valid = {
>>>>>>> -        .min_access_size = 1,
>>>>>>> -        .max_access_size = 4,
>>>>>>> -        .unaligned = false
>>>>>>> -    },
>>>>>>> -    .endianness = DEVICE_LITTLE_ENDIAN,
>>>>>>> -};
>>>>>>> -
>>>>>>> -static const MemoryRegionOps sdhci_mmio_be_ops = {
>>>>>>>      .read = sdhci_read,
>>>>>>>      .write = sdhci_write,
>>>>>>>      .impl = {
>>>>>>> @@ -1413,7 +1402,7 @@ static const MemoryRegionOps 
>>>>>>> sdhci_mmio_be_ops = {
>>>>>>>          .max_access_size = 4,
>>>>>>>          .unaligned = false
>>>>>>>      },
>>>>>>> -    .endianness = DEVICE_BIG_ENDIAN,
>>>>>>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>>>>>>> };
>>>>>>>
>>>>>>> static void sdhci_init_readonly_registers(SDHCIState *s, Error 
>>>>>>> **errp)
>>>>>>> @@ -1467,23 +1456,6 @@ void sdhci_common_realize(SDHCIState *s, 
>>>>>>> Error **errp)
>>>>>>>      SDHCIClass *sc = s->sc;
>>>>>>>      const char *class_name = object_get_typename(OBJECT(s));
>>>>>>>
>>>>>>> -    s->io_ops = sc->io_ops ?: &sdhci_mmio_le_ops;
>>>>>>> -    switch (s->endianness) {
>>>>>>> -    case DEVICE_LITTLE_ENDIAN:
>>>>>>> -        /* s->io_ops is little endian by default */
>>>>>>> -        break;
>>>>>>> -    case DEVICE_BIG_ENDIAN:
>>>>>>> -        if (s->io_ops != &sdhci_mmio_le_ops) {
>>>>>>> -            error_setg(errp, "SD controller doesn't support big 
>>>>>>> endianness");
>>>>>>> -            return;
>>>>>>> -        }
>>>>>>> -        s->io_ops = &sdhci_mmio_be_ops;
>>>>>>> -        break;
>>>>>>> -    default:
>>>>>>> -        error_setg(errp, "Incorrect endianness");
>>>>>>> -        return;
>>>>>>> -    }
>>>>>>> -
>>>>>>>      sdhci_init_readonly_registers(s, errp);
>>>>>>>      if (*errp) {
>>>>>>>          return;
>>>>>>> @@ -1493,7 +1465,7 @@ void sdhci_common_realize(SDHCIState *s, 
>>>>>>> Error **errp)
>>>>>>>      s->fifo_buffer = g_malloc0(s->buf_maxsz);
>>>>>>>
>>>>>>>      assert(sc->iomem_size >= SDHC_REGISTERS_MAP_SIZE);
>>>>>>> -    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s, 
>>>>>>> class_name,
>>>>>>> +    memory_region_init_io(&s->iomem, OBJECT(s), sc->io_ops, s, 
>>>>>>> class_name,
>>>>>>>                            sc->iomem_size);
>>>>>>> }
>>>>>>>
>>>>>>> @@ -1578,6 +1550,7 @@ void sdhci_common_class_init(ObjectClass 
>>>>>>> *klass, const void *data)
>>>>>>>      dc->vmsd = &sdhci_vmstate;
>>>>>>>      device_class_set_legacy_reset(dc, sdhci_poweron_reset);
>>>>>>>
>>>>>>> +    sc->io_ops = &sdhci_mmio_le_ops;
>>>>>>
>>>>>> You call common_class_init in subclass class_inits last so this 
>>>>>> would overwrite what subclass has set, doesn't it? I think you 
>>>>>> either have to change order in subclass class_init methods or not 
>>>>>> set this here.
>>>>>
>>>>> Oops... I'm surprised tests passed. Do we have coverage for sdhci on
>>>>> e500 machines? Or are we only testing them via virtio PCI block 
>>>>> storage?
>>>>
>>>> Not sure if that is what you are asking, but I have been testing it 
>>>> with
>>>> sdhci-pci for a long time (not this series, though).
>>>
>>> I'm referring to the Freescale eSDHC controller of PPC e500 machines
>>> (see previous patch).
>>
>> I think testing SDHCI is generally difficult since the images need to 
>> be resized to a power of two.

historical references for this "sdcard power of 2" limitation:
https://lore.kernel.org/qemu-devel/20210623180021.898286-1-f4bug@amsat.org/
https://lore.kernel.org/qemu-devel/4b846383-83bf-4252-a172-95604f2f585b@linaro.org/

> Any idea how to do this with the new 
>> functional tests?
> 
> we can truncate to 64M the rootfs used in  :
> 
>     tests/functional/test_ppc64_e500.py
> 
> and boot from it in a new test if that's supported by the machine.

Yes, that is the best we can do until we implement the async DMA.

Regards,

Phil.

