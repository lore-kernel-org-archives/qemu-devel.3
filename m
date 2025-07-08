Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A9BC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGcM-0003Le-8R; Tue, 08 Jul 2025 18:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGYv-0005XY-6m
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 18:13:18 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGYs-00086v-K1
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 18:13:16 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso2720259f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 15:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752012792; x=1752617592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+kbUNrPjCxqJMdGOcYTq49UvPqoFqRW4yRvrM7RsdxQ=;
 b=Id624D/IVFn2+JAruffGCnjmD30JkWK029KM3vUUhnLECjp+CRPblkkKpy+vIHiFQW
 DQsxeGCnOGrET90z7VZGkc8DAfCG2/TOQcRZnl9/6kUJo1KXzcoKBDoJgLZDrCkQDck5
 Rk3H5QR65Z9DWzwzpOoWYol506LM5MEDS5VGRPeSyMfp8TIw01QYb/y9QwsduUMhJoIO
 JRXD1WnLTdLzWgeWTgY2LyWoz655fbszrDbUORmQnwFUWURYXzyLuU9LkSZNAOYuGXmY
 8x2C1ZLIv3HBxNdkLsK8kpYEkbi6oNVzDLi0omq+dL/eeC2HQnAHrg5NB0WvZTwnU2r8
 1ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752012792; x=1752617592;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+kbUNrPjCxqJMdGOcYTq49UvPqoFqRW4yRvrM7RsdxQ=;
 b=nCoIdebzsnv2ORZGTLFCPspz95T7AjOFW3x+frhSiOPlyOrlh3B8r5M2x0MJYNZNmD
 nqueiGUd53AMv+AOLhjKxZER01lcih0rucfG+6ZotQhDG7rJ0JRGclSheIXNVScYG6ZY
 rFzysbSPOyM9xlLezUU9qpcy67kVZo4bVuMxv0HGQCdZrF4JMEWogR7SedfjTkye/zjh
 0iraDvTqp7ik9EQoElL/AmgqhAjdeXqCZY8ctYHcTX/9hSfSv1ABssx+4kFBgYoRI6Pr
 Hw0N0TihTGOmTrkYR0vq1rmvpFr40OoXowETOj7RSz2rYzzpdN/kQRqIN/s02u3UEf6g
 nxpA==
X-Gm-Message-State: AOJu0Yy65/RslPlSL+y/E63yPGVmtE7quSax2kxHc8jyfYkyYQV+MSX5
 v8fVdKi8cf3lDwb9FATRs2wwbgQvSj0CvbkpEXKkTrDMLvGEyy/WdJg7sNKjRxtkLPvgVF2sfhN
 sWibv
X-Gm-Gg: ASbGnctzYzRpd2bI3eiAcQ3KqDnlEnB4BhYZi39kYniOm4ALPCDR6BjRtGPfo2gMX5T
 YBs9T/Ca6xb0cbS6W5VtnKlu+idfMQR7H2kgfRge3nRMQNKak+fr78zYDCu42HsChSBR919D8Gp
 Sm1o6ixuKK0HKGThJZb7tjurFo+bHAq9Ehv6X+vVd2ffZetIycm0bhGMfOezG/Mok4VoOrN5nRY
 y8e2+yNBHhqUgnCn9clvbtFGQDf7H/X/gI3B0Ob0PanN/ngmiMsvkyRkVj8MNnCzWyGula9tVAh
 8zieiWcTh2fATJ9uH2tDHycBjCM6VrodRGa9j5TIvA4ywyPkh3jNl8b1MEZOIu73k5DGBxePgKf
 G6v4KwxW6A6pqsqu/qELguWrHZ5osNwp2
X-Google-Smtp-Source: AGHT+IFGiqwIs56ZAhE27Y5U1Nv0hRYcCpdysNZDEfPzjh6bN8zkva6qm0uF/n6ONNw+W85FM22yqA==
X-Received: by 2002:a05:6000:210a:b0:3a4:d53d:be20 with SMTP id
 ffacd0b85a97d-3b5e2fec82fmr800201f8f.18.1752012791810; 
 Tue, 08 Jul 2025 15:13:11 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50ded8csm937445e9.20.2025.07.08.15.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 15:13:11 -0700 (PDT)
Message-ID: <9df05684-af4a-4317-90d3-660494c73fac@linaro.org>
Date: Wed, 9 Jul 2025 00:13:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] system/os-win32: Remove unnecessary
 'qemu/typedefs.h' include
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250708085859.7885-1-philmd@linaro.org>
 <20250708085859.7885-4-philmd@linaro.org>
 <37e9f347-f7ba-4ea6-93f8-879d8169012a@linaro.org>
Content-Language: en-US
In-Reply-To: <37e9f347-f7ba-4ea6-93f8-879d8169012a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 8/7/25 22:53, Philippe Mathieu-Daudé wrote:
> On 8/7/25 10:58, Philippe Mathieu-Daudé wrote:
>> Commit f5fd677ae7c ("win32/socket: introduce qemu_socket_select()
>> helper") included the "qemu/typedefs.h" header for the Error type,
>> but files including "system/os-win32.h" should already include
>> "qemu/osdep.h", and thus "qemu/typedefs.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/system/os-win32.h | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/include/system/os-win32.h b/include/system/os-win32.h
>> index 3aa6cee4c23..662cfabc5e7 100644
>> --- a/include/system/os-win32.h
>> +++ b/include/system/os-win32.h
>> @@ -29,7 +29,6 @@
>>   #include <winsock2.h>
>>   #include <windows.h>
>>   #include <ws2tcpip.h>
>> -#include "qemu/typedefs.h"
> 
> FTR, copying Peter's comment on v1:
> http://lore.kernel.org/qemu-devel/ 
> CAFEAcA9rcJHBaeAqCM1BszrhzkE4=gxJkx9h62BVhEz9hB7OMA@mail.gmail.com
> 
>  > This one's tricky -- osdep.h includes system/os-win32.h
>  > *before* it includes typedefs.h. If you want to remove this
>  > include I think you need to move the include of typedefs.h
>  > a bit further up in osdep.h (taking care that it's still
>  > wrapped in an "extern C").
>  >
>  > (Or we could declare the functions in os-win32.h which
>  > use the Error type somewhere else. That header I think is
>  > intended to be "Windows specifics and compatibility wrappers
>  > that everywhere needs to have sorted out", not "this
>  > function happens to only be needed on Windows": a lot
>  > of the functions declared in it are only used in a
>  > handful of files and don't need to be declared to every
>  > source file in the project. But that's a bit more effort.)

Amusingly qemu_socket_[un]select() are always called with Error=NULL.

