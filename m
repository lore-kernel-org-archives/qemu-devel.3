Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EEDC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXIzf-0006ft-OD; Thu, 03 Jul 2025 08:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXIze-0006fC-BV
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:24:46 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXIzb-0004Lm-7d
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:24:45 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-710bbd7a9e2so57212877b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751545479; x=1752150279; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v+AwiiMWyFBLhFTvXF4KFZt1rk+9QPIOjHq7O4/eo/M=;
 b=UxgkinChupz3PcdwFINiGQdNAaUFbH5zre+gLIZj0ro70PhPOlYvaBipaxKVEcgZjc
 NZyEPAtbNW/JIcr4fuqCZ/Od4ZyqjgNFvRf6Yg0Iwx8XK2bKgONuNeIsYHYcHbmjjFF/
 Tbyd+MvwYKQxBOjACsxbgaT4P5QhwqgC/h59daB45PuorAT/Jr9xStpGW/1YNpd50g2L
 CoYrw1SWD8t0ACd16RDK4SOIcUUkAG/frvPDk9aDFNJRGFIPQIB0aiMaUgcSlilArw1n
 WWsYm1B+JuS2Ol8UoE/die1B/u4Jidpehpvx1jLAJNrHzW4gGu7AbK+aVzzNpmqdNuk8
 AZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751545479; x=1752150279;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v+AwiiMWyFBLhFTvXF4KFZt1rk+9QPIOjHq7O4/eo/M=;
 b=oNnu4l27TNrMbonKiIdgKzYfs3L7hoRsKjfO2mV4acjDp2E7exXC7vH0N0JHRCY47I
 DrPaonym2LByJ6aRuin+pLR1N134NN7r1BKFxRdm9lk2yKeMwSFqnHryEuuF8wf01uSy
 FTK161kiU5ExQIVFFnR8pCq4aFaqtGebGtLU3HRR5hZQ5Q4VG7fKaPe3hxdFCAwOL55D
 5YyKa2U05bN9wqtfTn1p8Hr8U/ZGShbIStJ944epa78giqPQS9gXAbayS1Cnbj/0odSq
 i/CbzLYt6GzA6fxAKAfTQc778sbZkm9G41JoYVsOpQjW/OdpABeVZHAAJTPdps04BAXr
 qZJA==
X-Gm-Message-State: AOJu0Yyy2ox7DfGGRLXtfDsKJ+DZoR4UEsGdusW5wDgUgFdVZohgEhpf
 5A53pGiH+IhpdONapVdM/2dKWN6L83KqU0lVhtgVYEHoKHZdKeE6JsxWNRd/fsu8AMgGAuZaBhu
 ovtImzJPj/jZCXqOmLoEtaX/ksnbBeQ8/X3kZciqOart43sRoXNAc
X-Gm-Gg: ASbGncscUSTIF3YFVgDpEj93JBu+O/Z7cyeDTcR1DaALccA/9z6lubGCP9g3K31lOYb
 PGXDdjjUqjDFK12ntmRSHYAjG2/oRavC+xx2fysJytNuDbMJHuoLogErhvaiA5YAUKXxqsol89I
 wEpvzSPiLcBTBM5vbb6Js0d0mp2lrCD9Kkbms6WFLQ345+rqZ5eAkVPOw=
X-Google-Smtp-Source: AGHT+IGWNilNVBTZostVgxI83dSWxOV+umz93PjR5EYJT2KPLFrKBcFQSBiv9OV3jqHjo58gkVGW075xO/lFnnERI0I=
X-Received: by 2002:a05:690c:6a11:b0:712:d70b:45d5 with SMTP id
 00721157ae682-7164d4cdff0mr92240717b3.33.1751545479374; Thu, 03 Jul 2025
 05:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-75-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-75-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:24:28 +0100
X-Gm-Features: Ac12FXwo5TfK5W4YK9-rSWl8M1AJuMb3MUJ0BTQgbIcJ2_0drXO8scdjMQNPtJg
Message-ID: <CAFEAcA-MfbiYJJjLZutLqjroXJTwO38LwdtypV6uqhyU-Pzp2w@mail.gmail.com>
Subject: Re: [PATCH v3 74/97] target/arm: Implement FADDQV, F{MIN,MAX}{NM}QV
 for SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sve.h    | 49 ++++++++++++++++++++++++
>  target/arm/tcg/sve_helper.c    | 70 +++++++++++++++++++++-------------
>  target/arm/tcg/translate-sve.c | 48 +++++++++++++++++++++++
>  target/arm/tcg/sve.decode      |  8 ++++
>  4 files changed, 148 insertions(+), 27 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

