Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF86C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 03:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmOnp-0005IH-0F; Sun, 23 Feb 2025 22:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmOnk-0005AK-19; Sun, 23 Feb 2025 22:06:37 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmOnh-00028E-H3; Sun, 23 Feb 2025 22:06:35 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-8671441a730so1184598241.0; 
 Sun, 23 Feb 2025 19:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740366392; x=1740971192; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eg1y1Ua4cHPagwA8dQMgP3JWwBZLhcu2IExz+F4RTFk=;
 b=GZWW0sOjWeknPqnbQC7AB4g6Rntk5r9u4YOF2CwjQgGCbAdXZ8nF1AeTqq5kh19XYH
 fxm4Ofr7/zlNfyY1kCdj1VE9qWYPJ1QPpLyxvp+DAbxtjy3GjYhucGBklOhs5QamNQ+f
 A2qqboyT0wBFVrCd5CHIF/uqYlmGsAnvjxWxlL9uq1L4F5MALQIrpG4T19KptoDkccWR
 OTH8yuOB39QMRvAa3t3VKwufaxPTc4Zi32M/zbiaWfMsfRRn0DuVXbD+GvY5EEB2VXea
 6jEM6nioeSX1yxbJTD87U9AiWetbsy/JijTSwigrKRaKTml560QsaOzreNnSrS7cJ1gj
 cQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740366392; x=1740971192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eg1y1Ua4cHPagwA8dQMgP3JWwBZLhcu2IExz+F4RTFk=;
 b=p/sBwk6Nf2QVN+mrK3BneVvLRgBK0aUKHnEbbsIR0YgctKO6qymszgH3cgTxRfQ9sq
 cQxKFIav0JwXA4nIDPKT0E02cjfTei3TEITRJ/I7xKSMpMHWEi5wpxCv+av5p9pgIFcm
 BrjTsT6fOgxE9r5NQ703gzvtBRtcRVnClU2lwupVWlQqYCqLrkoQtO/1GsyqoaPPKVfS
 PR/1uAMom2upFjlzsFNTKTRZNSxnkAYOBekh2t4Sf0/Xv6xgdoTk6XsU1tkfrdFbTD5h
 fAJvAenrIbw08/Eb8ZW9Mo+fXV/gTchz5n3FXrWlCuYwB4sGUL3Rvf1Qt8CLlpvHww4K
 4kFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6Kl/Nbwy9TZoeBIFK/I+IZuvofZb5mAFLm7EjfaRCe5tknMS8dFJTOfZylXqEMcEciIA7t1QWBane@nongnu.org
X-Gm-Message-State: AOJu0Yz7kQ8LSjJCzEqiZJB8XwBcr3xMMCjE7wMxvxTdxo5v5CHL8/mA
 kugshg7k9eaZ/a2+mJcgzbVpc/EeP9E81S8R5jC+Z+tQ3XbjKHERcyKFBXDw9/T6bgSal78p+th
 SixlFBI2JvbpN7x3FVtJN53Mi6DK2nBnb
X-Gm-Gg: ASbGncv7GdKvuPdA9yzqM86VN4HTny9TTmUQ99NX/jo213M2YhKVtYg44EmwDz1O+8d
 8KiTssAHC/TfQvp5E5uDuPoUAGqNjtFst3hliQ6JGa9gOS9PJgmzUzgKPSvtOFO+857isf25gEP
 MGlZJklxcrPEX0s/iCt26DcKZ6ZE2mktGZY4RG
X-Google-Smtp-Source: AGHT+IGlEwoyPX4SdIbntkVPOO5681TxD0In/jxMEG9rGAMtv4medY9FsSDmd65qXAFLG83B+q7sOEptqDH/ob1qP3I=
X-Received: by 2002:a05:6102:3a0e:b0:4bb:edc9:f95f with SMTP id
 ada2fe7eead31-4bfc00c8062mr4701684137.14.1740366391978; Sun, 23 Feb 2025
 19:06:31 -0800 (PST)
