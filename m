Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687DBCD1299
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 10:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru8Tz-0007aR-64; Tue, 09 Apr 2024 06:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru8Tn-0007Zl-DR
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:13:30 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru8Tl-0003ph-Nr
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:13:27 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56e69a51a33so1391187a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712657603; x=1713262403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ANszgX4aSUH9u8zKZHHhE8et0D1o2RK7kFE6pc/c7A=;
 b=f8693ktvlpnB89/YOiLSOh24VUfnVdM+ORhyD9JaZKo880ekggut34GbQMATL7p7an
 vBfsEeNQSQTG0bzencHqhJrUxUsAw0QBGTipk+4Y0p6Qjs0PN2iGJ+LE13/+oNCvOT0Y
 oZufo6oD9fV7qm5B6RtDlMquoR+tjcef/qYpCj3f0Hiin3nWlzbWTn51oPBwMlQtckzI
 G55Wq0BO5k8trrJ57fvDG/SKPD7arv0vhSftuK7byGkB7LV0BUKsr7V2b0d8uMedrV9C
 ef78L56XBraGRBaxJlkJKLKtK5QFhr/3lVH13GMiZGOAQJAgz8AxWvfN+uAKWbmC/e30
 0rYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712657603; x=1713262403;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ANszgX4aSUH9u8zKZHHhE8et0D1o2RK7kFE6pc/c7A=;
 b=l8SQT/1st4wEo8McAfiylSI2DTiD+wq/B9GPpq7zh9XBK06Dq6JGZj7r8CkIomCsNA
 +NkShJqAXCtsKGBqY50cP6/hakofTWBV25VW4hbhH5KU0k4TdXyliQHNOUT7y8ENOwo0
 n7b02dnEuO8OYzSP7fyFmIEzgzdgHvIWwR255p5BrEvRBJ8kUW0MFCLzl7XBAIA08jrd
 y4Oi5oovTyBtdoSvAKBKJovu723dlESuEMFCkEVbZXISds9zsyiYV/m9Aku2nKCnncUl
 bs6QiEnn9Wf/nyPTU0n/7GDIN10U62l6Ih6uqAtsoxKpT8VAMxZSyiWCITxuM86i3sNJ
 jVVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK2C0USw+H4JClsqAyOib5OQ0Lkb+JfMcv+Cni5Vaxv99cEUv0O2q8vdkYK/K3VMicdPJWhj9u+oz4mdnkzDpnwIhf8+k=
X-Gm-Message-State: AOJu0YweSgvTfoaI8ihRrd5XO9j/XuLnBnwYM6bphPf4oWV5XVKyaHGH
 V+wosBcXl4VehOZgtvdHK+UiFuZtDKny3HaO3d5w1KGr2qM6XueX2V7rT+ycqVQ=
X-Google-Smtp-Source: AGHT+IEbcgW2jn1TWxsRIIrBFhlCfhKqDBq9bhwERjwL4xH6nKDr2xFF7Th5c2Jn3hqgUULpQ0RIqQ==
X-Received: by 2002:a50:a419:0:b0:56b:e089:56ed with SMTP id
 u25-20020a50a419000000b0056be08956edmr9345710edb.39.1712657603042; 
 Tue, 09 Apr 2024 03:13:23 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 a24-20020a50c318000000b0056e347954f6sm4850404edb.31.2024.04.09.03.13.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 03:13:22 -0700 (PDT)
Message-ID: <3fb12f7c-2749-40d6-95cd-4ff98796c0f0@linaro.org>
Date: Tue, 9 Apr 2024 12:13:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] linux-user: Preserve unswapped siginfo_t for
 strace
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: gustavo.romero@linaro.org
References: <20240409003411.1452196-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240409003411.1452196-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 9/4/24 02:34, Richard Henderson wrote:
> Passing the tswapped structure to strace means that
> our internal si_type is also gone, which then aborts
> in print_siginfo.
> 
> Fixes: 4d6d8a05a0a ("linux-user: Move tswap_siginfo out of target code")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/signal.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


