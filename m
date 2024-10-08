Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F944CED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 00:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyQF-00072w-WF; Mon, 07 Oct 2024 20:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxyQE-00072f-Ed; Mon, 07 Oct 2024 20:49:54 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxyQC-0005QF-Vm; Mon, 07 Oct 2024 20:49:54 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-50abd42a6b2so3474072e0c.0; 
 Mon, 07 Oct 2024 17:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728348584; x=1728953384; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/z6WiVmtUbbKwjOUBqxNjOTosLFsd4CXzc8JqXjGuQ=;
 b=UxUcgNZmFZEp9yzWu76jIIeu30hfXW/NRVcHcYnNQS1W+AeZzY46nRlWsIzlmy2+tp
 I0F3MnwPQWpM+GrCr35QQx5Sg5EGNuPLF00MOqo8WepH/9izzjXvqHzcYTEGfLrljNwa
 gGqxSorAcV6/JNAptVvwnKxVj9ijMwNPaDoE8GKORjvV5KikjPgPRVxMFjPYybFBievD
 NROW1X4BsZKBa5TmimKc1tg3UxKKQjLRDkeAdeGjUgyodXvXdA1NTfzY1rmT+ODo+nAx
 ESs4CYz81Trwd6wOQImyRblhbQXaImncoXF3px89PvSkNzoj8WcVJC7oN9SsSQODTjMv
 Yjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728348584; x=1728953384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/z6WiVmtUbbKwjOUBqxNjOTosLFsd4CXzc8JqXjGuQ=;
 b=VuIu8HDMyH1wBk4jr7l2LiSwtK7AURTPcDQf4cwEDE1TWC8IUcuBrUASPjwTZVF2f6
 eHwExoVetml4HNY876PGvTIojB8XcR8eBEVJXwfvjDYUN/ReKTZsSN5ZHFYDim1UKTyB
 fCaRwKTohwTsruoJGL9TggiCNUj20zZSjtof88TKX+VAX2AL2eH9gmz3UkYwripHbcan
 xUJdMsP0HH/2g20kaIAPbfqm16Zgb5DLb+G6hDqnx5D/9+pkcyf574iXbfGfbwjfWe0d
 5PWnBRQ40qlyK1luf+o0+yYVBDzvkv9hZ4sJ55JXoXbxW/VHVoFf41oUJ33T23jOMbx3
 OvMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzJ1rE/pSN3gdACU5sJQgXGXkJEtDtsmecBbUHuDvYiLIaV7oqBBZV+zkIspCru5HszjVdFVXyzrRj@nongnu.org
X-Gm-Message-State: AOJu0YznfANF9ip0kH68+QvZudYKPV/WkmVhY2eHFc3Bl0lsoaRFnuIY
 i1onKkux3WLDy4ktSauZuHjMQCOnT6vkVqi+0xYykWvR61FU9U4Y+CWjMxgX2w8JIKxYQSl3yDW
 LEKw6PmpeMVx5yseTjnHeTIip6pM=
X-Google-Smtp-Source: AGHT+IEVxBn0+c31tFPPWPvY4CtqLHCUm2hHhmCUcxs7solHt6dRyy6iNvI+wPke6aaTVgB00B5MZMuBCwilRzkb+CM=
X-Received: by 2002:a05:6122:35cd:b0:4f5:312a:6573 with SMTP id
 71dfb90a1353d-50cd812faeamr1304977e0c.5.1728348584271; Mon, 07 Oct 2024
 17:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240919055048.562-1-zhiwei_liu@linux.alibaba.com>
 <20240919055048.562-8-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240919055048.562-8-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Oct 2024 10:49:18 +1000
Message-ID: <CAKmqyKOyR---gKrQkZWaTs65sr05P3f8M+M5uzhNKWbhLFn_Og@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] target/riscv: Add max32 CPU for RV64 QEMU
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Thu, Sep 19, 2024 at 3:56=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> We may need 32-bit max for RV64 QEMU. Thus we add these two CPUs
> for RV64 QEMU.
>
> The reason we don't expose them to RV32 QEMU is that we already have
> max cpu with the same configuration. Another reason is that we want
> to follow the RISC-V custom where addw instruction doesn't exist in
> RV32 CPU.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 12 +++++++-----
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 4464c0fd7a..62115375cd 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -30,6 +30,7 @@
>  #define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)
>
>  #define TYPE_RISCV_CPU_MAX              RISCV_CPU_TYPE_NAME("max")
> +#define TYPE_RISCV_CPU_MAX32            RISCV_CPU_TYPE_NAME("max32")
>  #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
>  #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
>  #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 86ce15252a..baf8fba467 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -448,11 +448,9 @@ static void riscv_max_cpu_init(Object *obj)
>
>      env->priv_ver =3D PRIV_VERSION_LATEST;
>  #ifndef CONFIG_USER_ONLY
> -#ifdef TARGET_RISCV32
> -    set_satp_mode_max_supported(cpu, VM_1_10_SV32);
> -#else
> -    set_satp_mode_max_supported(cpu, VM_1_10_SV57);
> -#endif
> +    set_satp_mode_max_supported(RISCV_CPU(obj),
> +        riscv_cpu_mxl(&RISCV_CPU(obj)->env) =3D=3D MXL_RV32 ?
> +        VM_1_10_SV32 : VM_1_10_SV57);
>  #endif
>  }
>
> @@ -2945,6 +2943,10 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32E,        MXL_RV32,  rv32e_bare_c=
pu_init),
>  #endif
>
> +#if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
> +    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX32,     MXL_RV32,  riscv_max_cp=
u_init),
> +#endif
> +
>  #if defined(TARGET_RISCV64)
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cp=
u_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_=
e_cpu_init),
> --
> 2.43.0
>
>

