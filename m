Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D4CC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 21:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgAZC-0008SH-Bn; Fri, 01 Mar 2024 16:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgAZ8-0008N1-ME
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 16:37:15 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgAZ5-0004Sd-AF
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 16:37:13 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dc1ff58fe4so22808625ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 13:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709329028; x=1709933828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q5GiP80IalSN5F7eFL1OJ19Krnw4i3TpXLYxT0jJhPU=;
 b=J37cVQq+cxbhwasccpQ42gY6mgk4Zt8yLGQLy0AisizK783g9eOidVDnp2Jm2sC3r7
 x+mbHpS7DZbEvRkUi4pC0Km7RBWhBG59sVfO5JslRXtR0BXF5DCh8jGSeIi4x5/siqz1
 Z1ZPUWnB4mHQaeTSmZXS5QEINDi7+sNDOp6nT6SXBCKR+ZukqaSAPF2J2tn9yneNlNNK
 nIC3+sfbkWALRNPB36za76KPC33ACT1x3wuOgKguIJBhnKP0PrFYugbxYJ/nu7upaL8D
 jWgQoUCUf6eP6SoEqlnqpygOanNM3ti3xKu5sywequrIJxV+nkVJrnkHV6ubOm9rZqtm
 NltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709329028; x=1709933828;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q5GiP80IalSN5F7eFL1OJ19Krnw4i3TpXLYxT0jJhPU=;
 b=QDfXNNnLk5PjnyhLGBE2NLmJZKzUovXvCLBRNNFm9/CaA9oBr8nIJ685GiTBUkXbPV
 SVPmkB9VpIJ7DmkHWgt7RbKJ+1ht6EQrJW78Xb65YFdUPkjps5hYOH90oUZUv33M9WDq
 b32cpYKkz/p1xn10mK5TpQhFW96e5GZ57GpfHn30mEdBSUxizOdRvq/N6BDU+Lo4oejK
 H6gixiZmN+tz6i4i1XPqY86ZLaHAzJsGBRGF7zsDfDtddpQnKX/ADeTAUWbg0NP9TUr+
 +aiEvECVDIPHXQ77lJwHf/o985NqkveYZxPMKXZ0aDz28LD1WtHcP1ItbDEYkBEe1ibW
 Kppw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbk/4yKipV5R0Q8x26z9H0aCaK9BMUb0dSSTVkW31oKrnYXzhgv3BpSLbpUNjI/4hyZcbKQP4dNIaCV3upPTjogfkyzC4=
X-Gm-Message-State: AOJu0YwWcWQsOGBGLXhms7XAW2FE5ARjMqS78vzFLZSCoXpKG4SYMyyN
 /JjCugg2rcS39R4WCb38t2wAAHH0s8VAnt/QB+jFhiUhBrIy+KLIRGzQZEOOsmo=
X-Google-Smtp-Source: AGHT+IEStfGXaSZ12ttvrD90FfOefhWPA0Cij39i1gPWPq0q5xLK4dlr+gIqhWZoj50vKmspFy31WA==
X-Received: by 2002:a17:902:e785:b0:1da:190c:3481 with SMTP id
 cp5-20020a170902e78500b001da190c3481mr2642517plb.34.1709329028252; 
 Fri, 01 Mar 2024 13:37:08 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 le13-20020a170902fb0d00b001dbcf653024sm3932680plb.293.2024.03.01.13.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 13:37:07 -0800 (PST)
Message-ID: <33667149-6f6f-4ca0-aa51-96d3a397ef89@linaro.org>
Date: Fri, 1 Mar 2024 11:37:04 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] target/arm: Implement new FEAT_ECV trap bits
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
 <20240301183219.2424889-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240301183219.2424889-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/1/24 08:32, Peter Maydell wrote:
> The functionality defined by ID_AA64MMFR0_EL1.ECV == 1 is:
>   * four new trap bits for various counter and timer registers
>   * the CNTHCTL_EL2.EVNTIS and CNTKCTL_EL1.EVNTIS bits which control
>     scaling of the event stream. This is a no-op for us, because we don't
>     implement the event stream (our WFE is a NOP): all we need to do is
>     allow CNTHCTL_EL2.ENVTIS to be read and written.
>   * extensions to PMSCR_EL1.PCT, PMSCR_EL2.PCT, TRFCR_EL1.TS and
>     TRFCR_EL2.TS: these are all no-ops for us, because we don't implement
>     FEAT_SPE or FEAT_TRF.
>   * new registers CNTPCTSS_EL0 and NCTVCTSS_EL0 which are
>     "self-sychronizing" views of the CNTPCT_EL0 and CNTVCT_EL0, meaning
>     that no barriers are needed around their accesses. For us these
>     are just the same as the normal views, because all our sysregs are
>     inherently self-sychronizing.
> 
> In this commit we implement the trap handling and permit the new
> CNTHCTL_EL2 bits to be written.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu-features.h |  5 ++++
>   target/arm/helper.c       | 51 +++++++++++++++++++++++++++++++++++----
>   2 files changed, 51 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

