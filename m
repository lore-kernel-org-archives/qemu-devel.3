Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B43C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 03:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJm3I-0000wM-8s; Tue, 18 Jun 2024 23:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJm3C-0000u3-K5
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 23:32:02 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJm3B-0004RM-3b
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 23:31:58 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-25ca30072eeso45092fac.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 20:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718767915; x=1719372715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BFjo2CMWaow1AyjC+jZcvadwWGyIjBbqjLni3Kn7s7g=;
 b=zD1q7PNVoN/WyXRqwBn71qAsaOS/lf+K4PrT1u11Z+F92v2YubxokjGn1YmrM7behf
 s+lveGDvMiMi/9VfOXJecODoA2qy2BWLM1IGrgKE0+h0CSy8wVif/yU/CSyl6Q7stgh8
 l195WAjOll17Pcti6lVWe4rwiVwa77miu/3nwwntynfoZguRZnTgI31LUrFuEGrXyjIv
 W56c71n7yCiP9DN4wJ4MCgP1a6l0dzB+01A+x3xDFg82SIQ0uLgsLemLdEGqmoEs32Ft
 cmWl40LwFCYadjezP6ego9rkq3d644Qb2TL3rGZhZBzES6DfJxqZJcVXdtvss+vVyqQJ
 yE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718767915; x=1719372715;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BFjo2CMWaow1AyjC+jZcvadwWGyIjBbqjLni3Kn7s7g=;
 b=BSxwuRwB3VYXuVotJnBDsJBF47/6NEmfCnSa8tFUtLntxQ604OpUs7SY5p5FQdSdHD
 N7iunANgFFzJ5B/po8QpkfBtWb968ScQq0lP4O+LX2IJvhmDAT85RSI2iThOZ1NpE/8S
 Is5M+hqMY8nMLeR36GjrgmbrsmYkEG6EUFjvtYHHdSsiM+oCy6V1S7Dpbkqh5NKYkiFc
 anhioWl9ut0mfyBlosh7Uukvub8uuloEcVsDLZbgWNZsvBmuiioo8/93Ezu1zB5OFFtw
 X8VxUd+EHUKCvj6NO0+uWfZyUarDDV1/ULhAHXM9HAEdLlUDlBCvYkyNh+HMBiX67b0X
 aNQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSbUhKNl0GWxpI+J04+KyIfouJmqn1GG0IH3WeumUz9L8b37FLk5p4zI9xZgPHtMnuqgAO7MvBpOw5L5tln7wnH2aoy+Y=
X-Gm-Message-State: AOJu0Yw3UMWgkQSXTRWL5toHf2HnEHZ5Z9PIw+Aa0wV3pCYScftzzN1B
 1b8eFfvB5C04Vp0rIUOAzjaSB0Q1NHaPuMGSRI7TRY/fd7dLv0woHijGcpHX0Ho=
X-Google-Smtp-Source: AGHT+IE/+B8lbHeNn6g2SYBiZyGNSo3T7LDCLmgLj6eBREkHRDwmwRho+fkcxVKcoMLIUuxVMy3m4g==
X-Received: by 2002:a05:6871:5c9:b0:254:6e4e:23d7 with SMTP id
 586e51a60fabf-25c94d722a6mr1866447fac.50.1718767915382; 
 Tue, 18 Jun 2024 20:31:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc987738sm9700993b3a.89.2024.06.18.20.31.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 20:31:54 -0700 (PDT)
Message-ID: <7cd4838d-ab79-48a8-8f06-dd8145c6c82f@linaro.org>
Date: Tue, 18 Jun 2024 20:31:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] Implement ARM PL011 in Rust
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 6/11/24 03:33, Manos Pitsidianakis wrote:
> If `cargo` and `bindgen` is installed in your system, you should be able
> to build qemu-system-aarch64 with configure flag --enable-rust and
> launch an arm virt VM. One of the patches hardcodes the default UART of
> the machine to the Rust one, so if something goes wrong you will see it
> upon launching qemu-system-aarch64.

What version is required?

On my stock ubuntu 22.04 system, I get

/usr/bin/bindgen aarch64-softmmu_wrapper.h ...
error: Found argument '--formatter' which wasn't expected, or isn't valid in this context

USAGE:
     bindgen [FLAGS] [OPTIONS] <header> -- <clang-args>...

$ bindgen --version
bindgen 0.59.1


r~

