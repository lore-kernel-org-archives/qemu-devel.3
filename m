Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F041BCFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 07:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxhmL-0003eM-Hq; Mon, 07 Oct 2024 03:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sxhmJ-0003db-UB
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 03:03:35 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sxhmI-0002WT-2n
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 03:03:35 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5e1c65eb5bbso2162144eaf.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 00:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1728284612; x=1728889412; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aptl47yu43/54sHoBJYfLeRjV//VWQKVUST0vLmIhDE=;
 b=in2huUbPSqpxjRvsMJOEg2egjI8ZCRujpCXV1JJT8Le/0Wv34WbUK/w88yGdwiwlJ3
 OILvgNju2mFWzxhfppnTttyY4iWxNYqpXKyvveOfcsAqR9cl4N9Pdom/8M3T/1Q11HZg
 PPaou2r61ZmletPgz/RFwQ5n/qdxiNem7Z2TkYtUCPKatS7b1IaM0G+KYJ1w7uAqhcxS
 7ETItHGUcRTfuGpCLBw2lrvhAYciYPP1vGhBFGOrTi9Ufr6+xhiZADgkzyXt04V2HgzG
 fmolEGZs6fV8RNS2BlydOvNrIRadyGzmiw5GaNnp2BFS03jAbsdMbsvN4C947jyZLTbM
 cKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728284612; x=1728889412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aptl47yu43/54sHoBJYfLeRjV//VWQKVUST0vLmIhDE=;
 b=QsF71+bTvkI30PPVWaD3PNTzgvSdt4J+XOHcPc9RuY7Vo4vQxaQ37r9DVPMgv0LpdH
 ZuX109TDVFeKse83xiUSmxEAd81NqEKtEd33kgTS+Mo3EqhII4traDiXfst+pQ41dmPZ
 4U3tZblBVR0eDPmt2wrzR0PKgXQyczw9Z7OqS6xC9iSPS8fxt4I1rGRXYIrt3N+iOWRZ
 z4t5L/LTqiWYpVPNCGz72L3o/EmTRfxJuggZh/bfcFtarHkuvwSmQ7wgY2JrVLmMyUiX
 RgETzIWSnZ8g+WkPwV/EZoYFqSgmfRUdL+jzMCmapqPz2KzKxV4POaUazx/7aeKzFBmy
 N2Sw==
X-Gm-Message-State: AOJu0Yz/rfdxDXIfStkFDJ0FvGE8dCSH3IyCdCEXkVcXypCM64/yf1oB
 PViqJU2/2+T4G64LMFHD6MkAwyu4EIfVpSXjpo5y3LMzTG0BFplMyO2chUruercyns9rXYaQXww
 tujCP5Q/pdMYhuu24HlSV2SX/vAjVk35g535k
X-Google-Smtp-Source: AGHT+IHSJri+2aZvXQ1eARZ+lTQ9vlOUtc90JapAavo8GdyWw6oSRzR651LfgMrVr6plEjFlgA4CVeLTH5c2vYHPOnw=
X-Received: by 2002:a05:6870:164b:b0:27b:6762:3fdb with SMTP id
 586e51a60fabf-287c1db855cmr8023688fac.6.1728284612219; Mon, 07 Oct 2024
 00:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241003234211.53644-1-philmd@linaro.org>
 <20241003234211.53644-12-philmd@linaro.org>
