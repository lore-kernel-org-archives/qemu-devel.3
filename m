Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6236CD3424
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 08:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKY2V-0000oi-JW; Wed, 06 May 2026 04:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKY2U-0000oC-2k
 for qemu-devel@nongnu.org; Wed, 06 May 2026 04:55:30 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKY2R-0006lo-Sq
 for qemu-devel@nongnu.org; Wed, 06 May 2026 04:55:29 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-44da2de25f3so2120319f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778057726; x=1778662526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aa//v3LX4mJz0k9Gr12pp4wvMv9PFFWJt/t/4VmkHo8=;
 b=nSAVLIN/p3nW3XO+qeu4olvKUYhcuWA6//45uyTcpbjRaKYbZPXAKf804z12uMCp8K
 /THJ86mEl16hrrH+s7+gSxzG3700Ldk4LybrRrZ3VYZtOgOHwJZUIpe3v4XktxEJOqzx
 5VApuEHqlJKjKb6Fk68Pg3VDk2wwQ1CmIxwVF/4ihhW2WA0df3m0dE90DFgVYF+KDn9U
 oaEgTj8TQqGUQBvuDFIs/RqS2LYrFT7vUKwg9LzoJICdnNqx2j7+dMcEZWd3E++j4Bpr
 6D3u7RGsJSBF7F0DGmHkHYLrBfvG9y/2uqHpPidsufDXgCBs7BerLxmuZp3ji5hrqBO2
 n1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778057726; x=1778662526;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Aa//v3LX4mJz0k9Gr12pp4wvMv9PFFWJt/t/4VmkHo8=;
 b=A2M8ENfdARYmmwX5T0cdp+/zsCS9xG5RjTDVFaId4UjpQxeQJ3AZ6z/X7ND6JizZPR
 jfZai9opRoDCA4iGCTVOwJe6rZN20U6fbEGeJcemEbyxePk3Gsc6I7VBmWE3dbI0wyt5
 /QkkIrt2z6MIP1Gqt6PWo8tkDEzVQq1KYhj/2uHBhf2kN/pC3cGYPVROb0QPEzhSX7Dn
 pKN4yt6WiIsJVVRpJHAXv4pin/EWYkSBN663FzM5a+LIlMHtqsJ5nLdoc7zNrmfKFFko
 yXG0lxRLTbkQ2mVaR6R824nChStEnbZO8QTluMLUQ3e8aC2722jn/VUqzpdoj609l8ur
 86uA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KLP9rmgXIGDKwZMJ7KbUwLd5xbJ/um3vJYyrY1uxCjHNzTxSvcGPRhWDgF4dc6HoSynViov9IXj8S@nongnu.org
X-Gm-Message-State: AOJu0YwEAncxaRDt0fjGtge07x5WXoTJUOgUvWW3MvEim7wf4KOyDBAv
 kXhPKJHznb5aMHroynh/NXu8asc/1Hat7djUnFOZgFe0B95t3xSQT1DVSLhlxt40Vqk=
X-Gm-Gg: AeBDieucAPrbAgtADfILQJwhTWAk13CORVWFIkX2y0jB/E5G1UnBCNrok02y/lX3J1U
 0CVzPZb258mp2eA9sPvmtxpS+oqJfjFS54iitbKCy9UDeo7sHSuRojzj+Kx8pVyYo7JOGTdWycF
 ZrigbZdVDY/t4cKRdi6KHc0ZML1pdEJPktEM0mn1DRrQ9A87hym81m5/p7fgjbNGgORD3/HgFBS
 5P4dmybOa6g3V1SqkABXZQcZeWaHMYNLrSBZ0mGaGpa5ASHc3aaBJC39kPSQocKpzH7gymSlbbQ
 /Hly0t6Gx8jIePLQslIvp/rxGy1gnoRB2u9qt/T2NJsw1eSsIK4fhPoq3eCbbSNged31qQpubux
 2tsrjawHQVQ/Pad0xoOpB3om3R/PriU7RvKm/A4esXfGeLQ6PVChKVncMLOy/2X9IN2YM0y1QsW
 Lkpm6/KK8hdJU9yUzZQViww4cyK7B7kfTBDFzthVdI3oF7qw==
