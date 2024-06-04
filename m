Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FADBC25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 01:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEIhN-0005b6-2B; Mon, 03 Jun 2024 21:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEIhJ-0005aU-TS; Mon, 03 Jun 2024 21:10:45 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEIhI-0003Oe-7D; Mon, 03 Jun 2024 21:10:45 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-80a8770ff33so1680488241.0; 
 Mon, 03 Jun 2024 18:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717463443; x=1718068243; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQQr0yO2f2k5lhQE2ZGtWqWllPfCIwCEyaxAd/VsTE4=;
 b=H7hKgwSsbWCPKjpEc/20kwZE/o/WJ0qvtjK2gaAWPuqDxO4CzLtz4AbrVW9Ezgyk9b
 9hPj2tPOObF44Pa5X9EAmJrTjFbDSgL7p64NrBP1BIy0+k9tMRgoAeoJVYfBkJBZRFpI
 Txiro3SrpSKFgw17z56wlK9GojVSQskf0HfdWSPpPXeBlluA8dsh24fbPn1QMdXMAAeM
 m0q5CJEq6ijAJ/fMMhI68wIuK8L1dZd29aqA8jNzwgXua9DrYZg65y8ER2tCqP97FOtp
 alKKUR0/dreomWSTm9t/djgc8ffC+bbfoi+KcocILb4mYGxe/o7qHCBynQ2AGULjN1I6
 IY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717463443; x=1718068243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQQr0yO2f2k5lhQE2ZGtWqWllPfCIwCEyaxAd/VsTE4=;
 b=EgpaxEU5lw+AwO0wMmBfi/iVxbMv+Kee7CQXT84dU3G12G1owjrEFFk/wi+5gY4qR0
 iMjLCf/7Vs36IzyIhQtn6W34bD50eBcRk4WA1BnuO01d+V1bvMBwhXoYo+TZPE00b/oe
 pGUe2rnbi9dDoFHmJbEcfNLJiMuxI4k4BvKH+fZPv+HFX9uTvWfjpE/uOy6slMtoUpDF
 yDY6VAaGynjyTrER0b3scoj5AFIpyu4bpgJ0hFDsXTFyYArCpqGpfAmgfmV6kGRRDFeI
 gsPVA/s6E4ZT4WXvQ+beJHh8E6BUBRHj/om39+F5kcQX/SgQ+ivLmKgGYGjbQj3V/J1J
 wC2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkcfZw4jVTOACb87MbC+65XUi40k2Ihb1sNqYmrMXbLyM0NNmz0JmR/tvI7wl+bOD1Z5TIDOObeF9LGARv6j7XsxxrfEI=
X-Gm-Message-State: AOJu0YwzMVG/7pJGSWOAzXR9N6PgGVXWjS/kObfvI2EIeQiv9qw04A6R
 N5PSt2k2dR3FQYpXMVYCKHI0t5mVWwXTtHd0BjBiG2VtOcCA2v+RY4Xk8qBZXH1zcjZ3JT8Lj1C
 CmWO8AMpD8ZAjsYz+YcOG/20FfRU=
X-Google-Smtp-Source: AGHT+IErMXFhrlb/C1CDJtPLZeAbZ8re2wAn1kW9AFj5PAKXLKs/DGXjweLjcGHYYK2evjlzaZ2XFneYX1Vi4x1z4x8=
X-Received: by 2002:a1f:ddc2:0:b0:4e4:ef76:3843 with SMTP id
 71dfb90a1353d-4eb02d6d349mr9414489e0c.2.1717463442679; Mon, 03 Jun 2024
 18:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240324150949.20822-1-irina.ryapolova@syntacore.com>
 <20240324150949.20822-2-irina.ryapolova@syntacore.com>
In-Reply-To: <20240324150949.20822-2-irina.ryapolova@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 11:10:16 +1000
Message-ID: <CAKmqyKPSjYz0mHyGvaLwdqHjPETMr_UiMda2FnCyAghiFXCYfw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] target/riscv/csr.c: Add functional of hvictl CSR
To: Irina Ryapolova <irina.ryapolova@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 25, 2024 at 1:11=E2=80=AFAM Irina Ryapolova
<irina.ryapolova@syntacore.com> wrote:
>
> CSR hvictl (Hypervisor Virtual Interrupt Control) provides further flexib=
ility
> for injecting interrupts into VS level in situations not fully supported =
by the
> facilities described thus far, but only with more active involvement of t=
he hypervisor.
>
> A hypervisor must use hvictl for any of the following:
> =E2=80=A2 asserting for VS level a major interrupt not supported by hvien=
 and hvip;
> =E2=80=A2 implementing configurability of priorities at VS level for majo=
r interrupts beyond those sup-
> ported by hviprio1 and hviprio2; or
> =E2=80=A2 emulating an external interrupt controller for a virtual hart w=
ithout the use of an IMSIC=E2=80=99s
> guest interrupt file, while also supporting configurable priorities both =
for external interrupts
> and for major interrupts to the virtual hart.
>
> All hvictl fields together can affect the value of CSR vstopi (Virtual Su=
pervisor Top Interrupt)
> and therefore the interrupt identity reported in vscause when an interrup=
t traps to VS-mode.
> When hvictl.VTI =3D 1, the absence of an interrupt for VS level can be in=
dicated only by setting
> hvictl.IID =3D 9. Software might want to use the pair IID =3D 9, IPRIO =
=3D 0 generally to represent
> no interrupt in hvictl.
>
> (See riscv-interrupts-1.0: Interrupts at VS level)
>
> Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Changes for v2:
>   -added more information in commit message
> Changes for v3:
>   -applied patch in master
> ---
>  target/riscv/csr.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 726096444f..4c2cbcd59f 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3613,6 +3613,21 @@ static RISCVException write_hvictl(CPURISCVState *=
env, int csrno,
>                                     target_ulong val)
>  {
>      env->hvictl =3D val & HVICTL_VALID_MASK;
> +    if (env->hvictl & HVICTL_VTI)
> +    {
> +        uint32_t hviid =3D get_field(env->hvictl, HVICTL_IID);
> +        uint32_t hviprio =3D get_field(env->hvictl, HVICTL_IPRIO);
> +        /* the pair IID =3D 9, IPRIO =3D 0 generally to represent no int=
errupt in hvictl. */
> +        if (!(hviid =3D=3D IRQ_S_EXT && hviprio =3D=3D 0)) {
> +            uint64_t new_val =3D BIT(hviid) ;
> +             if (new_val & S_MODE_INTERRUPTS) {
> +                rmw_hvip64(env, csrno, NULL, new_val << 1, new_val << 1)=
;
> +            } else if (new_val & LOCAL_INTERRUPTS) {
> +                rmw_hvip64(env, csrno, NULL, new_val, new_val);
> +            }
> +        }
> +    }
> +
>      return RISCV_EXCP_NONE;
>  }
>
> --
> 2.25.1
>
>

