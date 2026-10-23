Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5428D606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GG7MMCE+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKBQt-0003vN-BN; Fri, 23 Oct 2026 05:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKBQr-0003ua-CP
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:19:25 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKBQp-0006Pp-Ql
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:19:25 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8ab395abf79so6511607b3.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 02:19:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792747162; cv=none;
 d=google.com; s=arc-20260327;
 b=SKcBgyXXwV0G8RovEo+JUt6neyA8xJBHPz3U8Qih8/lLuX7Zvxl1vNIOM+5WLTpPpC
 87NVDvGONQurovvVj6i7n2DPAwsPK5BY7Zg1rWTquK70jWkDV9FEgko6ErmjHkYUGOBa
 01tJwahYOmpAbKdF335a2eEWML0yUsBlYzU26bnqpxH6ilcP83OvUzaU9HwP9KmNlJ+g
 pHC5xphrTdVDnLriMhIhcqnfz19iEgUmoy+j52fk0ghcvg2gAxBCLhNjj5vSNadpeW0y
 n3FP3+CSjTBzcuDdDm3VxBQX+CFrofbIdpb2SomWgKaFhG4OiQ54B+2fqGuSisOQcnRX
 C32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mLqfpqTOPQxPIyRO3AiO/z+XRCEOzHjSsl/ENke+obQ=;
 fh=XTTVB6ywah99SChND1zlNweUq8YqXd4UiqbWz1Dd4iI=;
 b=BloTyW4zWVCSuguLlnxmebLRAfkPz5I5WQvOVGziHNE5NcePG4Ke7nFc74+d9HAgSN
 fkILuhixsgnDKAemkMRZVwmtsQ8h6ldkeWsywbl4wICexGq7GI/QxzrFlCcQT3Q9NVDz
 zpsWd48ILNm78kOBzmJplmRw2RdFhMQTCdzSBxEQGCv5HwvXEad2M7mrQS5HtAoSx+xD
 2SrXHOnBv/n17jtIIOXazvtO2VANILvC5aCCGe/d9Z0/zl8+SrBhWEUWCEMJOejD0A1u
 VN30q0+y73OyfhlVM6XXEjhPfULGIulP5eVLofe4tGj+gA0Geibx77zIKS0OvC/fJ/41
 Ynbg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792747162; x=1793351962; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mLqfpqTOPQxPIyRO3AiO/z+XRCEOzHjSsl/ENke+obQ=;
 b=GG7MMCE+Iy8XQ9JCC9Luf1h4UU2HydJFfyRZqC1iWUg5/cfYDM7uYXZzRt8l2CVWYh
 dTWSkHOrhgyjQytDzaCgnM6SdvdEYTMeUZDXvyK9OJjKhl8eou6yMv2ots3ezPYtU0Mz
 oeFEYJ3uawUn1r8+wOtiaclFqYvxY3qW+0j3I+MDZzsTmSk5T/nyWJHMuyrW801EEmts
 AXUCeBy51w9VEu/oiEbz4HpNXnZRca/uHu1tZi5CqLtXT3HQBRJdGrhl1YiQTS54FkVe
 5gQHCxz7Deepzw2IAud6Ody60NgzxpEmPPKyHoczU9vGNci1nbRc/2MZuLknCvK7bGfa
 tYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792747162; x=1793351962;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mLqfpqTOPQxPIyRO3AiO/z+XRCEOzHjSsl/ENke+obQ=;
 b=bqBeJx5dBWk3GoLSuuIV1Ml5bFCFmQFkcmQ2R4dP9cfdS88yX5t4ab5GYeXDZ03unh
 8uqyxKpSY2YMWSofKwNH+L/rt+3iTVHokwYiUhWKuw0am1bHMpxFUDBmYlUsy8FxhpFQ
 i7H4+H6EG3bIv8n6WfhR+Ae+XPzgzC7qPIy5mPg0CgUT5IKCLHBI7DMruBh+/CKceH1F
 p/g9D8VY0IOP02yAdkaFzzWxQ99ABlAI7LKX2lPXPzSsQqyvdvrHJqzDf7G5V5wEwIS/
 uD3XmOdI7VgpyyHLHyec6pq2p2lBEaEScjCUUWBqMu3pgukalGCbIqaXpgGbnP2hb4wq
 +oyA==
