Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AA9C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXNdS-0005VL-80; Tue, 06 Feb 2024 10:45:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXNdP-0005Uw-Po
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:45:19 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXNdO-0001RB-5L
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:45:19 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40f033c2e30so51646115e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 07:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707234316; x=1707839116; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Plyo5mknz8kPaE5BH2cdFDRghb7YK1RuLYsVJ6e7ax8=;
 b=L1Bz+kZoEDXmRnPheleroWbK1VHkMRdIiJSKfM+Xw+JHQP8nkCHaBfwd/SWUPP/Ksz
 hn5r4y1A27RHX1BAYZdEKFQhRe+zLTzBG1olizdNPWOt5qzxiqx7voINIFEvujhSPY0g
 ArjKD+aOeAdNPF109PZOi+FbnG1dlqvabioinTZBmX4suRa1s7HePaxy06JiQYlIUKxS
 OStRxZiFki+p7xfZD9EJJCviVgBaBwpWw95Se79ueT5fD4nHUrRi+7ZrbihS/YkAHJZz
 av2hOU+yZ1/XauD1gTvIGwXXJYS1WOWXeeSXx9RZVryaPuQNrfVc9zjcSma8uhqrZcLV
 K+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707234316; x=1707839116;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Plyo5mknz8kPaE5BH2cdFDRghb7YK1RuLYsVJ6e7ax8=;
 b=wNrXJnl8FB+dDYg5pQuGuR7593vdr0Mcb71DpMW+vtpiRYqNIv3nQSbiiE9+fPJhNe
 R8Wl6mN5ywFmEx//uHaCQJmLuoDcVMg4Li0uDSFQuGEL8+itwSFtGT7IQcJl6UHfENT6
 pRCC65/ks6/14a2VvNKXxRN7+ddnF10P808thar41/z9e7eO3mMkg/4HDUAQ7aUuye50
 Xtgq7tiXHQNvWTzAbQ5in7PD9Y6y6kRzm/ecXE3/Hb/CEKZw8nrpCKkM3CjPGIdZRpFS
 PQfUY5LWzo0UOoEFkNaNPA6YLjtPgIVfaBuLfbZpVFFt63wAnKMV/O1p22LSUnPnXDYY
 vsXw==
X-Gm-Message-State: AOJu0YxA+K0xFeeiTglKx6jzcUdRcsOQgHoDe3JhiXgDLFx/is4URnOB
 f9eyAWd4bD76qk3ssb5GXPN4KMKbr8pw4NYrrEPLaXG4A/zd+IMjhn55nQI4QWAuZ+8hRZwXuCX
 R
X-Google-Smtp-Source: AGHT+IGvXShRoDLg24PUkf2nYFQeMB3FAUEXa8B5FW4oRbUF5Baw2gKAYje+1ljARUMLXFTAGSVSOA==
X-Received: by 2002:a5d:4748:0:b0:33b:2b:1921 with SMTP id
 o8-20020a5d4748000000b0033b002b1921mr1308470wrs.23.1707234316352; 
 Tue, 06 Feb 2024 07:45:16 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVHDs+UGZ5SVWq8jxcY2BLH1PY7KmKKYCvdUleu2zkykx6CDjDDty2kgY+pywCQ69n9Sqnd6yEbSStWsBpRzaKuyilJ8xVhCGs2ZZdPMw7ez722b4ZaQc3XYdT4q8lwA7bDO5Evb+1Vct5mCi8Q0T+cmjvsT1kIln8UHDe73Tt5YtY+/N7gXb8Ue6HFw+0jSQAyLhKzZnJKUoIPX+u0yT5ocwCWSUm7fJxVkaH9JHqFcywPduPS/KTGYOFcmZlTmXXRWLI1w6noNCB9d8IJysq/XOUoyqd2W6pfxVjUG481X8TwabY=
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a5d4dc9000000b0033b483d1abcsm1609231wru.53.2024.02.06.07.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 07:45:15 -0800 (PST)
Message-ID: <a93b8601-8f45-4781-8ba1-0d894c0e0139@linaro.org>
Date: Tue, 6 Feb 2024 16:45:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/pci-host/bonito: Access memory regions via
 pci_address_space[_io]()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231011185954.10337-1-philmd@linaro.org>
 <20231011185954.10337-4-philmd@linaro.org>
 <5FD62714-3C33-4A93-B7E3-F3523FCE69C1@gmail.com>
 <bf5d344c-84a1-c6b9-3d17-0362a4c2c9e7@linaro.org>
In-Reply-To: <bf5d344c-84a1-c6b9-3d17-0362a4c2c9e7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Bernhard,

On 16/10/23 09:04, Philippe Mathieu-Daudé wrote:
> On 16/10/23 00:19, Bernhard Beschow wrote:
>> Am 11. Oktober 2023 18:59:53 UTC schrieb "Philippe Mathieu-Daudé" 
>> <philmd@linaro.org>:
>>> PCI functions are plugged on a PCI bus. They can only access
>>> external memory regions via the bus.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> hw/pci-host/bonito.c | 6 +++---
>>> 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> 
>>> @@ -719,7 +719,7 @@ static void bonito_pci_realize(PCIDevice *dev, 
>>> Error **errp)
>>>
>>>      memory_region_init_alias(pcimem_alias, NULL, "pci.mem.alias",
>>>                               &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
>>> -    memory_region_add_subregion(get_system_memory(),
>>> +    memory_region_add_subregion(pci_address_space(dev),
>>
>> I need to keep `get_system_memory()` here to get the same results for 
>> `info mtree` in the QEMU console before and after this patch when 
>> running `qemu-system-mips64el -M fuloong2e -S`. The other two changes 
>> above seem to work as expected.

Can I use add R-b tag after dropping this change?


