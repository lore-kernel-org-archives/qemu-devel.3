Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E33C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 22:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXToq-0000Qx-Cw; Tue, 06 Feb 2024 17:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXTon-0000QP-6f
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:21:29 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXTol-0004mH-EN
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:21:28 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e05b72fd56so17293b3a.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 14:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707258085; x=1707862885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tz3YkQkdu+Ipsvb/V1NtvBWEUdROxzeJq2B3ecyGZiE=;
 b=ojhXJzC7fQMczVtE3mptsIHRar9OZkbOUafDJtVGRcjwEs3A6+sGQnNsqrTmpWd+7e
 pTS6fhotQTloic+uVycVXqVJG+zEbeL/eW8BAK3waspp+tkdSiEMNMCcOc6OHH3VeXTy
 S6HRm8q3PDsov8lS+aQiPMluKnlqK1ALNZcmleLuPf7yNhBlHqXylaoNq8y5dgydzGhU
 scJUXwuFKm/b+0glnEV9SuoiecU8vN3PPrbkPGeuiZWX6wPTiHgNy8NMs8Fgc0fez9/w
 g0RPajxmr950fvVej1+oLGV38YT4F6bt3puThU+ueUxavAI7d36LteKzAGWosCMkmisj
 Lh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707258085; x=1707862885;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tz3YkQkdu+Ipsvb/V1NtvBWEUdROxzeJq2B3ecyGZiE=;
 b=qxM7W8uqANJprEkZcR40KKRG1aRuboVn0BTov8/F2unGaDT3nOQcWYyCfuU+J+7P2F
 kb/lig68lqbYByB6eBpcqcESjBnDOlP2RouEIaz/ILiG3rPGYfTUOajXGkPTZo5eYD11
 ELAnrxxFlAhazERH/1ERf6xReELHNxgXK+1Jcg+j+6RTowuRxtRZOyPsInqWQU9Atz5B
 mz8C+t4+1UcDfbob3/YIm7sQTcl6NB86mdUK0LbqLk1bIqhCq6yb+NY849o4SDOb4mWk
 s/k0j7S/Yy6LXmTK8utM7KDF/Ew8GdKIdVSNMQb/lohK4C33JqLFLfZps11cog7J8lUD
 Ng1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2jbhDPndAfcp2eGwoOkGquy24jOz6HrunUe/lAzJIvtcdHOqsrlOhS18nik1KqwrD/pF3SYCagCcmTROR+Wf8PF70MEs=
X-Gm-Message-State: AOJu0Yz8DZ8CnWWUvmlpItDXLWIpVa4fe//5/B7sNNq7RK35tJ/HPG7H
 HV9+28KAtwS/UOyeIYiYVGSCz+OGgOz9A+Qb8HgU/+m54vLo3e84Hq1U1dAu+vQ=
X-Google-Smtp-Source: AGHT+IFTjPb0T9ZJ7xHY+wz49on3xdPXQfM58akQqcuOKJnBTAyoArYmRm+dS+Dnc/b6F/zlinUg5g==
X-Received: by 2002:aa7:84d9:0:b0:6e0:5254:c9f1 with SMTP id
 x25-20020aa784d9000000b006e05254c9f1mr873702pfn.18.1707258085519; 
 Tue, 06 Feb 2024 14:21:25 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU/pEGfbQZsq7sZXVIyt+E5jy+yIh6zWgCPT1+KCRTt1qJFWW0JQXgiqllKTqzaA81SZyJSRYCCzg/y63uHew22WugyHNToI3kaf/UAUQys+LfDSdIgG66hT0k=
Received: from [192.168.0.100] ([43.252.112.200])
 by smtp.gmail.com with ESMTPSA id
 e22-20020a635016000000b005ce998b9391sm2672528pgb.67.2024.02.06.14.21.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 14:21:25 -0800 (PST)
Message-ID: <0b1126e3-3446-447a-9cbd-a646cfdf4049@linaro.org>
Date: Wed, 7 Feb 2024 08:21:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] target/arm: Add Cortex-R52 IMPDEF sysregs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206132931.38376-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/6/24 23:29, Peter Maydell wrote:
> Add the Cortex-R52 IMPDEF sysregs, by defining them here and
> also by enabling the AUXCR feature which defines the ACTLR
> and HACTLR registers. As is our usual practice, we make these
> simple reads-as-zero stubs for now.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/cpu32.c | 108 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 108 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

