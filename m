Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EA7C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 04:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7T4n-00050x-9I; Thu, 16 May 2024 00:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s7T4l-00050b-V9; Thu, 16 May 2024 00:50:43 -0400
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s7T4k-00072T-4W; Thu, 16 May 2024 00:50:43 -0400
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-47ef8c9991dso2239179137.0; 
 Wed, 15 May 2024 21:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715835040; x=1716439840; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZ1V+XeHZFFYo52QXcjvbrka+P5opxVsNXShzQBDDaM=;
 b=bOLcFDEmvnJPpwvHwvDnTSaP0gM8sy5A5/WW85NsO0WJOXkxfxKzSXhFZa5Y9XF6mW
 JCxrifTEPlBYAW2PxWMnHP6ibedd2gQIG+Kutp97PziFPbO5UQE8mFJRlQCMZ/VqxqZC
 cX2bYt2xT3wXoS0Gxf+BOazDC6mLrGmgEinSNwqUqeoVZG7Jd59IbqwVad4v70C0WDWv
 kNbCWpjyQR7Oje6paUxqL120EaLcUshkruqP59SMp3G5wuzVT0rl5gFCM+/MvR/rAxrp
 SZBhccgmMuPzyHjA0eZtp60Xbm9LWrgkAMZZR+ylA18x4XIApdBNdfO/jWuifBf9Sp0r
 oTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715835040; x=1716439840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZ1V+XeHZFFYo52QXcjvbrka+P5opxVsNXShzQBDDaM=;
 b=T2ie/ZqAjJlk+L0OyR5PfEAf/ID5n7G7Iy/A7HWdGiqhsatnFwpBSUeY0N7QQQAHoH
 SavRYpJQ6a3eJOI2T4PxClHIZ5W15zQlp0+RkWrbQFpaxw7wOVM2FYgH+I6wo5NlBezZ
 F2fcdlY2LFRupEMvrAAXUryYJNEpGHozWdSL5egI5HzJN63G4pZDH8JkVMNb9vwrWlo0
 4RXqf7mqASJlNzJxHOYkxXtxsLBIumxw8xTnIDjXej0XlH+KjwvGyl9bksdEA1kGIqkq
 40PSxeTivjJCntLNe4Q9s4vhin38tYCjp0yIxYvHMxPkuoV920MMO6m3MwW4sARHisav
 fRQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgZVpIBKCeQUa0JuqPWChYwY9UA44DVuA2iEoJtXnj2mEv7OfMdmgaPjuE4CY+zro2MruP688v+IdDr/PawyEW4wzHVJw=
X-Gm-Message-State: AOJu0Yxnm5JDi/HBVhTKQHC2wLsMrGjdMvmym6mmOXKlGTw2eMzg84U5
 hxCinUmHSmEBxkoRHkh1OcPReSqtihQwOuKdmK4nGekhf83CZMOXnXi1NTgf1s5r1Wv3rbaRSNb
 efdxm/zPhJk+ifDGNwh4xDGv9Sdg=
X-Google-Smtp-Source: AGHT+IFMHY7ewiilsQkNuS/y0jBYA1Kksurfmm75XGYk77J/p9qY2YbU6qQR1kPjLfM+iA6h0DwhHOovkT/VZabAU9M=
X-Received: by 2002:a05:6102:a4f:b0:47f:fe4:a39a with SMTP id
 ada2fe7eead31-48077de53a8mr15686591137.9.1715835039135; Wed, 15 May 2024
 21:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240514110217.22516-1-rbradford@rivosinc.com>
In-Reply-To: <20240514110217.22516-1-rbradford@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 May 2024 14:50:12 +1000
Message-ID: <CAKmqyKN6S3uD7nrp2z4js9Zrc249LH2V_h0H9HojO9sbjBh1CA@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Remove experimental prefix from "B"
 extension
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Andrew Jones <ajones@ventanamicro.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe35.google.com
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

On Tue, May 14, 2024 at 9:04=E2=80=AFPM Rob Bradford <rbradford@rivosinc.co=
m> wrote:
>
> This extension has now been ratified:
> https://jira.riscv.org/browse/RVS-2006 so the "x-" prefix can be
> removed.
>
> Since this is now a ratified extension add it to the list of extensions
> included in the "max" CPU variant.
>
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 2 +-
>  target/riscv/tcg/tcg-cpu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eb1a2e7d6d..861d9f4350 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1396,7 +1396,7 @@ static const MISAExtInfo misa_ext_info_arr[] =3D {
>      MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
>      MISA_EXT_INFO(RVV, "v", "Vector operations"),
>      MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
> -    MISA_EXT_INFO(RVB, "x-b", "Bit manipulation (Zba_Zbb_Zbs)")
> +    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
>  };
>
>  static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 40054a391a..164a13ad0f 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1281,7 +1281,7 @@ static void riscv_init_max_cpu_extensions(Object *o=
bj)
>      const RISCVCPUMultiExtConfig *prop;
>
>      /* Enable RVG, RVJ and RVV that are disabled by default */
> -    riscv_cpu_set_misa_ext(env, env->misa_ext | RVG | RVJ | RVV);
> +    riscv_cpu_set_misa_ext(env, env->misa_ext | RVB | RVG | RVJ | RVV);
>
>      for (prop =3D riscv_cpu_extensions; prop && prop->name; prop++) {
>          isa_ext_update_enabled(cpu, prop->offset, true);
> --
> 2.44.0
>
>

