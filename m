Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32544C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8P0R-00072S-Bf; Fri, 25 Apr 2025 15:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8P0P-00070X-Kb
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:46:37 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8P0N-0008Bq-G7
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:46:37 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-af5139ad9a2so1857597a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745610393; x=1746215193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x2bTp6vH4HckfaXUZvd03oQPBeLbQlxfhaoS9S9MqZE=;
 b=do1vsJQltN7D8ui/P9SGkJDcbyehgPKf08S96aQNwB0JeLsJLNQ9dcOHaHs8TqJ0DX
 ht3T+eRoq2c0nD2jTDjw94fmH8YE0yj17tseOAeVrr1n1Cn0OmrcAcB0Z7OcOhuKpxF0
 m2B8y3Ej5WmYGv4oI677I93PEheqbz5KtpuDtqe8zPVMEDT4vtv2S8bCAeNrMSsaiJAR
 miHxLr9koCtVQ46Yy/bLhB+rJu+PJH42LwRncdC34Vq+avZD/w1BLBuPeW1FQc82EkEh
 jwqjmU++CsZOjCvpSs+miwyZUvz7BKmCpTYVFJ0dL+mF5ddwibBwn9Up+5bte+OQUVJi
 PQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745610393; x=1746215193;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x2bTp6vH4HckfaXUZvd03oQPBeLbQlxfhaoS9S9MqZE=;
 b=hH2TwUraunVfXSTcJzG9MsEPnl6NPPO7fRUhrKHhunWn+CcUikIoEvBUYCaga2Inob
 UYq4Upm0kW6GRiY/j57JqMoeT1v8hr5ypnf8F9b/PFPfapaaxCSAyvj+l2Ps0/FXCSBG
 JvFUhZ40Zg2x3EfkBRucmam7GhPdaqSEzD+DJWLI6x5IxSarhqJzkAp5mRmVhlmpdJyu
 NCM+VWE/I6bv9IgJvmlVz3HGnL35s/3Frz8i6pYTFkYcSLkgrYeOPhFxhAwN6HeFQ9aK
 DYRJSFxj3RvaGGBZ+XGI+AcciXMxe6Drb/zAxmf/+0raOkr3XiLGua/Ic+Zz/agbUafX
 LYKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH7tA++cX2Qh4vw+Ur3RzJZJsoKlYzfyNQI/Z2lR8ERe0vhAEcvnILL1iQ46LDjFdxxaSOPPwCXTZk@nongnu.org
X-Gm-Message-State: AOJu0Yzyq1CdKBY5X40nohA2524KKZZkbltWxVINwPOpCPdDRRiDeSwr
 swi/EwUiVfl0Mo42ylmmyafVY8Lk5+CmuUbnYywN81LFYlptnFAw/OaNMWxv9VQ=
X-Gm-Gg: ASbGnct5gAbx7FDlzaHae2cyap6LouOXQCdrN2D1Ky8ScmHJeq9R58JxUwViCQc6y5c
 42Ep2h9HpCSC8ewKtR68xl7gW3ZYmymKCs622gLyaZrQM1xbxiVV/Ih8/cn9ggjMGjRv6Ytg9W+
 ZZ8bHvjOdMfwRYUUg7jehT1fn6oLvJAcdEXa5rpx1B5C1uABvgbdUf3y8+SRxFK18Dc8SjG2wbq
 +lh5mHToFITWd59fMc047Xs4ozbOCbWuG2NrB7C3h3ceLMpElr5eNG8VsaFjX1r/mHYgWy+nvJa
 D232o/5XMOfL9DWXuOAZwxw1AsI8bW1jdYOSCLwOUIQCqKPdG69z1g==
X-Google-Smtp-Source: AGHT+IEawuMP8gj41p3UOOkn/wAiU2itxMdWkby1vRZ6Uu5FyGBAH12Xwm9vYGdro0VQhCyt+J21ww==
X-Received: by 2002:a17:90b:4cc2:b0:2ee:44ec:e524 with SMTP id
 98e67ed59e1d1-309f7e8f6dbmr4766991a91.35.1745610393634; 
 Fri, 25 Apr 2025 12:46:33 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f785225esm2068351a91.49.2025.04.25.12.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 12:46:33 -0700 (PDT)
Message-ID: <54a1a59d-5872-4b7a-bb44-9dc645952495@linaro.org>
Date: Fri, 25 Apr 2025 12:46:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] accel/tcg: Compile tb-maint.c twice
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-16-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424011918.599958-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

On 4/23/25 18:19, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tb-hash.h   | 3 +--
>   accel/tcg/tb-maint.c  | 2 --
>   accel/tcg/meson.build | 2 +-
>   3 files changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


