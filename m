Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F36C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdbh-0006Xy-Sc; Tue, 04 Mar 2025 20:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdbc-0006MD-Bn
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:31:28 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdba-0001aB-4X
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:31:28 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-390fb1b987fso4270276f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741138284; x=1741743084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gev7S8y3fn3jwjmRo39QfUqXmJdiqV/PUszHcBWZL2A=;
 b=FtoLZE10We/nCQhCQRd28AfpzL94FDHsxcIDhMzOHuhJinfrRaZOxWkr+mor7/0Siz
 D2pT5gBkVJNh+NSGz4N37+ib0/ppujvL0AcQxPosM6gho+ENt3dXPSTbnCh27avWiLpI
 qWk0+pVLoeZMCnYfxWioOkB4m2YlyQvqBbiPgbSeNnxWZe8kdBxOuuFwZlg0NAu/0VeU
 N9N7wqiohorvN+wWrBgKGHqIX2ri/FVTOT3rMNV9Kqy/zpLTfWFRMLeGo3rBrqMbm1DR
 C/Pa/1CJ96eDgGFggHF2C+fOD54Xd4RSTF8iSEmtWwk4w8hcLQbjHrO7wXpkqKExQPqS
 QSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741138284; x=1741743084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gev7S8y3fn3jwjmRo39QfUqXmJdiqV/PUszHcBWZL2A=;
 b=cpBNk0v++KbxfkURxXsPqqVZxAaKJNI6LDWKbMr5Fh3w3kdTqlk2fkUeOR1P4JOZY6
 z5bVOmMIH+ubcBfkbofEC1y9YzGkcUztIStLBiAxSYL5++y1SOlGWfqhZJzg6DoosDbq
 NewAjSplp0BJEGE8pFNfytPt40I0HjLJA8+hrzcIlQ+w8dHc4cZY7XomlcppF2CZrrTi
 mfy5I/Qz/uXvSZXnfwEPMXJOLwKQdvOW7kaHvEA2RavlizrbjdluuG2n5HpwYidnBd9O
 rY4jp2tXTtU92+iaOVoeiBhredzKD+mx07OdIvzktAJSWILa0F5Tt4Syhff+udaLPCA0
 ImRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8qfP4/tDQbqrzcSq39oeEV/6XjFlkBO2o1WRTbg3L2j1rRJGIwXIebbfoO6uFcnbQgu8mAAOKxkqU@nongnu.org
X-Gm-Message-State: AOJu0Yy+Ah7mbtY6sBHYRK+F1a7i6xCXM4J3CEMggFLre97v4Rw3YMsM
 6ynTwkpksYoGg9h952MjrcoyJ2ua43ouFlkx2AHa3BwtjKTJqQWnE7Sl7pzGa0c=
X-Gm-Gg: ASbGnctvmNNA5cQUHodAND/eRuEj5EuDH0Rb8Zy3pdhYj5IgFQpjGgjg810yluQxLN2
 UcsE1EiwpmqmO/0eAfujh+s18A16knxQAqKVvVu1QcNDIQ2xOBQ+AERDr2YwbhXGnxVf85tEN3o
 u65HYoIenHow5L2gncRYcqMuQwWAuGpJPdnVG9cQS6GM9/nyt2g2T2XCJeu5X2VHDF6kM/S3sqj
 S3Gj5jZ8NWDrdQnI3UQ8nR5olulu0QklpDPhxaL+fc3U04aTsk8pdZEVe9lWG7FyyPD0aim+7ue
 xYubizop7ituyXqob6VYkYGyJxMH1jt3/dJPmBgNYX2nOrP1rtbG7mb699Abt/SDsuuGJkRlKU0
 4IPNvF2qG+kt1
X-Google-Smtp-Source: AGHT+IHB+0todBndY1PqXDVVGWl+1Tsi7hVuzzQcP/U6YdWt8Jr2p/OQBrnWPcQ3QBTEervemBgWaw==
X-Received: by 2002:a05:6000:400e:b0:38b:d7d2:12f6 with SMTP id
 ffacd0b85a97d-3911f726f14mr736157f8f.2.1741138284188; 
 Tue, 04 Mar 2025 17:31:24 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485df5asm19521631f8f.96.2025.03.04.17.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 17:31:23 -0800 (PST)
