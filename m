Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D340E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 01:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW3h6-0007qI-25; Thu, 09 Jan 2025 20:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tW3gz-0007mA-68; Thu, 09 Jan 2025 20:20:08 -0500
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tW3gx-0008E7-IQ; Thu, 09 Jan 2025 20:20:04 -0500
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-51640f7bbd3so565671e0c.2; 
 Thu, 09 Jan 2025 17:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736472002; x=1737076802; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8ojhKXZBIIkcb4rU1o0VI+GeJeUjZYfQehmckTEK5E=;
 b=JzzfCmEqjxkw/DVhLbfJb0c2NkBcSiMCtIOoca7XdSCFnOKp+wkXEhoWNB+dTSkzWc
 wkRUqr3cjg81dYxWqeJ9mJjKtPAfCAxNkM4wLYCDa0fhypkCr1V8URdgfaZ3uUNBfTwt
 5RmRx9L2y2u2gVIeWQv2RA0GQ09jX9jdSAsC67w57DO1PJyy9lb7PQalp10G7juCJHf3
 cu7FcrgMfFA0bhXmCDQgXt3IM2fPpO08IpZzpL2ZrDb+WBkXb6U6V5Vtar1HBnk2311A
 nP2Zm+RA0h/Jix8oFr+FYHRysycX5QeWTUgFakEqKYCEwDnpQaO/7vPjJ9YZ1QVfy/OC
 TTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736472002; x=1737076802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8ojhKXZBIIkcb4rU1o0VI+GeJeUjZYfQehmckTEK5E=;
 b=C2edZ1H2EmHh1QYx1mKyq9SppPlLSGwLYw3cXK32jEUcM9PZYSCcVJ72L2WC2954wZ
 7+5HJ8Qtt+rVFfwJoixXcm3pX3gU5YEiMFGhl2KmGNGp/Ly2zDftTmxvGgDatfv03C/K
 EP74kKc/A3RbjCy9tVVZvbdCE2UvMTLWHGwThl5UsFKIkj1Bpr1BEw0oNr2ZeA3vhfx4
 Tv7NibDlW4TPmF73YJI84aNim0z4OxPIrSIgp1fA7ylyaHjRra7lzzV5z2UP5L0gkmJJ
 +Qw0Np3VAbBJ46ca9vCz36pK0ab6sWoTkR5x5f1q/+f47/PnkgPc+P+d0j0CIlgmVLId
 SQ4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8wusLOyMoLaWhmfTSNZ3gG7l7NyorqsePX+vNQ4zBoEIp6OKfLcfuw/V3A+7vDGVbXFAZU6/pB3ub@nongnu.org
X-Gm-Message-State: AOJu0YxmY5XNEABPgdTU9ftcDrajBBWDymG/vTYMjXcIhQtt7P72Md5l
 xQ1eY2dknWx4LzAopWSV1ChzXpkFwh49EfAZkm2kCQK465V/ZC5y++815VUSfJwpGIRfoxSiJr+
 m/zR+1AYPAkx2Poa0QKS91LRIHudRMw==
X-Gm-Gg: ASbGncs5MX5dEg4fgtiB/NosjW8MIzsftXH0OKe/g7tVd0muJdr9cn+og1N+xLkXwrE
 5+AG3nh+XKuay8N01+q5hRWThoys5L1gOxy9qtUso3uozXMSQicyJH8NWihFQ39AymP4=
X-Google-Smtp-Source: AGHT+IFbWAC1mMAuAHGs32DOzUyOIBuF/dxVaoE8/snhVouvdil7ai4/Mm/YvONIkRQ2Ogz3nKBtRNiRTcHUO3aH+1g=
X-Received: by 2002:a05:6102:50a5:b0:4b1:ed1:56ac with SMTP id
 ada2fe7eead31-4b3d0dd7df6mr9150595137.12.1736472002101; Thu, 09 Jan 2025
 17:20:02 -0800 (PST)
MIME-Version: 1.0
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
 <20241203-counter_delegation-v4-5-c12a89baed86@rivosinc.com>
In-Reply-To: <20241203-counter_delegation-v4-5-c12a89baed86@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Jan 2025 11:19:36 +1000
X-Gm-Features: AbW1kvaZVGQTRRe-unkBYFsM8sd3AhgvSp14pAr9Jdmw4vrWOT8BNfZ1Bq02iZ4
Message-ID: <CAKmqyKMR0TKN26LAmR1aN56KVxZ+_8bm04nMytoHQb5eH5vnpw@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] target/riscv: Add properties for counter
 delegation ISA extensions
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, kaiwenxue1@gmail.com, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Wed, Dec 4, 2024 at 9:16=E2=80=AFAM Atish Patra <atishp@rivosinc.com> wr=
ote:
>
> This adds the properties for counter delegation ISA extensions
> (Smcdeleg/Ssccfg). Definitions of new registers and and implementation
> will come in the next set of patches.
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c     | 2 ++
>  target/riscv/cpu_cfg.h | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 963f1f3af9ae..82edd28e2e1d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -184,11 +184,13 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> +    ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
>      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>      ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> +    ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
>      ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
>      ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 8b974255f6fb..ae2b019703fe 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -78,6 +78,8 @@ struct RISCVCPUConfig {
>      bool ext_ztso;
>      bool ext_smstateen;
>      bool ext_sstc;
> +    bool ext_smcdeleg;
> +    bool ext_ssccfg;
>      bool ext_smcntrpmf;
>      bool ext_smcsrind;
>      bool ext_sscsrind;
>
> --
> 2.34.1
>
>

