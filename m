Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E715C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 22:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSm8w-0005Ks-8v; Wed, 24 Jan 2024 17:54:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSm8v-0005Kg-6M
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 17:54:49 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSm8s-0001k7-Ev
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 17:54:48 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d746ce7d13so32599225ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 14:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706136885; x=1706741685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x2nI9rtsZtS/jfj4b1io6ekxBYd9MBqJSO8Zb2YBI5E=;
 b=JAVVy9BIGPUijK4MZoyjD6JVVwRHuogaBMTE+4kBh5xmiw2ER+60QbBMnpNrVGB7j8
 zqfSWKsN8bMlBbexEl1aHR5xMhyytO7lei4seyJQNtg+fxbvcxqAe0v3xbzZUieRsOaM
 oyhKopyLTCjg6KqUx5brHFgGeZBib4A5LtrB2bARZxBPtW1IIcQoLKotACDuIgwsmVoX
 tDDFenEvVLrKp6cFcHPN4jJS8Bt/Y1Ee6YIl4aFqYEG91jFh+/hEeoTMRjMpOts5kEh9
 D1+aBpcCROe3GY+3k+q6E3b7YiHRTkFu+JntqS/AihNTk5SOUa+Xp8RqQahqTGfQNTaU
 fW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706136885; x=1706741685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x2nI9rtsZtS/jfj4b1io6ekxBYd9MBqJSO8Zb2YBI5E=;
 b=FyBb5Gnv39BSdfFc0VWnmGCJtReLFsEYQsc+trpKAwSWUkaaorTTRpVadgDWBuPv+N
 /pZTD11Op9n4Aj0NnFBAbQxcDD0GdZ/7/FvEGA8PKlHiq/NxcBNgF8b7j0KFCB61eTlw
 77R94dDCEFOHPtVu5WAyDxbm05cU9gLYdVOxtUdO8x4UR9bV55EU/anSUh/OJc4Cs2yU
 tIQyvXYtDLJM41j5vk1yvGOZEF03ewrKGhbId8nvGLpzYa0M9smdxd7KSbGnp7cauSq9
 WDEDY1zuiaYH6cHetIm43FytQ7fOy5ZnMxJfa6OttUNESB9ojZAHjm4EUKtTtbMLlGNh
 3YnQ==
X-Gm-Message-State: AOJu0YxRfaiKu0wipIPWHISjh1CuiwRRdxWzGh2FYc68hdj3qFenf+H2
 4bTEKHQcHFb0o/g6sJ4T+brs/EZXIwacVh0NessI3b41+oQ0vl/9KQAT2gt6yyo=
X-Google-Smtp-Source: AGHT+IHp+ppUZbe0RhIepHDJqDfOFr5K9dF6x6asATz1KuhpVJbt43bdA0DRAJo/sAdx7oXVEbuGiA==
X-Received: by 2002:a17:902:e546:b0:1d7:450c:be68 with SMTP id
 n6-20020a170902e54600b001d7450cbe68mr149905plf.66.1706136885083; 
 Wed, 24 Jan 2024 14:54:45 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 bi3-20020a170902bf0300b001d6fe15b563sm10909619plb.157.2024.01.24.14.54.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 14:54:44 -0800 (PST)
Message-ID: <cc8024bd-ce99-47b0-9418-f99f37dab924@linaro.org>
Date: Thu, 25 Jan 2024 08:54:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] accel/tcg: Rename tcg_cpus_destroy() ->
 tcg_cpu_destroy()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240124101639.30056-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/24 20:16, Philippe Mathieu-Daudé wrote:
> tcg_cpus_destroy() operates on a single vCPU, rename it
> as 'tcg_cpu_destroy'.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops.h       | 2 +-
>   accel/tcg/tcg-accel-ops-mttcg.c | 2 +-
>   accel/tcg/tcg-accel-ops-rr.c    | 2 +-
>   accel/tcg/tcg-accel-ops.c       | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

