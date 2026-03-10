Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BD9FCC9A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 00:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzl03-0002mp-Ab; Mon, 09 Mar 2026 20:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzkzv-0002mQ-MV
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 20:30:57 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzkzp-00018n-F5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 20:30:52 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-359a5d8b3f8so3931688a91.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 17:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773102647; x=1773707447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OvccXg6WJ6T5oukjb/AZ0sfxwkB3hi3UO+Fm3ac5E6k=;
 b=UXmxiYkfRZaFpB4LFOs4eYvwwkKVI1RE/RbtAS9iysiJlZToeCvo/fleYliddcfNVQ
 ybMnis6ibyURCpMOu1MmqkSVuSur/ybhbLYWataIdz8lz3nOR5QiRmSCvIdefa1HZdvm
 Jcu8wR9sZ8S8DtdbfWpmNnmAF/j1depP8LJ5aKZzc9Aqgfj5UKMaKaWFEwdhrRMabE7R
 j7OVdkn38kLDPL0wgMp0q9XQiM0yT6GCIWvtXltr0iH3GlHy+n5kB+u6GkY67LKr+5Iu
 /rEV87nb5yZufIV1ssyLVXWMcoXgsWDYlPoqW3GKbNrl1sfVJ8J/gxd5Q8KXO4LyPR5t
 pDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773102647; x=1773707447;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OvccXg6WJ6T5oukjb/AZ0sfxwkB3hi3UO+Fm3ac5E6k=;
 b=jCI2bJSqAqvHhka/qpVmVvknCfdNCmTz+PyXNha3X4hMYMxZhV5Ycz8T3o5tAV6f/W
 bExDLvaPhUDWYie1Hp5hV/+R/xXrlpLNOitHVba2SnrfvtMzSJHg+OWi2MtLCrb3fgaD
 2jJUzEBKu69QkJfrTaCeEXMVrYG21Zh1mfLwyNAXRonJmlEHqbFPhVkG3a2voZ3mpc9l
 PafrbeuuLO2NZB9j1F0aStgeEUsFPBSC8N4wgfXXDPZYPNI5D9An3E5bFze/LMwmc5xm
 5++Ie0boiAMXlmWtSHw0z8GGPiUcDMSZ9JAs2TYSRrO7QbeYZfHQYuKfsMXfAt+34hf0
 atyQ==
X-Gm-Message-State: AOJu0YzowP3kkS/5ZHP7diidGGHSfaZieOF27CtfXNPJlbhVN/mn2ghC
 JhIb9DuSLsimNWHlvAC8Q6s3Io4kgtKbYTtq/lIxlzxGlWuGNafG0b0cSDmzd+xTE4k=
X-Gm-Gg: ATEYQzymRWopbDtU6IQDkokZIXRxtUlrJGMu9Nz6eiwJ4oevVZavByG4DvYlSL72saG
 R2cKAYP94wZITm57ZpPJDRa6M/B4mMnqk2AZllCq2un1oHWW+DSIBfVfmeOGhj4LTsbvMo4/SYM
 CtSc/gJreF//9++edZPw5EvigiW9pGH0XbwDOj62KJOdkReEoFeouKUh/jcxpgqoDEbDGyEaYTF
 2OmAJPZnCx1vRyKU6VukMqCGAnu1yBmcQHFQS9LEHci2xiSppATQnA/nJEkW5wxgArlzTst4tE5
 fKg8It6O+TTEXbl0h3vl/KBO1/0ZLN3uSybuXN5LRPVPzwt98kwQpCYv7HOjw4UV19+98a0Urp7
 F63Js+yM1d6zDEG/9ckrGwjwY+7Akrb1c3WIDD8/q2puKpyR0Xbyy/6MggIzOfBYPXcMwNdX5wK
 A0EF5nEZPQEA/h9DNLOtgdt5KFJG8NRj1MMQ2LAXRBFvUFeHl8/bURiEUv9AkZl7Q+0ght
X-Received: by 2002:a17:903:3bac:b0:2ae:8081:c5a0 with SMTP id
 d9443c01a7336-2ae8245e0afmr140386355ad.39.1773102647207; 
 Mon, 09 Mar 2026 17:30:47 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae83f8baa3sm139239575ad.65.2026.03.09.17.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 17:30:46 -0700 (PDT)
Message-ID: <62d96ae5-0b15-4de4-90f8-fb7f6a93afeb@linaro.org>
Date: Mon, 9 Mar 2026 17:30:45 -0700
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
 <cbc1b812-40f4-4b1e-b206-ed4962cb5dd9@linaro.org>
 <c30ea720-5208-adea-c8a3-788c870fedee@eik.bme.hu>
 <905957d4-4d5d-45d1-95e0-f7cdc6f75a97@linaro.org>
 <f2690dc7-ef35-3ab4-0f4a-dbe139b48670@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <f2690dc7-ef35-3ab4-0f4a-dbe139b48670@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

