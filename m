Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4650CC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjsJ-0008HS-0j; Mon, 24 Jun 2024 09:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLjsH-0008HD-Kv
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:36:49 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLjsF-0001yD-Tb
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:36:49 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57a30dbdb7fso5448224a12.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719236206; x=1719841006; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MS+wQnVORVY3/VovjZL2n0flSwot/Y7njZyC7HF+76E=;
 b=E2GpebTahFgcfSV/ZEjZKgiaFVRM+OhLKSmTuKtAoma7x5m5CbbGlumoDH7HAA1Pfp
 BGhCoNy8jSyNilBnS4aONhoLacLI1sesvjpzbGqgbc4mlwLPe5UFk0SMN0DNWHDFGL8p
 09aWnFvHbl+TBxRqyfpauq5DvBlXJ4lO58YmDB0Rj6215HlThSWh1M2eany4OpwILjw0
 pTV9LDX9w/q6lcPZcMjrMHRUfusmw4NUfd5o6be0ynAsdmNzQm5/P/b1lpjt3RLq+tte
 +QJ9okw9P3DMp60/K84kASwEnteDp4iODqqIphtn6iSBOOhlopUK3fYQTIqe2/X+B3JT
 Hs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719236206; x=1719841006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MS+wQnVORVY3/VovjZL2n0flSwot/Y7njZyC7HF+76E=;
 b=VLgCNtr5WgQtbaZcvwv8JzntckMm8OOY7X4/QMagOHmRjDcRtjOeImZXCKfIg0z0a3
 mTZgS4sKfW+KJEU3UXb6Z/n/MZyW/u5nxP+iC7Y8YVHc1pK3Of0Vyz4p41sRAaowSaX7
 7KbwQWmrvv+LAv2W+cHhrfhUBydreowFlp0iOhvo4tF/zV1uu42YuULPHi0OTZ4aqhK3
 6srqa8o10Dcn/nSuA8Rw1jkr8PneZHyXh0hIo0Xo8EF3t/nmEM8IR3Ur6bllMJrsDBzE
 p49MU1twpji2PQCvaI13dZT978klYr6c0OweN49dcJHAoe2PD7XteKi1J9ODPMZsWtaN
 1qeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCQXS1cujSxm3Cnk8FYB5nMJ+j20d/EWu5yYtDB9FWUe+WH0Of9Cjakl2EJWvCuiXzBdTX4uNynVcYQysUx8bXlquSfcw=
X-Gm-Message-State: AOJu0YzANRxxfpf1UH3/tS6S3NPsNAIG3W+m+MPnORS/9PWI9uJDKCHO
 EICd/OH4eJtN0Pk0ls/LI4XuvCiIYoFntASeBgHJq6B5zsDI9fawCXJFwTQunqU+LHDVfFYKQnS
 Q9FdMcqwNJiHmVisacrmrb9XySMow0qWcn1YooA==
X-Google-Smtp-Source: AGHT+IHWftPsmcLNRwVAeE0XML4GyJSAxoSY919JYk81pnPhkWNgI5y+iWGlarUwap1XoSJ6gMiWNBsgxXThjM3Ds9k=
X-Received: by 2002:a50:c058:0:b0:572:4fc3:3a28 with SMTP id
 4fb4d7f45d1cf-57d4a28e8bcmr4060764a12.23.1719236205654; Mon, 24 Jun 2024
 06:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240619002218.926674-1-nicolinc@nvidia.com>
In-Reply-To: <20240619002218.926674-1-nicolinc@nvidia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jun 2024 14:36:34 +0100
Message-ID: <CAFEAcA8MnL8+TKHsCZ2c18g0+-KyL1X4PeebFo88jQu-vU-Y5w@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/smmu-common: Replace smmu_iommu_mr with
 smmu_find_sdev
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 19 Jun 2024 at 01:22, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> The caller of smmu_iommu_mr wants to get sdev for smmuv3_flush_config().
>
> Do it directly instead of bridging with an iommu mr pointer.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  hw/arm/smmu-common.c         |  8 ++------
>  hw/arm/smmuv3.c              | 12 ++++--------
>  include/hw/arm/smmu-common.h |  4 ++--
>  3 files changed, 8 insertions(+), 16 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

