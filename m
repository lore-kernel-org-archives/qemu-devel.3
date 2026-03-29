Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5308FC97F9
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2026 21:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6xzq-0007yI-QR; Sun, 29 Mar 2026 17:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w6xzp-0007xy-8F
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 17:48:37 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w6xzn-0002i1-Ku
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 17:48:37 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c06cb8004e8so1415372a12.0
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 14:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774820914; x=1775425714; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HbZ00DdUqBg8ZY3/FALTkREkSlK/OBJyIP1kVH+mhgU=;
 b=JkfzjwpaVaisSZxV1lf94pnyWZEqFOzO2ZCDyHcC8olR9mpktsTNs1vBKuUNp3vjL1
 My6ydwOKe2R1Cui89bbj9uIi/sMlSwKbcSr1T/h1WFmi0k0dnK9PAvEVHHflAcbqI+g+
 2p4Z+oT6HOMKmvSxZlk2956u8MksIyXjfUgY4+zNLR0xR4gpvpaD9K3fmR7MrlnYyYdm
 Zyffvwi441KcKpwf37wYapM1w/XJ2iAAmLl3FYzQpEgIVjgX/tDiGcf1buJHs6gNxTCQ
 hhbLC1XJDJvj0mG1CawHknOZhHgsM7C0Yv6GDB/ECA8cuGeVxHtqLNdz8KLKa3+DGR/v
 +S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774820914; x=1775425714;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HbZ00DdUqBg8ZY3/FALTkREkSlK/OBJyIP1kVH+mhgU=;
 b=Q0ow3nSrQEENaRaIced6lESiU0tvmqAUaKYzR3ZJHNPF3FipV3aox306qaaySKUaak
 Y4P9N5SRlFfSOLDKHe89pizT3TKncDH7+89/kUG2tr/QS8pUsEOUKL2fY046hUkNOsA/
 S0QFidFrcR5T1SbyJ0t2Vc2WL0p7T6MRMZwmubFUx0GdFbzto/pXI0HaEMn4LUUjfA+O
 192ONjSp+ci8V7n8BqlXkZT8aBJoTcybrUFpTaink0ZwIxRbM+IFViBMF/8oUHn/ucEn
 SPnARCfPMfq9AA0LMf5WpkD80g7GObxNW2Q+aV0lXrDyusWcEighxrJ7x/p32sL6zCqj
 9ObA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1L41uliO0qdscOolfbxChuosbSGe9ljmRnlteYEVgWr2um+A3JPfAzLF4wI1DojGd33St+/q7cWu0@nongnu.org
X-Gm-Message-State: AOJu0YyzylRG/eE05tvtskYDCF/1SQaq1O9R9kUr8zHEsIwcQ4UmrTFP
 YxfGwWX45jZbsjc1zOhmABdv7iBj3PGs7UBFVHYm37S7EAEf+0l9R53AEckkRAaGQmA=
X-Gm-Gg: ATEYQzyuBVdFfxR3aVR3IF2qFqwDEtEQFfNPgsDtkawOwhFG1M9gx+QlcKfmcG4h1L4
 ZaKOrOhbY+aF31SDNwHojSORGQbf6WNnT3qKbmdaMmbheQ4FmjgWuMGO153mK8JQv7wsaRQa47+
 OVEBm/+R2au4+vnSi91c+dC0NFSqd2APlNn1Zj0lX0hOKScnAW0QIGSqVW4dCVMa8DlTKu5Fz+i
 /RhdgqofOVR/3imcM3RgVWLxntxUWHSPNguI3oxse/99YT+JA22hXaP5n6jHXiCzlck8W0QICzb
 aHgzz6jlDOFzfehptc1GBuYeh+LENynQxQjVGI66DY8vJvoGl0jGB/sSVTonPv8enMXaOIVDGe+
 TvaXVZHYN8CYtGEJl1vKOJnos05AmSxgkekEGH1eYOT4RJYfCyWjiSkeNFzGtb0oJgN8ruFNgP7
 UNAIBYC2e+QitFPaJwaiQi3XtwX7Sl9FnJpG3EBTVlyjzpOWurkg==
X-Received: by 2002:a05:6a21:9996:b0:39b:e0f4:3235 with SMTP id
 adf61e73a8af0-39c87ae0d4dmr10976676637.49.1774820913916; 
 Sun, 29 Mar 2026 14:48:33 -0700 (PDT)
Received: from [192.168.4.112] ([103.73.85.111])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76917bb31asm4507006a12.23.2026.03.29.14.48.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Mar 2026 14:48:33 -0700 (PDT)
Message-ID: <c91e1d34-df6d-43fe-9785-07af0df86b03@linaro.org>
Date: Mon, 30 Mar 2026 07:48:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 v6 4/6] monitor: Remove last target_long use in
 get_monitor_def()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20260320091019.59902-1-philmd@linaro.org>
 <20260320091019.59902-5-philmd@linaro.org>
 <858c6dde-8ccf-459c-acfe-af38bcba977d@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <858c6dde-8ccf-459c-acfe-af38bcba977d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 3/21/26 07:51, Pierrick Bouvier wrote:
> On 3/20/26 2:10 AM, Philippe Mathieu-Daudé wrote:
>> Truncate manually, removing the need of target-specific
>> code in get_monitor_def().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   monitor/hmp-target.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
>> index 155caedd784..5e9f1b0db5b 100644
>> --- a/monitor/hmp-target.c
>> +++ b/monitor/hmp-target.c
>> @@ -34,7 +34,6 @@
>>   #include "qapi/qapi-commands-control.h"
>>   #include "qapi/qapi-commands-misc.h"
>>   #include "qapi/qapi-commands-machine.h"
>> -#include "exec/target_long.h"
>>   #if defined(TARGET_S390X)
>>   #include "hw/s390x/storage-keys.h"
>> @@ -93,7 +92,7 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>>       ret = target_get_monitor_def(cs, name, &tmp);
>>       if (!ret) {
>> -        *pval = (target_long) tmp;
>> +        *pval = target_long_bits() == 32 ? (int32_t)tmp : tmp;
>>       }
>>       return ret;
> 
> Looking a second time at it, I don't think you need it. Same in previous commit.
> 
> Since pval is a pointer to a (signed) int64, sign will be extended from 32 bit value 
> automatically. So either, it's a positive value, and will be treated as it is. Or it's a 
> negative value, and all upper bits will be set to 1.
> 
> So the casting in int32_t has no effect, since it will be extended again automatically.

No, tmp is uint64_t.

Presumably we're trying to discard the high half of tmp.
This will not be a nop.


r~

