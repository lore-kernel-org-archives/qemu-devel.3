Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7208CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO1p-0003Z3-5e; Thu, 04 Apr 2024 10:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsO1l-0003X0-1K
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:25:18 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsO1f-0005xY-0Q
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:25:16 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56e0a8733d8so1207301a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712240709; x=1712845509; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c8ExWDHR6fUpIq8ES+mS5HgEhWRKo0jFGf4s3D+PgJI=;
 b=tCl7tGzqd54fRY+H8denh7i6qrnK4fusDtNn2nSoRP2TA3Ay8pQRPqPlATJKcgBg/r
 XXkyMnZQBH0J5vk/F3SJz/lyxX+61Sv2qMnt81BowzwLkLrifYyLt9CGdogh2d7KK/o8
 pWJs+0q6K3/S+hMkfYHdFWuxvkdFkJSc382rzk41MzMq8dXXArTjhbQFUYN7jq+vJlxQ
 oSbLUrYlIO3pEw6OmbuQh1boMenTCUbUuMGmQyZaKAkbYBpSs5uWBx1/SdyTs2LBIJo1
 g4ZfbPjNpEzL3TNcyyREmMRZUDzcK0W1dhNr+F3GKucEGj7YENs8l3/sUvxAuMFnjDUn
 vLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712240709; x=1712845509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c8ExWDHR6fUpIq8ES+mS5HgEhWRKo0jFGf4s3D+PgJI=;
 b=Wi6h2K7W7dL8+/gvSnE2da9JXGCJBfXdpguntI3PFNFPPHplkaNsEXtjwnzVXEydvy
 zlR9WUSzinOxhNoC3bJtkj9pWN3IEOM86aMTWdca3XzzrJYLHJPeVBBPBoLB8xx59uKz
 4CZarq+VFWFjrqBdS+gz8F7Vw0lMSN3tJf6iOx+pWHdZIEmFfKuQpAKe8yoG9g3+2WXx
 ODUmdU0DIIpK9uV/R9iKWlSWtqDn14f1yP4rKOh8JPbSSt+CkLC1zz3RsvbNJe7H6QOK
 hf9jCwx387+x7pt+ASekCGl9U7XYwIqJmf9YHM06OmPfc0qP9QfxO980tgFNMoKcFHYC
 hxtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZeD0TrnZDMoacTjMDP5wG5etJoM2i2W4vqsYLKtXbyJdkMvEkcQ77dC7ukMhBDsTR2WZ4SsBNIHwLop5YhLTfAzy7q+Y=
X-Gm-Message-State: AOJu0YyUJIdle9zJ0Tgb7k7wEStLY469QzrfbAqDF0xqWyGw2fhxxGU2
 7NLuSHH0HrpuPqJc++egCRc+/dCPCD8OPdV0CsBi/GsELsjWa7WPii5HYwghxqX67cTeFhbGE9s
 +zOTElSA0IyDJU1wsFluxBf7aXJ5W8DEzMnpbvA==
X-Google-Smtp-Source: AGHT+IGf49Ow575yV5dltlM7JucTrroUSaQWivf9EL9kCWy8puqRJBXupm97peIoKn1l8HPfrc3E/htxkWemt/S1iVQ=
X-Received: by 2002:a50:cc82:0:b0:567:ff26:4bcb with SMTP id
 q2-20020a50cc82000000b00567ff264bcbmr1607896edi.30.1712240708718; Thu, 04 Apr
 2024 07:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
 <20240403101611.3204086-18-ruanjinjie@huawei.com>
In-Reply-To: <20240403101611.3204086-18-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 15:24:57 +0100
Message-ID: <CAFEAcA_2b3R4KMyiO_Pe1zH9xBsUFjUW64vL3xEwi6OZQ=Z3eA@mail.gmail.com>
Subject: Re: [PATCH v12 17/23] hw/intc/arm_gicv3: Add NMI handling CPU
 interface registers
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wed, 3 Apr 2024 at 11:17, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Add the NMIAR CPU interface registers which deal with acknowledging NMI.
>
> When introduce NMI interrupt, there are some updates to the semantics for the
> register ICC_IAR1_EL1 and ICC_HPPIR1_EL1. For ICC_IAR1_EL1 register, it
> should return 1022 if the intid has non-maskable property. And for
> ICC_NMIAR1_EL1 register, it should return 1023 if the intid do not have
> non-maskable property. Howerever, these are not necessary for ICC_HPPIR1_EL1
> register.
>
> And the APR and RPR has NMI bits which should be handled correctly.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