Message-ID: <4229013f-8601-4e8a-912a-d641bdf8a105@linaro.org>
Date: Wed, 5 Mar 2025 02:31:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/11] system: Introduce QemuArchBit enum
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-4-philmd@linaro.org>
 <1951b0b1-ccea-429e-9e72-e8df7a7a8599@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1951b0b1-ccea-429e-9e72-e8df7a7a8599@linaro.org>
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

On 5/3/25 02:23, Pierrick Bouvier wrote:
> On 3/4/25 16:52, Philippe Mathieu-Daudé wrote:
>> Declare QEMU_ARCH_BIT_$target as QemuArchBit enum.
>> Use them to declare QEMU_ARCH_$target bitmasks.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   meson.build                |  4 +--
>>   include/system/arch_init.h | 65 +++++++++++++++++++++++++-------------
>>   system/arch_init.c         |  2 +-
>>   3 files changed, 46 insertions(+), 25 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 0a2c61d2bfa..1ab02a5d48d 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3357,8 +3357,8 @@ foreach target : target_dirs
>>         config_target_data.set(k, v)
>>       endif
>>     endforeach
>> -  config_target_data.set('QEMU_ARCH',
>> -                         'QEMU_ARCH_' + 
>> config_target['TARGET_BASE_ARCH'].to_upper())
>> +  config_target_data.set('QEMU_ARCH_BIT',
>> +                         'QEMU_ARCH_BIT_' + 
>> config_target['TARGET_BASE_ARCH'].to_upper())
>>     config_target_h += {target: configure_file(output: target + '- 
>> config-target.h',
>>                                                  configuration: 
>> config_target_data)}
>> diff --git a/include/system/arch_init.h b/include/system/arch_init.h
>> index d8b77440487..06e5527ec88 100644
>> --- a/include/system/arch_init.h
>> +++ b/include/system/arch_init.h
>> @@ -1,29 +1,50 @@
>>   #ifndef QEMU_ARCH_INIT_H
>>   #define QEMU_ARCH_INIT_H
>> +#include "qemu/bitops.h"
>> -enum {
>> -    QEMU_ARCH_ALL = -1,
>> -    QEMU_ARCH_ALPHA = (1 << 0),
>> -    QEMU_ARCH_ARM = (1 << 1),
>> -    QEMU_ARCH_I386 = (1 << 3),
>> -    QEMU_ARCH_M68K = (1 << 4),
>> -    QEMU_ARCH_MICROBLAZE = (1 << 6),
>> -    QEMU_ARCH_MIPS = (1 << 7),
>> -    QEMU_ARCH_PPC = (1 << 8),
>> -    QEMU_ARCH_S390X = (1 << 9),
>> -    QEMU_ARCH_SH4 = (1 << 10),
>> -    QEMU_ARCH_SPARC = (1 << 11),
>> -    QEMU_ARCH_XTENSA = (1 << 12),
>> -    QEMU_ARCH_OPENRISC = (1 << 13),
>> -    QEMU_ARCH_TRICORE = (1 << 16),
>> -    QEMU_ARCH_HPPA = (1 << 18),
>> -    QEMU_ARCH_RISCV = (1 << 19),
>> -    QEMU_ARCH_RX = (1 << 20),
>> -    QEMU_ARCH_AVR = (1 << 21),
>> -    QEMU_ARCH_HEXAGON = (1 << 22),
>> -    QEMU_ARCH_LOONGARCH = (1 << 23),
>> -};
>> +typedef enum QemuArchBit {
>> +    QEMU_ARCH_BIT_ALPHA         = 0,
>> +    QEMU_ARCH_BIT_ARM           = 1,
>> +    QEMU_ARCH_BIT_I386          = 3,
>> +    QEMU_ARCH_BIT_M68K          = 4,
>> +    QEMU_ARCH_BIT_MICROBLAZE    = 6,
>> +    QEMU_ARCH_BIT_MIPS          = 7,
>> +    QEMU_ARCH_BIT_PPC           = 8,
>> +    QEMU_ARCH_BIT_S390X         = 9,
>> +    QEMU_ARCH_BIT_SH4           = 10,
>> +    QEMU_ARCH_BIT_SPARC         = 11,
>> +    QEMU_ARCH_BIT_XTENSA        = 12,
>> +    QEMU_ARCH_BIT_OPENRISC      = 13,
>> +    QEMU_ARCH_BIT_TRICORE       = 16,
>> +    QEMU_ARCH_BIT_HPPA          = 18,
>> +    QEMU_ARCH_BIT_RISCV         = 19,
>> +    QEMU_ARCH_BIT_RX            = 20,
>> +    QEMU_ARCH_BIT_AVR           = 21,
>> +    QEMU_ARCH_BIT_HEXAGON       = 22,
>> +    QEMU_ARCH_BIT_LOONGARCH     = 23,
>> +} QemuArchBit;
>> +
>> +#define QEMU_ARCH_ALPHA         BIT(QEMU_ARCH_BIT_ALPHA)
>> +#define QEMU_ARCH_ARM           BIT(QEMU_ARCH_BIT_ARM)
>> +#define QEMU_ARCH_I386          BIT(QEMU_ARCH_BIT_I386)
>> +#define QEMU_ARCH_M68K          BIT(QEMU_ARCH_BIT_M68K)
>> +#define QEMU_ARCH_MICROBLAZE    BIT(QEMU_ARCH_BIT_MICROBLAZE)
>> +#define QEMU_ARCH_MIPS          BIT(QEMU_ARCH_BIT_MIPS)
>> +#define QEMU_ARCH_PPC           BIT(QEMU_ARCH_BIT_PPC)
>> +#define QEMU_ARCH_S390X         BIT(QEMU_ARCH_BIT_S390X)
>> +#define QEMU_ARCH_SH4           BIT(QEMU_ARCH_BIT_SH4)
>> +#define QEMU_ARCH_SPARC         BIT(QEMU_ARCH_BIT_SPARC)
>> +#define QEMU_ARCH_XTENSA        BIT(QEMU_ARCH_BIT_XTENSA)
>> +#define QEMU_ARCH_OPENRISC      BIT(QEMU_ARCH_BIT_OPENRISC)
>> +#define QEMU_ARCH_TRICORE       BIT(QEMU_ARCH_BIT_TRICORE)
>> +#define QEMU_ARCH_HPPA          BIT(QEMU_ARCH_BIT_HPPA)
>> +#define QEMU_ARCH_RISCV         BIT(QEMU_ARCH_BIT_RISCV)
>> +#define QEMU_ARCH_RX            BIT(QEMU_ARCH_BIT_RX)
>> +#define QEMU_ARCH_AVR           BIT(QEMU_ARCH_BIT_AVR)
>> +#define QEMU_ARCH_HEXAGON       BIT(QEMU_ARCH_BIT_HEXAGON)
>> +#define QEMU_ARCH_LOONGARCH     BIT(QEMU_ARCH_BIT_LOONGARCH)
>> +#define QEMU_ARCH_ALL           -1
>>   extern const uint32_t arch_type;
> 
> What are we gaining by having a "bit" oriented enum, vs simple values 
> that can be compared too?

I'm not sure what you are asking here, these definitions are heavily
used in qemu-options.hx, and I don't plan to change them anytime soon.

For the single binary I'll try to keep the command line interface with
no change. For heterogeneous binary I plan to start with no CLI so I'm
not really considering them.

> As well, it would make sense to add subvariants (aarch64, x86_64, little 
> and big endian variants for some arch), so all of them are present and 
> can be queried easily.

IIUC what you are referring, this is planned for another interface, but
not this series which is focused on introducing qemu_arch_name() and
removing TARGET_NAME. While you don't see any improvement in duplicated
target files as of this series, some reduction should happen in the next
step which remove TARGET_BIG_ENDIAN uses in hw/.

>> diff --git a/system/arch_init.c b/system/arch_init.c
>> index b9147af93cb..fedbb18e2cc 100644
>> --- a/system/arch_init.c
>> +++ b/system/arch_init.c
>> @@ -24,4 +24,4 @@
>>   #include "qemu/osdep.h"
>>   #include "system/arch_init.h"
>> -const uint32_t arch_type = QEMU_ARCH;
>> +const uint32_t arch_type = BIT(QEMU_ARCH_BIT);
> 


