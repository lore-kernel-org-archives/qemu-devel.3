Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1166C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzCQ-0007s6-Oq; Tue, 28 May 2024 11:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzCN-0007qI-0O
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:57:15 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzCJ-00077f-7S
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:57:13 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a6267643794so51815066b.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716911829; x=1717516629; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t5I6FM7wfhrQpyqcrQoFxjcsAaOC4vvrRdythIA5FgM=;
 b=MwwZ1BSQK636LEgD2yWFsaCbAUFuKZBO0VKQLy1AVnRYUV3OhVEvcNOK5z/wrxihrV
 mwluEDpbxQex+EP5atOXBVquyC6yZR2sAaCZYcCDwCD9L7y2R4JUrHTA8tErdcMaMyWK
 JQQRymDzpY3zrZWxtBBj9zhwfcCYYTvDz2hAAHrNqu3QzRXQOZTvFY9IoUmLAloEDpLb
 m2Uh5/1QfZtEW6PxH9Hjpv8QPDHhsRmATKWNISHyD9NOc221rGBssR4Fgp4EXg9iR5Jy
 rW4+tOE3TIKXPUq6Gpd+6FBnBHQHOCUus1jQVZpqK2fAIm3Da/h20KR32HFD7txt2wQs
 r2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911829; x=1717516629;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t5I6FM7wfhrQpyqcrQoFxjcsAaOC4vvrRdythIA5FgM=;
 b=SfoHi9/207wAlM0AJhQXU6Bp2e68u63F5Cqfepf6NDv7XgOGO3DS0I0FbfQ4i0P8pE
 xPdTAGvvrfRhWjPmFqb0Mt0aFxmfZkmdhFDF3eFmElzbck4jn2biz8WHxfTdDcY61eUZ
 kSkvD+CiIBrL8bBFGBnG4iV5roW20Ynm0ss5AYGB+kMYNtVy9K1CgxFeJZcjifsxnLMV
 xTeYJijeZuK7f3K+3i2YW+gmWBwxl2e4rMmxToOYWW8tGw4m7+xcWi4HJr9cXOlPk94l
 iq/4oL22XeSWjetDNjVQ2MXzaSdXnuqLHMxBlMoxfVXbxwGrUkhXPd1ytcmdpzj8mta6
 R/3g==
X-Gm-Message-State: AOJu0YyRowiDmyOnVwv38XJnD3Xv9M4qIFGPLVTYVEPNC7we5HBP2Nxr
 nzVO8fdjAZNYz7bLpVSoZw9Lzf1Gw4wmFQyo71dVvxE6g3XHdEsVk7sstIuwDuQ60JBUUuNXYr+
 vCyFl2jB0ycvbiAR4cf5TRUfyW36pIGFJAgA3jg==
X-Google-Smtp-Source: AGHT+IGtWKxaMwiouLpusdvk2kX6dCdPA/pwh1MUSr6noNZ91hqcx5QilmtgxY/NvEuXkqehFxljwn8Qb7NFLJrmIng=
X-Received: by 2002:a50:875d:0:b0:578:5756:1519 with SMTP id
 4fb4d7f45d1cf-578575616d5mr9935643a12.16.1716911829213; Tue, 28 May 2024
 08:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-51-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-51-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 16:56:58 +0100
Message-ID: <CAFEAcA8PWJzumHfxRFARTmLzEZyPJkMSkODGmsVdM2OmJ3PG_Q@mail.gmail.com>
Subject: Re: [PATCH v2 50/67] target/arm: Convert ADD,
 SUB (vector) to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

On Sat, 25 May 2024 at 00:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  6 ++++++
>  target/arm/tcg/translate-a64.c | 34 +++++++++++-----------------------
>  2 files changed, 17 insertions(+), 23 deletions(-)

> @@ -10958,6 +10956,11 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
>
>      case 0x01: /* SQADD, UQADD */
>      case 0x05: /* SQSUB, UQSUB */
> +    case 0x08: /* SSHL, USHL */
> +    case 0x09: /* SQSHL, UQSHL */
> +    case 0x0a: /* SRSHL, URSHL */
> +    case 0x0b: /* SQRSHL, UQRSHL */
> +    case 0x10: /* ADD, SUB */
>          unallocated_encoding(s);
>          return;
>      }

> @@ -11044,14 +11040,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
>                           vec_full_reg_offset(s, rm),
>                           is_q ? 16 : 8, vec_full_reg_size(s));
>          return;
> -
> -    case 0x01: /* SQADD, UQADD */
> -    case 0x05: /* SQSUB, UQSUB */
> -    case 0x08: /* SSHL, USHL */
> -    case 0x09: /* SQSHL, UQSHL */
> -    case 0x0a: /* SRSHL, URSHL */
> -    case 0x0b: /* SQRSHL, UQRSHL */
> -        g_assert_not_reached();
>      }

Shouldn't the parts of these that aren't ADD,SUB have been in
some previous patches rather than this one?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

