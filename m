Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A1DC9830A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 22:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgsek-0005Hw-4A; Fri, 16 Jan 2026 17:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgsde-0004MC-El
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 17:49:56 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgsdd-0007v0-16
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 17:49:54 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a0a33d0585so16139255ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 14:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768603790; x=1769208590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+wDS3enKX7juOyzLJX9JHe2huFCoU8PL1zri4GFZqng=;
 b=Ty5Rdmf9BIlrOG+hI7fTwRzWf3GPlyC8svrLQWp3BJ2nN36ZWuWal+q0324jL3tq0j
 m/R39xEp64SJTWF8e7cF9S+X2PTgPCwRfbkhvPri8EZIoPn+tv6mns284Llnb3zxbyJY
 hjLJnmis/+NkycyLWvQqcHDPPc03Uvy8fn+WX8qzhsfi+tZofM0bELybGq4eZ4Aysi/U
 D/LGAiY7i4OgyTFeyjrO6zFscZiXc41VBWzcYYfzaDCVGVwfVdnMQDoaPbAbMwoIXRAz
 expeCQN4yZRcIDJXpIwUWUtQa5BgUNlLHYmm/jhYe8mUHGtoy5SA/2lJfUXsdqz2/ZSi
 xzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768603790; x=1769208590;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+wDS3enKX7juOyzLJX9JHe2huFCoU8PL1zri4GFZqng=;
 b=p55onHTnaba8KLHDneBRatWhz8ZpjiW4kr4EBp3qI2DHypVbSvC8KwcySWSXoCMKe7
 h6TzbHMpkvoYMqROgegAczFNj358/0ANKjqIKZxdgeaZsYGKxMHYKzlHCH23+TZ78A5J
 5ju36Ku8BZbbj2F1zU7OzADbSPthEGGDk/3TO8hlqSNdQ3lDcLbeaZ8JxwbUP1S1kIS0
 xtlXYcOoW2Rt3zGyx7Fc8XiBLyRxpDuyC3/v7+8tkpM/Mgw+07HX/3OT2Z5i93j29v8Y
 dwycxzU5OUVtSg3Vro2XW+50IbXTEmCkLnf+B259kmP0jJBWGNem2AvhaOIxK/eUPBEo
 rOcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgXVg1RVZ0Ty2mINnR4slW6iRk4RC7fPEArhdHDXJMRtEE5IjGpg9+sqRJfgKuDuwKX7YJBxs4SjWL@nongnu.org
X-Gm-Message-State: AOJu0Yxkzcc3WPmjQBObTls9ya/yycUh5zwvyy43K1DIMJCjg/fbRoh0
 n93lFZX/wqHIoC5BbAZ9xpA27P/FLAwItVVTINApnIhC6nDAJl8BL4sGaJUistoyPyM=
X-Gm-Gg: AY/fxX6wVZBoQ6NzU24ZSy9YgUkvnVVWvPKWo2BX6KTfJHvW7B4HHPSH5THov3cRq/E
 YZLj0xZ7NVf3CQGb3ekvX0rWX3Z9sNYClqBMp0G+3nOsz09w8+gQa0zbiLyzmpWkfA6zYD9cwWg
 ZXgDBD3VBpdCCovMKPSn4vtpV+lfPmtCY+PLmuHdNSToSR4oGq9RCvbjH68Nowj368thn6L8ZLo
 aQkdZ9Dr34RvrcMeRD1+8rXQEB+GAgRTdextZo7X/7cjNradbcakz/QLDFGuEdqcIQDoSgxIwjK
 7MwViQGWu4dFl0z93o2EzQcSQiR1oOJjZIwfW7NLD2ZOwl7JZQcfkDGD15x5I7Au8GIz2otxCWY
 xFz07Xjqz1WkEvPdzy9yaYo+U2Bq1EsNpMXH2j2ypdMQyQEYndFTCwJo7KCWdK1sOhcGxKLH5Ze
 CckxJXbMOPcuousJuHAdgQOQoPjkKQHsc+Gj1WR3t5VP9hyRlHWfYCupIg
X-Received: by 2002:a17:903:1206:b0:2a0:c58b:ed6 with SMTP id
 d9443c01a7336-2a7188fd7c9mr40307205ad.29.1768603790414; 
 Fri, 16 Jan 2026 14:49:50 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-352678af047sm5406792a91.10.2026.01.16.14.49.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 14:49:50 -0800 (PST)
Message-ID: <24267db5-5c14-48e6-a5c2-356460924e6a@linaro.org>
Date: Fri, 16 Jan 2026 14:49:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] target/arm: Add a _MAX sentinel to ARMASIdx enum
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org
References: <20260116185814.108560-1-gustavo.romero@linaro.org>
 <20260116185814.108560-4-gustavo.romero@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260116185814.108560-4-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/16/26 10:58 AM, Gustavo Romero wrote:
> Add a sentinel to the ARMASIdx enum so it can be used to compute the
> total number of address spaces supported by the arch.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   target/arm/cpu.h | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

