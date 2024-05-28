Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F917C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByy7-0003C3-Ex; Tue, 28 May 2024 11:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sByy2-0003B1-GI
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:42:26 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sByy0-000543-1W
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:42:26 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a5cec2c2981so50278266b.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716910942; x=1717515742; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nujjuCfOsctSzG+VGzSekO6dwzpNPN6IdY5BDfvPr9g=;
 b=VNds9trLytwJvt/8l57/B5YhAEftxct4cU8CCcn3QUTZBjhkFVo85HqM2x0vrLrDwK
 UsOjIOGtKdlGAtdZvXSAdPxQ7BNt2K/RkdeCsEe5hlIuKeazJm+e0VuPK6vWsLV3Y+zj
 ntS3A85gwkOpV7NHigQ4eyfcIMjtqKRBSe56ENFzNjbKg9+A3yHMtwDDrdTvY5L/Nkz9
 Pp3vOUpex3Rn7P7E8uv+7dQHrEQ2e2mmp6XhHm1aTMKc15Bp9khSLBroFEmyEVa/dK+n
 k9ZwAf3WT2R5C1+B/NqOHXY1DfDAtEJv6gPB9TP4kasgcM07qBtH2h2v/+LCQ0eRGzo4
 YU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716910942; x=1717515742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nujjuCfOsctSzG+VGzSekO6dwzpNPN6IdY5BDfvPr9g=;
 b=rjbQPmdtkaAj0D6iTreZlY1EMaa8P9AElBrMdaZdCUHyCoSSbEJc4WEcDG72lreLST
 V0XFd6kwZalD6ZhtviFrDJPgJ/oP8dORbazMmNyWd5h0vRY028sODh8m9hbV6Ihw9XEP
 Ud+6/SJYkIR4z9TX+soUAzJIb09T4OFkL7BDR/tAHRW/2p7sYfe9SdMZPdpCBl9+MauF
 8OUOFtrUJIbokYDsHvWBu+AmAFkwd2YM57hxOUlei2swHurTZH7oAs2eHZhOACYY3OHl
 2Lw/P2H2lonTelqz7CUWx2HpDFaLq50G7yyPcefaBACsSqN6wYTTamVBGD9My++1KFp8
 WtUQ==
X-Gm-Message-State: AOJu0YyTC8ZPwctT1ckiJD6Ght/cZ0q1JX5ty4f7GADighRY6vFRNX64
 2g1VR5G2KrhE9lKHfEpY6wMNdvbZ/QUjg3W5Ef1r2eUneHQM4qj/G/GakJnmEQqsc7cnuvpyuJY
 91efBEjSF2S/Iq2Mt78ccW8z8Ofe7R8QDtehbxCX7KpIZoCL7
X-Google-Smtp-Source: AGHT+IEz+h4x+MtmDdkq/3YVUkovhQM/KmuT3k/3SPPzepfW6utoKt6AM6dTVEk495wMyb/m9SL0gtgJ7gNQCI4cz/s=
X-Received: by 2002:a50:d649:0:b0:572:6af5:1b61 with SMTP id
 4fb4d7f45d1cf-57851915266mr11800496a12.6.1716910942581; Tue, 28 May 2024
 08:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-41-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-41-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 16:42:11 +0100
Message-ID: <CAFEAcA_OkFbPCumCpv2GB6zN69PZQ5YJJNY6VnCMZ+SXRxdNqQ@mail.gmail.com>
Subject: Re: [PATCH v2 40/67] target/arm: Inline scalar SQADD, UQADD, SQSUB,
 UQSUB
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sat, 25 May 2024 at 00:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This eliminates the last uses of these neon helpers.
> Incorporate the MO_64 expanders as an option to the vector expander.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

