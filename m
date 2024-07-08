Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E669C38150
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 02:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQeNF-0007zF-9V; Sun, 07 Jul 2024 22:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQeNC-0007ot-HQ; Sun, 07 Jul 2024 22:45:03 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQeNA-0006sw-SI; Sun, 07 Jul 2024 22:45:02 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4f2c8e99c0fso1241635e0c.1; 
 Sun, 07 Jul 2024 19:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720406699; x=1721011499; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5QNLve9vyMt55AWjkOMdZjwkvJj2X8LZA7QTcU3bobk=;
 b=LpGO30d6QZ+4VZ7mEQ53Jgj0JDzck7V+rdTeRrszAjPe80tQ7MdWPCWIC89gZ+jd8e
 QEAJYcyl/nuZzBsSUskzjq4IgQVXvJQV1lLxAhjwv1C6mIPzXsxYDlt6Na7xULD8L3/U
 5FZ5zcp9WIJLnQ58EtniJEQ3hTSgWdz50QsSlcOlDRP9crH52BCBu4LRY4BsI7BX909Y
 1lL/iz37Vn2OjoBJEP+QiHgpt+q9MzlYoYIqjy31bv0mAhpoiC6cdtqdan/J+L7FP1Hj
 Np6uGZCMmkxaBcb99DHFlGn6nQuft1P0aGx0enog/s3JsJGZpg2nCqNqQi0I0i4dpIwC
 mT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720406699; x=1721011499;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QNLve9vyMt55AWjkOMdZjwkvJj2X8LZA7QTcU3bobk=;
 b=REaudHEAlZJw1e+15/Tyc6tPI1wXtHmaVhocBY9z8ZwbpyWdNd/TpK69dHUG42VrrE
 N8DbitsAf97N21UoaOnrzbuqe3oe+tJVAjPlkO9pmaxxbmhz2PTZnXGPMAdfSMXe4ho4
 wRCm2Lhhnvyzj0H6oA92w/Pr18HmQFoMzrWE+x9a3nm3J87HY9JUELkVjZJ1lQlKkriO
 u92BK2xyTd7xKDJYerXZRV6a0Y2aii3xD/oAl1FSMAOI5yPuSSOJZz2wLwWydAA7sxbI
 sEf8zZWHdoU5x12DTg2RrZSU+Wf4nib4vjCfKQRXRjdML3R0EtIqXVzx0aZVjC5+LlcR
 wetg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1y56V17GsTsUBeF4fzdFgxUSJ/nFOq28P/mH/4frzC68wIbX3Ar0OILqjLM1fGK2rgttH3wh/W6l8AP+S43o3vfLkTXI=
X-Gm-Message-State: AOJu0YzTy5yhLTf0ds8hx9+2BHuchzx1+nWtLhdncK+jTSobPKdPnQv6
 z7rD6urVxtpNJQPD2KvY7zBBeQz3Ovaj7twCgh9/4HMEJ/OEkyGMsAvvO5gFRoeouWX+pY25ruM
 ZV+Nxn832CfUE1d18z7LN2exviLc=
X-Google-Smtp-Source: AGHT+IG/uGz/9dD27AndiPLDIl4h8BnX45Kc/w/jiuOYD5S0hJ36pm4O5yjyVi97k63lQcsEYj1r11oWLrJc8cJ73/s=
X-Received: by 2002:a05:6122:1c0d:b0:4ef:678e:8a90 with SMTP id
 71dfb90a1353d-4f2f3e95cb0mr11839634e0c.3.1720406699459; Sun, 07 Jul 2024
 19:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240703144921.1281-1-zhiwei_liu@linux.alibaba.com>
 <20240703144921.1281-7-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240703144921.1281-7-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 8 Jul 2024 12:44:33 +1000
Message-ID: <CAKmqyKNv8c1GBAZnnQvFy8vWxq3b56W1mEQXK44a3yxrJm2F6A@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] target/riscv: Enable RV32 CPU support in RV64 QEMU
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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

On Thu, Jul 4, 2024 at 12:55=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>
> Add gdb XML files and adjust CPU initialization to allow running RV32 CPU=
s
> in RV64 QEMU.
>
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  configs/targets/riscv64-softmmu.mak |  2 +-
>  target/riscv/cpu.c                  | 17 +++++++++++++----
>  2 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv6=
4-softmmu.mak
> index 917980e63e..6c5de72e03 100644
> --- a/configs/targets/riscv64-softmmu.mak
> +++ b/configs/targets/riscv64-softmmu.mak
> @@ -2,6 +2,6 @@ TARGET_ARCH=3Driscv64
>  TARGET_BASE_ARCH=3Driscv
>  TARGET_SUPPORTS_MTTCG=3Dy
>  TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
> -TARGET_XML_FILES=3D gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.=
xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
> +TARGET_XML_FILES=3D gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.=
xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml gdb-xml/ris=
cv-32bit-cpu.xml gdb-xml/riscv-32bit-virtual.xml
>  # needed by boot.c
>  TARGET_NEED_FDT=3Dy
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a2640cf259..fdd0f10aa5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -630,8 +630,10 @@ static void rv64e_bare_cpu_init(Object *obj)
>      riscv_cpu_set_misa_ext(env, RVE);
>  }
>
> -#else /* !TARGET_RISCV64 */
> +#endif /* !TARGET_RISCV64 */
>
> +#if defined(TARGET_RISCV32) || \
> +    (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
>  static void rv32_base_cpu_init(Object *obj)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(obj);
> @@ -2944,6 +2946,13 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>  #if defined(TARGET_RISCV32)
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,       MXL_RV32,  riscv_any_cp=
u_init),
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cp=
u_init),
> +#elif defined(TARGET_RISCV64)
> +    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,       MXL_RV64,  riscv_any_cp=
u_init),
> +    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV64,  riscv_max_cp=
u_init),
> +#endif
> +
> +#if defined(TARGET_RISCV32) || \
> +    (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,    MXL_RV32,  rv32_base_cp=
u_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cp=
u_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_=
e_cpu_init),
> @@ -2951,9 +2960,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_=
u_cpu_init),
>      DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32I,        MXL_RV32,  rv32i_bare_c=
pu_init),
>      DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32E,        MXL_RV32,  rv32e_bare_c=
pu_init),
> -#elif defined(TARGET_RISCV64)
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,       MXL_RV64,  riscv_any_cp=
u_init),
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV64,  riscv_max_cp=
u_init),
> +#endif
> +
> +#if defined(TARGET_RISCV64)
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cp=
u_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_=
e_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_=
u_cpu_init),
> --
> 2.25.1
>
>

