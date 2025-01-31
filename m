Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD41DC02194
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 00:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdef8-0001Cl-LS; Thu, 30 Jan 2025 19:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdef7-0001CV-42; Thu, 30 Jan 2025 19:13:33 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdef5-0007Eb-Bz; Thu, 30 Jan 2025 19:13:32 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-518a52c8b5aso462879e0c.2; 
 Thu, 30 Jan 2025 16:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738282410; x=1738887210; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8rHVcW7DGvjB3qZZiatZAb/KjP65k9EZUncJgy5lDT4=;
 b=VhAB3x+0DuceR3C26K1q4cPhfSSDABGrqHWQSFSYvPjgHCyp51G2o0LnZPKE8GXJMb
 BDtst9+Mfy8IjW6dj1nECVoOAg2+wJza3U2Az9SkzTJQKJwWJxXJmvRHyp1wKIcWGLlt
 BgwxTTWjcz4Hz4oM+hMppJ863+VErg6xwweCGk9lClqZB4AZY6dJerWgL9tQeVekjUng
 OwbU0PM5NN34SvCrfzpmrPFzsbBQ5niEgpprIQ1iJ/VZG1sClhgYaDz6pG+xn3pIIcUg
 sQGQhUZhgg9FBQgYjqnWlqXpnTe6bz/gNtmg9jeOMydri/tCoZnSumAT0hTT50hjqBgf
 WmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738282410; x=1738887210;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8rHVcW7DGvjB3qZZiatZAb/KjP65k9EZUncJgy5lDT4=;
 b=gNPN9r+wfIeOP4XY5NMvegBMutvyDVHTfmQ2uBqf5W5/AwGplOaJmDa9n41N82YbXd
 juWT37bKO3BARi5N3KhRytQLTdtsniLcEVSwt2KS9swkckkpa9YhmtRtIE2h/fW1EGfO
 O/qJnu4wc56yMkx9wbZ7nDguvzIz35EGhH0DeOWJ9TuKOleDs3wl8RNLr04sJaMEWM/9
 OxGiGWPsU9xHacixhlI6mrV6H7vrcv3mcIaXLpd24FEIVuCgFjkr8odtgHhK/9gyeWCM
 FZNkVXtdElxXM9tUcYu78lKmO7nwj59bwHoK4u2Rk5nh+qV4iY5wd1FTJ5p2AyK/v7L/
 vThA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8ft1Wsqdd22ttJhK6N82JQCLW1rPBg0SrN03APccdKBIDxKIjCSLldOXSRyh69mD2rBL0huYFeKbw@nongnu.org
X-Gm-Message-State: AOJu0Yy4lVq28juFlhr2KAsy9fkvpuat1zgfJydKI5GkLlWhQwX7VFNi
 SIbvXZJumOP8lBxNyaJH6TguLtvB3ZcqTvPNVAsf8V1duhnFxlKonTzQeSVhSl/Xu0Q8zUJrOkd
 CJwsQDQiCl96hpMWapYI+JLQeXn0q5A==
X-Gm-Gg: ASbGncuv2mKHuNtVUxh2sHB7vxG6JK8O55YHOWsLcQ9YtEh2e5CciIZT8pWsOQ6lv+M
 YGgu88axGh7ao137P7/IGW4WMaiCO7Z7JkndaZuLIUrRzn4MVmh2pae1osYTdgzWkxL6hlZ0OfJ
 3xvBSkw7lVNc8iBVoCYtl3bUir0iA=
X-Google-Smtp-Source: AGHT+IGugLuRRXIm4DtLIJHwYgyoTr6cui+WpuTQotMjTbQQfJmKeNGKvjAr71DjnC0Q/ziIB6197D/3AzipaEYnVK8=
X-Received: by 2002:a05:6122:4281:b0:51c:c663:a337 with SMTP id
 71dfb90a1353d-51e9e28a525mr8549847e0c.0.1738282409709; Thu, 30 Jan 2025
 16:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20250115184316.2344583-1-dbarboza@ventanamicro.com>
 <20250115184316.2344583-7-dbarboza@ventanamicro.com>
