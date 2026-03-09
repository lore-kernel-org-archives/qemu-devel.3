Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B004FCA17B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzgAo-0004n9-Px; Mon, 09 Mar 2026 15:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzgAk-0004mm-6R
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 15:21:46 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzgAh-0003bQ-6l
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 15:21:44 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-829756f3ee9so4961475b3a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773084100; x=1773688900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V+zc7m8AXGS3NP8Uhy0CUA61wN9kBxJxnryrQblP2Qc=;
 b=uwz4dmFLRsUhuUV8gH30utLYyzhiiu5ziDc+CC27xL56gjdwSl0Jpb1OBeRUjMG0E3
 W7MVoYB/A1W9LD6BV1lrDdPp3DDoex5lzA1EIBUxwy9YNPrPH0VwVp+ZKODWmnSOUych
 4rHmsOrbVDZ1nMSbRX6TirG3if/TdObYDmon5gAOepccnvlGdGVAK8KN/C/PuPg7bjle
 WxNDNZlu3/ShZuj9M9MMzuDyhih25kDgrjSE8xatTtqoldf/F0L+WB85J7ow5Vb4PHC9
 5lzquxEnKHV2AeP/aO8Iyjdia/vhmJAGaklFM5bhUIJbslZgesP1Mw+tMKKOmjsycyb5
 cgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773084100; x=1773688900;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V+zc7m8AXGS3NP8Uhy0CUA61wN9kBxJxnryrQblP2Qc=;
 b=SPEtAGiG7PXedcRL4uuQQfeqP2ECVzd5gBiZrxPPII3cIiZArr7nAYbaJtR/aDfHJp
 nhyeTLntd410Bjs8RtkNAHREq9OnEzfukNAt9g22i6NDW3ffg986wK/mfKjlt5Vpc35u
 040vn0cVqyaXdj/W2lhajuA+vcXaZG37U2qqPCQL+gy86GZ69S8bFO+atFiAq7++J8P3
 L/MxzDux9Iti37BOYErrg/pEV0NWvZJiugZzoy1TdLEzMRgk5PmCzTL16OYC0OGeqqJ4
 JRq66rx5YKPU9fiJsl+ZxusT730zQqiqTwyC7j8sBakVIO7f7q6j18VUAz1txom4A6pU
 qCYw==
X-Gm-Message-State: AOJu0YyjyKlqppo3udQTtz454oR0zujVWBFVJB3Jc6bOGIoHaUIftcUk
 Y9DmlmsnWDlIeBNjc6zz7PaSNhQfMu10dpg1pcUERIT94ziRWTs5wB7YinB8t25W8CI=
X-Gm-Gg: ATEYQzwWiVqOEngfi4V1IstniKGPqdAQ0sMuG7iEtrH0bnFoVWX9598gB/S/js8GkGx
 bLZWASZCYBZEeDK8Pw6qKmY4S3Kd4zy7rvFby3D+yUKmpK9IvoZ+zqKKfeM8w1E8wZpEwUakolz
 R/m4JxFfrpAhqeTNBCBEL3wRxavwd8/4y10g+4MPnFART1F0WvjSgOG4zDrcex0sBkTA9oLERdj
 e3GNFz8LdN7Uozuo114NDQpo9WFHCWfY7hx77xlzfXgH/8poFfwBpUW0lVQdAlLAXZn4jgADtmW
 ENNPgkDKIkv5+3USLfsW9V5c6kpvskrFqJOyyk2YbHPkR35DL+dRoJ5HncqGyBVBz260YY7pnuX
 c7F0bEMNrCq6rI0eC7HuDHJbY0G06YxrkPgeIQY9xAivfXlKIq9ZkV6kCrTHnD57MeZS6kw5Vkv
 RsfBtdAMRGOcP02a8x0W/20S1lVXz+SLNIa0iPxl+pDJEkbRmCtCHcYgRjliKmqem6TddoHCw6Z
 G/aLoI=
X-Received: by 2002:a05:6a00:761a:b0:823:877:5519 with SMTP id
 d2e1a72fcca58-829a2ef7a2bmr7769502b3a.43.1773084100327; 
 Mon, 09 Mar 2026 12:21:40 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a48b437fsm10828383b3a.52.2026.03.09.12.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 12:21:39 -0700 (PDT)
Message-ID: <905957d4-4d5d-45d1-95e0-f7cdc6f75a97@linaro.org>
Date: Mon, 9 Mar 2026 12:21:39 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <c30ea720-5208-adea-c8a3-788c870fedee@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 3/9/26 11:50 AM, BALATON Zoltan wrote:
>> Every N months, you can run a manual "archive" command (i.e. move to another
>> INBOX subfolder) on messages older than N months and your qemu-devel INBOX
>> will keep a constant size.
> 
> Glad that it works for you but I have a limited mail quota so I have to
> delete read messages.
>

