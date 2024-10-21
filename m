Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82CAD3C935
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 00:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2gjK-0005f0-Sp; Sun, 20 Oct 2024 20:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2gjH-0005eX-NO; Sun, 20 Oct 2024 20:57:03 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2gjG-000339-1l; Sun, 20 Oct 2024 20:57:03 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-50d3998923dso1227809e0c.2; 
 Sun, 20 Oct 2024 17:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729472220; x=1730077020; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mvEeq9NpxqfN3oL3affbuyazFTgTYYEvefC/JYTKrg=;
 b=B2I2hJgPa6sM9uRQeT92J2EfeGsn/rO8exeI6Y1bfxm0nhON8zTL9NnTDIQWEaKW4M
 DtsOp66G5WKA7A4XC74YMxH+ZHWgEc7gYNyjGiIx9Gf7o+N87vo9oc2HYI1l6SdQx9uv
 /EuB68hqKAqvJa7YEI08K4coXHTpVkW6vMI0v2ll4Xv+kEKA4uUCD5aGCgW1mqgb5qYW
 n/pmCtW0+7P21nJjF4vOLM/S7S7A3xpINQPSqQgOmcuy6YpGQJC9aUqE7i8xm7AWt58M
 M22yUB3eDwQTmGapHeMNKfpGadOZ6NSZbnMlIisZbgaC/ForWTvuN8V2EzmKnfsCsjw1
 WrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729472220; x=1730077020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2mvEeq9NpxqfN3oL3affbuyazFTgTYYEvefC/JYTKrg=;
 b=S85uSFY4QQjZSfKNu5OeaKYa/d4pAOShIoN3AdvpGhb8vKGq6RQ6FH/CpjDIEf1aPF
 SsKbWcNd5mxiamxBJA/Ir58L7niSHLK/893uZdaX7oQlvXN/z96o+X1EjpuUbxuLpfbN
 pepqItjBO+LoD4MMIHvUjXlj56aZPrNE1y+SN4Oj2px5QZc4gw239zwQemMe1h8Nzcif
 ZrXtN16TQkyyMU7YLl1pcdWe3gJ7DPsg1QqZp8NaKppNOH4xG7Sbhl1dEvNaRIDXaKy6
 w1vHwXWSgrQkeYyOU44xA/UvS3Lb10c7wtCzkW8qIEdzKPwsDcznDu0yvZXGaDxRXv9F
 5nDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj7FvgXr4w4J6ktxd0m9TEM0PP5OjIXEhC3X33ywLBrTnb6woWjg8E2vNP6trgE/1pNs53mmPY2kJ4@nongnu.org
X-Gm-Message-State: AOJu0YwAJZl0eWz55e26Zi+QbmExyE8blKumsvhdPvZqlpCAZS3DuJJ9
 h7GEQL3RVnJ2Q6FnoSxw1QVjD9xyK74swDqNN+QEModj3Ey3NJXiQ+kKLZJdkFb9PQlMX+3bhwD
 BcAL5hWLFEr3JrCbhsWnWMx3GSxw=
X-Google-Smtp-Source: AGHT+IHYpmnhj5zgZIoCi6TqO05wFN7RBZR5I6JDObltfKMcMuUqPewHAlzMIZMRNCJK2FdPlqmojeS4OVSF65S46sU=
X-Received: by 2002:a05:6122:4584:b0:50c:eb10:9799 with SMTP id
 71dfb90a1353d-50dda029213mr6277696e0c.1.1729472220680; Sun, 20 Oct 2024
 17:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241017145226.365825-1-cleger@rivosinc.com>
 <20241017145226.365825-4-cleger@rivosinc.com>
