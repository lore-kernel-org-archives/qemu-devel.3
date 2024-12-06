Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68750E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJabh-0000G0-Ph; Fri, 06 Dec 2024 10:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJabg-0000Fi-1P
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:51:04 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJabe-000530-Fr
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:51:03 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d10f713ef0so5979160a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733500261; x=1734105061; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7dwN+5iJ/zEeDGeitQaXAjE3tKiZIOqfGlNo+OpjxBA=;
 b=CLmEQzeWv4NRmnJER/plMkjYXv5RD/5hlectaamHwd6xkvUDtgNfJTn6VOQsaz8bDk
 P9JxZ1W+4HN0x83WeGxU4g7W8abycV5KD8WVOVg66mXr+qO1+xI02BlDbNifkQpgmkK7
 JL94X5GERr22bKbvqBEhaY48JtuxfgPu6uYaZJ5SrGtqowW8WWA04MOjGVCkWaBCMNE2
 qybCiK1eM8e+uTh8sjn1CB3Jd74WL2ODe9Pv1wxMeAvoQCeY6hz60VuLzHeuNwWHv70W
 sh7+2U/xJ4F6hEMWqXtz6Ayrkay1tjyY/W3aAQQ/Q5ljKxLttyYShxZRwIG94AHenPJi
 kTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733500261; x=1734105061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7dwN+5iJ/zEeDGeitQaXAjE3tKiZIOqfGlNo+OpjxBA=;
 b=WpxS8CYlgYaXYXJ4yLd1ueiNlvTU08+Z48MJtCEdVT8EE0ouMEwjEj51qHDc5+c7G2
 v3qeKDUVW6ngg43uPciYIf94stJBB+7lsEUMA5exZzhPyBHwTrCWynOCfO+W+Dk2KYWQ
 SbWvzAFtQquCeU9h12k0+KvZSCJMx5Od9nnFHufYFxDM/CZZgH7n+XRF79XoKn0SI4xu
 +Kb+Y1e1HJ+sFkEKHAGNXJo1de/uU1tFpRZI27+QkR1M0Sbn/Nvf9OprAzPaI6tVR9ba
 7fG6YbJ/rPDWfJRfW4uPvW/X0LkgEKQzqh1LWRZSesbcKooJx0otv/Tdt+mXkB02HFDX
 6oMw==
X-Gm-Message-State: AOJu0YxAhNJMZe/d7sLiFAm5FC3gLsfcnL4VPpHaVvgdF/UfOP4JQp1K
 neveOVRt3L+3IrVUEbvNfiEfqMsy+6KbCPhqz46S81gE9RPAqsGZw4g753LOZTG97zzL4o6WCfA
 MvFjbtcq/F3W+wZfu1Ujj3GWdSdAestdRbwjFDQ==
X-Gm-Gg: ASbGncshlUGeIgPt59ECUs4fzlttMcuH0Sfz4swQGz6Q3Q2u7Lf/oElmBD7+UtOHLe8
 gG9r86u8pKqnKjmYH+u+v4f1SDMfXjuwZ
X-Google-Smtp-Source: AGHT+IE914gnqeg+qZBVIJtXBASB8/mjyFX0iAjTI4FlrX9LR4s36HCA990oiXitlT5FLwVphNqXNd8aVg8DWZ82rvk=
X-Received: by 2002:a17:907:7da4:b0:a9a:6c41:50a8 with SMTP id
 a640c23a62f3a-aa621892191mr785701666b.17.1733500260853; Fri, 06 Dec 2024
 07:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-51-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-51-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 15:50:49 +0000
Message-ID: <CAFEAcA8bsoLXP5yOEnuR+uy1gOHdGNfPziZ6K3sZ0H6j=oPQXg@mail.gmail.com>
Subject: Re: [PATCH 50/67] target/arm: Convert FCVTXN to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sun, 1 Dec 2024 at 15:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove handle_2misc_narrow as this was the last insn decoded
> by that function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 101 +++++++--------------------------
>  target/arm/tcg/a64.decode      |   4 ++

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