In-Reply-To: <20241003234211.53644-12-philmd@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 7 Oct 2024 09:03:21 +0200
Message-ID: <CAJ307EhfCd5Y_erOiTYnArnkg-U0xkPtv_j9T4CM_Za_oY=37A@mail.gmail.com>
Subject: Re: [PATCH 11/16] hw/sparc: Use explicit big-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Michael Rolnik <mrolnik@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <thuth@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Eric Farman <farman@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=chigot@adacore.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Oct 4, 2024 at 1:43=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> The SPARC architecture uses big endianness. Directly use
> the big-endian LD/ST API.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/sparc/leon3.c   | 42 +++++++++++++++++++++---------------------
>  hw/sparc/sun4m.c   |  6 +++---
>  hw/sparc64/sun4u.c |  6 +++---
>  3 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 6aaa04cb191..021b5070128 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -78,21 +78,21 @@ typedef struct ResetData {
>
>  static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val=
)
>  {
> -    stl_p(code++, 0x82100000); /* mov %g0, %g1                */
> -    stl_p(code++, 0x84100000); /* mov %g0, %g2                */
> -    stl_p(code++, 0x03000000 +
> +    stl_be_p(code++, 0x82100000); /* mov %g0, %g1                */
> +    stl_be_p(code++, 0x84100000); /* mov %g0, %g2                */
> +    stl_be_p(code++, 0x03000000 +
>        extract32(addr, 10, 22));
>                                 /* sethi %hi(addr), %g1        */
> -    stl_p(code++, 0x82106000 +
> +    stl_be_p(code++, 0x82106000 +
>        extract32(addr, 0, 10));
>                                 /* or %g1, addr, %g1           */
> -    stl_p(code++, 0x05000000 +
> +    stl_be_p(code++, 0x05000000 +
>        extract32(val, 10, 22));
>                                 /* sethi %hi(val), %g2         */
> -    stl_p(code++, 0x8410a000 +
> +    stl_be_p(code++, 0x8410a000 +
>        extract32(val, 0, 10));
>                                 /* or %g2, val, %g2            */
> -    stl_p(code++, 0xc4204000); /* st %g2, [ %g1 ]             */
> +    stl_be_p(code++, 0xc4204000); /* st %g2, [ %g1 ]             */
>
>      return code;
>  }
> @@ -112,13 +112,13 @@ static void write_bootloader(void *ptr, hwaddr kern=
el_addr)
>
>      /* If we are running on a secondary CPU, jump directly to the kernel=
.  */
>
> -    stl_p(p++, 0x85444000); /* rd %asr17, %g2      */
> -    stl_p(p++, 0x8530a01c); /* srl  %g2, 0x1c, %g2 */
> -    stl_p(p++, 0x80908000); /* tst  %g2            */
> +    stl_be_p(p++, 0x85444000); /* rd %asr17, %g2      */
> +    stl_be_p(p++, 0x8530a01c); /* srl  %g2, 0x1c, %g2 */
> +    stl_be_p(p++, 0x80908000); /* tst  %g2            */
>      /* Filled below.  */
>      sec_cpu_branch_p =3D p;
> -    stl_p(p++, 0x0BADC0DE); /* bne xxx             */
> -    stl_p(p++, 0x01000000); /* nop */
> +    stl_be_p(p++, 0x0BADC0DE); /* bne xxx             */
> +    stl_be_p(p++, 0x01000000); /* nop */
>
>      /* Initialize the UARTs                                        */
>      /* *UART_CONTROL =3D UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
> @@ -133,17 +133,17 @@ static void write_bootloader(void *ptr, hwaddr kern=
el_addr)
>      p =3D gen_store_u32(p, 0x80000318, 3);
>
>      /* Now, the relative branch above can be computed.  */
> -    stl_p(sec_cpu_branch_p, 0x12800000
> -          + (p - sec_cpu_branch_p));
> +    stl_be_p(sec_cpu_branch_p, 0x12800000
> +             + (p - sec_cpu_branch_p));
>
>      /* JUMP to the entry point                                     */
> -    stl_p(p++, 0x82100000); /* mov %g0, %g1 */
> -    stl_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
> -                            /* sethi %hi(kernel_addr), %g1 */
> -    stl_p(p++, 0x82106000 + extract32(kernel_addr, 0, 10));
> -                            /* or kernel_addr, %g1 */
> -    stl_p(p++, 0x81c04000); /* jmp  %g1 */
> -    stl_p(p++, 0x01000000); /* nop */
> +    stl_be_p(p++, 0x82100000); /* mov %g0, %g1 */
> +    stl_be_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
> +                               /* sethi %hi(kernel_addr), %g1 */
> +    stl_be_p(p++, 0x82106000 + extract32(kernel_addr, 0, 10));
> +                               /* or kernel_addr, %g1 */
> +    stl_be_p(p++, 0x81c04000); /* jmp  %g1 */
> +    stl_be_p(p++, 0x01000000); /* nop */
>  }
>
>  static void leon3_cpu_reset(void *opaque)
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index d52e6a7213f..f375f0d389b 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -271,9 +271,9 @@ static unsigned long sun4m_load_kernel(const char *ke=
rnel_filename,
>          if (*initrd_size > 0) {
>              for (i =3D 0; i < 64 * TARGET_PAGE_SIZE; i +=3D TARGET_PAGE_=
SIZE) {
>                  ptr =3D rom_ptr(KERNEL_LOAD_ADDR + i, 24);
> -                if (ptr && ldl_p(ptr) =3D=3D 0x48647253) { /* HdrS */
> -                    stl_p(ptr + 16, INITRD_LOAD_ADDR);
> -                    stl_p(ptr + 20, *initrd_size);
> +                if (ptr && ldl_be_p(ptr) =3D=3D 0x48647253) { /* HdrS */
> +                    stl_be_p(ptr + 16, INITRD_LOAD_ADDR);
> +                    stl_be_p(ptr + 20, *initrd_size);
>                      break;
>                  }
>              }
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 4ece1ac1ffc..e591e5a741a 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -210,9 +210,9 @@ static uint64_t sun4u_load_kernel(const char *kernel_=
filename,
>          if (*initrd_size > 0) {
>              for (i =3D 0; i < 64 * TARGET_PAGE_SIZE; i +=3D TARGET_PAGE_=
SIZE) {
>                  ptr =3D rom_ptr(*kernel_addr + i, 32);
> -                if (ptr && ldl_p(ptr + 8) =3D=3D 0x48647253) { /* HdrS *=
/
> -                    stl_p(ptr + 24, *initrd_addr + *kernel_addr);
> -                    stl_p(ptr + 28, *initrd_size);
> +                if (ptr && ldl_be_p(ptr + 8) =3D=3D 0x48647253) { /* Hdr=
S */
> +                    stl_be_p(ptr + 24, *initrd_addr + *kernel_addr);
> +                    stl_be_p(ptr + 28, *initrd_size);
>                      break;
>                  }
>              }
> --
> 2.45.2

For leon3:

Reviewed-by: Chigot Cl=C3=A9ment <chigot@adacore.com>

