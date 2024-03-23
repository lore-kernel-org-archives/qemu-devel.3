Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40EFC54E58
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 06:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnusi-0001Cg-E2; Sat, 23 Mar 2024 02:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rnusf-0001BO-VJ
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 02:29:26 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rnusd-0000yV-Ta
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 02:29:25 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so1363761b3a.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 23:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711175361; x=1711780161;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JDPrjmfd0maarg1eC/XO8MWaaIvrB1qm42Rf8MCKVFY=;
 b=J4UO8oi8gl1VylHQk0KHy6T5/YLaRw24ibkMr5fLKdn6NgFQka4SNGTLCqmrmJcrEr
 tm8OeZICp0m94y/DsAlUSu8Bs8cdusJ8m/Kus98BXvVK+FcxnYsW4iapo3UebQzo4W9O
 v8owfNylJzzmeRJydVJ2OSf7CJUgOVo+/BSHWVfRaRPfsH4bI9OaswO/dRQUUlkd7Ijt
 Y0LtIm+2LphTKecVqSIKJQOfotOR9c8iwRe55A8ILI6hcAJnncVeE/Bvxbcw2oqvpBP8
 I6ZdQa7mnAcrt0/SH6PBSRAF+qssVIGtGuZ7cS21ZuoCzd8lM15FoHpbILB7ofV/zXTS
 Li/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711175361; x=1711780161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JDPrjmfd0maarg1eC/XO8MWaaIvrB1qm42Rf8MCKVFY=;
 b=rlqKSzbzyirKhykw9zb4TjleJngZILn4e4fhRP/vUtstv562AzH/9o4JrCHhar1pru
 UrF+b14rM0DkyC5QSiBQE2UgyDtb/awDNzIXOORx+mjLO/rZBPk3xiip5UJcjIvT82Qi
 p3yd9DmuBgyNkwH2p7ZPHWNmhaBvy3Pr8hfexWiQI7zG/OJq22WjnAZyQ9TfHdokK145
 cIZ75SUHBcC16XMLYAFlnZ2tIrc/C0lMk2KJIz+l+ZBtKVHQs5Uqf9uAIKCe2cnoQS84
 BBH2kFFvbLhF2CsPzbNh72am+LQfy96TJiyo0ONgdX9ZYBGfmbOE0bZ+2P+bzJHtmPXj
 bLsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ600ZUURXK/jQUK9l1g9XJsWuCvxqpKOK69UHLEo4T9ue/BufgcECNUBSbhxhCikyrYEitmEdsmwlJoHexUVy1BSFOaw=
X-Gm-Message-State: AOJu0Yy30WnG+QEHsvqZrtqjr6rclk0qqDstKoDl87KKpgBxzGY1xTuR
 1mdRxHHMcPF1VjeejuIJV2Yu+w5OgdSE8M3B1gApVoL3Md5gEmKozjMpMBjRegc=
X-Google-Smtp-Source: AGHT+IFYQfBRu+OUGeGvlzyGl6fygjy7rnjzV02kRSD4BdwlXvYqWoCDAF3XDYBB9D5luA8CheJmzQ==
X-Received: by 2002:a05:6a00:801:b0:6e6:f9b6:4b1a with SMTP id
 m1-20020a056a00080100b006e6f9b64b1amr2124756pfk.11.1711175361101; 
 Fri, 22 Mar 2024 23:29:21 -0700 (PDT)
Received: from [157.82.200.213] ([157.82.200.213])
 by smtp.gmail.com with ESMTPSA id
 b68-20020a62cf47000000b006e635740126sm802167pfg.112.2024.03.22.23.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 23:29:20 -0700 (PDT)
Message-ID: <5f907e47-9275-4df1-b247-a95e5008bf28@daynix.com>
Date: Sat, 23 Mar 2024 15:29:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ui/cocoa: Fix aspect ratio
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20240318-fixes-v1-0-34f1a849b0d9@daynix.com>
 <20240318-fixes-v1-1-34f1a849b0d9@daynix.com>
 <CAFEAcA80J1zDs1odrHmJGm0sjcg1O_rS0N3su4Gvq+NNLpaUXQ@mail.gmail.com>
 <805177eb-7cd4-463c-9d01-c955d6b91cf8@daynix.com>
 <CAFEAcA9YedzrYosLLa0PaqS72Bq6XjM8GBmUrQwmzD3tC-Ecjg@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA9YedzrYosLLa0PaqS72Bq6XjM8GBmUrQwmzD3tC-Ecjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
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