X-Received: by 2002:a05:6000:2082:b0:44f:da83:2030 with SMTP id
 ffacd0b85a97d-4515da961bcmr3970953f8f.41.1778057725579; 
 Wed, 06 May 2026 01:55:25 -0700 (PDT)
Received: from [192.168.69.210] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a48c04sm11277896f8f.15.2026.05.06.01.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 01:55:25 -0700 (PDT)
Message-ID: <34aac4dc-2113-47ca-9147-6d0db3a4890b@linaro.org>
Date: Wed, 6 May 2026 10:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/13] hw/i2c: Add designware i2c controller
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Chris Rauer <crauer@google.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-2-joel@jms.id.au>
 <972d8ddd-8ef9-4cd3-a7e5-90f00ec625ad@linaro.org>
 <afrVHbIeet5tqCA-@lima-default>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <afrVHbIeet5tqCA-@lima-default>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 6/5/26 07:53, Nicholas Piggin wrote:
> On Tue, May 05, 2026 at 09:57:20AM +0200, Philippe Mathieu-Daudé wrote:
>> On 25/4/26 15:17, Joel Stanley wrote:
>>> From: Chris Rauer <crauer@google.com>
>>>
>>> In the past this model has been submitted for use with the arm virt
>>> machine, however in this case it will be used by the upcoming
>>> Tenstorrent Atlantis RISC-V machine.
>>>
>>> This is a re-submission of the model with Chris' permission, with a
>>> light touch of updates to make it build with qemu master.
>>>
>>> Reviewed-by: Hao Wu <wuhaotsh@google.com>
>>> Signed-off-by: Chris Rauer <crauer@google.com>
>>> Link: https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@google.com
>>> [jms: rebase and minor build fixes for class_init and reset callback]
>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>> ---
>>> v4: Remove unused random header
>>> v2: Add trace event for read and write, document Alano and myself as
>>> reviewers.
>>> ---
>>>    MAINTAINERS                     |   8 +
>>>    include/hw/i2c/designware_i2c.h | 101 ++++
>>>    hw/i2c/designware_i2c.c         | 817 ++++++++++++++++++++++++++++++++
>>>    hw/i2c/Kconfig                  |   4 +
>>>    hw/i2c/meson.build              |   1 +
>>>    hw/i2c/trace-events             |   4 +
>>>    6 files changed, 935 insertions(+)
>>>    create mode 100644 include/hw/i2c/designware_i2c.h
>>>    create mode 100644 hw/i2c/designware_i2c.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index aa4267b15806..e1942a86eba5 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2716,6 +2716,14 @@ S: Orphan
>>>    F: hw/gpio/pcf8574.c
>>>    F: include/gpio/pcf8574.h
>>> +DesignWare I2C
>>> +M: Chris Rauer <crauer@google.com>
>>
>> This was 4 years ago. Is Chris still up to this?
> 
> Joel is away for a few weeks, but AFAIK he did ping Chris and got
> ack to upstream his patch.
> 
>>> +    case DW_IC_SAR:
>>> +        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_sar\n",
>>> +                      DEVICE(s)->canonical_path);
>>> +        s->ic_sar = value & DW_IC_SAR_MASK;
>>
>> Unsupported but updated...
> 
> Yeah, not sure what the best course of action is, maybe device driver
> was working better if the value got saved?
> 
>>> +    s->ic_comp_param_1 = DW_IC_COMP_PARAM_1_INIT_VAL;
>>> +    s->ic_comp_version = DW_IC_COMP_VERSION_INIT_VAL;
>>> +    s->ic_comp_type = DW_IC_COMP_TYPE_INIT_VAL;
>>
>> Preferably initialize the IC_COMP registers once in the
>> designware_i2c_realize() handler.
> 
> This I didn't change yet because I started register API converstion and
> that all changes.
> 
>>> +static void designware_i2c_smbus_init(Object *obj)
>>> +{
>>> +    DesignWareI2CState *s = DESIGNWARE_I2C(obj);
>>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>>> +
>>> +    sysbus_init_irq(sbd, &s->irq);
>>> +
>>> +    memory_region_init_io(&s->iomem, obj, &designware_i2c_ops, s,
>>> +                          "regs", 4 * KiB);
>>
>> I note the current registers only describe a 1KiB region.
> 
> 256 bytes even. It might have 4K alignment in data sheet.
> 
>>> +}
>> Since I couldn't look at the datasheet values, for overall modelling:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Thanks!
> 
> I have an incremental patch here that incorporates review comments and
> also a couple of possible issues I found - RX underflow bit was never
> being set AFAIKS it should be set here, and one of the INTR bit clear
> registers was not recalculating irqs.
> 
> I will fold this in before next repost if there are no objections.