In-Reply-To: <20241017145226.365825-4-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2024 10:56:34 +1000
Message-ID: <CAKmqyKNEMbQfmuuJDv0iM_+4fW7Rc0Pm03Rhy+isq1uxF0+NkQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] target/riscv: Implement Ssdbltrp sret, mret and
 mnret behavior
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Fri, Oct 18, 2024 at 12:53=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> When the Ssdbltrp extension is enabled, SSTATUS.SDT field is cleared
> when executing sret. When executing mret/mnret, SSTATUS.SDT is cleared
> when returning to U, VS or VU and VSSTATUS.SDT is cleared when returning
> to VU from HS.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/op_helper.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 180886f32a..dabc74de39 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -287,6 +287,18 @@ target_ulong helper_sret(CPURISCVState *env)
>                          get_field(mstatus, MSTATUS_SPIE));
>      mstatus =3D set_field(mstatus, MSTATUS_SPIE, 1);
>      mstatus =3D set_field(mstatus, MSTATUS_SPP, PRV_U);
> +
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        if (riscv_has_ext(env, RVH)) {
> +            target_ulong prev_vu =3D get_field(env->hstatus, HSTATUS_SPV=
) &&
> +                                   prev_priv =3D=3D PRV_U;
> +            /* Returning to VU from HS, vsstatus.sdt =3D 0 */
> +            if (!env->virt_enabled && prev_vu) {
> +                env->vsstatus =3D set_field(env->vsstatus, MSTATUS_SDT, =
0);
> +            }
> +        }
> +        mstatus =3D set_field(mstatus, MSTATUS_SDT, 0);
> +    }
>      if (env->priv_ver >=3D PRIV_VERSION_1_12_0) {
>          mstatus =3D set_field(mstatus, MSTATUS_MPRV, 0);
>      }
> @@ -297,7 +309,6 @@ target_ulong helper_sret(CPURISCVState *env)
>          target_ulong hstatus =3D env->hstatus;
>
>          prev_virt =3D get_field(hstatus, HSTATUS_SPV);
> -
>          hstatus =3D set_field(hstatus, HSTATUS_SPV, 0);
>
>          env->hstatus =3D hstatus;
> @@ -328,6 +339,22 @@ static void check_ret_from_m_mode(CPURISCVState *env=
, target_ulong retpc,
>          riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC()=
);
>      }
>  }
> +static target_ulong ssdbltrp_mxret(CPURISCVState *env, target_ulong msta=
tus,
> +                                   target_ulong prev_priv,
> +                                   target_ulong prev_virt)
> +{
> +    /* If returning to U, VS or VU, sstatus.sdt =3D 0 */
> +    if (prev_priv =3D=3D PRV_U || (prev_virt &&
> +        (prev_priv =3D=3D PRV_S || prev_priv =3D=3D PRV_U))) {
> +        mstatus =3D set_field(mstatus, MSTATUS_SDT, 0);
> +        /* If returning to VU, vsstatus.sdt =3D 0 */
> +        if (prev_virt && prev_priv =3D=3D PRV_U) {
> +            env->vsstatus =3D set_field(env->vsstatus, MSTATUS_SDT, 0);
> +        }
> +    }
> +
> +    return mstatus;
> +}
>
>  target_ulong helper_mret(CPURISCVState *env)
>  {
> @@ -345,6 +372,9 @@ target_ulong helper_mret(CPURISCVState *env)
>      mstatus =3D set_field(mstatus, MSTATUS_MPP,
>                          riscv_has_ext(env, RVU) ? PRV_U : PRV_M);
>      mstatus =3D set_field(mstatus, MSTATUS_MPV, 0);
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        mstatus =3D ssdbltrp_mxret(env, mstatus, prev_priv, prev_virt);
> +    }
>      if ((env->priv_ver >=3D PRIV_VERSION_1_12_0) && (prev_priv !=3D PRV_=
M)) {
>          mstatus =3D set_field(mstatus, MSTATUS_MPRV, 0);
>      }
> @@ -378,6 +408,9 @@ target_ulong helper_mnret(CPURISCVState *env)
>      if (prev_priv < PRV_M) {
>          env->mstatus =3D set_field(env->mstatus, MSTATUS_MPRV, false);
>      }
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        env->mstatus =3D ssdbltrp_mxret(env, env->mstatus, prev_priv, pr=
ev_virt);
> +    }
>
>      if (riscv_has_ext(env, RVH) && prev_virt) {
>          riscv_cpu_swap_hypervisor_regs(env);
> --
> 2.45.2
>
>

