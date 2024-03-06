Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D35C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 05:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhjP0-0003gA-Ub; Wed, 06 Mar 2024 00:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhjOv-0003ft-Qi
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 00:01:10 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhjOq-00041z-1D
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 00:01:09 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dbae7b8ff2so32799695ad.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 21:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709701261; x=1710306061;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I6yMAQumNZ+pJK6ySQ+OvbDpNUqZR1uJ6iQTlSg/XDU=;
 b=dypbONi3EpCJzhB0Uip+FTk77+R47e4Nssi8XcmiVg6LK891z4zBlOI2JJA1B7tZwc
 BYDMBsjvSYhn8nfyDo2pAkcC+vuetofryYPnKK70Ekm+Xb52MD7jRrqZuVI9PjOP8aJ+
 vmjIcZOQLt/Zor4TTX9b4QC8F5c49YfbogE3jEMQ3Y3VRKKJi7QqJ9L6t8vFlOaQoH2w
 XAAiJ7wgnVqChIEGu0tqR+PT5bBzBt41k1E0qummEoL2WpCW0McbS9xSkMhXMkShzkZU
 FhuSPyfDeFNWxdDS4DBziPgTCHxcPpZ5nyIQO3VHcKL5owV0yS+NMK/8TzhbjZqJaMFg
 umhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709701261; x=1710306061;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I6yMAQumNZ+pJK6ySQ+OvbDpNUqZR1uJ6iQTlSg/XDU=;
 b=XIZFQA1FwdzE931jRajLQB7L9IwIGwGXbYXoplrH7ALUIqJmMcSRgOKThcBUvLb/eJ
 Jgj5vpxsoDJJ98DRp3rWqftsRsDF4kh/An3rIBleHMgNsC7esz3Al7cvBqFWQ8K1jv7U
 lOrvAuE1i3XbSyJi2zHrcXrfPjpc6xVwxvwaItfPtlvDSrTRcSew4F84BKg3hylG9rMQ
 4IhnPUmn3HSCGcddY8zSfTEkxGb+StfcOagN0V/Ocx+vCcKe9SP2tIjxlS5HK+D9w00f
 JMOiAnLfdEi5Y9s2VxsUZlRC+DNSSnK4eImXBe7M7yrWDK2al9k/Sxonaefo5Ui5Hp4J
 Pkfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr51Qv1MNJRf7wwHMjahgo40hSQk22RiYnF9+ThZDQ+fSFHu1MOi50lO79YFwpMZIb1qex7vCo79+xhuV6lqeHg5T6aNs=
X-Gm-Message-State: AOJu0YwJmaYCz+s2zIoYC+68niI83br0Rd8JzT4GRvNE8H+oVWt0OtMs
 C+pdLqbZ1mvam17+DLi9dkvMaiqE8Z0XHVnARmu5zkxxNrLgJf0xG3l1TmElUXo=
X-Google-Smtp-Source: AGHT+IFb3GmgxrOH6n2M1AAeUcaFKllxakb8+qVvzT1jeJdtWUD9TrvobBf2h5W4v3JFsB9a3UrLPQ==
X-Received: by 2002:a17:902:ecd1:b0:1dc:8c27:9a07 with SMTP id
 a17-20020a170902ecd100b001dc8c279a07mr5032531plh.31.1709701260751; 
 Tue, 05 Mar 2024 21:01:00 -0800 (PST)
Received: from [157.82.206.27] ([157.82.206.27])
 by smtp.gmail.com with ESMTPSA id
 t1-20020a170902e84100b001dcfae45ab7sm7521865plg.57.2024.03.05.21.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 21:01:00 -0800 (PST)
