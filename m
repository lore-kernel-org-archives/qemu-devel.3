Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F44CC369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7uAS-0000W8-GE; Thu, 24 Apr 2025 06:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7uA2-0000Tk-Jm; Thu, 24 Apr 2025 06:50:33 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7uA0-0000u2-FH; Thu, 24 Apr 2025 06:50:30 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-86dc3482b3dso2279108241.0; 
 Thu, 24 Apr 2025 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745491827; x=1746096627; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7AlI3C+LjjGhHkNYleiXqOdDuGD5iVehVUi/xQsgYQ=;
 b=H7gifleQnXbUCHHqkaPwC7aN7J+AaG4gs3ZkR9ZXRU5gUiw2Sahmmcn3gukG4wnLn+
 sCKgrT61Y761/5Z2lny2/54r5hQlH7cR+5G+7C4B0Gr8rgWsxhRoU7XVRqOnHgdLQrjZ
 ca/B/d8Yw1Rxm1ktv+QnV6cHTtuewMnqlDWB4SI4cn0oLjLBrJSTiOLNvQ75gqC2dZ3v
 6UXgxKu6Ha53hw5CkscEeROCMZ2lVGnYYERJwykkVN5jv7/bkGwfr9HUL9SSb3rUb2Hk
 2DiTnQh4tLKz3pgMCImY5PCZmW8EI3pJ9gvE/HPeNESfaCTNrTgc3g9GUIT0gc46PgxB
 URmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745491827; x=1746096627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7AlI3C+LjjGhHkNYleiXqOdDuGD5iVehVUi/xQsgYQ=;
 b=JRfe8cM2vfA72cuJGBYivtqkjCq3LW261lrbI4tP9eXJUAcT7hM1GDRRhB4ZIbFDvy
 Vzlp3BMllsTRxOPIHHDYNM32ALrXT6RnrdxcUL4H9g0wh/Hb9kuYfMo6vQbKqbpHD/ly
 wr8qTp2oV5ZtqnnbtgIhugAseCEAE3b33gD8rf/7pQO/9aD5SZ8OgTSVtmMVr0j9qSK8
 NO6LfNapCMHlxQbqpzOAspCD7g0CKtQNoxNNEd3kdpeGORsiqbtGx6/MHpGh93BRjWNs
 QECZj2RF/Qx2HRt5vkbg8sZO80wF4DcUGI6Itr7bfec28Grz3Gqbn5F2so5EBLlp35GH
 9UuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC4MAz7A1wXYf82SmDPk12mHcVBZehp6nP6za2AsZYSGm91IOGseTyjuBTL2w/sC8PzkDDIwHiSCnX@nongnu.org
X-Gm-Message-State: AOJu0Ywqpe00WWAwx6uQBGIXsvE9Pdqh2bCni7qh4N8+uWX80R9ygIVF
 V+wrZMhhyW+DRZExR1OwaoSu6sI6Ntw5LRupizReWGmeud52buHxkgJHLrS0qbJ/GRHiYhBe1tu
 goB6dRX4wk6IlOONm7fwHMSH7QrM=
X-Gm-Gg: ASbGncvAHXVtOjpCI0RSZsH+99Q2FUr82mCx5LRCQq1H/8wURP1+f6+qp/UpJ+FMV+Z
 AkpFmvhDEl2upk5lsbYMYZkPWFpXNVQWRHFxNlUcvf1B3torJK968tmeB7eamgCly9NrwGJnI8w
 e7eW5KtN2Zg0sCbspUADsiw+MjXO9UcY+jbpVugdQfeN+/PsjAvmWK
X-Google-Smtp-Source: AGHT+IEpNZqTQEK1e/kOtUwWtmwhUNa5dxy15CFlXjOzN5JlDNNkaPdso5+S/iWpqboVtEdYX2PfiuPJwPz7VR5Sqz8=
X-Received: by 2002:a05:6102:161e:b0:4c3:64c0:8b14 with SMTP id
 ada2fe7eead31-4d3c73f1c0amr831771137.3.1745491826535; Thu, 24 Apr 2025
 03:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250408022121.173531-1-huangborong@bosc.ac.cn>
