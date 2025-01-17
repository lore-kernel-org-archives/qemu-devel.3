Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26544C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYq5O-0001gp-Bl; Fri, 17 Jan 2025 12:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYq5J-0001Qw-V7
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:24:42 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYq5C-0006Cp-4Y
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:24:36 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3862d161947so1329112f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737134672; x=1737739472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0pLsAWDJOraFG88EG1SozRkXs1n2DWuvNRJ2Y9eAxkU=;
 b=bbTqKbRf9+UaEb8DlBlzCuL7xElcp9Lqo4sIIjmmyYaxuRnns9nMBjfVY5UBoQSWW3
 d0+i+nqkSrrOtrN2/kkUmFdtk2bthBvEH9VbXlEzdtTDgVAor0a2rG9UfVXe+j2RjEpI
 zjsjShEyXKhrrujFb6mJTVAzntcGya3vz0DNwE+D+lO5KIe3xIE7Fs+GbDAyqIOmsOnH
 3ca7CvcsAB+KKkufLRPvCNv1+qt+vRNjNZ68KeD9TT1EYRA/7v6WCfmfnewwDPKRDf0i
 5BEzqiC2glJtNFDpwH2ouxS0ZikSfXHRdJCyBeSCW50/IjJKb+NrAdosOGHefQ0k4dP3
 GD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737134672; x=1737739472;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0pLsAWDJOraFG88EG1SozRkXs1n2DWuvNRJ2Y9eAxkU=;
 b=S7U8TRkCL1I0TazQVl2B/byYGGtCt8NBy2DYfKOE3ElZAp9eKR1rQCImCSxczGMWhh
 rBiPTUFm4IEzWnNxDBvaREO74VmYVJrE+ZgjTtcoYvbYG6MuDo9tLdFMgAFvwIcpEuwY
 pRAfhXUeJ/gGeqEhTKRstpVqo6M/d33l0NXwRJWPC8LwW9NviW2qCLQxvrRm17hYfaTM
 GGhbZUvFUAXyT4LsTsJNFHD6FtMG9B4ZaYIyOmDQ0h21Fv67NPgZu7UK1B4nf4zjeyVI
 MYU3SEoUxbibf4LBHiFtg6yOyPetSDJXIXgtRbfLMpOT4GC9qjmd1Gn9UNcx1WUE9nSl
 I0wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnp0NabUK7oT09AhRqhIIy8CyY8EI4vMJRd5ZRlw4RCUwfTk/g5PKlldPAPBT2PMJZVPEaI5pNs2rD@nongnu.org
X-Gm-Message-State: AOJu0YxKAt8HXzAR/F14D1FlgtsrDO2LIAclvFrQNHklYoL1jgCWLkf6
 fw4XkqhvRZRaLAh6JtGzo8DDYFsXGLcAKeXPVmCYHTjpBhaPzohluxN91S0ZpDw=
X-Gm-Gg: ASbGncsfAwVYOZPj3Z+xsbyJvVkNILIxATTvyPSIUJe5OsNY/WusAWuA204tBIwC1EM
 mcagONNCJhfZu5hUiEe/fszJ/gz9Fr6L5m/BMoAerxlNa6EAbGoZl5PrKEHRgaO7zEHttQ9fnHl
 KCG8ywSQ6p+QrjGomP5iIM36JuqWzfHcvvFXHnM511jlEB01RE4BxbSsXIwizUSBAYapaklk3pS
 RXL1ze8g9oFmcM06a7MOPkT8AO+PTt3QJ148dZZ2eidC+gY9wv0FWnkHM+8nOaRWSAb9lh2M/cm
 sicLKoM8cBHEXw0t77iiWM5S
X-Google-Smtp-Source: AGHT+IHQ0mj2dJkGREvXcoi2iy1mKr9412P1DIpFc1kJYiyLrWvUlr+7zfrFSivENGmA/cI0T5Zd9A==
X-Received: by 2002:a05:6000:1548:b0:38b:e32a:10aa with SMTP id
 ffacd0b85a97d-38bf565521bmr3404553f8f.5.1737134672157; 
 Fri, 17 Jan 2025 09:24:32 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890420412sm41035045e9.18.2025.01.17.09.24.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 09:24:31 -0800 (PST)
Message-ID: <da1630f6-f25c-45ff-a69c-a2d9a5e0eeb6@linaro.org>
Date: Fri, 17 Jan 2025 18:24:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] hw/sd/sd: Allow for inverting polarities of
 presence and write-protect GPIOs
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-9-shentey@gmail.com>
 <342ca371-3e14-4108-9c45-e15cda51b9ca@linaro.org>
 <FBA535B4-8191-4CEB-905F-FA4C3416048C@gmail.com>
 <e202623e-eac7-4ed3-87fb-002491ddf745@linaro.org>
 <6AF83F55-5BFF-438D-AB05-5403D619B403@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6AF83F55-5BFF-438D-AB05-5403D619B403@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 17/1/25 00:20, Bernhard Beschow wrote:
> 
> 
> Am 12. Januar 2025 18:06:04 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> On 9/1/25 17:20, Bernhard Beschow wrote:
>>>
>>>
>>> Am 9. Januar 2025 11:40:10 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>>>> Hi Bernhard,
>>>>
>>>> On 8/1/25 10:25, Bernhard Beschow wrote:
>>>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>>>> ---
>>>>>     hw/sd/sd.c | 12 ++++++++----
>>>>>     1 file changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>>
>>>>> @@ -876,8 +878,8 @@ static void sd_reset(DeviceState *dev)
>>>>>         sd->cmd_line = true;
>>>>>         sd->multi_blk_cnt = 0;
>>>>>     -    qemu_set_irq(sd->readonly_cb, sd_get_readonly(sd));
>>>>> -    qemu_set_irq(sd->inserted_cb, sd_get_inserted(sd));
>>>>> +    qemu_set_irq(sd->readonly_cb, sd_get_readonly(sd) ^ sd->readonly_active_low);
>>>>
>>>> Please embed in sd_get_readonly(),
>>>>
>>>>> +    qemu_set_irq(sd->inserted_cb, sd_get_inserted(sd) ^ sd->inserted_active_low);
>>>>
>>>> and sd_get_inserted().
>>>
>>> Are you sure? I deliberately implemented it as is because embedding would change the internal logic of the device as well as SDCardClass::{get_inserted, get_readonly}.
>>
>> Yes, this is why I requested that change. Why don't you think it is correct?
> 
> I'm asking because I think that moving the xor inside the methods would break the device model.
> 
> The goal of the active_low attributes is to invert the polarity of the GPIOs only which allows to model boards where these are inverted. IOW they are intended to influence the wiring. That is in contrast to the two methods which determine the internal logic of the device model. They are also used as virtual method implementations of SDCardClass::{get_inserted, get_readonly} which determine the logic of the sd bus. Moving the xor inside inverts their return values if s->*_active_low are true, effectively flipping every if statement, which seems wrong to me. What do I miss?

Right... Then maybe we should model polarity in qemu_irq.

Patches 7 & 8 queued, thanks!