Message-ID: <ad039353-0666-4f92-a348-f6fca4a4339a@daynix.com>
Date: Wed, 6 Mar 2024 14:00:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] contrib/elf2dmp: Conform to the error reporting
 pattern
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
 <20240305-elf2dmp-v2-4-86ff2163ad32@daynix.com>
 <CAFEAcA8HdgZuOf67yjAVZJ0e-ZazOShh=ji4W5CuFyfrRMqNCw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA8HdgZuOf67yjAVZJ0e-ZazOShh=ji4W5CuFyfrRMqNCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/03/05 22:28, Peter Maydell wrote:
> On Tue, 5 Mar 2024 at 07:36, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> include/qapi/error.h says:
>>> We recommend
>>> * bool-valued functions return true on success / false on failure,
>>> ...
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   contrib/elf2dmp/addrspace.h |   6 +--
>>   contrib/elf2dmp/download.h  |   2 +-
>>   contrib/elf2dmp/pdb.h       |   2 +-
>>   contrib/elf2dmp/qemu_elf.h  |   2 +-
>>   contrib/elf2dmp/addrspace.c |  12 ++---
>>   contrib/elf2dmp/download.c  |  10 ++--
>>   contrib/elf2dmp/main.c      | 114 +++++++++++++++++++++-----------------------
>>   contrib/elf2dmp/pdb.c       |  50 +++++++++----------
>>   contrib/elf2dmp/qemu_elf.c  |  32 ++++++-------
>>   9 files changed, 112 insertions(+), 118 deletions(-)
> 
> This is a bit big to review easily. Converting one function
> (or a small set of closely related functions) at once would
> make for an easier to review split.

I'll split patches for each source files.

> 
> 
>> diff --git a/contrib/elf2dmp/download.c b/contrib/elf2dmp/download.c
>> index 902dc04ffa5c..ec8d33ba1e4b 100644
>> --- a/contrib/elf2dmp/download.c
>> +++ b/contrib/elf2dmp/download.c
>> @@ -9,14 +9,14 @@
>>   #include <curl/curl.h>
>>   #include "download.h"
>>
>> -int download_url(const char *name, const char *url)
>> +bool download_url(const char *name, const char *url)
>>   {
>> -    int err = 1;
>> +    bool success = false;
>>       FILE *file;
>>       CURL *curl = curl_easy_init();
>>
>>       if (!curl) {
>> -        return 1;
>> +        return success;
> 
> Why not just "return false" ? "return success" makes it look
> like a success-path, not a failure-path.

It is a mistake. I'll fix in the next version.

> 
>>       }
>>
>>       file = fopen(name, "wb");
>> @@ -33,11 +33,11 @@ int download_url(const char *name, const char *url)
>>           unlink(name);
>>           fclose(file);
>>       } else {
>> -        err = fclose(file);
>> +        success = !fclose(file);
>>       }
>>
>>   out_curl:
>>       curl_easy_cleanup(curl);
>>
>> -    return err;
>> +    return success;
>>   }
> 
>> @@ -186,13 +186,13 @@ static void win_context_init_from_qemu_cpu_state(WinContext64 *ctx,
>>    * Finds paging-structure hierarchy base,
>>    * if previously set doesn't give access to kernel structures
>>    */
>> -static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
>> +static bool fix_dtb(struct va_space *vs, QEMU_Elf *qe)
>>   {
>>       /*
>>        * Firstly, test previously set DTB.
>>        */
>>       if (va_space_resolve(vs, SharedUserData)) {
>> -        return 0;
>> +        return true;
>>       }
>>
>>       /*
>> @@ -206,7 +206,7 @@ static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
>>               va_space_set_dtb(vs, s->cr[3]);
>>               printf("DTB 0x%016"PRIx64" has been found from CPU #%zu"
>>                       " as system task CR3\n", vs->dtb, i);
>> -            return !(va_space_resolve(vs, SharedUserData));
>> +            return !!(va_space_resolve(vs, SharedUserData));
> 
> If the function returns bool type, we don't need the !! idiom
> to coerce the value to bool.

va_space_resolve() returns void *.

Regards,
Akihiko Odaki

