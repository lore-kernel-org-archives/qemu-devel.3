Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F13C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 09:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUjpO-0007oW-6n; Fri, 19 Jul 2024 05:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUjpM-0007mw-8i
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 05:23:00 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUjpK-0006TX-HM
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 05:23:00 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-367990aaef3so477908f8f.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 02:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721380977; x=1721985777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/jpJmlnJGxMqLM2gozvaX6vYmM5VG8aEvMAmikZSNPw=;
 b=FmcKsEClPF/c2aO67/hG1eXZ1aG3rDs4haFFI54eAykao5hrQVIQ/12GpqgIf24yEk
 8BvjYDFZt7NMXOb9D0geA2g5+vVLKPWiqr1JVYBYtFkTrSz39Atf65GXSbu0IwnkNvV5
 GT4zl4XgTg0BuaGjZs5/zoQH6hNgPVb8/xbtPckqMZQSp68MjHJn/rat9z+QSVWau7IC
 aeU4H9LGcRX8Ah2fN3SmePK5orrwYcRQb1Rz5TkRNjY/rmywf1FX4CcArwWYwEpbCeWg
 xNG6H6bDQoZdU0nIgDUKNX78M723HpZaOrL8TxCBiLG+SD/qt5jQ6Hd7vS+v4vqcZUFT
 Es0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721380977; x=1721985777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/jpJmlnJGxMqLM2gozvaX6vYmM5VG8aEvMAmikZSNPw=;
 b=afQi/K1NVBsUF7z+cd1LD+hR6SkPuiJm5Ef7y+f5jj9Zit6JhKbpGgde9T2l+HhuuX
 yh37WXdDT3i7VtH5LY2LeoGGyp6l4LTT7YPCAn3JK8IBhlyvvnsxaLy272GaEl0yK0MI
 7FOaBpw8nxWpI5BH/QtwN8HVhY6uSro/Y/ZvGKDoemABa+pb5DJY/JKyceHZjCL2Z+jB
 Jq7s+NRVHNfctpWHPISzTa/sb6wpJ2FI2i6zTowxzRsdgCepmGh8qRUD4lIrXb+IbvIw
 Gv9+XM6MPBd33RULo+A3h8YEs3BmUKiOMY2eWHAk2snqw0B/9VdrR8v7f8khs+dFcOg4
 T/9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/lsNCUHYikXoHotEuzHfBcbZEcYZ9z4dLKOYXi+cPz3dYJ5gKH0WADrm7AWPlWNskNdu/7VG+Q7RSPBlRD6lgg1eCLpQ=
X-Gm-Message-State: AOJu0Yy+Vw/dp2yX5z99fN8hVh3PbFK4oJb6ZPTEc7GCbIkEEgKo7ez1
 IgJBwP3mu91qvHlrKQDr8Qh82g1q/eCLCagByITP3cV89V9T8qH2bBV8gYjU6eo=
X-Google-Smtp-Source: AGHT+IGY5HBhMIZijdje9H2k9zJ2+mdZyWPNWb/purRbdOKpIBsFXIi+20H9fhnyW6DxD4en+8BFhQ==
X-Received: by 2002:adf:ee4f:0:b0:368:5b01:32e3 with SMTP id
 ffacd0b85a97d-3685b0137c8mr2748490f8f.23.1721380976702; 
 Fri, 19 Jul 2024 02:22:56 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787cecbfsm1063109f8f.85.2024.07.19.02.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 02:22:56 -0700 (PDT)
Message-ID: <f92a1c5e-c9fe-4062-bbb5-a42432504d0f@linaro.org>
Date: Fri, 19 Jul 2024 11:22:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/3] hw/loongarch: Modify flash block size to 256K
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, Xianglai Li <lixianglai@loongson.cn>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240719022604.781608-1-gaosong@loongson.cn>
 <20240719022604.781608-4-gaosong@loongson.cn>
 <a143257f-62c0-4c3a-9031-5f3e510f430d@linaro.org>
 <ZpohPHRh7gOeTV4o@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZpohPHRh7gOeTV4o@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 19/7/24 10:18, Daniel P. Berrangé wrote:
> On Fri, Jul 19, 2024 at 10:12:20AM +0200, Philippe Mathieu-Daudé wrote:
>> On 19/7/24 04:26, Song Gao wrote:
>>> From: Xianglai Li <lixianglai@loongson.cn>
>>>
>>> loongarch added a common library for edk2 to
>>> parse flash base addresses through fdt.
>>> For compatibility with other architectures,
>>> the flash block size in qemu is now changed to 256k.
>>>
>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>>> Reviewed-by: Song Gao <gaosong@loongson.cn>
>>> Message-Id: <20240624033319.999631-1-lixianglai@loongson.cn>
>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>> ---
>>>    include/hw/loongarch/virt.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>>> index 8fdfacf268..603c1cebdb 100644
>>> --- a/include/hw/loongarch/virt.h
>>> +++ b/include/hw/loongarch/virt.h
>>> @@ -20,7 +20,7 @@
>>>    #define VIRT_FWCFG_BASE         0x1e020000UL
>>>    #define VIRT_BIOS_BASE          0x1c000000UL
>>>    #define VIRT_BIOS_SIZE          (16 * MiB)
>>> -#define VIRT_FLASH_SECTOR_SIZE  (128 * KiB)
>>> +#define VIRT_FLASH_SECTOR_SIZE  (256 * KiB)
>>
>> Again, I believe this breaks machine migration. See the recent
>> example Daniel explained to me:
>> https://lore.kernel.org/qemu-devel/Zn6EQ39Q57KtmKPU@redhat.com/
> 
> Yes, changing flash size breaks migration compat, but note that loongarch
> does not have any versioned machine types, so it has zero migration compat
> right now regardles of this change. IOW, now is the right time to make the
> change, before someone asks for versioned machines with loongarch.

Oh I see now, thanks for clarifying!

It would have been nice to mention that in the commit description,
but too late so I don't mind.

Regards,

Phil.


