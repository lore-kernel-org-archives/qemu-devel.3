Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5591C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 14:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOdY5-00013x-SD; Mon, 09 Jun 2025 10:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOdY4-00013D-1R
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 10:32:28 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOdY2-00054v-36
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 10:32:27 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e7dc89108bfso3570145276.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749479544; x=1750084344; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3rG5HcsB4hpidPPhVtVmmdnh1ZPkuyYuDe3/kjf3D8w=;
 b=XzNByj3kBlg98kky8zYly6Bikrlvb+E0n2ASnBReNKH2mmFgAdrDmHsyKmrriu+TQC
 1zFDwAtBxegM9TZNOq4SDOGYRWMunGtK4+K/LngHeTgD43OKW++Yhm4x5NZE82/NPYs8
 NvP66XnzVwutSdB+V7XK9tHuWKJhvnLxsjQ5NeJR2XCetF7CaSL9cr9W2nrLSeFj2Gma
 2aPhGxC9Uw8VK+ihdBVH33ogANu1JkKHP6V4O6iemulj8Hc3pnlGSphd/+uEbVx9AaSz
 xE6/C13D+aoD/5GOsJccMYsSM0Sj4a0nHm9ZRGE5ubZtO+yIFs8lqS+m8yJpzIEv8yo3
 CrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749479544; x=1750084344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3rG5HcsB4hpidPPhVtVmmdnh1ZPkuyYuDe3/kjf3D8w=;
 b=odJew5RC8kZcxSbICobIfPY9aP2bTiKcABwUONoXcDR7pyTb15DpKl9Gamdspji594
 p+2wBED+QWTN23AuHyqD1B2/tIKnSTbmeEu14uCYr6nLnXCQEVRrLuOE0j0q3BA/pOT4
 cwkPmVDBi6pWrLoItjG8KNP2zsg1ScrYcTEQv2bWI3MVYazieMB6WfgNOU4Vc/zDWBVl
 jX81L9Qx/UgLiey8EEz9bLB2G+KlfgGPRzL3OWKtSD10TKzynEfGOIVdMPquJU2hiEEn
 EBftZN6EXM5ququWEMU3+71u/JcEUTq+WPCQWoLpGS9nKN2SrnTzh7huL7rKOuRybt3P
 ohag==
X-Gm-Message-State: AOJu0YzT1Dyfz7KSgbTS/sLK6Z4HKzHyftNhc+0YdnHuhcx6qWPGHpk/
 LbvdypnMrFX9+Kgkk9fySI1qB3MiskVzU9CKGU0gFRfQ0q65WLKWTNibK3/5IM6R0DAHucMjubc
 7nPO1pSgmWUKRHPiJGT1yEjjDpBeLKFtiOdLSKSwmTA==
X-Gm-Gg: ASbGncsoEeDzaOEOkCwb6+amQVAh02f4tdvoPgrD2l5EgMbp25dO9UCgjJL9xyVIYNu
 93RVbztkQQwA1u1uw7k9UA2/ujH4vN7afh90JtQVg8VXe5jvrWgbKYUmuLFpXeBC3ntIapBOorS
 lDqRQHc+B1mrc4TNDAgbCDPJUMSaInrpORVk9mCWm8Wy4Q
X-Google-Smtp-Source: AGHT+IH8qK4MD6w7pHT7NqE/59mfe2g4WtaQ66QEJbAu8axcbWZ4MaIlAPSFQjgXVCI5n8HjqaagR+cErPMuRfmb/Bc=
X-Received: by 2002:a05:690c:3685:b0:6f9:7a3c:1fe with SMTP id
 00721157ae682-710f776cc31mr177351737b3.23.1749479544111; Mon, 09 Jun 2025
 07:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250605022640.598308-1-taotang2025@gmail.com>
In-Reply-To: <20250605022640.598308-1-taotang2025@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jun 2025 15:32:12 +0100
X-Gm-Features: AX0GCFuMAXdGQ5vQ3w_Y8wVfZPOV4HIAcF6G11ihjE5nH6imX74MHr0kdzHydSM
Message-ID: <CAFEAcA-B2o+weobCK8F7TmynexmsJ_JC+Ccr4ELbPYkPJ34D8Q@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/smmuv3: Fix incorrect reserved mask for SMMU CR0
 register
To: taotang2025@gmail.com
Cc: qemu-devel@nongnu.org, eric.auger@redhat.com, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Thu, 5 Jun 2025 at 03:26, <taotang2025@gmail.com> wrote:
>
> From: Tao Tang <taotang2025@gmail.com>
>
> The current definition of the SMMU_CR0_RESERVED mask is incorrect.
> It mistakenly treats bit 10 (DPT_WALK_EN) as a reserved bit

This is because our implementation pre-dates the revision
of the SMMUv3 spec which adds the DPT and this DPT_WALK_EN bit.
So for us it is/was legitimately reserved. We use this constant
value to update SMMU_CR0ACK when the guest writes to SMMU_CR0,
so ideally we shouldn't mark bits as non-reserved unless we
actually implement the feature that they correspond to.

We don't get this right for VMW and ATSCHK, which are both
"RES0 unless the ID register indicates presence of some
feature" fields, but which we allow the guest to write to
(and cause updates to CR0ACK) anyway.

> while
> treating bit 9 (RES0) as an implemented bit.

This part is a bug; nice catch.

thanks
-- PMM

