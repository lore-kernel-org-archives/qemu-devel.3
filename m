Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1151BD65553
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 20:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG1z9-00061V-Cu; Tue, 26 Nov 2024 15:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tG1z1-00060Z-V2
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 15:16:30 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tG1z0-0002tp-AW
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 15:16:27 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so277010a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 12:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732652184; x=1733256984; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LT7lf+IgSHcWOIDv96fLJzCXaOar+Yp/Fpwj66/+LQ0=;
 b=EG48NiJK+2WqtYZfnqKVSs1fNy4FySPzB3PrjmrMASUCP3+cR3LV53X8tTxiuEmv/O
 RwsKVb99TjtZfYvmHpjBlgSaXqDx43RSCiDijnBj8rD7zh3xbW6urKOA/IzQPKij8j7B
 79vk7bcZiurNAFTwnx5TI2HEKU0cv4MuOa+MEEEcclUd9lGsdIITUYeojOnZsQ2msGYC
 CeD0j6fsuHR7WOKRqR+1wkHDffgT8wFxpFyTb0TbbglIJwp742HfeyQTy0ne+UxzcInq
 i2Bi/PbRDhdPgO+kcenfnFu6jEwv9YyJykL31Krux3QLk5YZuF397lNFNHQJ/a7Juc/4
 Ud0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732652184; x=1733256984;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LT7lf+IgSHcWOIDv96fLJzCXaOar+Yp/Fpwj66/+LQ0=;
 b=eiq8AEPQ32WfIiIp2yasW0edDvBuzEV5V2+9Zz6ZF170ZO4k3effsDzQp10gUrkrfS
 smGCe6nFZi7yscU78sy88j0vtSLjgI0rT3pWEufCxUd+lLoflzIHSuRYtqSRHsTAA07S
 I9zs2LtoZGPsfn7NRLgCkoaUK5KKu0C+Iqqv04A7DfDkyfiIa786Kfjt+bgr3pZZOdqO
 C1dGL5lrbZTEr/6Xczg7/Aflb9ZxGwzWoNFJIpEkWSmohc9FS8T7X8oUO6gNj+1zj/c1
 RocVywzU4DJ5vvmGiE9g4BnyTYDVR+e9kg2OrwDx50Mg3FEMVVPKoDbPLEvnQXYKk0J/
 +Mxw==
X-Gm-Message-State: AOJu0Yw5z60ueKyaTKYlBez7OI8NFewjypYO8Qfwhsci7q69IEjBrO05
 yqTwA3Z2VKfBWXMJF6uosF1JggcDWwjMWqZFYNsZ+LxYUmGK624R0pab3Yn8GpqvRvuwmzSZ4Fe
 FbFGdO8MMduT8cxQDHYEHUx4iYqLS4w12XBi5BZs4lY6knfJx
X-Gm-Gg: ASbGncv2SdeGPDaBBcewbRoihvX2Jb0gS0c3pBu+vxlMxAarzxE5tJIFUzf4KdRpZ9c
 JSzqdd1GOFjUSAfg2QBE7uSFWXsSzQDXl
X-Google-Smtp-Source: AGHT+IFgjl/i480ECl3/Gy/Rey5jo3IXLwJarI18b1RUkj2RT/KtMu7cu/4rSjzizKA/IzdtbKZm/wEVZdvjva4cejo=
X-Received: by 2002:a05:6402:40c5:b0:5cf:d1b2:b44e with SMTP id
 4fb4d7f45d1cf-5d06ad516efmr5003259a12.1.1732652184234; Tue, 26 Nov 2024
 12:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20241126170224.2926917-1-peter.maydell@linaro.org>
In-Reply-To: <20241126170224.2926917-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2024 20:16:12 +0000
Message-ID: <CAFEAcA8w6mWkzHY9=xwbfX39E6E8-hEjwz8+tPRCBRSWUz5kEw@mail.gmail.com>
Subject: Re: [PULL 0/9] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 26 Nov 2024 at 17:02, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This one's almost all docs fixes.
>
> thanks
> -- PMM
>
> The following changes since commit ba54a7e6b86884e43bed2d2f5a79c719059652a8:
>
>   Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-11-26 14:06:40 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20241126
>
> for you to fetch changes up to d8790ead55a2ef1e65332ebec63ae3c5db598942:
>
>   docs/system/arm/aspeed: add missing model supermicrox11spi-bmc (2024-11-26 16:22:38 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * target/arm/tcg/cpu32.c: swap ATCM and BTCM register names
>  * docs/system/arm: Fix broken links and missing feature names
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

