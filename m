Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087FEC38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 04:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sROe9-0003f0-NQ; Wed, 10 Jul 2024 00:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sROe7-0003dy-2L; Wed, 10 Jul 2024 00:09:35 -0400
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sROe5-0001yQ-GX; Wed, 10 Jul 2024 00:09:34 -0400
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-48c2d353b01so2014552137.2; 
 Tue, 09 Jul 2024 21:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720584571; x=1721189371; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6Ck1eU6ncsjc03ndkznoCEqd3/vOvUdkUl2pQNwovw=;
 b=eB7dZF0Ci8tUjgZthRV+v+G+gQJ01/FoLkDl0pKc/ycY1b7n2PQ6mRpjh5WlyDFaOO
 LkaWb57Gy92YdJL5zcHDKor+MtpNp04sZUmW/A2aOkHO9W6tm0sSHDUKGGjFb7N7cPeY
 tC7Jrv9Nx7gAnD3nZqJue5He+1/2dw9d/mT8qjeaXaR3ad6om91w4E1iF1KhTBrBDFU8
 dNQbrcGT95+5t8sxXbwufN4v7na70fIyIrurYnwYcQxaY/xTAT4BHOL2iLMMdtpzfWih
 TLeSDMhmR4xYgt/+3rdJxPxbcHVj+3EhysWRl6OlLSG2RQ2SNayac5RMzPES62DS7zcL
 H8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720584571; x=1721189371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6Ck1eU6ncsjc03ndkznoCEqd3/vOvUdkUl2pQNwovw=;
 b=MOFk7UJpehQRuSaCfKdO4aPVa7NcvB5ApRDM6qvlLEog4zAtWWMMl/e4vCBnix2I45
 poi4e5dyuoGduSRMUftFEa27z/oTOKO6l8S+9L7y237glXQ6dM9gJnrrfj9dJYfCKsOl
 +dysMF+MSKv72g5inINpacdiUh16Z0dTuBec3ORTRgEazxFlrOpgYW0yL02pDrfqZGpJ
 rBksa8dMZaSv6AiQa58TtZaJ7OCksA01j5wbZJJ58EFfQyDARw0F28DQaO3m3lXK0JVw
 Zkry7jbJSLiYCp6n14G8NFjVjk/cKB5d/MBTrAbt+ZZ/6iyHcIXkzfanSUfgjZWmkcV8
 A7eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUjVWrGFe4mneFZIIQyLUBaz14lSRgtppigdqGEgJ48Ac6AggyAy21TI5WjW87S+l3WdYdgLKsb1CNFsMmu4Pgu5mphjhlFlpCoHl88GpyPhFA3d9sb/hFxSVZ1hLDEbF7uoDvnPWS5MHNRCZb/upBzg==
X-Gm-Message-State: AOJu0Yyi63GQyyCx15N5l+2wYM46uz39G8J35l56VHSCBzQEd5FIfB7O
 GiEc5g6tyd0gNrOHtrrljTO3VIKxnTe+eYmfWW+xXwri6ax/9IDchVTjgZmZmA8uCTKmMFlAi9k
 uLmzZMxjEUc+6A/UQ2CGlz7v+ZEk=
X-Google-Smtp-Source: AGHT+IGEV/SmVBT7AhyeTE5R/YEz09Ko3fM3FobVJA4n26D2Q/ceJB2jHg9+XdC3enfvUlugYM4vLBrcVeixsKl1YPg=
X-Received: by 2002:a05:6102:b14:b0:48f:831d:cea6 with SMTP id
 ada2fe7eead31-490321f7ffbmr5013693137.25.1720584571303; Tue, 09 Jul 2024
 21:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240710032814.104643-1-richard.henderson@linaro.org>
 <20240710032814.104643-14-richard.henderson@linaro.org>
In-Reply-To: <20240710032814.104643-14-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 10 Jul 2024 14:09:04 +1000
Message-ID: <CAKmqyKNWdDrfR+RA+SVtQVUafmsBWgq9srXpQQKhAE3tte6mhQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] target/riscv: Simplify probing in vext_ldff
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongu.org, 
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu, 
 max.chou@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe33.google.com
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

On Wed, Jul 10, 2024 at 1:30=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The current pairing of tlb_vaddr_to_host with extra is either
> inefficient (user-only, with page_check_range) or incorrect
> (system, with probe_pages).
>
> For proper non-fault behaviour, use probe_access_flags with
> its nonfault parameter set to true.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/vector_helper.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 1b4d5a8e37..4d72eb74d3 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -474,7 +474,6 @@ vext_ldff(void *vd, void *v0, target_ulong base,
>            vext_ldst_elem_fn *ldst_elem,
>            uint32_t log2_esz, uintptr_t ra)
>  {
> -    void *host;
>      uint32_t i, k, vl =3D 0;
>      uint32_t nf =3D vext_nf(desc);
>      uint32_t vm =3D vext_vm(desc);
> @@ -493,27 +492,31 @@ vext_ldff(void *vd, void *v0, target_ulong base,
>          }
>          addr =3D adjust_addr(env, base + i * (nf << log2_esz));
>          if (i =3D=3D 0) {
> +            /* Allow fault on first element. */
>              probe_pages(env, addr, nf << log2_esz, ra, MMU_DATA_LOAD);
>          } else {
> -            /* if it triggers an exception, no need to check watchpoint =
*/
>              remain =3D nf << log2_esz;
>              while (remain > 0) {
> +                void *host;
> +                int flags;
> +
>                  offset =3D -(addr | TARGET_PAGE_MASK);
> -                host =3D tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu=
_index);
> -                if (host) {
> -#ifdef CONFIG_USER_ONLY
> -                    if (!page_check_range(addr, offset, PAGE_READ)) {
> -                        vl =3D i;
> -                        goto ProbeSuccess;
> -                    }
> -#else
> -                    probe_pages(env, addr, offset, ra, MMU_DATA_LOAD);
> -#endif
> -                } else {
> +
> +                /* Probe nonfault on subsequent elements. */
> +                flags =3D probe_access_flags(env, addr, offset, MMU_DATA=
_LOAD,
> +                                           mmu_index, true, &host, 0);
> +                if (flags) {
> +                    /*
> +                     * Stop any flag bit set:
> +                     *   invalid (unmapped)
> +                     *   mmio (transaction failed)
> +                     *   watchpoint (debug)
> +                     * In all cases, handle as the first load next time.
> +                     */
>                      vl =3D i;
> -                    goto ProbeSuccess;
> +                    break;
>                  }
> -                if (remain <=3D  offset) {
> +                if (remain <=3D offset) {
>                      break;
>                  }
>                  remain -=3D offset;
> @@ -521,7 +524,6 @@ vext_ldff(void *vd, void *v0, target_ulong base,
>              }
>          }
>      }
> -ProbeSuccess:
>      /* load bytes from guest memory */
>      if (vl !=3D 0) {
>          env->vl =3D vl;
> --
> 2.43.0
>
>

