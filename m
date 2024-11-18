Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F610D6DDC4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 06:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCvZX-0001gb-Fe; Mon, 18 Nov 2024 01:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCvZW-0001ft-0I; Mon, 18 Nov 2024 01:49:18 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCvZU-00077m-9q; Mon, 18 Nov 2024 01:49:17 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-856e51bf038so517256241.2; 
 Sun, 17 Nov 2024 22:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731912554; x=1732517354; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGw0cH+P6hS5lkD18G8H9nn/DG2njtnM1pVDAApaJvQ=;
 b=l66QfD3cW1L9SUGOiB4k1AHiSFQ8S0qCRooixrtzq+X83tmg6vEfUARwCwZKq4YTHV
 KJyCTOmrHryb4nGaBMf90ZlpFE7VTWuWvFmPJlfb0UACidGLooy8/kS5zCfkq7K4EVT3
 59fE1MUua34bjgMnXmkfMcHc66Sne9jtOHNXQKe71h9xTm5IcohqAS6O1wMXWkacazp4
 dAFNsMVVCWHj1VIAq2R5CnkHR6e/2XWEZi7WaCr/XG6ruz2fn4uPG2JF50QQcI3sM6ZU
 95gWsROEmJLLiBa0INqTZ1CW5vkVkXCixIvrKL/hAJUaoNd7NH/bU5EIftnb/uSSnnFg
 s/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731912554; x=1732517354;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oGw0cH+P6hS5lkD18G8H9nn/DG2njtnM1pVDAApaJvQ=;
 b=AruwHB/LaDu0kkHe+IV1Rk1NRTxu9eWlRJ0ax55pJIGlmAZQ1lHmd/YlfSoBIrUb5e
 wWgPmhYD6IPhMT+M0DVV9m/6mx06qk+EFOEH2nZCFskR6rIH4hK8AOropVOc1WINeTHG
 n5ZnxSapaFjruKOMR+HffLiI8wCqh2O3G7IbNvKKhsCUTbEVoKxzJ4e8PzIEi6yOZnOG
 Qg0CZqcvJ5Q1oMxNyzHt7xzA0PA+gSzlBFiOADSWTLR8mtGn+LNyjSO7Hd/ziZy55qZf
 +hqOlSgUKXkBhMeDmyWmsBiKgUhnsm9u6XFyng2Oea2qQsM8OtJOd6mBfeOtMpE3owZT
 IEdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfwd64sx5vlOQYJhZEDOwYI6RFiSpqVwwJZ6689MEg6hLgoyf2IWmrT5J5Sc3pqm6v+pk0X2V2ziLh@nongnu.org
X-Gm-Message-State: AOJu0YxjH9dZTmjasQOEazoufOrunxK93aY2koWuklISQKX76zfnsnkw
 x7sRM9hMRicxlEHld48f8BS7VZD7ydJPXlT/AHo7Q+K+De1RrgE4rsZ2dEp10CvHV17MVSy+HGv
 5bO6L5C7OdSu+4pkIJ12dfL7zhWw=
X-Google-Smtp-Source: AGHT+IE55AjO44yLeocXMJeqMRCw+TJgbUYc7/E9+LplbfbiUaTwI3TcOKtxmdaBR5dfJEel2XdhrFdVUx8cdzyWEhs=
X-Received: by 2002:a05:6102:26c5:b0:4ad:4f26:105e with SMTP id
 ada2fe7eead31-4ad62d5bbbbmr8361436137.24.1731912554639; Sun, 17 Nov 2024
 22:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20241029085349.30412-1-yongxuan.wang@sifive.com>
In-Reply-To: <20241029085349.30412-1-yongxuan.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Nov 2024 16:48:48 +1000
Message-ID: <CAKmqyKPW4eKUZ7_uVHkf8gHNEYaOe66TuOivfkzNYXF=0qx6qw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] hw/intc/riscv_aplic: Fix APLIC in_clrip and
 clripnum write emulation
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
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

On Tue, Oct 29, 2024 at 6:54=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifiv=
e.com> wrote:
>
> In the section "4.7 Precise effects on interrupt-pending bits"
> of the RISC-V AIA specification defines that:
>
> "If the source mode is Level1 or Level0 and the interrupt domain
> is configured in MSI delivery mode (domaincfg.DM =3D 1):
> The pending bit is cleared whenever the rectified input value is
> low, when the interrupt is forwarded by MSI, or by a relevant
> write to an in_clrip register or to clripnum."
>
> Update the riscv_aplic_set_pending() to match the spec.
>
> Fixes: bf31cf06eb ("hw/intc/riscv_aplic: Fix setipnum_le write emulation =
for APLIC MSI-mode")
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v2:
> - add fixes tag (Daniel)
> - follow the suggestion from https://lore.kernel.org/kvm/CAAhSdy3NmwbHY9Q=
ef9LUeXfr0iE7wC-u0d_fHzC47PXk-MzmRg@mail.gmail.com/
>   (Anup)
> ---
>  hw/intc/riscv_aplic.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 4a262c82f078..74c82a841101 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -248,9 +248,12 @@ static void riscv_aplic_set_pending(RISCVAPLICState =
*aplic,
>
>      if ((sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_HIGH) ||
>          (sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW)) {
> -        if (!aplic->msimode || (aplic->msimode && !pending)) {
> +        if (!aplic->msimode) {
>              return;
>          }
> +        if (aplic->msimode && !pending) {
> +            goto noskip_write_pending;
> +        }
>          if ((aplic->state[irq] & APLIC_ISTATE_INPUT) &&
>              (sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW)) {
>              return;
> @@ -261,6 +264,7 @@ static void riscv_aplic_set_pending(RISCVAPLICState *=
aplic,
>          }
>      }
>
> +noskip_write_pending:
>      riscv_aplic_set_pending_raw(aplic, irq, pending);
>  }
>
> --
> 2.17.1
>
>

