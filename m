Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAD4C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 18:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG0Wa-0005OU-NN; Sat, 08 Jun 2024 14:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG0WZ-0005O8-6y
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:10:43 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG0WX-0002Jv-9N
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:10:42 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-6e41550ae5bso1010431a12.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717870239; x=1718475039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9GXGUGAqh7ReiYCL9QMSlagbvK1D85iN1Rus6aeKG0w=;
 b=AbSa5+mIeQxUjYQxNAgNXBMKDhnhLBKbs4XFmASyJQQWBbTqlqTj3yaeeVuoOtSm6r
 v9xJLUzOl9hV9a5v1KetmHaWM5KH3ZFt9xSAZDGQfIfAhDc8Fwg/z77wBrsb4Rkad5qk
 toqMASgXMzIqh3ZF2f8qONQVzUg1CZR7zuBBzBhh1nNM6RmBYQa7mFa6pezDaAn97kSE
 2eCfPTUWlQEoMj1AJium1hC6bkk7D7gMtCWhkzRjHY+YxzzS0xKtA4NO/5ZYo0lrTkD4
 9FEnOXpQ7aBvje2emnGPPszCGsPeQY9m/eYEhogcDe+52XAlezM8tkzVBM3vnEks0LXB
 q9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717870239; x=1718475039;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9GXGUGAqh7ReiYCL9QMSlagbvK1D85iN1Rus6aeKG0w=;
 b=N8ggFateCt8qOd51arTYeBK9zd6or2QWqegxpkq44UjrUsYlt3Hfgkp/RvvowDndnO
 CtVk0ooD4RIXYVhmrI0JgRnl//ob3yEBdxGe91yCaNYsnPSceQya5EtxnxIm7HpAbt9Q
 jGY7k4dzH1yl7gv/reSZXqszgCSEzpAhQVb11Gy2E6HVIfyH8JsL7MTVGOZST+rd8w55
 xxhzv61m59ylmCXoVSqAI6o3RuNqeTKkw+mcGbm3DqAPPoKHECc31s0zsldcPOgW6eCm
 i+clW2o2Szj7ijGUQn9JCXcOUm/ogDdOpPKE9Hupf78zbqCmEKkRW/v5uB8zuwO2EpbE
 48Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdWg9ur4pAmC04NODtboIBNyfHHU9CxyuLlFi0wM3Fx7W8Yt4fdy+OQjNpix5rdL32dQOudYblRHVfYdT1Y4j5mcGYwpQ=
X-Gm-Message-State: AOJu0Yzk7BGBoiBNGS0izrnJKGzJZsZArbUB0u4GLk6VoP6GbfcK+tgu
 6ODyfJCLFbfRyy970WQmzEz4wTTAJjeRR9CcyoBjFQdEUy5R6k+xhQVYZzJJFGF7xJD255u91xf
 a
X-Google-Smtp-Source: AGHT+IFQKrxbVs1zscCwKQrUuFjmFEyf4Q7iY7TLa/SAM2jBfDnouH0HeHc44b1BWDvuB/iGhR0B4Q==
X-Received: by 2002:a17:902:e883:b0:1f4:7d47:b89a with SMTP id
 d9443c01a7336-1f6d02d1feamr61636035ad.1.1717870239463; 
 Sat, 08 Jun 2024 11:10:39 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6f5062278sm13102825ad.140.2024.06.08.11.10.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 11:10:39 -0700 (PDT)
Message-ID: <372d8cac-3939-4186-bfb3-008b0fd1943c@linaro.org>
Date: Sat, 8 Jun 2024 11:10:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/25] target/i386: change X86_ENTRYr to use T0
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-5-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 6/8/24 01:40, Paolo Bonzini wrote:
> I am not sure why I made it use T1.  It is a bit more symmetric with
> respect to X86_ENTRYwr (which uses T0 for the "w"ritten operand
> and T1 for the "r"ead operand), but it is also less flexible because it
> does not let you apply zextT0/sextT0.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc |  6 +++---
>   target/i386/tcg/emit.c.inc       | 34 ++++++++++++++++----------------
>   2 files changed, 20 insertions(+), 20 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

