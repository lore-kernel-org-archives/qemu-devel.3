Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADABC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 21:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZzr3-0003fX-KC; Fri, 02 Aug 2024 17:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZzr0-0003eq-VS
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 17:30:26 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZzqz-00026T-Bw
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 17:30:26 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5a156556fb4so12371974a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 14:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722634223; x=1723239023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gasCbbzFnrZn1eqIJ84bjlhKurieGaCI420v1thBi1w=;
 b=AnlJZSW255xwuBMktXSk89DjGbYc5AFgTAyV/xD9olCSDuWJOi1A9rdAUoGDQZ2CYx
 or+6zR/BzZHqqqhxPJt3Br+4TEFIFPC6LTe4Ufev9ud6WnbqvWBa3cM3U7Pc/vsb0UAO
 u5kHynlmkRrXNSRhUjKNFHUYOvkzjVc8OyfSNFl/TfNwUrZrSXNNK5VQk30UVYx/c8uB
 hiq91SJGxWoH81K/j9eO4QZUqJPq82+5WuhJdECVkAdSJBTgJ45j6+0yUT1ejuot8W7K
 +GVBiG8K6gkyeMAcM8ZqAh0d4+WnztA0LEqkeo+FW1CJTNhOIBMCdgnd4bjNLEJu6LeR
 mNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722634223; x=1723239023;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gasCbbzFnrZn1eqIJ84bjlhKurieGaCI420v1thBi1w=;
 b=j6y9DZh9jhNPLQdbnC/xLvxSsewYNi79jlrDiAD8aI9lZndTHvweeHnlBGmYpccUcA
 uFhU/zeNHAx6i32Tjr7iBIy30oyxMCaArvwPQGhQwaCcXf2trmUkjeaoZWvM6rzOgf2F
 YT1f9QRaUTqfbByNySh5MmheC2X1hTlNDq5NwWgo9Tw13lnDT6Gc3Me9H19eNeyp8t/4
 TPqsWbM3GL5XaL+sN0+1Jmr2ioleLuiwnwk/XviO71iJT2Hr1rgRJstbjQ+ddRq2wUoe
 9yBAzQqVdUmAfe83pVUwq52jO1YiS3WmuNKbqmTMt1esh/VKEnoLk0kJMmUJGuuLUhzO
 nlaA==
X-Gm-Message-State: AOJu0YyCl/L+MWn+4JcnPCVS0sG3wtiW4p/kuacXMfWG2QudClQsj2fW
 v93RiWew9vTJqw6hfN5qQWsYip7r4U0DF+p7acWdFXvvt9neWmZUp5w8cUj3HO4=
X-Google-Smtp-Source: AGHT+IEJzbGGBq3ujGxpwyy2qlS0CZsFSIF78zVauSrzCVbrST99x4DOA6XJtemf9BTT5GovdPnWoA==
X-Received: by 2002:aa7:c406:0:b0:5a0:f0c4:aa7b with SMTP id
 4fb4d7f45d1cf-5b7f5129461mr2957276a12.27.1722634222510; 
 Fri, 02 Aug 2024 14:30:22 -0700 (PDT)
Received: from [192.168.69.100] (cvl92-h01-176-184-49-210.dsl.sta.abo.bbox.fr.
 [176.184.49.210]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b839716279sm1545644a12.12.2024.08.02.14.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 14:30:21 -0700 (PDT)
Message-ID: <20a598c0-fb47-438e-a292-d92b134fd7c9@linaro.org>
Date: Fri, 2 Aug 2024 23:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v4 1/2] hw/pci-host/gt64120: Set PCI base address
 register write mask
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20240802171023.85719-1-philmd@linaro.org>
 <20240802171023.85719-2-philmd@linaro.org>
 <0319cc95-fb5b-d904-4043-00384ac9df4e@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0319cc95-fb5b-d904-4043-00384ac9df4e@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

On 2/8/24 21:21, BALATON Zoltan wrote:
> On Fri, 2 Aug 2024, Philippe Mathieu-Daudé wrote:
>> When booting Linux we see:
>>
>>  PCI host bridge to bus 0000:00
>>  pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
>>  pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
>>  pci_bus 0000:00: No busn resource found for root bus, will use [bus 
>> 00-ff]
>>  pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
>>  pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
>>  pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
>>  pci 0000:00:00.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
>>  pci 0000:00:00.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
>>  pci 0000:00:00.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
>>
>> This is due to missing base address register write mask.
>> Add it to get:
>>
>>  PCI host bridge to bus 0000:00
>>  pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
>>  pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
>>  pci_bus 0000:00: No busn resource found for root bus, will use [bus 
>> 00-ff]
>>  pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
>>  pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff pref]
>>  pci 0000:00:00.0: reg 0x14: [mem 0x01000000-0x01000fff pref]
>>  pci 0000:00:00.0: reg 0x18: [mem 0x1c000000-0x1c000fff]
>>  pci 0000:00:00.0: reg 0x1c: [mem 0x1f000000-0x1f000fff]
>>  pci 0000:00:00.0: reg 0x20: [mem 0x1be00000-0x1be00fff]
>>  pci 0000:00:00.0: reg 0x24: [io  0x14000000-0x14000fff]
>>
>> Since this device is only used by MIPS machines which aren't
>> versioned, we don't need to update migration compat machinery.
>>
>> Mention the datasheet referenced. Remove the "Malta assumptions
>> ahead" comment since the reset values from the datasheet are used.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/pci-host/gt64120.c | 14 +++++++++++++-
>> 1 file changed, 13 insertions(+), 1 deletion(-)


>> static void gt64120_pci_realize(PCIDevice *d, Error **errp)
>> {
>> -    /* FIXME: Malta specific hw assumptions ahead */
>> +    /* Values from chapter 17.16 "PCI Configuration" */
>> +
>>     pci_set_word(d->config + PCI_COMMAND, 0);
>>     pci_set_word(d->config + PCI_STATUS,
>>                  PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
>>     pci_config_set_prog_interface(d->config, 0);
>> +
>> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_0, 0xfffff009);
>> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_1, 0xfffff009);
>> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_2, 0xfffff009);
>> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_3, 0xfffff009);
>> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_4, 0xfffff009);
> 
> Documentation says bit 0 is read only 0 for these? Why mask ending with 
> 9 not 8? Also prefetch bit 3 is read only 0 for the last one BAR4.

Oops indeed, and also Type/Prefetch for BAR5; updated as:

pci_set_long(d->wmask + PCI_BASE_ADDRESS_0, 0xfffff008); /* SCS[1:0] */
pci_set_long(d->wmask + PCI_BASE_ADDRESS_1, 0xfffff008); /* SCS[3:2] */
pci_set_long(d->wmask + PCI_BASE_ADDRESS_2, 0xfffff008); /* CS[2:0] */
pci_set_long(d->wmask + PCI_BASE_ADDRESS_3, 0xfffff008); /* CS[3], BootCS */
pci_set_long(d->wmask + PCI_BASE_ADDRESS_4, 0xfffff000); /* ISD MMIO */
pci_set_long(d->wmask + PCI_BASE_ADDRESS_5, 0xfffff001); /* ISD I/O */

> Otherwise:
> 
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Thanks!

Phil.

