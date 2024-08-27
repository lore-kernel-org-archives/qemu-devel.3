Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9538C54744
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 00:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj66z-0003nX-BD; Tue, 27 Aug 2024 20:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sj66w-0003lT-DQ; Tue, 27 Aug 2024 20:00:30 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sj66u-0005YH-HM; Tue, 27 Aug 2024 20:00:30 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-842fe718899so1524126241.3; 
 Tue, 27 Aug 2024 17:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724803216; x=1725408016; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dNbQ05SIcd4fs9Vv2Jcl+WBnWBa6A/TRG3WT7XBuPHU=;
 b=J83iQpHbN4sYY445mNrTiMl+E+Eh34yLy8fyAx3qnQ9sC7aDUVUWrObdxOLme2NFqO
 Y8r3qqasQPX11X6qVC9cUaMh0F17AezJaWjGRYXCBDSULDzZLaI9wRM3Z0uJ6WXXi/QA
 +7Kcn2hWOJ2fJiT3RhNGUbjEryDsQjVLrEUk+rOT61x5UmqPHyVjEK8sW5fd0+XXbgIM
 xpiOPjNNHkuNgrIsU/9ejOyktziGyrqH/d3/1QSjnmBJvRa1N8XpUiJSPsfCwqmJc57a
 LI8ZusIGTHNiDYFaNc6CvWCawLBPqMHild5dRKDAt9LUBkdEJEFdKgYRi2zRxf2Z5zbL
 gw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724803216; x=1725408016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dNbQ05SIcd4fs9Vv2Jcl+WBnWBa6A/TRG3WT7XBuPHU=;
 b=DRlehh41A4lCWZGwkgkugaa6uXtH7iQ4ScDXOSGzsKymYxiHA+krzex7TeEMbQuECk
 va+YUkn+SmHJwBOs3FLX2YeQBBfy7CQYLmYMZZhUfX1uAVpDpddJH8ud5V6N4tCkEE+k
 S7aJ3ESV8w+zRpyqczM9eQFWMKCIZ4MzzwQviHdShz3J6jN/okAEtryAsUqP9cliUGhj
 zui36EkxsjBAuOSQ3c2NXTDzph12hw79BaeiItUWnXVgVVGj6qurXk/obmyLvkJSSWwX
 tQ3XfaS21LPohE+RUXpHsRiA+aabxE9INmLcaws4/HFtTCxRKFhPtMVFqH+TGOfr09GR
 h83g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEgIJdwfADjZ0y0WstEjbj6n4ycJq6cUT2fuZtIXOWWfsVjaDy2qFH/CbE/+4JdfFE9W2W3Xrn9m6J@nongnu.org
X-Gm-Message-State: AOJu0YzHzf0zO/GWkUEyCk49yiHDYq1DGsspCRSSZyRlStSgnj0dSpIk
 obzFqZmJ3ZrqoiJxCLijyOq+8f9zqvscgF6PWwx1bE6RVIyb/DKaB6WqBdoVRuDW4rl6bP/f7yx
 3dKHebSSoXU1GE4fbSf+fGKE62aA=
X-Google-Smtp-Source: AGHT+IHX/f+SwvM1P5sFxCHJRE/7lxBC7o8BUXCufbb2TkMxbVR6330L8qrO+X3h7FOkx6vVtgT3mMjgQLTWYdP4spM=
X-Received: by 2002:a05:6122:4588:b0:4f5:202b:6220 with SMTP id
 71dfb90a1353d-4fef09ef469mr232235e0c.0.1724803212258; Tue, 27 Aug 2024
 17:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240827231906.553327-1-debug@rivosinc.com>
 <20240827231906.553327-4-debug@rivosinc.com>
In-Reply-To: <20240827231906.553327-4-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 28 Aug 2024 09:59:46 +1000
Message-ID: <CAKmqyKPZqRMjCCk7tp2PVJG5jR2XXa8EqegGiHY0A2-cddQGhg@mail.gmail.com>
Subject: Re: [PATCH v10 03/21] target/riscv: Add zicfilp extension
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Wed, Aug 28, 2024 at 9:20=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> zicfilp [1] riscv cpu extension enables forward control flow integrity.
> If enabled, all indirect calls must land on a landing pad instruction.
>
> This patch sets up space for zicfilp extension in cpuconfig. zicfilp
> is dependend on zicsr.
>
> [1] - https://github.com/riscv/riscv-cfi
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 1 +
>  target/riscv/cpu_cfg.h     | 1 +
>  target/riscv/tcg/tcg-cpu.c | 5 +++++
>  3 files changed, 7 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 33ef4eb795..43156ebb92 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -106,6 +106,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
> +    ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
>      ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
>      ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
>      ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 120905a254..88d5defbb5 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -67,6 +67,7 @@ struct RISCVCPUConfig {
>      bool ext_zicbom;
>      bool ext_zicbop;
>      bool ext_zicboz;
> +    bool ext_zicfilp;
>      bool ext_zicond;
>      bool ext_zihintntl;
>      bool ext_zihintpause;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index b8814ab753..ed19586c9d 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -623,6 +623,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          cpu->pmu_avail_ctrs =3D 0;
>      }
>
> +    if (cpu->cfg.ext_zicfilp && !cpu->cfg.ext_zicsr) {
> +        error_setg(errp, "zicfilp extension requires zicsr extension");
> +        return;
> +    }
> +
>      /*
>       * Disable isa extensions based on priv spec after we
>       * validated and set everything we need.
> --
> 2.44.0
>
>

