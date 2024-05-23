Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45A7C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 09:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA59U-0001en-NU; Thu, 23 May 2024 05:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sA59N-0001bH-Tx
 for qemu-devel@nongnu.org; Thu, 23 May 2024 05:54:17 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sA59L-0002ax-0P
 for qemu-devel@nongnu.org; Thu, 23 May 2024 05:54:16 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ba0cb1ea68so1925396a91.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716458053; x=1717062853;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qiRZ3jhmx0CfXGtxm7Pi5C54YsiHG8nEIR+rlFGlhXM=;
 b=2ZdhyuzXFByEpJlBG/W+2LtOuMeDNj7oiU4g1PKD1IRoBRjQfUzemq8Ai36pb6hQhZ
 2FImWn51bgBowuSnTi17JdF21+lqvQkCOtIef+yr1mQUnvuL/aFzbBmVBdIcY2CQ6MD4
 WSFFVFdZ/L9tJxZ6OzlukFChzNGBTTWCGxb8d4XRLdvDIyiQPIQm9k6IOA4Ysw8AjCOL
 yrOQhUNHFXGEFjyrvlWht270OI0CfYyso0jHZD3wpKNwzHkxX7dI8vNYkxnKSZ69oTN3
 /ZXNS3DO06Ngk9USHSZUq6VSBxv3SfSuT8YmPeEIJ6092QJI8qLgH/QKCfOZFJdtSJgy
 alEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716458053; x=1717062853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qiRZ3jhmx0CfXGtxm7Pi5C54YsiHG8nEIR+rlFGlhXM=;
 b=tjFG2uqsUAO/jqAEOvhSGBd6qFR4khazkqXF+lAAQZEMKI9IYATLVFXkZeD9199AFe
 7f7y3jwxPvrz/mhOZx8PRsunLqs5hmo20S8YcKh3LOD7RbXPCQSEDSPW9piYP7omWMQS
 PyiRIKLUR93+U9tpsb0D+u4h9xhY4JtZQeWNvJ4Vqdy/gIB670nJ15t6OwN74SFFse6C
 BK2dmDOigtFmd3vc8xmXrTyfK/jnq1KZ94UN6y+RfmtrTqfUbQNQ/cysCCIp5v2o+XyR
 l8zWhUmAKW425SNWnEHzApgpXBBQcJRpSjkyWttU/KVaDCzpiBsggP6lLhemPVSh8J+k
 nCzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzpXznLQIz88SZfHWkfzbRJ5pqTUkrw/of0/hE8ByZ4+WjNGkW1JL2E2hEbqGLMjrHbTj6/VJaLvsv/L2cnN+fl/DuqSk=
X-Gm-Message-State: AOJu0YxyeXewF6Avwgk3NwRwLtLBrhICr7wgd7WLyiXtHi+Jtv/xS796
 /hw4/Yx0HKXHk/NWAjVxmHhGNCd4L5dvgh6ii/hT3/mgBsZI829yx1j+B/d4kqs=
X-Google-Smtp-Source: AGHT+IGMSlTGsoTEZ4xLcwdMTAzyABYzA2Vzni4X3HKJTNtDoSjHmNodyn3o/H3WZoMoLWzfo6IhJg==
X-Received: by 2002:a17:90a:d706:b0:2ae:b8df:89e7 with SMTP id
 98e67ed59e1d1-2bd9f5a2611mr4454063a91.38.1716458053345; 
 Thu, 23 May 2024 02:54:13 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bdd9f0b3desm1210372a91.25.2024.05.23.02.54.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 02:54:12 -0700 (PDT)
Message-ID: <2aaec457-2ba8-466d-a30e-31d9ff36df30@daynix.com>
Date: Thu, 23 May 2024 18:54:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] qemu-keymap: Free xkb allocations
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20240522-xkb-v3-0-c429de860fa1@daynix.com>
 <20240522-xkb-v3-1-c429de860fa1@daynix.com>
 <CAFEAcA_Sm=j_Q-gP=gaAKpmaMwA1-rO+JLAijzzuuhQOEFyfXA@mail.gmail.com>
 <Zk3bXNAIGnhbEUnK@redhat.com>
 <CAFEAcA9xVf4iOGVKZjhu8YRrTXtgxD5CFvcthVr1sOrin1-vJw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA9xVf4iOGVKZjhu8YRrTXtgxD5CFvcthVr1sOrin1-vJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
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

On 2024/05/22 23:36, Peter Maydell wrote:
> On Wed, 22 May 2024 at 12:47, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Wed, May 22, 2024 at 12:35:23PM +0100, Peter Maydell wrote:
>>> On Wed, 22 May 2024 at 11:49, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> This fixes LeakSanitizer complaints with xkbcommon 1.6.0.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>   qemu-keymap.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/qemu-keymap.c b/qemu-keymap.c
>>>> index 8c80f7a4ed65..7a9f38cf9863 100644
>>>> --- a/qemu-keymap.c
>>>> +++ b/qemu-keymap.c
>>>> @@ -237,6 +237,9 @@ int main(int argc, char *argv[])
>>>>       xkb_state_unref(state);
>>>>       state = NULL;
>>>>
>>>> +    xkb_keymap_unref(map);
>>>> +    xkb_context_unref(ctx);
>>>> +
>>>>       /* add quirks */
>>>>       fprintf(outfile,
>>>>               "\n"
>>>
>>> This is surely a sanitizer bug. We're unconditionally about
>>> to exit() the program here, where everything is freed, so nothing
>>> is leaked.
>>
>> I'm not sure I'd call it a sanitizer bug, rather its expected behaviour
>> of sanitizers. Even if you're about to exit, its important to see info
>> about all memory that is not freed by that time, since it can reveal
>> leaks that were ongoing in the process that are valid things to fix.
>> To make the sanitizers usable you need to get rid of the noise. IOW,
>> either have to provide a file to supress reports of memory that is
>> expected to remain allocated, or have to free it despite being about
>> to exit.  Free'ing is the more maintainable strategy, as IME, supression
>> files get outdated over time.
> 
> I think if there's still a live variable pointing to the unfreed
> memory at point of exit the compiler/sanitizer should be able to
> deduce that that's not a real leak. And if you believe that these
> really are leaks then you also need to be fixing them on the early
> exit paths, like the one where we exit(1) if xkb_keymap_new_from_names()
> fails.
> 
> I don't object to this change, but I think that if the sanitizer
> complains about this kind of thing it's a bug, because it obscures
> real leaks.

The sanitizer can certainly be improved to keep the automatic variables 
alive when there is exit(), but I'm a bit sympathetic with the sanitizer.

Covering such a case requires the sanitizer to know that exit() 
terminates the process. Perhaps the sanitizer can look for 
__attribute__((noreturn)) and __builtin_unreachable(), but they may not 
be present and not reliable. I think it is a legitimate design decision 
not to try to deal with this kind of situation instead of partially 
handling it with attributes and builtin calls.

Regards,
Akihiko Odaki

