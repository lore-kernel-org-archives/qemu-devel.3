Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90915D24468
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 03:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz6nV-0003i1-JQ; Thu, 10 Oct 2024 23:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz6nU-0003hh-JF; Thu, 10 Oct 2024 23:58:36 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz6nT-0006OW-1p; Thu, 10 Oct 2024 23:58:36 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-84fc5aaccf8so468077241.3; 
 Thu, 10 Oct 2024 20:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728619113; x=1729223913; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lEeOTKSIdAr+iTdLi/qdQIxcLIFex5Fuw8DUCxfgYcI=;
 b=NJxUzh8VroBzE9QIEyi+ehCn/oVZlDV54yrNdi/b8gSRJAi00Q2ueSVGgn+CZP/TGt
 pbf8fdZ+nb7moEz+WL5FuyYsQ5231U69FLUyr+K5A2HqVVo67cTR1x41fLmFY6Y0Ncx5
 Ql/5tKMqoLiFmw7nMDSDdS16S8lhDbqA5dBRqvL3jl65/aABMGAr+FW82eLPBjrJTgRC
 LhZBcGgREXP5HDgxayvXH+gYmSciUXE4gFAonrbPrq6anXY2oPlmJwsbZC3fVa/rJ+gq
 u65alvWOMOc8Fe8o6hLQ0j0ieumYKFb7pAAYY/xjXK5vjNLDiQILi4FRIN1O/v/mDBTP
 PvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728619113; x=1729223913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lEeOTKSIdAr+iTdLi/qdQIxcLIFex5Fuw8DUCxfgYcI=;
 b=b1vq4WhA0GBEoKGqkTtcoDh4pARvKM5h5Psyl4J134iwfBv5cld2RVylsZepL4ZPOJ
 /jr4nFu1YEPnqbvv+WA145h5CYTiVKdvE4lt1eFRg5++y2JGPKINsILDoeD7RJt62uTd
 OWZmzOVUnYipI6BQHVJYuQUo2iA30EHgUdIhQ4XtMZsqTQOqoc9p9YjBVMpasv/TusVw
 LjYia76gGgCTVd1R3gVPGP9rAQ8JixCJ3KcY9A2rcZlkYNo7lcX8dXuIbl4DD+dPJZ3F
 CwdqAU8DxI+8nArEgoLj8qUYJ+CUt7SeqXoZ3CXAjWCO5caYozS5uc233AX2Eie/Owus
 HTEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNi24vmskCyrkb+cAtNrWa7x2XpM2dH8MFZDcpXVHF5suPykBJJRZxTvr/FzGxaEysfNLvCp/Uuq1n@nongnu.org
X-Gm-Message-State: AOJu0YwkPAUTogQNoVTb6Q4Evy2o8mSBStJRZP1+kC181HapWYs4iPP4
 ryao2XZ1mKFIqBf0F9vL8XFJ17S7czvijY8+Hj5T8MQwDv4p+Vz1cnGMIZk43O93kKw9wlV5T5U
 5u9puNS3ojkWXdSBNJpGFfF5rTP8=
X-Google-Smtp-Source: AGHT+IFr5bjJ2Yp5zW9jtkKyc1JK5SydBq9MwXVDUjs86ebV1SXtsSb2End44x5+XSYNw3VRaCnenFT3DDgu28Low2k=
X-Received: by 2002:a05:6122:513:b0:508:4997:18c6 with SMTP id
 71dfb90a1353d-50d1ed5aeb8mr718834e0c.0.1728619113605; Thu, 10 Oct 2024
 20:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20241007033400.50163-1-zhiwei_liu@linux.alibaba.com>
 <20241007033400.50163-3-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20241007033400.50163-3-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Oct 2024 13:58:07 +1000
Message-ID: <CAKmqyKOtnBzNgeAWL6m0-oRRMgHXXKpv3n2WbtV4Z6bmL6MLVw@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] target/riscv: Fix satp read and write implicitly
 or explicitly.
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

