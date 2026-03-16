Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28284F46445
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25Oz-0007PG-Iw; Mon, 16 Mar 2026 06:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1w25Ou-000779-Uf
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:21 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1w25Or-0003bw-IT
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:18 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-50902b1006cso39676541cf.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1773657736; x=1774262536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0GbtDccudGM5TUUMHUNfrU2i5E4foPGykGBDUGJMv7I=;
 b=EgtLkP9iZ/LrvjEOYr1ega5ZIfyVgwYXBooVCa0aqsaGqyBcvP8VwiKLd/Lng5o8P6
 UBOerL99XjlJ4ZoO2enksna33eK2GAzU3oN4jWmROV0dru/2ELzUZqWd2vo1Yc+3oNk0
 gjd0IodR+Mwt7zh5B5hpd5W0Z9ZPPIO/VCLotr9uMidZgUSa28/amU2T+mEWoOKJj8cA
 0Ez/reE8XMsjhVBaO3BMEpaD8aiA1M8N7pipddnN0N17jbCBhTFWQ3Nex/MI08ONEu/b
 xSYs6DCR5tcj0nOmAd2gDknuL9Ry9Jn2M34HwniqEHxmeZxhpgN07Goy01cv1XnxHbx4
 Maxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657736; x=1774262536;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0GbtDccudGM5TUUMHUNfrU2i5E4foPGykGBDUGJMv7I=;
 b=sgahzCG6jlWqN5EcWNcdXPq2BhZwpEoM7n/59oCJg92tuQq6xjIFdq+1Cm0p0YtBly
 SbKxmzzz7DsANxjlQmQZ3NvWCWwrlDcRdCFRCI8aZexP/dOZqgKfe8gQV27t8wQXBBms
 2Ka2zA1w8xNLn/X2qKkT7LEqehf9ZskRWZvVqGCkR7thi5T1ATo1fb5rAd9Z4bg6v48o
 gB74f4IFXYDFL/D54tvI8XyfJunOV057hCre1+HDfEvJ3IeFGuKw0g17sTxQNLMrsDTq
 ZXVhmfSjuqEUEj9eSnqOx039f2QRaD8xJOKvnQa/mcAfPUXt17R4Yo/l8/ZfWchALYkS
 sbFg==
X-Gm-Message-State: AOJu0YwzB5BMv0l5UYfl884VCOi8LrO/MvwLILXYwCJ97iHl6lUpuzVc
 w+ye4cayMiDDnYMFTV6AIGXogQqKK1qkfAfyHiB/TII2r+UKqJ6YpB6q9EANjev+Klg=
X-Gm-Gg: ATEYQzwf6aESyqwATIFdtQOCKRQoVtbz/956AuJlwJ1FlgV0kcQFt9yOGDNchYUY4yM
 EbVJKaAGpPu/WKz9ucqCWNGThnBVPaveqWe1/bTRtrENFRD8DRTCqIyZzAFMm20H02CbgHZB9dg
 OuKegXbfgXjoju7GrnHTsXzfcEjaZwJi4+QOf5OHoTR2BGt5UPReJ5mo1U0Br4H3siB06Oy+c2t
 Wp5VSNie/tWh1o+b7otMol5IftZibYUVyOX1YTgBwSw8s03++Gz8N8RhN2P8obZfthXOVgTF1fe
 TjuD+cCQUQETt9nKOp4yI0vgxWCXDAGnE9hxjk9lxt3FpC4b83Cn2/Z/TKpTtk5rrtCkSV9wyJ/
 KgbaMr7NcJDjFXOAcn0UKXG6QNgnTyFKduGdE0Q7kz58TF0r9BMRbQEVC9IN+oyemve4aZeBwf/
 V1VKTGYX1sznnhE3qOFOaxXg32YEJnhKhUHE8vJrCHM815VMmiBaPu
X-Received: by 2002:a05:622a:244:b0:509:3141:312c with SMTP id
 d75a77b69052e-50957e11044mr162452971cf.40.1773657736240; 
 Mon, 16 Mar 2026 03:42:16 -0700 (PDT)
Received: from [192.168.68.100] ([152.250.131.163])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5093a14d7a6sm113575091cf.33.2026.03.16.03.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 03:42:15 -0700 (PDT)
Message-ID: <8e124f96-b6c7-4e9b-b11e-f0f3e387eaf4@ventanamicro.com>
Date: Mon, 16 Mar 2026 07:42:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] target/riscv: Don't leak general_user_opts
To: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260313182957.28432-1-farosas@suse.de>
 <20260313182957.28432-4-farosas@suse.de>
 <CAFEAcA-2mcfjsngURah2jGvz0kib+-JYCGWjUPGWF8W262HJYg@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA-2mcfjsngURah2jGvz0kib+-JYCGWjUPGWF8W262HJYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x834.google.com
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



On 3/16/2026 6:56 AM, Peter Maydell wrote:
> On Fri, 13 Mar 2026 at 18:30, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> The global variable general_user_opts is being assigned twice, losing
>> the reference to the previously allocated g_hash_table.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   target/riscv/cpu.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index e56470a374..afccfc2935 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -1099,8 +1099,6 @@ static void riscv_cpu_init(Object *obj)
>>                               "riscv.cpu.rnmi", RNMI_MAX);
>>   #endif /* CONFIG_USER_ONLY */
>>
>> -    general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
>> -
>>       /*
>>        * The timer and performance counters extensions were supported
>>        * in QEMU before they were added as discrete extensions in the
>> @@ -2751,6 +2749,7 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
>>       cc->tcg_ops = &riscv_tcg_ops;
>>   #endif /* CONFIG_TCG */
>>
>> +    general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
>>       device_class_set_props(dc, riscv_cpu_properties);
>>   }
>>
> 
> This doesn't look to me like it's sufficient. These hash
> tables are used to store the values of CPU properties.
> Those are per-object, not per-class, so surely the hash
> table needs to be in the object, not a global ?


This hash is used as a hack to determine if a QEMU command line option was
user set or not (i.e. a global setting).  Back when this was introduced
(and I assume this is still the case today, need to double check) the command
line support in QEMU didn't provide this information.

Most QEMU targets don't care whether a given CPU property was user set or not,
but the RISC-V target has a lot of code that automagically disables stuff given
certain conditions (e.g. riscv_cpu_disable_priv_spec_isa_exts()).  The result is
that we were reaching situations, Gitlab bugs being opened and what have you,
where the user was doing things like this:

qemu-system..... -cpu X,extensionA=on (...)


But so it happens that extensionA isn't compatible with the existing extension set
in X.  The behavior back then was to disable extensionA during realize() and be
done with it, leaving users baffled and frustrated with their cmd line settings
being ignored.  Now we're able to error out in these cases.

All this said, most likely there's a better/cleaner way of storing this command
line information that has global effect.  Just point me in the right direction and
we can make it happen for the next release.


> 
> There are also other hash tables in the TCG riscv code
> with the same problem (using a global variable to store
> property info that is per-CPU, not global).


Not sure which hashes are you talking about but there's a high chance that they
have to do with tracking QEMU command line options that were set or not and we
want to know the difference.

In hindsight I should've sent a RFC detailing this situation we have in RISC-V
and maybe we could have discussed changes in the QEMU cmd line handling to provide
this info.  I'm willing to do that route if that means less hash table stuff to
deal with in RISC-V code.


Thanks,
Daniel


> 
> thanks
> -- PMM


