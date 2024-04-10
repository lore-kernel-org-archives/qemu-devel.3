Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9402CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 04:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruPjV-0002Bu-If; Wed, 10 Apr 2024 00:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1ruPjR-0002BR-2g; Wed, 10 Apr 2024 00:38:46 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1ruPjP-0007dE-BG; Wed, 10 Apr 2024 00:38:44 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ed32341906so2348759b3a.1; 
 Tue, 09 Apr 2024 21:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712723920; x=1713328720; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JiS56cHvDoDYEOPmeRAazFfdabqjkT7+PmAEiu4hEGs=;
 b=ex/5prpDDckEUS1bzvBm3MfLyt1g6Yc8PBm403gXXUGAOqhiO2eUlicnhEAD+Lf4AJ
 4Re3g3wiWYF0eqp9ib08LijpxaLE+On6zW5/OxuNqjto5NDEcmeVgjS3SHwqrs9dsTxh
 WswweyjZ5WVjdhXMhyoUtOnjjLwTK8Qj1ASXJ1EjhaVjjOvtNq4fZ8Bmws2vDSJmOBDw
 eEZIcfg48kMIkJRg5VdEZo4izLGBaQkejEYw7abOhXOk0gmueM/5DGccKzEGoG9AWj94
 4dbYfgOXurWbopFpjJ+g51rrw9IuH8gSR9RelNzzwxgygn9bIjuENE9iPk9ylpIAI4JJ
 O2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712723920; x=1713328720;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JiS56cHvDoDYEOPmeRAazFfdabqjkT7+PmAEiu4hEGs=;
 b=kbYaMk6L5xAIfRU+Bvz5uaxw9Xjo5/mClgztV1fXD6ICWisgzMqNgCFJ4XSjCWQ0M5
 0Q3nMl+tdH0NqsDkyEvfbSFufWrF+9BbnrdIo9ZBYcU64iXz+nPUVgmuzXMybm6nXmtR
 DtwuuD6xIgp9MB5F2R/oG404gwCqLFZu6t/yuaSGJgBRAb6psWRsmWlrgMSSwoyTgCkx
 1zXgqAUfG1NEUtHCxsIPlyHLf+FmEgkPFcLeOly83392uTaXrkrN+xO2zXLLTxhhsMWf
 r7rKcQF/3D3jvGCJOw47wl22GHZBrAZQubl8BNKtQUSUgUrqmwngU2zxdvWSz6OSYQiV
 qtAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVNwlQ5VEaXX5klH7yrxPe8hornsqw/1WlBQYJb7VHQE5qMsAeCNPn0gmYQw99Yk1xOL6240Pkdj6qpaBH/iEX/Gtj4ZWQxrEDepsojcauG1hKDrQX4QbunSQ=
X-Gm-Message-State: AOJu0YzQyFXky62FRkKvp4oveeuZNDvFGn3WbSh+GQ0+fR4UXON59rHt
 l68E1LlkaWD9W++cNfdCD6hEmXzGG06iMvnyb1Ar/xh/5Mv8+V/x
X-Google-Smtp-Source: AGHT+IF257ek+g5jKbTf+z39CmZsM5K2huaa7gWWhQiI5kvuaiPhQKYOUORVgdDaHwGVclT3aEgzxQ==
X-Received: by 2002:a05:6a00:7006:b0:6ed:caf6:6e54 with SMTP id
 lf6-20020a056a00700600b006edcaf66e54mr236986pfb.28.1712723920394; 
 Tue, 09 Apr 2024 21:38:40 -0700 (PDT)
Received: from localhost ([1.146.50.27]) by smtp.gmail.com with ESMTPSA id
 r25-20020aa78459000000b006eb3c3db4afsm9206180pfn.186.2024.04.09.21.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 21:38:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Apr 2024 14:38:33 +1000
Message-Id: <D0G5YFXXNK98.3NO5536V5LC8N@gmail.com>
Cc: "Peter Maydell" <peter.maydell@linaro.org>, <philmd@linaro.org>
Subject: Re: [PATCH for-9.0] ppc440_pcix: Do not expose a bridge device on
 PCI bus
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240409235543.0E0C34E601C@zero.eik.bme.hu>
In-Reply-To: <20240409235543.0E0C34E601C@zero.eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Apr 10, 2024 at 9:55 AM AEST, BALATON Zoltan wrote:
> Real 460EX SoC apparently does not expose a bridge device and having
> it appear on PCI bus confuses an AmigaOS file system driver that uses
> this to detect which machine it is running on. Since values written
> here by firmware are never read, just ignore these writes and drop the
> bridge device.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> This is only used by sam460ex and this fixes an issue with AmigaOS on
> this machine so I'd like this to be merged for 9.0 please.

Is it a regression? Does it have a fixes: or resolves: tag?

Unless we broke it in this cycle, I would be inclined to wait,
and we can ask to put it in stable.

Thanks,
Nick

>
>  hw/pci-host/ppc440_pcix.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/hw/pci-host/ppc440_pcix.c b/hw/pci-host/ppc440_pcix.c
> index 1926ae2a27..ba38172989 100644
> --- a/hw/pci-host/ppc440_pcix.c
> +++ b/hw/pci-host/ppc440_pcix.c
> @@ -52,7 +52,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(PPC440PCIXState, PPC440_PCIX=
_HOST)
>  struct PPC440PCIXState {
>      PCIHostState parent_obj;
> =20
> -    PCIDevice *dev;
>      struct PLBOutMap pom[PPC440_PCIX_NR_POMS];
>      struct PLBInMap pim[PPC440_PCIX_NR_PIMS];
>      uint32_t sts;
> @@ -170,10 +169,6 @@ static void ppc440_pcix_reg_write4(void *opaque, hwa=
ddr addr,
> =20
>      trace_ppc440_pcix_reg_write(addr, val, size);
>      switch (addr) {
> -    case PCI_VENDOR_ID ... PCI_MAX_LAT:
> -        stl_le_p(s->dev->config + addr, val);
> -        break;
> -
>      case PCIX0_POM0LAL:
>          s->pom[0].la &=3D 0xffffffff00000000ULL;
>          s->pom[0].la |=3D val;
> @@ -301,10 +296,6 @@ static uint64_t ppc440_pcix_reg_read4(void *opaque, =
hwaddr addr,
>      uint32_t val;
> =20
>      switch (addr) {
> -    case PCI_VENDOR_ID ... PCI_MAX_LAT:
> -        val =3D ldl_le_p(s->dev->config + addr);
> -        break;
> -
>      case PCIX0_POM0LAL:
>          val =3D s->pom[0].la;
>          break;
> @@ -498,10 +489,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Er=
ror **errp)
>      memory_region_init(&s->iomem, OBJECT(dev), "pci-io", 64 * KiB);
>      h->bus =3D pci_register_root_bus(dev, NULL, ppc440_pcix_set_irq,
>                           ppc440_pcix_map_irq, &s->irq, &s->busmem, &s->i=
omem,
> -                         PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
> -
> -    s->dev =3D pci_create_simple(h->bus, PCI_DEVFN(0, 0),
> -                               TYPE_PPC4xx_HOST_BRIDGE);
> +                         PCI_DEVFN(1, 0), 1, TYPE_PCI_BUS);
> =20
>      memory_region_init(&s->bm, OBJECT(s), "bm-ppc440-pcix", UINT64_MAX);
>      memory_region_add_subregion(&s->bm, 0x0, &s->busmem);


