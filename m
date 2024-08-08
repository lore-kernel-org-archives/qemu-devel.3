Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317C8C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 04:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbuWe-0001LP-Eg; Thu, 08 Aug 2024 00:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbuWb-0001KC-QU; Thu, 08 Aug 2024 00:13:17 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbuWa-0002hO-9s; Thu, 08 Aug 2024 00:13:17 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-81ff6a80cb2so161194241.3; 
 Wed, 07 Aug 2024 21:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723090395; x=1723695195; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HR0Iw3L4vpDwP5slj8vBhEkrjKstVb8uWou6Rkd8/O4=;
 b=QScWTR6G3lExFR0e4+FIV0Qqo8kzAYA+ju6+QWrE0T9RTgvSOI/yApH/uxuvb6wEEv
 cE+KguzOoR2JCP0ADSWG9LHe7d/UvR1EIKACR3q/Mgse2NXW+SUgbSY0LMxQoUY5ryzQ
 crfqEkjTgKC/i/fwiSbhx3jFXWm79D79LE3cQDN8W2R6sSilhNlBtsYyJ78i0wpjfCBu
 Q+Q/CRl3zCqj8IjxNlURKtZl6Rta3Vw8d+ZmWs+t3xv2ajGh3+1o64vNLRrP8pFI9SOU
 LJAiTu7dzHhRjh2uPOtu2JaAAxn3/e0q4cXAKIvSU6vlLiwcX5vBUy7bwW5zL6JcD8aF
 eL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723090395; x=1723695195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HR0Iw3L4vpDwP5slj8vBhEkrjKstVb8uWou6Rkd8/O4=;
 b=C24iNKyLlqIa6nfDAM8XDLDd987xRrAk2QS5I7TOylkJW8Louz0P0+RU32R+cz9+Pl
 1pG4EZ1rIFmjwYqK6zE0NG+dUZpfbVid1QqTGkdvUbswh2n0ATGkyCyaGKpQjg1nak9o
 QahlRwX9oj8O6WbF3q2qQi176aszwPk1VghGzbeL5Nay7ig1fqUcEcnGAHnzY8fL79fI
 XmDUARlbUumf7R8LjTcS19LJlw/TJyrtlIglmXQMHTQ2I4DpjFUwViNQYFDCyLTnZ34H
 CR+u+1Eelrd1baN51lwn6e1f8LJE0rTfbs2FpIKi1wLF3BuCCDRnyRb/CdBwt+qkyv3l
 tLFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTtHXbPI1+fJhKhEm5Gk/BKgp3uHfVqAFHdtNeGHQS0ugvBc8WDrq0mVjwat64NowaRG3aaITDzl/dJuvtTf6+cCfho5o=
X-Gm-Message-State: AOJu0Yzsm460OgialEOkXRR5wuzGGxgbSI3wYuMQIbCStd8mvNP0xJ0o
 idrc8XRhV7mqDIMta7UeiQy2i/8jOJfoz3DjtsagmXVl2wKxjzFrroUiq/4JqgykwkP34bQyd/u
 d4pRLtUGLpIUSTzNFzVDtQy+bL3k=
X-Google-Smtp-Source: AGHT+IHYdeLhAPTKGshn8FVGeasYnhws2BduN7KhF4mM1ItR/hNra+az72n3QY6OrJ61cnfTtbCRR2GjQY6u/C4kDho=
X-Received: by 2002:a05:6102:cd0:b0:493:b06d:eea2 with SMTP id
 ada2fe7eead31-495c5ce7ef0mr822397137.31.1723090394695; Wed, 07 Aug 2024
 21:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240715095702.1222213-1-ethan84@andestech.com>
 <20240715095702.1222213-4-ethan84@andestech.com>
In-Reply-To: <20240715095702.1222213-4-ethan84@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 8 Aug 2024 14:13:00 +1000
Message-ID: <CAKmqyKPdAKu6McnsjGXd0KSf_rV_ESk+t_z7H9DiFjR01msVHg@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] target/riscv: Add support for IOPMP
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Mon, Jul 15, 2024 at 7:58=E2=80=AFPM Ethan Chen via <qemu-devel@nongnu.o=
rg> wrote:
>
> Signed-off-by: Ethan Chen <ethan84@andestech.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_cfg.h    |  2 ++
>  target/riscv/cpu_helper.c | 18 +++++++++++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index fb7eebde52..2946fec20c 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -164,6 +164,8 @@ struct RISCVCPUConfig {
>      bool pmp;
>      bool debug;
>      bool misa_w;
> +    bool iopmp;
> +    uint32_t iopmp_rrid;
>
>      bool short_isa_string;
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 6709622dd3..c2d6a874da 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1418,9 +1418,21 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr addres=
s, int size,
>      }
>
>      if (ret =3D=3D TRANSLATE_SUCCESS) {
> -        tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1)=
,
> -                     prot, mmu_idx, tlb_size);
> -        return true;
> +        if (cpu->cfg.iopmp) {
> +            /*
> +             * Do not align address on early stage because IOPMP needs o=
rigin
> +             * address for permission check.
> +             */
> +            tlb_set_page_with_attrs(cs, address, pa,
> +                                    (MemTxAttrs)
> +                                        {
> +                                          .requester_id =3D cpu->cfg.iop=
mp_rrid,
> +                                        },
> +                                    prot, mmu_idx, tlb_size);
> +        } else {
> +            tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size =
- 1),
> +                         prot, mmu_idx, tlb_size);
> +        }
>      } else if (probe) {
>          return false;
>      } else {
> --
> 2.34.1
>
>

