Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD76E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 15:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBbZ-00042Y-O7; Tue, 07 Jan 2025 10:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVBbX-0003v0-G0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:34:51 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVBbV-0005C7-P7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:34:51 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21654fdd5daso214408515ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 07:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736264088; x=1736868888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qgHvuD9mo6flfbAZTuMkYLnQcUOY8FDvBrOYgWFXpoQ=;
 b=M2/dD2EC1SuxQOqgZBeZYIlxwb4smslEHa76HidfX8DeFMZqTOGhvJ9L8W1Cuc75JQ
 5UG0Ks2g9TuNE5qDCwm8waE4boXIu1Flu8bJPt+pWvOhRFpYg86bvY6apUxczcnbB1gR
 fk8v2YVBFiWaRmc9jaFy+Gr7xySE42qWLIs/ORugMGz9bfLQD+IvDe02m/zfYVIl/ZpA
 6dkpUAB48lqvrQkn4Pog0GbXsTp8zBbz1T9jKHMuQ7gQELXDuS0qrrfiLi8J32vPp8Ei
 Kqdx8POt0TIKQQbJDJZDz72vN0/y3/S6pQY1CI17L6yAZVnovWmSWxv7AZ/HSD8B55oI
 2E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736264088; x=1736868888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qgHvuD9mo6flfbAZTuMkYLnQcUOY8FDvBrOYgWFXpoQ=;
 b=QZXqyv1VHHl+fQ74jZ/ZV+tpNicuoQbI/tS/nnKtvwLYL0mdoQCe/X5TIpNYDsdpW/
 h8xA2uotEcr7h3Z1puhYVkDsjA2z8NK+3zUQCsyJsu9lUdmUSLB9iMzsmBeEj41ivx2y
 YUzV3rCcdmQoJVoIElF/to1UGgJeyB3uLvS4pb4i0aiWtLuZ+O/ruXg5mmVTseE+aP2E
 qVa1jDBe4EAnQ2YS8L8C1bqfQA6uR1GzErWDAejL0dH6U+0eo6uYFxIzifxWepMdDf7r
 N5yaa7TKVkbM4cv1jgua8xTqO+qXFcyJH+ZP7q4EiiOF9kxvTaHnBO6RCHuFBtvHlBJT
 2RUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyUMtxLAGD3SmEa7jfhPGvy+To6MgEoLOyMVxE1zomwMxvuuJc5ZaN4bVc5y2yR4UcJ+1SBHUe4zOu@nongnu.org
X-Gm-Message-State: AOJu0Ywey5KcuW1SsriVvGp54++PCNEdpTJhQZ2/6ihkRF9jC90diw3w
 ZS61rr2xkZx4E6w+j03HjVREH5eitbjuX+jr5ZSy4A58kOkRtFj+TOtSi5cb5e/3TpS0f7MHLCn
 O
X-Gm-Gg: ASbGncsV3men65VsV+usGmRJu5G5VCpIzPf6IkyZjRTGQWO/E8nKvJl2Hm6EwQCyUw1
 uU0/Btf4YyAi8TshzYXw7KNCanCwtjjT1X34K9PaCCgxMI/hHXnukqmoV5lqSOeCqxYnJWmriDr
 0cuN0c/V8TjJdr4jALfy2nOBeDN7J+JJjkLOtGGSM2SNC8INccJIDJ6+6ugQBWbJrbAbeiwWW4c
 9E1ZV+TIFkktuHd0Aq6Be+VRwzQzv1qQxlt1rm1zrlpAU1BfccbfW2TfHEU34XkjK9Dms/kPc7i
 16qWscEpEtNpXO2M9C+iC2CdXBKdTGs=
X-Google-Smtp-Source: AGHT+IH0Qqlxhfp60UweDm07f6TXXvd8IHIcd3qEwTcEF74MktQnAtgm78MXQ0GvcBpqlHFpFn3vQg==
X-Received: by 2002:a17:902:d4cf:b0:216:60a5:ebfd with SMTP id
 d9443c01a7336-219e6f5472fmr700569435ad.55.1736264088212; 
 Tue, 07 Jan 2025 07:34:48 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705c1sm311335215ad.101.2025.01.07.07.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 07:34:47 -0800 (PST)
Message-ID: <1db55939-040e-47f5-8550-17a44f3dc129@linaro.org>
Date: Tue, 7 Jan 2025 07:34:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target/arm/arm-powerctl: Restrict to ARM cores
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair.francis@wdc.com>,
 qemu-arm@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250107135739.48324-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250107135739.48324-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/7/25 05:57, Philippe Mathieu-Daudé wrote:
> Since v1:
> - Factor cpu_is_of_type() out
> 
> Philippe Mathieu-Daudé (2):
>    cpus: Introduce cpu_is_of_type() helper
>    target/arm/arm-powerctl: Restrict to ARM cores
> 
>   include/hw/core/cpu.h     | 9 +++++++++
>   cpu-common.c              | 5 +++++
>   target/arm/arm-powerctl.c | 6 ++++--
>   3 files changed, 18 insertions(+), 2 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

