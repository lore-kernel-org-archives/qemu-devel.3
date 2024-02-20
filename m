Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DDDC54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYEt-0004yQ-Ol; Tue, 20 Feb 2024 17:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1rcYEs-0004o1-0q
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:05:22 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1rcYEo-0000BV-U1
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:05:21 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-512b29f82d1so3930228e87.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 14:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708466716; x=1709071516;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+CX6VXTmBh09QBbs/GeIlvXtA5ox2lt2Ixx9L9mYbM=;
 b=oiUx4CGOZ1RRHiIUVXjywjl52ZcRv+s/WyHl3GSWO685mt4a0Vj9sC9/4xzOsMHwea
 IJz0vBgedtUqBgNHwyoRByqNQsFii9YHnHcc3gmILTCQmzOVAcctX1cJFZc9HZNzhXLM
 NoVQKOyQOE/MlC0uUycJWjbXtNJ0EeKFxaI1dDbKe67UuJHo/nsEb9+QfHX4cb1QQR2h
 il9aUMKpeGiMrl0oVEr9qVxdSYla7zwKg/Ijrh3aXTE1ihSRWiTJib9tBEiPUE1npWDQ
 IqLiaMz43NmqTVREJK7m/qGrbXoodpIKC/nhJj6FOQoPdJ2MPuybqbsCDHAj12HN6rgb
 EXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708466716; x=1709071516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c+CX6VXTmBh09QBbs/GeIlvXtA5ox2lt2Ixx9L9mYbM=;
 b=q77yX2AgouCiw1L9ReHWulen5wYlYHmh5kRXmtWq5ArWmq7fS8S2e7ipCiLvJAFD5B
 jkfoC9s7VeQwye/HTtVr9Cl8HHWE6SwVvlWcDPPcfPtUJa2nhaUWz5XT4m5velIq9BJf
 UJPZCrLbM/od07T2N+gz23+HsfgF4InWvshJSMf1IUh6AsFVyWTEFiboy7KlXSUXJZJo
 3SwgEEkpL5Ao95s3JAgxAWskwWo0tbvaiO65tySyG0HH+5c8vk1kl7oqOmm/T+m/OavX
 LisZRqV1ovFAiV7buhvPov7Wt/36iasWC601KYlMEvkdcXbQpMDG8jACk4T9UxcB3MyW
 rnqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFtVdz4zxA5P3LyPf6U6tYZR7s/BYYun/ryvtC4MwkbcJv5c5olM5kXSsYM5Uej39EQGtItGtKRUFm6i8LinSlGjtBvWc=
X-Gm-Message-State: AOJu0YwQemIbh/zIwN07zuSQeZmALki4VQkULTlKF17ubhCxVmcfjS1p
 mFx3XBB8Ht3ILdiHVkTJxMFzUqfiJUfkAaBKcV+Fe2svu9q8nU10LJ3rvj2e/JnLGH1A45h+2AW
 a2Y48Wt5QrpV/SEwmcbnlZP8x2TALu32XRtV6Xw==
X-Google-Smtp-Source: AGHT+IHIenxUNHodkG0h3rrBkK5cXQQK/y2NPMGKgA8WbyMofzulixGllVX0bUyLIfHTRk8vUyXTc+KOWg+Pro9zSrk=
X-Received: by 2002:a05:6512:691:b0:512:ccd2:5cb0 with SMTP id
 t17-20020a056512069100b00512ccd25cb0mr1248296lfe.29.1708466716259; Tue, 20
 Feb 2024 14:05:16 -0800 (PST)
MIME-Version: 1.0
References: <20240213145308.869874-1-alexghiti@rivosinc.com>
 <20240213-87d669a3bd421a1b2bc30fc2@orel>
In-Reply-To: <20240213-87d669a3bd421a1b2bc30fc2@orel>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 20 Feb 2024 23:05:05 +0100
Message-ID: <CAHVXubjs87Tqqyx=BSBm3RqiwvsYGSG_Nn0F-XAH2coQJLtr1A@mail.gmail.com>
Subject: Re: [PATCH RFC] target: riscv: Add Svvptc extension support
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alexghiti@rivosinc.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Andrew,

Sorry for the very late reply, I was (and still am) off!

On Tue, Feb 13, 2024 at 4:33=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Tue, Feb 13, 2024 at 03:53:08PM +0100, Alexandre Ghiti wrote:
> > The Svvptc extension describes a uarch that does not cache invalid TLB
> > entries: that's the case for qemu so there is nothing particular to
> > implement other than the introduction of this extension, which is done
> > here.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >
> > That's an RFC since the extension has not been ratified yet.
>
> Hi Alex,
>
> No need for the RFC tag. You can add not-yet-ratified extension support
> to QEMU as long as the CPU property is off by default (as you've done)
> and you add it to the riscv_cpu_experimental_exts[] array with an "x-"
> prefix on its property name.
>

I'll do that next week then,

Thanks,

Alex

> Thanks,
> drew
>
> >
> >  target/riscv/cpu.c     | 2 ++
> >  target/riscv/cpu_cfg.h | 1 +
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 1b8d001d23..4beb5d0350 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -178,6 +178,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> >      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
> >      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
> >      ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
> > +    ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_12_0, ext_svvptc),
> >      ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
> >      ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
> >      ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
> > @@ -1467,6 +1468,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions=
[] =3D {
> >      MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
> >      MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
> >      MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
> > +    MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, false),
> >
> >      MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
> >      MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
> > diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> > index 833bf58217..c973693b6e 100644
> > --- a/target/riscv/cpu_cfg.h
> > +++ b/target/riscv/cpu_cfg.h
> > @@ -77,6 +77,7 @@ struct RISCVCPUConfig {
> >      bool ext_svinval;
> >      bool ext_svnapot;
> >      bool ext_svpbmt;
> > +    bool ext_svvptc;
> >      bool ext_zdinx;
> >      bool ext_zaamo;
> >      bool ext_zacas;
> > --
> > 2.39.2
> >
> >

