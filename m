Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46CFCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 01:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3OrE-00034Z-Nd; Mon, 29 Sep 2025 21:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v3Or5-00030a-SW
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 21:08:37 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v3Oqy-00034O-LJ
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 21:08:35 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b3e25a4bfd5so350918566b.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 18:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759194505; x=1759799305; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WfR8Cd6swzh2/q4hRbJlAffsL1L/IC1DhkfkQ19+UY=;
 b=OQJ3CJ7rx1B/wY3Sr4rCtBQJndc8R0XaTZvBcYsgRsi0gybqIuKh8VU8G62+gwMvzR
 3rPpThXRXHpgh/E8XTb/EYzwZv7bTbDLUOcNF62q8EIydLBQHeBwxXF6N5kMY9Pn7/pq
 zfV9d2hN9zGKzp63YlwKerivV1v8WYBtRsZsYHTa5yp56bu2Gd2lQyZ0SDSAV3ujekea
 7QF4DimAYnbB0ukin3bUJDBSB09ql0fsMMGDqxQHVI4DT6byXL2hja0ZT6PdRItOs40N
 dcIg6JCMdW9TYw9HX7dYzjM9T4PjDp+KPrw6xWmaoVlNBUg+d0HLQScqX4YnJn9Duq0s
 +Eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759194505; x=1759799305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WfR8Cd6swzh2/q4hRbJlAffsL1L/IC1DhkfkQ19+UY=;
 b=PyU3xfeH4ih8CaVnOblHA8nsgh11S478br+gR0NS0ACiGiiuxHRhCBqO3IbDmdYdZf
 FCWA08NWCPmU/jPNnkJfYHdZjxH0btoBxejApcC5XG/8Xfz2fqWXfHl1ylUtqEXI20PL
 xVN46REDTWsSL4d5cDIZxGeCkP1/rDD4GItaUKizKP905d+l+OrQ/1MsMKr1BWMIhdbX
 kjYZTOjVksSgJSk/95tYOyiAreYw7helbK2xS1ad3K3r5ZQbXOfJ0nhnSCiH7XXxDPuJ
 cmqbZQQthIKrvMYXlAp7pRO81IonjsSNYL+Mxg3j34hSU1Oz8stha5dMMh1DOmKxAq0V
 PbvA==
X-Gm-Message-State: AOJu0Yzr/6JTp3GUFQzDaJ6PQiJEUgO11R0UEfkAVn+9sEr3ZKYIB1o8
 PmLAGsPYNJCcgNg43cJ0L2ZT9S8jvqa2u7R4aK/K8LH5BEDhOzwYfYhBpzcq7/8/EP6A0XFAAY4
 ckleVB8XKvf1DEFtCX1pnqmuUrG0atDo=
X-Gm-Gg: ASbGncuC4s95S4vlvh2SxEslOG6DrwMfPpXEqusCSsXKtWPnJGcAVBSRvtOTcnbp37f
 S2yD9getTCaRdRDVJ3NNUixxAo9JfHqADGripv7hArPE+Kil77QYnhlBNkxEWBGRbruVVRXu06w
 9c7DJs1g19zPonslPrGtowsRdMLej3BTc39KPJE0+4OpwwXqqZoJpo7e1RHEMaEQcZg/pTv3qf6
 B2i4g4RfIuRSEQmZGEYxKr7JrsY7eKgBPrkflfCxwJcDyW4gvR5spdYsMkLyA==
X-Google-Smtp-Source: AGHT+IF+S/1T7ezj8RNaCN8Qlem3EHhTnel42OFDpcUTwW0SpVC3faNOCFvBB2SFR1OKglpf9GAL76FwYZ3TI/doeDk=
X-Received: by 2002:a17:907:608f:b0:b3d:5088:213f with SMTP id
 a640c23a62f3a-b3d50882706mr832814666b.19.1759194504669; Mon, 29 Sep 2025
 18:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
 <20250924091746.1882125-4-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-4-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Sep 2025 11:07:58 +1000
X-Gm-Features: AS18NWAoDHA-I9B3HZqksmqDLxmrAhPlltz8UVnEYfUGCrmG8RiyePd142b2K9c
Message-ID: <CAKmqyKO7RbJjty32QNUk-uec62s5+UAAvkCssurwt-e_hC2KKw@mail.gmail.com>
Subject: Re: [PATCH v8 03/14] target/riscv: Add MIPS P8700 CPU
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62f.google.com
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

On Wed, Sep 24, 2025 at 7:25=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Introduce P8700 CPU by MIPS.
>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu-qom.h      |  1 +
>  target/riscv/cpu.c          | 16 ++++++++++++++++
>  target/riscv/cpu_vendorid.h |  1 +
>  3 files changed, 18 insertions(+)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 75f4e43408..30dcdcfaae 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -56,6 +56,7 @@
>  #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon"=
)
>  #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-n=
anhu")
>  #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-k=
unminghu")
> +#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700"=
)
>  #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>
>  OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 74728c5371..6e0bd6b798 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3281,6 +3281,22 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.max_satp_mode =3D VM_1_10_SV48,
>      ),
>
> +    /* https://mips.com/products/hardware/p8700/ */
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
> +        .misa_mxl_max =3D MXL_RV64,
> +        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
> +        .priv_spec =3D PRIV_VERSION_1_12_0,
> +        .cfg.max_satp_mode =3D VM_1_10_SV48,
> +        .cfg.ext_zifencei =3D true,
> +        .cfg.ext_zicsr =3D true,
> +        .cfg.mmu =3D true,
> +        .cfg.pmp =3D true,
> +        .cfg.ext_zba =3D true,
> +        .cfg.ext_zbb =3D true,
> +        .cfg.marchid =3D 0x8000000000000201,
> +        .cfg.mvendorid =3D MIPS_VENDOR_ID,
> +    ),
> +
>  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>          .cfg.max_satp_mode =3D VM_1_10_SV57,
> diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
> index 96b6b9c2cb..28f0ce9370 100644
> --- a/target/riscv/cpu_vendorid.h
> +++ b/target/riscv/cpu_vendorid.h
> @@ -2,6 +2,7 @@
>  #define TARGET_RISCV_CPU_VENDORID_H
>
>  #define THEAD_VENDOR_ID         0x5b7
> +#define MIPS_VENDOR_ID          0x722
>
>  #define VEYRON_V1_MARCHID       0x8000000000010000
>  #define VEYRON_V1_MIMPID        0x111
> --
> 2.34.1
>

