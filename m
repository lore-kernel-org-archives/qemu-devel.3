Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D933FC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzGT-0004i9-0O; Tue, 28 May 2024 12:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzGQ-0004be-QC
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:01:27 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzGK-0007gw-B7
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:01:25 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5785199f7d1so470364a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716912077; x=1717516877; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ItU2xJw1LbyVLk1x+30RAb/uRezAxAqiS+M0e/yJEiA=;
 b=Z92C/aoFarOxTLPpWyUAiMLcLSQvvuyH0dIRnRMBX0fvC7u1mqR1Ph0F/i7b1/xcDb
 4QqytWAN/BPLDHiRP0vIEFSRcVaAr0puBPDEiCq2qyREVRMPswoEBGjqBDi3q0ShEmR5
 sGOcFvqEYfu4tqCyDxRnedWThPy9x50xRtGWWJJ9mdrwXxXSfZ37CWG5a5c52ujSuGm7
 J4Jzc6D/KkHfIvJ9WVoWPfCZ7Q9QL59tKKCRlsJL3MeeFOTz6UJvq38ov3AxV2ZSdrjs
 EHljizmif3mPa90m0MBZQKK8CwmTQyRDq1ZW3e3cj2cp2aqh0oDkzdapzu3Vf/C4JSSK
 eJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912077; x=1717516877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ItU2xJw1LbyVLk1x+30RAb/uRezAxAqiS+M0e/yJEiA=;
 b=Wq62qnCOV1R/zQPAEhr1UKZQjehn6HY8mjv/jfqa4vrLvVDoFQ6k7o3fLBRIWFtaGF
 RqSTEsmQ2UlbKciteFGA6vHAhuWY2DPtVq4BS/NDqgd9gTyuYDLm4OIjW+8KI1C8ngWU
 OKZg/SbO01naOQw1K5f9fpzzN0Rkn1tPfDq1yCQWd4i4mXnGL+F5FK/ezowBJTnh3LfA
 g3ignYuW2xhhl7f8KHAQdlHymg8SGddAxasE2z9f7Sok2B0T0t61b3TS/HD4Bh1LTpuN
 l1eloE2i3dqSRv1iPFMeib4suuqocYs/DVpe+Oy5c1EqhAXpgfMtvnn5pli/zn1vuQym
 2/dQ==
X-Gm-Message-State: AOJu0YziHa8TTvtB+r5ArfkkGaCBmWfpIAAHFkwdCf/Klx+Ow33lnlhL
 NEAxfrKVqyz/HPfYyOVa5fJycMJpvWNLeNlOuHvBC7VVVpNTcfLKx5IkkrMoEF8LVS7dqi6yuyi
 yVWqfkGs/MS5uuDSdkmoPkQS0t0ZqIShuKhZAHA==
X-Google-Smtp-Source: AGHT+IGA82kWnyAO0exOFEMjJXfi29OL6ZdWC4Lj+GbdbatsUEA2JsYNN/Ncy8tKT9fHNOWbZuPczli46tmMIr6kN24=
X-Received: by 2002:a50:c907:0:b0:572:689f:6380 with SMTP id
 4fb4d7f45d1cf-578519144e9mr10481072a12.3.1716912077432; Tue, 28 May 2024
 09:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-55-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-55-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 17:01:06 +0100
Message-ID: <CAFEAcA9pm+-pfm3xp8boF++EncTGGGo7Ws-Od+HKsPKt-DaPGQ@mail.gmail.com>
Subject: Re: [PATCH v2 54/67] target/arm: Convert SHADD, UHADD to gvec
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sat, 25 May 2024 at 00:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h             |   6 --
>  target/arm/tcg/translate.h      |   5 ++
>  target/arm/tcg/gengvec.c        | 144 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/neon_helper.c    |  27 ------
>  target/arm/tcg/translate-a64.c  |  17 ++--
>  target/arm/tcg/translate-neon.c |   4 +-
>  6 files changed, 158 insertions(+), 45 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