X-Gm-Message-State: AFq9FYIGsOfwVH8USsRdjpOrUauJXPihqUWmdkzuNcuSht0tGs5sRnAf
 jzHN8nm4OKYo7ROMSEwhANy3E67i0SZkha0uoyEsnk//lD2OB2A86mIGtithJjNLr4Cb2rE//kI
 0gwhtHp0W6TjexBpczAhQ+wtCooWCi8dQ12dix6Q0lQ==
X-Gm-Gg: AYBFou16SF/tSPnoUHI+Qlx4PupoenxGLOY79AEVf/BTPccO5bTiZSVj6n/Vjzz4/14
 /ZKNDuZ+yDgEfUmsOAvSaGUuwdHwLdYmr2+fLzkd+7y1QQX6YrQRjjR2ZiYUB18xFJPhWQ1axCD
 PiWGsbWi9aYlsrpIoEf0Unl1s/T0CaAtqAALv9GRNEFWDxSfcvLzX17UpNdvIKFgbsDAbONu9xp
 8bkvuZ3gFI9QiEg6fx2UPCcOosfV/4Mc+KrPXNi7sONft8ZrfTFkKbYRF/KTwgXNSUw0Bpsy6Tn
 FQ3MQtL04PWc3v6wswaIwkUfGnLbz+iied0DFavAGcIRGiS3RpC99RjXC+/j7Iry/vgp0rCAw2X
 m8cBkJ7JsDMoaAo1l6K2B3AEWbH/VLUH4KKS6bP9AePqGP6mxeZHVqApLBvaliEOA0Tzb8Dj9mr
 u11Jeax6iv01NI/1hro5mQdLWkGq0xuzC7SBOJOTl/ZA==
X-Received: by 2002:a05:690c:931c:10b0:8ab:436f:6e77 with SMTP id
 00721157ae682-8b157efe2c5mr11345257b3.55.1792747162229; Fri, 23 Oct 2026
 02:19:22 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261018133603.64323-1-marcelomanzo@gmail.com>
 <20261018133603.64323-2-marcelomanzo@gmail.com>
In-Reply-To: <20261018133603.64323-2-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 10:19:10 +0100
X-Gm-Features: AclHuK8-N3SG9XLv1gseGM_K2U08QRXMVp2e716TWDPfUVpZ67YzVobHzRwF4vI
Message-ID: <CAFEAcA9Su3o0GdJ-VzkXHfx7eXYrsPU6E4hqn8SDMEinOKt-WA@mail.gmail.com>
Subject: Re: [PATCH v4 01/17] hw/arm/bcm2838_pcie: add BCM2838 PCIe Root
 Complex
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 18 Oct 2026 at 14:36, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> Add the PCI-facing "root" part (D0:F0) of the BCM2838 (Raspberry Pi
> 4B / BCM2711) PCIe Root Complex: a PCIe root port with the vendor's
> device/vendor IDs and capability offsets, not usable on its own
> without the host-facing part added in the next patch.
>
> Adapted from patch 13/41 of Sergey Kambalin's "Raspberry Pi 4B
> machine" series (patchwork series 829638, posted to qemu-devel in
> 2024 but never merged) against current QEMU master; the surrounding
> PCIe/GENET networking support for raspi4b was left unmerged upstream
> (base scaffolding aside), so this and the following patches complete
> and debug that series to get real networking working under
> raspi4b.
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>



> +static const VMStateDescription vmstate_bcm2838_pcie_root = {
> +    .name = "bcm2838-pcie-root",
> +    .priority = MIG_PRI_PCI_BUS,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = pcie_cap_slot_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj.parent_obj,
> +                           BCM2838PcieRootState),
> +        VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.parent_obj.exp.aer_log,
> +                       BCM2838PcieRootState, 0, vmstate_pcie_aer_log,
> +                       PCIEAERLog),

What the heck is going on here? All these parent_obj things are
definitely not the right way to do this.

> +        VMSTATE_UINT8_ARRAY(regs, BCM2838PcieRootState,
> +                            BCM2838_PCIE_REGS_SIZE - PCIE_CONFIG_SPACE_SIZE),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +

-- PMM