On 2024/03/22 21:55, Peter Maydell wrote:
> On Fri, 22 Mar 2024 at 12:25, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/03/22 21:22, Peter Maydell wrote:
>>> On Mon, 18 Mar 2024 at 07:53, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> [NSWindow setContentAspectRatio:] does not trigger window resize itself,
>>>> so the wrong aspect ratio will persist if nothing resizes the window.
>>>> Call [NSWindow setContentSize:] in such a case.
>>>>
>>>> Fixes: 91aa508d0274 ("ui/cocoa: Let the platform toggle fullscreen")
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    ui/cocoa.m | 23 ++++++++++++++++++++++-
>>>>    1 file changed, 22 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>>>> index fa879d7dcd4b..d6a5b462f78b 100644
>>>> --- a/ui/cocoa.m
>>>> +++ b/ui/cocoa.m
>>>> @@ -508,6 +508,25 @@ - (void) drawRect:(NSRect) rect
>>>>        }
>>>>    }
>>>>
>>>> +- (NSSize)fixAspectRatio:(NSSize)original
>>>> +{
>>>> +    NSSize scaled;
>>>> +    NSSize fixed;
>>>> +
>>>> +    scaled.width = screen.width * original.height;
>>>> +    scaled.height = screen.height * original.width;
>>>> +
>>>> +    if (scaled.width < scaled.height) {
>>>
>>> Is this a standard algorithm for scaling with a fixed
>>> aspect ratio? It looks rather weird to be comparing
>>> a width against a height here, and to be multiplying a
>>> width by a height.
>>
>> Not sure if it's a standard, but it's an algorithm with least error I
>> came up with.
> 
> OK. Maybe a comment would help (at least it helps me in thinking
> through the code :-))
> 
>   /*
>    * Here screen is our guest's output size, and original is the
>    * size of the largest possible area of the screen we can display on.
>    * We want to scale up (screen.width x screen.height) by either:
>    *   1) original.height / screen.height
>    *   2) original.width / screen.width
>    * With the first scale factor the scale will result in an output
>    * height of original.height (i.e. we will fill the whole height
>    * of the available screen space and have black bars left and right)
>    * and with the second scale factor the scaling will result in an
>    * output width of original.width (i.e. we fill the whole width of
>    * the available screen space and have black bars top and bottom).
>    * We need to pick whichever keeps the whole of the guest output
>    * on the screen, which is to say the smaller of the two scale factors.
>    * To avoid doing more division than strictly necessary, instead
>    * of directly comparing scale factors 1 and 2 we instead
>    * calculate and compare those two scale factors multiplied by
>    * (screen.height * screen.width).
>    */
> 
> Having written that out, it seems to me that the variable
> names here could more clearly reflect what they're doing
> (eg "screen" is not the size of the screen we're displaying
> on, "original" is not the old displayable area size but the
> new one we're trying to fit into, scaled doesn't actually
> contain a (width, height) that go together with each other,
> and it doesn't contain the actual scale factor we're going to
> be using either).

With v2, I added the comment and renamed original to max as it's the 
largest area we can display on as described in the comment.

screen and scaled are not renamed. Renaming screen is a bit out of scope 
of this patch as it's an existing variable. The variable is referenced 
from several places so a patch to rename it will be a bit large and not 
suited to include in a bug fix series. I couldn't just invent a good 
name for scaled.

Regards,
Akihiko Odaki

> 
>>>> +        fixed.width = scaled.width / screen.height;
>>>> +        fixed.height = original.height;
>>>> +    } else {
>>>> +        fixed.width = original.width;
>>>> +        fixed.height = scaled.height / screen.width;
>>>> +    }
>>>> +
>>>> +    return fixed;
>>>> +}
>>>> +
> 
> thanks
> -- PMM

