Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9D1C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 12:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rne6N-0006CD-N5; Fri, 22 Mar 2024 08:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rne6G-0006AI-N1
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:34:22 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rne68-0008TM-Tr
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:34:20 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-dcbf82cdf05so1911853276.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 05:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711110851; x=1711715651;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IXK1I2DOGbszVnPV4RVDpZi4PB7H1sYF7WyEtDJ3HAE=;
 b=OlcSlVx1itQxq+kSljz/Laz6ERykcmsAjs0ObW4THppvG3SU5kbR693e8QoW25816q
 qAeeRBTlGfY5Y6Vkde+ujRa4EwDjQl9wnrYMAny+KAU2sk+5w+2PQv7XlppT4U4PE9XW
 CK3OsGi38WSNRrEuwf91XidQW8gPepjX4JXVqkJzpsDpg3bSZnthArDLecDXNO3LK5EH
 iEFoC+nyjwoTznW0pkb6SZ+Ud9Cv9IzLx6IEB99ZGG+k580sUs4fv18puCgaEr0W6flu
 eq72wdEemnlfw0T6aw5TuBTcD6pjeTe9YkX7MUJ2iEMkN9IDfqfsF/InwSLFPTZymTlG
 iVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711110851; x=1711715651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IXK1I2DOGbszVnPV4RVDpZi4PB7H1sYF7WyEtDJ3HAE=;
 b=OMPvNxvUnkcb7pGYVS0xA/TrbX5BFyGOANhYD0FChPxvUqU85Byol4VM7Dg5ijEkyH
 6xhfdz6iq6EqT0hMHuccLLGh0NTpY+Ier/lOrd9VJkqv6fbaWavA9GvP2xxfG6TbHgFS
 wun3UjTUP8g1qoD2ck0pjObRTh9c7I0KUJMjjmSGa5JX46AkAtwaPp9dqUdz4q4/msU1
 npNESX7FXQ/uRmPOobIu6WMihysDxH8LVksmCJUPWAnHe3B9jYlteNbDKNohTUnsiKu2
 h3Yu9eWSfsucP+Ft5KLnGnCm5UXcf15t5jdBT0loT1e83aS8zNx2s6he1ns2819GP7Fp
 IuZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyDAoRM2FgJeyc1R6BHwcnAA7mGxqqq8WzoQVya/ciTD2IMBWS/tVbVphNUll9m8P9kGO6ByYGnYiOGf0Mw0eKEkdMHv4=
X-Gm-Message-State: AOJu0YyWM/fm5qgSms2sxhN1IQynZsg0v5m+nowUDDJ44lAXxW27vpZl
 DffbQzjpt82q+8AYEgSlQaqTKvO84ur6q8vi9NXdGO9j6BYLhtwe7X9KBOWdwrjljL7wTPln4Qz
 u7hQ=
X-Google-Smtp-Source: AGHT+IGaeILVfkBEZnMY0N2cFgqvKwII5CZ9rK0mQbvl15LuIhvU8aaDT92qDX/18aBHTTsnSCiKgA==
X-Received: by 2002:a05:6a20:a125:b0:1a3:638f:4fbe with SMTP id
 q37-20020a056a20a12500b001a3638f4fbemr2949995pzk.42.1711110352120; 
 Fri, 22 Mar 2024 05:25:52 -0700 (PDT)
Received: from [157.82.200.213] ([157.82.200.213])
 by smtp.gmail.com with ESMTPSA id
 b5-20020aa78705000000b006e73d1c0c0esm1523550pfo.154.2024.03.22.05.25.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 05:25:51 -0700 (PDT)
Message-ID: <805177eb-7cd4-463c-9d01-c955d6b91cf8@daynix.com>
Date: Fri, 22 Mar 2024 21:25:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ui/cocoa: Fix aspect ratio
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20240318-fixes-v1-0-34f1a849b0d9@daynix.com>
 <20240318-fixes-v1-1-34f1a849b0d9@daynix.com>
 <CAFEAcA80J1zDs1odrHmJGm0sjcg1O_rS0N3su4Gvq+NNLpaUXQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA80J1zDs1odrHmJGm0sjcg1O_rS0N3su4Gvq+NNLpaUXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/03/22 21:22, Peter Maydell wrote:
> On Mon, 18 Mar 2024 at 07:53, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> [NSWindow setContentAspectRatio:] does not trigger window resize itself,
>> so the wrong aspect ratio will persist if nothing resizes the window.
>> Call [NSWindow setContentSize:] in such a case.
>>
>> Fixes: 91aa508d0274 ("ui/cocoa: Let the platform toggle fullscreen")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   ui/cocoa.m | 23 ++++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>> index fa879d7dcd4b..d6a5b462f78b 100644
>> --- a/ui/cocoa.m
>> +++ b/ui/cocoa.m
>> @@ -508,6 +508,25 @@ - (void) drawRect:(NSRect) rect
>>       }
>>   }
>>
>> +- (NSSize)fixAspectRatio:(NSSize)original
>> +{
>> +    NSSize scaled;
>> +    NSSize fixed;
>> +
>> +    scaled.width = screen.width * original.height;
>> +    scaled.height = screen.height * original.width;
>> +
>> +    if (scaled.width < scaled.height) {
> 
> Is this a standard algorithm for scaling with a fixed
> aspect ratio? It looks rather weird to be comparing
> a width against a height here, and to be multiplying a
> width by a height.

Not sure if it's a standard, but it's an algorithm with least error I 
came up with.

Regards,
Akihiko Odaki

> 
>> +        fixed.width = scaled.width / screen.height;
>> +        fixed.height = original.height;
>> +    } else {
>> +        fixed.width = original.width;
>> +        fixed.height = scaled.height / screen.width;
>> +    }
>> +
>> +    return fixed;
>> +}
>> +
> 
> thanks
> -- PMM

