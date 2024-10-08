Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9C1CED258
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 02:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy0DV-0005FX-DB; Mon, 07 Oct 2024 22:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sy0DT-0005F2-Ii; Mon, 07 Oct 2024 22:44:51 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sy0DR-0008IA-Uc; Mon, 07 Oct 2024 22:44:51 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-84e857bc0feso2826371241.0; 
 Mon, 07 Oct 2024 19:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728355488; x=1728960288; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vmtwzfYVvKE9wfoCiqlAQ9b9b0NA7/bDfk1kM+8FZsw=;
 b=H+UntRtGYcNBle+WcBmdk0ASKYlXErtaan0kFS90CC7nqSN3e5bJDwgy6HZJPl4ovm
 r2ckveOytDAWhda7s+U7isZcFD6I7Unn3nT0eXOV8788bWC23mjy/LG66diY/l9Uor94
 /ewNB8VdmFOc+HfuGjNX9dXyC7hnaT1apgQMOKMDGVaVU/VwCAzAEtFivkxStfewie4b
 XwMa/ZBuCRO3lV7WV4iM1vZ82bq1D6IEJ6M24puiIaMtfPmLIoJgWzIjxVSz3lKAfYGJ
 qOzWJ3DZlZrsie5gMpx5Q+ks5MhYE4iUR/mU0amFMEPNutrkW2o0D86Aq/zgrQnjCzQi
 SRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728355488; x=1728960288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vmtwzfYVvKE9wfoCiqlAQ9b9b0NA7/bDfk1kM+8FZsw=;
 b=mZ5xtju9FsI9S8D1oMlKA3tEjPvK/CtyF+Ix1fobHCCf9r94bRFTTQzu7cC1P0rGh/
 YHoHJRzkBQLiWksExInraYUvDUEFWSzKJjHPxEvErtt9dmgcKhYfXGp/cIg6ebD7I7wx
 3rM3ttfCqOgxT56lpXcvQwbCUurRzxa7rhpcIPSAogmWMqIYPfeWUKFXPLxZiRa/t62O
 hrZ/Rc4U0uEvQVuMt+aDi9QD7Jp1zE9UT9hgB2OToTsbOeg+knVYNVP70FKNCvBezVGh
 2SBmRJBT0jdtnnBC8JCOLK5wKghbTW5uRVGUBnK6j8BFWQwE4be1w8AyS+bA/9KbjqCN
 f6xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGEFDwmbrcxWC5/pGo3voy7USVGeFIaeHA6nVVIt1i/jq3eTtykW6qDL/KR2MjixYms6JT4Sh4LbIY@nongnu.org
X-Gm-Message-State: AOJu0YweWFFMfoK0ffNGYsa7JnOAPyP4vDYeSNyBb6Xr9inuRgn/J+sQ
 Qa5BdI+Ki4GiznQD/uZ7j6VMiUo9AURnXpTDl3+ik2xc38hnNL4iaqqsqfGspNQ/sshwSdy/s6d
 4STdu5lJpUWyGxg38GGUik7mlG64=
X-Google-Smtp-Source: AGHT+IEZfN7mHBOMGL+ac6ZCWvnUpoqoGIUWCsDhjycR89+2/9WrjF8ApGTY76I4iWA94UuznbDSnS/oym9vzOtOpew=
X-Received: by 2002:a05:6102:f0b:b0:4a3:d4bd:258b with SMTP id
 ada2fe7eead31-4a43890a036mr1552660137.8.1728355488211; Mon, 07 Oct 2024
 19:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241004104649.13129-1-yongxuan.wang@sifive.com>
