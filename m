Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D07CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 18:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOJMb-00028T-4e; Sat, 16 May 2026 14:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOJMZ-00028A-Rc
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:03:47 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOJMY-000257-3f
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:03:47 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82f8893bff3so404425b3a.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 11:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778954624; x=1779559424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YlKmFSFwZPKbHnr1+wcvQc1lFtSnECQOGaF8rh8TLhY=;
 b=NrHAkjehronhHWUXTsNPMGTeO1dyCRpX0TNm5/mz+ox/94agil6tSqP5JwGlvNIJzP
 L5CrvMg3DvBRfZALMaI4qLzAvCmM5Ujgn7Sl4XyOFzPMTJ+GNWELWEH6Onp4kZe/hGBf
 MM9Smo4bJUpe0Z/JCHBm44TJp7Gk5CNxsv99reyKneaZtaPS5aaehDQE3JL/DTaqViu4
 fIhmc/BNcRwcWSmaDcxeH0yBjb5l8hOlXhaUvDiTofYjMnnMEyd5P7jC7i439nQrWAbO
 uoRuN/xcyTXEK2sAixoifiSXJD1w5yaknXfZerFo8PIjo40vFExsKxSaxGRpOkIFjI3e
 DnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778954624; x=1779559424;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YlKmFSFwZPKbHnr1+wcvQc1lFtSnECQOGaF8rh8TLhY=;
 b=eG+xXjWO24J6y0meiHBDUSCKE8GiqRZhfyCb6f6/J21J/hLf1vbCtWSMRkboP4t+Rx
 VKl5/HWL15aCyeEA+7NNO1cHuKc77M41Wt4aICm9oq5NmUYu9hXP/fWnRpst4uL0l7dS
 /+A4XQ6lqfIAJtAnvVHa6X8Dss2gj/oUHZgzTn7dgo++zNLZg2RivHHxuRkyiNhl59pv
 6svQ81QxDbjzpG9+gn29MnXYZDWhay4m2qBD1TNURMfcDub0VYqHpf8XnXlzoKsydP8P
 HQEQNIeqQARs64yk/fKJAPj+eCS9XPdjcp6Ln3PlZzshxs/EEgrEHUMjEyWhphJcnWf8
 9aFw==
X-Gm-Message-State: AOJu0YyUownv4q7n5JZUoHIt3JbXCA/cVz8RHtCAal7XhowS0njQHzKu
 DWlwKPms9VTUvah5tI2qVcEUvHIZdCBD/Y0Q3XWN6x24PevF7RImd8LXQiH6hfiMZyiP2EGfNmU
 tuNnw
X-Gm-Gg: Acq92OGA8vvvkekm9o3lnxe5jRmxhmnos5dygl+pkCrZWvmWf9dEKdElc1YXb/7mWwD
 018KJc6+7+zq04qP34s812DY6RVyVSjOtUmZT4WVlNbwIO5pKejlHC4AIweLbbTv/Dj+9scphLC
 u5Ii3ST2JERpbZsRRTNxrzIDqvRTaT3OVEBGoo6sq8lBeb6LBT8oGS7qFUCCDWiokBJgRwf3s4J
 /EaoZM63yYpnBoIl1oIxg06fI01w+RyI4J/myeWzaaXELnXntZUdXCsafVKm5pkdivieUDvYzIo
 abJK/Nu0wq8HlbUHyn5mpQQeCNDe8wH+eZVy3qtXBSlhOLJ8ejvcLqW7MQRIk2Lyv9YyAocUsuD
 ORsCQwM9J+RUHCs88YG5GqYJcMfbeo5cFcEvZfbwcRrENjZP+XM3PnP3Sm7GiCEu3odnqhco9W9
 J6zs+XWBOA3nJaSPQsbP9FajLibgjRvJFo0xsP
X-Received: by 2002:a05:6a00:4094:b0:837:8b75:a5ac with SMTP id
 d2e1a72fcca58-83f33d8860emr9539257b3a.34.1778954623831; 
 Sat, 16 May 2026 11:03:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f196638d0sm11856627b3a.7.2026.05.16.11.03.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2026 11:03:43 -0700 (PDT)
Message-ID: <77790d9b-b710-4ebb-ba61-1b4cffe48b11@linaro.org>
Date: Sat, 16 May 2026 11:03:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/arm: GICv5 cpuif: Fix overflow in left shift
To: qemu-devel@nongnu.org
References: <20260512093856.3197700-1-peter.maydell@linaro.org>
 <20260512093856.3197700-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512093856.3197700-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 5/12/26 02:38, Peter Maydell wrote:
> Coverity points out that we forgot the "ULL" suffix when shifting 1
> right by a bitcount in various places, so for bit counts above 31 we
> end up shifting off the end of the word.  Fix the three problems
> Coverity noticed and one more of the same kind that it didn't.
> 
> CID: 1659588, 1659591, 1659559
> Fixes: ce245ac6957 ("target/arm: GICv5 cpuif: Calculate the highest priority PPI")
> Fixes: 3f79212abae ("target/arm: GICv5 cpuif: Implement GICR CDIA command")
> Fixes: 49f4c98648c ("target/arm: GICv5 cpuif: Implement GIC CDDI")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/gicv5-cpuif.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

