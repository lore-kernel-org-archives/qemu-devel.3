Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4CAC0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 00:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdepe-0004B2-Es; Thu, 30 Jan 2025 19:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdepZ-000495-49; Thu, 30 Jan 2025 19:24:21 -0500
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdepW-00015g-K7; Thu, 30 Jan 2025 19:24:19 -0500
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4aff78a39e1so419567137.1; 
 Thu, 30 Jan 2025 16:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738283057; x=1738887857; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZcdAkWnVXHbYiz/ygKlWH1oKcO/zFb8qU5UBHkHJR40=;
 b=mp9OyvRPT2fYCnMO6zc076wsSUqxfsXFrKt3HC2ILDw9/l7jE6icqGkGy8DXivPSBo
 4hOVo/4cNrdZndG7KzVzKzu5w9YjSoPOKzj3/mTGz6/qgvdhOHSGhIIgOFLn/0zrndZ2
 /LzJNhx0QDdGpE60CxixHyMc+Dr8nbIWGt4wAZm6OHKMrqdL7HhaG/jo0LfSLic3Xd0p
 0ot6r+D7aZvXaB5R0GPZ3F72A4HNg5OEAzqZZGrtTOuIxtEdcLR5/Q9Z3DoFgGxksNTE
 YmvMBYiWDgwgT4vqM6hYPCY4qqfjRpdL620SwFYAl9FlhQsNPqJ/uyugbQ824kT5duG5
 aW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738283057; x=1738887857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZcdAkWnVXHbYiz/ygKlWH1oKcO/zFb8qU5UBHkHJR40=;
 b=xAS6MFQ+0pFva9amBGT9Wkl+sojRVKUXeYKDBBRY3zsCPUH3wTodLhqYqdll4KNDD9
 xnTUVzhEzDu1F91wOr+Rt4Cz7kcwCh1nWvLw718StXZyuls2E9KUFSPUenwk3U3NRlpT
 JL22eDaV+2BTEW5FWcvOL/cyCtgwDpFQXnLfVOgekZ81ZYIyULg5vGY1ozvvigh+FRIp
 LTsc4/c7H34o7HwYRndmvVMIBaatAmkp/5Wxkvjp90AM2W7zipvKKDFyRuffRenPRAeg
 MGOObjgQXkYjpSFPdJowMp/X2QF9/KAsQ+3EcpozJyJvI16NbVFXE0ExW073mxjhVAko
 e9Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/AtdWNSEXJCVt/iBxpBdSKZq76w8PgPtrHCQ+QEKg7Nq+YrXbHuu265WwpLguanCWQe5BtvEFNIre@nongnu.org
X-Gm-Message-State: AOJu0YxFPhhep8pl3lsj1pb90QQVM1cfSpJHnWFeGWrbzuFCJ6Hft8aw
 lDgkWYxV6fTS8Cy68s93VA9KrQoFuV7HVMuuggikGK6os0iX98DsYeFPWITJh9M2C1Q331wS+Jz
 XXWfOys5OvhHp+cSkYm14FVSHLHhHkQ==
X-Gm-Gg: ASbGnctHT4KqYo45132R2xmQImzeyBmziFccsnItdSwiobMnBh/65vaT0viX5Wz0WTq
 RYWj91HgUhEmDXEmvRY6qMgn6m9Fkx3uOC/mtOExUM/WPMb2xyQXXhnuQG9eERjtWMuDtmyLJ+T
 p7yk8fdF7/kOQry0Hfs9VOaWEyZ9o=
X-Google-Smtp-Source: AGHT+IG/SvmVuRm1IOZzj9c17ydda1OhjDCp5hz1cbDbxKIigm8EtbcoKlQ3xuw8m1/O07eDp53HkmKknOnOK4FGQb8=
X-Received: by 2002:a05:6102:330b:b0:4b6:44ff:414e with SMTP id
 ada2fe7eead31-4b9a51df604mr7930031137.17.1738283057104; Thu, 30 Jan 2025
 16:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20250115141730.30858-1-jason.chien@sifive.com>
 <20250115141730.30858-2-jason.chien@sifive.com>
In-Reply-To: <20250115141730.30858-2-jason.chien@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2025 10:23:51 +1000
X-Gm-Features: AWEUYZlNHFEURIZknNEjzshbnF8f_NoH26bevTO1_Snfp_YRwG8v7cyeAYHJ5q4
Message-ID: <CAKmqyKPqpbE6mWT1td7ChwMy1iCDxWXObhCw28HofeROPbNRAg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] hw/riscv/riscv-iommu-bits: Remove duplicate
 definitions
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
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

On Thu, Jan 16, 2025 at 12:18=E2=80=AFAM Jason Chien <jason.chien@sifive.co=
m> wrote:
>
> The header contains duplicate macro definitions.
> This commit eliminates the duplicate part.
>
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu-bits.h | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index 485f36b9c9..de599b80d6 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -50,8 +50,14 @@ struct riscv_iommu_pq_record {
>  #define RISCV_IOMMU_PREQ_HDR_PRIV       BIT_ULL(33)
>  #define RISCV_IOMMU_PREQ_HDR_EXEC       BIT_ULL(34)
>  #define RISCV_IOMMU_PREQ_HDR_DID        GENMASK_ULL(63, 40)
> +
>  /* Payload fields */
> +#define RISCV_IOMMU_PREQ_PAYLOAD_R      BIT_ULL(0)
> +#define RISCV_IOMMU_PREQ_PAYLOAD_W      BIT_ULL(1)
> +#define RISCV_IOMMU_PREQ_PAYLOAD_L      BIT_ULL(2)
>  #define RISCV_IOMMU_PREQ_PAYLOAD_M      GENMASK_ULL(2, 0)
> +#define RISCV_IOMMU_PREQ_PRG_INDEX      GENMASK_ULL(11, 3)
> +#define RISCV_IOMMU_PREQ_UADDR          GENMASK_ULL(63, 12)
>
>  /* Common field positions */
>  #define RISCV_IOMMU_PPN_FIELD           GENMASK_ULL(53, 10)
> @@ -382,22 +388,6 @@ enum riscv_iommu_fq_ttypes {
>      RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ =3D 9,
>  };
>
> -/* Header fields */
> -#define RISCV_IOMMU_PREQ_HDR_PID        GENMASK_ULL(31, 12)
> -#define RISCV_IOMMU_PREQ_HDR_PV         BIT_ULL(32)
> -#define RISCV_IOMMU_PREQ_HDR_PRIV       BIT_ULL(33)
> -#define RISCV_IOMMU_PREQ_HDR_EXEC       BIT_ULL(34)
> -#define RISCV_IOMMU_PREQ_HDR_DID        GENMASK_ULL(63, 40)
> -
> -/* Payload fields */
> -#define RISCV_IOMMU_PREQ_PAYLOAD_R      BIT_ULL(0)
> -#define RISCV_IOMMU_PREQ_PAYLOAD_W      BIT_ULL(1)
> -#define RISCV_IOMMU_PREQ_PAYLOAD_L      BIT_ULL(2)
> -#define RISCV_IOMMU_PREQ_PAYLOAD_M      GENMASK_ULL(2, 0)
> -#define RISCV_IOMMU_PREQ_PRG_INDEX      GENMASK_ULL(11, 3)
> -#define RISCV_IOMMU_PREQ_UADDR          GENMASK_ULL(63, 12)
> -
> -
>  /*
>   * struct riscv_iommu_msi_pte - MSI Page Table Entry
>   */
> --
> 2.43.2
>
>

