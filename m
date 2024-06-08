Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081ACC27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 20:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG2S0-0004Ki-GU; Sat, 08 Jun 2024 16:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG2Rz-0004KS-QH
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:14:07 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG2Ry-0005QO-8q
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:14:07 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70413de08c7so1219455b3a.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 13:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717877645; x=1718482445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lttXSuPZFePpB0sxCFRajF8GLBpn6NJdri0ybI+cX1s=;
 b=l8/9OcsqvbiYDv+LUzO8xWuRJ/bnVbYKGwAx7v8B9FPa1bQs8G90tJa7/xLH7FwuKQ
 QyFS5smuiA54+140XWTndX2NAb15IUVrzCWvvpY4yGYRoWXAgLuqa79vzWNKMLLQdGvD
 7mEV/VrvLRJjU1y0uMyvnmLznlZJ0asoe51fJYuZ5GKt9I67E94Iq/oo+4xYmZBA9Aqg
 HUYQPr02EEkCMaxMV99fLRvwx5w2wcbziN+gtjbVhWQRtfyzonGcsWA+Sx25808WdHOp
 wulHmYIB9awZ2By0MlUGgNX9ltDMFSZ2ORWqRvlisBEy/vF84ddCDHjhKrwLRNyEFJg8
 FjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717877645; x=1718482445;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lttXSuPZFePpB0sxCFRajF8GLBpn6NJdri0ybI+cX1s=;
 b=pevFd98FwMKtjtZfhWKm4UP/4QjjflYwbxgjV2c2YenWMOyHPMqo4l8olTGsVhxWXS
 l4DAiJu/PWJmbAkss1mGjwUQxGRfEDe7mGgV3xjdpULbzuo4oSHpMpMpBm6nEj1/Wbe5
 RIhUzGCVdLa5PdBAAFXN3zF6WGVS4zu/vDcZjMy9vPSMFVguw57Zcpe8B6grbBo5QFEK
 R/RnD4/+6GVP/Pnph0qESnGDml9dIaE4R6CNjl4WDKHRT8vfHs0q9rPwUY5H6oBmaWEO
 /crd4k6K0adFXUtUdDvXeB7uSEAgX3joyAeqfFbJfbN3sTh0HQAbj1FXSGAQ3xDL+C8T
 8uJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULdhMmqIc+oIUXTzlsJvoX4isC7/rFS9fEFpM6qLs9fEGbRPgrd2TV8JBghnOBTGNSMpoxwm0AZRJszJovDJJkKZ7R3Vc=
X-Gm-Message-State: AOJu0Yx/3RFMWhvtWxxgkKMg/tmEY18ynH5rDr+odioZ8rXUGCRuNd4Y
 ixGjUJELNi/hZmboXkebpy+MB5Ri2e8XN/TmX3LOz2We4wO+vGVMjwDytsC8rTU=
X-Google-Smtp-Source: AGHT+IF5MQVSBFqa0l0uQCKD8NScDs7Va3ErLLt58H5yrntNu5AsUzLqLZllWV0Q8r0HqC/YtPJtOQ==
X-Received: by 2002:a05:6a00:2396:b0:704:21cf:3926 with SMTP id
 d2e1a72fcca58-70421cf3c91mr2857822b3a.6.1717877644363; 
 Sat, 08 Jun 2024 13:14:04 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7043639b5d3sm28593b3a.91.2024.06.08.13.14.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 13:14:03 -0700 (PDT)
Message-ID: <c79841a9-4840-4dc8-a319-f9d501dddc2f@linaro.org>
Date: Sat, 8 Jun 2024 13:14:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/25] target/i386: list instructions still in translate.c
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-23-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-23-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 6/8/24 01:41, Paolo Bonzini wrote:
> Group them so that it is easier to figure out which two-byte opcodes to
> tackle together.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

