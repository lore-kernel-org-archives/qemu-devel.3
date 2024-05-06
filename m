Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B962BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 06:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3raX-0005nu-1p; Mon, 06 May 2024 02:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s3raM-0005jv-Bv
 for qemu-devel@nongnu.org; Mon, 06 May 2024 02:12:26 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s3raK-00046h-HR
 for qemu-devel@nongnu.org; Mon, 06 May 2024 02:12:26 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2e367c2457bso5861191fa.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 23:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1714975942; x=1715580742; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXx0i4fSaFCK9+9RiI/Aa6wwUQxFeaFWg/hGSQ0VnYY=;
 b=cLZTzJO/h/iabTFgjoI8SnIhvAQ4YR6AOUnufEFuCN+xeNlqniSvaJ8YdhA/Y4Icad
 XECbeYFlxkp8x/8D3/Y9IiDge5xX0I50sPtOxTRUf4q9UIAXW/+JVwyxKkmcYmU+qCpR
 TOTZ92hOSZSmsAhRd2/D0H8OyJFO6HiR8XEQAEzXOYpfUwy40NCGNAZJv/gaA8s0ETIx
 gN2QOBVZW0vKcNRWQf35nlKNBEiADVYAxa/F7RQltBPPLryeJ/darWZY/wMjNGnBC9Nf
 lBntUCowWxr+S0xand9OsdOxOHgYBw8pY+MmWT4Ugzfp77QVIAE5H8ZroEWzasOzHeY0
 tRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714975942; x=1715580742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VXx0i4fSaFCK9+9RiI/Aa6wwUQxFeaFWg/hGSQ0VnYY=;
 b=XzPuU7kt7i5pr4lWJqKZ9YrycB5cSk+HTw4aKelsyX9Sf/8rzTvVYa8eOSTM2qBWrA
 11Ao4XfbmzHu6Lj0sO0b3RTXTIceZar6ZkJriUGPUPM/Zp+Em4h9xKH+5Ibx48Cf7Ylb
 B7uT0SpULhkbxTnEdvsQVZynzDvNDwXE3MUUlglYiXAfbfrjuTJcwc4sva7FtIWbKlwb
 Ny4hn21ef79Bi3tA1FDK0ledil3Qpk58TPrAE1doWSkU201rn6zm1WHJJpzyV9D4O8Bw
 X7x9skDXLsXkJwRw0+dkTnp/YdzfCNcoJuRr2PJ/OB/uR6753+jKY1ZufFtxeIAeVhUb
 HEwg==
X-Gm-Message-State: AOJu0YxqyQIvrqqPLQ9UPQV6E5sSkg48c2ZQ6NqAyYRoijxvRJZSgpcx
 vvn0YFmhcQJ8PkiSlBpRsB0EBinyeJ1Z+DhgAgKER48YmWO8R3Z6NJn2Pxvdx6Xe/YiQWjBcuO4
 xByF8/mgi9w+2mBX0M+xHVTDtPWbaJX3CebztqyIORGLfhzxZHmmnuvWLrKQ/RYO8MIMeQJVJyn
 RGZfhLJFh9nPCWaO6/clxvVKGK+FqAuihdqvEkjA46OQ==
X-Google-Smtp-Source: AGHT+IHENwKg/Pj3kUARg0vayx8vOpDvaXxgCnio9CMlQoEAgkrETTtnF4OokQ+gvu/XlFkZhFSwRA==
X-Received: by 2002:a19:f606:0:b0:519:1a91:30cc with SMTP id
 x6-20020a19f606000000b005191a9130ccmr5869974lfe.4.1714975942131; 
 Sun, 05 May 2024 23:12:22 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com.
 [209.85.208.178]) by smtp.gmail.com with ESMTPSA id
 dw11-20020a0565122c8b00b0051ff89d5ec6sm841245lfb.58.2024.05.05.23.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 May 2024 23:12:21 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-2e0b2ddc5d1so19253491fa.3; 
 Sun, 05 May 2024 23:12:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUEMDnld/iJ2JV3vI3+qvr3nPHq5m62b71QF37Xn/34maHLtpAKGyAgUIcP+CJCSI9PYzwnqYtPx1tre4wEAqAnTpmJ0XQ=
X-Received: by 2002:a2e:b009:0:b0:2d4:3d86:54e2 with SMTP id
 y9-20020a2eb009000000b002d43d8654e2mr5012098ljk.27.1714975941554; Sun, 05 May
 2024 23:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-13-dbarboza@ventanamicro.com>
In-Reply-To: <20240307160319.675044-13-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 6 May 2024 14:12:10 +0800
X-Gmail-Original-Message-ID: <CANzO1D13s85OE3u30EkP43CFVdFNgJNVWoM-BW9oPJi-A7cbNA@mail.gmail.com>
Message-ID: <CANzO1D13s85OE3u30EkP43CFVdFNgJNVWoM-BW9oPJi-A7cbNA@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] hw/riscv/riscv-iommu: Add another irq for mrif
 notifications
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=frank.chang@sifive.com; helo=mail-lj1-x229.google.com
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

Reviewed-by: Frank Chang <frank.chang@sifive.com>

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
3=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:06=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> From: Andrew Jones <ajones@ventanamicro.com>
>
> And add mrif notification trace.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/riscv-iommu-pci.c | 2 +-
>  hw/riscv/riscv-iommu.c     | 1 +
>  hw/riscv/trace-events      | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
> index 4eb1057210..8a7b71166c 100644
> --- a/hw/riscv/riscv-iommu-pci.c
> +++ b/hw/riscv/riscv-iommu-pci.c
> @@ -78,7 +78,7 @@ static void riscv_iommu_pci_realize(PCIDevice *dev, Err=
or **errp)
>      pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
>                       PCI_BASE_ADDRESS_MEM_TYPE_64, &s->bar0);
>
> -    int ret =3D msix_init(dev, RISCV_IOMMU_INTR_COUNT,
> +    int ret =3D msix_init(dev, RISCV_IOMMU_INTR_COUNT + 1,
>                          &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG,
>                          &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG + 256, 0=
, &err);
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 1fa1286d07..954a6892c2 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -543,6 +543,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUSt=
ate *s,
>      if (res !=3D MEMTX_OK) {
>          return res;
>      }
> +    trace_riscv_iommu_mrif_notification(s->parent_obj.id, n190, addr);
>
>      return MEMTX_OK;
>  }
> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
> index 4b486b6420..d69719a27a 100644
> --- a/hw/riscv/trace-events
> +++ b/hw/riscv/trace-events
> @@ -6,6 +6,7 @@ riscv_iommu_flt(const char *id, unsigned b, unsigned d, u=
nsigned f, uint64_t rea
>  riscv_iommu_pri(const char *id, unsigned b, unsigned d, unsigned f, uint=
64_t iova) "%s: page request %04x:%02x.%u iova: 0x%"PRIx64
>  riscv_iommu_dma(const char *id, unsigned b, unsigned d, unsigned f, unsi=
gned pasid, const char *dir, uint64_t iova, uint64_t phys) "%s: translate %=
04x:%02x.%u #%u %s 0x%"PRIx64" -> 0x%"PRIx64
>  riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f, uint=
64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u MSI 0x%"PRIx64" -> 0x=
%"PRIx64
> +riscv_iommu_mrif_notification(const char *id, uint32_t nid, uint64_t phy=
s) "%s: sent MRIF notification 0x%x to 0x%"PRIx64
>  riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0x%=
"PRIx64" 0x%"PRIx64
>  riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
>  riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed=
"
> --
> 2.43.2
>
>

