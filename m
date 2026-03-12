Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A95106ACCD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0kd1-0008J8-NQ; Thu, 12 Mar 2026 14:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0kd0-0008Ii-1a
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:19:22 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0kcy-0006Bv-Cy
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:19:21 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-358ed696623so616102a91.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 11:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773339559; x=1773944359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nP7/QqYasv+PeU8tVWkVR8pVTaHzqTPgBgC8uyyJCBU=;
 b=rk4xDP1fAy8ALvaS8A3trtOrhWXNrj+n3McBb59CnYTQ2RRRhBks3DViPpY+lc79Ds
 GYLs5FH2gPn18yi7/timgQpB3DD0klM6+u6Bp5yBGOv2Xeeed7HbENdsD6pPCxifnATN
 7yuR9RdM9JS2+foNu3XUhyWQ0M3vQgFHvxj79ueOj3tqh1FE9IHz30y2PuX+egGilXZo
 rVTweamLgJKHDyhIsoJX9hsnKSr5Gj49IpTJm5cTymujoU01GZaQNfWnkgwO7Ki8KP6M
 5No1xFSeAllwamnJ42j8XHa0bLsFP0pgSq56vzc00aSqMLdnazJQUQMhzwYAjc/jz9PW
 gAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773339559; x=1773944359;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nP7/QqYasv+PeU8tVWkVR8pVTaHzqTPgBgC8uyyJCBU=;
 b=pqUa49cICb0AxQTpl80YG3HlnbJPrfz7PAh4TZrgxNIm+dqwg9FWwl2mBdWzQLn0Pz
 0LcOGKAwAU/5eqi8ZR3rXfOZZKu9RyuE4VxHIPF4Zgm+QMQOVAa0Bn4DMHYJIjK8yBzp
 kg0PTB9Csdpme+NVlnUZ+ndy8u4C28zU5rAs1ULrFS+jmzkqOY0zB6Ghuw2djynGf2Zv
 +1hQ60a0vxe+zVJSMIO+p71Bqjvnjtzl0q4RWNsN1Lm3LHg8lYFeSk0vXyHKwwPve6d8
 RHq7bVHbvQEZe/B2upI/ucTP6fXF/kfrOiYmxTTKzoK88M0dZnAKyYEWfQRp2q/HgyZK
 XQAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbIqTyPAf9yEaQJoObuB4Ih5uil2Y/u9YWhLpOp+0q5aI1PVgIuwETwNt7xHMFqcjJCNkd3jgUt3Nr@nongnu.org
X-Gm-Message-State: AOJu0YwZtTjatdYOaMWrag/FkEnQ7FRfUbeVB6you/GHMNjxAss3uTH7
 nzjJlpqQQD+9ofHTbPIUJsuMzyWEUhQO/hxYdAS1zUPeaAc5KPBw6yFTlb3+RchcC4g=
X-Gm-Gg: ATEYQzyy20vNiSco/scy5I9nqtDN/I6+gOrQzZ05XdCBFxreKDLXeK8DgKwOwsS9wJM
 sW/TkeQuaKSZzK8qXIaFL+G4iRuVZz4OSaYPt5s7E1oYCtplYaQWzBHP1s5z4gW/AXAPbOW+sDw
 yZvMjHPifHvtcZDIlhW4489ytJh6DQwZiNktEKZWnPgE5Uw4VXlj97n38ya5pt3+fRf2Yog56dZ
 Igr9I3Adv4XIdZSSyryrDWWdTt+XciMAutRuvjTgFhhiNDOUgpSPo8qt9reo9ba4digpSDypTkr
 B71WfuiXJm350r9BVPBB3jpC/G8evdGZohvT0JQQNQaWWaDmJEWbbGSu9Y/Zem1nlgcrISMytaM
 g+RGGStXB0B0urqAuEbemqCJxf0XSsWqFZ2PiRtfsNOBY0cdVyKGGdAjnJhM/IPYzlolwCLq8VE
 Z8n3XW7+d7Du2kqvJQEkWI8rMWMdD1jYYKIYbjUK70PFr1rIMJ1YcNtG/ShiIYKw9+B/Q1
