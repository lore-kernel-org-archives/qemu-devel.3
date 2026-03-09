Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDEAFCA16A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzevQ-0007gs-5k; Mon, 09 Mar 2026 14:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzev9-0007be-I9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:01:36 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzev3-0005YX-Ew
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:01:31 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-899ed41208fso161478226d6.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773079288; x=1773684088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wvJn6jkrgK6OxQ6S5XfePpR60P+qH7p8JnhfONVjLHg=;
 b=w9vOKI3/xajJ84FyTsIL/7sMW4qW0sgi2RJ7BNHZN2QtbhEhIKavT9KoeoqVdf6izl
 Ay6EYiQFdhz+0SJFC/QXfoM6sn/5xYP+C0A/2zO++q+uyrt4kMtOOX31UsIA9qaRmg7I
 +GXZ+fciEkhhJ5cz9YjhX+mxtF+ULkJmPx/YkH3SU5YdI/Xd7vErvNVOH5vBDBTr/z9T
 5PUtPAw1R7ChyIEivggBWHeU/6JkZ8jnOuAoAwhLTAW7rONrIev2i5lNhHP/OlQc8eIl
 5P6UJgb+Ey3/GdRkAagwCpKwFNGzkYSaIjkK7Kc0Afi4Wk4LKuWQ7f9h+6RwCZu9Jezg
 M1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773079288; x=1773684088;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wvJn6jkrgK6OxQ6S5XfePpR60P+qH7p8JnhfONVjLHg=;
 b=mxdHf2vj2NZrjRxkHj7SSrDbxo7u5i/6zmRCrvfLe43aoGt/5EtBseFlrswF3mrYxI
 k/N3BmqoO2yAmwluqVeTNVWu/lLlw7KOX3UEzrv1B/8QLP8ymr/5hyGmkQMT0FOYxh0Y
 4H8caxeFMHiAq9s+inxlAqjDfIP0q0w7WQVKZOt0AwWEm49GBw60vDTsknaaMdc+BikS
 bmzGnGS7uA5JfnHhjf9Hku+wP6YnDurvLemE67eax3H+O1oBzmLCKfm4VOqZHMF1EWH0
 JpJNT0Ubim6CFnAqXAE9G4fg9LePH9abVcQa5edHgcIRJbNp0dA5wa7lBNiB6ksvPhVK
 ZeWw==
X-Gm-Message-State: AOJu0YzzNvPSuQkesM1NBuT0k6LQe2msCVCShPhTP7PrlJSG/nqkZzhL
 ZRVt1jlYN0DrWK/lZhBRy4rcsXzlIjMBKiiETQB/cUzn3jygnRZ58ad/T6eP6/flzgo=
X-Gm-Gg: ATEYQzwmRumPxSz5S7ErYtunWX95wkXIcssb4oMx1oVbQyMKUwSd+KcnBBSKjjXPhHa
 v1pphnQNYlTOxME6JT2vaeMw4kOqGhkbVkFplvcxsFjB+k01/lexm97yGasvB/X2xi5gdxprwmZ
 I1qsVkc/uOqKJrsH7Tf27RfiuDDFUCRfUkoUateYbUZLvvr/ENiIdjk/xBFgkJYUUeo7Y5vDm0g
 CAnsb9UmvzjD+bOSjWRs1Pt1GZAgTcpedIRfEOipr7YiakCDre6Ru3undv5SZXFZ4qYWk+KmEZI
 IF1HJjf/91hU37ppdhaEtnk2kWpzk315FM7fnfQu0+AXnJAiQBOOnxXqTGqyultT9lLqg7+wgdN
 XKr/OZVObZvs/6kZX+QUbn9lYGK6INLTzKS4o0iHlq7xhE8GghrPSs28v0uYQPEG/yZT7z/yKZZ
 ctVgWRu991rpoqXNoKsqNTj8wwc9Y798yt7os6HiYdsyELAzxkhhH4O/dHmReD4kSz9e3Yd/+oS
 6AI12w=
