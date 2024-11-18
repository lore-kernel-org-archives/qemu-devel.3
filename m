Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6892D10F3A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 01:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCqcB-0001OD-Pk; Sun, 17 Nov 2024 20:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCqc3-0001Na-L4; Sun, 17 Nov 2024 20:31:39 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCqbz-0001CZ-WE; Sun, 17 Nov 2024 20:31:34 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-856e849af48so864350241.2; 
 Sun, 17 Nov 2024 17:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731893489; x=1732498289; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UakCqRsRqARr3KWbLcl1y3V6jFG4SnbWO6ibObSLCQw=;
 b=OWDdpdCCvva885aWOcfX9LGDBTFywCjOZHVawBi/CxUHZtBtZKaXvHA29s76gwhKYU
 I73JxrwD2Wz3aXAWzfoHI7cmtnESYtcIVk4omd0cY6o7C9Kat13wFEVKi3/jUlfE74kE
 ZM3kxUVPyZ5xCPDCocIeQGdFTKp3ZiDf+Mspq59lf6Ox9tqI2E+RzshBTZk6Ad0bVD9J
 heUne54DC2aYhxF+etZacXM/3tFgXlkRX52VFgdJNl4bvcPBs0/AuTp/u6uwiOzUmHxH
 PhhVaZAhIMQ8MJyJoHxAOTjCypA92lS8XbHon5ygnsaN3Cf+meZGTzkGeZ93zS1cevXa
 SzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731893489; x=1732498289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UakCqRsRqARr3KWbLcl1y3V6jFG4SnbWO6ibObSLCQw=;
 b=iWpAaUTRizF4qgJtdOHBOd17jioci4b2INSOgYyGMN4hRZkrbDHMx5WgUMLlUDhMoA
 veNhinZZYE4hRqoWsj4eR3MpJPTc+FzDnGwyp33X47Uyg6q0TLVuXv8Dr5NlenD8Kd4j
 lE2zrddhQfkZOXA9Kaztwk8/Uj4/+gf6IGzBGdX34h3jvZow2AvlmFgmO2gyorayktw5
 Jm1vbB4HjDASBEXpz1CucJnHrWY6Ggicl8ELSpcyCZ/81NDOWDRkXRAVb+CFzhF1X4YI
 Te/9yzBc9rC2E30Sj1qtMSR/S8SaRkX3FLQSQu4eEuY9WDikjNV3RTBXyx4hCLxuI+Zn
 PGAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSajZy37dcs7lf8NuQIcy2241Mp1vcm98ijYKZAGcV0PPvx3F64t7P2hJgW/C2TlaI6aURfIydlfIz@nongnu.org
X-Gm-Message-State: AOJu0Yx9HYEx8iUMA60SAALwyLhSRTGUeqtoSwgzZZ8qcjDIGeXcuM0o
 HylYgnal5n464u8j1+HzTdlmCkH5KcmBJ/NrT823DIftocQrVBA9mwqyiX4LZcDUcY9oukANq2I
 rBhjmpld5bsn2Y60Rr1qdOf2ZBuQ=
X-Google-Smtp-Source: AGHT+IFL58i9sJOeP7fCRFYAUDZjrSdWvKZ5/glg9OgTT+J0geWQoybU8Ued6ToLzpgObJ7sA1hEtoKWkYU5RWBjBY8=
X-Received: by 2002:a05:6102:c4c:b0:4a4:78a3:34f6 with SMTP id
 ada2fe7eead31-4ad62b5af11mr8034017137.16.1731893489558; Sun, 17 Nov 2024
 17:31:29 -0800 (PST)
MIME-Version: 1.0
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
 <20241010190337.376987-2-dbarboza@ventanamicro.com>
In-Reply-To: <20241010190337.376987-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Nov 2024 11:31:03 +1000
Message-ID: <CAKmqyKPHsoJb5zZ6ro=nNMSb=Dkaz5U9rFVtQHmY3iyu1K3UYQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] hw/intc/riscv_aplic: rename is_kvm_aia()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Fri, Oct 11, 2024 at 5:05=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The helper is_kvm_aia() is checking not only for AIA, but for
> aplic-imsic (i.e. "aia=3Daplic-imsic" in 'virt' RISC-V machine) with an
> in-kernel chip present.
>
> Rename it to be a bit clear what the helper is doing since we'll add
> more AIA helpers in the next patches.
>
> Make the helper public because the 'virt' machine will use it as well.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_aplic.c         | 8 ++++----
>  include/hw/intc/riscv_aplic.h | 1 +
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 4a262c82f0..20de8c63a2 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -154,7 +154,7 @@
>   * KVM AIA only supports APLIC MSI, fallback to QEMU emulation if we wan=
t to use
>   * APLIC Wired.
>   */
> -static bool is_kvm_aia(bool msimode)
> +bool riscv_is_kvm_aia_aplic_imsic(bool msimode)
>  {
>      return kvm_irqchip_in_kernel() && msimode;
>  }
> @@ -853,7 +853,7 @@ static void riscv_aplic_realize(DeviceState *dev, Err=
or **errp)
>      uint32_t i;
>      RISCVAPLICState *aplic =3D RISCV_APLIC(dev);
>
> -    if (!is_kvm_aia(aplic->msimode)) {
> +    if (!riscv_is_kvm_aia_aplic_imsic(aplic->msimode)) {
>          aplic->bitfield_words =3D (aplic->num_irqs + 31) >> 5;
>          aplic->sourcecfg =3D g_new0(uint32_t, aplic->num_irqs);
>          aplic->state =3D g_new0(uint32_t, aplic->num_irqs);
> @@ -877,7 +877,7 @@ static void riscv_aplic_realize(DeviceState *dev, Err=
or **errp)
>       * have IRQ lines delegated by their parent APLIC.
>       */
>      if (!aplic->parent) {
> -        if (kvm_enabled() && is_kvm_aia(aplic->msimode)) {
> +        if (kvm_enabled() && riscv_is_kvm_aia_aplic_imsic(aplic->msimode=
)) {
>              qdev_init_gpio_in(dev, riscv_kvm_aplic_request, aplic->num_i=
rqs);
>          } else {
>              qdev_init_gpio_in(dev, riscv_aplic_request, aplic->num_irqs)=
;
> @@ -1021,7 +1021,7 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr=
 size,
>
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>
> -    if (!is_kvm_aia(msimode)) {
> +    if (!riscv_is_kvm_aia_aplic_imsic(msimode)) {
>          sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
>      }
>
> diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.=
h
> index de8532fbc3..fd0e6427d9 100644
> --- a/include/hw/intc/riscv_aplic.h
> +++ b/include/hw/intc/riscv_aplic.h
> @@ -71,6 +71,7 @@ struct RISCVAPLICState {
>  };
>
>  void riscv_aplic_add_child(DeviceState *parent, DeviceState *child);
> +bool riscv_is_kvm_aia_aplic_imsic(bool msimode);
>
>  DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
>      uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
> --
> 2.45.2
>
>

