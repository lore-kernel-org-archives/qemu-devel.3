Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23649E7719A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 00:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW33r-0002jd-NY; Thu, 09 Jan 2025 19:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tW33e-0002cI-GC; Thu, 09 Jan 2025 19:39:27 -0500
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tW33b-00036h-P8; Thu, 09 Jan 2025 19:39:25 -0500
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4b60c221587so585802137.3; 
 Thu, 09 Jan 2025 16:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736469562; x=1737074362; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ns4dMduQNYpyEpkVFIWaa72banYqpLcfPengagu6snQ=;
 b=K+kFQuUqeGyiwsVN1O5Ni8wgWxPfgPhjGw6E1AY1KigZM0Y0L42RRWk19dHtkTIwlS
 uYeeQGqX3et8rsKgHzL+MJcht+9Dkx41FuRpVNojO1n0f8KufkmahA+TvcItt6HthbRB
 SsquKmVl6023bgYwyzMhq/0P0vAi3E+cGl3ef/AcSoegUmEfqkSVcMChZfsxTcB59UmS
 GpDXHjnGrzqBatak2gamAMYWUXFG16NLImrAIp6fcT5cWmq0RZZU7h340arfAtsKhqHS
 YSfsCJ1qDhUEXzG0/ZJeCMsMIRZhwkvvZSg8TrPcVROyrwKelxqU8m0GLeeo3kIGsMcI
 cw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736469562; x=1737074362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ns4dMduQNYpyEpkVFIWaa72banYqpLcfPengagu6snQ=;
 b=bDR/aEzGs3wkHQaH6KXWcS8h5NxNvf54P0uni9StLmUhlATbmX2B5cpAaJ8qauG2Bz
 lkor2SWt2W7IIO/9hWU6gdrtBTs7vI8HGaQ0T4+VvLs9cxzwhePgoUN+d0wjJ7Z+q4AO
 XS3Wtci9VW69+mH3tbxhutuopg8F2BkKATeOs5s8/Yhu2OBkZFamyDwHEd8WC2bqpuk1
 ARshDRe15h6M3IrjCrF3tOy3oauD/KN9lozJnYHINe0tjvAq3dhxQyKZe+ayqCJcJDmU
 zQZTrl2ipv8Ul+EkZ7r6Ss4CQvBzY6n3AEZpqqc8DGDnXhOrQi2lktd9mhcQdvickcAn
 eDwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2J56WOJww5dn0vw/Mr8kEPdAEiloszqYdhxVEIZfucyvwVgOuQ5I8ts3vtPg1wYuQrt9ecf3A3I1V@nongnu.org
X-Gm-Message-State: AOJu0Yw+kVP6T+U8/n04bE+4/i2bM5UV1SghmlOprumK+Cw2BhlVrb+L
 y52cBsThgrHFYBNEc5y006dE3I8t95GomMT/DCAEY2eRpIOB0JoB4PzbF9J2uuqsI6LMsXh8E+T
 +eXlF+dyij7QRQAhN7IVhJoj6rGZveQ==
X-Gm-Gg: ASbGncumReyKWsS2EUvLkLmPM+F3raG0U6ts3jSXBl2lOjEFyLoUulOp2JMhUf0TwTI
 BYFdjnNDQ8SoILJGYw+YP7h5MLgHBg04GLylWuU97uBtprpzTbv7yAuk5h9Ypmxywh4U=
X-Google-Smtp-Source: AGHT+IGVnTUNidZpt98wWxsaRA1fHTOIJmYneT7HTf4XijzkidnttnOfCcD+cVS3VxJ9ONFdrI78DiH71wUT6M7bfP0=
X-Received: by 2002:a05:6102:5491:b0:4b1:16f8:efcb with SMTP id
 ada2fe7eead31-4b3d0ec7051mr9307960137.17.1736469562132; Thu, 09 Jan 2025
 16:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
 <20241203-counter_delegation-v4-1-c12a89baed86@rivosinc.com>
In-Reply-To: <20241203-counter_delegation-v4-1-c12a89baed86@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Jan 2025 10:38:56 +1000
X-Gm-Features: AbW1kvbi_Jq3A1Sb_dqvPsh2eRbraf7GGrafzIbnLL1m-1FxX2UDT6qJ3j_rz40
Message-ID: <CAKmqyKOFx2bj7Gq=mdiG0DisOChG0KLuGVcSM+JmSKnWw5QrFA@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] target/riscv: Add properties for Indirect CSR
 Access extension
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, kaiwenxue1@gmail.com, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
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

On Wed, Dec 4, 2024 at 9:17=E2=80=AFAM Atish Patra <atishp@rivosinc.com> wr=
ote:
>
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>
> This adds the properties for sxcsrind. Definitions of new registers and
> implementations will come with future patches.
>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c     | 2 ++
>  target/riscv/cpu_cfg.h | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f219f0c3b527..963f1f3af9ae 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -185,12 +185,14 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
> +    ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>      ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
>      ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
> +    ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 59d6fc445d18..8b974255f6fb 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -79,6 +79,8 @@ struct RISCVCPUConfig {
>      bool ext_smstateen;
>      bool ext_sstc;
>      bool ext_smcntrpmf;
> +    bool ext_smcsrind;
> +    bool ext_sscsrind;
>      bool ext_svadu;
>      bool ext_svinval;
>      bool ext_svnapot;
>
> --
> 2.34.1
>
>

