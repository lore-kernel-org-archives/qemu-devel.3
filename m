Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22F5C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZpz7-00065a-7V; Thu, 10 Jul 2025 08:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZpyR-0001U5-4n
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:02:11 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZpyO-0005bc-D2
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:01:58 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-710bbd7a9e2so8972907b3.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 05:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752148912; x=1752753712; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G4Lh/oYIsokCqRCumrpkEW0ShZKXwoSJIhTNgGFU3tY=;
 b=u1TBSiXxgvs0U8yEzG4xleGe3kJ9ylteH3BBUgFKUYU7ujb4UBTtmmUZCIgZkZ+JgQ
 1HYRU/Njt8cv2bArILu9nebHNjXfCoY8QaH65hwWSyp780qjQGytr/jkzr7twMLWEL+U
 M4uKU6DITaQtdWMplmBDjaJlvPQuUFZwQz68xAIJn5fOx7ze7T3obliU07i1E4HQYGJt
 C3X0WH4gkkPRckTYV2kU10m96yAwd7mWiANFNFUaYAN1oEWn3sKbmbBQ4M/zIrYRNe64
 23nQZajTLpU7KrmOZgW2JEgO9F1H4QXxOdwOAgk1uUJn9Wn1O0k73T+jbaI8PGNx4Wud
 ywrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752148912; x=1752753712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G4Lh/oYIsokCqRCumrpkEW0ShZKXwoSJIhTNgGFU3tY=;
 b=GJuGKkwS67/OdERYNajxbUvMwpov6vTW5T2M0iZH4ke9ZcyPsiW3AtDkEE7d0YjAKc
 WU9umtUtca5lBph1sl831N19EiLGiqLdm+Srgfql3cHtCtbtKSOPz73ELkqHphqP9Rg6
 XyC8aUo1EYrCOq9cxSlilsAuRDRniWP5bXQUdRoO6iUjEUYoPED71sC+hIno8QrIJ3fB
 TuzaYCnokIktMiwOBD1Hwpp6vhOxVE4qq3MxNZkdwUUdTuC66zG+EHnpz436gUWYp9M3
 JQbcM4ZMRh7DPWnT21j/AFM8GMP0uW2Cr1HfWtMfcwMjJ1WyAerYvRLiejrB6FYz31+S
 awUA==
X-Gm-Message-State: AOJu0Yw5Sb8lR330KNaVi40LZyx0VYd6hu6vpEWPdZINyanX25Ts51cT
 Gcnjre0doTBahwccj+EYbnoyJIfOt4XqmeXyxF5G9V6Ix8MeLUkNgPLzF33DqGD7P2sup4+YP8J
 acdkj22dXDEViGWpC2Jy+Byz2EbkEXB52jqD0eupdyQ==
X-Gm-Gg: ASbGncu43VKcBQFAN9EIEyH4hYw6O0s0oREm/OYlI2VweQI7+lL4XNGM4Umobisyn8v
 K7DTsyRhJhnvKklo+dnWSFY+E9UV/wwS2emZ/TOzm+amoIYzeSmVABX61iidwLgogCqdcW9F2vZ
 ONhWg6hZprMALUMldZ2bbppvwI5rTxUzcxHdTq6ZIK7U41
X-Google-Smtp-Source: AGHT+IFKm14OnPnasbBfpQXwCr3MFpyCQ6sCYiPnkct/WzJI0OHlYxud5DB5fxX1owWbr4/sz7sDMBUQJ9kr0TpbtQM=
X-Received: by 2002:a05:690c:2504:b0:711:a4af:43ad with SMTP id
 00721157ae682-717c4663feemr33342167b3.14.1752148911194; Thu, 10 Jul 2025
 05:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250707202111.293787-1-richard.henderson@linaro.org>
 <20250707202111.293787-8-richard.henderson@linaro.org>
In-Reply-To: <20250707202111.293787-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 13:01:39 +0100
X-Gm-Features: Ac12FXwLX1hkjlmfNmoFWYbHGSgARVrM1qbuWMkOoHJ4DlMgTuu3qgk1PibLZtU
Message-ID: <CAFEAcA9aH_31Z=C++baEMm+9TUCuVbKnYz7LMjoF0-Q_S_RvGw@mail.gmail.com>
Subject: Re: [PATCH 07/20] target/arm: Convert v8m_is_sau_exempt to access_perm
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 7 Jul 2025 at 21:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/ptw.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index a11df31b18..78a9c21fab 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -2754,14 +2754,14 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
>  }
>
>  static bool v8m_is_sau_exempt(CPUARMState *env,
> -                              uint32_t address, MMUAccessType access_type)
> +                              uint32_t address, unsigned access_perm)
>  {
>      /*
>       * The architecture specifies that certain address ranges are
>       * exempt from v8M SAU/IDAU checks.
>       */
>      return
> -        (access_type == MMU_INST_FETCH && m_is_system_region(env, address)) ||
> +        ((access_perm & PAGE_EXEC) && m_is_system_region(env, address)) ||
>          (address >= 0xe0000000 && address <= 0xe0002fff) ||
>          (address >= 0xe000e000 && address <= 0xe000efff) ||

This also is conflating "don't check access permissions" with
"access is data, not insn".

-- PMM