In-Reply-To: <20241004104649.13129-1-yongxuan.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Oct 2024 12:44:22 +1000
Message-ID: <CAKmqyKOGNohPoZHdxNAW15bcR7SsCpupjf0i3A3XLoxDjqibTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] hw/intc/riscv_aplic: Check and update pending when
 write sourcecfg
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Fri, Oct 4, 2024 at 8:47=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifive=
.com> wrote:
>
> The section 4.5.2 of the RISC-V AIA specification says that any write
> to a sourcecfg register of an APLIC might (or might not) cause the
> corresponding interrupt-pending bit to be set to one if the rectified
> input value is high (=3D 1) under the new source mode.
>
> If an interrupt is asserted before the driver configs its interrupt
> type to APLIC, it's pending bit will not be set except a relevant
> write to a setip or setipnum register. When we write the interrupt
> type to sourcecfg register, if the APLIC device doesn't check
> rectified input value and update the pending bit, this interrupt
> might never becomes pending.
>
> For APLIC.m, we can manully set pending by setip or setipnum
> registers in driver. But for APLIC.w, the pending status totally
> depends on the rectified input value, we can't control the pending
> status via mmio registers. In this case, hw should check and update
> pending status for us when writing sourcecfg registers.
>
> Update QEMU emulation to handle "pre-existing" interrupts.
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

>
> ---
> v2:
> - fix checkpatch warning
> ---
>  hw/intc/riscv_aplic.c | 51 ++++++++++++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 18 deletions(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 32edd6d07bb3..4a262c82f078 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -159,31 +159,42 @@ static bool is_kvm_aia(bool msimode)
>      return kvm_irqchip_in_kernel() && msimode;
>  }
>
> +static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
> +                                          uint32_t irq)
> +{
> +    uint32_t sourcecfg, sm, raw_input, irq_inverted;
> +
> +    if (!irq || aplic->num_irqs <=3D irq) {
> +        return false;
> +    }
> +
> +    sourcecfg =3D aplic->sourcecfg[irq];
> +    if (sourcecfg & APLIC_SOURCECFG_D) {
> +        return false;
> +    }
> +
> +    sm =3D sourcecfg & APLIC_SOURCECFG_SM_MASK;
> +    if (sm =3D=3D APLIC_SOURCECFG_SM_INACTIVE) {
> +        return false;
> +    }
> +
> +    raw_input =3D (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
> +    irq_inverted =3D (sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW ||
> +                    sm =3D=3D APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
> +
> +    return !!(raw_input ^ irq_inverted);
> +}
> +
>  static uint32_t riscv_aplic_read_input_word(RISCVAPLICState *aplic,
>                                              uint32_t word)
>  {
> -    uint32_t i, irq, sourcecfg, sm, raw_input, irq_inverted, ret =3D 0;
> +    uint32_t i, irq, rectified_val, ret =3D 0;
>
>      for (i =3D 0; i < 32; i++) {
>          irq =3D word * 32 + i;
> -        if (!irq || aplic->num_irqs <=3D irq) {
> -            continue;
> -        }
>
> -        sourcecfg =3D aplic->sourcecfg[irq];
> -        if (sourcecfg & APLIC_SOURCECFG_D) {
> -            continue;
> -        }
> -
> -        sm =3D sourcecfg & APLIC_SOURCECFG_SM_MASK;
> -        if (sm =3D=3D APLIC_SOURCECFG_SM_INACTIVE) {
> -            continue;
> -        }
> -
> -        raw_input =3D (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
> -        irq_inverted =3D (sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW ||
> -                        sm =3D=3D APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
> -        ret |=3D (raw_input ^ irq_inverted) << i;
> +        rectified_val =3D riscv_aplic_irq_rectified_val(aplic, irq);
> +        ret |=3D rectified_val << i;
>      }
>
>      return ret;
> @@ -702,6 +713,10 @@ static void riscv_aplic_write(void *opaque, hwaddr a=
ddr, uint64_t value,
>              (aplic->sourcecfg[irq] =3D=3D 0)) {
>              riscv_aplic_set_pending_raw(aplic, irq, false);
>              riscv_aplic_set_enabled_raw(aplic, irq, false);
> +        } else {
> +            if (riscv_aplic_irq_rectified_val(aplic, irq)) {
> +                riscv_aplic_set_pending_raw(aplic, irq, true);
> +            }
>          }
>      } else if (aplic->mmode && aplic->msimode &&
>                 (addr =3D=3D APLIC_MMSICFGADDR)) {
> --
> 2.17.1
>
>

