Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A252AF43699
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 12:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDi1K-0006wY-5B; Fri, 17 Apr 2026 08:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDi0o-0006rd-N3
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 08:09:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDi0m-0007MW-L3
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 08:09:30 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so4248675e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 05:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776427766; x=1777032566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ETIheo6n0POO6m+3vqnolVCAr2ujTEu5quAYRMbusmU=;
 b=WSzkKABhQrbF2l9QO8lbYBhWWqGJk+Kzs5BTp6FMViJQBqFKNEzmyz97gfxT4mjJqh
 pQsYUwlhAoXF7VHWzt6IOO/tW/ybO9h7jPjuFXD7+8XRzybbh7kKmdtHGMqnrhWWuhxx
 hQSjKYsRXq9pY80XUsdzSK9h+MVvp7FfAh+YjtYitGpt+cu902eDpdiiLVQGQg+c9u5c
 rCX3uR+qQcAAquWl2P+XkD+cQzaH6Nd9K2ETfpGgXGIn1tp5I3MDcj2vv83z3KE15FlA
 AwHSuRI+KOFO9tCIWjdAqMJtjdZGeYM7MFNWCB/v5yKgUQHeIrQI7A43bPIFK3biSwIO
 4S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776427766; x=1777032566;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ETIheo6n0POO6m+3vqnolVCAr2ujTEu5quAYRMbusmU=;
 b=nLDX6CV7LKsaT6cFORvZvMrFNaAD2v2xoQkluK3yf1Mj7J9m8Jo1ZD2A8RyLfkdTAr
 lD3+Yq/yj/yBLOZ9ld7EJAxa5sgoGy8+H7kcNQAZ7KbGAWo1FB+Et+YWHApoW3YsiTu1
 us1LljE3ZbrzX9TQBfkkhfKpg4DgTrpVuCd0hYVHMjlxxo4PpWDyYB0IfP4yq/LBDv44
 vzMtMUwoG9q9v/Y2OEE3MJKj6UxJUppX7QFGjB8BGow+qeUc75T0sZEgu1ZLqvG/ACZp
 3offwWiGxRInKaE9uZK7O8AZHu/KfDbch5baTAEYViL8Mo9HZSEcb/4jT0ICWB0IvyjP
 GlOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9eOvxwHrnR17MQRgl5n+1X6TK2kZs9lccwW5iPq9lluaeZAVku8tu8Me796vWdjGgYvi2oU1fwxerm@nongnu.org
X-Gm-Message-State: AOJu0YxqRIUOKX1c2QSBBh93a68a6WNyM4xBih6bzJc4RIAO0QB9RIOZ
 C65fwoRdmzJw8vUzWesyz7ycZZOB2hrDTql1wN0X4nkWI0UnB7kXCavNBLXkwI0/oVg=
X-Gm-Gg: AeBDiesiJt79AJbbEsvtJ423RjPNpbotJ2Zg1A/e7XRLEc+Pojgn4vwASxpqTnL1FyD
 4m7qm369mOEwRcxL/7h0+i+D3VwgWsxIpUsm+c26I4B/P9aA9j5uO8qZ/GqBvUsJHm7jDbkYgV6
 DOWi5j48kTYNU5FwRBB5PwDUxR7MT1CUpMTsXn58mu0d2E4Zlu+D+MGDUnnsd8vRKRcOnk5P1Iz
 RROaOBIvv8/+V9LFkk/RQ5bVqzoowm5CnnhKNFYl+UW2LWq28J9WOnBUxltnTvB+e52cz8XKg+N
 185uCMp7AJX6g2uVWRABxsKzdnibomOGvHx536rdeZZzc5uhitUrzASM/eiWrILiZK1dyGF4BSG
 9iTpLViVxNC8I7YkRFx1irTEdGmQik2owwgHiRC/oWxsb+eGXPIiF+a2eQ8Cdg7OUz7RvEuFnNd
 9XQbd1Q9gJ/keKZFbBY4ywgGJ19MRJs7ou+HY8DVE1WYtYUqzAqY+bxVUTgqwacdEgOoutcn14l
 RbHHR7bIPjSWag=
X-Received: by 2002:a05:600c:8207:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-488fb73cf74mr39274645e9.3.1776427766390; 
 Fri, 17 Apr 2026 05:09:26 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7c2167sm15067905e9.36.2026.04.17.05.09.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 05:09:25 -0700 (PDT)
Message-ID: <b57f0f08-d725-425f-bd5f-7d127f6fa83f@linaro.org>
Date: Fri, 17 Apr 2026 14:09:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] hw/sd/sdcard: Add erase-blocks-as-zero option.
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
 <20260417-sdcard-performance-b4-v4-5-119e66be10c2@avm.de>
 <2bdfa874-468b-4f59-b0c8-a7f51fc9d5d9@linaro.org>
In-Reply-To: <2bdfa874-468b-4f59-b0c8-a7f51fc9d5d9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/4/26 14:06, Philippe Mathieu-Daudé wrote:
> On 17/4/26 11:51, Christian Speich wrote:
>> Currently, erased blocks are filled with 0xFF. However SCR Bit 55
>> (DATA_STAT_AFTER_ERASE) indicates that an erase produces zeros. One of
>> them is wrong.
>>
>> This patch does two things.
>>
>> First it fixes the reporting of DATA_STAT_AFTER_ERASE in SCR to
>> correctly reflect the content of erased blocks. We also increase the
>> Product Revision (REV in CID) to indicate to the guest that
>> DATA_STAT_AFTER_ERASE is now reliable.
>>
>> Secondly, we introduce a erase-blocks-as-zero option, which allows the
>> user to choose if erased blocks should contain 0xFF or 0x00. The default
>> is still 0xFF to remain compatible with current users.
> 
> I'll update as:
> 
>    Secondly, we introduce a erase-blocks-as-zero option, which allows the
>    user to choose if erased blocks should contain 0xFF or 0x00. While
>    previous QEMU versions keep using the 'erase as 0xFF' pattern, the new
>    default becomes the more efficient 'erase as 0x00'.
> 
> Does it look OK to you?
> 
>> Signed-off-by: Christian Speich <c.speich@avm.de>
>> ---
>>   hw/core/machine.c |  5 +++++
>>   hw/sd/sd.c        | 15 +++++++++++++--
>>   2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 
>> 0aa77a57e956693208d77fea6af5853ed4904234..54e4c05c96e3cf35ab2e702ee81fba36457cadd7 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -38,6 +38,11 @@
>>   #include "hw/acpi/generic_event_device.h"
>>   #include "qemu/audio.h"
>> +GlobalProperty hw_compat_11_0[] = {
>> +    { "sdmmc-common", "erase-blocks-as-zero", "false" },
>> +};
>> +const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>> +
>>   GlobalProperty hw_compat_10_2[] = {
>>       { "scsi-block", "migrate-pr", "off" },
>>       { "isa-cirrus-vga", "global-vmstate", "true" },
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 
>> b27fed2e563e5971dd32787498eb8abed9ffe9be..0f997ed8cc80e38645101cb8f47c86f1c30d5a25 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
> 
>> @@ -3287,6 +3296,8 @@ static void emmc_realize(DeviceState *dev, Error 
>> **errp)
>>   static const Property sdmmc_common_properties[] = {
>>       DEFINE_PROP_DRIVE("drive", SDState, blk),
>> +    DEFINE_PROP_BOOL("erase-blocks-as-zero", SDState, 
>> erase_blocks_as_zero,
>> +                     true),

Although to maintain bisectability we should expose the property
after the next patch -- the 0x00 implementation --.

>>   };
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


