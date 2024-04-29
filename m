Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC051C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 02:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1GZ5-0007Dp-6r; Sun, 28 Apr 2024 22:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1GZ3-0007D6-EZ; Sun, 28 Apr 2024 22:16:21 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1GZ0-0000wh-Vp; Sun, 28 Apr 2024 22:16:20 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4dac5a3fbeaso1547164e0c.3; 
 Sun, 28 Apr 2024 19:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714356977; x=1714961777; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwZzHi26dZ5c6cpcoX3eitYP5+ZeW1+/zedr+01JoPE=;
 b=PXqtzQv9LsunP/ALRdS4U4cw4CuDViy1RWHS7a4HTcksKD2M1COF7QaJJNSkh9pdfV
 YE+DNG63/0/mDO/P1ItcCE2cFhhkgeXRVAfHbXgdDZNdfA+XzuLRI4nCBVcUt5lDtY8y
 qjLIVgv1TdsqF0PvEv4sf/gjxdluPih8snRZf2vMNH4UdsE16qZPiymcHCYsEYtbvk3Z
 JoPiNeXaCl8H9jTMxfbLM8e/z6cr3R/BCzed0W9WoQVGV0vthmht48Qre9l6lHKT7H0h
 TZ92XSEy2LBdK29ueNFVyL6VsOWJG+vneCOfJG4EZOeKB4yB2FUfohaG2v7s7yQo38ug
 Rg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714356977; x=1714961777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwZzHi26dZ5c6cpcoX3eitYP5+ZeW1+/zedr+01JoPE=;
 b=oLbe5tOxaVigB7EgWSCoXyJCH0N5klfxufIF/jEZ52tFieO+mHh4hiqfACQ2U+kSUk
 z0EbaXIs6+YT9lVfciwqOWoQI7Aw5MRFpU5CJR/rrcLgyxVrpYENnfMbu/IPUT/b+4jq
 QovUSwiehgkvpRJZyJ5OdJIvnC1mIqFG/Fcxru8t4PiNMiJjNTWqPFSdbackpDGH9jkS
 efBIDqXNhwarGTKlYLtdscnhfpst+/sHx99h8stNEDr/Z3kbY6gLoSZA5I7jCmd7f4Gh
 j5BopQ0eAtPO5J8677zjgQ4eFkd9LQmet199TMUKXKpvmX51PNxwc0Nt2i9WxPY6f5aT
 57tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrWuBvWtrSmQ8UI5FfR7pGVSSMCJaGCkDrEf3/mW1If5Rn2MiQYzbI2j2jhRpz5n4RwJO//k6y6CKKea4bBBQSGDbRXLs=
X-Gm-Message-State: AOJu0YxLs8g/6wvLm3jg8aeskclj7ln9udrksFry+YqHJRQZlCYPWgMY
 tTlNvL1pC3g2jzAKslObybNiUUaZghwQtf1jEpIvyko/j/1NHcztSPHGxw9HzBQgEEEeLIcVl1b
 ZqK6XBDrkQkPoUN55xJphMNsyAwE=
X-Google-Smtp-Source: AGHT+IHLUOj+CCdmDqca8LeAEaqn76x6bW2zPhhGTCsggHGbrM5l23iWGx1G4wZpIeelkqNnktkheZeVrF5sUz0puEY=
X-Received: by 2002:a05:6102:508d:b0:47c:3033:5faa with SMTP id
 bl13-20020a056102508d00b0047c30335faamr5448568vsb.20.1714356977562; Sun, 28
 Apr 2024 19:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240424202425.534338-1-dbarboza@ventanamicro.com>
 <20240424202425.534338-2-dbarboza@ventanamicro.com>
In-Reply-To: <20240424202425.534338-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 12:15:51 +1000
Message-ID: <CAKmqyKO3i+QYDdACTarWR_A+VdJ4weHEqLAA1W3=WMv9MoWOPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/riscv/kvm: remove sneaky strerrorname_np()
 instance
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, thuth@redhat.com, alex.bennee@linaro.org, 
 philmd@linaro.org, mjt@tls.msk.ru, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Thu, Apr 25, 2024 at 6:27=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Commit d424db2354 excluded some strerrorname_np() instances because they
> break musl libc builds. Another instance happened to slip by via commit
> d4ff3da8f4.
>
> Remove it before it causes trouble again.
>
> Fixes: d4ff3da8f4 (target/riscv/kvm: initialize 'vlenb' via get-reg-list)
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 6a6c6cae80..ee69ea9785 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1054,8 +1054,8 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVM=
ScratchCPU *kvmcpu,
>
>          ret =3D ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
>          if (ret !=3D 0) {
> -            error_report("Unable to read vlenb register, error code: %s"=
,
> -                         strerrorname_np(errno));
> +            error_report("Unable to read vlenb register, error code: %d"=
,
> +                         errno);
>              exit(EXIT_FAILURE);
>          }
>
> --
> 2.44.0
>
>

