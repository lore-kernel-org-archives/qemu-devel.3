Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289C0606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=C76eQuNd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTT5W-0005rO-1c; Tue, 17 Nov 2026 18:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTT5U-0005rD-DH
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 18:59:44 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTT5S-0002RM-Ok
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 18:59:44 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8b600fae14dso176771b3a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 15:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794959981; x=1795564781; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1gJ6KeIJAOkjxfIaImbyUeWwQnKpdFw9XP+Z2uonX0A=;
 b=C76eQuNdUlDwa99izoS1d7MmH4xhXsB6fkaW/WX8YJvRHp2vt9VRk9HqV5npKCoiB8
 Lgvag6nxmR3zutrqH6GCjD7G/dh2Q15ok5ulyail+ogx/4ZmGr/nWQsmlVwlmblnNsoe
 4gQ0SRWL9U4D9iftmH5QCoKqgZlmB7jyhUQarRI57vUy0FY2PmxtIWApTie1LYuMxjgH
 rg98CFwPaFw8Zwu5TnC6pdMG4yeUt09imu8YR1FLFhr6I+Y/G93mAailLlLzCmBUK9RH
 BtR/0XbBHxG9m90Y4G3dc710cnjXaty+iZ/0Vqv4Frnr65LF2UqTE+2BsmMAeT14tejx
 ENzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794959981; x=1795564781;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1gJ6KeIJAOkjxfIaImbyUeWwQnKpdFw9XP+Z2uonX0A=;
 b=joP/ZEF3qpF1WrN+U6ahI3qkrSOs/3gkzLyT9qVbBLm87K3Y6i+VCC4X17zeEquICu
 cDAi1uWnE6sYpx57glU+uM6dw/Eu+huxpGhhEWWHZeS0yFFDFxS9UOr7bs73AMDJQBam
 E+ThK2LemePrpiRgbOmARRgn9eX9DNQOu5WE8ytktlVG/GStI4PWlSWne72CFiuRdRAD
 qK4sZUZsVEQQL2cwTGJbJFNyNDrZOon2lPTdTviBAWsXuU0Z2RCHYpej/Kj5RI8GEYCI
 7pN6BrpuyaJjErpFFv6WbG+XVs5//5ju9ezCh8kHh5+l/WcnRplkA/OjE3YTVkiCL9qw
 3UJg==
X-Forwarded-Encrypted: i=1;
 AL+hErHCcGuucuAfPAV1eupXx+GITc5rEhNoyDS0CUJHjmgdwCEk8R59XHNPw7yXoCkO7pbz71boZBLtIhgM@nongnu.org
X-Gm-Message-State: APuU4Z8UcvEc/+T+yn2Os0267qTEo80VpwHXXeyBwTQWHB2ZVi+0NmC5
 hXW0od4yAzyyWk5udtZcFHwCX/jsPRWA2w0EsAsN1IUi5yUUjQDfZNFSQVc1yVbQKU4=
X-Gm-Gg: AYBFou30pFufZakWudroPkTLKtWbvWxTqeHfFXlSPHV7AUWc2bKTUrsN12QAlgJTF/N
 JD/K5PrQExrM9nI0my6/ywNzxate2aUuvnrGc7hwEB0cfQYzKoXxZuysWN0iryY2luLAGXlNQKM
 0UQKO4LXZ2pnAnu8sCoC7p6FR4bC4lBV1wGZ1v6A80V/6pRtZrd6TvsUizdR9Z8IM4yzHXBJCzj
 DdM7zMUult4VuwjNb+XnIyR60W8YRTMAJsCcWhHb8OuW6fbt4+/dd9a53Ek9DeTjkoN5DEOjFAB
 OvWnEb+SENm2/qC7mb+smRb7gXTv/RebDg1oEpHznKGnMKbX16C3HN9Uyl9G1YaWExYkVEVo1MO
 L4tzmez8EdA0KxPPjBotRX9QQEQsi/WMcjJdvnxkxIFGewm17QDqoZ/lFEITwEltooHA7jy2iGC
 jGCdEkigutTdd14x0YHZ3FEskSMTLMoZjG9dyX/dM2aiK0r9AoGcR85MjGclD+K+0xa3qkVPiCu
 e2fq3oJDEm1BcYVEHsunYyb6OZixlbGpETlpQlyNdHC64g3yo+ZfDkN9b7llXwgDw6qgCSBsP3Z
 739thPWOABaLYrR5ll9kAeQdCHpJWfV8VbI/JKGyFjpe7uWJqXC1v8kjA8A33y0eZkBBly9iIy/
 s/17XodJFpnhd+MeY8Q==
X-Received: by 2002:a05:6300:496:b0:3fa:df2d:d3cf with SMTP id
 adf61e73a8af0-3fe96ff59eamr693387637.14.1794959980912; 
 Tue, 17 Nov 2026 15:59:40 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c5cb93d04bsm222847b3a.49.2026.11.17.15.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 15:59:40 -0800 (PST)
Message-ID: <38c2c229-0c72-4146-acab-44b8d59b7d2b@linaro.org>
Date: Tue, 17 Nov 2026 15:59:38 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] tcg tests + docker 11.2 fixes
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261117182304.3261165-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261117182304.3261165-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 10:23, Pierrick Bouvier wrote:
> The following changes since commit 822b70d4ec8532a569c1c88060fc8f41d5b294f2:
> 
>    Merge tag 'hw-misc-20261117' ofhttps://github.com/philmd/qemu into staging (2026-11-17 07:25:58 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg_tests_and_docker-20261117
> 
> for you to fetch changes up to cf2f97574c18aeeb45fc38aa6864190aecb64bb5:
> 
>    tests/docker/dockerfiles/release: use full registry name for image (2026-11-17 18:21:49 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH 0/2] tcg-tests: detect redundant exe_name/test_name (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261116232140.2758664-1- 
> pierrick.bouvier@oss.qualcomm.com
> - [PATCH v2] tests/docker/dockerfiles/release: use full registry name (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261117170244.3180399-1- 
> pierrick.bouvier@oss.qualcomm.com

Applied, thanks.

r~

