Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9D0C3064D
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 16:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNxt5-0000QA-2C; Sun, 30 Jun 2024 12:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNxt3-0000OI-Po
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 12:58:49 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNxst-0006DR-3j
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 12:58:49 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-707f9c3bd02so1334202b3a.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719766718; x=1720371518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kk+ucyYl/O8kMajjzsiQlInGTeEzBakg8N7HwQIRv8w=;
 b=Yu0c/zsWch4ZMzeBQvEal9dVLPdUlSKQWjVQt0dFwDntWIWKu+yLf8rcA8m8lWYBYv
 D5ox6NOqc9n2+dkyRYLMaY/m7IDiZ9FoqvvRNHw7at46VsGBDPuO2DJVxHdzZ7I/Tqzt
 8+jqlZnCRLobOYC3XzsTakkYNC2ubXqNS6haKlyxmBr9uZyUrnqqGxQSg9Q728Zf4p+t
 ujqVflhGyxZcns+Dun8b8LEaf0raJMn2Rd7QMyIJu95AcNPCUGslqONGQfKoJrfmV0vN
 2putXLkUdpFruEidS04e7cc5cv0HpVoyeKoX5vpRoV8nkh4dweyyOabQxabxw3PRSoFB
 cjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719766718; x=1720371518;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kk+ucyYl/O8kMajjzsiQlInGTeEzBakg8N7HwQIRv8w=;
 b=Dnh7nCGiqQkLwsP/ZWQVIRBSSCZH2zM/S4x0VioVbEKlBGLCRz4yN/Kch1C2J1J/UD
 oCyrlatgllEIdJG4rCWxdZuanb5RUttxu5b7YgC6sMCc57G81GMZLvwpNh9jd1v0ItUr
 nGzjQ2zBbr9iOjSi7c3+VyLulSOKnBm3sdZD3dxX+Y0jJxMG+2fAckkXbtP2hYdhBbxZ
 thjkro7YAGMOR8KYDq3qbiulBjZJaHs0ArsTjJG0IEDZoLC/UOiDwizoHYumOtCdV/lu
 lG2PZCYx0BFz/SAdKi0za3CIIO2MxDTMozDN2GyQA4QizOMVvdDC3lBzjQ1/ftjC3SPG
 QcMQ==
X-Gm-Message-State: AOJu0Yw/D1V/k5VYqhyd0vKGQYiAMQtY8oDnO1kvCO1Pb7ZrqvL28HVf
 tkMRfH3YbVjQHTwE/sgU01BUEL0d22GoRo0Km7g0BvSKbXtqyF7Tevs7jG2LLfbgN56Dx1QKCXC
 E
X-Google-Smtp-Source: AGHT+IExqqe2waG0TIMX/KaVuKGSIGmge52pamBGCkcq4IjhlIG1+sP1E0bJuuEDdjydG2haeGnxpg==
X-Received: by 2002:a05:6a20:d707:b0:1bd:2a28:cad2 with SMTP id
 adf61e73a8af0-1bef624468amr2393193637.62.1719766717603; 
 Sun, 30 Jun 2024 09:58:37 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac159f502sm48013595ad.294.2024.06.30.09.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jun 2024 09:58:37 -0700 (PDT)
Message-ID: <0128b027-079f-45bf-8040-3a447b0aacb2@linaro.org>
Date: Sun, 30 Jun 2024 09:58:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/ppc: Update VMX storage access insns to use
 tcg_gen_qemu_ld/st_i128.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240630120157.259233-1-rathc@linux.ibm.com>
 <20240630120157.259233-3-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240630120157.259233-3-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/30/24 05:01, Chinmay Rath wrote:
> Updated instructions {l, st}vx to use tcg_gen_qemu_ld/st_i128,
> instead of using 64 bits loads/stores in succession.
> Introduced functions {get, set}_avr_full in vmx-impl.c.inc to
> facilitate the above, and potential future usage.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
> ---
>   target/ppc/translate/vmx-impl.c.inc | 42 ++++++++++++++---------------
>   1 file changed, 20 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

