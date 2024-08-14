Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1884BC52D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 22:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seMmh-0002oD-N7; Wed, 14 Aug 2024 18:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seMmf-0002m8-78
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:48:01 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seMmd-00084i-Is
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:48:00 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7a0e8b76813so330094a12.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723675678; x=1724280478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ahp+ZOzdGGQJhl5LADPxcjExVcW0vy5FLQfjVrpZKX0=;
 b=DIRvXfjEacRV5cZ3ELu10mMABRwRAHDvO1WjNy5CwFoGFscyOgoz4J7WUqZw0eJo5v
 l8zb66hRYTmuOY6ftUbUV+D6Xt1lOQMPqa9/SeVjojRYJjI5T+bq0OUtDzMt8jfIlemK
 r7xG0BRXXrPILV/OiUoBBmx/Jk0huwnuzcWy0SOwmqD+y0iyWQXAes0eiEtgvj24eB2p
 +j6nvGBUTNhIYB42iEthao82dwUSgdNoA37LBoGWT1I2fBGdFEXKStJffrcOiCPsb/M5
 yRC4r943Z4RvNHn2XrJH59YiEi6Vampwv38/jgXJEMBCjzTMcxFQMCYtnC6d6lEYDKyW
 hRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723675678; x=1724280478;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ahp+ZOzdGGQJhl5LADPxcjExVcW0vy5FLQfjVrpZKX0=;
 b=wfRLHk++wfrPybGGYMwRpNBBrHJoxcClkfbsW86ljH41ShGoeQRfvrjpPFTu2KKVGj
 52tIOTAZ+/h4wC2CDyXxvoDTlnMzsXdw3D0xM79Z6c7zmkHLj3Bg6j25DaIolbdNxDEA
 vTBvoM8sdVczc5geqLCRmh8UYrUxUdMZmSHYnxyBuZiOpuYjUgpeSkF6q0NKL7ppBlxs
 5q0T/NOuXXZVVjMZ8puONfqhuv8P6ZZX3cq/Pwngvvw8RukO2ejG7ytT0n4HUd6wmpQS
 Hlt4EdAzbMFh8eV1LAGgdZA+SElolcpnruQpnhEnu22TDYDlWG0A3B5IQS7GH78RAR7Y
 Ewxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9DpEKX9eJOmV7WpJdH5COC52gmNUxP+AyyrN5BAs64bbqNVQIrUC2DdNpYjtYVMi502DQDYNDUoledOcBv0gSXuvVtB8=
X-Gm-Message-State: AOJu0Yzr5VX/S5d2w8XLAG/NO86WkR3jGmtvV1hPXvluuBhReyf/i3FO
 tTkKVjF8iA3ZC5zuBLv+fUaWX6qQV08LorO26czjgBWrblp43JtHLinF9cG2U/7X52ignakY3HF
 mEPk=
X-Google-Smtp-Source: AGHT+IE/eLRHqNZQYimxoQzM9Xb+dL6t1wNCxUpgHTIaNCag4giXE4di94juUCOY692EF6o/KXfogw==
X-Received: by 2002:a17:902:e741:b0:201:ef29:3541 with SMTP id
 d9443c01a7336-201ef293769mr9649385ad.18.1723675677445; 
 Wed, 14 Aug 2024 15:47:57 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f037592csm1300385ad.142.2024.08.14.15.47.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 15:47:57 -0700 (PDT)
Message-ID: <efd7aaab-081c-47b1-b0f5-6a959f04c9af@linaro.org>
Date: Thu, 15 Aug 2024 08:47:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] target/i386: fix build warning (gcc-12
 -fsanitize=thread)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
 <20240814224132.897098-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240814224132.897098-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/15/24 08:41, Pierrick Bouvier wrote:
> Found on debian stable.
> 
> ../target/i386/kvm/kvm.c: In function ‘kvm_handle_rdmsr’:
> ../target/i386/kvm/kvm.c:5345:1: error: control reaches end of non-void function [-Werror=return-type]
>   5345 | }
>        | ^
> ../target/i386/kvm/kvm.c: In function ‘kvm_handle_wrmsr’:
> ../target/i386/kvm/kvm.c:5364:1: error: control reaches end of non-void function [-Werror=return-type]
>   5364 | }
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/i386/kvm/kvm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 31f149c9902..ddec27edd5b 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5770,7 +5770,7 @@ static int kvm_handle_rdmsr(X86CPU *cpu, struct kvm_run *run)
>           }
>       }
>   
> -    assert(false);
> +    g_assert_not_reached();

While a good change, and while I have always hated the assert(false) idiom, I believe this 
points to a compiler bug and might be worth reporting -- assuming a later version of gcc 
still warns.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

