Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B839C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 14:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl7FL-0005fq-7l; Thu, 20 Feb 2025 09:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl7FI-0005fM-Hn
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 09:09:45 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl7FG-0004EL-IV
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 09:09:44 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6fbaa0582a6so13886377b3.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 06:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740060581; x=1740665381; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UIZshvD68i6YUVum3s1elgKpBgGDILDeQgleIfXIgtk=;
 b=svraJXh9Vr+kJZidYyWnejLkHBSCF4y1qPPEXQKs3vvqhuW1kWCNX+ZXRujfDC54i7
 AQdEZufuFd1Vpe6BJLAKSVLtxiUzlUBCejicoeY+yC7fCx5o9A0bEST5RrCqgR23RXqY
 fgDuDD/GImiYbSK4dtlfUEqdVhzhz5PDs84rFM02G+iQXNhnGF7HLRJpXseYXwDa+Rdn
 Oy1v/iSrvvYwhOo7HqgBRGBD0qktmizfRsUYpUgLhCgxYHipcav19L8CDNY+sQIDi8PZ
 5LbsFTbyH3l+Hv8MQrxK1XdxTVuBxZBNj1xmXJF5HX6OXZxdD188AFTKSfzwq0I7azVB
 727A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740060581; x=1740665381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UIZshvD68i6YUVum3s1elgKpBgGDILDeQgleIfXIgtk=;
 b=ozW1ft4pigeG2Bxg8Nudze4smR4aVzpvhmSDY4BPlZsGbEtAqtPxY+Pvh5S31WzxEb
 XkGD4MsPhsqYhUcnro3Sassuqq8ivOO2a+pcbYakXqGkNCNLJ23fV4sY6HYzXe6h4BMK
 6Y6QPYbVs3PO+9mFiXAfFYElODBT3WnADdnUrjs4SDH0Tw104QWqDjZhdSV/L4X1n+HI
 2c3FjeK2hfbiB57CQI43gxdfK6DYkOlSfQSfxfuqzNg6KS5+Xa6eegQyO5BL8nLuAzuv
 63qQChenBQp5D98mO8ThmhQ+AUbV2CPzD4Dsl+dV10NeShrR9iGJlX2fOfKNyNt2sny5
 txrQ==
X-Gm-Message-State: AOJu0YwsrVpVwxBWwP9UbpZfhacpYNEz07MLKxc1jBOb1vZzvwXS1sPm
 pHrQ6iIOGgtEwt66BLYWoc+qjKoif0lJWRiyLgZLzuj9pOtqNFU4zOaVj5WjtzEn+zjtV8XbU93
 oj5F78ZljZtfWiCeplyAANWZ4kIdMAEby0ZvHVA==
X-Gm-Gg: ASbGncuLZisICVx8DdPNEC+a7CE0czHOQ8PCH8RlbxBfMDW8K8eof/wwuX3z7xvycYj
 i2RyMqnP8deO4PIRUjVT2IzLq4dcmSxRzUmR6qjbGt0vadzBN2JV43PNpl4djXOwaKkjieAyNLg
 ==
X-Google-Smtp-Source: AGHT+IEO1e2wgbnoOmXyF/PQtyLlc+xvtxB/jzo7c7dKNE9Zd5pGxNhgdeinSORLndBYIpTcgfeH5BuP7F8ZTILHi/E=
X-Received: by 2002:a05:690c:630f:b0:6fb:a251:2450 with SMTP id
 00721157ae682-6fbb78f8026mr28349537b3.1.1740060580969; Thu, 20 Feb 2025
 06:09:40 -0800 (PST)
MIME-Version: 1.0
References: <20250209103604.29545-1-shentey@gmail.com>
In-Reply-To: <20250209103604.29545-1-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2025 14:09:29 +0000
X-Gm-Features: AWEUYZlFlf1hUAcZI1NRD35GD7_3yphfZhQCUZ67plEEHBq8rKZ3O7hGlTEnAa8
Message-ID: <CAFEAcA-PGTAQhmktPmMvAjkL8S7UDhEp2+edwiLJT0f_xe=8ZQ@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: Extract CONFIG_USB_CHIPIDEA from CONFIG_IMX
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Sun, 9 Feb 2025 at 10:36, Bernhard Beschow <shentey@gmail.com> wrote:
>
> TYPE_CHIPIDEA models an IP block which is also used in TYPE_ZYNQ_MACHINE which
> itself is not an IMX device. CONFIG_ZYNQ selects CONFIG_USB_EHCI_SYSBUS while
> TYPE_CHIPIDEA is a separate compilation unit, so only works by accident if
> CONFIG_IMX is given. Fix that by extracting CONFIG_USB_CHIPIDEA from CONFIG_IMX.
>
> Fixes: 616ec12d0fcc "hw/arm/xilinx_zynq: Fix USB port instantiation"
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> cc: qemu-stable



Applied to target-arm.next, thanks.

-- PMM

