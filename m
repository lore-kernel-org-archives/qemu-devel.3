Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC23C54743
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 00:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj67s-0005YR-0d; Tue, 27 Aug 2024 20:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sj67q-0005Tt-UX; Tue, 27 Aug 2024 20:01:26 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sj67h-0005ey-5c; Tue, 27 Aug 2024 20:01:26 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-70968db52d0so7092027a34.3; 
 Tue, 27 Aug 2024 17:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724803275; x=1725408075; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ElK+JyFqTsSKObghAQ+frGtEpMy2wZg7RgmDMCfH5DE=;
 b=fUqX+zlSfSCNtD5nRwB8cpqAy/l41yfkGBFIaswBl0hQAqOLoVDrUnhf2o7w3QFTf1
 cQMcU+VTDLOCbIaTQERvUBOtT2/e4F/k5bMVEah+rGTC5JKLORIICQSxzR8pND/DC9Gr
 AH+vuVthwcSCXPhykwlU4maz7mCpNlwLKZbRC2mZI+qXBgfQ5l+OFS3hq+ChAlJco2WW
 aAtp/3tspw1MFQZEBLjmiJsFfDJpgiMfbdumGIIWxF57T2MuOIKdy8a9dX+W1SQmzbqv
 xWuzgYELW+knTYXCsRgYddHkbMiWSWwHNLFkvtYERYmBQXTTX6Mp3KqrHL5lgtpVNt9e
 KtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724803275; x=1725408075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ElK+JyFqTsSKObghAQ+frGtEpMy2wZg7RgmDMCfH5DE=;
 b=QZGEkhh2wajKN0D38JQYewqTN/QmCEdTBhHpTmd4jW8RAI1gbfKz5+ocHoe6Tu5XFI
 ziMnGDkbb9/PO7w0mVosxt7d5kz+iOqMfHButqyckoyIvW2NPQ3bwkjMlmFJY68zTI7N
 +nmK8CpX4AUay0KLZ+l9C0tCjxFQloGWgyNGynHRaR3s0w8PGtO1vz2bawIReP9OFohX
 mQ2Wk3jRT1amJr4Xkj0ygRxVW3L816N7g01eDmpqNQG2w/Rys0qYC4CSSMcH06gmYpPB
 fwf1KHoWZJy8rqclVzMtkQa2I9HHwpyieQhtEHn14G8dU4xLF+ghe8svO8GuT++DFXC6
 BItg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2kCv5oM6F1AQlXOBUqh+KUxoZZCK7hmBb1nDul8EjeCvuWri/Jptio6p65I4REqsaJJCv4z2H12WG@nongnu.org
X-Gm-Message-State: AOJu0YwxgdA9RMk48nSxw6/vw6oUPizs8DnMm61EyQNSU2oStaezIoDb
 uoM520zv8u12cfdPMRejPEiVObXEXgwFBfF259Oxw8ZBEnWct00a9Cp+6NI2OMBO+7UHf1ID+dO
 2bpOsL24FWK75grBzkGZXnZkx6s4=
X-Google-Smtp-Source: AGHT+IGOwQPE1dWoTgnBvHpRDZAWjQYrY0lmjlZ1nueyNTAAOZ3+GNQRu62nd7qFbDxmDmoqPnAyLFkruBjoo9jGe+U=
X-Received: by 2002:a05:6358:109:b0:1b5:a0d5:cc10 with SMTP id
 e5c5f4694b2df-1b5c212c9famr1863444555d.7.1724803275316; Tue, 27 Aug 2024
 17:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240827231906.553327-1-debug@rivosinc.com>
 <20240827231906.553327-12-debug@rivosinc.com>
In-Reply-To: <20240827231906.553327-12-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 28 Aug 2024 10:00:49 +1000
Message-ID: <CAKmqyKMewo3C_QYR1hLJ49KOWTVZPJ8pzDtmcigV6Qv1fNQTyw@mail.gmail.com>
Subject: Re: [PATCH v10 11/21] target/riscv: Add zicfiss extension
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32a.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         |  1 +
>  target/riscv/cpu_cfg.h     |  1 +
>  target/riscv/tcg/tcg-cpu.c | 19 +++++++++++++++++++
>  3 files changed, 21 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8e1f05e5b1..0dab110a3f 100644
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

