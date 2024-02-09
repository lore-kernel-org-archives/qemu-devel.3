Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F895C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 16:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYTw7-0002po-Oc; Fri, 09 Feb 2024 11:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYTw4-0002oe-Vq
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 11:41:10 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYTw1-0006gw-9j
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 11:41:07 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41068e36cbbso6762775e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 08:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707496863; x=1708101663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iSA6HhjgtgS+VYvw61Q384rZfEab29SZDHt8SdZCCu0=;
 b=Foiy2Iis/++URF+mx52f7rC3XvltJ49Z2vhBvZoVBCxhPUQ1ADvBKys5IMOCsPx2k/
 646bkh2lZHzcEtzl5jIMbHuUCWoJOzvKOw2mRBZhwM6Uh1yWhHRneIz/NCST8RAzThrm
 Loa/0gKGMbWPRZybwGE/q6qitDavSKNs2Cz2FGvkMfaCWlmaqO7exiCwCLQtQA3xZqr6
 mxWwvIGgh7bXkR6yVcktveoxgsOv01T0EWmerH95mzjfWtOR3znE0oM1B1EF0Wfd6kiW
 nFY0qmz+9+1dkhgUClg0z5521Bm9lI/Q/j46t/63VbFiDRiDM77sXCcqXzmyB/HN9Pjm
 0JFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707496863; x=1708101663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iSA6HhjgtgS+VYvw61Q384rZfEab29SZDHt8SdZCCu0=;
 b=u9JV2tZDWRDXl307Yzdl5L3a3qQtAZ5emDOLiXWYJWb63G9Q+SNKBxtaCYFtQA+Q6J
 Bq+4kfFEMzM3fKLif6SeODRSbnxy7t5OMZWxIZ0rDMgCU+zf1j1q7/mg70128y0xa7oK
 XgzKyVMC9tk3cWdEopgPLo/qD6u1NRMQuRbeQGYRL6OGTlk7tZnMukh5+lDKCyb6g8T6
 JEOrR51GvRN5cUo8AQxoGT/3qCBRzEQUKLymsGQdAkAaO++4Y7U9YqFNV9bCi7yAVImE
 AfURpVBuYXR1L3OwEq0jIaR9pVlvVlQENcFBcuAFWfkf1b7PMEOOxQ9xeNBsdLwrd425
 gY9A==
X-Gm-Message-State: AOJu0YyZGQUQzS5S+gW5c9rUVLe3t1eAIkpY89LqRFX+Kon9ItalxF4O
 2P4gqeDlpejywrhH+5LDP53a2ftRHFrXarT/YCV2tueQVzRR0Hcjyuwc1EGNV44=
X-Google-Smtp-Source: AGHT+IFE6M/HDLUe7XvRKr9Xb8XD1golMsntQyrxDY63eWBSLOr/zd39TdRYQgGL//rrpKuEZK6jPQ==
X-Received: by 2002:a05:600c:3ac6:b0:410:3bf6:fabe with SMTP id
 d6-20020a05600c3ac600b004103bf6fabemr2044644wms.6.1707496863410; 
 Fri, 09 Feb 2024 08:41:03 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUMloP6m+ODjqWexS0tsMf9Cp6/YAZytC2vti9mJw8ePmpXZmvfRSgZm9ALoWT6b/LudPxxmUIwyZxq/fZSG203GyDtT2C6eBUNpRwMOLh8AJIRn1jUqlCWeF6r73+GY6vHXokh9MY6TTNsbN7Mg/h0q00kq9ymCCA8W3Sou2a5qTwt5TMtv1eY/NyNYUkt1Z8rfobzhP/F8+zNFFWLNP8osghBSKt/KUlCmBAEPj/A5yr7uxgbBQLGI6esN6VA5EWYfA048keNhvzmQeiM01YKxJN/BFniuvT4HY6IlTVtiYkXQKhUQRY=
Received: from [192.168.69.100] ([176.176.147.207])
 by smtp.gmail.com with ESMTPSA id
 jn14-20020a05600c6b0e00b004104bc8d841sm1157700wmb.13.2024.02.09.08.41.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 08:41:03 -0800 (PST)
Message-ID: <06da11bb-424c-49d8-a650-b846acb82298@linaro.org>
Date: Fri, 9 Feb 2024 17:41:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] system/physmem: Assign global system I/O Memory to
 machine
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-trivial@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>
References: <20240209150039.22211-1-philmd@linaro.org>
 <20240209150039.22211-4-philmd@linaro.org>
 <CAFEAcA9+6aK_uPa6tFV2-yh3g_2oeuvFaOs=nd=2dexm=uxN9Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9+6aK_uPa6tFV2-yh3g_2oeuvFaOs=nd=2dexm=uxN9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

(+Markus I forgot to Cc)

On 9/2/24 17:06, Peter Maydell wrote:
> On Fri, 9 Feb 2024 at 15:01, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> So far there is only one system I/O and one system
>> memory per machine.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   system/physmem.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 5e66d9ae36..50947a374e 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -2554,12 +2554,13 @@ static void memory_map_init(void)
>>   {
>>       system_memory = g_malloc(sizeof(*system_memory));
>>
>> -    memory_region_init(system_memory, NULL, "system", UINT64_MAX);
>> +    memory_region_init(system_memory, OBJECT(current_machine),
>> +                       "system", UINT64_MAX);
>>       address_space_init(&address_space_memory, system_memory, "memory");
>>
>>       system_io = g_malloc(sizeof(*system_io));
>> -    memory_region_init_io(system_io, NULL, &unassigned_io_ops, NULL, "io",
>> -                          65536);
>> +    memory_region_init_io(system_io, OBJECT(current_machine),
>> +                          &unassigned_io_ops, NULL, "io", 65535);
>>       address_space_init(&address_space_io, system_io, "I/O");
>>   }
> 
> What's the intention in doing this? What does it change?

We want to remove access to pre-QOM and possibly hotplug QOM paths
from external API (CLI & QMP so far).

When the parent object is obvious and missing we simply have to
explicit it.

> It seems to be OK to pass a non-Device owner in for
> memory_region_init() (whereas it is *not* OK to do that
> for memory_region_init_ram()), but this seems to be
> getting a bit tricky.

Yes, memory_region_init_ram() is problematic; I'm hardly trying
to ignore it at this point.

