Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADF4C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9WDR-0001cH-C1; Mon, 28 Apr 2025 17:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WDF-0001Vz-4W
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:40:30 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WDA-0004yN-Kc
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:40:26 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3054ef26da3so4770273a91.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 14:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745876423; x=1746481223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gn6cJJeZJWFJKAlBBzJnSRHtlX+o+mz9Z4x7v2k+v/o=;
 b=evip+8oOcDjYTfM30Z8YyUgFmJWBuCe8OgSdKhwDXCIKiHSQLnf5olkacpElQUfucL
 Og/BrwDAMzzD3Kvhw99kDJPdO1mCB+26wIInJ3u/q34UZBy1Zpm9sS9XuRiEmIrdqQVY
 oMUaFR+ro1MI9Vhp57FqMegfvVqJlc0RPjbWwnjcJJWwRaFm8g1U5NW6qGQcNBLawQg+
 O/oQ1QqRVbvfRLq9rNcfnMjx8vk5veULlQeRaeFJDjIDYH+2oQpogIa18qI4haP1ROLg
 cgdGdb0Bw7sZeEyE7ewoAQbBMVXqTRu5lU4FIeA7uXZ6lNVx0d6hTlz6aanYXFcYLt/g
 fvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876423; x=1746481223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gn6cJJeZJWFJKAlBBzJnSRHtlX+o+mz9Z4x7v2k+v/o=;
 b=LQWmF+7aeZcMlEYpqJJtiWQ6bHk+WcQ8/RKE/tcIcWJJ5CJ7lCFWNha8vsTUZN5rzE
 8JrhpydatCDtAAYG9QHRfTAQ+GOG0zkPIuYA4AY3MnNiqhalLckJBajTztPKNabCoPGd
 QdvChItB6GNygxj7+0CeTuqn6SDVjf0kn513ZvXq4VSlEWIiY+iHTQQY2apHYvyyH9VF
 2oF6HZXNDqSTCpeuUIO2986j8JnDETD+VHecKC4AOqzMY3t00GMFoK7PDxy6jgkF5kZG
 XwW3Xbq60ClBrPr6HoPV1DWyxNbA3XL7FyEpZk3OCvrYCyR8iS3+KfvhWtbhcZU89yhk
 yS+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxRfkZpDD1Di3nDCR71qvnHeqKWkMIU6+BZIf4INTr4iwDuZEa0K6pjK9QpiP+3u4+4/LCAJKnjTrr@nongnu.org
X-Gm-Message-State: AOJu0YxQd0YRbG4kcRwJgwDOrqeKcs+cwDkKQmtAzZF0gtK0nbTr7FPY
 /s/mM/LOQZZE3HWVCzMyQtuJmP+HdwP6w8XXJ69hflOogZHAlHJL8sfiIbL/uojNaI5dd2SGT1+
 Y
X-Gm-Gg: ASbGnct+KNViwSDOu1xaomTjkJqsOhuF9h21FGgBnoZtzR6vr5ea0HIV0PSlgo+st2b
 aWLF3UIe0VhExVaq92hklwVPyYQlPlSu8lFI/g8du19CeyuUfHhf2LLBFRFmhx/Fkhqp6QonQ9Q
 bcz1T3gWoAfCw214m3vCHP1SVrh1yUKbTb9QJZfkM766J2VQsSdEzz0OY51Qmp7GvkSIzJA8Bwy
 ujzsMMzRiefY3yagcABCsb/6ncnrqjOj59mN6w62XNnCZpj40wmih4h1pmMlK0Uc4fTUrnRKMeg
 AzifAJXiFng6UqXfu4X3tleIQsmWR+UZCWIqIiklEHaUwMKGzKPUGg==
X-Google-Smtp-Source: AGHT+IF2Ui9IEuVayYF8R71r5e802K80ddR2Hiba/9l69FDZrC3PGfNyRLdihFsNbDD/r/Jat56s0g==
X-Received: by 2002:a17:90b:17c9:b0:2ff:6ac2:c5a6 with SMTP id
 98e67ed59e1d1-30a2214b44fmr1048565a91.31.1745876423026; 
 Mon, 28 Apr 2025 14:40:23 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef1246c1sm9581170a91.33.2025.04.28.14.40.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 14:40:22 -0700 (PDT)
Message-ID: <cce0b453-4a5f-46a7-83cd-f7a547a3e1d7@linaro.org>
Date: Mon, 28 Apr 2025 14:40:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] target/i386: Split out x86_cpu_exec_reset
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250428201028.1699157-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

On 4/28/25 1:10 PM, Richard Henderson wrote:
> Note that target/i386/cpu.h defines CPU_INTERRUPT_INIT
> as CPU_INTERRUPT_RESET.  Therefore we can handle the
> #if TARGET_I386 block in cpu_handle_interrupt with the
> new TCGCPUOps.cpu_exec_reset hook.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cpu-exec.c      | 39 ++++++++++++++-------------------------
>   target/i386/tcg/tcg-cpu.c | 11 ++++++++++-
>   2 files changed, 24 insertions(+), 26 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