X-Received: by 2002:a05:6214:1d2b:b0:899:f0b1:732a with SMTP id
 6a1803df08f44-89a30ad6ab4mr198424076d6.31.1773079286104; 
 Mon, 09 Mar 2026 11:01:26 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a57bf9e7asm3075176d6.31.2026.03.09.11.01.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 11:01:25 -0700 (PDT)
Message-ID: <cbc1b812-40f4-4b1e-b206-ed4962cb5dd9@linaro.org>
Date: Mon, 9 Mar 2026 11:01:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: ignore zero sized
 symbols
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260306051553.2778652-1-pierrick.bouvier@linaro.org>
 <f7e095e3-18f8-4c5e-8a39-ff428f984b07@linaro.org>
 <f9c9d581-294d-a813-2cfd-584fb57af743@eik.bme.hu>
 <0a0f0d55-24ed-4018-addf-dac2b7bcfe6e@linaro.org>
 <e5bef5ed-23e9-119d-3f63-a45343cc9c53@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <e5bef5ed-23e9-119d-3f63-a45343cc9c53@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf36.google.com
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

On 3/9/26 10:35 AM, BALATON Zoltan wrote:
> On Mon, 9 Mar 2026, Pierrick Bouvier wrote:
>> On 3/9/26 9:38 AM, BALATON Zoltan wrote:
>>> On Mon, 9 Mar 2026, Pierrick Bouvier wrote:
>>>> On 3/5/26 9:15 PM, Pierrick Bouvier wrote:
>>>>> When using llvm-addr2line in replacement of addr2line, it will output
>>>>> zero sized symbols, which can shadow other binaries depending on where
>>>>> there location is (happens with arm-trusted-firmware and its different
>>>>> binaries). Thus, those symbols.
>>>>>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>> ---
>>>>>     contrib/plugins/uftrace_symbols.py | 2 ++
>>>>>     1 file changed, 2 insertions(+)
>>>>>
>>>>
>>>> This was merged into master (a8ff516c2f5ec05fb8b8bf4bceb88f49701f80d6).
>>>
>>> I doubt the usefulness of such messages. People will know when pulling
>>> from git and this list already has high enough volume. If you think this
>>> is useful for contributors could you please send such mails off list only
>>> to involved parties?
>>
>>  From what I understand, since you were not directly CC on this series, your
>> problem is not especially with the message in itself, but with the fact that
>> "this list already has high enough volume". I personally don't suffer from
>> that, even though being CC on all patches touching docs/, because my email
>> workflow allows me to follow threads I have specific interest with, and
>> ignore the rest.
>>
>> In general, a mailing list is not something you are supposed to read
>> exhaustively. Instead, you're supposed to track your personal interests out
>> of it. For an analogy: When you go to your local supermarket, will you try to
>> follow every conversation happening there?
>>
>> If you feel it's too much for you, then maybe there is something to look into
>> how you track the mailing list, and my advice would be to use a threaded
>> view, with tags and mail filters to reduce the high volume you seem to
>> receive on a daily basis. If you're interested, I can share my (simple)
>> setup, and maybe you can get inspiration from it for your personal usage.
> 
> Threaded view does not help because the thread is already deleted when the
> separate "this patch was merged with commit hash" message arrives so it
> will show up at top level again. Ignoring everyting not cc'd to me would
> make me miss useful info about where the project goes or being able to
> review a few patches because I would not see them.
>

So, that's the issue, deleting existing threads breaks the context 
indeed. It's like working with git repositories at -depth 1 and trying 
to use 'git log' on a specific file.

Personally, I mark messages as read instead of deleting them and use 
"View -> Threads -> Threads with Unread". It has the added benefit that 
you can search efficiently through past conversations also.

Every N months, you can run a manual "archive" command (i.e. move to 
another INBOX subfolder) on messages older than N months and your 
qemu-devel INBOX will keep a constant size.

If you email client gets in the way, switch to another one.

