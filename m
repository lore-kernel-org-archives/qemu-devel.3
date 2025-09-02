Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F0DCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 09:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utNiM-0002st-P8; Tue, 02 Sep 2025 05:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utNiI-0002rt-J0
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:54:06 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utNiE-00046O-JB
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:54:06 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71d601859f5so40582067b3.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756806839; x=1757411639; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S2DLNfb3hwUzbT+Qfwm51/d38ALsr8Q5J9G5EBFuW5s=;
 b=NNd8vE5hg9f+BAq7U/Lith+kd+HM7K32tz+OmK7VLLRsQLzYJl/2XHPpcEvbSkRV7j
 2KHwuqLurchwpfuHCco7dsvv5uPVBeCCW2+LOIh2d+JHVDr0qER1/GpfFtaqMa7j+foX
 21idyDfi+chtFQbekSLd7oa30lc6+/yzdCidBsFqoifr3alxJzP/dbmg3uChHth4meWi
 /SJbr/eMac+Rhy6WYDW6jirK14IGBZuHT08e231NfvHcIIy2jQHEWiMNw2eKcBuRli1j
 6c3PcnCJoRfzbGFXBBswptz5SqqqsYPG4wjKhCZngJfCyAcpTgk7U5d/k7u5e9gql5Vi
 eVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756806839; x=1757411639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S2DLNfb3hwUzbT+Qfwm51/d38ALsr8Q5J9G5EBFuW5s=;
 b=mNYPHV0DnOd9FMuVySYu2IgJBNywUJv2OW1gqCn0xrwR2gjbmxlRlBkOAZrUDVDdia
 nMS1b6DKZWO7n+8PQnYHKR9KB18Yt/3+GQUE7qGSWUUySU59CfvkEBLIkHkO0WhiBjzG
 lITckJb1GHo7HBBGq+w5f50IC6LcUXGXnshLhed980cGxlMmpVuiqbGO0jHR8+uzl6ie
 InDaXy6wL9as21wfBP394492ScTtCcOip8owJoEiyRnMZjvFo5kf99wDzHcQk/0XoK5X
 FlynVWe5g1H8D/KEMhPyzW9SNqolXyd++Bh9E9xhnFudoqboYLButW7zdDDvkhn6cwjW
 Lcrw==
X-Gm-Message-State: AOJu0YydHHqVQG5jivbmlL9xE14/zYdbNnUaDDh1GAlTWV0wSI088hFw
 6v5z2LISgb2wQqvCg+A51CEtGQYFi6IWy7hH6Oc7JH//aJUtEahnFpv78ApCpJUJ/EPXe8noJUG
 EwOe+niDB0s260H7Y0RdthEB6VTap6HG4tKdkenxdWQ==
X-Gm-Gg: ASbGncv5KtGKno/2oQS+R2JOMoiD63oMW3VUJsG9y+WgPVi9Bw2aksffqQZcuBZ0d1b
 MSHpnxC6bKAk0+6CYuGuiHUF3fE7IeS1Th5+NyJBiZB9JosgDkZLy+Dd+HHFShiqyG9KqmBVuUx
 7DCIcQJ86r6GjqapmjTj0KMF2gJWTmNaPE2ZSTcthWuVD/dyfCr+Oqw9exq7xq9csqm1YddPdRg
 OGXpW2Y
X-Google-Smtp-Source: AGHT+IEq0OMs00G8PE9o7PzzTQr5VvEooHkGACYRPRPgj7VBG/g9X75NfrCKCBwBvRulpF+C0tOzsfLOGoxTNCBCyaY=
X-Received: by 2002:a05:690c:a0aa:20b0:722:7a7f:5358 with SMTP id
 00721157ae682-7227a7f6daamr97651567b3.4.1756806839336; Tue, 02 Sep 2025
 02:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250820211932.27302-1-shentey@gmail.com>
 <20250820211932.27302-7-shentey@gmail.com>
In-Reply-To: <20250820211932.27302-7-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Sep 2025 10:53:48 +0100
X-Gm-Features: Ac12FXz09qSSJ5uxJBmoGYE4yxTscF7subjkPLUIDVy-ToppFSpxBX8E1CsVzG4
Message-ID: <CAFEAcA_g08weBggnyCqLNPhOxKrZ3baVoGUyUqpZaEgSUN086A@mail.gmail.com>
Subject: Re: [PATCH 06/10] hw/pci-host/designware: Fix I/O range
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Wed, 20 Aug 2025 at 22:19, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Fix the size of the I/O space to be 64KiB, as defined by the PCI
> specification. This fixes illegal memory access by guests in the
> imx8mp-evk machine such that the FSL_IMX8MP_PCIE1_MEM unimplemented
> region can be omitted there.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/pci-host/designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index 7342207eb3..1e29b7e6be 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -684,7 +684,7 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
>                            "pcie.reg", 4 * 1024);
>      sysbus_init_mmio(sbd, &s->mmio);
>
> -    memory_region_init(&s->pci.io, OBJECT(s), "pcie-pio", 16);
> +    memory_region_init(&s->pci.io, OBJECT(s), "pcie-pio", UINT16_MAX);

This isn't 64K, it's 1 byte less than 64K. You want
64 * KiB   or something similar.

(The memory APIs have a special case for "size 2^64" where
you can pass it UINT64_MAX, but any sizes below that you
pass in the actual size: the special case is just so we
can use a uint64_t type for the argument without losing
the ability to specify a size that covers the full 64-bit
address space.)

>      memory_region_init(&s->pci.memory, OBJECT(s),
>                         "pcie-bus-memory",
>                         UINT64_MAX);

(We seem to have a similar bug in xilinx-pcie.c.)

-- PMM

