Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB31AC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwwhO-0004Bb-NN; Thu, 20 Aug 2026 02:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wwwhH-0004Ax-Ry; Thu, 20 Aug 2026 02:56:21 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wwwhF-0001sB-6t; Thu, 20 Aug 2026 02:56:19 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4hQZ3H6NXMz5vd8;
 Thu, 20 Aug 2026 06:56:11 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 20 Aug 2026 06:56:11 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.164.208])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hQZ3H5fFvz1yw6; Thu, 20 Aug 2026 06:56:11 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id DA3FE941B49; 
 Thu, 20 Aug 2026 06:56:09 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S00164f68013-9cf1-4506-bb50-c04efdc19e05,
 290C66463DCC85845983D07CBD6D5DF49C8F16C8) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 2.10.174.70
Message-ID: <7ec3eecd-9d78-4f1d-a020-9c0960e923ae@kaod.org>
Date: Thu, 20 Aug 2026 08:56:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] hw/usb/aspeed-udc: Add ASPEED UDC device controller
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260703074332.1049473-1-jamin_lin@aspeedtech.com>
 <20260703074332.1049473-2-jamin_lin@aspeedtech.com>
 <6537f5d6-4e21-4e55-8a21-2818a7d7fa28@oss.qualcomm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <6537f5d6-4e21-4e55-8a21-2818a7d7fa28@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 11892599242196626671
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEX6PJlKYAw60+Q/ZUzv3Px0jFlgOIg+VOlqTV11tyxJ9Ksa6yAlCFOoKpFNbzjS90BgtnKcrui5Sk+dzUndboQSG6y4k0VRzmNRy1IQkTjfKlOPTNFdBUzot7+FAYpbusdw5LpWCFeAcIgMhMbQw6dh7Ri9wt1LfF+pGCU9tJds4G0FdN1MV/b+ugKv3zVNT3XaMWO37yzekyjb+fhUuP9m0m0Wk/PIXnFBUvg1hETO8bnRaRBVkeaSsKyM1plo9WqQmbgvr32+UiMsDS+FWwahVjVHpL3AdeKIOwFz9/v927YRnxEEs5ew5UxiaXzqwxm8MLXFeJf4MUAv7VDsGmznN5RbO4EHA7qUCxYJi78srEbBpYH8WGk1g0KQ/RNJmrZ59PfE7zNuiEbNd/WLTLUw1jTs/Wq12LJ0J9E+BJXD5B1Jw6NxhHgmvV5oxRamHFx5WQMGub047ifAoH85Yk4qrrsXO1wBziIlszsG1ZCiUq6s0aEsT/hikWdrxPIhm2kAOc/J0oH+euUQQHLSuY6K4stkZQl7TbnGW8rowCibJXlv3afvU3ENlmmMaI+mm4E/ZQ5VWvAvrJZjlC2V8DicDjFn/zSNjvlH1HrKmOTAM6WKiVEJZXfS+/IzNCHwsDltVsorttyR9/fzRCFClctoGktorYm5uUbbbhpwmcC6g
DKIM-Signature: a=rsa-sha256; bh=Hg0b1uPd34r0HT7H9m6VbHavq6GXJn+HtrDuv+0JvnE=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1787208972; v=1;
 b=IR4tmxLp67SQLuVt3wl3KZnTufOXoLpcnR8a6lwh9mYIPhXyXCxlzOiTssLz/0QWaV1zyYnK
 qUSMdP+G5G427X+TASMiF3UmR78+wvIanCfiQWnLTGRPEKhaMfHDKIeoZjMGvywdYQLv1jfZjyu
 iEFBQv2bUg0hsLPkzzK08gDFGTVFxJoq79KJsi5GnrxT2rU4/hq9ZOxr9CQTusvoSGokooz1foJ
 FGnu3SjfeyfQobItr26mpbhe9QJLUPicur8S6mwttRdP4rD0ZZCCMU+PpaWnDIGp35SPB9YKgzG
 4eG6LSLcdvlNq/ptrCSoG061MkHNPK6BwHFlpOV2UZXuA==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/9/26 23:03, Philippe Mathieu-Daudé wrote:
