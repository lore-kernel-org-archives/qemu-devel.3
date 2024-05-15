Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FF2C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7EBX-00056m-3U; Wed, 15 May 2024 08:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7EBU-0004rb-Go
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:56:41 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7EBS-0001SG-6B
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:56:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41ffad2426eso51608255e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715777795; x=1716382595; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UDYhJdm0vOY3TJHzDuhWkM+vb21XWozE1YskLKf5dDk=;
 b=wtE1/NqNdqPrK5798oR91ARHObDZDHVjAFtBH83tTzmzOez3Y5RDwvflGDfoy9onkH
 beA5TMGsjDWoGPdmf/aZRfq7JnU9VQ4MB/Qtd18PwvrfZfWG8nr9Xw8T4V1uEAgxIXRD
 Lnm3JOM4bwdccAAi3al7ADOSgugJQ7XGRWMrSNtPQTZDdCtLwbBwj2fEEBizja9HnBxZ
 CClxiEnOYtBRJUb6Fnh1qkMP7D5tkNekqSEAvSAmsZIW48TVpsv5ChQEKWnnZXF5Ehgy
 BRzDlc9t6uaotaO2BLncACP5nPbcVrmnkjJYRyb+NpGNQx5JNPfkoihqTHtNI86lWxUP
 KpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715777795; x=1716382595;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UDYhJdm0vOY3TJHzDuhWkM+vb21XWozE1YskLKf5dDk=;
 b=R7fCIKfVeFkmJkbZV+W3fAONwEnJfjdIIfmpUFmCjeV8NccbIB0VuN9l5edKV+Gx7w
 UCq5jo7NPfZtN/gFg3+nxQh8j8pWc9f0mhansLDVdeOM5Mf/cTY2J9RZD4OEder7eI3x
 OEdAEBJFHKKIujriY304w2v6sqppdc9PME+phM3vJ4B6BbKJXWwEx8lBwO45HoOBpZQz
 dWxcF5YhYEQI1f1l5dSIhH792zDDf07OyP28WVIQ7fidFb8ndeEr9Z4r7OA0hWSm/l2y
 uUPQFxDC6tD1cMwMOyV3BUwNbfUeEdF2VZE6x2PJ6jSGVhRwOWbFd9ss/vCmUW4XsvZi
 +zTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVklBB5makE8l573bSOFXPIusEjgJ4SrDhL1koQbvCPlHlxZz3RjnfBGHX4Pk4nEknWqVd0BMB3XZxt3HNJU3tV+EUq04=
X-Gm-Message-State: AOJu0Yw9h0HUPk3gWXmtHcHeZ0v07vGGscsyOtXkqWKNU5p6cbtNJaWQ
 h0QDjU0llYBZg0RUkYkEAdXN2OyFx6ZxUSLcFWesST5iSTqc9bvUY+kai6ulZVs=
X-Google-Smtp-Source: AGHT+IErXOF/K+2h9qo/RH+f8k85no3rxEvpqJMpTwzuUf5EK2YmXIRrwoJn6yWxGwxX26lCcKqScQ==
X-Received: by 2002:a05:600c:4f04:b0:420:1508:f0ae with SMTP id
 5b1f17b1804b1-4201508f2edmr89127945e9.10.1715777794824; 
 Wed, 15 May 2024 05:56:34 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccbe8f74sm234573365e9.8.2024.05.15.05.56.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 05:56:34 -0700 (PDT)
Message-ID: <62e1798f-a078-4566-a965-95a89625e4e0@linaro.org>
Date: Wed, 15 May 2024 14:56:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] Use bool for reginfo_is_eq
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-14-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240511115400.7587-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 11/5/24 13:53, Richard Henderson wrote:
> The function result is more naturally boolean.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   risu.h                     |  4 ++--
>   risu_reginfo_aarch64.c     |  4 ++--
>   risu_reginfo_arm.c         |  4 ++--
>   risu_reginfo_i386.c        |  4 ++--
>   risu_reginfo_loongarch64.c |  4 ++--
>   risu_reginfo_m68k.c        | 16 ++++++++--------
>   risu_reginfo_ppc64.c       |  4 ++--
>   risu_reginfo_s390x.c       |  4 ++--
>   8 files changed, 22 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


