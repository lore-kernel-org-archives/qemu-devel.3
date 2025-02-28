Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2983AC19F32
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 01:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnpdV-00066q-QY; Thu, 27 Feb 2025 20:57:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tnpdU-00066J-DW; Thu, 27 Feb 2025 20:57:56 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tnpdR-0007KZ-Tl; Thu, 27 Feb 2025 20:57:55 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-86b3bd4d0faso574572241.3; 
 Thu, 27 Feb 2025 17:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740707872; x=1741312672; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AYuodx1Y4Z8M0NM15BpoCRYlbvhA1hyOL6BysQeMvKM=;
 b=hJIc3DEhjIBgmk47k44cPv1EyA4B4envXhJMnaX7c7qSI+WTfTTMKvU3YsfNbQGzFw
 BLbOxaKWM1eduTtcYz/20SUecgwYF1AytFcAKvG3H4vo4c1gLCTOm7XnmB5ymFIZ7f4f
 s8jqhbJ72x+K4dxEZqdf1jcrlo2pbUl6zp8jdRtDTbkv2lHNmnN8PIij6xNLF4m6n88G
 V0G77lJwdUUYiweHzLblEC2Q5MoDlw2T4tl1nYX0MCLyRGvtpETiH8rqLl18W+e3SvzC
 nxdoaTzu0VtiUhx8WX04XhYwiNEzzcBWw20HTauaAZHs/ynxoHVvJjr2p0rQqZFr9xDc
 Xyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740707872; x=1741312672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AYuodx1Y4Z8M0NM15BpoCRYlbvhA1hyOL6BysQeMvKM=;
 b=jcwqWgML/seWpqseBiFsNzyfjOhGgf7Au5eo5R45dtuI2mKBQhWraD5LQ8As56EfBp
 6qQlu04XXVICm97j22MzcO5DA5VEsrG0uXFHCeuLPxHIa5RPlm4ZgVKkM0OE+UMBpeRO
 JpCptZNLW184qkx+57q1C0hns7xrC6j7RKnIlQBUyy/T9OT3AN3iVMJwRj4iC4D8gq3u
 2406+SrLIS6kFNkCRnXC5ntZkMxet2GOGyANsXAnNmlwa7XqDl0TCvuko4Q9TYVKGcD1
 GAQcyjgnM9aq3l2aAl6Sr7j7+cYHggzCtgLrzTDAf9azvVhG8F7kIY3u1ZvaDxyc7zNH
 AW0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxH+AsSuC2X4NeT0bY7Q3OJXqeXBpomYLgeLqD7+5mNa9SubQpog2geGltln3pdwW5VGX0plo5r5WR@nongnu.org
X-Gm-Message-State: AOJu0Yzr5Kz8k+Bm+d/Of0H5ixu/i+NMYpTmVzJb9+nf4PgRHcp6DjFT
 k2AC+tS1Tk48OWEc059nFi0RcQ6AglNkSSHW/NwpvWMF41zWvM4l6FPF5beEZNZPOo9ec+qhpTH
 4f2UzHqlSJOZgllvFFI/M4Anzowg=
X-Gm-Gg: ASbGncv9cuGpUBORsTlza4v1snHksNID/cqJI2DHaoam3xnt14pSaKP3leZRtW2+IOt
 jeSNbaCvaVKtXN4MNyrFSFIZyHH39c/MBxFombYQUZ1IBk//o8iX/J+q3UFrV3cuZwoW8qsWgc3
 dbRbpwkTxkkmj7iXWOyzzOSaRDwtK91nbUF1lN
X-Google-Smtp-Source: AGHT+IFI7pAykRCtTYxIqH4nUO6bj6d5ctbd0eXHh8Q2VjFS6e9TV9Ck1d00kAw9Gc3lolc1DgtpwAb9cKLUR5d6H8w=
X-Received: by 2002:a05:6102:570b:b0:4b2:adfb:4f91 with SMTP id
 ada2fe7eead31-4c044d30f60mr1539170137.21.1740707872188; Thu, 27 Feb 2025
 17:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20250122083617.3940240-1-ethan84@andestech.com>
 <20250122084630.3965707-1-ethan84@andestech.com>
In-Reply-To: <20250122084630.3965707-1-ethan84@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Feb 2025 11:57:25 +1000
X-Gm-Features: AQ5f1JrfeiwKbjm0dtQYqOOKYL-LcgYMGWFq7MQTLELks30ABEJx2erDl0b_5eo
Message-ID: <CAKmqyKNu3NDom_8Yp1fcX+douovDCPD_VQejxOr43M3cp49-dA@mail.gmail.com>
Subject: Re: [PATCH v10 5/8] hw/misc/riscv_iopmp_txn_info: Add struct for
 transaction infomation
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Wed, Jan 22, 2025 at 6:49=E2=80=AFPM Ethan Chen via <qemu-devel@nongnu.o=
rg> wrote:
>
> The entire valid transaction must fit within a single IOPMP entry.
> However, during IOMMU translation, the transaction size is not
> available. This structure defines the transaction information required
> by the IOPMP.
>
> Signed-off-by: Ethan Chen <ethan84@andestech.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/misc/riscv_iopmp_txn_info.h | 38 ++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 include/hw/misc/riscv_iopmp_txn_info.h
>
> diff --git a/include/hw/misc/riscv_iopmp_txn_info.h b/include/hw/misc/ris=
cv_iopmp_txn_info.h
> new file mode 100644
> index 0000000000..98bd26b68b
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
> +} riscv_iopmp_txn_info;
> +
> +#endif
> --
> 2.34.1
>
>