> Hi Jamin,
> 
> On 3/7/26 09:43, Jamin Lin wrote:
>> The AST2600 has a USB 2.0 Device Controller (UDC) at 0x1e6a2000 with one
>> control endpoint and four programmable endpoints, driven by the Linux
>> "aspeed_udc" gadget driver.
>>
>> Add the controller as a sysbus (system) device: the MMIO register map
>> described with the registerfields macros, the interrupt line and the
>> soft reset. This is only the register/system side.
>>
>> Note: this "device controller" is the system-bus device (TYPE_ASPEED_UDC).
>> It is not the gadget USB device (TYPE_ASPEED_UDC_DEV) that a host
>> controller enumerates, which is added in the next patch.
>>
>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>> ---
>>   hw/arm/Kconfig              |   1 +
>>   hw/usb/Kconfig              |   4 +
>>   hw/usb/aspeed-udc.c         | 264 ++++++++++++++++++++++++++++++++++++
>>   hw/usb/meson.build          |   1 +
>>   hw/usb/trace-events         |   7 +
>>   include/hw/usb/aspeed-udc.h |  54 ++++++++
>>   6 files changed, 331 insertions(+)
>>   create mode 100644 hw/usb/aspeed-udc.c
>>   create mode 100644 include/hw/usb/aspeed-udc.h
> 
> 
>> +static void aspeed_udc_realize(DeviceState *dev, Error **errp)
>> +{
>> +    AspeedUDCState *s = ASPEED_UDC(dev);
>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>> +    int i;
>> +
>> +    s->regs = g_new0(uint32_t, ASPEED_UDC_NR_REGS);
>> +
>> +    memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_UDC,
>> +                       ASPEED_UDC_REG_SIZE);
>> +
>> +    /* Root/global registers occupy the low part of the window */
>> +    memory_region_init_io(&s->reg_mr, OBJECT(s), &aspeed_udc_ops, s,
>> +                          TYPE_ASPEED_UDC ".regs", ASPEED_UDC_NR_REGS << 2);
>> +    memory_region_add_subregion(&s->iomem, 0, &s->reg_mr);
>> +
>> +    /* Each programmable endpoint has its own register bank */
>> +    for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
>> +        g_autofree char *name = g_strdup_printf(TYPE_ASPEED_UDC ".ep%d", i);
>> +
>> +        s->ep[i].index = i;
>> +        s->ep[i].regs = g_new0(uint32_t, ASPEED_UDC_EP_NR_REGS);
> 
> Why allocate a fixed size? Otherwise LGTM.

I agree. The rest looks good.

Thanks,

C.


> 
>> +        memory_region_init_io(&s->ep[i].mr, OBJECT(s), &aspeed_udc_ep_ops,
>> +                              &s->ep[i], name, ASPEED_UDC_EP_NR_REGS << 2);
>> +        memory_region_add_subregion(&s->iomem, ASPEED_UDC_EP_REG_BASE +
>> +                                    i * ASPEED_UDC_EP_REG_SIZE, &s->ep[i].mr);
>> +    }
>> +
>> +    sysbus_init_mmio(sbd, &s->iomem);
>> +    sysbus_init_irq(sbd, &s->irq);
>> +}
> 
>> +static void aspeed_udc_unrealize(DeviceState *dev)
>> +{
>> +    AspeedUDCState *s = ASPEED_UDC(dev);
>> +    int i;
>> +
>> +    for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
>> +        g_free(s->ep[i].regs);
>> +    }
>> +    g_free(s->regs);
>> +}
> 
>> +/*
>> + * EP0 (control) is served through the root registers (UDC_EP0_*), so only
>> + * the 4 programmable endpoints get their own register bank / ep[] entry.
>> + */
>> +#define ASPEED_UDC_NUM_EP       4
>> +/* 32-bit registers per programmable endpoint */
>> +#define ASPEED_UDC_EP_NR_REGS   4
>> +
>> +/*
>> + * The root/global register block spans 0x000...0x087: the SETUP data buffer
>> + * ends at 0x84. Size the backing array to cover the whole block.
>> + */
>> +#define ASPEED_UDC_NR_REGS      (0x88 >> 2)
>> +
>> +/* MMIO window: root registers below EP_REG_BASE, then the per-EP banks */
>> +#define ASPEED_UDC_REG_SIZE     0x300
>> +#define ASPEED_UDC_EP_REG_BASE  0x200
>> +#define ASPEED_UDC_EP_REG_SIZE  0x10
>> +
>> +typedef struct AspeedUDCEP {
>> +    MemoryRegion mr;
>> +    int index;
>> +    uint32_t *regs;
>> +} AspeedUDCEP;
>> +
>> +struct AspeedUDCState {
>> +    SysBusDevice parent_obj;
>> +
>> +    /* container: root registers + per-endpoint banks */
>> +    MemoryRegion iomem;
>> +    MemoryRegion reg_mr;
>> +    qemu_irq irq;
>> +    uint32_t *regs;
>> +    AspeedUDCEP ep[ASPEED_UDC_NUM_EP];
>> +};
>> +
>> +#endif /* HW_USB_ASPEED_UDC_H */
> 


