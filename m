Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDE0C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfno-0003RE-5T; Thu, 13 Mar 2025 06:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfnl-0003Ok-Dr
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:28:33 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfng-0003RV-GX
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:28:33 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-394780e98easo492005f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 03:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741861706; x=1742466506; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qLgr7Mc6uis7QeH0vS2N18sxnc5vIUrDHX5kEV5eUjw=;
 b=imdW0ZyIEg/X+eWzruegRuv05qiI1vtnbKWgeJPCw2Z3x8W8M6+nAS3/Ci2UZAQfiR
 7ntIqvhV8FSr1YY3ul85Dm8BuRG3TluP2+x1YMuh1Edt4ZWJttgIbwrhCKtVVzp6OyHg
 0as/LvoVOsqXkx0MJs6UELHKnGYVkIyd5/JDbRiQ9puldS2053JbJcGxZvE07CxOLTvw
 q/eYU39MhBNrpeATSAK1PlkYJMZESLgsDSiCIjb0PYOc2sK9W1wz0uGcMLP6wQ9d5q4O
 jflKIsumT1gBLJZU3QOd/XTPN/NcbxJynZWHbatXyE2Y5TC1n8/v7+mrNCJ1n19VgDEV
 QwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741861706; x=1742466506;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qLgr7Mc6uis7QeH0vS2N18sxnc5vIUrDHX5kEV5eUjw=;
 b=NgJRA/rdhm+G0lyOcVyLuXlcO5FezYb0YGrc3G28NItj825j3n+6rwvAfVUOw+eNRh
 fnFB/rweLAl5lpvpT1x2vAcMe8zKCCB9hAXd24NodeiM6EpFpywtkrcCV+dfcBFmVQ+l
 KDTUkMLm/XybjIfsCgX6emgRIn/oLUpv52v4QgfrkYHyFgqJV6Krb+mmLWaG2iLj+pXn
 iutpHoPlvleNUDNXIjoPHb8mvyaS7NFGgTf3zaLacxIjZq2BYG02vCAtFX4PyXRSQXPt
 Jnet5VzFrFRekPUMwI2jkY5FM4Ckz7U+TF4ffo96VqKs+v+B4FojE9IKfA19CCTB+YQD
 90PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzF8gFFHCdMrbDA4nafqE/Wgl0X+YPtdnUfQ6sop+3E3/G+3UBJy1xjcnpBTaNHHHhSjdI+lMXg8E5@nongnu.org
X-Gm-Message-State: AOJu0YzUftqzNWOfLrmEvitfNxxH0Spt3AL8j54mhGDcmx77QaQFNzdM
 Q9JsgnuUG1QyGt5Ej94lnWDHp0Ukk8lUFUWBENWbhjws6FpxQWvOLxvF0bgwJjqNCKKvCq1rs9E
 49B0=
X-Gm-Gg: ASbGncvFxFCedp3x2E7WSope6l/BEcEz+V5CAqWgQq/+ElkGbbeMjVTteRujZo0gB0Z
 KUHpLI1ASodn6HdOBwaf2jUTC2FqiJd3XRbNqhGOONuXOIOmnlvugeSZqIj+Pxu0FSWdeDMB2jl
 VPyphUOOheB6XnWAxhTpFoUwDnUCnrnulRknmTXlkAFKDcBoRPBtDR/VPXnZWQnawOA8vt+/8cN
 zeTvRKZpk+K55py2ZiFkMDhmZz254LypmNFA3g2mOOH999rEkQ7UZV6yh9m/XnEJtrMfwdlFDoQ
 dNr7zEM0nPlbbLVwcxIlAuMCNhzNbCk8ZLOa0VZ2P5dgVVEr888cws+34MEmArOCDh9lcZroGRT
 jq5WrHUBzZi7umuA=
X-Google-Smtp-Source: AGHT+IHG6lXdj5JOdT9R1O2iXeuQrcukxMd3ACv+PVhoiBFsfel2rJ922fuXx3oZ9DjZpPOA1QQaJA==
X-Received: by 2002:a5d:6d8c:0:b0:390:e48a:3869 with SMTP id
 ffacd0b85a97d-39132d774a1mr18961415f8f.11.1741861706398; 
 Thu, 13 Mar 2025 03:28:26 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df402esm1632927f8f.1.2025.03.13.03.28.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 03:28:25 -0700 (PDT)