Fine by me!

> 
> Thanks,
> Nick
> 
> ---
> diff --git a/hw/i2c/designware_i2c.c b/hw/i2c/designware_i2c.c
> index 7d8b1c1353..1e5505f571 100644
> --- a/hw/i2c/designware_i2c.c
> +++ b/hw/i2c/designware_i2c.c
> @@ -217,7 +217,7 @@ static uint32_t dw_i2c_read_ic_data_cmd(DesignWareI2CState *s)
>                         "%s: Attempted to read from RX fifo when not in receive "
>                         "state.\n", DEVICE(s)->canonical_path);
>           if (s->status != DW_I2C_STATUS_IDLE) {
> -            s->ic_raw_intr_stat &= ~DW_IC_INTR_RX_UNDER;
> +            s->ic_raw_intr_stat |= DW_IC_INTR_RX_UNDER;
>               dw_i2c_update_irq(s);
>           }
>           return 0;
> @@ -228,7 +228,7 @@ static uint32_t dw_i2c_read_ic_data_cmd(DesignWareI2CState *s)
>       if (s->ic_rxflr > 0) {
>           s->ic_rxflr--;
>       } else {
> -        s->ic_raw_intr_stat &= ~DW_IC_INTR_RX_UNDER;
> +        s->ic_raw_intr_stat |= DW_IC_INTR_RX_UNDER;
>           dw_i2c_update_irq(s);
>           return 0;
>       }
> @@ -395,6 +395,7 @@ static uint64_t dw_i2c_read(void *opaque, hwaddr offset, unsigned size)
>           break;
>       case DW_IC_CLR_RESTART_DET:
>           s->ic_raw_intr_stat &= ~(DW_IC_INTR_RESTART_DET);
> +        dw_i2c_update_irq(s);
>           break;
>       case DW_IC_COMP_PARAM_1:
>           value = s->ic_comp_param_1;
> @@ -698,6 +699,10 @@ static const MemoryRegionOps designware_i2c_ops = {
>       .read = dw_i2c_read,
>       .write = dw_i2c_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
>       .valid = {
>           .min_access_size = 4,
>           .max_access_size = 4,
> @@ -748,7 +753,7 @@ static const VMStateDescription vmstate_designware_i2c = {
>       .name = TYPE_DESIGNWARE_I2C,
>       .version_id = 0,
>       .minimum_version_id = 0,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>           VMSTATE_UINT32(ic_con, DesignWareI2CState),
>           VMSTATE_UINT32(ic_tar, DesignWareI2CState),
>           VMSTATE_UINT32(ic_sar, DesignWareI2CState),
> @@ -803,6 +808,8 @@ static void designware_i2c_class_init(ObjectClass *klass, const void *data)
>       dc->vmsd = &vmstate_designware_i2c;
>       rc->phases.enter = designware_i2c_enter_reset;
>       rc->phases.hold = designware_i2c_hold_reset;
> +
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>   }
>   
>   static const TypeInfo designware_i2c_types[] = {
> diff --git a/include/hw/i2c/designware_i2c.h b/include/hw/i2c/designware_i2c.h
> index 0d8f904f51..71d74c9141 100644
> --- a/include/hw/i2c/designware_i2c.h
> +++ b/include/hw/i2c/designware_i2c.h
> @@ -57,7 +57,7 @@ typedef enum DesignWareI2CStatus {
>    * @status: The current status of the SMBus.
>    */
>   typedef struct DesignWareI2CState {
> -    SysBusDevice parent;
> +    SysBusDevice parent_obj;
>   
>       MemoryRegion iomem;
>   


