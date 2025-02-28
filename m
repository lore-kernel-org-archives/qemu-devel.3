Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B18FC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 06:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tntQ0-0000jL-Sq; Fri, 28 Feb 2025 01:00:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tntPz-0000gJ-3T; Fri, 28 Feb 2025 01:00:15 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tntPx-0001kh-EO; Fri, 28 Feb 2025 01:00:14 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-5209f22ecfeso782795e0c.1; 
 Thu, 27 Feb 2025 22:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740722411; x=1741327211; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2cyC8PDX8j+2ueryZfmhOSHFyPq7pyYoq3HJ2Xy2pY=;
 b=FdCEGc0xTVdQOQ0TMYiY9RIiaHXRDSBiiai2jLR5rFebKAFe4LCbMLqBQh4oDjS6oe
 btALPBQUxbTeYjC2p56D+T/D39+OFJ/UoJK7gqmyuNxw1YaB4s9DsJgMaZLc/f+VGpo5
 JxVWMgHMuhZ6Svn4ZSR0m2KF7Ykx+A5ZvyGVKL/s751vTUQzztjk7oVPXtBCTtbWbfbd
 LCq8tzMCPnL5jcDM0JBlCp+3Byn0QK2qp/taZ2jQt28cPlaGr82mq4Oe/M378LN30aXu
 X1ZpfyBc3mJlP75gojzfashIjHQwHypouw3lfqtsntYHJkxL8coxTt5aPHPQipP+7uga
 ospA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740722411; x=1741327211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M2cyC8PDX8j+2ueryZfmhOSHFyPq7pyYoq3HJ2Xy2pY=;
 b=L35NTpKqmjfXtMpKArmSTcfuUk9RgFMqooPieqDq/A4nG3ROoTifd23MAU/k6ar+nc
 CQy3NAWbhuz7ZK7o+zkCOCcVQalRXGtndqaF37ajdq+JedwPogT0Lg8RZ5znaCpNnPAQ
 +sNo5rdejba3wYP4yYc/EG047gdA0d0QAXySMCyzaoimCXbQQSb/SSLzmYRXrbFIY4X5
 8X2SlDTWAvptXSKOWWhSTc1K5LN1NC/vyXFF1fI0yHCiNhwNZFkQCIeGOSw9UckTy+e3
 KRXfbRMUJMaTL6U+7xCXCYuVQBSfdCbh6ToqkCYie6570ju00fVph1w7J69k1aqb2OLd
 h01Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrp4Gzn0VeJq8Ca0k4ZbjrONg6uFlB2gjaoml3ELwI4RBOsTFIb3Le95WlT2A2kHWqlWjd+iVb0I5m@nongnu.org
X-Gm-Message-State: AOJu0YxUYnIoXb7DJAsWO2JN/AR/WgiGdT2GiIRn0HkjU9j34W7vnY4+
 Zh7MkJYRKKqpzhW2iK8/ToMTx9obWTTnpfTH9R36HkFIPn93Jls1V/o59X0CJJ7gAQi9lYragBq
 VtKU8INYHZLdELXD3jbNoMVbqS4k=
X-Gm-Gg: ASbGnctHB8XgtoeTs1tYW+esy62zHun4rtttfg+kc/CvLBHIfT8W+guSbvbAjw08hcv
 ZUkV8HnoI7b5W+YBTb7HoRJTjiJCYUDebCqzDLbjxF9oxACl/kOQf9dYaXCCFv1t7frz8/wWn7t
 uA+Xi78YttP98hW27lVfAlCwhxjLIj4UuKuD/t
X-Google-Smtp-Source: AGHT+IHJtH/zI6a6j6y8aXvV80ZsPaOY7riPuW+myAVvYZf64+Ycd/Opyrrp7FGuBNm+rIVsws9snA52GDzUdrRDanc=
X-Received: by 2002:a05:6122:3c51:b0:519:fcf2:ef51 with SMTP id
 71dfb90a1353d-5235b797b95mr983719e0c.5.1740722411282; Thu, 27 Feb 2025
 22:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20250122083617.3940240-1-ethan84@andestech.com>
 <20250122084630.3965707-1-ethan84@andestech.com>
In-Reply-To: <20250122084630.3965707-1-ethan84@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Feb 2025 15:59:45 +1000
X-Gm-Features: AQ5f1JolcWETvuz44cANEudMwh4VzMX-TwnHa_LRGH2f30SZ6XS-9vo7OtkqCLA
Message-ID: <CAKmqyKMH_aSRRfznFp4fDc4L8RNbMoZfMNUm-GXKpKN5TcH0Fg@mail.gmail.com>
Subject: Re: [PATCH v10 5/8] hw/misc/riscv_iopmp_txn_info: Add struct for
 transaction infomation
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

Whoops, this should be CamelCase.

Checkpatch should catch these type of errors, make sure you run it if you d=
idn't

Alistair

> +
> +#endif
> --
> 2.34.1
>
>

