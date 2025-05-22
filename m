Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281CCC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 00:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHtyp-0005YS-Ee; Wed, 21 May 2025 20:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uHtyo-0005Y2-1y; Wed, 21 May 2025 20:40:14 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uHtym-000689-A6; Wed, 21 May 2025 20:40:13 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-52413efd0d3so2277699e0c.2; 
 Wed, 21 May 2025 17:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747874410; x=1748479210; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1elXq2GPfNmeQGd2a0YWeuVKouo88r7F5zO/MJP7erA=;
 b=b2wg70Bs1obFrir3fYK8o9E7VRRYvvfzmqp01uPtbP3dLtwEQvZQJ9QOjWhL1PaUdG
 BqcJOJUT8bi9lh519dgJqCHWWeaphobnX3A0RPlu9fMOICu1Hskx+zqLy0UKEAHWPAh5
 upIbgS4dyrEowiUg3ztX4Htqyk5zsq/XaUw52feMNXXy6FtFv70vgmSITGGSNR1SPXsu
 0m/+OU5xW2t+d2hgQ53FcgOOVU+PjyGg5zVW5j82r4hZIUV/W32rIk6AG63exMX3rnZS
 QyJHjHpVZOF1Y5LVbkyEpu44dB29KRW2QMJO3LBp3KF643q4/y/SBCI72q3ho6mqhzaO
 0c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747874410; x=1748479210;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1elXq2GPfNmeQGd2a0YWeuVKouo88r7F5zO/MJP7erA=;
 b=SoORXfIPeoz2rAMeWqgqEwu/eWMPLC7x9fAJ5PX6oj0ozjZx7qit5/aAMERu1u5tkS
 64ptKkLd2S8Dj/QK7a7fUM2JwdVHZ4quXKR6x1waVKbZ0y6iCYZ0EnvQIzuyDImOvpsM
 i+yvFRmhUU8ZsW05yFKMo+6eCcnX1MhNrUgcZB2R+SnL8DgZmSiVidRbFobGwjN9m+4b
 5WPhM2/kJ6ZP0i5+1U9rfod1NHQJzzAVfoM/OUVxVBQ+p7jUJCTmcQX8CWBCy6JOPfc4
 mUb54atWXVeUDyy7YpxR/Zq4+hRSGhCHB6/5tES59+PltbOu/3n8nRAYa4COsAKK3c2K
 iaFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+KPtjofvs6+0/nCC9Sehq4jJsyD/JiehdrrplB04AHBsWLlOLyBJFCB/WtkroIqAYAjywrVGfY8uH@nongnu.org
X-Gm-Message-State: AOJu0YyGK4peGIidDjHxl/zj/YLG8+Cq51heyJHG3Z/81KQ/vhJhlWDj
 dcUbBW3hACteegsy/0vcGGdLzDQsg0xLacrq3+9Hz2eaeYyqKP8zp7GhOs8BI+lwHn/GUnB74Wj
 xOl2u2MJwiFSYOjU4e9iTPXrkzu9mjiU=
X-Gm-Gg: ASbGncukpgiMtOvePMjJsuBziPZtoFnEb/fjXjwwTIAPBPuxyVBiFUEazGcWxkNBCa4
 5p1rVUaxWDfPoCpsTA3XIB2Uby6OBG/c+24YWR+niec816ecgRSNAax4dygWRXj0zNPdhYzv1Yn
 f/DoPBu2bYwEdUyAGbxi2kpCCF1M7pFjDQ9dUDJZ0tUC7YbOQS8dg5jQ75taTNwYJV/8fuxb6C6
 g==
X-Google-Smtp-Source: AGHT+IEOKaQBQhKMi+qrNX9RaqKQmgg6A/MuHPmoF3eeNV9vt4IVBpsjXN/x6YO1qY4nW58XXLE765XpHhmE2NhNxDw=
X-Received: by 2002:a05:6122:8ca:b0:52c:3a36:a82d with SMTP id
 71dfb90a1353d-52dbcd2b254mr19813901e0c.5.1747874410354; Wed, 21 May 2025
 17:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250312093735.1517740-1-ethan84@andestech.com>
 <20250312093735.1517740-6-ethan84@andestech.com>
In-Reply-To: <20250312093735.1517740-6-ethan84@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 22 May 2025 10:39:44 +1000
X-Gm-Features: AX0GCFtcYfJqVv_H4JTGFXjxj-gPlZsU4azhrY2RXjVWK7x5UA18LisDf0T6yo8
Message-ID: <CAKmqyKMhj8X7o1i0vPtrQw6GjuEJk97BYThZRO=6iCODB8X=9g@mail.gmail.com>
Subject: Re: [PATCH v11 5/8] hw/misc/riscv_iopmp_txn_info: Add struct for
 transaction infomation
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, peterx@redhat.com, 
 david@redhat.com, philmd@linaro.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Wed, Mar 12, 2025 at 7:43=E2=80=AFPM Ethan Chen via <qemu-devel@nongnu.o=
rg> wrote:
>
> The entire valid transaction must fit within a single IOPMP entry.
> However, during IOMMU translation, the transaction size is not
> available. This structure defines the transaction information required
> by the IOPMP.
>
> Signed-off-by: Ethan Chen <ethan84@andestech.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/misc/riscv_iopmp_txn_info.h | 38 ++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 include/hw/misc/riscv_iopmp_txn_info.h
>
> diff --git a/include/hw/misc/riscv_iopmp_txn_info.h b/include/hw/misc/ris=
cv_iopmp_txn_info.h
> new file mode 100644
> index 0000000000..d1d8213867
> --- /dev/null
> +++ b/include/hw/misc/riscv_iopmp_txn_info.h
> @@ -0,0 +1,38 @@
> +/*
> + * QEMU RISC-V IOPMP transaction information
> + *
> + * The transaction information structure provides the complete transacti=
on
> + * length to the IOPMP device
> + *
> + * Copyright (c) 2023-2025 Andes Tech. Corp.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef RISCV_IOPMP_TXN_INFO_H
> +#define RISCV_IOPMP_TXN_INFO_H
> +
> +typedef struct {
> +    /* The id of requestor */
> +    uint32_t rrid:16;
> +    /* The start address of transaction */
> +    uint64_t start_addr;
> +    /* The end address of transaction */
> +    uint64_t end_addr;
> +    /* The stage of cascading IOPMP */
> +    uint32_t stage;
> +} RISCVIOPMPTxnInfo;
> +
> +#endif
> --
> 2.34.1
>
>

