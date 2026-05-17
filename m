Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA3CCD4F47
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOf4d-0006f3-81; Sun, 17 May 2026 13:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOf4U-0006dC-8F
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:14:34 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOf4R-0007Gt-Lh
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:14:33 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3660ab73adbso926049a91.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779038070; x=1779642870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2D+L8Ic1BCX0ye9kJy+Dv/vVfY6wo39yQ9H3bUjJPGY=;
 b=MW+oTwXPkuBwEUtXz3mRzUYFwCIsnECfPQFS1q5RQJuzubkBfnhgMKTQfzGYdAzN4N
 n2tAFkwMf+dhTklmPzZtdBsgctMSMgZD7eWr1vrrpyVQvar7FAEGkd67z/bS4LFdMZMQ
 v4KOZWIwF0m5y0clS/GUoS/A7Nw/dUF7vN1FiSxincxhWG7eK2PvqviJ2cKTOatXqZEN
 CF9UUJ32KWGIELRsdeHODfQacmkmE+37fBFCTfKfvvO3T7fEXgh55H+goT/HFPCTIl06
 Om5yLTXJw8zdNKo0YlvoFeF4SoDDtQe5hSz3csoAQKU0BoS+dHz9h8q5bOGRklrysq3i
 fnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779038070; x=1779642870;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2D+L8Ic1BCX0ye9kJy+Dv/vVfY6wo39yQ9H3bUjJPGY=;
 b=nHlpE7gy2tW5TFT3xmcVc59UMhz5xDaMU1TJ9xEseROARTT8+ExkM/BnBeVMQ3xuIc
 HuwbDPgemR+r+LZ55A+AY5GByLq9guyiGWk6bp3Uy9/Mh1Jtp/ldAbwJnxc3SeDIp6Qn
 W5vOK+84QNQOCmvSZoHiM79svX9wD1W0eepF9Ml33z/N/xnshhHy2BEn5d8jSpda1O04
 jmTHXAUovZYs1hHCKN7kihWErxEfN8iQJPB08vq3A9Wvs8K1pCKuR6OsfKHjaa9A37/r
 u6TQ3lkQpCEN0LfNN5OEYAbUKYDonmfIb1p7Sc3a0FwtgV+A1ilxL7jB5y/fHThn/tVB
 dWTw==
X-Gm-Message-State: AOJu0Yy7dBVsfwTdJGhIJwFkMSCH67co4SXaHYjtY3zql5WWZyWqE12I
 f59nYGgc5vB7aw52vEAl/E9w4vLFbmgr2WxmB0E51EoXjTWxenP3ZIRML6U5FCX4EXjwKVAEELG
 S0lQO
X-Gm-Gg: Acq92OG2vOtpTnkNkfSWehTlf/0gV6rncaJwmuaZVZqoWtHwJYhb0d3Z3uy/3FQ+61Q
 E1eAGDYbCJeQwpjbI3GnvKjhSH48pxl0Z9ZCg877UZBxH7vFdhoQ33J8+dky7fU/mIFNRm5mjuY
 OZeIiHaFjmjrIIh2343qbw64I/2VdM30fphT5BPfSoXNBUPW7jfBVhXsKe7KeWLtfb75PtU6TpF
 4lnrodrYA9oU5bh2Y5Ftd98Kuq7h4WrKrDeiRlyl8FxNU4aZPtVt7gtNpf6VbZC7uVebA13TkF7
 YayMBfmOLdcJ9wWw0AEda/SzD70G3AcCUoI/A3hcOfKsOWis6qhr4YVLgGWnUlFDmGiKpKtk0oJ
 20eoDfsWNLPohAxQKzO0UauAIBRV81XZdCr4bixacp67iGq6K+FaLuDpgGC2xNagzTb+N+pZUhq
 PUHVkGr0ZoQohqTmS5FInDm1Zp/7i9WsJqWtud
X-Received: by 2002:a17:90a:d40b:b0:368:4942:50c4 with SMTP id
 98e67ed59e1d1-3692363eecamr13695233a91.17.1779038070201; 
 Sun, 17 May 2026 10:14:30 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36951437316sm8551603a91.11.2026.05.17.10.14.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:14:29 -0700 (PDT)
Message-ID: <dedf8a54-31d6-4e70-99d8-2cbb9b43f3c7@linaro.org>
Date: Sun, 17 May 2026 10:14:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] hw/dma/omap_dma: Fold omap_dma_sys_read() and
 omap_dma_sys_write() into callers
To: qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512203414.3633237-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/12/26 13:34, Peter Maydell wrote:
> Now we have removed the DMA 3.2 support, we call omap_dma_sys_read()
> only for the single address offset 0x400, and similarly for
> omap_dma_sys_write().  The other cases in those functions are DMA
> 3.2-only and now dead code.  Fold the 0x400 register directly into
> the callers, and remove the rest.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/dma/omap_dma.c | 121 ++--------------------------------------------
>   1 file changed, 5 insertions(+), 116 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

