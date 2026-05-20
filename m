Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978D5CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 14:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPhYE-0000e5-OW; Wed, 20 May 2026 10:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPhYA-0000dj-EJ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:05:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPhY8-0000OD-5a
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:05:29 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso37011165e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 07:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779285926; x=1779890726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gIuhhsU/oWpaLTfQQ2X5AOpBNNlpQMq5zhNmYSWFHmE=;
 b=xd/WHa6ZLBhj6hvbjEDWdz/a9Ehb6N217Iw25SjACAAX+/9wOoVXVd6mtMMfDpt8ft
 K7X1lYBqFyNaUZlvH6Ihrcvtjv1shcF9riH1dQyMoT+aB/g1antI4XOPBQ4JqqCbNCEv
 YzoS0g+/NWqxKXaEnvNAhpgiDLVM9vW74QWQi++L8gAbVFeErio/nQXvPhZcShnpqMKs
 /xJGhzI1hPU61wOY//DEWeuNzGgKpJmCS/qL+m5e0UnV1bIt//UgXXqilEl/mwpKhAvn
 Vn3GQp4Jq2R3O/JsRCw4UXv7nBzJUj1EnuRCcEL6LenXDPxIFpyFWPLaThdb3x9nBHqA
 UbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779285926; x=1779890726;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gIuhhsU/oWpaLTfQQ2X5AOpBNNlpQMq5zhNmYSWFHmE=;
 b=rkNe/52KQFETGZxGNyLP6xS2xvegCQzDruWKxFJV6bxbq0GYkoDSaXZL41On+/P2Yr
 6Q6gC5xjSI9OBCdMf8hCTEy8OyYy/NvZi98h7qG3R5AutkLwsVnYiFdT9x0ylXqsBwep
 SL7JHaTCLuvNZmnaQPNrlroL5Ok4PSa9mAZ/2wwPmv75lxzFUzzDB0bhrYk9eAEZSChP
 jq9pq+6Ak/X+nf+XTA28x8MJlUDBpL6Yt0XDnE6znRnkUGJ99tZzmPfj+3X610SH7Bf8
 xo3i+d/+/tY+/b/6y8eCQgfWR7Wkr4oLCYY3GNnCowAzJ4id6ECc6r3CRzj22Uj6i+SM
 xOaQ==
X-Gm-Message-State: AOJu0YyIu93XUoCIAmNn28R+XCP60H1abWs9cltsZEhZl0R94Ck9KzPk
 M/y/8E9zi0ZZEinkmLUzO0rZMJILv9AL/sEGCFom6hZPz+EHhrB+ZRpTtOtDbzT3mtg=
X-Gm-Gg: Acq92OGTbo0ZRaqOJqm/J1a0oq1ve64YaxGnUtqqDxyBaovun+jRF2vDhPNVpprK64/
 BhaKzuqdVZxLam4XpKK+0C/v5es72gbgyWWrRR8ABAMirZ8dZ3/wtqxrwUsbGLz7iaeeBdgB/op
 qkN69UgpEMmOLyN3nRu0RCJmtL6ZUYsFTiilVJM+owROA2DofwqfmsiFXda+wTM6qiNHywXcPXd
 wDMNHiIWZU6EDjNJxB1pRTJ/0m5Kr7H6m+u1Ah7hAJ61IU8YHlwVHoembzb43Bs0HrQtODxg8lo
 3k3uDxjGbubDwWAw+QUpYs0weQs353DbnmJfforaauB8klHFFAZRNiXZ+j8q0VqvYrsmd6nkOrr
 856cpaysqE3bZF09vog7zI7tEnnI0TELbDkO+hxj+tZLcCCs+sQoRw4ap6G5+9vQoZU7qappXIV
 Y3sBsyD6+T4u27yxU22fNJ562+FygznCVWTkW6jq0JcgfTJVkTKmoqAur22NiwVaL7tg==
X-Received: by 2002:a05:600d:8496:20b0:48f:f7cc:f6f5 with SMTP id
 5b1f17b1804b1-48ff7ccf76bmr189628595e9.31.1779285926214; 
 Wed, 20 May 2026 07:05:26 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febf81970sm189592075e9.8.2026.05.20.07.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 07:05:25 -0700 (PDT)
Message-ID: <8bf4fb20-d675-4569-92c2-b8921b2991e4@linaro.org>
Date: Wed, 20 May 2026 16:05:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Fix hexagon-linux-user.mak path
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260520123947.12711-1-philmd@linaro.org>
 <87fr3ms0oi.fsf@pond.sub.org>
 <f52ebf28-1921-4ada-a7c5-ec3342cd3acb@linaro.org>
 <57f7a25a-dce1-452f-8529-187d66a6d8de@linaro.org>
 <87fr3mkz26.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87fr3mkz26.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 20/5/26 15:09, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 20/5/26 14:57, Philippe Mathieu-Daudé wrote:
>>> On 20/5/26 14:52, Markus Armbruster wrote:
>>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>>
>>>>> Fixes: 812b31d3f91 ("configs: rename default-configs to configs and reorganise")
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>    MAINTAINERS | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index b75f3222f2f..2a4d124fb3c 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -256,7 +256,7 @@ X: target/hexagon/gen_idef_parser_funcs.py
>>>>>    F: linux-user/hexagon/
>>>>>    F: tests/tcg/hexagon/
>>>>>    F: disas/hexagon.c
>>>>> -F: configs/targets/hexagon-linux-user/default.mak
>>>>> +F: configs/targets/hexagon-linux-user.mak
>>>>>    F: docker/dockerfiles/debian-hexagon-cross.docker
>>>>
>>>> This one's wrong, too.
>>> Already fixed in Alex's tree:
>>> https://lore.kernel.org/qemu-devel/20260518102222.80735-2-philmd@linaro.org/
>>> Pierrick suggested to repost patch dependencies already queued in
>>> maintainer tree when posting series; while this seem counter
>>> productive it could indeed have saved us time.
>>>
>>>> I have an unsent patch fixing both.  In fact, I have an unsent series
>>>> fixing *all* F: patterns that don't resolve to any file.
>>
>> I looked for your series without success, then realized you mentioned
>> it is "unsent". This patch is still valid then.
> 
> Yes.
> 
>>                                                  Why mention unsent work?
> 
> To avoid duplicated work.

I'm not sure this thread is making sense o_O

Let's try to figure what you meant here. I'm not racing to get
this patch in nor enjoying duplicating work, but this is the
mailing list rules (due to the intrinsic email workflow latency,
not to mention subscriber processing their INBOX in FIFO mode).

See for example last week at least 3 developers fixed the same
GCC warning issue. Generically, how could we improve that?

> 
>>> Oh :( I already sent various patches about that yesterday :(
> 
> I've been picking them into my tree as I went.  I may have missed the
> odd patch, but I'll fix that.
> 
>>>>
>>>>>    F: gdbstub/gdb-xml/hexagon*.xml
>>>>>    T: git https://github.com/quic/qemu.git hex-next
> 


