Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDBDFD4F08
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 17:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w01G1-0001jP-QC; Tue, 10 Mar 2026 13:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w01Fp-0001jA-5c
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 13:52:25 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w01Fm-0004IE-T2
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 13:52:24 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-359832fc558so7812147a91.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773165141; x=1773769941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EWvQjJ/GJtZVkCpg+NyxdaGUgScDcuaDg9DXgoFoL2s=;
 b=yIhxUlIQV52UgggFA+ZVVMvwFHZKUwHOrdknIlL/fvTqXacti6fDBaUA1i3O3Z1PW2
 m2ed8I32FJhdiDnO6EnRvlLVFH3nacxfT//vPDgmnIyj3zw5f23ZwZoOppLwPZKhgWgB
 miCGD/Tn5+YZyGoRmtCuBOIoNdMjNlmSOLUEYdEaiHdx48d3cGu4KMZITHuJGqaKM88j
 3vmf2VLtlLnHJRKGdTFxRog8ipX8p/jC2tHQ/HToxnJLmsa9LO7otIGrMgNsGsXslAf1
 RLexB7NGAZ3nrlMzy2nrk2WXZzrdL1w5VqcWneqvMYPpbtpW8y1VSyzA+IsvRtslJxeN
 AKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773165141; x=1773769941;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EWvQjJ/GJtZVkCpg+NyxdaGUgScDcuaDg9DXgoFoL2s=;
 b=QuvKi7VRa5c+FIgQzodq2z8n3SW6Z+3O9dI2u7Kar+jM8GNOL+wm2K7xKMavl7xmYJ
 9RQJPaRg4kndu3A/ueTOuBDz6lZiGBRL4yLJr699M74Qx5u/ARryX5c3+au/lWvp2KnA
 nKF9nb6ZIU7hMEaf1k9/MrbtVQVVXFob7tKXJMERickHhqfhIEmnx3M8gsYkJPOiFiH7
 9YeGbjFCgNgzeH+30JRfKj5Um+ocYh6nDtdPX5GINVj3qw2lMy0KtahOyR5FB7EEXFQM
 noJdNP8be68rMK1Z+XKkE1dcHK2Ekzqk5oVncutZK4TIjGnAt23IdLG2Fne2F8hwsZd9
 wLgg==
X-Gm-Message-State: AOJu0YxheH9a/+HPnUxNPdEezY+KbdyB3qjP6jq5g/OPwEkU7pfRl9q7
 OuIir/8G4RRSyJbsKj59MAsrsUMRWSPd7XEOEx0zTzo9zC2oIZafrXajfKwvxcDEeRc=
X-Gm-Gg: ATEYQzyc5w8l7SqOFVaq+BKrfS5F7DAnOn+imY9Pdqlr2ECRXJKR92F12I5IA5tA8i0
 QQ/oWMyv6lkwLf6Omkh7kfebiQoyiGOa8VfWLWbGVk+Xx8nLfK6vmPTycrRfK/vUFtwJ+y1jbzS
 eDiJTr757Z0OeNfDTtRW+izrfThoTMhyg0+2g4Io6ZscKsMQWRlxN/G9Ou/gVIUGVe4el+TDypL
 B67rY77O4b8S9ZwhJlJpKK6W0Y5GF7StEg2iU539oeA5dav1uGu4VXUbq5cMifkHAbt8EIpqf81
 4qwIyqLQ106A/ZxS6HVJVfo/cpqf+MT6yAG38lWX6jG7bWXKp2KyFJNEJTK+5V1teQIk+GUQiAe
 t4mfqsy7yxCiV0sUA5kuPRbNKHW8i72XAEUw9ygRcUQhAuyRuyQ2WT5FClDV6iBm3l74X8t1qo3
 JqFgtlbcuYljLExAxFDtw1h0OBKeCywDqwYxsLvCbIs99zwA1wc4H9jpS+ZuXJwo1lLw1V
X-Received: by 2002:a17:90b:2d85:b0:359:7ae5:89e7 with SMTP id
 98e67ed59e1d1-359be2331b5mr12653797a91.4.1773165140500; 
 Tue, 10 Mar 2026 10:52:20 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a00416674sm5012a91.2.2026.03.10.10.52.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 10:52:19 -0700 (PDT)
Message-ID: <a2af11df-42a8-44eb-9e07-27f40b7aef92@linaro.org>
Date: Tue, 10 Mar 2026 10:52:19 -0700
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
 <62d96ae5-0b15-4de4-90f8-fb7f6a93afeb@linaro.org>
 <f10e3c8e-b1a6-215b-812d-4c4eb8e6c0c1@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <f10e3c8e-b1a6-215b-812d-4c4eb8e6c0c1@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 3/10/26 5:44 AM, BALATON Zoltan wrote:
>>> Could you at least make it easy to filter and delete them? Like sending
>>> them with a cover letter threaded at once or adding [MERGED] to the
>>> subject or something similar so they are easily filtered and not just tell
>>> me to deal with it if I don't like it?
>>>
>>
>> The message body will always be the same, as I use a template in my email
>> client.
>> ```
>> This was merged into master (.*).
>> Thank you for your contribution!
>>
>> Regards,
>> Pierrick
>> ```
>>
>> Second line is optional because I don't thank myself when sending my own
>> series.
>>
>> So a simple email filter could be:
>> from: pierrick.bouvier@linaro.org
>> contains: 'This was merged into master (.*)'
>>
>> Does that sound good to you?
> 
> That helps as long as you're the only one sending these otherwise "from"
> is not the same. It would be even better it you could also change the
> label in the subject to [MERGED] as it's easier to filter by headers
> (faster than content search) and that may also help more easily tracking
> the lifecycle later so you'd see [PATCH vXX] -> [PULL] -> [MERGED}. Or add
> some header specific to these messages.
>

Unfortunately I can't do this with template, that only can have a fixed 
subject, and not reuse existing subject + a prefix.
If I use a manual process, I'm pretty sure I will get it wrong at some 
point, so I prefer not to promise something that will end up being 
inconsistent.

> Regards,
> BALATON Zoltan

Regards,
Pierrick