In-Reply-To: <20250408022121.173531-1-huangborong@bosc.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 20:49:59 +1000
X-Gm-Features: ATxdqUG_-rriHUqaJ_R8HY3BeswBWj6YDhMGoIY9Ad4qjWkw4XiBhUurVUYlvUo
Message-ID: <CAKmqyKOwbLJrRTkVrGO8+Kd-5SAEj1GU7ToytB8b66b_gbADHg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] target/riscv: Add BOSC's Xiangshan Kunminghu CPU
To: Huang Borong <huangborong@bosc.ac.cn>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-devel@nongnu.org, wangran@bosc.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Tue, Apr 8, 2025 at 12:23=E2=80=AFPM Huang Borong <huangborong@bosc.ac.c=
n> wrote:
>
> Add a CPU entry for the Xiangshan Kunminghu CPU, an open-source,
> high-performance RISC-V processor. More details can be found at:
> https://github.com/OpenXiangShan/XiangShan
>
> Note: The ISA extensions supported by the Xiangshan Kunminghu CPU are
> categorized based on four RISC-V specifications: Volume I: Unprivileged
> Architecture, Volume II: Privileged Architecture, AIA, and RVA23. The
> extensions within each category are organized according to the chapter
> order in the specifications.
>
> Signed-off-by: Yu Hu <huyu@bosc.ac.cn>
> Signed-off-by: Ran Wang <wangran@bosc.ac.cn>
> Signed-off-by: Borong Huang <huangborong@bosc.ac.cn>
> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 72 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 4cfdb74891..f2908939e7 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -53,6 +53,7 @@
>  #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
>  #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon"=
)
>  #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-n=
anhu")
> +#define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-k=
unminghu")
>  #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>
>  OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 09ded6829a..a076d9dc0c 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -697,6 +697,76 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *ob=
j)
>  #endif
>  }
>
> +static void rv64_xiangshan_kmh_cpu_init(Object *obj)
> +{
> +    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> +    RISCVCPU *cpu =3D RISCV_CPU(obj);
> +
> +    riscv_cpu_set_misa_ext(env, RVG | RVC | RVB | RVS | RVU | RVH | RVV)=
;
> +    env->priv_ver =3D PRIV_VERSION_1_13_0;
> +
> +    /* Enable ISA extensions */
> +    cpu->cfg.mmu =3D true;
> +    cpu->cfg.pmp =3D true;
> +
> +    /*
> +     * The RISC-V Instruction Set Manual: Volume I
> +     * Unprivileged Architecture
> +     */
> +    cpu->cfg.ext_zicntr =3D true;
> +    cpu->cfg.ext_zihpm =3D true;
> +    cpu->cfg.ext_zihintntl =3D true;
> +    cpu->cfg.ext_zihintpause =3D true;
> +    cpu->cfg.ext_zimop =3D true;
> +    cpu->cfg.ext_zcmop =3D true;
> +    cpu->cfg.ext_zicond =3D true;
> +    cpu->cfg.ext_zawrs =3D true;
> +    cpu->cfg.ext_zacas =3D true;
> +    cpu->cfg.ext_zfh =3D true;
> +    cpu->cfg.ext_zfa =3D true;
> +    cpu->cfg.ext_zcb =3D true;
> +    cpu->cfg.ext_zbc =3D true;
> +    cpu->cfg.ext_zvfh =3D true;
> +    cpu->cfg.ext_zkn =3D true;
> +    cpu->cfg.ext_zks =3D true;
> +    cpu->cfg.ext_zkt =3D true;
> +    cpu->cfg.ext_zvbb =3D true;
> +    cpu->cfg.ext_zvkt =3D true;
> +
> +    /*
> +     * The RISC-V Instruction Set Manual: Volume II
> +     * Privileged Architecture
> +     */
> +    cpu->cfg.ext_smstateen =3D true;
> +    cpu->cfg.ext_smcsrind =3D true;
> +    cpu->cfg.ext_sscsrind =3D true;
> +    cpu->cfg.ext_svnapot =3D true;
> +    cpu->cfg.ext_svpbmt =3D true;
> +    cpu->cfg.ext_svinval =3D true;
> +    cpu->cfg.ext_sstc =3D true;
> +    cpu->cfg.ext_sscofpmf =3D true;
> +    cpu->cfg.ext_ssdbltrp =3D true;
> +    cpu->cfg.ext_ssnpm =3D true;
> +    cpu->cfg.ext_smnpm =3D true;
> +    cpu->cfg.ext_smmpm =3D true;
> +    cpu->cfg.ext_sspm =3D true;
> +    cpu->cfg.ext_supm =3D true;
> +
> +    /* The RISC-V Advanced Interrupt Architecture */
> +    cpu->cfg.ext_smaia =3D true;
> +    cpu->cfg.ext_ssaia =3D true;
> +
> +    /* RVA23 Profiles */
> +    cpu->cfg.ext_zicbom =3D true;
> +    cpu->cfg.ext_zicbop =3D true;
> +    cpu->cfg.ext_zicboz =3D true;
> +    cpu->cfg.ext_svade =3D true;
> +
> +#ifndef CONFIG_USER_ONLY
> +    set_satp_mode_max_supported(cpu, VM_1_10_SV48);
> +#endif
> +}
> +

Sorry about this, but we just merged a new way of defining CPU types.
Can you please rebase on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next to use the
new macros? It shouldn't be much work, just a little restructuring.

When sending a new version can you also include a cover letter [1]

1: https://www.qemu.org/docs/master/devel/submitting-a-patch.html#include-a=
-meaningful-cover-letter

Alistair

>  #ifdef CONFIG_TCG
>  static void rv128_base_cpu_init(Object *obj)
>  {
> @@ -3261,6 +3331,8 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_=
v1_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
>                                                   MXL_RV64, rv64_xiangsha=
n_nanhu_cpu_init),
> +    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_KMH,
> +                                                 MXL_RV64,  rv64_xiangsh=
an_kmh_cpu_init),
>  #ifdef CONFIG_TCG
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_c=
pu_init),
>  #endif /* CONFIG_TCG */
> --
> 2.34.1
>
>

