Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAAAE7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 03:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIgJI-0005Fg-Jb; Tue, 03 Dec 2024 22:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIgJG-0005FF-LN; Tue, 03 Dec 2024 22:44:18 -0500
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIgJF-0002nY-2U; Tue, 03 Dec 2024 22:44:18 -0500
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-85b8c94a6b4so1352132241.0; 
 Tue, 03 Dec 2024 19:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733283855; x=1733888655; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8acdpEXnBtnDnuDsdxg1bR5r1dwuvW28CSjip2UK3U=;
 b=W/YKT1HuZu1L1jKL7f0UW3Bqy7G72z4/ik3kcbE3MfCfN+tSPWqGzHnkldrU3yNjKT
 m6UCPRHrRoEDTK/ql1YXHnFFn4NeZepr6SZxrii3PGf2JAGuDU4tqZHfhjiwfgAsH5ZT
 iH536pUxJPc/9Cl4YEtZD2H09Qz1WKCxeVJwmMPvavrMFUvP1yEh2XDfnE3/T+m+p3+R
 wSeVq2o96vJig+YAfYPoDBMbppVbLB+NN5shjmcsDzgFWfzEFc+7oZxzgProAamavMz1
 UmP/ylLMHHEaa66AHM6NnQsFiHR3j86S2oJfLv0xJzEfqw1JybAFtdZtt1bYS9HsS5aK
 iHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733283855; x=1733888655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P8acdpEXnBtnDnuDsdxg1bR5r1dwuvW28CSjip2UK3U=;
 b=PAnWXh9CSr3swT05wnSTUHpos9GgHrgVuLjLrmEutIGNtDjFfhgz3O15labYOVq+Ta
 2MWcJAzLLwHIKdyNQ8LxMl+518sbWDuSg98l0lrWsyhQTifEpEyfi/41H8Re6W0P12mw
 5ukdiLnWwZT737RhbfENliBHn5uBch7Qufrd7xPmcaLFOFIiTRIKSmUYFDVUlliSvfLX
 kkSqgksq5/DV0lJSRhBuIbUpZOZQvWvslGTkUDywQgGT7qSY1LyGgj+HPGldc+HM1Flp
 R3ZR0rtufISGNuvxCeYlgMb7KS639h13ZryYfLa1hMeQeldaeH6A84rh24hLSkakceDs
 Z3ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7YC6bSW0ZASIJvhn3H7Q5eQlOjXhIhg5iwXakZWblsA2raeLLNzlmzn9li7molqjTO6f97sxGQSYi@nongnu.org
X-Gm-Message-State: AOJu0YyE3WIJVn0P6EueyUGMj7QBZ/9PDlU12LxPS7hhGD/I1/8T0/g5
 ZvyKsw/hHd6IaG/uC+HRIZtosLoEuSaKQphM9wDQdb0mYHizHGL4x5zTYop37qKQJbwDRDkUUpH
 kTBiFHc2Y/j52MnG62ZskT1LGxOE=
X-Gm-Gg: ASbGncvdPFsql1D9ItMMEMXUmPiCCVzX6okGVfbp8b6zMDVOKkHi/uB4VUyBjlI/mLK
 3BznaYIo6uRUQOnf9kR5lO2wirIunVp5R
X-Google-Smtp-Source: AGHT+IG0obxRRets533hug2y0RnEX5StQQ81HJZ6YjD26Cmh7zH9fme3oVmPdQc+nSx1U2n7j4CNpu42NFhuNhoozl0=
X-Received: by 2002:a05:6102:3f53:b0:4ad:de0b:fe11 with SMTP id
 ada2fe7eead31-4af97375fe1mr7338914137.17.1733283855441; Tue, 03 Dec 2024
 19:44:15 -0800 (PST)
MIME-Version: 1.0
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
 <20241113171755.978109-3-dbarboza@ventanamicro.com>
In-Reply-To: <20241113171755.978109-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Dec 2024 12:43:49 +0900
Message-ID: <CAKmqyKP8HxUivNJ4pxW99fjNQhUwoJxKa1Vu18znf415HR3=qA@mail.gmail.com>
Subject: Re: [PATCH for-10.0 2/9] target/riscv: add ssstateen
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Thu, Nov 14, 2024 at 2:20=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> ssstateen is defined in RVA22 as:
>
> "Supervisor-mode view of the state-enable extension. The supervisor-mode
> (sstateen0-3) and hypervisor-mode (hstateen0-3) state-enable registers
> must be provided."
>
> Add ssstateen as a named feature that is available if we also have
> smstateen.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 2 ++
>  target/riscv/cpu_cfg.h     | 1 +
>  target/riscv/tcg/tcg-cpu.c | 9 ++++++++-
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f219f0c3b5..4ad91722a0 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -191,6 +191,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
>      ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
> +    ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -1607,6 +1608,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental=
_exts[] =3D {
>   */
>  const RISCVCPUMultiExtConfig riscv_cpu_named_features[] =3D {
>      MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
> +    MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
>
>      DEFINE_PROP_END_OF_LIST(),
>  };
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 59d6fc445d..c7bf455614 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -139,6 +139,7 @@ struct RISCVCPUConfig {
>      /* Named features  */
>      bool ext_svade;
>      bool ext_zic64b;
> +    bool ext_ssstateen;
>
>      /*
>       * Always 'true' booleans for named features
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index cd83968166..0b9be2b0d3 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -204,10 +204,15 @@ static void riscv_cpu_enable_named_feat(RISCVCPU *c=
pu, uint32_t feat_offset)
>        * All other named features are already enabled
>        * in riscv_tcg_cpu_instance_init().
>        */
> -    if (feat_offset =3D=3D CPU_CFG_OFFSET(ext_zic64b)) {
> +    switch (feat_offset) {
> +    case CPU_CFG_OFFSET(ext_zic64b):
>          cpu->cfg.cbom_blocksize =3D 64;
>          cpu->cfg.cbop_blocksize =3D 64;
>          cpu->cfg.cboz_blocksize =3D 64;
> +        break;
> +    case CPU_CFG_OFFSET(ext_ssstateen):
> +        cpu->cfg.ext_smstateen =3D true;
> +        break;
>      }
>  }
>
> @@ -343,6 +348,8 @@ static void riscv_cpu_update_named_features(RISCVCPU =
*cpu)
>      cpu->cfg.ext_zic64b =3D cpu->cfg.cbom_blocksize =3D=3D 64 &&
>                            cpu->cfg.cbop_blocksize =3D=3D 64 &&
>                            cpu->cfg.cboz_blocksize =3D=3D 64;
> +
> +    cpu->cfg.ext_ssstateen =3D cpu->cfg.ext_smstateen;
>  }
>
>  static void riscv_cpu_validate_g(RISCVCPU *cpu)
> --
> 2.47.0
>
>

