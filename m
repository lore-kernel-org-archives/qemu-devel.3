Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06172C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 12:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzFZV-0005Al-FS; Tue, 23 Apr 2024 08:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1rzFZS-00058G-0Q
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 08:48:26 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1rzFZP-0004xc-NY
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 08:48:25 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-346a5dea2f4so1224449f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 05:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713876501; x=1714481301;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=upmp17IZU71FfVax5a4XTIDXJxQ3I1tlzX3P4AJdJe4=;
 b=gUqUMUDiVK55BpKFPb/QvliRBZWR891RbsF3e0jqgOrJ4fKt8oVRPOYezs286V/9wG
 if5G2gkebv1ybcfCQbbYSiErs0/tr+FhZrW7KD6Wb5RirhRmYUL16sOWrgUqZmvYjHdo
 iwgFK/gTJ44vSepQN21/DOjE55JGbePMWBdaNBuTRmXq8ACmdoUYkYTu1bhrP+XDbhl8
 SFK49+aiHN1YTuNswPLBgBcPnN7np3h7HMD312TfsgwAnKFzBY4sVq8078i7su1kUq8N
 0zUSnd5KgxzzXj5p8nKWh0iAAtyuAXsZLFfA2eh/pAh5DlA4x9XlfpC7GDFlJQWgMTKD
 FpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713876501; x=1714481301;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=upmp17IZU71FfVax5a4XTIDXJxQ3I1tlzX3P4AJdJe4=;
 b=Ng4fH4rlUhbQe5KHnKgDxKvpyJUhb7nEKU2csqNVZPg/uVEqOrbb19ui+07u/Y9AVi
 SWUwAdjaZfn9wt5tms1/clrfQ2IdmM08XlzH0BrxCv2c0E+WjBwwbGVdH4PhTaLTs7RO
 dMyHtApzmF/3eGj70+k7Ix0YklpU1TnyYy/f98B3XmscPJDwutr/npnSBwyPx/tWTX0u
 lyrcKIDMLmCBGrt1PyTFrJ0gC1AsDIIbERJDw2QcwFd9M+kBDg1wqNzah7XrZmwwhNSS
 NAShlDWX6XQ3Zhhht5cUa/ElGqq7NrmU2/6kWl6Y7I+16WN4t7UzSKIXNL6jYOnmMwiN
 HoDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAo4sZDCziYFEeO+OAy95n7ZntGXWpXWcvM9MyVRg2/y2JOSmQKsEF2Y18xFxDniahiXckH/0TYpxSl5FHg2I4Q8Hu+UM=
X-Gm-Message-State: AOJu0YxqiQFYCoJ564cE58VNgVpSAz0yLEw9iN1WhieCKUp1z4KfJuaX
 LtaNw+SEIbxM7cTIft3QRxFEa0gP+B95iarXihNKuOpBJhWB11+SKKVu0AsaQ04=
X-Google-Smtp-Source: AGHT+IFM52nFpTIiBtxGX82x28khIr4XteXRd9BeoHvRfr59TX2Ajz7HprGksnHgNFNUs5RFk94OWw==
X-Received: by 2002:a05:600c:3b09:b0:418:ef65:4b11 with SMTP id
 m9-20020a05600c3b0900b00418ef654b11mr10129528wms.2.1713876501580; 
 Tue, 23 Apr 2024 05:48:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:71cb:1f75:7053:849c?
 ([2a01:e0a:999:a3a0:71cb:1f75:7053:849c])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a05600c354d00b00419fba938d8sm11455806wmq.27.2024.04.23.05.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 05:48:20 -0700 (PDT)
Message-ID: <3cec0ced-b017-4875-99fe-b1222b2f4372@rivosinc.com>
Date: Tue, 23 Apr 2024 14:48:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: change RISCV_EXCP_SEMIHOST exception number
 to 63
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, qemu-riscv@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Anup Patel <apatel@ventanamicro.com>
References: <20240422135840.1959967-1-cleger@rivosinc.com>
 <b0fcb589-9217-4d30-8b72-5b0210ea871f@ventanamicro.com>
 <73af7008-f40a-4861-8826-2de4d5fc0564@linaro.org>
 <a3b54b5b-005f-46e4-a472-adbbf7d38635@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <a3b54b5b-005f-46e4-a472-adbbf7d38635@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 22/04/2024 21:58, Daniel Henrique Barboza wrote:
> 
> 
> On 4/22/24 16:44, Richard Henderson wrote:
>> On 4/22/24 10:45, Daniel Henrique Barboza wrote:
>>> Palmer, Anup,
>>>
>>> On 4/22/24 10:58, Clément Léger wrote:
>>>> The current semihost exception number (16) is a reserved number (range
>>>> [16-17]). The upcoming double trap specification uses that number for
>>>> the double trap exception. Since the privileged spec (Table 22) defines
>>>> ranges for custom uses change the semihosting exception number to 63
>>>> which belongs to the range [48-63] in order to avoid any future
>>>> collisions with reserved exception.
>>>
>>>
>>> I didn't find any reference to a number for the SEMIHOST exception here:
>>>
>>>
>>> https://github.com/riscv-non-isa/riscv-semihosting
>>>
>>>
>>> Do we have any potential candidates? I would like to avoid, if
>>> possible, setting
>>> RISCV_EXCP_SEMIHOST to 63 as a band-aid just to replace it later on
>>> by the real
>>> value.
>>
>> RISCV_EXCP_SEMIHOST is internal to the qemu implementation and will
>> never be delivered to the guest.
>>
>> I suggest using a number high in the >64 reserved range which will
>> (likely) never be used by any implementation, including ones that *do*
>> define implementation-specific exceptions.  Which seems more likely
>> than not within the "implementation defined" range.
>>
>> E.g. target/i386 uses 0x100+n for qemu internal exceptions.
> 
> I'm not sure if we have a range for risc-v qemu internal exceptions
> only. IIRC we don't.
> 
> If that's really the case I believe we could use whatever i386/ARM uses.
> At least we'll have some
> standardization.

The spec also states that numbers >= 64 are reserved which is why using
a one for custom use was making sense.

Thanks,

Clément

> 
> 
> Thanks,
> 
> Daniel
> 
>>
>> But in any case, the number can be redefined at will and not cause
>> compatibility issues.
>>
>>
>> r~

