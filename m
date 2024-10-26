Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8C8D10BE4
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 04:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4YQc-0002SD-OG; Sat, 26 Oct 2024 00:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4YQb-0002Rq-UK
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:29:29 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4YQa-0007sw-Ea
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:29:29 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20c70abba48so21960725ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 21:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729916966; x=1730521766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UVjxF3ESHzHgAk0dGqkCsRxn8hWXACkiPeKVzbzaR0c=;
 b=Z1xpwA4XTo8FjwuyNFR5UjC8cljYATEPxPfzdiBTFmd1r1Xt+ifRdlMcDY9fnsAKeL
 9m/8dR0LnR15vL+JG9WiRBGyS4rqnStBIHXTPdjpSZ7+l9fuPreMh69Btj+iH6x1GCkV
 oFdX+bZxiRt5o9nZE5F/4FXcFapwqK9G2fxOwBEhPFNhIGJXTG+GZ+pqEqcZt5D31vEZ
 aS7gdT+Bv1kiwYecplP60a1rzUnttCSoHeo2iTMO1e46LLlkBOYdnOs9lZ4PkEHZ1KfF
 XUo978mkFUkpq3wP+e2KF1Gad/vnUoIB3bKPik29Xk5VcsRHDUk7KaqL1rRNwTTvY5+b
 TUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729916966; x=1730521766;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UVjxF3ESHzHgAk0dGqkCsRxn8hWXACkiPeKVzbzaR0c=;
 b=PGt6bNFMN/40gtEHc/1+WldCnnrApNv/voPuytQnDOYbcDmAb8raC88EA9yaagCgq0
 riRyLt7PA3SWUd151znSKT84DTtkB80V+6auvfFLSXGPjMSI+jB3vxwmT4kyphnPvihR
 HthrNGxYuV24b0ZVfkmq6yrJAIJVDt9+WtgeOPV2bGAaYGLtQa1kPSoKOylm4a4qqs/O
 4LkH7mYUDxpybCmtgADMJ4wK1lximrZVenBSOZZzIQ2M9mqP1y6sYTZuonJLBqdfi/kH
 yjLmseB2Y++m7u+PzYuTV+uMWF4H7EvwEMgx0ErftfFiNdhqd5gkR7ZaD+8sOzAtrexk
 pjwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqaL0zD095LXPEOUiKBh0qbTiqk4/tXr2gxTGnKm8QlpCP2HMHcUrQhQzfP3jyNyLak2H1Ol1x0AQ0@nongnu.org
X-Gm-Message-State: AOJu0YwneebnU3ECBdGj3z5LxZGzZaBu3HRwZCcfUNvUqHbeW82RMcl8
 VpaZP0mcEuVuO+KMlDZLVF8ylgf9dOUQsETCFJVKT081CyvYGo9g1kWPYqbpuRo=
X-Google-Smtp-Source: AGHT+IHn+TeGpIjJCcIgHcT7/vNz+Hebrk6hCDc8j9HSpSNE3xaZFqLbUrpMq6/FIGtbK9hI1L7KnA==
X-Received: by 2002:a17:903:1c5:b0:20b:8e18:a396 with SMTP id
 d9443c01a7336-210c68abfe8mr15661615ad.9.1729916966560; 
 Fri, 25 Oct 2024 21:29:26 -0700 (PDT)
Received: from [192.168.120.226] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc012f19sm17191775ad.158.2024.10.25.21.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 21:29:26 -0700 (PDT)
Message-ID: <bd83aec6-ddd6-4d21-9d7a-7eabf3e1a79a@linaro.org>
Date: Sat, 26 Oct 2024 01:29:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/21] target/rx: Explicitly set 2-NaN propagation rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-21-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241025141254.2141506-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 25/10/24 11:12, Peter Maydell wrote:
> Set the NaN propagation rule explicitly for the float_status word
> used in the rx target.
> 
> This not the architecturally correct behaviour, but since this is a
> no-behaviour-change patch, we leave a TODO note to that effect.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/rx/cpu.c                | 7 +++++++
>   fpu/softfloat-specialize.c.inc | 3 ++-
>   2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


