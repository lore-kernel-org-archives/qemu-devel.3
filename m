Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDB2C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 01:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0W5t-0001nd-0b; Thu, 03 Apr 2025 21:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0W5s-0001nR-AH; Thu, 03 Apr 2025 21:43:40 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0W5q-0005i7-Fh; Thu, 03 Apr 2025 21:43:39 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-86fea8329cdso1422442241.1; 
 Thu, 03 Apr 2025 18:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743731017; x=1744335817; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehxx99rmBnlEk9OR1sdpI1+1VPwZPvgYZq1iMISYvbU=;
 b=PBDkdSUopgBlnWJR/uQRC10n+AiIl8imifD3akKX9NtRgoo0XDvNOfUFNPxvTluWgx
 6nwCPH/4uJVV5fRW7zBZZ0pX7lRQw480y5W56acTqYxAh9Oil287NNhChyTWfo9yS6IF
 qXsgd91Hw2G/jScP5kurv8STm3COhCIQ3kcdeX51JVzBG3j8vNOwRYhRLvpY29B82aZD
 P3kvHm7bkXto+81IMxhUqJcO+ePsdVIroMp2jiG2XQM1LRA1zx9/hUknKCQfCz2NsSDY
 o+I/EWWJ0pIbpmMLbDpghALru8sOi/HhoLpmT/mowFaBGGd1Hca2xjDPjqToPcjBEaOS
 MlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743731017; x=1744335817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ehxx99rmBnlEk9OR1sdpI1+1VPwZPvgYZq1iMISYvbU=;
 b=YHuFWbn2l3tMtZc0jbpZTJZb07cT2whO3ykvMiY84CHesoLUm6sxdlzaO73pbmbnJI
 HA9N8Mvf9cumMshqlSbq9gQJHsbxxiE9uRFEfEo5akNo/E/bxmXh1KkA2eI6kPKfOXLF
 7wCkdY2fmWApjPV5uqhUMeg/gJSw92//7eVbcbfF1YSev4HsPHvjdhJnVR2MDdDuyfER
 dkrBdXVCgHZVtFwYRWEfYE+VP4jTapzMuUFeLjmsTuDHt4K+2nES6kQFS1nlrD+Lpmcw
 bOX6pjwHQe9+dawjxN6iaeLZYuwTELH1VkLaH08gwFrF25WmXybS8Rc43dJSu1wUBGIA
 Axaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3D/jmDnEZuAot0L7SIy4ivwsE7tiXey79w7hwsAPXJMSJC0u5gpowlOa6w55f4FpFmafl0ObYh+zl@nongnu.org
X-Gm-Message-State: AOJu0YwYiBPEVPBzyZRPwyrf8T+gv3UGCk+0ERXjBwv/dtpbQLaEE8Wi
 8zrkdpWizTgChn6wt9tGwSY5E2yBzSt4yugCMxlFtdVUruqG8sHhDJJIkTeFHxME4UGRq8j08NZ
 sZcJy+ocVrZmxiExhyvq0bwc0MHI=
X-Gm-Gg: ASbGncuObG4RERmfDpbVYn9YHvY2T4o1PquQBubjMUuewRaB9we7/yFq5IrFbWRk6AE
 RtvJ3oe3M+1v+jfyj7EUx/cJ98wCahzaDV8OsmyIGuvLVnV1KS84HvXkVj/vw72H+eXC0sX2PcV
 4qTQOAY1/yFIDlA72Prklg++zi2RDqM6wwsqrr4bvj0fxUVVPWG0zLf+VI
X-Google-Smtp-Source: AGHT+IGF3Fff2y+WZjK7CUQaZc9LJATfCELIOMF/vIQhQBxSrDF3/T+NTirapLYwCyGSQjM80TWQhiJYHV01dbC2vVc=
X-Received: by 2002:a05:6102:38ce:b0:4c1:94df:9aea with SMTP id
 ada2fe7eead31-4c8553e5196mr1465011137.15.1743731016727; Thu, 03 Apr 2025
 18:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250302091209.20063-1-jason.chien@sifive.com>
 <20250302091209.20063-4-jason.chien@sifive.com>
In-Reply-To: <20250302091209.20063-4-jason.chien@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 11:43:10 +1000
X-Gm-Features: ATxdqUEZCKLyknhgF0NaocRD9zfv-w5OLWYH6d-0tAs3QmWvsFP9TAF1HSlKZKM
Message-ID: <CAKmqyKO3iqjru7hd9d87LC-Qaeg5Wqb3Q5+_6oL55Y+Noy9a0A@mail.gmail.com>
Subject: Re: [PATCH 3/3] hw/riscv/riscv_iommu: Remove the "bus" property
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Mar 2, 2025 at 7:13=E2=80=AFPM Jason Chien <jason.chien@sifive.com>=
 wrote:
>
> This property was originally intended to set the bus number for non-root
> endpoints. However, since the PCIe bus number is assigned and modified
> at runtime, setting this property before software execution is incorrect.
> Additionally, the property incorrectly assumes that all endpoints share
> the same bus, whereas no such restriction exists.
>
> With the IOMMU now retrieving the latest device IDs from memory attribute=
s,
> there is no longer a need to set or update device IDs.
>
> Signed-off-by: Jason Chien <jason.chien@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 7 -------
>  hw/riscv/riscv-iommu.h | 1 -
>  2 files changed, 8 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index b72ce8e6d0..1ca85b95ac 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1197,9 +1197,6 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUSt=
ate *s, uint32_t devid)
>  {
>      RISCVIOMMUSpace *as;
>
> -    /* FIXME: PCIe bus remapping for attached endpoints. */
> -    devid |=3D s->bus << 8;
> -
>      QLIST_FOREACH(as, &s->spaces, list) {
>          if (as->devid =3D=3D devid) {
>              break;
> @@ -2261,9 +2258,6 @@ static MemTxResult riscv_iommu_trap_write(void *opa=
que, hwaddr addr,
>          return MEMTX_ACCESS_ERROR;
>      }
>
> -    /* FIXME: PCIe bus remapping for attached endpoints. */
> -    devid |=3D s->bus << 8;
> -
>      ctx =3D riscv_iommu_ctx(s, devid, 0, &ref);
>      if (ctx =3D=3D NULL) {
>          res =3D MEMTX_ACCESS_ERROR;
> @@ -2498,7 +2492,6 @@ void riscv_iommu_reset(RISCVIOMMUState *s)
>  static const Property riscv_iommu_properties[] =3D {
>      DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
>          RISCV_IOMMU_SPEC_DOT_VER),
> -    DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
>      DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
>          LIMIT_CACHE_IOT),
>      DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index a31aa62144..655c0e71a8 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -34,7 +34,6 @@ struct RISCVIOMMUState {
>      /*< public >*/
>      uint32_t version;     /* Reported interface version number */
>      uint32_t pid_bits;    /* process identifier width */
> -    uint32_t bus;         /* PCI bus mapping for non-root endpoints */
>
>      uint64_t cap;         /* IOMMU supported capabilities */
>      uint64_t fctl;        /* IOMMU enabled features */
> --
> 2.43.2
>
>

