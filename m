Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6741C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 21:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsphf-0006Iv-C9; Thu, 13 Mar 2025 17:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsphY-0006DE-8n
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 17:02:48 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsphW-0006eK-C2
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 17:02:48 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-223fb0f619dso28316105ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899764; x=1742504564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YnCv1vVdkV17XDZki66o2ESkY2b3Wvg8ybCcz+yRqAc=;
 b=AypbFqCxVaHH9AKMRDNAVsIrDIWMtzy+NSfWuxZ6jpue1S25+CXxZgiuEVsIBBW/T6
 AgHfIB8+E6AHhzazHqFj06qu7Qh+oeAsVo2TyUTAYjcOq9BvLFYNfnoluDzhTIleQ6KP
 EPMSx9ZimeUQnrc4AuhjtZPPjVScW+7a2fnSH0QSO3DHNqpzZcZdj6klSZ1a0ziFCFeN
 xQr9VXy8EtHHJGFaPbfPqa2sMPDzM8a73Nq4st3zeBC3/LZpxbQ/ioqpv/WVb2eH4tHn
 IXNrwIObCoNX0/z7F8jqP/TfFR0qY0eNKeiI1ImlgHMLvZSnvxMTE8GM8h89meEL3xPa
 5Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899764; x=1742504564;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YnCv1vVdkV17XDZki66o2ESkY2b3Wvg8ybCcz+yRqAc=;
 b=aTxjo06fhoM04gJhobn9sGueFZlGUGbCblmS8j2GLw5XE05sxeySH/h/kxGFXtIN+F
 cCLWoDj2rvwf9buqpAboNGqweaf/1f8TquWzFC1h3spqaU4nW8SINy1GcXdVe8mOLc83
 PiZnf3ML8SsTEKdiyC4q2Qk0PcSFqF0IRguR7TGJzQM2tTQ6lfOHHLCQHzbrl5LRJJjQ
 4CKn7qCmIkMTs1eeMBOyGW3/9Ko1kYcxq2BI3uxoTo+2CNNFH7mcduUaS6b6ebB8AKkC
 VlbIvRzSa83z42oLM3ybHOg6DCbM5bKrAay4E7iibw0oZHZRpw/gKz7Xx7Xka9caSPH8
 1b9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY2nAr7NS+/HyDFgLZj69Pqm0taRsqI0n1NRUXvuoj2m0McpBDDLx1AQgbSsnem1uGu1a3lYSdZtNP@nongnu.org
X-Gm-Message-State: AOJu0YwwnnZB3bmNwyCnWvUlohcZIqLhaGKFopwHtS7PoD/0lLRM9TXj
 uZxDlIgKPcZUF5N4kHHpujlj6FntEJLN47wbcwgUa+7KkLA/8XYkIh+lTgtuYjw=
X-Gm-Gg: ASbGnctN24h+EApCTieC3VOsf6i48WTb1BKLjyn1ufx4O6KuZCtBjIh+LDrfS1QKt+D
 CfV2dOeTq0T6QkuqnXSunyGaPnl1garNc3vN7EIxaJXKpF/pMHvSlrEsOl/unDIs3PTak+jkx3n
 jinjB6GYEAoipOgKpi96ds88dPIgMR/EGWzDJ2O8H6gR4FyipCDa2t/AScEGPVuRRWQu56Xb5eV
 36OhkD+8/DztViptoeyxo7Kda1WFce5w/ySaw6mnQWUsh29qwG6IvXv5/bZ64AUhbGAHPnnfMAy
 87mYNbZ+NjiuitoC4URAgxTjfc1Gbwr+217iOzU8amd0wZXPrJZroaOOpw==
X-Google-Smtp-Source: AGHT+IEeCC6hSF8wx1h/bblmMJN/xv98OfApkd5LtJlcW+gxBwvKarAXCZ8Xhv9vu6wAz+w5xTOeQQ==
X-Received: by 2002:a05:6a00:2314:b0:736:65c9:9187 with SMTP id
 d2e1a72fcca58-737201550demr649765b3a.9.1741899763858; 
 Thu, 13 Mar 2025 14:02:43 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695b4bsm1847501b3a.149.2025.03.13.14.02.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 14:02:43 -0700 (PDT)
Message-ID: <c87d3709-a547-4679-8743-cb09a39f41fd@linaro.org>
Date: Thu, 13 Mar 2025 14:02:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/37] include/system: Remove ifndef CONFIG_USER_ONLY
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-35-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/12/25 20:45, Richard Henderson wrote:
> This is include/system, so CONFIG_USER_ONLY will never be true.
> 

Some build configurations have this symbol missing.
https://github.com/pbo-linaro/qemu-ci/actions/runs/13826820446

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/system/cpu-timers.h | 2 +-
>   include/system/qtest.h      | 2 --
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/system/cpu-timers.h b/include/system/cpu-timers.h
> index 64ae54f6d6..f10cb5e7d4 100644
> --- a/include/system/cpu-timers.h
> +++ b/include/system/cpu-timers.h
> @@ -30,7 +30,7 @@ typedef enum {
>       ICOUNT_ADAPTATIVE,
>   } ICountMode;
>   
> -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> +#ifdef CONFIG_TCG
>   extern ICountMode use_icount;
>   #define icount_enabled() (use_icount)
>   #else
> diff --git a/include/system/qtest.h b/include/system/qtest.h
> index 6ddddc501b..84b1f8c6ee 100644
> --- a/include/system/qtest.h
> +++ b/include/system/qtest.h
> @@ -23,7 +23,6 @@ static inline bool qtest_enabled(void)
>       return qtest_allowed;
>   }
>   
> -#ifndef CONFIG_USER_ONLY
>   void G_GNUC_PRINTF(2, 3) qtest_sendf(CharBackend *chr, const char *fmt, ...);
>   void qtest_set_command_cb(bool (*pc_cb)(CharBackend *chr, gchar **words));
>   bool qtest_driver(void);
> @@ -33,6 +32,5 @@ void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **
>   void qtest_server_set_send_handler(void (*send)(void *, const char *),
>                                    void *opaque);
>   void qtest_server_inproc_recv(void *opaque, const char *buf);
> -#endif
>   
>   #endif


