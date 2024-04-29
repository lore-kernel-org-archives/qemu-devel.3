Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1E8C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 10:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1OhB-0001fk-JL; Mon, 29 Apr 2024 06:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Oh8-0001fQ-Dt
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:57:14 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Oh3-0006Nj-Cq
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:57:11 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34782453ffdso4025578f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 03:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714388228; x=1714993028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FI3t1VBco+IGS/8gMdFE3NBsBczTbQiPY1pVwxoeFb4=;
 b=cDL3DuUpTHoKi3aFnEfCieGBI1cD0vwW3sdPfOkt25GM+awRzOPp88tO3Tub9uBvGh
 3S4jtlP+mZWUYLSd5fb+IzlA3fmUhGAIQS6U6Al3wwbJZChV+PxvRQI2XCxA0wc1LoFq
 Ym7EHppTyTzMJtygrbebF5Yz3CgqJFrFcYHCMsi6Ci49NjoL6umaAQrHBQsYJmdNyXiT
 ZS3YRxr+VoK3KGlMxSjXMcvSdCcuhbbHInKSPe+F4RKozdneNZnzPvwKbI7F/fUuiZ6N
 UGDFn1DFJr5TUhZsy6YUj4MtkWbpcJVhvBIid02bLa6ZnAOk1t/pPXAGShljN6Cnh0n0
 N9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714388228; x=1714993028;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FI3t1VBco+IGS/8gMdFE3NBsBczTbQiPY1pVwxoeFb4=;
 b=vAUbv517XQxZOXnr0nUNje6syT7KAy+qRAK0U0uq/8ewqVxk0PhhPphYbwNmmJwAP8
 ttQMtmEB6IHH8pTV0KOT9jX8vmmJsqxsAkg2V55GcRW8TEvqRZfZR1iriAyh8Lwg72YH
 +VSU2rA7q/lAGvVuZwsXbgk1+7r6iDWEnDnK3MGNSPiBN3FThi1Fvz1v8uM+WP4Loyjc
 hbVxvyr6pVbJ0Jod7+G3ILI26lfqGAqU+Axf0odjNzuNJE4kZsSyrKTZkGXyWFdl58In
 PQQw15CEhmfjaYaar8ty391hK0HyAJbTVnP4zCsJ90kotuB8RbkFKPNL4LwfrmzMERyb
 bFAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPQZohMOfcSNn2whaahCC25Q1biqhjgQ8gOohjIR3Ac1qtyMQLkRxQksDbT6L+4z5fZXpI9wxBnc/i+mwLjg3zYashYnY=
X-Gm-Message-State: AOJu0YzQ2YenmYh9t8OWz4PBE6liKfOPYu2sbqbloWfVJKHHlCeCy9U2
 Jshc6fQncgcseH4uMtNfIeJ62Z10Ry89bynAnWliQ9rxyfSKm7p/f15Sm+WxNHs=
X-Google-Smtp-Source: AGHT+IFrCIAAgch6noEpPijqp9SH7iaPlM4w43Vh9BJxlaoO3ICL8OthMSeOnXss7PHWK+m0JiLB1A==
X-Received: by 2002:a05:6000:156a:b0:34a:beb3:f6dc with SMTP id
 10-20020a056000156a00b0034abeb3f6dcmr9741428wrz.2.1714388227778; 
 Mon, 29 Apr 2024 03:57:07 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 d4-20020adfe2c4000000b0034a3a0a753asm27578251wrj.100.2024.04.29.03.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 03:57:07 -0700 (PDT)
Message-ID: <75c6e408-def3-4302-bac3-a87717c3d5bb@linaro.org>
Date: Mon, 29 Apr 2024 12:57:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/20] tcg: Make tcg/helper-info.h self-contained
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
 <20240424230224.941028-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424230224.941028-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 25/4/24 01:02, Richard Henderson wrote:
> Move MAX_CALL_IARGS from tcg.h and include for
> the define of TCG_TARGET_REG_BITS.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/helper-info.h | 3 +++
>   include/tcg/tcg.h         | 2 --
>   tcg/tci.c                 | 1 +
>   3 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


