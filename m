Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16EFC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGyd-0003zl-Oh; Thu, 03 Jul 2025 06:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGyZ-0003gz-6K
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:15:31 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGyV-0001dA-Rn
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:15:30 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-711a3dda147so84724547b3.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751537727; x=1752142527; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EYx/7QnBvX30mhGX0gngEYFo/Sqp6D3SUtEhqOi/Icw=;
 b=iiqiekgfMwAFHeLm9cVarakT5Vlc81ToFnOOxIO+tLzfjdUsdyZADVWSm7k1bxs5VX
 VTbIhr1x0tI1s76oly5qTUPekCTaSSQIF3EYisSuW5DKK33KjmAiFzdRhddbo8OKt0cw
 HGAx2hIclLvLPYXlJTCjPGkwaHcx4fKfNKAFYrqgGLZNAyVaM0ieESi7IgcNKC0L4+ze
 sJfW919MVy/fXd4jjyq8y0d3S0aBTtLFefhJJDUQ2jAHQbqExxpooD15dZqLEVKOeIDQ
 z7QnXZ278+YoHG1gxoHeLhPuswsiR89k8v82Wa89WrYzmam1eQrFTmw0MVP8A3TtQ07w
 lG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751537727; x=1752142527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EYx/7QnBvX30mhGX0gngEYFo/Sqp6D3SUtEhqOi/Icw=;
 b=VqZqRY9HHissTVCmY8D938b6L81yjIDLHYygq8hNTx+9+R1xAJzz7QeL8Nqahca7vo
 c/bbPhHvldL7hKvCHFgvxI9NayxBiBJ7odKRtclUqYIC90WT3VbnousxZyx27kJ1wODG
 RUqete+72zsjKDddJWzza0rdl/u+rpcp9MH7nKsIKzKmE+iq23rrL6Q5jOpIuJOCsZgy
 hedZZP8odWyQRPFHbm/hyvN2R446xF+l0s9B2dI5ATxGTvS8ER1UvMh3RzpsZGCfZyS4
 2q2e4J7qfZxrMqRC10sOscU3VNOvZET07fqrbvcSM2dwz3/gWNq3Cpf409yzRvQChctd
 nLoA==
X-Gm-Message-State: AOJu0YyStxcjkdvuCZcpkOGvor2aSI13bHfba9VWkH/adV/wzt1daC0G
 9KGjCniFQ47FHuiQUzeB/BaEL+O6eyXj+k/ayzZq8Bf/gvlhooq3QYd3wwywinqoDVOuoyXbgT7
 dr6qruFBnKEA/8OqLJKpojLQQxiTQBcy3GHjnwQcB1Q==
X-Gm-Gg: ASbGncsid5vvVRS7sFIg+TM/hhhpG1bfoULmvhzk/B+qCJwFxXL7IlQ/KIZ23fvPJvB
 2xv5E79y8c+anQsg2dTotNs/dM1uTjf6mzXIp66nIA1ZpNteelanY54NwkkH098jS3EPw7vVLhx
 S/XLsFrWNe06Oo3jscVGuUiMmb2LtIowbxsFeq4pvkwtFX
X-Google-Smtp-Source: AGHT+IGD0sSKXsW8oZ2peEBywSh4vEWLmdpHUQsMP0gdNuJ0o/SqHYR73U2EU4gR+xu2vrN4yLRbISkzJiqq6/Q3ud0=
X-Received: by 2002:a05:690c:6ac2:b0:6fb:b37f:2072 with SMTP id
 00721157ae682-7164d4db0b0mr89570037b3.22.1751537726573; Thu, 03 Jul 2025
 03:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-49-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-49-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:15:14 +0100
X-Gm-Features: Ac12FXxEllNTpMRXremxLHNFw05PCcDZUdy_3FWOncrWEe5sANnYOKDeLoH9DYQ
Message-ID: <CAFEAcA8bWwFZ31g1QsrQL6eNq_0ZNJ47BJ2P=yE=-BE9ebZ+NQ@mail.gmail.com>
Subject: Re: [PATCH v3 48/97] target/arm: Use do_[us]sat_[bhs] in sve_helper.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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
> Replace and remove do_sat_bhs.
> This avoids multiple repetitions of INT*_MIN/MAX.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