In-Reply-To: <20250115184316.2344583-7-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2025 10:13:03 +1000
X-Gm-Features: AWEUYZmkjBwlQxby_EJe5mz96ObPr7yle3d9dR0Owlf6zA_nXSbQqfH14Vmw2ZU
Message-ID: <CAKmqyKN61eJs7tWnD05Wp-LcGvwUgb1Z5FjqFtSe8yBjpCdxsQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] target/riscv: add RVA23S64 profile
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
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

On Thu, Jan 16, 2025 at 4:45=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Add RVA23S64 as described in [1]. This profile inherits all mandatory
> extensions of RVA23U64 and RVA22S64, making it a child of both profiles.
>
> A new "rva23s64" profile CPU is also added. This is the generated
> riscv,isa for it (taken via -M dumpdtb):
>
> rv64imafdcbvh_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_
> ziccrse_zicond_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zimop_
> zmmul_za64rs_zaamo_zalrsc_zawrs_zfa_zfhmin_zca_zcb_zcd_zcmop_zba_zbb_zbs_
> zkt_zvbb_zve32f_zve32x_zve64f_zve64d_zve64x_zvfhmin_zvkb_zvkt_shcounteren=
w_
> sha_shgatpa_shtvala_shvsatpa_shvstvala_shvstvecd_smnpm_smstateen_ssccptr_
> sscofpmf_sscounterenw_ssnpm_ssstateen_sstc_sstvala_sstvecd_ssu64xl_
> supm_svade_svinval_svnapot_svpbmt
>
> [1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.a=
doc
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 53ead481a9..4cfdb74891 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -41,6 +41,7 @@
>  #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
>  #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
>  #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
> +#define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
>  #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibe=
x")
>  #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>  #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31"=
)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 761da41e53..adfce231a7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2421,10 +2421,41 @@ static RISCVCPUProfile RVA23U64 =3D {
>      }
>  };
>
> +/*
> + * As with RVA23U64, RVA23S64 also defines 'named features'.
> + *
> + * Cache related features that we consider enabled since we don't
> + * implement cache: Ssccptr
> + *
> + * Other named features that we already implement: Sstvecd, Sstvala,
> + * Sscounterenw, Ssu64xl
> + *
> + * The remaining features/extensions comes from RVA23S64.
> + */
> +static RISCVCPUProfile RVA23S64 =3D {
> +    .u_parent =3D &RVA23U64,
> +    .s_parent =3D &RVA22S64,
> +    .name =3D "rva23s64",
> +    .misa_ext =3D RVS,
> +    .priv_spec =3D PRIV_VERSION_1_13_0,
> +    .satp_mode =3D VM_1_10_SV39,
> +    .ext_offsets =3D {
> +        /* New in RVA23S64 */
> +        CPU_CFG_OFFSET(ext_svnapot), CPU_CFG_OFFSET(ext_sstc),
> +        CPU_CFG_OFFSET(ext_sscofpmf), CPU_CFG_OFFSET(ext_ssnpm),
> +
> +        /* Named features: Sha */
> +        CPU_CFG_OFFSET(ext_sha),
> +
> +        RISCV_PROFILE_EXT_LIST_END
> +    }
> +};
> +
>  RISCVCPUProfile *riscv_profiles[] =3D {
>      &RVA22U64,
>      &RVA22S64,
>      &RVA23U64,
> +    &RVA23S64,
>      NULL,
>  };
>
> @@ -2918,6 +2949,13 @@ static void rva23u64_profile_cpu_init(Object *obj)
>
>      RVA23U64.enabled =3D true;
>  }
> +
> +static void rva23s64_profile_cpu_init(Object *obj)
> +{
> +    rv64i_bare_cpu_init(obj);
> +
> +    RVA23S64.enabled =3D true;
> +}
>  #endif
>
>  static const gchar *riscv_gdb_arch_name(CPUState *cs)
> @@ -3198,6 +3236,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_pro=
file_cpu_init),
>      DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_pro=
file_cpu_init),
>      DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_pro=
file_cpu_init),
> +    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  MXL_RV64,  rva23s64_pro=
file_cpu_init),
>  #endif /* TARGET_RISCV64 */
>  };
>
> --
> 2.47.1
>
>

