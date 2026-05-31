Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA79CD6E57
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTncM-0005hs-FL; Sun, 31 May 2026 17:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTncI-0005h0-NZ
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:22:43 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTncG-0007dr-Pg
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:22:42 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45ef5146b56so1226451f8f.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780262559; x=1780867359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DURbIP8Jg+r+3ZKVgmLRjQwOU3DJ0HRiYWmwaianKnM=;
 b=rz1sQhD5f7P7XvKEAZc0GuWJoP4DUI8FdPbnvJ4k0vmQMw2j6edgy1FHK+uwwR2QS5
 zYuYeoS59kuiKXS/j4LJ696AFk0++xDaWdgGo8XBVzjoG8dtkDe4PVBlp5LYUfmttFvK
 m8bLNkBemjloQMp6sj3R/4TaHtlfttLcoZRWkZi9BoFa32Z7VS6qciijew/GsOrGDP5u
 uabBZ3z/YaUFIdNDG1QmuQe+uWkcGxs7cL4USJDXXqkclgNvrvYdMbOtLSCsEe3O4maB
 yMQG0WCrYY+E+zglqwqTXKuAdzaUOt+Hzy1l88lh8Q0dcu0Rlh4JoLgU2SLqXcaAqLRX
 wcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780262559; x=1780867359;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DURbIP8Jg+r+3ZKVgmLRjQwOU3DJ0HRiYWmwaianKnM=;
 b=QeeGgKQRtX/LxPyevhc4WhFNKYO1EriF1YXJjijsBH/YEJXkdZc8zMZcZQ2AYIukEJ
 hprGj0hVwxlrLR5U6oYU0nY7t4obluQ7yede+S/xTQ4rD8GC2/xFFT3Kw5QJvJ6puAcE
 9IiJNhHD5S3xtwrAxWJGBb/qdx7jIWgyHMCq38UHqMqUnwPLlCkRA3mvqp2nD5wL7s9H
 lAfkV34ZmydlRFS51/bgp/Izatftx0U/ElxCOrpPgvGC/pUpJjf0GKNlLKj09sNaLsl5
 faMiZvg8rI02y1vFPaQPaHqxwNq5f6bgZYmqUTFlvxDC2x9N+gDgH3yZztL8OxhYEmDL
 4NaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hJ4xXTxXo6aDuSLkzJg6RZvsEYmG+ppKABRa1q4iBdU3EgEP02MWfdKi9pE6gFLyuJNk8y4jw+cvH@nongnu.org
X-Gm-Message-State: AOJu0YyFj6RCEc8BSrOVIpDgy6K8uPZblZ/5S1pV264iTxEpzZHxNEox
 q8Dkj3N1gAwXiwL0xc+X7uDMOaSHhypzuX07EDhM0Z/TABUyqkLkL1ooq4GUdNxjWyo=
X-Gm-Gg: Acq92OGSfXmaoYVpWdLZxhgEm+pB8thsl6ArrfhpZiCekdvR5DnADeD8s46GfuuKoGp
 pbs87xjEjwSMWrjbwW3mSYELjWe7W2cmsyMDDCp925w1M3goid5o9DS4ubhs9QMm/bfx0A1ZiVT
 fHklR2DtazbXj/IWRDBopfTZGYuH5Ohdjtm6dKFOE63Q9BCfSSpdeXhbf/xWYgKvqsUmTIbAu5Q
 npUPxQBuGr45vXGVKxHrE0nRVPZwByjKn9+RiAhh0SXHr6JSUV6/wZKHRXxArr0b3Msaun/x5QD
 5XSx31Wz+dQTX5dmhWV2SQY2Ixm3W/YsFPlgkwGQzjjYEpoHm6XaT35xU+wDCcE6WPwJgtJ1UF0
 PBw1kgmsVA4x4w29euzBfnJN04Fn2mq3ZaGR4oRKpj8ezkPp7suhaJ+n4uvw7C3QkRALzFjPUhy
 esPpbHSABlOFR2pEBMBwRD9vwsdqKkuGYaVX18/kmMHUxYU9rcYzhvGm1FP4/CADQ3d6MGFwXqf
 cd5
X-Received: by 2002:a05:600c:3b26:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-490a2a7005bmr111521105e9.14.1780262558831; 
 Sun, 31 May 2026 14:22:38 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c08f1bdsm93504255e9.1.2026.05.31.14.22.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:22:38 -0700 (PDT)
Message-ID: <356e0211-cb77-40ee-859c-64de49dabf2d@linaro.org>
Date: Sun, 31 May 2026 23:22:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/38] target/hexagon: Add placeholder greg/sreg r/w
 helpers
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, Brian Cain <bcain@quicinc.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
 <20260529215554.606133-19-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260529215554.606133-19-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 29/5/26 23:55, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/helper.h    |  8 ++++++++
>   target/hexagon/op_helper.c | 28 ++++++++++++++++++++++++++++
>   2 files changed, 36 insertions(+)


> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 53898db815b..359bf12f1f2 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1373,6 +1373,34 @@ void HELPER(vwhist128qm)(CPUHexagonState *env, int32_t uiV)
>       }
>   }
>   
> +#ifndef CONFIG_USER_ONLY

Can be cleaned as a follow up: move to sys_helper.c, keeping op_helper.c
common to user/system without #ifdery?

> +void HELPER(sreg_write_masked)(CPUHexagonState *env, uint32_t reg, uint32_t val)
> +{
> +    g_assert_not_reached();
> +}
> +
> +uint32_t HELPER(sreg_read)(CPUHexagonState *env, uint32_t reg)
> +{
> +    g_assert_not_reached();
> +}
> +
> +uint64_t HELPER(sreg_read_pair)(CPUHexagonState *env, uint32_t reg)
> +{
> +    g_assert_not_reached();
> +}
> +
> +uint32_t HELPER(greg_read)(CPUHexagonState *env, uint32_t reg)
> +{
> +    g_assert_not_reached();
> +}
> +
> +uint64_t HELPER(greg_read_pair)(CPUHexagonState *env, uint32_t reg)
> +{
> +    g_assert_not_reached();
> +}
> +#endif
> +
> +
>   /* These macros can be referenced in the generated helper functions */
>   #define warn(...) /* Nothing */
>   #define fatal(...) g_assert_not_reached();


