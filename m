Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DED2C021B6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 02:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmNuD-0000y6-6Z; Sun, 23 Feb 2025 21:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmNu8-0000xR-Ui; Sun, 23 Feb 2025 21:09:10 -0500
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmNu3-0005M5-K5; Sun, 23 Feb 2025 21:09:08 -0500
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4be5ec1262eso756081137.2; 
 Sun, 23 Feb 2025 18:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740362941; x=1740967741; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5rSEnxkrHO89v+YUHJsPBAyGrs++Z6R4095rIv7xZ5w=;
 b=SbHJuffv2MV2t2Qd7Av0qDvOy2XCt8Nd3So0peT29SdQbU3zxlMLGo4gOeGqpxUQCG
 wn2w9Wb9JMOMe5t53RF1gD6IKKwDSuCaqoTgM1Hh/uCDV4ukKFvaIp0wOzZTDkFzcev9
 1Zj4LBw3ejKJdY6La9vfIrbfmLfbSFdGQtMtjbGEVD5FXgmEvtIwRqAVbz3i/ad9S0Rj
 k5OR2JBC3s12MJVp0jpm6tbY6lRat5JcJi6rTTKsCChpyBklYNJ8t9pE0xBeDkawPxUr
 ArtPQfRt3zLvDmIC9lZcDobAtNCek23BpvPEPF76lU6HeLMeULFkvNi3NRTh9IAQDYVa
 ok8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740362941; x=1740967741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5rSEnxkrHO89v+YUHJsPBAyGrs++Z6R4095rIv7xZ5w=;
 b=e1iER+XBFzGPtkI462cyL56MeMaFvtXEoJzgm8cxdycOjlJP54D2HSjmB4E2CpBmDu
 LvDDiwWh/BcsOE6IYQP9JMw6AqZVd7lZjGUpHNKYE2IJ7QH9TwgpPOpJ9iBy6uKupuvA
 YIPbkN82sLWQxV5p3LX3oWMPNF3R2dVRdIpyALTKlbF4qzalZdcq1Hn5fKz5bnDz1tei
 LsffRX3AdWb6qtuKtkh20OG75OBW4qQOh4dfGZAL3lxzjwemuRy2Xg6seJoRyAw7ULHm
 KVNx/IaMJ2IaSOQXhjUmmRBJQIiq3l71avP+0OK2cBdW2lKG0MQM5K2471+9Ouqw4GFm
 c0Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3AtUIz7sm6aIKiJtcwQ48NYELZ3ESemUSpXQrhB8oE6SevMQqieyFOFlqyzHg9t8ZDr6NTByKmD7z@nongnu.org
X-Gm-Message-State: AOJu0YxYEeeB42Jdy3IVrpr1elg0mR4a1XlVJc5HVMaYYAZ2DyadhT3R
 x5VFQ/pDfAU475ILsIiGzsrlyBIOSfhzW06dm5r71IWCun5Q9MVPrCpnDZxorIslFCPjeiwlwtG
 9gQGa6sUzRxiTb4fzTufZeKOxmLM=
X-Gm-Gg: ASbGncvRSmTrQbF0atkxw6A0qRw9LdbGoeJSq0/uF8RcS4bfdyZg/lJUdDwpQIHjjn+
 zhFADYpXYe9f4Hx7b0rofOLGaPcqzHIRwUrAY72XG/ZNYmHvo+E6dRKcVdhmHCkGdOAi2YPjlwG
 aOlv/lpTBDHj4GdRsnqnDtaPiqhnOaRwWGOFbN
X-Google-Smtp-Source: AGHT+IFWO3bzzQNnCfUIr6Qgd3CWalquoLy/G8iofvNNjDR8EfAyw0q0wYhSCCLR35B3KfdyAixSmqyFqM8oxjnqGVY=
X-Received: by 2002:a05:6102:1489:b0:4bb:b843:95e6 with SMTP id
 ada2fe7eead31-4bfc001ec22mr6476865137.7.1740362941474; Sun, 23 Feb 2025
 18:09:01 -0800 (PST)
MIME-Version: 1.0
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
 <20241205133003.184581-2-dbarboza@ventanamicro.com>
In-Reply-To: <20241205133003.184581-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 12:08:35 +1000
X-Gm-Features: AWEUYZmdDkYGeq6CxlI5k46webNef5EnYV6zH-vgvDfq-wdn8YGjp00khpSLYWo
Message-ID: <CAKmqyKNvHYegwWas+GpTjWQcu2bZRr54Nm+bsSwG-MdXmN8GNQ@mail.gmail.com>
Subject: Re: [PATCH for-10.0 01/11] hw/riscv/riscv-iommu.h: add missing headers
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
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

On Thu, Dec 5, 2024 at 11:32=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> This header is incomplete, i.e. it is using definitions that are being
> supplied by the .c files that are including it.
>
> Adding this header into a fresh .c file will result in errors:
>
> /home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:30:17: error: field =E2=
=80=98parent_obj=E2=80=99 has incomplete type
>    30 |     DeviceState parent_obj;
>       |                 ^~~~~~~~~~
> /home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:50:5: error: unknown type=
 name =E2=80=98dma_addr_t=E2=80=99; did you mean =E2=80=98in_addr_t=E2=80=
=99?
>    50 |     dma_addr_t cq_addr;   /* Command queue base physical address =
*/
>       |     ^~~~~~~~~~
>       |     in_addr_t
> (...)
> /home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:62:5: error: unknown type=
 name =E2=80=98QemuThread=E2=80=99; did you mean =E2=80=98GThread=E2=80=99?
>    62 |     QemuThread core_proc; /* Background processing thread */
>       |     ^~~~~~~~~~
>       |     GThread
> /home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:63:5: error: unknown type=
 name =E2=80=98QemuCond=E2=80=99
>    63 |     QemuCond core_cond;   /* Background processing wake up signal=
 */
>       |     ^~~~~~~~
> /home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:71:18: error: field =E2=
=80=98trap_as=E2=80=99 has incomplete type
>    71 |     AddressSpace trap_as;
>       |                  ^~~~~~~
> /home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:72:18: error: field =E2=
=80=98trap_mr=E2=80=99 has incomplete type
>    72 |     MemoryRegion trap_mr;
>       |                  ^~~~~~~
> /home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:80:18: error: field =E2=
=80=98regs_mr=E2=80=99 has incomplete type
>    80 |     MemoryRegion regs_mr;
>       |                  ^~~~~~~
>
> Fix it by adding the missing headers for these definitions.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index 9424989df4..2de0cdfc56 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -20,6 +20,8 @@
>  #define HW_RISCV_IOMMU_STATE_H
>
>  #include "qom/object.h"
> +#include "hw/qdev-properties.h"
> +#include "sysemu/dma.h"
>  #include "hw/riscv/iommu.h"
>  #include "hw/riscv/riscv-iommu-bits.h"
>
> --
> 2.47.1
>
>

