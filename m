Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E17E9D40F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnfrb-0002vP-6s; Wed, 04 Feb 2026 11:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnfrZ-0002us-Vf
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:36:21 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnfrY-0007zW-5t
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:36:21 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34f634dbfd6so5521157a91.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 08:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770222978; x=1770827778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=daGqxaOjyTMVyaGNtSXXqFpwiSEndExDyWYOjbs/MD0=;
 b=AVFeHwh3rmx4CaMrJYJOzEI8LqaPgo5fM2+bbJowtem2sRi3UyIreqIvCVXgenZYll
 RbB/WUJpAygn9VMLxNlT6m4kf3CT+vII0D6KsjJpoQbReLjKYGALGInENAXXiPJkmFXI
 ezFfdPB82GEYC5NZTYEO+llzzRjeqWwjUSig3Fp/tMkqBoSMY/iHRd76AIisNY4Z33Vt
 Qv9KavYE0/ujzGxUMpxsVNElpdFphDeM+VgmOW74URoDJSsaZFLUbWgEEoCcAAnRdhB8
 NleYOBh4sdsC4+fZjwIjzr8BzOkjyUp2kW+x3ECEHc1VzzLQ7e6eGj9pxzFYrrRaOxNU
 N9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770222978; x=1770827778;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=daGqxaOjyTMVyaGNtSXXqFpwiSEndExDyWYOjbs/MD0=;
 b=PZKCcoCsukZcRD7N0wmVy13Io8PCjq2wj2XPnQdsL2u1vQ8Ax8vjsX7gExkbicOrAu
 u2QBGJITkQqV+s/204uOL+pIXLXAPBCCfIs9PHDXd4XNvnhbCFBcldGq8Eo+9/2BqFkw
 Tne/gjHVCpYsC+YLbzVSWaNc4nhPXnFRqd/3scJV6rD/0EHsm9EjxCcmI8qkv2AtwRLP
 Oq9dKCylX4NXEj+7focsova9hXMCUlQjweSq9g92c+NXOJiWP0ZFgNii0Mnu6U3xQJsR
 XIW4HUwADwk7Cb55hJ5wRSYCKuOSVy4BCZeQ+qBVLKT11v603yyKrwrXBKN3g8S+6kwI
 boUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsNRABdfPL9bet9eK3m6f8kIGWGMztniYvkhF+5RMuuSZXb6LukzsqzLx/bDUEEM2L/NPCf7atxVjB@nongnu.org
X-Gm-Message-State: AOJu0YwX7FT+6tsbuSiAnjK4PyBqC8D2GEDBrmR5JbkmNQunBhTewAqm
 QgPsB6PzmlYYW0ct8PvGglBzjfr7ZtSiXi0WAkRWP+co4ymm5tzu8Vdxk0ipK188fJM=
X-Gm-Gg: AZuq6aI08dlnelUmYU5tM4O+SPBDazo3YETvZEGswaru6dKqHJN7nJ+VeZdQCQeGcvO
 cF7Ke9A3Xkte6rhRQ9sEnhIXoXx8oR9YzH1HejLmFyVDlZXNWys92wIiuCw7vo8bilIqQQ/eD9y
 4wtb+QH9dvuiowJCiyXRxf7y0TuBsGg8gq3/dT5GW8tfDqmg92e4SG0DKAy7arx4ttq5uCk4p9/
 oQ43dKxjS6TdJEQeHqcRHhMCzt2yu+PDvpMayPHU7mNPbs+8nELnASnrSGEIfqlbbI2emjP9Abw
 YObR9o1F0o6Jl1i6gaH/ztRHTdiswcHZhCJKOqivTiQ9YPEO8xNday24+/nop/b5JGXzG6LTlyL
 GNfHLuEmwsKXvu1YBBcrylySYKaRQnGSv3XnE0DznSQ2JGQ1iQrxZEjeJSWSd7lCjHdNKTyHToz
 3JShOYsfrhSGaNhn1pgZXxoFRmsFORv0H85csV0uVRO5oBI1cSYW00mNHp
X-Received: by 2002:a17:90b:4f87:b0:34c:99d6:175d with SMTP id
 98e67ed59e1d1-354870aadc4mr2987976a91.2.1770222978239; 
 Wed, 04 Feb 2026 08:36:18 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354862eedfasm2939932a91.11.2026.02.04.08.36.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 08:36:17 -0800 (PST)
Message-ID: <5fd0062c-b474-4971-9a46-06af9ae4e0c7@linaro.org>
Date: Wed, 4 Feb 2026 08:36:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target-info: set target_arch statically
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20260203194113.3026757-1-pierrick.bouvier@linaro.org>
 <7645fcac-c4b2-4a9f-91c8-4990e9c92ef9@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <7645fcac-c4b2-4a9f-91c8-4990e9c92ef9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 2/3/26 5:36 PM, Richard Henderson wrote:
> On 2/4/26 05:41, Pierrick Bouvier wrote:
>> target_arch() function will reparse target_name() every time if it was
>> not set to a proper SYS_EMU_TARGET_* value (when using
>> target-info-stub.c), which is not efficient.
>>
>> Since we want to preserve the constness of TargetInfo but C doesn't give
>> us flexible compile time expressions, we simply set target_arch using a
>> static constructor once instead.
> 
> A static constructor isn't static initialization.
> That said, we can do better with some extra help from meson; see attached.
> 
> I'm mildly annoyed with openrisc vs or1k.  We really ought to fix that, but I haven't
> looked into what API breakage we get from selecting one or the other.
> 

This was my first approach, and I noticed the or1k issue + missing 
hexagon in SYS_EMU_TARGET enum. Having a hack for target name in 
meson.build is *really* ugly IMHO.
At the moment, hexagon is only linux-user, so I thought it didn't make 
sense to add it to SYS_EMU_TARGET, and I didn't want to go down the 
rabbit hole to rename or extend this qapi definition, as the initial 
goal is just to define a field before main, which I consider to be 
static initialization, even though you might prefer to call it differently.

So with all that, having a function with constructor attribute seemed 
like being the best compromise between maintainability and efficiency.

I'll let you upstream whatever changes you prefer, and I drop this patch.

Regards,
Pierrick

