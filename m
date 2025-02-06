Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F92C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5it-0000nt-4S; Thu, 06 Feb 2025 12:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5ir-0000nW-J2
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:31:29 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5iq-0002XR-4R
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:31:29 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e5b3391b033so985529276.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 09:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738863087; x=1739467887; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dfU5V4zjdma7aQoc+LWVG7ZW26tugMNTUQmoXgCYcZM=;
 b=JVl4dvI4BPZc2uErHK+ORnJa4LdD2g18vAn3/WXzVMr1h7waFqiCr5OFAylqKB6/WO
 A3ZLn9oRwHWbiV5Qo1Uw7fbt1HF2brvhcffkS8/Nf0D67ILocY/tNQRatxfiBimKr6NF
 0TqCdwLA0xLHhdHcJEyxc0MkRdz19/oqPy1WkHbNhRMaDubWrOaoCQTn8IeYVc0K6lBW
 g6yp20UPgIAo75GBBweP6EZmJ3oV3TnVn8+8kf+57KDufnL5yJsnEaB8PhVeEjeY+faM
 /ozq4gsPLJJXuA+c+3ofyCGtiUWMdU//dtmB1UEfCEIGJn/bnvtaJyYUkKs5b5W8pddN
 KAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738863087; x=1739467887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dfU5V4zjdma7aQoc+LWVG7ZW26tugMNTUQmoXgCYcZM=;
 b=YobMShIvXoujfD7NRfLngaNtZ0pI5jczZd1Z16dh9P3ID4gAHklyQY3OFTpGNvS8IY
 /98FcF2qW/lxLyr8wOmDeqbPriXpKXAFWmC5xmUtJ3TvOlkgsryv9KSkXg/Vx4mjNhBf
 WYY4mn7Hbh4OLEGkJjGDbCKiqNjfMnvcw8910X1znLPoq/6tAVh1+m22aGd5eHNre2FR
 Ysjdu/qvIrQgMODvEtE9yC/QFIwpwxnkC+XU4YZig1p6X9fxt1GlC7nsM5vr8jcb94z1
 2lrHGZtTgy8Ho/lhtjPGRLNDNzlD9FZc6tKkJI+D9tH73BhGlBZDU1jpPPqwKINNrh85
 X6zw==
X-Gm-Message-State: AOJu0YxCNi15iNtCsIVNjc+LslZFxlhazJIhJ7AWWn5Bt+QF/XoH3UuH
 i7/r9FWcUAkv0y9whLNCB1prDMAhdYvOQqrJ0UWfmUlVhLjWkhGaXUb5u3q33jd/mQDuQbszxid
 w9barPIpNTfycmL4AX9rEvw/v6K9khpge5JatbmvC6NKvuSko
X-Gm-Gg: ASbGncvkpv8XzjGKCV3cl48wTXIGlpQYwSzmbNcAZBANHDaeJkreps/Dwqc9Q2rvsK+
 xf6pyM9lZCfe0Gc2ZD2CZ0o/v9FF+F2hC6mGcdPmKcWNrxOblZ1JIe+CuZrJzDD7xJ+qPRqIYYw
 ==
X-Google-Smtp-Source: AGHT+IFghz/VehSaPyNbvFNioixfKO2sfjBiIuJt2uo6Sqqdulb8EWirDXj3yEvbzo+SEWqHVPeRwleTv3z9e8r39AU=
X-Received: by 2002:a05:6902:18c1:b0:e5b:42c7:8f21 with SMTP id
 3f1490d57ef6-e5b42c79005mr1374693276.7.1738863086841; Thu, 06 Feb 2025
 09:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-16-shentey@gmail.com>
In-Reply-To: <20250204092112.26957-16-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2025 17:31:14 +0000
X-Gm-Features: AWEUYZn70VInlOTWSxL-cdW3Siy61BHBoAkILP2bDGcQQ2mpJrJXoFMZzqcBEMQ
Message-ID: <CAFEAcA__+Y_zQpeAck-EUB38z3OdRvDPxnD_KZewOqTApfR9OQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] hw/arm/fsl-imx8mp: Add USB support
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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
> Split the USB MMIO regions to better keep track of the implemented vs.
> unimplemented regions.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  docs/system/arm/imx8mp-evk.rst |  1 +
>  include/hw/arm/fsl-imx8mp.h    | 12 +++++++++++
>  hw/arm/fsl-imx8mp.c            | 37 ++++++++++++++++++++++++++++++++--
>  hw/arm/Kconfig                 |  1 +
>  4 files changed, 49 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

