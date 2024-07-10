Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DF1C38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 07:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRRN6-00078R-Du; Wed, 10 Jul 2024 03:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sRRN4-00076w-W4
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 03:04:11 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sRRN3-0006xG-E5
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 03:04:10 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52ea79e689eso6948868e87.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 00:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720595046; x=1721199846;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzDbRblYb4j4HpZf7wgsha8ZuZj+nldecx8F/cKfveM=;
 b=llW1eQl10GkoPrzrjzt8ibiJoIZTWztFz3hvkATEXKT7woPTFMR6XT0FIWPVFWo0BT
 yBv9PTNhANqSS3qVISP+lg56uvAhYHMI4zoXWryousNECb4fsOQJiu2l6WXaJUOZ9NZt
 F3m3FsCP9bmVvwSQvbrk575/tazZHnJjeTSB/aDBYRUtl8y+kW1H2zPwdggTP0TT+uP9
 seHaL/bdC9KQJgdjtmRy/NMrsqI5G3kcTUBqDjwC0oSAk+0txbttd6ob0iv87CG/pNrg
 MdPMaNf+uAegvmXaWVATwZofAR750Z5CD4bg25YnzmgoJsB7jEcu6BkoyzH1WM44MCJD
 U3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720595046; x=1721199846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzDbRblYb4j4HpZf7wgsha8ZuZj+nldecx8F/cKfveM=;
 b=uh8mOHoYBatpnMJVNlVjLXNbBJBy0bWqazsWsJbsbHhjdyAKMcxX4rn6OgFdC3UoxT
 4iinuQplWUSUgTOHw4tn6zMGHGIhuF6zvdKua4O/rS7nzyx7AgGAu/GdF5sK2k/Voc1X
 CXwpQOK1jVUlawhyunpjvJznqlZLw7FG/4NtSmEdCqbF7raIgMZ1KrEpn7jpihqmAIr7
 j+R5cw2lpLy5g0r6OrHMgTTDYQqTLwLeJnHZlY8YwOyylwcTwhxBeO3fTceRyB39ybmJ
 uEdQXw5NbBy/xptUVcbhjk/PQFMlPxNCbSnI8/zjV6J8TblHPT1ssBfo+odt7KS1SARW
 RZrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX07+Au0sgNuZwrMnGakBp0vzDonKgupxiUFLvDAhq3rc642S27N5M3mJQbFwI4N508LDjICxSs0fld09NxVyhMFpkNe48=
X-Gm-Message-State: AOJu0Yy/n1mcIcqikf7eynmrHpM7J4KI45IPNXqDf5Q1RvvQPjudYtbf
 sKRJSVt2LkwjlMbZxdtKkZ7FxW7q1z/qrhdpDt7KwSPXKGEaxVq0pNsQWu7rNuG7K4xcXe1qf+0
 g57n7Jlq33cqc2eYEE3zja8u6zBmcvbQbyTS6Rw==
X-Google-Smtp-Source: AGHT+IFNR0A34ueVjpkhYERuaarAt4/VrUdWFnkO+FWIVL+lqs1lGrrIlzWeI/x5/zisMJ2/zMdGDwVeUqa7ZIXnkNU=
X-Received: by 2002:a05:6512:555:b0:52e:a03f:ef53 with SMTP id
 2adb3069b0e04-52eb999c211mr2920195e87.24.1720595045802; Wed, 10 Jul 2024
 00:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
 <20240626-smcntrpmf_v7-v7-3-bb0f10af7fa9@rivosinc.com>
 <CAKmqyKOjmnvmCe9PvhLeowTT-nHz+pdnF4itEfEjh_C8xmiOOg@mail.gmail.com>
In-Reply-To: <CAKmqyKOjmnvmCe9PvhLeowTT-nHz+pdnF4itEfEjh_C8xmiOOg@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Wed, 10 Jul 2024 00:03:54 -0700
Message-ID: <CAHBxVyHqj9b1LV+h5A5MtyY9WoMsj-fhJYE86_frmaj49XbmLg@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] target/riscv: Add cycle & instret privilege mode
 filtering properties
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Rajnesh Kanwal <rkanwal@rivosinc.com>, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=atishp@rivosinc.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 2, 2024 at 7:03=E2=80=AFPM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Thu, Jun 27, 2024 at 9:59=E2=80=AFAM Atish Patra <atishp@rivosinc.com>=
 wrote:
> >
> > From: Kaiwen Xue <kaiwenx@rivosinc.com>
> >
> > This adds the properties for ISA extension smcntrpmf. Patches
> > implementing it will follow.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> > ---
> >  target/riscv/cpu.c     | 2 ++
> >  target/riscv/cpu_cfg.h | 1 +
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 4760cb2cc17f..ef50130a91e7 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -178,6 +178,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> >      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
> >      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> >      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> > +    ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
> >      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> >      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
> >      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> > @@ -1467,6 +1468,7 @@ const char *riscv_get_misa_ext_description(uint32=
_t bit)
> >  const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =3D {
> >      /* Defaults for standard extensions */
> >      MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
> > +    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
>
> Exposing the config should be at the end of the series. Implement then ex=
pose
>

Sure. I will move this to the end of the series.

> Alistair
>
> >      MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
> >      MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
> >      MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
> > diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> > index fb7eebde523b..b1376beb1dab 100644
> > --- a/target/riscv/cpu_cfg.h
> > +++ b/target/riscv/cpu_cfg.h
> > @@ -74,6 +74,7 @@ struct RISCVCPUConfig {
> >      bool ext_ztso;
> >      bool ext_smstateen;
> >      bool ext_sstc;
> > +    bool ext_smcntrpmf;
> >      bool ext_svadu;
> >      bool ext_svinval;
> >      bool ext_svnapot;
> >
> > --
> > 2.34.1
> >
> >

