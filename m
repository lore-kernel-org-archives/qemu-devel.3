Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D49CCD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtiKo-0003eb-2x; Mon, 08 Apr 2024 02:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiKm-0003O3-1r
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:18:24 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiKk-0007L0-58
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:18:23 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e1baf0380so4404535a12.3
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 23:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712557099; x=1713161899; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RSz/bbwofYl8koEtD5rjk3a44YqnQg5S+o0qyBDryo0=;
 b=SdPgu3jmifi6DSXx4ZyxitzzpQLS7f8TJWdQeNlTbbyfVIYVOTmosfMYMI97nAbvJR
 IlL3cEBclW4I4blJ0hVK9apkpJZ6b2/3nDMWLhNIiR+SXYzugVhy6f5RH0Dgv9Pc9I4Q
 SqKbsBp/usCSG1ZxeD3ZsVWcYNwz9gKBBf7nTXANnlP5k3+X8sX4M3uDfz+t6yz6Gl9F
 NnZsvkAH7T3SNuWFkBqctUN1mwZXhhZvBFJbB/qeOObPnDiOia3fEQJio6POSnooKtDM
 rYWe/MVSHG0Jd0h8EN+iLj+ZDR4EYOuAkveJNfh5vDZSY3NIu8bXEbsU2B/HIPV5ZIKi
 EqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712557099; x=1713161899;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RSz/bbwofYl8koEtD5rjk3a44YqnQg5S+o0qyBDryo0=;
 b=vhEtkTf5BT/YuMqVYpJTEWWgMFGoXc5FKDuBf8diV8I5UPSTL3Wywea7dIRckyPr2U
 m86S5BjrU13YeYid3MdooehcHXPAqjyzWwoACUq5R7pws6PUpwz1CMT0kZdg3/2MwMJM
 mISUtv9pX6lUfRXS77tkpWI6CqDXOoUukJFtl/Z2uWaRwXgXjnh+QiRb9imOiyF+ZCO1
 3NqZhKjCku1QhGJWu4VjZi0ipunhyTU2pE2H6+J0yGr6zfefHh3kB+jrZQJ4P6C42h96
 4EA6qzeKfpcdoCzywMTGH/RnHToUYdGLKGh78B9bMmxAS7NAhgjRWKeeHwdigEmTz00G
 6grw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgSvTX0APiKwiSMJLAsdpEQHel9+UbKf2R4RXG5xK5Ip/N8qaWSmOCI+EWD8g2VHdcI8zd6d9zNCNfHG7k3Qm9oJyAOlg=
X-Gm-Message-State: AOJu0YzPMGsRcKeHOytxH5Q+FTX1Ge+m8Q/IkiE9D2tQyqkhk8kK1JRx
 ry0orhuPlnb50LR+tWfOBXtnOw0KS0ABqsNnKNlt0krl1rbsxY7RVNiGMlJZVOU=
X-Google-Smtp-Source: AGHT+IETS8WZKmRrI77KEzZDdSBPY7aYd9ZsTXNHdLJrXwem3diozYwBpsJ+OHfjGt/LGy1PLEKSeQ==
X-Received: by 2002:a17:906:fd89:b0:a51:b917:3036 with SMTP id
 xa9-20020a170906fd8900b00a51b9173036mr3932065ejb.17.1712557099667; 
 Sun, 07 Apr 2024 23:18:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 sa2-20020a1709076d0200b00a474ef94fddsm3991001ejc.70.2024.04.07.23.18.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Apr 2024 23:18:19 -0700 (PDT)
Message-ID: <21f16b2d-3c87-4f43-adf2-3f07b23f5c40@linaro.org>
Date: Mon, 8 Apr 2024 08:18:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] accel/tcg: Add insn_start to DisasContextBase
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 7/4/24 00:32, Richard Henderson wrote:
> This is currently target-specific for many; begin making it
> target independent.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h | 3 +++
>   accel/tcg/translator.c    | 2 ++
>   2 files changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


