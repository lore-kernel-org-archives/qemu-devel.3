Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082F8D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 11:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi9Ws-0006oT-Od; Tue, 20 Jan 2026 06:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi9Wo-0006lS-6G
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:04:06 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi9Wm-0003RT-LQ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:04:05 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so49352295e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 03:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768907043; x=1769511843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W0JD07AZBpN55XM8F3b36pRGyGB8JsDnYlN4Wnuvsis=;
 b=DcU/s+WAJ9jz883OodC0mXZvcP88YOG+0oGTWWMG2zOgUuDULTHyOKJCD7tNahHDIn
 rrVqwUoGt+du8kXL3ylu6mkxQW5TlPttBQE8FurcmH7JB0Gyf658nqMLxCHYAmBXNyQm
 gdWxIotkRIlshU6OZvXdiJuWWlBX7fwQlLPWeHAFmlaGm7vfzXYXlIF5noSHD8Fkn3Bi
 GtsGHQc8PZfPsCmqhjNagn8mfwvK7ZFG+y3Gco6Vp7W4chX06mEUFmTtYNhDNoI5J1zJ
 RAf2UNNPr2ZED7UjWnDf29NyhWn9CwA/fe4kQWZZ4ux3SooUymgGVfEcTu6KXgPq+bIX
 DEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768907043; x=1769511843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W0JD07AZBpN55XM8F3b36pRGyGB8JsDnYlN4Wnuvsis=;
 b=AMDcufZqf/JqYdIFnvEP39zobQDelXsa0MvXRMMPy//yVrSGkZpuU5s15azSBnkKl7
 /1ns3BWcuQbsnnEwSghrSFCm8a+BA+LbmMJ8DyIvH97ubTcKjF0I6epCx80V/qjePonv
 OiVriZ0J45Boj47yiKDKraruoyyZUFj1D0JbgHJTQVzEh8WK3ufAFMXqqoOgJyl0tMe2
 MvLZ6+rFXrlvptgUMcQ08e1P5XEWmjz/JI5GyVsoip5TylQKsmTOhNQCyz5J4PIIoz0R
 NoRu3A/zGBYGMHFQiFeV/43A+cP2vxeYifCawJY3wxkk8j+i+1wZjOGPcxUs53+o4Snr
 altw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxNsDfi/4Z1MSrNqKZMxrrdGWMOtFFhwYwjhurCdyjbl3iUiM1y2ZtsF+nSEYBsJBJEW9n0S+ggTkz@nongnu.org
X-Gm-Message-State: AOJu0Yy+E+5bKjf0vQRdO201gJnGowVDHUoe8fmpQsuBPuz9tFcgVRAN
 J9ajxQYOr4lW8tJb1wd6y2hEizbakUbXCRc6dlFkMV+BO/YkSpQ0v7Zt8S0vBn2FoGQ=
X-Gm-Gg: AY/fxX5lHe1s8e8vNWO8GISvu1oGVadL7XhstRKI56MNrZwidSUSr23NdPtC4ZODF+q
 BRqqORf5W4hdg+hcuo0hyLNop9U8EdzseaiUCs1J8tSzWpgZsPbQRcI+dzQszNvsYGqkFetB1J/
 1AUnSeft/AvVhQooS9ezr+UKJFsR3UNB+7M+zP6rb3BOs4O8zrYf6NfX86ggyh2uD4Et/TJuzPY
 H9zq4bi3n8M3WAur5T0cUw4c+sle510YrQD4sv9CMo4TKx5zA1wXd9J2/I78Ry+bYhHv0WO7MCF
 hrx3QbAxTYFaBOU3h4RbqIbMEhJL5wayIcExcIQe3c+Nt4DuH7dobY8+aO7MwC9OQ7UfVRs0QPn
 nUDegk4OR3O8ZY6itND2OWUsXMSQdaF5SeOEt+qJrgUx6NX0ZepY6JxLwxcYO2Wp9qSm/FJl/mq
 nQdKYhttnZNy8/m4kFDVcMzLHegr4qRXER6MknaP3nRM/3+2NcNJRW5A==
X-Received: by 2002:a05:600c:3e12:b0:477:76c2:49c9 with SMTP id
 5b1f17b1804b1-4803e78ff26mr16841915e9.2.1768907043040; 
 Tue, 20 Jan 2026 03:04:03 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4289b789sm299768515e9.1.2026.01.20.03.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 03:04:02 -0800 (PST)
Message-ID: <a4cdbd4b-f780-40d1-9e41-3c3ecea54720@linaro.org>
Date: Tue, 20 Jan 2026 12:04:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 24/26] whpx: arm64: check for physical address width
 after WHPX availability
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-25-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116135235.38092-25-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 16/1/26 14:52, Mohamed Mediouni wrote:
> In the case where WHPX isn't supported on the platform, makes the
> intended error appear instead of failing at getting the IPA width.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/whpx/whpx-all.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

