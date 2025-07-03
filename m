Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAD1C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJBy-0007fW-Vi; Thu, 03 Jul 2025 08:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJBw-0007e6-JG
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:37:29 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJBr-0008Eq-FI
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:37:28 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-711d4689084so86776587b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751546241; x=1752151041; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MPJ6n38GLR7Tuj9qMkkB0ODgl2ns+5tOg89TACZnxHQ=;
 b=Qw9dHRNFsZ8FFjCAukcQio5+xx5eVX7rX0qJp8qImTD99nR7mdkIimZdVPc4MROWjH
 CNIk6IZTayszzz/JDMeq7lUea7lbJRnkNtkdC1Qr5nyi1tAvFgZyr8rC0qM4FueNxjgD
 7ah2TjCdjILjqX79d6ZuEFshqusHBd0UzCrPeqwq86XSmNDelDcKelmMwfUBNeMS24c7
 gsTIJW2aJryGe3RxQFQ5TYjOItjnmdVHCooDMWePzr64+uZQ2SFur4+K6RjegUfrO6M7
 PUrKpjWT8hYUJAsDoEH97DUhfHnfUEWlv84AGBXBfWtvChNr6nKzX6918tYDsrV7f2Nc
 Mopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751546241; x=1752151041;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MPJ6n38GLR7Tuj9qMkkB0ODgl2ns+5tOg89TACZnxHQ=;
 b=Tu6dzrD3sAjJ8NGrOalQwWW8y5hLTO1WhOqtE2pl6tUtYHXjF2cINPa9dPNWRw7he/
 g/tkkb930sC3Ntf9I1farplJ2qgsgnCesXi34O9XynQBP70OgIWa+8nLLkGe5esv+4Pz
 HpiATxCgYgmpyEqgDBuVxNab3V09IbeJfLPIVi3l/xPjCmJRuN06EaU/EAtXPD5V613Z
 Kx2urLzEK10x3oNdxjrNB1AsX5BKN+PcBe+g6Axr/Csapuzy3gpL3FjkjRZXK/oKuOhx
 KfJXpSihyiLdd7iJXysHY44ET2swpVVIkzah3WoX5Vpe4m4kvGeTb2y8P/kmBQalmn7M
 nK7g==
X-Gm-Message-State: AOJu0YwIgfLEjZXrqeeipRcoowGJ6BmZGkRji7Zmg/hnParA7b8KbcOD
 0aOP3y7gEyiPMFMablh6T73VzvQl+SdOSUabaoDfImK2lz6aFnGYVYMuyMeStdh+AMJtITkywkR
 oaBpPUWdvfjaK7DxKh0AwMkT/ijV6QGDDwGmAYZCabg==
X-Gm-Gg: ASbGnct378N+xReiO+6dUXu9t0KXU015P1D14OyQUVMSd1scrkcUeLusp2uuTmRBYFW
 4NEIs+uJjtfzHgPdP/IjJisEFx3XHPjgo93oEySAyNntWrRfotK/3RLQkQSwfIa/pW2Sg0nEgj/
 uBwVcvSJV6fPxqB6GR2dYEe9IZdTlfXroFUiPX12Glc/Tm
X-Google-Smtp-Source: AGHT+IH/X00i8gma8xPMLPAhFY7054QYPiseuLK1VNZxNxTrwNb0aJdusnDHzSmTZoXI06sBpbdl1R9WyZpxc3yM17I=
X-Received: by 2002:a05:690c:9993:b0:712:e22d:a235 with SMTP id
 00721157ae682-7164d4cfc0bmr85299517b3.17.1751546241490; Thu, 03 Jul 2025
 05:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-87-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-87-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:37:09 +0100
X-Gm-Features: Ac12FXyo6jRJcqZWtwxX6dN_fIubiT2zNwp0oj3tqRHbXTG6WH57eCVVhrjkxmk
Message-ID: <CAFEAcA98mLaeB-YV3PZwbUJ+szJM4-GqDCEyC0syuNVrR0kwxg@mail.gmail.com>
Subject: Re: [PATCH v3 86/97] target/arm: Implement {LD,
 ST}[234]Q for SME2p1/SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, 2 Jul 2025 at 13:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sve.h    |  32 +++++++++
>  target/arm/tcg/sve_helper.c    |   8 +++
>  target/arm/tcg/translate-sve.c | 126 ++++++++++++++++++++++++---------
>  target/arm/tcg/sve.decode      |  31 ++++++++
>  4 files changed, 162 insertions(+), 35 deletions(-)



> @@ -4812,23 +4812,25 @@ static bool trans_STR_pri(DisasContext *s, arg_rri *a)
>   */
>
>  /* The memory mode of the dtype.  */
> -static const MemOp dtype_mop[18] = {
> +static const MemOp dtype_mop[19] = {
>      MO_UB, MO_UB, MO_UB, MO_UB,
>      MO_SL, MO_UW, MO_UW, MO_UW,
>      MO_SW, MO_SW, MO_UL, MO_UL,
>      MO_SB, MO_SB, MO_SB, MO_UQ,
> -    MO_UL, MO_UQ,
> +    /* Artificial values used by decode */

This comment and the similar one in dtype_esz should have been
added in the earlier patch that added elements 16 and 17.

> +    MO_UL, MO_UQ, MO_128
>  };
>
>  #define dtype_msz(x)  (dtype_mop[x] & MO_SIZE)
>
>  /* The vector element size of dtype.  */
> -static const uint8_t dtype_esz[18] = {
> +static const uint8_t dtype_esz[19] = {
>      0, 1, 2, 3,
>      3, 1, 2, 3,
>      3, 2, 2, 3,
>      3, 2, 1, 3,
> -    4, 4,
> +    /* Artificial values used by decode */
> +    4, 4, 4,
>  };

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

