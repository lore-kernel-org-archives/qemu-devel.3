Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE33C021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 13:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmYpe-0000D2-FR; Mon, 24 Feb 2025 08:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmYpc-00007w-Or
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 08:49:12 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmYpb-00004q-5c
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 08:49:12 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6fb73240988so28194457b3.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 05:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740404950; x=1741009750; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I+M4tOQ6mll5tAQYc99RXePAKGb1f81J/xwo1gTYimI=;
 b=nGQKM+ohkOr+XZu6pl3LrmS4lQ0q6an0e0Y1V764w6lGIWhVZohoiMgr8zOUTKAZbL
 FdOzV/fE7SjwKOnQIeu3niJntufIxarq9H1B/7NVbKLgZuGVcV408tyZAsWsd9zL8uxL
 cJj+qmCL3JsF0xBsW1gbvd5sxsL0ulbt10e2vLbOBRXyH723sAkTgLSQvt2So8y91Bqk
 Mv3If2WrJBjLtzmuVevez+9XMs0fbD+7gqwZeQovDlY3ZMquHQ73l3Lo4YRl0cUv3DFj
 F9KoesB9qRz8vuo21ybiyD6MBA2EV72OqaVRmFRNDRjHWPnT2NDGjEDv4ZBS8fiM6XtE
 Kk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740404950; x=1741009750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I+M4tOQ6mll5tAQYc99RXePAKGb1f81J/xwo1gTYimI=;
 b=SuOm9mmOyi+3N1B1R92egruoIbZ187FJK6jaWjzvQ90xJjc1hNQyb6DAz+w37uNtI1
 +J1+5BsBLz83PaBPy/49YuQXI44XNOuXTNOTLG2aD/z8tXFj+O0nA75/3cm5x4zqPrqT
 BKRgNgdGSiTniOz3SGaTHisLzmj9dulqhQdzAUMnlVgQhWW7RuElyO6KPCuBys/DeWAs
 coJRhlXxX5JrzM5vAZSmhUGjOt1I4xfofd+s3W0toQr851IQOLyr+dIHtn9WanxT0A7n
 lf+2ZDyVCHn937ic973rCRK0wTFvO6yHerBisXAVy0tm/sDKPc5k0MNf4IDBLditDmlb
 PlYg==
X-Gm-Message-State: AOJu0YxzAnEouYymqLwCD1O8CSQu4dCeczWofmHxWr/QbMBXWRJDRa5v
 7emwz0RT6xno8tkYBeKVJse8XxNx3lLckOJiYOiQ1N6ICi1vIvvWBZ2qhQXgL5TFWuQSzVj9V4Q
 DYIbBILWOgohI0PAI60gd1l8CImYtmO6fpzSl2w==
X-Gm-Gg: ASbGncvp0gZBv4ERUBtKG/p/uOTnpJtettsdeutGVutD8mXA7hpD23LIUKj07WP55nl
 B6+5THLlYhLpt4LDotDvr7T7UYPkuDvqDSqcgxIyDRhXU7zPrWnW6UMVS+CbKPdkq0PPnRvcw3c
 AnW2iMwD9N
X-Google-Smtp-Source: AGHT+IFShS2vHP/f48Vx0ILBVzYplXtP/gDT4d4SPszoqmbQN+W83YeQODFUek0RMG7ZWzUHSioPXZSDBdG4tZJyWHs=
X-Received: by 2002:a05:690c:4989:b0:6f9:82a8:e5dd with SMTP id
 00721157ae682-6fbcc365f82mr103673837b3.29.1740404948039; Mon, 24 Feb 2025
 05:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20250221145419.1281890-1-mochs@nvidia.com>
In-Reply-To: <20250221145419.1281890-1-mochs@nvidia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Feb 2025 13:48:56 +0000
X-Gm-Features: AWEUYZnEk0p8LXBYiirBPHKlN1COmmRsO6ZpuSdANnTpj-SFDWKtD4UfC-sN3ys
Message-ID: <CAFEAcA_8DwF21QnFxR8F8xNi4ZgvtVa4sgFOuymZt+W9mxmb8A@mail.gmail.com>
Subject: Re: [PATCH v6] hw/arm/virt: Support larger highmem MMIO regions
To: "Matthew R. Ochs" <mochs@nvidia.com>
Cc: qemu-devel@nongnu.org, nicolinc@nvidia.com, nathanc@nvidia.com, 
 eric.auger@redhat.com, qemu-arm@nongnu.org, 
 shameerali.kolothum.thodi@huawei.com, ddutile@redhat.com, ankita@nvidia.com, 
 philmd@linaro.org, gshan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 21 Feb 2025 at 14:54, Matthew R. Ochs <mochs@nvidia.com> wrote:
>
> The MMIO region size required to support virtualized environments with
> large PCI BAR regions can exceed the hardcoded limit configured in QEMU.
> For example, a VM with multiple NVIDIA Grace-Hopper GPUs passed through
> requires more MMIO memory than the amount provided by VIRT_HIGH_PCIE_MMIO
> (currently 512GB). Instead of updating VIRT_HIGH_PCIE_MMIO, introduce a
> new parameter, highmem-mmio-size, that specifies the MMIO size required
> to support the VM configuration.
>
> Example usage with 1TB MMIO region size:
>         -machine virt,gic-version=3,highmem-mmio-size=1T
>
> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

