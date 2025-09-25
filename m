Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2073FCAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1k3G-0001ZV-BG; Thu, 25 Sep 2025 07:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1k37-0001Yd-U7
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:22:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1k2y-0006Re-Oi
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:22:07 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-46b7bf21fceso5805615e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 04:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758799317; x=1759404117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d8g/Zr4Ho39Dd9DDIw28b3F0Ose4fAr6luyxDx8Cjbk=;
 b=k90FM9Ef9+8N4XNJYyq16K3uPOdcjg4v5FN+5EniSEtk7vzcOOZfKio2H3GlDbNV6Z
 cov4O5+pvykorEXXOqgMtV18QVZYq5GqDCJW5eaclnydulBC3SgENmIPVvixaLY1vAor
 GBsLJNW8n2iVekLZ5givlWeqJd6FliOVfMsAyFBrUq9FMox8CiEN3AJOHDy/57YkysYu
 UmeJB3Lq0hrw2YvRN6BJuiBhzp0JKZtD3uXdTLTgIA025trkWyTk54+z9yPP86WfU7fB
 WywHbUwlmLutrynUPoRrUxlDBbv2lpYHlNbTJ7/8DpU9BAkijYBpJOleU2ckETVzeRyK
 JjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758799317; x=1759404117;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d8g/Zr4Ho39Dd9DDIw28b3F0Ose4fAr6luyxDx8Cjbk=;
 b=N9A/PIDjy6lRgLOcCvkzSuMAZymBhdIGY/kjZx0YYUN6vmOpuu1j9FCdCeaZ+o8c/x
 suHDhl16LVYo3A2mMNvWf08R1U18QLqL+pnwCl3c33iNFkBAy+4GwJf1JGTAbgxNzDO0
 hvBI7rXttcFzP8VmDONJHLGTG+lzpRpCqoTruMq+7h2DuytvlvmxxROQpE0ChyUaAGuX
 Dq9k+Q0OUaNGmunuYADwcJEB2oi1x9CC2tspbByxgo/WxvYTp8DvKdNku8UengiKEF1i
 II+4MVQ4ZyijXzY7dwaNsn4o6H8HwoIO5FPgzY8kcL1wK+1zWKg4sA41pNL0aYSX4iAq
 86Fg==
X-Gm-Message-State: AOJu0Yyuudtm6BGy0WXc54xpBhpNvqRzHzOUtqLlzZJR2apVpw16VqK2
 0ciPFWqRpZ0dGMtJ+b+P1JMFaDgssdgla0mkoKG2wC0o+8eEloSxO6xxF25KsgvGn68=
X-Gm-Gg: ASbGnctKupwuG6mxj72L+pkMESyG50qIFPYs9qsRyJxvnJRlRaHZjuAq6blERwOK72y
 heQDSJDwIvDNs/uS7msYyeCnbdGXjJL6mT0kF1hfOd67Gp0DlVFIUE0al5CZDwvfSvUPNVNLWq3
 aZENIg1D0wyIdCSnjVFpHDWl99VUVY3Z/vcJtPQOxULb/r4OOG+0zqCVqlcr7r8rl5qJphNfLT/
 nZvK4R3673BLEEMipiTzbZ0X/tQvjbtWCZkdrNK91ZjYoGR06ja5vYN3gUhk61R3nPU/mF9Zo4P
 EkD52KqFJGH0F884TLYdlzFMRnQS67LyhfDZYp9JeMooc+6Mo9rQqiU+3ezBR+enXqFfCtT05UR
 i0NrRAMrWcYvkamSy1xasZvMbI1b4k01VMbIvcKfdhjsTR/SVvN6yF11GpMEnjFm09g==
X-Google-Smtp-Source: AGHT+IFNHneSnj5JxWrfzocI31qThVGc964ugcB1WCP7ynyhNVFlqVB7lI5gotHiwQuVElZa7YSF/w==
X-Received: by 2002:a05:600c:3b96:b0:45d:e110:e690 with SMTP id
 5b1f17b1804b1-46e329b84f2mr33271785e9.14.1758799316714; 
 Thu, 25 Sep 2025 04:21:56 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6921b7dsm2578103f8f.42.2025.09.25.04.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 04:21:56 -0700 (PDT)
Message-ID: <9e6cd227-739d-4efc-acff-c1b16fd9e2fe@linaro.org>
Date: Thu, 25 Sep 2025 13:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/23] util: sync error_report & qemu_log output more
 closely
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
 <3d77f02a-5e89-432b-8be1-d76df49b90e2@linaro.org>
 <aNUaE77pS6ypY8FA@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aNUaE77pS6ypY8FA@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

