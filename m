Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC0FECD995
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 19:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo4cJ-0001bS-Oi; Thu, 05 Feb 2026 14:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vo4cI-0001b4-BP
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:02:14 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vo4cG-0002Mx-Ew
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:02:14 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a12ed4d205so8928675ad.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770318131; x=1770922931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VzemhuQMeLYqzfURRhnK3Zc9G8vpn3DiZRQTv8M1bNg=;
 b=b1hoUhigrzGby9q3WFQZZ9U6ADXZw7boFoqJSQzuIXewmmQKMbAjnaA+3sKH7l7lME
 latmhEP0sr+NkhGbpklTIHAmcVLEViyvphCRjP1CVBh4r16qHRKDFQup9TcuWh6qe7J2
 tSi3w1kEy5Y6EtFu9ZZ12qvEkc/F7dsaiBJUa91H/1qAAeDN2f3neWh8uke4VaHO/LYJ
 z3Lhs/w3LjL32RxoANqhE/EVVm0Wg6FeQbBlPxbwp+MNXOmZ4gP1siKyaJjCTPfJbHR4
 7uoaA4I1IVh8lHF7mBSnqQwe+S3VLccbQHjB0mGmxLZ0X0ej7BKE4mW8Xmy1tOHnsCfX
 lFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770318131; x=1770922931;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VzemhuQMeLYqzfURRhnK3Zc9G8vpn3DiZRQTv8M1bNg=;
 b=dolwZh8X8W8LmpfH++6i59LQ+lhthQ2hAEcBwO4RQGjhbgNTjuXqzM5EakWIxDS2V4
 meg9qkv8FP9rnJ82dSt3n3izU8vDIwFlN4yXyYdkAwspsfLu+Ly/XYeimDlfzTspvmG4
 Br419sWOEeEn40iV3hW8Az6Oh271IvyJyOc9uW8RoC3aWysGMck+fOC4HOyLCZpdfQ0E
 DLH1dGCBrs6wgeGHz+sRCzi4u1CtAxkDMJwKkCOWjMsP7nU8UFiCWbz/Rfq/hDwEUIK3
 BOj+rF7ytR+Gg9IYsY/uO5NOrjdFbr126H8lXlWYl+qCklYWY+UwghOplPT++EV5goef
 Dusg==
X-Gm-Message-State: AOJu0YzTvqbmZQ9tIfklf7PU/A8mC5UnQ8vYKf34e2MBGe01v+d3CE8v
 9GpRF2EdRX/6ZfsJPJYTK9vRpN8ArOYhURx54GXMGN6gmMOT+N9ZMTBNuJTEi/IzPhk=
X-Gm-Gg: AZuq6aL0xJILNDku3NG0kKAIE/R9A7U/7rqK0rZYjsT07TScZC5+Eqzu2pNUUf+fFFp
 dt3H9a4w1ESwHAZKyug7igugqgWxaC9W6Ulizzy8xizjXuiTZFLd3ixlnKrksnfAL1dgFaDz4gK
 rqOCtaHbjbaJZ6seAwH+A4n4D3Oe1HXLNrixKypwvJaSBRibjDjYsU2VXpEi0sEO3jGk/dXMIoI
 RsN9ezEeSVmffwtnAOAKUuSCSybW+yOgM8otxGa6KS3DCI5rdtKTYocEfRs5JaXjPN5+WXHjJAn
 /ac+oB6URm55ACDAhPD7GuSVPed04X9wYUpN37H/ivy0J6qJJNERO0pSQLkwhae8x1oxlozUMdg
 DMY5x+I0rtfcD911drKIUuVZj13dWuVdMvO3fsPlOePPj1VqQnpQdPlt/eikmV+4gV+YneGAJBr
 LmKoRuK3FoIHYnzC1nf9XO53GS2jTpDs9wkTxYZK7CGDAY19mvt61YCI7E
X-Received: by 2002:a17:902:ec8a:b0:2a9:44e2:8fb0 with SMTP id
 d9443c01a7336-2a95196c3f0mr2155495ad.52.1770318130474; 
 Thu, 05 Feb 2026 11:02:10 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9521b8d84sm800285ad.55.2026.02.05.11.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 11:02:09 -0800 (PST)
Message-ID: <85423dea-5964-4196-a531-40569839c707@linaro.org>
Date: Thu, 5 Feb 2026 11:02:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target-info: set target_arch statically
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, richard.henderson@linaro.org
References: <20260203194113.3026757-1-pierrick.bouvier@linaro.org>
 <878qd735dd.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <878qd735dd.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 2/5/26 1:29 AM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> target_arch() function will reparse target_name() every time if it was
>> not set to a proper SYS_EMU_TARGET_* value (when using
>> target-info-stub.c), which is not efficient.
>>
>> Since we want to preserve the constness of TargetInfo but C doesn't give
>> us flexible compile time expressions, we simply set target_arch using a
>> static constructor once instead.
>>
>> This was found when doing changes to virtio_access_is_big_endian()
>> function, having an overhead of 50% after switching to runtime checks.
>> With this, overhead left is around 3%, due to indirect function
>> calls.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   target-info-stub.c | 11 ++++++++++-
>>   target-info.c      |  9 +--------
>>   2 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/target-info-stub.c b/target-info-stub.c
>> index 8392d81e8f8..ff86a02247a 100644
>> --- a/target-info-stub.c
>> +++ b/target-info-stub.c
>> @@ -10,13 +10,14 @@
>>   #include "qemu/target-info.h"
>>   #include "qemu/target-info-impl.h"
>>   #include "hw/core/boards.h"
>> +#include "qapi/error.h"
>>   #include "cpu.h"
>>   
>>   /* Validate correct placement of CPUArchState. */
>>   QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
>>   QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
>>   
>> -static const TargetInfo target_info_stub = {
>> +static TargetInfo target_info_stub = {
>>       .target_name = TARGET_NAME,
>>       .target_arch = SYS_EMU_TARGET__MAX,
>>       .long_bits = TARGET_LONG_BITS,
>> @@ -29,3 +30,11 @@ const TargetInfo *target_info(void)
>>   {
>>       return &target_info_stub;
>>   }
>> +
>> +__attribute__((constructor))
>> +static void init_target_arch(void)
>> +{
>> +    target_info_stub.target_arch = qapi_enum_parse(&SysEmuTarget_lookup,
>> +                                                   target_name(), -1,
>> +                                                   &error_abort);
>> +}
> 
> This is slightly unclean.  Constructors run before main().  If
> qapi_enum_parse(..., &error_abort) fails here, error_handle() will
> report the unexpected error with error_report() before main() calls
> error_init().
> 
> See also
> 
>      From: Markus Armbruster <armbru@redhat.com>
>      Subject: Re: [PATCH v3 02/20] monitor: initialize global data from a constructor
>      Date: Thu, 18 Sep 2025 08:30:23 +0200
>      Message-ID: <87frck1dds.fsf@pond.sub.org>
> 
> Observation, not objection.
>

Good point.

Richard posted a v2 tooking the build system approach here:
https://lore.kernel.org/qemu-devel/20260205030617.266625-1-richard.henderson@linaro.org/

So it doesn't suffer from this issue.
As well, it's cleaner and more efficient overall, so that's the best way 
to do it.

Regards,
Pierrick

