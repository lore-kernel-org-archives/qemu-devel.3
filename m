Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0128BEB64DE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 02:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snUCh-0007sf-F6; Sun, 08 Sep 2024 22:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snUCg-0007ri-3G; Sun, 08 Sep 2024 22:32:34 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snUCe-0003CP-D3; Sun, 08 Sep 2024 22:32:33 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-5012778824eso871930e0c.2; 
 Sun, 08 Sep 2024 19:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725849150; x=1726453950; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxDo2NbMl5xVS+RlRP3XB1wj/izTn7qjmhfx+s6CTJo=;
 b=NXkDhgXxSEjS1kLNJXrESmyWyd45m/j8RY4F3vN+0gHd43d3cwxrctaTa1n2aCFIkx
 2Lt0vvcWFmqKFnVIAnt7S9BFfNyff85Dtyc3U2HcZj2o3NxgnPm8ETrWaD6LUmVOxXI0
 XBKRVZB3jD/Dgwcy8QFClobr1ejbeQwzc3Hcj4wF2SyMC3ilXzMngHULbTnIouMT8Cuc
 aNniD1uPmVe7jt2esXU6uFvStfO9NmGS+e/VtysrqzbyumFDVZ9zSFCgG96vil4bjO9M
 RuHmFvmdAuTIYYI1x/prQH1lJRD/3XlTxhuK0JBmnjSorXdf/UfjazjT8c0aBvNSLuj6
 IPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725849150; x=1726453950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YxDo2NbMl5xVS+RlRP3XB1wj/izTn7qjmhfx+s6CTJo=;
 b=nALGr7RgQ2eAms2bwFRsacllSSax2zYqMVDuOKotbM+Aa6FC3Qcdf9RcyqYJsH5hFQ
 dEkmVaoYiescJAJRTsOhz5Bn0ZfLqylX/J1P6qRVO1kMG2wVvmAXNOf6sMOXMl0vW03I
 M5PLeWZn065sZo17STh6yNLRyJ0eMWoW8I+YYhXZpUzF7ytNBdlDq9lzUXBHQU1EtiuG
 ovF+D6HC8zN445qoutBcYXnRAxrqYHZovIChKS5c7nSfkj33xtM+mvcpPWNKBxZ4ktiP
 hTWZWf6dL7GEgybxgBTcG0VntmBCcv/IDjOL9eub+WtK7YqR9Q0BHN1zQ6w68DInsD5p
 y7eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEo2mgN77116K+VZES4YOsaz0g/vsG6Q83zJw6F/XWbzQ4SVg55Tjuiv+4RJmwaECX9rvzCeI1bB3d@nongnu.org
X-Gm-Message-State: AOJu0Yy6iEHm0jpdN0HgOqB7uykdL5iy1pkrf0Gb496cOZ0ckcy934Dv
 YpUFQMfJr7D5Dh80a3/ocAzeIzFK4jo3u1ga6F1lCS7BnDY3s0acg99RYYz4r9Owq+uCOFx+30W
 rznjlzvAqSPnYyOmQELov+hPRCeM=
X-Google-Smtp-Source: AGHT+IE++334V6F6KORjl4SiPBdT+/S6jI54eRESD5i1VHosSSpqpwZ9km9EYLiYXXgtSgUV4163bXjZ0hMxgktFp2w=
X-Received: by 2002:a05:6122:2a12:b0:4eb:499a:2453 with SMTP id
 71dfb90a1353d-502143ca0bamr7280593e0c.8.1725849150058; Sun, 08 Sep 2024
 19:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240808081948.25837-1-yongxuan.wang@sifive.com>
In-Reply-To: <20240808081948.25837-1-yongxuan.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Sep 2024 12:32:04 +1000
Message-ID: <CAKmqyKOh9dwx8+oESM5gMmuX8UY7M5-Q5oS=+EuKMR=mk3M-3Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/intc/riscv_aplic: Check and update pending when
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Thu, Aug 8, 2024 at 6:21=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifive=
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>

> ---
>  hw/intc/riscv_aplic.c | 49 +++++++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 18 deletions(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 32edd6d07bb3..2a9ac76ce92e 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -159,31 +159,41 @@ static bool is_kvm_aia(bool msimode)
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
> -
> -        sourcecfg =3D aplic->sourcecfg[irq];
> -        if (sourcecfg & APLIC_SOURCECFG_D) {
> -            continue;
> -        }
> -
> -        sm =3D sourcecfg & APLIC_SOURCECFG_SM_MASK;
> -        if (sm =3D=3D APLIC_SOURCECFG_SM_INACTIVE) {
> -            continue;
> -        }
>
> -        raw_input =3D (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
> -        irq_inverted =3D (sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW ||
> -                        sm =3D=3D APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
> -        ret |=3D (raw_input ^ irq_inverted) << i;
> +        rectified_val =3D riscv_aplic_irq_rectified_val(aplic, irq);
> +        ret |=3D rectified_val << i;
>      }
>
>      return ret;
> @@ -702,6 +712,9 @@ static void riscv_aplic_write(void *opaque, hwaddr ad=
dr, uint64_t value,
>              (aplic->sourcecfg[irq] =3D=3D 0)) {
>              riscv_aplic_set_pending_raw(aplic, irq, false);
>              riscv_aplic_set_enabled_raw(aplic, irq, false);
> +        } else {
> +            if (riscv_aplic_irq_rectified_val(aplic, irq))
> +                riscv_aplic_set_pending_raw(aplic, irq, true);

You need curly braces for the if statement. You can run checkpatch.pl
to catch issues like this

Alistair

>          }
>      } else if (aplic->mmode && aplic->msimode &&
>                 (addr =3D=3D APLIC_MMSICFGADDR)) {
> --
> 2.17.1
>
>