Message-ID: <ed71ef33-97ac-456a-ba42-75a71e5f11ff@linaro.org>
Date: Thu, 13 Mar 2025 11:28:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/37] semihosting: Move user-only implementation
 out-of-line
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-23-richard.henderson@linaro.org>
 <1515d5ca-d6c9-4287-b171-4739382f5620@linaro.org>
Content-Language: en-US
In-Reply-To: <1515d5ca-d6c9-4287-b171-4739382f5620@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 13/3/25 11:04, Philippe Mathieu-Daudé wrote:
> On 13/3/25 04:45, Richard Henderson wrote:
>> Avoid testing CONFIG_USER_ONLY in semihost.h.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/semihosting/semihost.h | 29 ++---------------------------
>>   semihosting/user.c             | 30 ++++++++++++++++++++++++++++++
>>   semihosting/meson.build        |  2 ++
>>   3 files changed, 34 insertions(+), 27 deletions(-)
>>   create mode 100644 semihosting/user.c
>>
>> diff --git a/include/semihosting/semihost.h b/include/semihosting/ 
>> semihost.h
>> index 97d2a2ba99..b03e637578 100644
>> --- a/include/semihosting/semihost.h
>> +++ b/include/semihosting/semihost.h
>> @@ -26,32 +26,6 @@ typedef enum SemihostingTarget {
>>       SEMIHOSTING_TARGET_GDB
>>   } SemihostingTarget;
>> -#ifdef CONFIG_USER_ONLY
>> -static inline bool semihosting_enabled(bool is_user)
>> -{
>> -    return true;
>> -}
>> -
>> -static inline SemihostingTarget semihosting_get_target(void)
>> -{
>> -    return SEMIHOSTING_TARGET_AUTO;
>> -}
>> -
>> -static inline const char *semihosting_get_arg(int i)
>> -{
>> -    return NULL;
>> -}
>> -
>> -static inline int semihosting_get_argc(void)
>> -{
>> -    return 0;
>> -}
>> -
>> -static inline const char *semihosting_get_cmdline(void)
>> -{
>> -    return NULL;
>> -}
>> -#else /* !CONFIG_USER_ONLY */
>>   /**
>>    * semihosting_enabled:
>>    * @is_user: true if guest code is in usermode (i.e. not privileged)
>> @@ -59,17 +33,18 @@ static inline const char 
>> *semihosting_get_cmdline(void)
>>    * Return true if guest code is allowed to make semihosting calls.
>>    */
>>   bool semihosting_enabled(bool is_user);
>> +
>>   SemihostingTarget semihosting_get_target(void);
>>   const char *semihosting_get_arg(int i);
>>   int semihosting_get_argc(void);
>>   const char *semihosting_get_cmdline(void);
>>   void semihosting_arg_fallback(const char *file, const char *cmd);
>> +
>>   /* for vl.c hooks */
>>   void qemu_semihosting_enable(void);
>>   int qemu_semihosting_config_options(const char *optstr);
>>   void qemu_semihosting_chardev_init(void);
>>   void qemu_semihosting_console_init(Chardev *);
>> -#endif /* CONFIG_USER_ONLY */
>>   void qemu_semihosting_guestfd_init(void);
>>   #endif /* SEMIHOST_H */
>> diff --git a/semihosting/user.c b/semihosting/user.c
>> new file mode 100644
>> index 0000000000..f5b500493b
>> --- /dev/null
>> +++ b/semihosting/user.c
>> @@ -0,0 +1,30 @@
>> +/*
>> + * Semihosting for user emulation
>> + *
>> + * Copyright (c) 2019 Linaro Ltd
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "semihosting/semihost.h"
>> +
>> +bool semihosting_enabled(bool is_user)
>> +{
>> +    return true;
>> +}
>> +
>> +const char *semihosting_get_arg(int i)
>> +{
>> +    return NULL;
>> +}
>> +
>> +int semihosting_get_argc(void)
>> +{
>> +    return 0;
>> +}
>> +
>> +const char *semihosting_get_cmdline(void)
>> +{
>> +    return NULL;
>> +}
> 
> Do we really need the symbols, can't they be elided now?

Apparently we only need semihosting_enabled().