>> To be honest, I was thinking to organize a small BoF on next KVM Forum to
>> allow people to share their personal tips with handling emails.
>> It seems to be a common issue, and some maintainers even missed some series
>> they were supposed to review, or to pull them. For myself as well, it took
>> quite some time before having a correct workflow. I even went through the
>> idea of "reading everything" and quickly dropped it as it was unbearable.
> 
> This also suggests maybe there's too much traffic on the list so it would
> be useful to think about how to reduce it. However maintainers are
> supposed to be cc'd on series they should care about so they should not
> miss them but maybe the problem here is more that there are a lot of areas
> without maintainers listed or those in the MAINTAINERS file don't respond
> even if cc'd. Just email workflow may not help with that.
>

That's true, some series fall through the cracks. That's why I applied 
to maintain docs/ to collect series/patches that might have been missed 
there. If you care about some specific subsystems, I encourage you to 
apply for becoming maintainer on the concerned top folder, so you can 
collect what is not by other maintainers.

>>> Getting messages about patches being queued is useful for other
>>> maintainers and contributors to know the patches are picked up and then
>>> they will also see the pull request on the list and when the pull request
>>> got merged. Getting separate messages for each patch in a pull request
>>> does not add more info to that for people already following the list.
>>>
>>
>> Except that some maintainers, including me, don't cc original authors when
>> sending a PR (that's a deliberate decision). As well, some top maintainers
>> don't always send back a message once the PR is done. Or they don't include
>> all authors on individual patches.
> 
> I don't think that's a problem. If somebody is interested they could
> follow the list or filter it e.g. for their S-o-b or simliar to get those
> messages or pull requests even without being cc'd.
>

In the case of TCG plugins, a lot of contributors are new comers and are 
not used to all this. I personally don't want to put the pressure on 
them to configure this kind of complicated setup, but prefer to offer 
them a GitHub/GitLab like experience. The series is a PR/MR, and when 
it's merged, the forge notify them it is.

Sending email patches is already a pain in itself for newcomers, no need 
to ask them to configure email filters on top of that.

>> So for consistency and the series I personnally track, yes, I believe there
>> is a value in notifiying original series and author.
> 
> I'm OK with that, what I doubted is that it is useful to send this to the
> list too. Wouldn't it be enough to only send it to the people involved off
> list?
>

It does not notify only original author, but other maintainers or 
reviewers also. As a concrete example, I'm sure you already went through 
a thread where someone was reviewing code already merged. With such 
notification, it would not have happened.

If you started arguing about the message itself, it would be an 
interesting debate. But your point is "My email workflow is A, and I 
don't like B, please change B". So my polite answer is "Your email 
workflow is A, and you don't like B, so change A". We can run in circles 
for hours I guess.

>> It's totally right for you to mention you don't like it, feel free to ignore
>> the message. However, I feel it's a bit beyond your rights to decide what
>> people can or can't send on mailing list when you are not in CC on the
>> concerned thread, don't you think?
> 
> And that's what I did. Mentioned that I don't like it and asked if this is
> really something others want or think it's useful to get these messages on
> the list or could it be done without increasing list traffic. How did you
> get the impression I told you not to send such messages at all? Just asked
> if it's really necessary for everybody on the list? The same way don't you
> think it's beyond your right to decide how I choose to read the list? I
> think this is a misunderstanding and I don't want to tell you what to do
> but wanted to discuss if there's a better way to do this and tell you my
> opinion. Don't know why you felt offended.
>

 > How did you get the impression I told you not to send such messages 
at all?
From: If you think this is useful for contributors could you please send 
such mails off list only to involved parties?

Reading it again, you are right, it can be seen as a polite suggestion, 
even though I read it as a mandatory request first.

I didn't feel offended, but felt like you were trying to control what 
someone can or can't send on mailing list, which is a big NO for me. I 
would react the same way on any other thread where I would read the same 
kind of message.
On the same note, I didn't try to control how you read the list, but to 
suggest a better workflow, because I sincerely think deleting threads 
and reading all new messages is not a good workflow.
It personally doesn't affect me, as long as you don't come to ask here 
how to reduce number of emails sent.

Regards,
Pierrick

