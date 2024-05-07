Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC981C25B5F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 15:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4MoT-0003yu-HJ; Tue, 07 May 2024 11:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s4MoK-0003sS-72
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:32:57 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s4MoD-0005P1-93
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:32:54 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2df9af57b5eso44358321fa.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715095967; x=1715700767; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQUIHwjlEAR8utDZkbcZVeKZcWtLLImxeFZkBtiibtE=;
 b=I1IsTEO/aiKNjGBFGwPrJ4c7Qe/2Xuy/DjNqXkRcMPr4kFqBEFSKvC7uCnSZDZZwyA
 rFyopuG0qFqXvfAUFgbCSmkGTfXAb6C1xlaMW8n9vZW2xG9LClqUOnOdR6PYgxcD3iN1
 nAzq6wIu3P5VmGuReW8VE9AA8PeqCFC8P2XQeq6dhlmhVuhIUdVUWfPp4bbiw3s+3LBy
 BKrFeAm0u0eTEvmkI+kfaOvG+736mUESTU7OuMgs6vJ/63Nw+OAfbjqAI4qLx+I/ib4O
 EhzDavif+Bqyza3Sthe37dPLhl7vfC8RuzuZUSU7WTmEvVGnkKFu1MOoKvgJ4mmDgrB+
 0URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715095967; x=1715700767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TQUIHwjlEAR8utDZkbcZVeKZcWtLLImxeFZkBtiibtE=;
 b=t0W4DgGHjvv9SYutuSivbjLw7GUxF0owsHYQVw6kBUSklAi0pZPuRFIIkvLHjgCXh0
 ruXabTnINVJbVkxnNgtA7fUcBkJ1V8rbur0Z3iQ4Okyg1S8w21I/HDRFeFfeYpDaaCmE
 D1xd8RqgSTLVxT0PyF7m/TafVeVjqP+NMzv+yYLPWgQVOFvsViVOBwbUoDRSXu5Hz1XR
 GF0cgHWe43/sBclyqwgNs6EGwptXxVFYnNThIZCvBom9gVwQL7oNtson2FN1hHTH1hSq
 CaL3pD63zql1qvlmlxNquiI9Ha6Spsp6b6zmnYl/Cqtnt15R9lcN1EdGk15uF1GKDXOX
 QpBw==
X-Gm-Message-State: AOJu0YxLkusnnc40n70Jku4K1OfGVb1+XubP97M+rT+xUS5PpXYtbpiH
 qQ7r/YLdNT98RToC1y9RVKJ1EYSkZVrw50lYk6IV5FMMbyGwgNfUphoSpM73Y3zxZJamch6VCdM
 YrVfq6M+oJyqidOUIQz8N1QEprD3BrO8QOMpdGlnTZjldwdo2uO50biQsu0v5AujAMBL4POAEX0
 X4Biu4vKtjbYXG/7oqhqkxxh5hBETdEOkJWKoYAvU6dQ==
X-Google-Smtp-Source: AGHT+IGHEpnClfcWptBdVb3JbuTTIlG/qw2dhuE9ZmwUbrb/Eu/oczpZOBnCrXRLm/qbi6LXTu1Jlg==
X-Received: by 2002:a2e:3309:0:b0:2e1:f05f:6424 with SMTP id
 d9-20020a2e3309000000b002e1f05f6424mr10655765ljc.15.1715095966905; 
 Tue, 07 May 2024 08:32:46 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com.
 [209.85.208.180]) by smtp.gmail.com with ESMTPSA id
 k8-20020a2e8888000000b002df37b8e73bsm2036024lji.37.2024.05.07.08.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 08:32:46 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-2e3e18c240fso13572031fa.0; 
 Tue, 07 May 2024 08:32:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVyUrknfU6axWaeVyeEhlFBSmOhrfTAkKUEAkvyMRBV+V3ZA5NB99+gYz9e6Rb3wf3AMROXNB1YnWhrdBylH/UIN/x+9II=
X-Received: by 2002:a2e:a314:0:b0:2da:a73:4f29 with SMTP id
 l20-20020a2ea314000000b002da0a734f29mr10284917lje.30.1715095966176; Tue, 07
 May 2024 08:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-16-dbarboza@ventanamicro.com>