On 3/9/26 4:44 PM, BALATON Zoltan wrote:
> On Mon, 9 Mar 2026, Pierrick Bouvier wrote:
>> On 3/9/26 11:50 AM, BALATON Zoltan wrote:
>>>> Every N months, you can run a manual "archive" command (i.e. move to
>>>> another
>>>> INBOX subfolder) on messages older than N months and your qemu-devel INBOX
>>>> will keep a constant size.
>>>
>>> Glad that it works for you but I have a limited mail quota so I have to
>>> delete read messages.
>>>
>>
>> Let me update my suggestion with something that would work in your case.
>>
>> Every N *weeks*, you can run a manual "delete" command on messages older than
>> N weeks and your qemu-devel INBOX will keep a constant size under your quota.
>>
>> The key is to not delete thread as soon as you receive them, but keep context
>> for a few weeks, similar to keeping your git clone to a constant -depth=N
>> because your disk space could be limited.
>>
>> It's a win-win: you keep semantic context *and* your quota stays under
>> control.
> 
> You complained why I want to tell you what you should do but you keep
> telling me what should I do instead. I say again, please let me decide how
> I read the list. I'm fine with the way I do it now. I don't want to keep
> context for months or weeks (there are tools like patchew or list archives
> for that already where I can look it up if needed) so I only keep locally
> what I need in the short term. This is fine as long as the related
> messages come threaded at once but with these mails it would come some
> indefinite time after the pull request and I'd end up with as many
> separate mails as many patches were in a pull request. That can be many
> and the only way to thread them would be to keep at least the covers of
> all pull requests for who knows how long.
>

I simply suggested a solution for the problem you had, and you are 
totally free to take it or leave it. It's not a "you should", but a "if 
you want, you could".
Now, if you leave it and want to read the mailing list in your own way, 
feel free to do it, but you're on your own to find a solution for issues 
that are related to it.

I'm politely repeating that asking anyone to not send a specific message 
on a public mailing list because it breaks your personal workflow is not 
a realistic demand, you need to find on your side a way to ignore the 
content you don't want to see. That's how a shared space work.

>>> I'm arguing about if it's useful to send these messages to the list. My
>>> workflow is an example but just ignore that for now to avoid
>>> misunderstandings. If you say that you need to send these messages because
>>> those people won't follow the list then I think it's not useful to spam
>>> the list where nobody would read these messages just in case somebody
>>> might read them. I don't care if you send them off list or not and if
>>> others think that it's useful on the list I'm also OK with that but I
>>> don't see what this would add to the already sent pull requests and pull
>>> applied messages already sent to the list for those who follow the list.
>>>
>>
>> They might not be in pull request messages recipients, or didn't configure ad
>> hoc filters for that, so they might have missed that.
>>
>> As well, for people reading the thread afterward from lore.kernel.org, it
>> confirms the series was merged and the topic is closed, without needing to
>> check manually in git log, parse pull requests, or check on patchew status of
>> series. You'll notice that I always send an update email when posting a new
>> version to link to new version also, to "close" a given version, in a similar
>> way. See it as an email ladder version -> version -> version ->
>> notify_merged.
> 
> OK at least this gives a reason why sending to the list might be useful
> for some to track a pull later on lore.kernel.org. There are already other
> similar systems but some may prefer this.
> 
>> I didn't invent any of this but simply mimic what GitHub and GitLab (and
> 
> But you started doing it on the QEMU list. Some other maintainers cc
> patches in pull requests also to authors, some others don't and you
> introduced yet another solution. So you kind of invented it here as we did
> without it for quite a while and nobody complained. That does not mean
> this can't be useful for some but could you at least consider doing it in
> a way that works for everybody?
>

In this case, feel free to start a topic and forbid this "officially" 
for everyone, including maintainers that sometimes report that code was 
merged, or that they pulled it in their own tree, as it's the same kind 
of semantic message. I would be very happy to obey to any new rule of 
conduct that would be added for the whole community.

>> other forges) do. They notify you on new versions, on final merge, and you're
>> free to unsubscribe from a PR if you're not interested.
> 
> That's exactly the issue. With those forges I could subscribe or
> unsubscribe to/from these but here you decided I should be subscribed and
> left not much way to unsibscribe.
>

There is a way to do it, by keeping threads context in your mailbox.
If you don't want, your need to invent another ad-hoc solution.

>> Once again, I totally respect you don't find it useful, feel free to delete
>> and ignore those messages.
> 
> Could you at least make it easy to filter and delete them? Like sending
> them with a cover letter threaded at once or adding [MERGED] to the
> subject or something similar so they are easily filtered and not just tell
> me to deal with it if I don't like it?
>

The message body will always be the same, as I use a template in my 
email client.
```
This was merged into master (.*).
Thank you for your contribution!

Regards,
Pierrick
```

Second line is optional because I don't thank myself when sending my own 
series.

So a simple email filter could be:
from: pierrick.bouvier@linaro.org
contains: 'This was merged into master (.*)'

Does that sound good to you?

> Regards,
> BALATON Zoltan

Regards,
Pierrick

