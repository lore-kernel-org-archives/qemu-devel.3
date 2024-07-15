Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E99EC3DA49
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 00:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sT9oN-00011w-0x; Sun, 14 Jul 2024 20:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sT9oE-0000yt-4M; Sun, 14 Jul 2024 20:43:18 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sT9oC-0002K4-K5; Sun, 14 Jul 2024 20:43:17 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-8102c9a5badso1409491241.0; 
 Sun, 14 Jul 2024 17:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721004194; x=1721608994; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwqLkJ7dr6J48QvHCXqXRzVapbBZ5MoTFOshyMmKmtk=;
 b=dTEknSZhdxKHSYFDO9OtoniDZvxQeaUv8zO+i9ubRTy30++1uDRGqB/HVoNcVhjyiK
 3tkVdinNaMiRtt+f/0ZfIu2PFIlK2/V+FLNCVMY12iPdyXXnFAPyFPTSz35uH2FpTS46
 cQEiHDvYhTrzMPn6mfJeVEaocod8gj0lnrYqrK8lbthZ5Fk8opqt3uU4KLrTQe4O04MT
 y/Gha8S6eNqrP0xffF+5dOxyaXKQPHuj7T2QjHavd0p3HVKmEfUZf0ae6VF9ktJKojLi
 d0dolFp3KlAKxtThprSorqbYBtEx/bCpefr1EzguGGUfQEKX3Ui1R1m34ydIeSl4xGZR
 Y4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721004194; x=1721608994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TwqLkJ7dr6J48QvHCXqXRzVapbBZ5MoTFOshyMmKmtk=;
 b=Oixzfx++HBBozkmguQDMYejTssEm002u7cTu562t0c1PCEGcN3pnS9yk1ssomjLGzs
 ziC6N8jfGdl7is6imjeCSSi0oamUubyyyGsFZmFWPPaXgcdle6PdHJxxiOS/HXR+pbbH
 fVdTLqVXUcTypUQwvq4z4wl38ltKaOsKToi71KBR1d/U4W6G1jPtxMH7CN3rQZW4Q/Sq
 WNdZVvi0qZX5hX7BLKouZTAoY1HSbzq3MMDmQR+m5f/a5qbStz8v10LPKMWZMb2ePXdo
 J0ZMV79xc46Gp2VUjknhYkA1rW1jyQwdeHzRE91+G9jaJpugjtVQXH0LWML90Gx7IEQ4
 ugPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDAxAT9kRY4h5spO7JzY61i4nz/+weax+X1p/ig0nawOCrvkUriZ64Yv7yxYzYBBcDtuTRJrQzJT5BTcfTA7azwnUSQlo=
X-Gm-Message-State: AOJu0YyLLKWSegGVNxWnR4jbl7z9yEyDfI3WTMlG42G3+LWAsqY3647M
 nJGAwOlz0e6C5x6c5qRW7fZl32HsuX3zUdxE5oud3yGkIxL4ztxacJczRLeYzfyi6Zf1DY7fA1v
 /9XFwbPSGcrqtDswmIp0cz29eeI0=
X-Google-Smtp-Source: AGHT+IFLMLKD/WzgjVP8LVtLdb6bVenbjq7oiaGPLCO23Frjw+/m6Zdh7olJ8qgG5iYX+cK1UZBJpSE2JrAJwCEwilo=
X-Received: by 2002:a05:6102:4405:b0:48f:79de:909e with SMTP id
 ada2fe7eead31-490321a413amr24394383137.18.1721004194326; Sun, 14 Jul 2024
 17:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
 <20240711-smcntrpmf_v7-v8-3-b7c38ae7b263@rivosinc.com>
In-Reply-To: <20240711-smcntrpmf_v7-v8-3-b7c38ae7b263@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jul 2024 10:42:48 +1000
Message-ID: <CAKmqyKNK1Nxk6OmEPaj2BZMgXim6T_yqGHS3v17umg7Z5Re1AQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/13] target/riscv: Add cycle & instret privilege mode
 filtering properties
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Fri, Jul 12, 2024 at 8:33=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>
> This adds the properties for ISA extension smcntrpmf. Patches
> implementing it will follow.
>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c     | 1 +
>  target/riscv/cpu_cfg.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4760cb2cc17f..63f553c92b00 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -178,6 +178,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> +    ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index fb7eebde523b..b1376beb1dab 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -74,6 +74,7 @@ struct RISCVCPUConfig {
>      bool ext_ztso;
>      bool ext_smstateen;
>      bool ext_sstc;
> +    bool ext_smcntrpmf;
>      bool ext_svadu;
>      bool ext_svinval;
>      bool ext_svnapot;
>
> --
> 2.34.1
>
>

