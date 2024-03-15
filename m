Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44893C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 06:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl1HW-0002BH-5L; Fri, 15 Mar 2024 02:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rl1HU-0002AW-1y
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 02:43:04 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rl1HR-0005Ne-8B
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 02:43:03 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e6b5831bc8so1769434b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 23:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710484976; x=1711089776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dWdlKqM9eUib6PnBU9BEHUH4tP+pJNByaXChBbFYYj0=;
 b=UY5ihcoBVWAmXSVMhHCPbTxVTjxcZbqb1E9XtKlhQ9+kFRdZCRPhW/kr8BH4kHdF+u
 VvbrQbcCk+XEKN/kC9/S1WwAAuv3/DfdKNKdg/G1ljdR+EuxZNIJXkheMJ7RVuPIp46H
 MdciMoVv95Po7jmN+g0JXxeDvppdVwpbLyV+nbSdvw584/VIepzzdx5+f5UVZVsOMUqb
 J73sFkrFRrhF5PZ/n5+xAVC9qU3+MG8hcVqfFluc7Pg8GfWM6Z1+wZRBWuvLperg7lnu
 Thj37h+mgZvrFyyEH3coFkDN+Gsc55G/Z+cHDp/ggI8KQYlNOKEIlJ/4pN+2SuckfZJX
 Y+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710484976; x=1711089776;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dWdlKqM9eUib6PnBU9BEHUH4tP+pJNByaXChBbFYYj0=;
 b=mWZsO8GGSqxg01X6ze3Td5jyBAwYoE9VyvNSRpxHByCvmA1lANRt7V9Nzba6j9sZng
 2DS9ighBD8U0yXz/r0SEe82Dib3gtGO5cEfjENb9TWOmHcicUSn/A5xKF3ePtIuq4BmQ
 BOJZyZqp6c/jPE806S3r9E9yMWOE5FqfvXZZcv4w3HOftV/e4QToQO5pcaEcfHkMIhKt
 I24pJ5xtMDMpTri0DQ6+1/PC23boNdnoKP4dY6Xg3gPCRqKGxG1EEZCnSZPTNUAy26aX
 2OrrZgJ+WrUjAX23HZspkBIc/SWoMPQSwKjyq+ZRNINLEs/ro/zDNkl8THA3uSAyrCBj
 NN9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg1bjBVU8bqMaF6b9mVXKFW18moB5c31o2RQvth1nb8tIc/x6XAWtXTxDto9AhcrFmr+qC81Gr/ep4b66PKfdR8qhmA5M=
X-Gm-Message-State: AOJu0Yx+WbjllfZ6r1q6dQGKt/zAwh+FCgkMaXVR0L9ZlMDUVT8ZexG3
 KWr08Fy2L+p2EepYxke1wZcikzDobzfTifPDXsArOjnG+Vr2CIYzsadR18uO3Xw=
X-Google-Smtp-Source: AGHT+IHiGhcZ9b4J+7XrKMN6zVfuPSuljNxom8OYI9sJ9aiLyadQG4SPt37ZNQscQHC0I18INU/YeA==
X-Received: by 2002:a05:6a00:2da0:b0:6e6:2999:e61c with SMTP id
 fb32-20020a056a002da000b006e62999e61cmr4982652pfb.17.1710484976629; 
 Thu, 14 Mar 2024 23:42:56 -0700 (PDT)
Received: from [192.168.0.227] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 g20-20020a63dd54000000b005ce998b9391sm1785164pgj.67.2024.03.14.23.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 23:42:56 -0700 (PDT)
Message-ID: <d0d771ad-b4f6-4c6e-a8f7-e566a33ca006@linaro.org>
Date: Thu, 14 Mar 2024 20:42:53 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? 02/12] travis-ci: Rename SOFTMMU -> SYSTEM
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240313213339.82071-1-philmd@linaro.org>
 <20240313213339.82071-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313213339.82071-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 3/13/24 11:33, Philippe Mathieu-Daudé wrote:
> Since we*might*  have user emulation with softmmu,
> rename MAIN_SOFTMMU_TARGETS as MAIN_SYSTEM_TARGETS
> to express 'system emulation targets'.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   .travis.yml | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

