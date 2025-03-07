Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674C8C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd8E-0000tQ-1P; Fri, 07 Mar 2025 14:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd8B-0000qB-43
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:13:11 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd89-00064j-CC
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:13:10 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2239aa5da08so37363175ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374784; x=1741979584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ycwJnngFT+7MZtRgIoPSjdNnE8Qs8pL9DccRjkAY2rI=;
 b=FC4+/L/lc/gIchl7cOTDWABh8qlhqyi/acBOjXTTQsvc7/Z845zIKw52zlJqfLy6Ey
 zsmVuxz3Wsf7wVcYSNCAN613auwPedOC/gFEIZhuyx1Tz/530CXwGfd6NJ4DeGp4wcXl
 apogDWb25FLZKTGQaYfDVD8fceugvijW5eIeagOoTeZXBAQxlKo0Of3Ut59H3hQkuwCT
 clxpC95eILh1LTC2447O2Kikyw8Ior8vRd7mg2vOTYo/0UahTzH9P6y0knRAT7c3KIwf
 A57eSvS8pmo5WmlQK+yFcS/K1nNjrJUgKqEDuJryUbkTwRZaYjHjNDuSjYMkispio3aq
 DIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374784; x=1741979584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ycwJnngFT+7MZtRgIoPSjdNnE8Qs8pL9DccRjkAY2rI=;
 b=mEEYt6Dh7fNSGAIRFwD+3TL2GK9U3tAppiuTbh6WGRH+/kvWfd8QsLtu2zojga3l+T
 20YFqIqM9meZulnY7j9/tuXiN0nXsANmjBVMP/tEOl80I56PTDAhQf1Qzbiai5cfpK4Q
 EIm1l79XoKPuByKreDVRh5XqaSOPcwtOwJDA2AAXgGqAPKIbVRKAZaQFUm3ZHDVuCM10
 zYR3doKHo6JPfgHmMuAAxDzSwVX1Hfzlc0L4UBoANfYY2/g5Nn+g9RddnH/MG9oZsDFf
 G5abpuRsYmmN7Y9WXLMZ+QlsCKSOf6Am0wQsq6mC2M9vBl365kQzEpU5kgNAJQK8ZxbP
 odkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKzT813Z1d6ahmzpWp+yLZG56TfLGtXjby9OQazV5K4d6aZPZzdE8FVD3zCmdTJv9eu2ANzwnbGjrz@nongnu.org
X-Gm-Message-State: AOJu0Ywv/EoiW1mudQ8C+/ncOKmkbMiREGX4q/iOcH173yLYE4bwg5ko
 v4C+uGiR+BIZIlO/GloboWlTsozuz3tDKkBoDX5mls3Na0beHJXH6Y1afiiK4gY=
X-Gm-Gg: ASbGncv+RqEUhwK4efG/ho+jClt8SVyzXeGTXQxqW8cVd2fhdqUE9RL9jo5sSKsvXIJ
 ScMpTnR/hta7VCMKpqc/d213qX63uEPKeI0ETxpC/d7AKsRyftMaTHykMIejoj1Ui3xVDs8RKOA
 5aHzjM1ZHgZL6MgJxYKd08kxm8Bi7RQmLjuj7o/E4KxefaYKWAOMU8y2BeBPlkVnD8J71f7XhY4
 jogsF1I2RROfHN5OVzQ7GwVAaJbJba+B+5U/9ho2WWbt5eWzUt+l4nI1CuzHIlCzaEdZR0Vm6SL
 a5a3VpM3bijLnXF3EnEReq17xK4UmP6oxIT8VosK7qDOrj+9bKdVojH70A==
X-Google-Smtp-Source: AGHT+IH37r53+wtd5mKoLBlfLSg2RyYDeHd6D3Iw6QUz6NR/NcFzVBPAvTzWQTNvEmGcrSxa7oMmQg==
X-Received: by 2002:a17:902:ce0a:b0:223:37ec:63d3 with SMTP id
 d9443c01a7336-2242889b359mr61260755ad.18.1741374784083; 
 Fri, 07 Mar 2025 11:13:04 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73698206e95sm3738956b3a.18.2025.03.07.11.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:13:03 -0800 (PST)
Message-ID: <a2d5bc7b-5722-451e-8fdb-0b21f388373b@linaro.org>
Date: Fri, 7 Mar 2025 11:13:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] accel/tcg: Build tcg-accel-ops.c once
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307185645.970034-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/7/25 10:56, Richard Henderson wrote:
> Now that tcg-accel-ops.c uses cputlb.h instead of exec-all.h,
> it can be built once.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index 979ce90eb0..70ada21f42 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -20,7 +20,6 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
>   
>   specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
>     'cputlb.c',
> -  'tcg-accel-ops.c',
>     'tcg-accel-ops-mttcg.c',
>     'tcg-accel-ops-icount.c',
>     'tcg-accel-ops-rr.c',
> @@ -29,5 +28,6 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
>   system_ss.add(when: ['CONFIG_TCG'], if_true: files(
>     'icount-common.c',
>     'monitor.c',
> +  'tcg-accel-ops.c',
>     'watchpoint.c',
>   ))

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


