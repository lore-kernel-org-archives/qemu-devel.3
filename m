Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E997C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk1Mu-0003Tb-GB; Mon, 17 Feb 2025 08:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk1Mt-0003Sx-4t
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:41:03 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk1Mr-0002kg-2S
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:41:02 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e5ad75ca787so3579081276.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739799659; x=1740404459; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pJdX7/qQJf3mAfmMHlUTCUVkYSKK7xwvyyLSDw1q6xg=;
 b=KW2C9jcbrqH+5Sd2Ekx5hGp5iQlUagZnwOx8GPv8+PGY/elRBPtSVFGlE3W//l0ajC
 nGPUii4XiezKcsM4gEhJvWAKbwUTkr23GulEo7HaLjYcpuh1Jq4QZG4dY/Pe3PebOB6g
 Su0SaLW0qZ4JnXpP9TLoQIPQnC5EJ7Cmzh4jWCG1CFonq20B7n29drscAGC4QYfO/SaJ
 DJf7I+DJpfdx9CqvhzWTAGcIuBb3qifro1pBd61bCGcZ7xqlGgRj5lZlXQihhcWGocY1
 tZEdUJ7aLa0M5yyKph5aF9eqW6cap/qiHLfxYa+QYE7Y9bWnCVGdApw2ODTCUCMm+Kla
 +NrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739799659; x=1740404459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pJdX7/qQJf3mAfmMHlUTCUVkYSKK7xwvyyLSDw1q6xg=;
 b=XYmTKGJgd+5/hE1oad7Az7FPifCNxqT3Re5vnmtblv52pAg5j+PR8F7G5vd9IArmUE
 zamDn37gp0nK0P0NXAh82XuplFvpL3pyctkHJFEFq6OloUpOeHpBxChrzag168w8HdJk
 ZSK+ZnqmcJNtCbtqnOCYmWUql44gtTSPqeSQDhW6BXQo82iR2Tv1FndH5YWZUc4hxs9w
 mtvfMg8un9E1YEjwCqcodpQtRySPiFkIV7S7F2cJXfgnmz9PmAf5K7GoKFuT2ETr9Mz6
 Oi+GnrvgZChb4J2C1C/gUZtKcpl3QSQ17Qy16zHoDSYA9G9u86o8m8CBsztTiHiOlYY5
 EL1Q==
X-Gm-Message-State: AOJu0YzrSxTK++e+4CdbXtPMj0pLPo3J0xrz+9kMimRNQEtkINyElqV7
 9zuhQDNoe7RUmPKTr/yHPd+3rD3JCQBaT513WLSQT7kG4OAIkR90eCFLfK9X9wl1IUYK8GiWVxm
 D07Fh5EEAsoddd4zoS2kH98RLgHUWvEkN9ajLOg==
X-Gm-Gg: ASbGnctwEFsQrThfHm7foAC6V0ntm+V1p69Nagz1gi9nSPk+z+8enRnyJsfzfUTMKLm
 0GddGsAZ0DhZUtF45dr5xHL2+T1mYDJaoNCyQVs95hcrEhn7UKpAtilLq7McbyLlpaad71lETxA
 ==
X-Google-Smtp-Source: AGHT+IE3UF54DNxB3mp02op4nnxTcng0S0cOIsfUdHXlt+6fHBqZT6P5BQ8WlEa+hPXF9lv47o7IVUdk3J/DEUDJONE=
X-Received: by 2002:a05:6902:2787:b0:e49:5f2d:e722 with SMTP id
 3f1490d57ef6-e5dc9820d5bmr6764371276.14.1739799659693; Mon, 17 Feb 2025
 05:40:59 -0800 (PST)
MIME-Version: 1.0
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-9-shentey@gmail.com>
In-Reply-To: <20250204092112.26957-9-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 13:40:48 +0000
X-Gm-Features: AWEUYZnzonYN89Qws-aSGt3A5CeGI__dhPIFRnc3xJkN8dgocjg5iPObbDwnlgE
Message-ID: <CAFEAcA8Ravyh4_iVXvmHzQzXa=gOTu8+-OPNLRLVB78if8i4Ww@mail.gmail.com>
Subject: Re: [PATCH v2 08/18] hw/arm/fsl-imx8mp: Add PCIe support
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Linux checks for the PLLs in the PHY to be locked, so implement a model
> emulating that.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---

> +static const VMStateDescription fsl_imx8m_pcie_phy_vmstate = {
> +    .name = "fsl-imx8m-pcie-phy",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(data, FslImx8mPciePhyState,
> +                            ARRAY_SIZE(((FslImx8mPciePhyState *)NULL)->data)),

Use a defined constant for the number of array elements, please.
We don't do this thing with ARRAY_SIZE of a cast NULL pointer
anywhere else in the codebase.

> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void fsl_imx8m_pcie_phy_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = fsl_imx8m_pcie_phy_realize;
> +    dc->vmsd = &fsl_imx8m_pcie_phy_vmstate;
> +}

This is missing the reset method.

thanks
-- PMM

