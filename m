Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14552E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZr8-0001DH-S9; Fri, 06 Dec 2024 10:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZr3-0001AY-Db
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:02:54 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZr1-0001pg-Uu
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:02:53 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3d2a30afcso596374a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733497370; x=1734102170; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a/NiNP3SfB4ZIhzC8wVnkCzIay7xezilJh9Qe3YoSJs=;
 b=Kg0kIqZg8/+MN06cIR+HImFns8AGv1u4YAtU0/XxRNUX//0/OPIrlpZg66IrjUfMGU
 7zvtWwuMlI7GiOXqa2itox7RD+a/79SjoMO2CX3UwRBJil9RaLd6nwdbrq/v1pdJwPos
 cqVa/iTM5E+QKmOmYbJyoOSkrGDornbrcDIIa2DTOET4Uyn0ZnkUiAhX8PqgK6qhHuOO
 XHgbBLOUd64Pi/34uIw0ePQrv9TrEoigo7iZGxtmSk2WXLQQelI8xg1PbQKKH2xsCxRX
 K5la+dawOOR0ETodfdzPZVhSN30m99b71S+X8A3ORhoBzIebCmfqwXLEHY2zbHpMaHM1
 LLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733497370; x=1734102170;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a/NiNP3SfB4ZIhzC8wVnkCzIay7xezilJh9Qe3YoSJs=;
 b=aQvbah0qs7g2H3iFDA5m8LFvChCKoNbFULWqHInUQrBNDAQ6BbvX5hzsWPEc+fDkTq
 DemX5CT4/DKlSlXZ9RuBYkSRBi5m4zzswX8N+e7mj8dBSEDF4SYYAiSRqdZomanerOGO
 3aIr0YlfHluUHqrbVfuPTJQM7Jw1Zinw4meFTuYD84mnpruorSk7/B02CGnels+ZtYvP
 MCtMP+jPVWisSdulk6Wa8b4CLTCnkifoyE4YHppePRdwo1LueBZbF94r1oPS589fZI76
 GBH5SLp1SdxoU9+E6fNM966osqMuov5L82Ss404zrf1ht1mGRtxK+kIqD3vj2gu9jGu4
 oIWw==
X-Gm-Message-State: AOJu0YxFXVLYQSbarxuqK09+UhSQY8i3XoMx2MlCtNuwvGxt1nVWHIgk
 1ExrBLh7pTy/P9YopI6AgqiCaE/88xJlCmFrDO1SkCe/uQ/VFbQdrD2IJfxcS1Ue8god+VTNVm3
 XjMtne11Yva/IzmOtyJr4Px7UjheHvUJHJLOvZGcxAKUZSdvx
X-Gm-Gg: ASbGncvfNxPDpYb4/guqvu2lhguLEgDwaQw47PcB5tTbwHt5tpeDjIsxb691sQKB3Ek
 D0jHQJWNtn8NGdn/jgcx493k0PBMki8sW
X-Google-Smtp-Source: AGHT+IFsu01eSzYBT7Yc5rj6EYPwUCoU1qGRGequ6lC5THsUCPCei3fQKfE0TcBRKrevkdcjsdllPT3eAxpQJGLeyD8=
X-Received: by 2002:a05:6402:390a:b0:5d1:43e4:bcaf with SMTP id
 4fb4d7f45d1cf-5d3be4656bemr3220830a12.0.1733497368324; Fri, 06 Dec 2024
 07:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-39-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-39-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 15:02:37 +0000
Message-ID: <CAFEAcA9EMaJew3b7+y1ehDLftpATSXZLZqRuHPT2QhekQgDD9A@mail.gmail.com>
Subject: Re: [PATCH 38/67] target/arm: Introduce gen_gvec_cnt, gen_gvec_rbit
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Sun, 1 Dec 2024 at 15:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add gvec interfaces for CNT and RBIT operations.
> Use ctpop8 for CNT and revbit+bswap for RBIT.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h             |  4 ++--
>  target/arm/tcg/translate.h      |  4 ++++
>  target/arm/tcg/gengvec.c        | 16 ++++++++++++++++
>  target/arm/tcg/neon_helper.c    | 21 ---------------------
>  target/arm/tcg/translate-a64.c  | 32 +++++++++-----------------------
>  target/arm/tcg/translate-neon.c | 16 ++++++++--------
>  target/arm/tcg/vec_helper.c     | 24 ++++++++++++++++++++++++
>  7 files changed, 63 insertions(+), 54 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

