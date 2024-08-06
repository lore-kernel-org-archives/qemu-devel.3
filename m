Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E71C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 00:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb8Cj-0007tj-KN; Mon, 05 Aug 2024 20:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb8CX-0007pr-0E; Mon, 05 Aug 2024 20:37:21 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb8CT-0001lM-3N; Mon, 05 Aug 2024 20:37:19 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-825dc62725cso31039241.3; 
 Mon, 05 Aug 2024 17:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722904634; x=1723509434; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/L66Q8W+MD7uejmn9bmXbfmSczmqBVrXt7DlrWxJRg=;
 b=KIOXsxcnYlwXg6Hw3V6Vi38rBfBJiJ32i2ZKAeHGD2qha771Mhkosd6s2gXves9OZp
 b3/ku3tS7KmxOTvo/T7a68tTEVCLz5rSxqL6QNa4hwBdCQfngfi0yuiN6Xz4+p6Jd4mP
 +/wKA+w5qMGYEfhSJ1bURmvg3UPTOewkHYfqqfKHqdpzrBi0O42ut04r1l+wF17lt3/X
 oNbihVyirJuQ/yYyNbxN/oETIpUT5mJCV5RBBijpHMULP2buYQqdkP4Y2Z4/cbAfxJ96
 wWTSuuPODFn/wFiid69csL8FMyXA4vHet42vLVRs4tWXL5rOg+HFiiUL1f8OkJsXROqM
 Isuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722904634; x=1723509434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V/L66Q8W+MD7uejmn9bmXbfmSczmqBVrXt7DlrWxJRg=;
 b=XfxFZYZ9RuX7Iho5kdUBsAa5u+nhHzsYf9JDXayZAhfkPD0Ta3AIF1kC1GM8BNRDGp
 wJfIt6nWJFk2xUhq/RyLJ/kYuf994QBDHfDgNZv2zsHyQyTsodmBoGZNrDIJvRebOZlQ
 m9OITjGhUUnHsmgOM7N/Q6hk2FAdCn4D2XKtTpqUEKRehD8a7Yk/R2DFxXIxkczqLENQ
 iKiNSQYzGQa3vTBgxY0j9+wRZofYNYGdOu8FxcqwGbUrauZy0h4c8irgYrr40xdEwCG4
 kKzlK657Zb6xC6DdozOiIvvHaDoJ41uy5WaQguHAJFxJFX5u44stf7pouj79AwVHtyZH
 O6gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9yP8IlEDgsRyxomxlyulNvE7ouXcZ2K3MfpkYzPsJ9/ivuyqzZnteMuey92JCoGuE9zuwRWeSAMY5oFA9sUGD5yftcVk=
X-Gm-Message-State: AOJu0YyeWgV06DJxIAfHQKxVYYDqqp0GYEL77SOMY1Iqi4X1UpS2WOY7
 LKbgRwzlljasDRPpfNw9eHPB31nEH9xFDdDaZa2Nf1w7NVvtz/d8Fgp91W3MdN9ya6Pg58q9EUV
 z9tPyfNp/J5f/qPXYU2Mq5rgH8SE=
X-Google-Smtp-Source: AGHT+IGHY/oK7Copo5eUdLnzNp/MkOQjfnkNoV/v82CTJO6xR0BE5/1RV5FM0T5G4zJ322mWBkRJt7V7pgI+AmV6Rw8=
X-Received: by 2002:a05:6102:cc8:b0:48f:461c:ab86 with SMTP id
 ada2fe7eead31-4945bde73admr19481944137.12.1722904634013; Mon, 05 Aug 2024
 17:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-5-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-5-c4170a5348ca@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 6 Aug 2024 10:36:47 +1000
Message-ID: <CAKmqyKPb-KZ0s1h=AG-g8_-gUFfAacN85ebzhNmvnhms4c=Yxw@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] target/riscv: Add counter delegation definitions
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Wed, Jul 24, 2024 at 9:33=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>
> This adds definitions for counter delegation, including the new
> scountinhibit register and the mstateen.CD bit.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h      | 1 +
>  target/riscv/cpu_bits.h | 8 +++++++-
>  target/riscv/machine.c  | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 1619c3acb666..af25550a4a54 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -368,6 +368,7 @@ struct CPUArchState {
>      uint32_t scounteren;
>      uint32_t mcounteren;
>
> +    uint32_t scountinhibit;
>      uint32_t mcountinhibit;
>
>      /* PMU cycle & instret privilege mode filtering */
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 2a8b53a6622e..d20468412dca 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -207,6 +207,9 @@
>  #define CSR_SSTATEEN2       0x10E
>  #define CSR_SSTATEEN3       0x10F
>
> +/* Supervisor Counter Delegation */
> +#define CSR_SCOUNTINHIBIT   0x120
> +
>  /* Supervisor Trap Handling */
>  #define CSR_SSCRATCH        0x140
>  #define CSR_SEPC            0x141
> @@ -778,6 +781,7 @@ typedef enum RISCVException {
>  #define MENVCFG_CBIE                       (3UL << 4)
>  #define MENVCFG_CBCFE                      BIT(6)
>  #define MENVCFG_CBZE                       BIT(7)
> +#define MENVCFG_CDE                        (1ULL << 60)
>  #define MENVCFG_ADUE                       (1ULL << 61)
>  #define MENVCFG_PBMTE                      (1ULL << 62)
>  #define MENVCFG_STCE                       (1ULL << 63)
> @@ -869,7 +873,9 @@ typedef enum RISCVException {
>  #define ISELECT_IMSIC_LAST                 ISELECT_IMSIC_EIE63
>  #define ISELECT_MASK_AIA                   0x1ff
>
> -/* MISELECT, SISELECT, and VSISELECT bits (AIA) */
> +/* [M|S|VS]SELCT value for Indirect CSR Access Extension */
> +#define ISELECT_CD_FIRST                   0x40
> +#define ISELECT_CD_LAST                    0x5f
>  #define ISELECT_MASK_SXCSRIND              0xfff
>
>  /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 492c2c6d9d79..1a2a68407852 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -398,6 +398,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          VMSTATE_UINTTL(env.siselect, RISCVCPU),
>          VMSTATE_UINT32(env.scounteren, RISCVCPU),
>          VMSTATE_UINT32(env.mcounteren, RISCVCPU),
> +        VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
>          VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
>          VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS=
, 0,
>                               vmstate_pmu_ctr_state, PMUCTRState),
>
> --
> 2.34.1
>
>

