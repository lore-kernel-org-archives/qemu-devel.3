Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A7CC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk1Iy-0006hi-C3; Mon, 17 Feb 2025 08:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk1Il-0006eR-Sf
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:36:49 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk1Ij-00020C-P4
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:36:47 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5dcea5ab3eso1230508276.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739799405; x=1740404205; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6c6UHa65sfkfOyhFhg5Qtleo7e4M0fY7yLvKY4FAG2I=;
 b=pXKzJTWAxJpSOmg48Q9tp3++xbEJtf19V247r7+R95xJERUemfqP4hGbVHgtd9HTA7
 yOnp4+jgg++h5X50wNVvystmpoNuTs4mppjbPJ+JelpIkRMEQsI/df9x1DKNgl1Sv5Kd
 KZc8PdAfH3XcF/AR/ASt+PBTLi9guQBZ1n3OhmPNYzTnecQQTv+fZzloYNINn40TpzA1
 88qPfPiRZ1kVcCCKmxYXynAYOIvY4YThk70oIMsctwoJ2aovuTw9vjEOKkGHNo5qTI+9
 Ty7G1zqRBQWwrMCnygtoXChmJVyM/0d700Va2FqE96R+BkYrNKXOzx12ee8eLZDA79hG
 /eJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739799405; x=1740404205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6c6UHa65sfkfOyhFhg5Qtleo7e4M0fY7yLvKY4FAG2I=;
 b=hAd7bx1GmJ3rQq6mgsIVQ1AkLFtOsVP+wZQCcfQCvGUrcLif9OCCKqIYmeQprYFkxZ
 98Yr0SVT5GJ1saIH+aqWJgFCApezzisEaB+dvnkaN0gCUVDnP7DzA4u1hQ1rozonG/ZP
 iOSWDvcmij1qtXBDrFT4SCYdRXm633qJwUrO0+dQGQO0KPwHQOxsO9gNkVPAZG+zqLw+
 ZRKJlciT0ZkTzXJo9Pb8StUUNcAaHCZhG5edNi8Qde0oxP2TyGHfczxRhIcoSJnJRk1G
 qJtgHkCN+vEjznyUN95ZABCQYjwJBsGjqkqDRy1wCXQiBoTJgQkgXEMtYGBBbvH8GYuY
 SUBA==
X-Gm-Message-State: AOJu0YySjDKNVZVQUNcwW6kfT9apT423Xq0bOrNGkBJqr8tYBkXK+gHO
 Sp/LHihqpubd3xEPAr3xL81L3iHqSdacUAehzVzP4+bh58PC7s3ma6pdD2PxEecJvT+8dkMzAI3
 d92bKlIUNzOxJntoQvtzfrEsJGUxbP8rv1S7doyKbPamv6+C9
X-Gm-Gg: ASbGncsTAZjcm0xaw7T0TaDA/DY+kmMr2dxGqJAjXf44mDnlPHOQy2sn+NA6LEHbBAF
 ys3bsw5bdkVj9ifjjGSHYLdDFQrkbie/1VAugom1W/rsXfvZK9XkXGCC714nSwyXjvyl/p1c3wg
 ==
X-Google-Smtp-Source: AGHT+IH22Kgxf/DvFe9FjUrHd/hgdFKq6U7ZpPh/5zXy5BfQ2M4mwmeW+vwJP1sMDkiuecfdqR/Tqh3p03DT6ZhsF6g=
X-Received: by 2002:a05:6902:1007:b0:e5b:3d71:bfe5 with SMTP id
 3f1490d57ef6-e5dc97f5886mr8021373276.3.1739799404769; Mon, 17 Feb 2025
 05:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-3-shentey@gmail.com>
In-Reply-To: <20250204092112.26957-3-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 13:36:32 +0000
X-Gm-Features: AWEUYZlPIZZZL_oRsKyhVAFrnYinW2M1TXvrTBtgzbTL6lKwNNpSDbyThTYpjds
Message-ID: <CAFEAcA-RTdb9tbR-CD0NaqW5+kqMvat9QnLQbcW=FfY4ZQifhg@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] hw/pci-host/designware: Prevent device
 attachment on internal PCIe root bus
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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
> On the real device, the PCIe root bus is only connected to a PCIe bridge and
> does not allow for direct attachment of devices. Doing so in QEMU results in no
> PCI devices being detected by Linux. Instead, PCI devices should plug into the
> secondary PCIe bus spawned by the internal PCIe bridge.
>
> Unfortunately, QEMU defaults to plugging devices into the PCIe root bus. To work
> around this, every PCI device created on the command line needs an extra
> `bus=dw-pcie` option which is error prone. Fix that by marking the PCIe root bus
> as full which makes QEMU decend into the child PCIe bus.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/pci-host/designware.h |  7 +++++++
>  hw/pci-host/designware.c         | 18 +++++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
> index bf8b278978..a35a3bd06c 100644
> --- a/include/hw/pci-host/designware.h
> +++ b/include/hw/pci-host/designware.h
> @@ -25,12 +25,19 @@
>  #include "hw/pci/pci_bridge.h"
>  #include "qom/object.h"
>
> +#define TYPE_DESIGNWARE_PCIE_ROOT_BUS "designware-pcie-root-BUS"
> +OBJECT_DECLARE_SIMPLE_TYPE(DesignwarePCIERootBus, DESIGNWARE_PCIE_ROOT_BUS)
> +
>  #define TYPE_DESIGNWARE_PCIE_HOST "designware-pcie-host"
>  OBJECT_DECLARE_SIMPLE_TYPE(DesignwarePCIEHost, DESIGNWARE_PCIE_HOST)
>
>  #define TYPE_DESIGNWARE_PCIE_ROOT "designware-pcie-root"
>  OBJECT_DECLARE_SIMPLE_TYPE(DesignwarePCIERoot, DESIGNWARE_PCIE_ROOT)
>
> +struct DesignwarePCIERootBus {
> +    PCIBus parent;
> +};
> +
>  typedef struct DesignwarePCIEViewport {
>      DesignwarePCIERoot *root;
>
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index 3e8c36e6a7..c07740bfaa 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -55,6 +55,17 @@
>  #define DESIGNWARE_PCIE_ATU_DEVFN(x)               (((x) >> 16) & 0xff)
>  #define DESIGNWARE_PCIE_ATU_UPPER_TARGET           0x91C
>
> +static void designware_pcie_root_bus_class_init(ObjectClass *klass, void *data)
> +{
> +    BusClass *k = BUS_CLASS(klass);
> +
> +    /*
> +     * Designware has only a single root complex. Enforce the limit on the
> +     * parent bus
> +     */
> +    k->max_dev = 1;
> +}

This seems to be what we do in at least one other PCI host
controller, so

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