MIME-Version: 1.0
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
 <20241205133003.184581-8-dbarboza@ventanamicro.com>
In-Reply-To: <20241205133003.184581-8-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 13:06:05 +1000
X-Gm-Features: AWEUYZnccbpHbiSeXWSyg21XrVbYh4Dbd_xhiitgvQnYIQzFIWv_Pvj0SzLoyAQ
Message-ID: <CAKmqyKO+CkEcCj9j3CGLGw9EbekM2Ebkky3CoC21q14OgDGutA@mail.gmail.com>
Subject: Re: [PATCH for-10.0 07/11] hw/riscv/riscv-iommu: add IOHPMCYCLES mmio
 write
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Tomasz Jeznach <tjeznach@rivosinc.com>
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

On Thu, Dec 5, 2024 at 11:34=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> RISCV_IOMMU_REG_IOHPMCYCLES writes are done by
> riscv_iommu_process_hpmcycle_write(), called by the mmio write callback
> via riscv_iommu_process_hpm_writes().
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu-hpm.c | 19 +++++++++++++++++++
>  hw/riscv/riscv-iommu-hpm.h |  1 +
>  hw/riscv/riscv-iommu.c     |  2 +-
>  3 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
> index 70814b942d..1cea6b1df1 100644
> --- a/hw/riscv/riscv-iommu-hpm.c
> +++ b/hw/riscv/riscv-iommu-hpm.c
> @@ -262,3 +262,22 @@ void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState=
 *s, bool prev_cy_inh)
>          timer_del(s->hpm_timer);
>      }
>  }
> +
> +void riscv_iommu_process_hpmcycle_write(RISCVIOMMUState *s)
> +{
> +    const uint64_t val =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_IOHP=
MCYCLES);
> +    const uint32_t ovf =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IOCO=
UNTOVF);
> +
> +    /*
> +     * Clear OF bit in IOCNTOVF if it's being cleared in IOHPMCYCLES reg=
ister.
> +     */
> +    if (get_field(ovf, RISCV_IOMMU_IOCOUNTOVF_CY) &&
> +        !get_field(val, RISCV_IOMMU_IOHPMCYCLES_OVF)) {
> +        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IOCOUNTOVF, 0,
> +            RISCV_IOMMU_IOCOUNTOVF_CY);
> +    }
> +
> +    s->hpmcycle_val =3D val & ~RISCV_IOMMU_IOHPMCYCLES_OVF;
> +    s->hpmcycle_prev =3D get_cycles();
> +    hpm_setup_timer(s, s->hpmcycle_val);
> +}
> diff --git a/hw/riscv/riscv-iommu-hpm.h b/hw/riscv/riscv-iommu-hpm.h
> index ee888650fb..0cd550975d 100644
> --- a/hw/riscv/riscv-iommu-hpm.h
> +++ b/hw/riscv/riscv-iommu-hpm.h
> @@ -27,5 +27,6 @@ void riscv_iommu_hpm_incr_ctr(RISCVIOMMUState *s, RISCV=
IOMMUContext *ctx,
>                                unsigned event_id);
>  void riscv_iommu_hpm_timer_cb(void *priv);
>  void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_in=
h);
> +void riscv_iommu_process_hpmcycle_write(RISCVIOMMUState *s);
>
>  #endif
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 56ec2d6d42..3bdd88df4a 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1934,7 +1934,7 @@ static void riscv_iommu_process_hpm_writes(RISCVIOM=
MUState *s,
>
>      case RISCV_IOMMU_REG_IOHPMCYCLES:
>      case RISCV_IOMMU_REG_IOHPMCYCLES + 4:
> -        /* not yet implemented */
> +        riscv_iommu_process_hpmcycle_write(s);
>          break;
>
>      case RISCV_IOMMU_REG_IOHPMEVT_BASE ...
> --
> 2.47.1
>
>

