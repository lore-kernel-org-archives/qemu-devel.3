Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4C7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 04:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbuXM-0001k5-NQ; Thu, 08 Aug 2024 00:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbuXD-0001fm-Uw; Thu, 08 Aug 2024 00:13:57 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbuXC-0002kr-CI; Thu, 08 Aug 2024 00:13:55 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-821eab936d6so190074241.3; 
 Wed, 07 Aug 2024 21:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723090425; x=1723695225; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ip9FHotMKpSZHlbqJ+CkbR7t8RwQTcvevbZ2dO9Zeco=;
 b=EVMCwld5SrLxg7Xebqo8SbikLz5Lx4To+Tln/rCyMcdOACFoggC+S38kc6zZMqFEIu
 43Rb4GAYkjidu2MQr+YiueR7DtQLAzIbLc5evXt/YLcJVFoQq75fkP6tWANPdTESL/JG
 EFdWe4a39nWTLsUOjG+t+rE+n8QOaaz8i8dl6stlN5F71tlG2rTUYMKICLk4xL9pZUiP
 /JK3TQR3sROtt4vSa+JnMEyF5lkJwUHfbaXiZfZ5oo2ZD2vMdlmPdQWjOSyESXxUtf4T
 3iDhg8I6NttShH3YxPAYrwoKUFLXEhuEVUhZtQJl0TIrW1MYLMuMcIt697DfQH3QMnKC
 pWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723090425; x=1723695225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ip9FHotMKpSZHlbqJ+CkbR7t8RwQTcvevbZ2dO9Zeco=;
 b=Yjtfdnibc/efd8wm59iMy5DepTUhegK2af9tZKzDlISbPbf8r6jDHhSSaTeQIEpvYb
 30jLhNlDZ5ma19V3P5cUl0EVvSjTgN37NF7OqopOL8s3KMZE+r6oxVdoNgNyOMrMaSLc
 NBeeydfVbbefdE2Gv5iq+nNnFo/qKv7MkutBupGNekvdGHnz3JCJLAfVEqqI3P3btMR/
 dCKtIvNl4Sz71a/q/9pXOvQAvAZobS6KhaSTasTkYWLAqoER7yLrLb2VeXHfD5Qr9u8G
 OaD9APfMDqH+NR//s7K/r8p+3yrkUtnKJk0P5PgWPuahyqGSB/SaE0ustRMItM6XtjbT
 jI2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdOYN5x+Vca7KC8g+Rfd3GE0SIzn4/We1iOQ3Eot4l3Cof/t05bvfG9owKSbrI9sqaNaPeqE3ZsdiZoitH5HvxRUdkjX0=
X-Gm-Message-State: AOJu0Yz41mKg6JUVA2d7DQUQp5PrrYtIorFBNmra+IXrHgHIxEyNVz6f
 AouuPrxoa8n0FS9Fh5mygAwRl6Gl9khm6WQ2dyQmqV/BDJsp7vsSU1uded3ex0bNQJmioJOgjZ4
 BOw+d4ERJ0TlROT9iBKafG/O7xRklMTAe8Ig=
X-Google-Smtp-Source: AGHT+IGCkLFubkQNe6fL2tksXrhQYDjP8dQHLBTXOSVKC57mwXytaBnm5h/4aZlM1PP/Xt2Z+hnIBp8XlgjXKxeB6Y8=
X-Received: by 2002:a05:6102:370a:b0:48f:966c:eee3 with SMTP id
 ada2fe7eead31-495c5b92d2fmr937288137.24.1723090425489; Wed, 07 Aug 2024
 21:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240715095702.1222213-1-ethan84@andestech.com>
 <20240715095702.1222213-3-ethan84@andestech.com>
In-Reply-To: <20240715095702.1222213-3-ethan84@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 8 Aug 2024 14:12:00 +1000
Message-ID: <CAKmqyKNn04_BgeEPXHViR5jmKEjANmN60tniW7e9zU4MLbHXow@mail.gmail.com>
Subject: Re: [PATCH v8 2/8] system/physmem: Support IOMMU granularity smaller
 than TARGET_PAGE size
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org
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

On Mon, Jul 15, 2024 at 7:59=E2=80=AFPM Ethan Chen via <qemu-devel@nongnu.o=
rg> wrote:
>
> If the IOMMU granularity is smaller than the TARGET_PAGE size, there may =
be
>  multiple entries within the same page. To obtain the correct result, pas=
s
> the original address to the IOMMU.
>
> Similar to the RISC-V PMP solution, the TLB_INVALID_MASK will be set when
> there are multiple entries in the same page, ensuring that the IOMMU is
> checked on every access.
>
> Signed-off-by: Ethan Chen <ethan84@andestech.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  accel/tcg/cputlb.c | 20 ++++++++++++++++----
>  system/physmem.c   |  4 ++++
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index edb3715017..7df106fea3 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1062,8 +1062,23 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>
>      prot =3D full->prot;
>      asidx =3D cpu_asidx_from_attrs(cpu, full->attrs);
> -    section =3D address_space_translate_for_iotlb(cpu, asidx, paddr_page=
,
> +    section =3D address_space_translate_for_iotlb(cpu, asidx, full->phys=
_addr,
>                                                  &xlat, &sz, full->attrs,=
 &prot);
> +    /* Update page size */
> +    full->lg_page_size =3D ctz64(sz);
> +    if (full->lg_page_size > TARGET_PAGE_BITS) {
> +        full->lg_page_size =3D TARGET_PAGE_BITS;
> +    } else {
> +        sz =3D TARGET_PAGE_SIZE;
> +    }
> +
> +    is_ram =3D memory_region_is_ram(section->mr);
> +    is_romd =3D memory_region_is_romd(section->mr);
> +    /* If the translated mr is ram/rom, make xlat align the TARGET_PAGE =
*/
> +    if (is_ram || is_romd) {
> +        xlat &=3D TARGET_PAGE_MASK;
> +    }
> +
>      assert(sz >=3D TARGET_PAGE_SIZE);
>
>      tlb_debug("vaddr=3D%016" VADDR_PRIx " paddr=3D0x" HWADDR_FMT_plx
> @@ -1076,9 +1091,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>          read_flags |=3D TLB_INVALID_MASK;
>      }
>
> -    is_ram =3D memory_region_is_ram(section->mr);
> -    is_romd =3D memory_region_is_romd(section->mr);
> -
>      if (is_ram || is_romd) {
>          /* RAM and ROMD both have associated host memory. */
>          addend =3D (uintptr_t)memory_region_get_ram_ptr(section->mr) + x=
lat;
> diff --git a/system/physmem.c b/system/physmem.c
> index 2154432cb6..346b015447 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -702,6 +702,10 @@ address_space_translate_for_iotlb(CPUState *cpu, int=
 asidx, hwaddr orig_addr,
>          iotlb =3D imrc->translate(iommu_mr, addr, IOMMU_NONE, iommu_idx)=
;
>          addr =3D ((iotlb.translated_addr & ~iotlb.addr_mask)
>                  | (addr & iotlb.addr_mask));
> +        /* Update size */
> +        if (iotlb.addr_mask !=3D -1 && *plen > iotlb.addr_mask + 1) {
> +            *plen =3D iotlb.addr_mask + 1;
> +        }
>          /* Update the caller's prot bits to remove permissions the IOMMU
>           * is giving us a failure response for. If we get down to no
>           * permissions left at all we can give up now.
> --
> 2.34.1
>
>

