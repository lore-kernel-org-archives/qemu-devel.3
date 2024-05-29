Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3226CC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJX7-0008PA-2I; Wed, 29 May 2024 09:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCJX6-0008Or-0v
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:40:00 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCJX0-0000TG-Nq
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:39:59 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4210aa012e5so19278075e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716989992; x=1717594792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SaoZoyELB42Y+krESOjYAfuIJuPAS2J73vb7fIitZ70=;
 b=FjN9iYwSp0Jw10ubDt4NnO9MAtZZQs3nXJyh1ecGYY0f/7Dy9v6Dh6VgWnE4+09tx6
 oTDIklW5qD+R45Zct0h/UgL171sWti/YSOfIApbwOr4FI02tRN63hQPe1khh2GV9Gs3y
 zhiTFpVBAWBNZxC/T+G/av4rdthCxY2hoBypjrZG6O8JcJognnUz02VYJYN7BLCTxaZ3
 7b/vJbYK+U/WGW/3VGxTMSQH1YK/6q66i5MJMu0Ovew1PsleNK1IkGjK3FpmDuvwOJxl
 Yrf9I0TivDjj2aAvBZhnbMqU/+0lAhmGI0CCnhZm6qlzwvE4ZVQW5zWv1j/NpUQ4OScY
 RMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716989992; x=1717594792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SaoZoyELB42Y+krESOjYAfuIJuPAS2J73vb7fIitZ70=;
 b=Ajvg6xeSCbjLflAWvNMqIFhsui35OasIUuiJva6zY4f2is4o4o12XKwvhwF2xiCLvZ
 bN/RcWCgP2NIXbbC1ptNXoMs+kfuqkUeZmjVga+toJMYtVuiDgoQu95kgrBifwLq4OSW
 ah1aZW+Pv+xxBEZlSM1cWbTja4zXW4VbN1GTO0+a9N22iohDIJBq5do/UJ+K6wS0BFeh
 IKUIJH823m2ZOg6cc1pTe5tGHLE5VwQjYbD/NkPaetMaql8gciF+duj2GRs8VoHsJA9M
 eC+Ksg0f/HQaqqMnHfOYtPLKpzoCOt3Rmwfs4G+ZIzgKMjoyJ6Vi4NfZsWS0bIbAL8hq
 iQqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIpZPNFKDyO2MFirGErF/TZvUv5+PZA5xYXKUhqjapM7gwhbyAbLSDjgSvh2+lrQAxUnSJPF8evjQU490SZwScj0B/fBg=
X-Gm-Message-State: AOJu0YylHSz+Q73vGh7jdA93NG3W11Ab1uCP5uLVoOvFxxhUli5bYnLP
 qTqN231VaVtQ34wsIpQYshfU47byjq9a0MDrJOlBkEocKmc/0tbdbtUXRdzX6DU=
X-Google-Smtp-Source: AGHT+IEbqP5P7TzRO8SlFk3Jw2uHAfB6VDVAbnhChBCE7NUNR9BTMGMhz0BoVkLz/0mk6qwaxIOu5w==
X-Received: by 2002:adf:f38f:0:b0:355:75f:2862 with SMTP id
 ffacd0b85a97d-3552fddfd25mr10436330f8f.48.1716989992240; 
 Wed, 29 May 2024 06:39:52 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c9570sm14720646f8f.68.2024.05.29.06.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 06:39:51 -0700 (PDT)
Message-ID: <079a43b9-52db-4428-9ae4-52a31fbf5e74@linaro.org>
Date: Wed, 29 May 2024 15:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mc146818rtc: add a way to generate RTC interrupts via
 QMP
To: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20240528072242.493056-1-d-tatianin@yandex-team.ru>
 <87mso8n7tw.fsf@pond.sub.org>
 <9a4ae973-5ad0-4dd1-9818-489833352936@linaro.org>
 <c8ef6f8f-411d-4f25-bfec-d9f2dfa4b55d@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c8ef6f8f-411d-4f25-bfec-d9f2dfa4b55d@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 29/5/24 14:43, Daniil Tatianin wrote:
> On 5/29/24 3:36 PM, Philippe Mathieu-Daudé wrote:
> 
>> On 29/5/24 14:03, Markus Armbruster wrote:
>>> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>>>
>>>> This can be used to force-synchronize the time in guest after a long
>>>> stop-cont pause, which can be useful for serverless-type workload.
>>>>
>>>> Also add a comment to highlight the fact that this (and one other QMP
>>>> command) only works for the MC146818 RTC controller.
>>>>
>>>> Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>>> ---
>>>>
>>>> Changes since v0:
>>>> - Rename to rtc-inject-irq to match other similar API
>>>> - Add a comment to highlight that this only works for the I386 RTC
>>>>
>>>> Changes since v1:
>>>> - Added a description below the QMP command to explain how it can be
>>>>    used and what it does.
>>>>
>>>> Changes since v2:
>>>> - Add a 'broadcast' suffix.
>>>> - Change the comments to explain the flags we're setting.
>>>> - Change the command description to fix styling & explain that it's 
>>>> a broadcast command.
>>>>
>>>> Changes since v3:
>>>> - Fix checkpatch complaints about usage of C99 comments
>>>>
>>>> ---
>>>>   hw/rtc/mc146818rtc.c         | 20 ++++++++++++++++++++
>>>>   include/hw/rtc/mc146818rtc.h |  1 +
>>>>   qapi/misc-target.json        | 19 +++++++++++++++++++
>>>>   3 files changed, 40 insertions(+)


>>>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>>>> index 4e0a6492a9..7d388a3753 100644
>>>> --- a/qapi/misc-target.json
>>>> +++ b/qapi/misc-target.json
>>>> @@ -19,6 +19,25 @@
>>>>   { 'command': 'rtc-reset-reinjection',
>>>>     'if': 'TARGET_I386' }
>>>>   +##
>>>> +# @rtc-inject-irq-broadcast:
>>>> +#
>>>> +# Inject an RTC interrupt for all existing RTCs on the system.
>>>> +# The interrupt forces the guest to synchronize the time with RTC.
>>>> +# This is useful after a long stop-cont pause, which is common for
>>>> +# serverless-type workload.
>>
>> In previous version you said:
>>
>>   > This isn't really related to migration though. Serverless is based
>>   > on constantly stopping and resuming the VM on e.g. every HTTP
>>   > request to an endpoint.
>>
>> Which made some sense. Maybe mention HTTP? And point to that use case
>> (possibly with QMP commands) in the commit description?
> 
> Hmm, maybe it would be helpful for people who don't know what serverless 
> means.
> 
> How about:
>      This is useful after a long stop-const pause, which is common for 
> serverless-type workloads,
>      e.g. stopping/resuming the VM on every HTTP request to an endpoint, 
> which might involve
>      a long pause in between the requests, causing time drift in the guest.

Please help me understand your workflow. Your management layer call
@stop and @cont QMP commands, is that right?

@cont will emit a @RESUME event.

If we could listen to QAPI events from C code, we could have the
mc146818rtc device automatically sync on VM resume, and no need for
this async command.

I'll let our QAPI expert enlighten me on this :)

