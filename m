Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11944C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZxEt-0006rl-HD; Tue, 13 Feb 2024 13:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxEr-0006l0-RJ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:10:37 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxEi-0006qd-6E
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:10:37 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5d8df2edd29so869169a12.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 10:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707847825; x=1708452625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wB6dwLTr4vXlsk6ZK7xil8wKRCgE5z6FfziZ2nKvGGA=;
 b=IBI8KhX+XMHRUFaRlKVc4Ug8oa1daBcX7zu3PzWK1G8cduYL/l8Fc1t1hKz7R6d2w0
 rqgVq9s/FgfYHstOaFmdwa/ucxdeMV7UCRN1IofBZRWxqDCUzOJAbZ+yad5fqcglvQcx
 OZvhxyq/vjiJoQ28fr+kLazkuNVy3f897AQoQypnwb02z5RBcNCOVZ3M7N8Lvq/Tk5LY
 4ZHo4Q0Qd1SBG97fT73fQnHKnhgfSRKEzkNqjvQzYeYEHsB4R+hn/JGuVALfoiNdg46D
 jQ07DP3LIwRCdHsmuAxbXm3EKXyqjZMGY4NZj3/RgwLfhGAHYFHgl3de826KstPEUv9s
 1LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707847825; x=1708452625;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wB6dwLTr4vXlsk6ZK7xil8wKRCgE5z6FfziZ2nKvGGA=;
 b=WDkf8yBAswwFbw/7WU4wg84NuFhyMc+aW1c8QjHmv7AGr8Nga46jqi7tRAGHWKS5c7
 RgBDWsa2UtRxsapXlyrucY7hakvuCdyY8pOf8OWi7b3gO4LWt3AjOEu1qOsPzbd6t51U
 jCIFVCiNw4NRwYVhN0gJvohgbXhWFTwDcmsI9JCM0Cti91kQ0PfyFj8t/gNuLDXocu3f
 /6Q/0pqrO15LeyUfbtCvUUC1rSkO2IJlYvKDS9QDcljurf9ovD8NRCQxzqWL+0iT/TJU
 bDXRHZWNE8xwjhJpZE6UNvA/ULhvOZPmSzLe4vXGBwhWsltc8Vi4q1H63oxlNM+pZRg4
 IVqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPfW4zNjCgzttoB8C53aCzwboyjtpRiw8a3c3OGJQUjic04/wuLIs8Pg3nJVD3uKKMLmPduiXwRJ1H7x2WT7LMNyZdZYE=
X-Gm-Message-State: AOJu0YxqaZiVQFMwz6qz4zw3BXKRs9Ai1osqqLnT+Fzt+qW22NRIJjTW
 HvWH2vQ6scKMzy1TttM2uov2rIHssZxqEt2iDUWcf0e5xtpdsbfcYPc5euiWDYo=
X-Google-Smtp-Source: AGHT+IHCE5F/X5pDPJOHBPFUPp1fHNYHjWy7geog+h9/2WjXq7CCZr7is0vmk+dHMOnLq8qWdnnrdA==
X-Received: by 2002:a05:6a20:c886:b0:19e:89ae:9b52 with SMTP id
 hb6-20020a056a20c88600b0019e89ae9b52mr502167pzb.7.1707847825531; 
 Tue, 13 Feb 2024 10:10:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW8ZC9zFNtDxiDMevgQxP/HMRwy1lnPVwNbIIY81WsX/2RigdVDRjAZKB/XNnw9Vu0Qb4jFEI0x/JxhR63RQComOH+tMPM=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 y15-20020a17090ad70f00b0029652c53a32sm1095051pju.33.2024.02.13.10.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 10:10:25 -0800 (PST)
Message-ID: <e222304f-42a9-4937-8f9d-cd9856b26290@linaro.org>
Date: Tue, 13 Feb 2024 08:10:22 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/18] plugins: add qemu_plugin_num_vcpus function
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
 <20240213094009.150349-3-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213094009.150349-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/12/24 23:39, Pierrick Bouvier wrote:
> We now keep track of how many vcpus were started. This way, a plugin can
> easily query number of any vcpus at any point of execution, which
> unifies user and system mode workflows.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/qemu/qemu-plugin.h   | 3 +++
>   plugins/plugin.h             | 4 ++++
>   plugins/api.c                | 5 +++++
>   plugins/core.c               | 6 ++++++
>   plugins/qemu-plugins.symbols | 1 +
>   5 files changed, 19 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

