Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873B1F3382F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 09:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2R7t-0003tu-ST; Tue, 17 Mar 2026 05:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2R7s-0003tW-SS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 05:54:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2R7r-0000LN-AZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 05:54:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso49170435e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 02:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773741249; x=1774346049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=//AqeR4JzpelLAMy1QHH1fZRV/plv/DWbwqgi3mpgto=;
 b=b+2G9Sh+/M6vMfVNwRG3AOBzKSIwFS94/RYiWBL6d3dnPwpgQNKA4uB0MLIQiBZLmL
 CoqtfObrz82xFK+8l9SyKSTwu33P/JpQLOmech6Fo3+fl9K9eJv0mhNPvOgxR25gSkTg
 3ZY5qMlat2BaNHd1Y4MqSl0DPZKZ/PPhDjlB6GDO8eB0fauqB75whMPBMAKjHZ8NU0IJ
 DGJD7QOLLDcXgVN8yxtC4RrPFyo9Q002fFKVPtwye5kNiQSupW9v/DnEK7jaB7H8AYlr
 XBiyh1mePBMzgt5uGWdEuiWWV4/+El28tseEAtfSaH3M/pIS0yC9IJo2msvdifFIHcDM
 cs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773741249; x=1774346049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=//AqeR4JzpelLAMy1QHH1fZRV/plv/DWbwqgi3mpgto=;
 b=BHBkbLYuGb1EepGzQDcgmyBZpSOsEXlIl7RT9I18+nuiKfubgRSh7O9MzeM3/YJJD8
 q1RDS4p2KFScU3b8nBaMxyvzXHjdaz+W0NzNwuDzerXEd+DXjrcATnEVmGFKvqCrR+QB
 KlShSxouKR6D2lutIwcX0rNxuL/U0WSWlleHuTQiJAlJI8E3Waa155xhWaQJcjRtei5X
 NwJdD+ecQBY6Ij8kfI4gMg9or5j99bTfOncdDXlPtU07qpXqYTHLIIBiX04u9luZmM76
 5OsbAgu+EbDsZSPqS39WmKJ6/w7LdxpOt/uc7+DffZhqPgTk7CszAA0vC6+1xaQzOilv
 d8qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq3Eq+m6S5+oD8zZH5Q8a6uEbcTTtdlIrz2xmj9TnNUFZwlBkpFH/Svx3+zTU9FtY7sHkyMF1fT7JB@nongnu.org
X-Gm-Message-State: AOJu0Yw25ZGfs0QXtH4HNrcogjDsTHMwsWKyQ6cs/qynHpiNHaSDta39
 RTxGbtYzryjWF5cHqToepmb6SZ2A8hnTuwLoWN7HNhuwVGXmMMDPRg+BCIGL0c2/d8GL/6VcdXi
 BLkKSjlM=
X-Gm-Gg: ATEYQzzBT9zGZgd66Vh+36VAlFHK9Pv6U50eIxMYE47S6y5xpYVEc5EjsR1yeQ/g2hJ
 yzztYkVseORFbPMpmxWv2UcVOn4Yn/NHthj+JhJFt+TTBrRC3c18njSprbas6s7VBhYTZkn5ahL
 3uSsT+7DIoDqCCRLMB1KnOBlEnBGXr2eg8FcDZE4fmlp1zIpMg/YEi0K8G9EhYyATc6Y6IqbVTy
 z5BY3HKJTPmX1TEZgBvLDopQrwyCo5Q1Ob7/Rxqk6RGMzGAWIZIAwdXjMQbZVbYYQ/YxdblM0ns
 CktAzsoSoB5frvXLyWTm0ClOTLOWQftPLOpuiNGuN1GA5CH9G9QZ3u2FyTrXXxM8ej8yQL3C82b
 0ei7Yx7cwoAN441mH4JWkCxcL2xUY52X4RhEdDfQ7aK37g2Z9+CHlhp7ik2OmtuFz+8sRLyEWX+
 HgerBjdltQYvbPm341M6M3IEXDvR/GA4Mmgus95jTaDLr9v16GTkcVK9jiRDA1jkMcfw==
X-Received: by 2002:a05:600c:8486:b0:485:3bc7:a231 with SMTP id
 5b1f17b1804b1-4855670b7ccmr266828405e9.29.1773741249543; 
 Tue, 17 Mar 2026 02:54:09 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19b936sm52494376f8f.5.2026.03.17.02.54.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 02:54:09 -0700 (PDT)
Message-ID: <460dcf4f-e5da-4365-8924-8fd0231abe7b@linaro.org>
Date: Tue, 17 Mar 2026 10:54:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] scripts/qemu-guest-agent/fsfreeze-hook: Fix
 syslog-fallback logic
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
References: <20260317094806.1944053-1-peter.maydell@linaro.org>
 <20260317094806.1944053-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317094806.1944053-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 17/3/26 10:48, Peter Maydell wrote:
> In the fsfreeze script we attempt to implement "log to a file if we
> can, and fall back to syslog if we cannot".  We do this with:
> 
>    [ ! -w "$LOGFILE" ] && USE_SYSLOG=1
>    touch "$LOGFILE" >/dev/null 2>&1 || USE_SYSLOG=1
> 
> This has a weird behaviour if it is run in a setup where we have
> permissions that would allow us to write to $LOGFILE but it does not
> currently exist.  On the first execution, the '-w' fails and so we
> set USE_SYSLOG=1.  But since we also do the "touch $LOGFILE" step we
> create an empty logfile.  Then on the second time the script is
> executed, we see a writeable logfile and will use it.  The effect is
> "log to syslog once, then to the logfile thereafter", which is not
> likely to be what anybody wants.
> 
> Update the condition of the first check to only pick syslog if
> the logfile exists but is not writable. This means that:
>   * if the logfile doesn't exist but we are able to create it,
>     we will create it and use it
>   * if the logfile already exists and we can write to it,
>     we will use it
>   * if the logfile already exists but we can't write to it,
>     we will fall back to syslog
>   * if the logfile doesn't exist and we can't create it,
>     we will fall back to syslog
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 85978dfb6b1c133 ("qemu-ga: Optimize freeze-hook script logic of logging error")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   scripts/qemu-guest-agent/fsfreeze-hook | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