X-Received: by 2002:a17:90b:4cc4:b0:359:8f4b:6ed5 with SMTP id
 98e67ed59e1d1-35a21f04a7fmr501662a91.15.1773339558739; 
 Thu, 12 Mar 2026 11:19:18 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a03005f7fsm6143415a91.15.2026.03.12.11.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 11:19:17 -0700 (PDT)
Message-ID: <7d017a0d-7d6a-4eeb-a56d-c9b670ffa766@linaro.org>
Date: Thu, 12 Mar 2026 11:19:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins/api-system: Handle migrate_add_blocker() failure
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20260312121617.228654-1-vikingtc4@gmail.com>
 <4d7c6db3-0915-411d-ac1a-f26b5b38dc28@linaro.org>
 <CAFEAcA9m_0VCWzxFACJzHKw=WUQhmuXSEgHzfJs1a9NUzWm6SQ@mail.gmail.com>
 <3e8016a4-17cd-4d87-9210-2f67a2ab243d@linaro.org>
 <CAFEAcA_JVF49rphVFdQpBeY7O+nU3NKNqXPFgSNodx53JpfjWA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAFEAcA_JVF49rphVFdQpBeY7O+nU3NKNqXPFgSNodx53JpfjWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

On 3/12/26 11:15 AM, Peter Maydell wrote:
> On Thu, 12 Mar 2026 at 18:12, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 3/12/26 11:08 AM, Peter Maydell wrote:
>>> On Thu, 12 Mar 2026 at 18:02, Pierrick Bouvier
>>> <pierrick.bouvier@linaro.org> wrote:
>>>>
>>>> On 3/12/26 5:16 AM, Trieu Huynh wrote:
>>>>> migrate_add_blocker() can fail (e.g. if migration is already in
>>>>> progress), in which case it returns a negative value and populates
>>>>> its errp argument with the reason.
>>>>>
>>>>> The previous code ignored the return value, leaving state
>>>>> inconsistent on failure. Fix this by:
>>>>> - Passing a local Error ** so failure details can be reported.
>>>>> - Checking the return value; on failure, report the error, free the
>>>>>      migration_blocker Error object, and return NULL to the caller.
>>>>>
>>>>> Resolves: CID 1645470
>>>>>
>>>>> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
>>>>> ---
>>>>>     plugins/api-system.c | 8 +++++++-
>>>>>     1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>
>>>>
>>>> While the description makes sense, how would it happen in real world?
>>>>
>>>> Plugins usually will request time control on startup (so no migration is
>>>> happening). In all cases, plugin who want to control time will have no
>>>> other choice than abort.
>>>> Maybe we could simply assert that migrate_add_blocker succeeded in this
>>>> context.
>>>
>>> If the user starts QEMU with the --only-migratable option then
>>> all attempts to install migration-blockers will fail. In this
>>> case we need to report to the user that the thing they tried
>>> to do (use a time-control plugin and also migrate) isn't possible,
>>> i.e. exit cleanly with an error rather than falling over.
>>>
>>
>> Reporting errors is useful when there is a possibility to recover from
>> it, but in this case it seems like we can only stop when user try to
>> request time control, so I'm not sure we should return anything from
>> this function at all instead of crashing.
> 
> When the user does something that is misguided QEMU should (as an ideal)
> never crash -- a crash indicates a bug in QEMU. User mistakes should
> cause QEMU to produce (hopefully helpful) error messages.
> 
> If we want to say "there is no sensible way for the plugin to recover
> from this failure, we should just print the error message and exit QEMU"
> then that is what error_fatal is for.
>

So yes, error_fatal is that we would like here.
My point was not how to stop execution (error_fatal, assert, or any 
other means) but to avoid returning a NULL handle on this case.

> thanks
> -- PMM

Regards,
Pierrick

