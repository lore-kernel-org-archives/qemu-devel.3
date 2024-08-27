Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6260C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 04:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sinhh-0007jY-W9; Tue, 27 Aug 2024 00:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sinhg-0007id-TQ; Tue, 27 Aug 2024 00:21:12 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sinhf-0008Ke-3I; Tue, 27 Aug 2024 00:21:12 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-498c4f251ffso1772951137.3; 
 Mon, 26 Aug 2024 21:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724732469; x=1725337269; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPPuJpDXLfcQEM7lsGmj1v2mnLuLUysh/SyzCLqmY+s=;
 b=ANSZXONmRIlYwwQ16SgDjmKcZskn1CeDrV2+h1SI6albWN1wnRSpXIC9PlpfpXUY/F
 He0W41SBlgytaARSb47BVlqB29t6ZE4stMdwUMJrcz4v9uTQN8o249QvctnuYdStZrbX
 3pA3zREUgo7TIjnu0aQgUOaGzB3lSg8G8pFljYsd1UDo9hKfqeE1krSMkHwU3KtIGOkG
 Olv8tsG8vIMKPaqd0VW9b+bceAc24gvmKVGwrfCtXVPqxeiP3NCtKeV+4YcuDPyFQWEV
 FuELmufzTpSZBLtOoLAymWGTQuUbfhzx1XyoBZC5SRKzGRkqd7+JqrjomU3mcnGGKvMZ
 aa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724732469; x=1725337269;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KPPuJpDXLfcQEM7lsGmj1v2mnLuLUysh/SyzCLqmY+s=;
 b=QfgPloKD/y/iiVBavwnKbysorKMBn7f+z/vthJ4bVP7+hrm6kWqArBCQdzK7DlYkO6
 W4Q9dzq1Pceq+NOdSAVHnIUBjiGhDV2cvA5/Sal1W9+2SZ+6Yk1KbpW3PV8RHTfVpMPR
 OrsmaRJTc4eEdg7uve07d+YizSnOqm3HpaH6zw5txtqemQSb5aJ1ycw3c6CnKOEeMXPU
 hvBp74VWarpfYS6tbwJLLM3tWPxy1m5B9OZT6oblxk2srWXLUa53RmC7qK9z02i4QYZ1
 boord5sOzxuAmlvOAvZ5p0cmvvbHG19Yq+uSVPxel5+Ui99skDM3Z4aC6pgXhsfHGblr
 PhTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrKVjTqzI7FHPSLTs925+0G/2pT9GRoxz6UnXRT00/iVlG2FUGkuzvfA4xTbdLm+E5OZ59+UK0a0UX@nongnu.org
X-Gm-Message-State: AOJu0Yz5n6nFzxA84CQgZcMEpFNnU/pkj47jxdOvqjK2iQJKPfr0PPgD
 +M3kT7J611K/KCAw3JoJLenrCVRIoTo3IfHscOAQAlL0kz+iSvIPb+CjPzwYntcj5x6hUS+w/Ug
 SzmePip6Gq5bvqoV9FNB8cfCdP4k=
X-Google-Smtp-Source: AGHT+IFwcypi0I9aXKDVFojuMyfopAc8451iCza6CPXefp9a5AMEGNupLos1SzKnxxGFcLOQRBWV5GefxGu0FBMt1Vw=
X-Received: by 2002:a05:6102:c47:b0:492:a74d:1664 with SMTP id
 ada2fe7eead31-49a3bbb7d36mr2228106137.8.1724732468893; Mon, 26 Aug 2024
 21:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-9-debug@rivosinc.com>
In-Reply-To: <20240826152949.294506-9-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Aug 2024 14:20:42 +1000
Message-ID: <CAKmqyKPEdsbKzAJXjH2PAa2pZR2NdwqQG3hBbUv7Mvww-Je+xg@mail.gmail.com>
Subject: Re: [PATCH v9 08/17] target/riscv: Add zicfiss extension
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, 
 andy.chiu@sifive.com, richard.henderson@linaro.org, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 27, 2024 at 1:32=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> zicfiss [1] riscv cpu extension enables backward control flow integrity.
>
> This patch sets up space for zicfiss extension in cpuconfig. And imple-
> ments dependency on A, zicsr, zimop and zcmop extensions.
>
> [1] - https://github.com/riscv/riscv-cfi
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>  target/riscv/cpu.c         |  2 ++
>  target/riscv/cpu_cfg.h     |  1 +
>  target/riscv/tcg/tcg-cpu.c | 19 +++++++++++++++++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 083d405516..10a2a32345 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -107,6 +107,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
> +    ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
>      ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
>      ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
>      ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
> @@ -1482,6 +1483,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
>      MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
>      MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
> +    MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),

Same comment here about exposing at the end.

Alistair

>      MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>      MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>      MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 88d5defbb5..2499f38407 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -68,6 +68,7 @@ struct RISCVCPUConfig {
>      bool ext_zicbop;
>      bool ext_zicboz;
>      bool ext_zicfilp;
> +    bool ext_zicfiss;
>      bool ext_zicond;
>      bool ext_zihintntl;
>      bool ext_zihintpause;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index ed19586c9d..4da26cb926 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -618,6 +618,25 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          cpu->cfg.ext_zihpm =3D false;
>      }
>
> +    if (cpu->cfg.ext_zicfiss) {
> +        if (!cpu->cfg.ext_zicsr) {
> +            error_setg(errp, "zicfiss extension requires zicsr extension=
");
> +            return;
> +        }
> +        if (!riscv_has_ext(env, RVA)) {
> +            error_setg(errp, "zicfiss extension requires A extension");
> +            return;
> +        }
> +        if (!cpu->cfg.ext_zimop) {
> +            error_setg(errp, "zicfiss extension requires zimop extension=
");
> +            return;
> +        }
> +        if (cpu->cfg.ext_zca && !cpu->cfg.ext_zcmop) {
> +            error_setg(errp, "zicfiss with zca requires zcmop extension"=
);
> +            return;
> +        }
> +    }
> +
>      if (!cpu->cfg.ext_zihpm) {
>          cpu->cfg.pmu_mask =3D 0;
>          cpu->pmu_avail_ctrs =3D 0;
> --
> 2.44.0
>
>