In-Reply-To: <20240307160319.675044-16-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 7 May 2024 23:32:34 +0800
X-Gmail-Original-Message-ID: <CANzO1D3sxSqXS6x1WkQDpyZ=T9nLQwHJCJRm=2FJn5OtrVN_mw@mail.gmail.com>
Message-ID: <CANzO1D3sxSqXS6x1WkQDpyZ=T9nLQwHJCJRm=2FJn5OtrVN_mw@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] hw/misc: EDU: add ATS/PRI capability
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=frank.chang@sifive.com; helo=mail-lj1-x230.google.com
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

Hi Daniel,

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
3=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:05=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> Mimic ATS interface with IOMMU translate request with IOMMU_NONE.  If
> mapping exists, translation service will return current permission
> flags, otherwise will report no permissions.
>
> Implement and register the IOMMU memory region listener to be notified
> whenever an ATS invalidation request is sent from the IOMMU.
>
> Implement and register the IOMMU memory region listener to be notified
> whenever an ATS page request group response is triggered from the IOMMU.
>
> Introduces a retry mechanism to the timer design so that any page that's
> not available should be only accessed after the PRGR notification has
> been received.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> ---
>  hw/misc/edu.c | 258 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 251 insertions(+), 7 deletions(-)
>
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 522cec85b3..f4f6c15ec6 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -45,6 +45,14 @@ DECLARE_INSTANCE_CHECKER(EduState, EDU,
>  #define DMA_START       0x40000
>  #define DMA_SIZE        4096
>
> +/*
> + * Number of tries before giving up on page request group response.
> + * Given the timer callback is scheduled to be run again after 100ms,
> + * 10 tries give roughly a second for the PRGR notification to be
> + * received.
> + */
> +#define NUM_TRIES       10
> +
>  struct EduState {
>      PCIDevice pdev;
>      MemoryRegion mmio;
> @@ -55,6 +63,7 @@ struct EduState {
>      bool stopping;
>
>      bool enable_pasid;
> +    uint32_t try;
>
>      uint32_t addr4;
>      uint32_t fact;
> @@ -81,6 +90,20 @@ struct EduState {
>      QEMUTimer dma_timer;
>      char dma_buf[DMA_SIZE];
>      uint64_t dma_mask;
> +
> +    MemoryListener iommu_listener;
> +    QLIST_HEAD(, edu_iommu) iommu_list;
> +
> +    bool prgr_rcvd;
> +    bool prgr_success;
> +};
> +
> +struct edu_iommu {
> +    EduState *edu;
> +    IOMMUMemoryRegion *iommu_mr;
> +    hwaddr iommu_offset;
> +    IOMMUNotifier n;
> +    QLIST_ENTRY(edu_iommu) iommu_next;
>  };
>
>  static bool edu_msi_enabled(EduState *edu)
> @@ -136,11 +159,65 @@ static dma_addr_t edu_clamp_addr(const EduState *ed=
u, dma_addr_t addr)
>      return res;
>  }
>
> +static bool __find_iommu_mr_cb(Int128 start, Int128 len, const MemoryReg=
ion *mr,
> +    hwaddr offset_in_region, void *opaque)
> +{
> +    IOMMUMemoryRegion **iommu_mr =3D opaque;
> +    *iommu_mr =3D memory_region_get_iommu((MemoryRegion *)mr);
> +    return *iommu_mr !=3D NULL;
> +}
> +
> +static int pci_dma_perm(PCIDevice *pdev, dma_addr_t iova, MemTxAttrs att=
rs)
> +{
> +    IOMMUMemoryRegion *iommu_mr =3D NULL;
> +    IOMMUMemoryRegionClass *imrc;
> +    int iommu_idx;
> +    FlatView *fv;
> +    EduState *edu =3D EDU(pdev);
> +    struct edu_iommu *iommu;
> +
> +    RCU_READ_LOCK_GUARD();
> +
> +    fv =3D address_space_to_flatview(pci_get_address_space(pdev));
> +
> +    /* Find first IOMMUMemoryRegion */
> +    flatview_for_each_range(fv, __find_iommu_mr_cb, &iommu_mr);
> +
> +    if (iommu_mr) {
> +        imrc =3D memory_region_get_iommu_class_nocheck(iommu_mr);
> +
> +        /* IOMMU Index is mapping to memory attributes (PASID, etc) */
> +        iommu_idx =3D imrc->attrs_to_index ?
> +                    imrc->attrs_to_index(iommu_mr, attrs) : 0;
> +
> +        /* Update IOMMU notifiers with proper index */
> +        QLIST_FOREACH(iommu, &edu->iommu_list, iommu_next) {
> +            if (iommu->iommu_mr =3D=3D iommu_mr &&
> +                iommu->n.iommu_idx !=3D iommu_idx) {
> +                memory_region_unregister_iommu_notifier(
> +                    MEMORY_REGION(iommu->iommu_mr), &iommu->n);
> +                iommu->n.iommu_idx =3D iommu_idx;
> +                memory_region_register_iommu_notifier(
> +                    MEMORY_REGION(iommu->iommu_mr), &iommu->n, NULL);
> +            }
> +        }
> +
> +        /* Translate request with IOMMU_NONE is an ATS request */
> +        IOMMUTLBEntry iotlb =3D imrc->translate(iommu_mr, iova, IOMMU_NO=
NE,
> +                                              iommu_idx);
> +
> +        return iotlb.perm;
> +    }
> +
> +    return IOMMU_NONE;
> +}
> +
>  static void edu_dma_timer(void *opaque)
>  {
>      EduState *edu =3D opaque;
>      bool raise_irq =3D false;
>      MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
> +    MemTxResult res;
>
>      if (!(edu->dma.cmd & EDU_DMA_RUN)) {
>          return;
> @@ -155,18 +232,70 @@ static void edu_dma_timer(void *opaque)
>
>      if (EDU_DMA_DIR(edu->dma.cmd) =3D=3D EDU_DMA_FROM_PCI) {
>          uint64_t dst =3D edu->dma.dst;
> +        uint64_t src =3D edu_clamp_addr(edu, edu->dma.src);
>          edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE);
>          dst -=3D DMA_START;
> -        pci_dma_rw(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
> -                edu->dma_buf + dst, edu->dma.cnt,
> -                DMA_DIRECTION_TO_DEVICE, attrs);
> +        if (edu->try-- =3D=3D NUM_TRIES) {
> +            edu->prgr_rcvd =3D false;
> +            if (!(pci_dma_perm(&edu->pdev, src, attrs) & IOMMU_RO)) {
> +                timer_mod(&edu->dma_timer,
> +                          qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 100);
> +                return;
> +            }
> +        } else if (edu->try) {
> +            if (!edu->prgr_rcvd) {
> +                timer_mod(&edu->dma_timer,
> +                          qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 100);
> +                return;
> +            }
> +            if (!edu->prgr_success) {
> +                /* PRGR failure, fail DMA. */
> +                edu->dma.cmd &=3D ~EDU_DMA_RUN;
> +                return;
> +            }
> +        } else {
> +            /* timeout, fail DMA. */
> +            edu->dma.cmd &=3D ~EDU_DMA_RUN;
> +            return;
> +        }
> +        res =3D pci_dma_rw(&edu->pdev, src, edu->dma_buf + dst, edu->dma=
.cnt,
> +            DMA_DIRECTION_TO_DEVICE, attrs);
> +        if (res !=3D MEMTX_OK) {
> +            hw_error("EDU: DMA transfer TO 0x%"PRIx64" failed.\n", dst);
> +        }
>      } else {
>          uint64_t src =3D edu->dma.src;
> +        uint64_t dst =3D edu_clamp_addr(edu, edu->dma.dst);
>          edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE);
>          src -=3D DMA_START;
> -        pci_dma_rw(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
> -                edu->dma_buf + src, edu->dma.cnt,
> -                DMA_DIRECTION_FROM_DEVICE, attrs);
> +        if (edu->try-- =3D=3D NUM_TRIES) {
> +            edu->prgr_rcvd =3D false;
> +            if (!(pci_dma_perm(&edu->pdev, dst, attrs) & IOMMU_WO)) {
> +                timer_mod(&edu->dma_timer,
> +                          qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 100);
> +                return;
> +            }
> +        } else if (edu->try) {
> +            if (!edu->prgr_rcvd) {
> +                timer_mod(&edu->dma_timer,
> +                          qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 100);
> +                return;
> +            }
> +            if (!edu->prgr_success) {
> +                /* PRGR failure, fail DMA. */
> +                edu->dma.cmd &=3D ~EDU_DMA_RUN;
> +                return;
> +            }
> +        } else {
> +            /* timeout, fail DMA. */
> +            edu->dma.cmd &=3D ~EDU_DMA_RUN;
> +            return;
> +        }
> +        res =3D pci_dma_rw(&edu->pdev, dst, edu->dma_buf + src, edu->dma=
.cnt,
> +            DMA_DIRECTION_FROM_DEVICE, attrs);
> +        if (res !=3D MEMTX_OK) {
> +            hw_error("EDU: DMA transfer FROM 0x%"PRIx64" failed.\n", src=
);
> +        }
>      }
>
>      edu->dma.cmd &=3D ~EDU_DMA_RUN;
> @@ -193,6 +322,7 @@ static void dma_rw(EduState *edu, bool write, dma_add=
r_t *val, dma_addr_t *dma,
>      }
>
>      if (timer) {
> +        edu->try =3D NUM_TRIES;
>          timer_mod(&edu->dma_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL)=
 + 100);
>      }
>  }
> @@ -376,9 +506,92 @@ static void *edu_fact_thread(void *opaque)
>      return NULL;
>  }
>
> +static void edu_iommu_ats_prgr_notify(IOMMUNotifier *n, IOMMUTLBEntry *i=
otlb)
> +{
> +    struct edu_iommu *iommu =3D container_of(n, struct edu_iommu, n);
> +    EduState *edu =3D iommu->edu;
> +    edu->prgr_success =3D (iotlb->perm !=3D IOMMU_NONE);
> +    barrier();
> +    edu->prgr_rcvd =3D true;
> +}
> +
> +static void edu_iommu_ats_inval_notify(IOMMUNotifier *n,
> +                                       IOMMUTLBEntry *iotlb)
> +{
> +
> +}
> +
> +static void edu_iommu_region_add(MemoryListener *listener,
> +                                   MemoryRegionSection *section)
> +{
> +    EduState *edu =3D container_of(listener, EduState, iommu_listener);
> +    struct edu_iommu *iommu;
> +    Int128 end;
> +    int iommu_idx;
> +    IOMMUMemoryRegion *iommu_mr;
> +
> +    if (!memory_region_is_iommu(section->mr)) {
> +        return;
> +    }
> +
> +    iommu_mr =3D IOMMU_MEMORY_REGION(section->mr);
> +
> +    /* Register ATS.INVAL notifier */
> +    iommu =3D g_malloc0(sizeof(*iommu));
> +    iommu->iommu_mr =3D iommu_mr;
> +    iommu->iommu_offset =3D section->offset_within_address_space -
> +                          section->offset_within_region;
> +    iommu->edu =3D edu;
> +    end =3D int128_add(int128_make64(section->offset_within_region),
> +                     section->size);
> +    end =3D int128_sub(end, int128_one());
> +    iommu_idx =3D memory_region_iommu_attrs_to_index(iommu_mr,
> +                                                   MEMTXATTRS_UNSPECIFIE=
D);
> +    iommu_notifier_init(&iommu->n, edu_iommu_ats_inval_notify,
> +                        IOMMU_NOTIFIER_DEVIOTLB_UNMAP,
> +                        section->offset_within_region,
> +                        int128_get64(end),
> +                        iommu_idx);
> +    memory_region_register_iommu_notifier(section->mr, &iommu->n, NULL);
> +    QLIST_INSERT_HEAD(&edu->iommu_list, iommu, iommu_next);
> +
> +    /* Register ATS.PRGR notifier */
> +    iommu =3D g_memdup2(iommu, sizeof(*iommu));
> +    iommu_notifier_init(&iommu->n, edu_iommu_ats_prgr_notify,
> +                        IOMMU_NOTIFIER_MAP,
> +                        section->offset_within_region,
> +                        int128_get64(end),
> +                        iommu_idx);
> +    memory_region_register_iommu_notifier(section->mr, &iommu->n, NULL);
> +    QLIST_INSERT_HEAD(&edu->iommu_list, iommu, iommu_next);
> +}
> +
> +static void edu_iommu_region_del(MemoryListener *listener,
> +                                   MemoryRegionSection *section)
> +{
> +    EduState *edu =3D container_of(listener, EduState, iommu_listener);
> +    struct edu_iommu *iommu;
> +
> +    if (!memory_region_is_iommu(section->mr)) {
> +        return;
> +    }
> +
> +    QLIST_FOREACH(iommu, &edu->iommu_list, iommu_next) {
> +        if (MEMORY_REGION(iommu->iommu_mr) =3D=3D section->mr &&
> +            iommu->n.start =3D=3D section->offset_within_region) {
> +            memory_region_unregister_iommu_notifier(section->mr,
> +                                                    &iommu->n);
> +            QLIST_REMOVE(iommu, iommu_next);
> +            g_free(iommu);
> +            break;
> +        }
> +    }
> +}
> +
>  static void pci_edu_realize(PCIDevice *pdev, Error **errp)
>  {
>      EduState *edu =3D EDU(pdev);
> +    AddressSpace *dma_as =3D NULL;
>      uint8_t *pci_conf =3D pdev->config;
>      int pos;
>
> @@ -390,9 +603,28 @@ static void pci_edu_realize(PCIDevice *pdev, Error *=
*errp)
>      pos =3D PCI_CONFIG_SPACE_SIZE;
>      if (edu->enable_pasid) {
>          /* PCIe Spec 7.8.9 PASID Extended Capability Structure */
> -        pcie_add_capability(pdev, 0x1b, 1, pos, 8);
> +        pcie_add_capability(pdev, PCI_EXT_CAP_ID_PASID, 1, pos, 8);

This should be included in the 14th commit.

>          pci_set_long(pdev->config + pos + 4, 0x00001400);
>          pci_set_long(pdev->wmask + pos + 4,  0xfff0ffff);
> +        pos +=3D 8;
> +
> +        /* ATS Capability */
> +        pcie_ats_init(pdev, pos, true);
> +        pos +=3D PCI_EXT_CAP_ATS_SIZEOF;
> +
> +        /* PRI Capability */
> +        pcie_add_capability(pdev, PCI_EXT_CAP_ID_PRI, 1, pos, 16);
> +        /* PRI STOPPED */
> +        pci_set_long(pdev->config + pos +  4, 0x01000000);
> +        /* PRI ENABLE bit writable */
> +        pci_set_long(pdev->wmask  + pos +  4, 0x00000001);
> +        /* PRI Capacity Supported */
> +        pci_set_long(pdev->config + pos +  8, 0x00000080);
> +        /* PRI Allocations Allowed, 32 */
> +        pci_set_long(pdev->config + pos + 12, 0x00000040);
> +        pci_set_long(pdev->wmask  + pos + 12, 0x0000007f);

We should use the defines declared in
include/standard-headers/linux/pci_regs.h for readability,
though some of the bitfields are not defined in the header file.

Regards,
Frank Chang

> +
> +        pos +=3D 8;
>      }
>
>      if (msi_init(pdev, 0, 1, true, false, errp)) {
> @@ -409,12 +641,24 @@ static void pci_edu_realize(PCIDevice *pdev, Error =
**errp)
>      memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
>                      "edu-mmio", 1 * MiB);
>      pci_register_bar(pdev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &edu->mmio)=
;
> +
> +    /* Register IOMMU listener */
> +    edu->iommu_listener =3D (MemoryListener) {
> +        .name =3D "edu-iommu",
> +        .region_add =3D edu_iommu_region_add,
> +        .region_del =3D edu_iommu_region_del,
> +    };
> +
> +    dma_as =3D pci_device_iommu_address_space(pdev);
> +    memory_listener_register(&edu->iommu_listener, dma_as);
>  }
>
>  static void pci_edu_uninit(PCIDevice *pdev)
>  {
>      EduState *edu =3D EDU(pdev);
>
> +    memory_listener_unregister(&edu->iommu_listener);
> +
>      qemu_mutex_lock(&edu->thr_mutex);
>      edu->stopping =3D true;
>      qemu_mutex_unlock(&edu->thr_mutex);
> --
> 2.43.2
>
>