Let me update my suggestion with something that would work in your case.

Every N *weeks*, you can run a manual "delete" command on messages older 
than N weeks and your qemu-devel INBOX will keep a constant size under 
your quota.

The key is to not delete thread as soon as you receive them, but keep 
context for a few weeks, similar to keeping your git clone to a constant 
-depth=N because your disk space could be limited.

It's a win-win: you keep semantic context *and* your quota stays under 
control.

>>>>> Getting messages about patches being queued is useful for other
>>>>> maintainers and contributors to know the patches are picked up and then
>>>>> they will also see the pull request on the list and when the pull request
>>>>> got merged. Getting separate messages for each patch in a pull request
>>>>> does not add more info to that for people already following the list.
>>>>>
>>>>
>>>> Except that some maintainers, including me, don't cc original authors when
>>>> sending a PR (that's a deliberate decision). As well, some top maintainers
>>>> don't always send back a message once the PR is done. Or they don't
>>>> include
>>>> all authors on individual patches.
>>>
>>> I don't think that's a problem. If somebody is interested they could
>>> follow the list or filter it e.g. for their S-o-b or simliar to get those
>>> messages or pull requests even without being cc'd.
>>>
>>
>> In the case of TCG plugins, a lot of contributors are new comers and are not
>> used to all this. I personally don't want to put the pressure on them to
>> configure this kind of complicated setup, but prefer to offer them a
>> GitHub/GitLab like experience. The series is a PR/MR, and when it's merged,
>> the forge notify them it is.
>>
>> Sending email patches is already a pain in itself for newcomers, no need to
>> ask them to configure email filters on top of that.
> 
> But you have no problem putting that pressure on me :-). Yes I know it can
> be a pain for newcomers and did not say these messages can't be useful to
> them. But I can't follow your logic about sending these to the list. You
> say that they won't see if their patch were merged because they won't
> follow the list because it gets too many messages. So you need to cc them
> but you also send that to the list where they won't read it anyway so it
> just increases the volume of the list even more with messages that those
> on the list will just have to ignore. Wouldn't it be simpler to not send
> these messages to the list if those interested are already cc'd because
> they are not expected to read the list?
>

Answering below.

>>>> So for consistency and the series I personnally track, yes, I believe
>>>> there
>>>> is a value in notifiying original series and author.
>>>
>>> I'm OK with that, what I doubted is that it is useful to send this to the
>>> list too. Wouldn't it be enough to only send it to the people involved off
>>> list?
>>>
>>
>> It does not notify only original author, but other maintainers or reviewers
>> also. As a concrete example, I'm sure you already went through a thread where
>> someone was reviewing code already merged. With such notification, it would
>> not have happened.
> 
> I'm not sure about that. If they are not on cc they would miss this
> message on the list the same way they missed the pull request. If they are
> on cc they would see this message without it being sent to the list too.
>
>> If you started arguing about the message itself, it would be an interesting
>> debate. But your point is "My email workflow is A, and I don't like B, please
>> change B". So my polite answer is "Your email workflow is A, and you don't
>> like B, so change A". We can run in circles for hours I guess.
> 
> I'm arguing about if it's useful to send these messages to the list. My
> workflow is an example but just ignore that for now to avoid
> misunderstandings. If you say that you need to send these messages because
> those people won't follow the list then I think it's not useful to spam
> the list where nobody would read these messages just in case somebody
> might read them. I don't care if you send them off list or not and if
> others think that it's useful on the list I'm also OK with that but I
> don't see what this would add to the already sent pull requests and pull
> applied messages already sent to the list for those who follow the list.
> 

They might not be in pull request messages recipients, or didn't 
configure ad hoc filters for that, so they might have missed that.

As well, for people reading the thread afterward from lore.kernel.org, 
it confirms the series was merged and the topic is closed, without 
needing to check manually in git log, parse pull requests, or check on 
patchew status of series. You'll notice that I always send an update 
email when posting a new version to link to new version also, to "close" 
a given version, in a similar way. See it as an email ladder version -> 
version -> version -> notify_merged.

I didn't invent any of this but simply mimic what GitHub and GitLab (and 
other forges) do. They notify you on new versions, on final merge, and 
you're free to unsubscribe from a PR if you're not interested.

Once again, I totally respect you don't find it useful, feel free to 
delete and ignore those messages.

Regards,
Pierrick