On Mon, Oct 7, 2024 at 1:35=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>
> CSR satp is SXLEN bits in length and always has the $layout determined by
> the SXL configuration, regardless of the current XLEN.
>
> Only process CSR satp, as we still don't have a riscv_cpu_vsxl API
> currently.
>
> Added sxl32 property to control sxlen as 32 in s-mode for QEMU RV64.
>
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Fixes: c7b9517188 (RISC-V: Implement modular CSR helper interface)
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>  target/riscv/cpu_cfg.h |  4 ++++
>  target/riscv/csr.c     | 25 +++++++++++++++++++------
>  2 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 8b272fb826..cdbd2afe29 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -173,6 +173,10 @@ struct RISCVCPUConfig {
>      bool short_isa_string;
>
>  #ifndef CONFIG_USER_ONLY
> +    /*
> +     * true when RV64 QEMU running with mxlen=3D=3D64 but sxlen=3D=3D32.
> +     */
> +    bool sxl32;
>      RISCVSATPMap satp_mode;
>  #endif
>  };
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index b33cc1ec23..93a5cf87ed 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1504,16 +1504,29 @@ static RISCVException read_mstatus(CPURISCVState =
*env, int csrno,
>
>  static bool validate_vm(CPURISCVState *env, target_ulong vm)
>  {
> -    uint64_t mode_supported =3D riscv_cpu_cfg(env)->satp_mode.map;
> +    uint64_t mode_supported =3D 0;
> +    if (riscv_cpu_cfg(env)->sxl32 && (riscv_cpu_mxl(env) !=3D MXL_RV32))=
 {

This should be using the actual SXLEN values, not this special
property. What happens if the property is set to false but the guest
software sets SXLEN to 32-bits? This will break

Alistair

> +        mode_supported =3D (1 << VM_1_10_MBARE) | (1 << VM_1_10_SV32);
> +    } else {
> +        mode_supported =3D riscv_cpu_cfg(env)->satp_mode.map;
> +    }
>      return get_field(mode_supported, (1 << vm));
>  }
>
>  static target_ulong legalize_xatp(CPURISCVState *env, target_ulong old_x=
atp,
> -                                  target_ulong val)
> +                                  target_ulong val, int csrno)
>  {
>      target_ulong mask;
>      bool vm;
> -    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +    RISCVMXL xl;
> +
> +    if (csrno =3D=3D CSR_SATP) {
> +        xl =3D riscv_cpu_sxl(env);
> +    } else {
> +        xl =3D riscv_cpu_mxl(env);
> +    }
> +
> +    if (xl =3D=3D MXL_RV32) {
>          vm =3D validate_vm(env, get_field(val, SATP32_MODE));
>          mask =3D (val ^ old_xatp) & (SATP32_MODE | SATP32_ASID | SATP32_=
PPN);
>      } else {
> @@ -3316,7 +3329,7 @@ static RISCVException write_satp(CPURISCVState *env=
, int csrno,
>          return RISCV_EXCP_NONE;
>      }
>
> -    env->satp =3D legalize_xatp(env, env->satp, val);
> +    env->satp =3D legalize_xatp(env, env->satp, val, csrno);
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -3834,7 +3847,7 @@ static RISCVException read_hgatp(CPURISCVState *env=
, int csrno,
>  static RISCVException write_hgatp(CPURISCVState *env, int csrno,
>                                    target_ulong val)
>  {
> -    env->hgatp =3D legalize_xatp(env, env->hgatp, val);
> +    env->hgatp =3D legalize_xatp(env, env->hgatp, val, csrno);
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -4116,7 +4129,7 @@ static RISCVException read_vsatp(CPURISCVState *env=
, int csrno,
>  static RISCVException write_vsatp(CPURISCVState *env, int csrno,
>                                    target_ulong val)
>  {
> -    env->vsatp =3D legalize_xatp(env, env->vsatp, val);
> +    env->vsatp =3D legalize_xatp(env, env->vsatp, val, csrno);
>      return RISCV_EXCP_NONE;
>  }
>
> --
> 2.43.0
>
>

