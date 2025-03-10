Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98EEC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 18:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trhp1-0002uv-9r; Mon, 10 Mar 2025 14:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Dnhs=V5=kaod.org=clg@ozlabs.org>)
 id 1trhoZ-0002q2-Sw; Mon, 10 Mar 2025 14:25:24 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Dnhs=V5=kaod.org=clg@ozlabs.org>)
 id 1trhoW-0004tw-Tw; Mon, 10 Mar 2025 14:25:23 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZBQL06rJ9z4xG8;
 Tue, 11 Mar 2025 05:25:12 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZBQKn1jXBz4xZ7;
 Tue, 11 Mar 2025 05:25:00 +1100 (AEDT)
Message-ID: <20adfeac-df39-45d1-9c5b-95fe7cafbbde@kaod.org>
Date: Mon, 10 Mar 2025 19:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/14] hw/sd/sdhci: Remove unnecessary 'endianness'
 property
To: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, BALATON Zoltan <balaton@eik.bme.hu>
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
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <E66E09F3-0E28-44D7-972C-1E72D789E9E0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Dnhs=V5=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/10/25 18:38, Bernhard Beschow wrote:
> 
> 
> Am 10. März 2025 17:31:57 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> On 10/3/25 16:56, Guenter Roeck wrote:
>>> On 3/10/25 08:27, Philippe Mathieu-Daudé wrote:
>>>> On 10/3/25 15:09, BALATON Zoltan wrote:
>>>>> On Mon, 10 Mar 2025, Philippe Mathieu-Daudé wrote:
>>>>>> The previous commit removed the single use of instance
>>>>>> setting the "endianness" property.
>>>>>>
>>>>>> Since classes can register their io_ops with correct
>>>>>> endianness, no need to support different ones.
>>>>>>
>>>>>> Remove the code related to SDHCIState::endianess field.
>>>>>>
>>>>>> Remove the now unused SDHCIState::io_ops field, since we
>>>>>> directly use the class one.
>>>>>>
>>>>>> Suggested-by: Bernhard Beschow <shentey@gmail.com>
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> ---
>>>>>> hw/sd/sdhci-internal.h |  1 -
>>>>>> include/hw/sd/sdhci.h  |  2 --
>>>>>> hw/sd/sdhci.c          | 33 +++------------------------------
>>>>>> 3 files changed, 3 insertions(+), 33 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
>>>>>> index d99a8493db2..e4da6c831d1 100644
>>>>>> --- a/hw/sd/sdhci-internal.h
>>>>>> +++ b/hw/sd/sdhci-internal.h
>>>>>> @@ -308,7 +308,6 @@ extern const VMStateDescription sdhci_vmstate;
>>>>>> #define SDHC_CAPAB_REG_DEFAULT 0x057834b4
>>>>>>
>>>>>> #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
>>>>>> -    DEFINE_PROP_UINT8("endianness", _state, endianness, DEVICE_LITTLE_ENDIAN), \
>>>>>>      DEFINE_PROP_UINT8("sd-spec-version", _state, sd_spec_version, 2), \
>>>>>>      DEFINE_PROP_UINT8("uhs", _state, uhs_mode, UHS_NOT_SUPPORTED), \
>>>>>>      \
>>>>>> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
>>>>>> index e8fced5eedc..1016a5b5b77 100644
>>>>>> --- a/include/hw/sd/sdhci.h
>>>>>> +++ b/include/hw/sd/sdhci.h
>>>>>> @@ -54,7 +54,6 @@ struct SDHCIState {
>>>>>>      AddressSpace sysbus_dma_as;
>>>>>>      AddressSpace *dma_as;
>>>>>>      MemoryRegion *dma_mr;
>>>>>> -    const MemoryRegionOps *io_ops;
>>>>>>
>>>>>>      QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
>>>>>>      QEMUTimer *transfer_timer;
>>>>>> @@ -105,7 +104,6 @@ struct SDHCIState {
>>>>>>
>>>>>>      /* Configurable properties */
>>>>>>      uint32_t quirks;
>>>>>> -    uint8_t endianness;
>>>>>>      uint8_t sd_spec_version;
>>>>>>      uint8_t uhs_mode;
>>>>>> };
>>>>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>>>>> index 47e4bd1a610..cbb9f4ae8c0 100644
>>>>>> --- a/hw/sd/sdhci.c
>>>>>> +++ b/hw/sd/sdhci.c
>>>>>> @@ -1391,17 +1391,6 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>>>>>> }
>>>>>>
>>>>>> static const MemoryRegionOps sdhci_mmio_le_ops = {
>>>>>> -    .read = sdhci_read,
>>>>>> -    .write = sdhci_write,
>>>>>> -    .valid = {
>>>>>> -        .min_access_size = 1,
>>>>>> -        .max_access_size = 4,
>>>>>> -        .unaligned = false
>>>>>> -    },
>>>>>> -    .endianness = DEVICE_LITTLE_ENDIAN,
>>>>>> -};
>>>>>> -
>>>>>> -static const MemoryRegionOps sdhci_mmio_be_ops = {
>>>>>>      .read = sdhci_read,
>>>>>>      .write = sdhci_write,
>>>>>>      .impl = {
>>>>>> @@ -1413,7 +1402,7 @@ static const MemoryRegionOps sdhci_mmio_be_ops = {
>>>>>>          .max_access_size = 4,
>>>>>>          .unaligned = false
>>>>>>      },
>>>>>> -    .endianness = DEVICE_BIG_ENDIAN,
>>>>>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>>>>>> };
>>>>>>
>>>>>> static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
>>>>>> @@ -1467,23 +1456,6 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
>>>>>>      SDHCIClass *sc = s->sc;
>>>>>>      const char *class_name = object_get_typename(OBJECT(s));
>>>>>>
>>>>>> -    s->io_ops = sc->io_ops ?: &sdhci_mmio_le_ops;
>>>>>> -    switch (s->endianness) {
>>>>>> -    case DEVICE_LITTLE_ENDIAN:
>>>>>> -        /* s->io_ops is little endian by default */
>>>>>> -        break;
>>>>>> -    case DEVICE_BIG_ENDIAN:
>>>>>> -        if (s->io_ops != &sdhci_mmio_le_ops) {
>>>>>> -            error_setg(errp, "SD controller doesn't support big endianness");
>>>>>> -            return;
>>>>>> -        }
>>>>>> -        s->io_ops = &sdhci_mmio_be_ops;
>>>>>> -        break;
>>>>>> -    default:
>>>>>> -        error_setg(errp, "Incorrect endianness");
>>>>>> -        return;
>>>>>> -    }
>>>>>> -
>>>>>>      sdhci_init_readonly_registers(s, errp);
>>>>>>      if (*errp) {
>>>>>>          return;
>>>>>> @@ -1493,7 +1465,7 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
>>>>>>      s->fifo_buffer = g_malloc0(s->buf_maxsz);
>>>>>>
>>>>>>      assert(sc->iomem_size >= SDHC_REGISTERS_MAP_SIZE);
>>>>>> -    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s, class_name,
>>>>>> +    memory_region_init_io(&s->iomem, OBJECT(s), sc->io_ops, s, class_name,
>>>>>>                            sc->iomem_size);
>>>>>> }
>>>>>>
>>>>>> @@ -1578,6 +1550,7 @@ void sdhci_common_class_init(ObjectClass *klass, const void *data)
>>>>>>      dc->vmsd = &sdhci_vmstate;
>>>>>>      device_class_set_legacy_reset(dc, sdhci_poweron_reset);
>>>>>>
>>>>>> +    sc->io_ops = &sdhci_mmio_le_ops;
>>>>>
>>>>> You call common_class_init in subclass class_inits last so this would overwrite what subclass has set, doesn't it? I think you either have to change order in subclass class_init methods or not set this here.
>>>>
>>>> Oops... I'm surprised tests passed. Do we have coverage for sdhci on
>>>> e500 machines? Or are we only testing them via virtio PCI block storage?
>>>
>>> Not sure if that is what you are asking, but I have been testing it with
>>> sdhci-pci for a long time (not this series, though).
>>
>> I'm referring to the Freescale eSDHC controller of PPC e500 machines
>> (see previous patch).
> 
> I think testing SDHCI is generally difficult since the images need to be resized to a power of two. Any idea how to do this with the new functional tests?

we can truncate to 64M the rootfs used in  :

    tests/functional/test_ppc64_e500.py

and boot from it in a new test if that's supported by the machine.


Thanks,

C.





