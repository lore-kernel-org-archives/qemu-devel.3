Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D81C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kit-0002Nl-1T; Wed, 23 Apr 2025 20:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kio-0002Ml-1u
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:45:47 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7kil-00047n-5g
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:45:45 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-5259327a937so215229e0c.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745455542; x=1746060342; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gO2NRRrPObZA3qLmDb64IhJ8aTjU0+tapirJ/SqenwA=;
 b=FVKtq+fu0daeDqISwcpPhorYc5v6n922dEBEcGtsZaGvVqA0nuTLUk3rO0HBVNcvJQ
 OlBM9i5WXdLuAHpnLe2zwNGzKnikBZxsrMf+wwrekyCZBgyqFWCGpFrVE8ueRfWF/Wi/
 v4g11iEXSOizmbpd314q1knTsUrgocUVXmLULSOoIlmZP2bnsrBKeEL+9ipnevUjE63C
 2EulICzKzWMreqAnewxyZ84ZtcRgykSKtP/IrY/jA2cXo+OfW3g/fWD0x5+4+EBVlAaG
 OfROJeW89kFtdR6W7C23LCceQiA7bMxfCnYaCYxK9KGN0lR8LfenHsmwJREf97/IVPN7
 Fn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455542; x=1746060342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gO2NRRrPObZA3qLmDb64IhJ8aTjU0+tapirJ/SqenwA=;
 b=ZxvePU9gdQXSroalFGFDsEIgLMDFTXa00VdEKLsGhVqZovOW+np1DQSo9UOgQrThU+
 6RpfSEdSVdkYlNxiV3XUQhZ8EKTDOtbvj7paznbPAYR9VVqh7ANO8FOut1jBh2W0h/0a
 IwXBZmQpBS9wBOZagmpINYT7BDCfL6Qto4HUyEldgir4tgIGcJf3qmHFYh9AAh6L8Mv1
 +M+WLEeP9OMc+xs/00yM3uJ8YVJzQe6BsyEXuoLW990pbnnS4PVJaEP6u2FKT1xOWbVc
 Y49SjRdidvHLC3UPFzJPgbQFNjxxST5EHhRRtKYp7TTAWpCzzmBSxNaeTvfqC27SbMbr
 /udQ==
X-Gm-Message-State: AOJu0Yx4osdJf6BwQrcxtGKdWmBYmONXXVonsEYO1JdyndRtX0pSWLit
 OEnZkmsR4osApUbq3GjOSpY8y6GehidUB5g5mjtnGcLFS0RralWMOffzhVniqpRbzfSg7SiZN0p
 kkrHN094KQDS/+Cma/EULwZEgxab5aw==
X-Gm-Gg: ASbGncuv/JtNfv6Z5WvZaWUkrIoJqXehjaUxWHtTq7YKiXPGvfMjlxwilw0LJzfCcEc
 XfyXAl3vXI3uQcUTUxvgt4nisfNj0Xkpw5wg0URtwzJhtxYZbjABbbIn3BPpZqUwiAZizVqE4PL
 zI7obZatNrnWcb608JeI0rky94eqALbI689N9Q+l3pHF4/r6Fpo55v
X-Google-Smtp-Source: AGHT+IHEI+JTjJtGknUkhaZSF0fuFb9smABPcRpa3+JfQaOUi635knEKuvRHh9I3DwcOE4CVG89On6oeKU2lcpnb9us=
X-Received: by 2002:a05:6122:a0e:b0:525:9440:243c with SMTP id
 71dfb90a1353d-52a783e491fmr664737e0c.11.1745455541849; Wed, 23 Apr 2025
 17:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-26-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-26-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 10:45:15 +1000
X-Gm-Features: ATxdqUFweJhmzz_PAXJGwBN4MwhXcgw4ykmgW8xuj00XThOFnLajGiOHmT06knI
Message-ID: <CAKmqyKNn3e+YjWCqaUr4GEEUt42jV01mRQpoogtaRUh2c9avcA@mail.gmail.com>
Subject: Re: [PATCH 25/27] target/riscv: convert Ventana V1 to RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
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