On 25/9/25 12:31, Daniel P. Berrangé wrote:
> On Thu, Sep 25, 2025 at 12:22:39PM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Daniel,
>>
>> On 25/9/25 11:44, Daniel P. Berrangé wrote:
>>> This series is a tangent that came out of discussion in
>>>
>>>      https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00903.html
>>>
>>> In thinking about adding thread info to error_report, I
>>> came to realize we should likely make qemu_log behave
>>> consistently with error_report & friends. We already
>>> honour '-msg timestamp=on', but don't honour 'guest-name=on'
>>> and also don't include the binary name.


>>> The main things to note:
>>>
>>>    * error_report/warn_report/qemu_log share the same
>>>      output format and -msg applies to both
>>>
>>>    * -msg debug-threads=on is now unconditionally enabled
>>>      and thus the param is deprecated & ignored
>>>
>>>    * Thread ID and name are unconditionally enabled
>>>
>>>    * Guest name is surrounded in [...] brackets
>>>
>>>    * The default output lines are typically 15 chars
>>>      wider given that we always include the thread
>>>      ID + name now
>>>
>>>    * This takes the liberty of assigning the new file
>>>      to the existing error-report.c maintainer (Markus)
>>>      Since splitting it off into message.c instead of
>>>      putting it all in error-report.c felt slightly
>>>      nicer.
>>>
>>> One thing I didn't tackle is making the location
>>> info get reported for qemu_log. This is used to
>>> give context for error messages when parsing some
>>> CLI args, and could be interesting for log messages
>>> associated with those same CLI args.
>>
>> Testing with this change on top ...:
>>
>> -- >8 --
>> diff --git a/include/qemu/message.h b/include/qemu/message.h
>> index 2cc092c993b..97fd2a94fbd 100644
>> --- a/include/qemu/message.h
>> +++ b/include/qemu/message.h
>> @@ -10,2 +10,3 @@ enum QMessageFormatFlags {
>>       QMESSAGE_FORMAT_THREAD_INFO = (1 << 3),
>> +    QMESSAGE_FORMAT_VCPU_ID = (1 << 4),
>>   };
>> diff --git a/system/vl.c b/system/vl.c
>> index bf9f80491f2..2f43a075be9 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -149,3 +149,4 @@
>>       (QMESSAGE_FORMAT_PROGRAM_NAME | \
>> -     QMESSAGE_FORMAT_THREAD_INFO)
>> +     QMESSAGE_FORMAT_THREAD_INFO | \
>> +     QMESSAGE_FORMAT_VCPU_ID)
>>
>> diff --git a/util/message.c b/util/message.c
>> index 7d94b9d970d..19d1331403a 100644
>> --- a/util/message.c
>> +++ b/util/message.c
>> @@ -6,2 +6,3 @@
>>   #include "monitor/monitor.h"
>> +#include "hw/core/cpu.h"
>>
>> @@ -46,2 +47,8 @@ void qmessage_context_print(FILE *fp)
>>       }
>> +
>> +    if (message_format & QMESSAGE_FORMAT_VCPU_ID) {
>> +        if (current_cpu) {
>> +            fprintf(fp, "(cpuid:%d): ", current_cpu->cpu_index);
>> +        }
>> +    }
>>   }
>> ---
>>
>> ... on a branch where I test heavy vcpu context switching.
>>
>> When using tracing + stderr AND the stdio console, I sometimes get
>> the trace events to disappear at some point. Not sure why (or if related
>> to my branch) yet.
>>
>> When redirecting traces to a file ('-D foo.log'), all traces are
>> collected (no hang).
>>
>> In both cases I notice a high performance slow down (when tracing is
>> used).
>>
>> Suspicions:
>> - flocking
> 
> The logging code (and thus tracing) already used flockfile in
> qemu_log, so that should not be new. Only error_report gained
> new flockfile calls in this series.
> 
>> - new formatting
> 
> Seems the more likely option.  If practical, a git bisect across the
> series should show which part introduced any slowdown.

This is planned.

> Assuming you've not given any -msg option to QEMU though, the finger

Indeed.

> probably points towards the thread name code, as the bit that is
> new and enabled by default.

I thought about that then noticed the thread name is const (preformatted
once in each qemu_thread_get_name() implementation).

> 
> With regards,
> Daniel