On Sun, Apr 6, 2025 at 5:04=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 75 ++++++++++++++++++++++------------------------
>  1 file changed, 35 insertions(+), 40 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 616d89be17e..4e4d8ddf5a2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -500,45 +500,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu=
, const RISCVCSR *csr_list)
>  #endif
>
>  #if defined(TARGET_RISCV64)
> -static void rv64_veyron_v1_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -
> -    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH);
> -    env->priv_ver =3D PRIV_VERSION_1_12_0;
> -
> -    /* Enable ISA extensions */
> -    cpu->cfg.mmu =3D true;
> -    cpu->cfg.ext_zifencei =3D true;
> -    cpu->cfg.ext_zicsr =3D true;
> -    cpu->cfg.pmp =3D true;
> -    cpu->cfg.ext_zicbom =3D true;
> -    cpu->cfg.cbom_blocksize =3D 64;
> -    cpu->cfg.cboz_blocksize =3D 64;
> -    cpu->cfg.ext_zicboz =3D true;
> -    cpu->cfg.ext_smaia =3D true;
> -    cpu->cfg.ext_ssaia =3D true;
> -    cpu->cfg.ext_sscofpmf =3D true;
> -    cpu->cfg.ext_sstc =3D true;
> -    cpu->cfg.ext_svinval =3D true;
> -    cpu->cfg.ext_svnapot =3D true;
> -    cpu->cfg.ext_svpbmt =3D true;
> -    cpu->cfg.ext_smstateen =3D true;
> -    cpu->cfg.ext_zba =3D true;
> -    cpu->cfg.ext_zbb =3D true;
> -    cpu->cfg.ext_zbc =3D true;
> -    cpu->cfg.ext_zbs =3D true;
> -    cpu->cfg.ext_XVentanaCondOps =3D true;
> -
> -    cpu->cfg.mvendorid =3D VEYRON_V1_MVENDORID;
> -    cpu->cfg.marchid =3D VEYRON_V1_MARCHID;
> -    cpu->cfg.mimpid =3D VEYRON_V1_MIMPID;
> -
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(cpu, VM_1_10_SV48);
> -#endif
> -}
>
>  static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
>  {
> @@ -3211,7 +3172,41 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.max_satp_mode =3D VM_1_10_SV57,
>      ),
>
> -    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_=
v1_cpu_init),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_VEYRON_V1, TYPE_RISCV_VENDOR_CPU,
> +        .misa_mxl_max =3D MXL_RV64,
> +        .misa_ext =3D RVG | RVC | RVS | RVU | RVH,
> +        .priv_spec =3D PRIV_VERSION_1_12_0,
> +
> +        /* ISA extensions */
> +        .cfg.mmu =3D true,
> +        .cfg.ext_zifencei =3D true,
> +        .cfg.ext_zicsr =3D true,
> +        .cfg.pmp =3D true,
> +        .cfg.ext_zicbom =3D true,
> +        .cfg.cbom_blocksize =3D 64,
> +        .cfg.cboz_blocksize =3D 64,
> +        .cfg.ext_zicboz =3D true,
> +        .cfg.ext_smaia =3D true,
> +        .cfg.ext_ssaia =3D true,
> +        .cfg.ext_sscofpmf =3D true,
> +        .cfg.ext_sstc =3D true,
> +        .cfg.ext_svinval =3D true,
> +        .cfg.ext_svnapot =3D true,
> +        .cfg.ext_svpbmt =3D true,
> +        .cfg.ext_smstateen =3D true,
> +        .cfg.ext_zba =3D true,
> +        .cfg.ext_zbb =3D true,
> +        .cfg.ext_zbc =3D true,
> +        .cfg.ext_zbs =3D true,
> +        .cfg.ext_XVentanaCondOps =3D true,
> +
> +        .cfg.mvendorid =3D VEYRON_V1_MVENDORID,
> +        .cfg.marchid =3D VEYRON_V1_MARCHID,
> +        .cfg.mimpid =3D VEYRON_V1_MIMPID,
> +
> +        .cfg.max_satp_mode =3D VM_1_10_SV48,
> +    ),
> +
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
>                                                   MXL_RV64, rv64_xiangsha=
n_nanhu_cpu_init),
>  #ifdef CONFIG_TCG
> --
> 2.49.0
>

