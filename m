Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BE1D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBDG-0003NX-7Y; Mon, 29 Dec 2025 06:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBDE-0003NA-Sj
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:14:56 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBDD-0005Fp-2Y
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:14:56 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b73a9592fb8so1713893766b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767006893; x=1767611693; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEhAiQdVgCRVoZlj3juwZJia4kfmPCwqvMgUNWAjVYg=;
 b=qIu/qlPNZSqKWFXiAubo/7LNa39woaAVmW5B+oKq/AzC98sb6oMK0tOR7t9J7eTuu7
 vekFTqipthn7SC2mWtXbswBheqDWKy29EMh3/QdkiyQFiu993Fn2L7Yi6GgOqiioTnWp
 klMSYh4MZCjlxK6evZga1K/oAa3Tns+TY9q2HyJ0Qk0nK1nJoA2iNMIxX0Qr0V10g7b7
 2HiKy0orb5ZOOxklxm6Sfc/YyVSH+8zzoS8yJU9PaE5Q4/9Ke4NMTZmd3kc5PGFXC6yS
 qoZwGpSZ/OTIJAd29vLhAKYakc9ILTHvKqu5n48hDFOMe3PRew1pi82XMgIU/u3dMIMx
 lGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767006893; x=1767611693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pEhAiQdVgCRVoZlj3juwZJia4kfmPCwqvMgUNWAjVYg=;
 b=dPxZQO5Jv88oLFfYh3Z2StpLJ9LjzLILy+dhRqDDJ7N9T/3aRhU/u2MVp0LuPowYqW
 4F2h/795/HJ57auPkpHZtKu/2RyEri8DJM3l1Xe69BnaChagtCDCznrtU02xYN8G4Xhx
 D2JSem1uRm8NH4yzbG+1eAvta8bOeU+cGJrUKHdddvqV9ktyCUodXvjhyLRIRc2LNe2k
 hW1WPon625rnWqaS1bFFCZe/Cyf2AfxR9KYRe8fDqjbV15EIPb/c1SccntdKHTju8/sQ
 OjaDu1Pe+zjp0dznh9q88diM18hyN+et/bdiLhp32aB5eL5AxKipRq+129Twg15b8pS1
 xt4w==
X-Gm-Message-State: AOJu0YwVepENs0FxgFkuC7LlbmEWZs2chkKDN+QXvUU9uu5BxGGTE1dF
 gtmCZuIePp7PQw0XlFMaGdSga9kZ45GkN/Mnq4gbA3LnImSdG94s7zG5b0HWzipumt5po6R/Vi6
 3A+hEUhXI0K1cgLsQMoBnZMwDTYRC8la4518JdChbtQ==
X-Gm-Gg: AY/fxX47Og9m9h5Irg5QK1J388Xa2sRn5cvEP/EtF5GZpZtl0gvANiiQKgogDyrEeoW
 2ZCdRduXR9+8ul2PWBB0fb2riwgn/3xgh+A1tXtowwU+LUiag8fSpXSPxO30HjiVvz8FtK75D+k
 Q9PO2s9ldBxx3U2EVf4Kax0U2XFPZoSg6fErW5XFUeC4xuNYOTBeFSNcc7aAAvtkZReyutEab9K
 yoxoTcVgRebXg1labevgk5sPvJYtkq4Peyqkf4YWUNC3iz1UYQlCxXniXbO3EM7FZiuclAfWBzJ
 h2OvS/RuERvM2qc7lWWw/9D+VcOIbiwkxYIVkSw=
X-Google-Smtp-Source: AGHT+IE1w+HQnqrcPgi40K6D5hEFCDDh29hF4Xff6qpjD1+UIsw0JE3FwQ2yV+rJyB18175fM24BL6664dcgahQthy4=
X-Received: by 2002:a17:907:7e9f:b0:b80:16:850b with SMTP id
 a640c23a62f3a-b803542da8cmr4014056066b.0.1767006893381; Mon, 29 Dec 2025
 03:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-3-philmd@linaro.org>
In-Reply-To: <20251224162642.90857-3-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:14:27 +0200
X-Gm-Features: AQt7F2ovy1AhdwuxZmjGZGMLMeQLRxr32pgXP3iRxjzQ26jcuSVUE4NDnUJ2FxY
Message-ID: <CAAjaMXZoRHMT7ZN2unhJvP-Y5nhEtQxUpFR5TTCZ+3bJssqYbw@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] hw/sparc: Use explicit big-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
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

On Wed, Dec 24, 2025 at 6:27=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The SPARC architecture uses big endianness. Directly use
> the big-endian LD/ST API.
>
> Mechanical change running:
>
>   $ for a in uw w l q; do \
>       sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
>         $(git grep -wlE '(ld|st)u?[wlq]_p' hw/sparc*/);
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Chigot Cl=C3=A9ment <chigot@adacore.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/sparc/leon3.c   | 42 +++++++++++++++++++++---------------------
>  hw/sparc/sun4m.c   |  6 +++---
>  hw/sparc64/sun4u.c |  6 +++---
>  3 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 631c6113b5c..0414e9df573 100644
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
> +    stl_be_p(code++, 0x82100000); /* mov %g0, %g1             */
> +    stl_be_p(code++, 0x84100000); /* mov %g0, %g2             */
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
> +    stl_be_p(code++, 0xc4204000); /* st %g2, [ %g1 ]          */
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
> index 53d7ae08ae9..52ca9586001 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -268,9 +268,9 @@ static unsigned long sun4m_load_kernel(const char *ke=
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
> index 82c3e7c855b..e83c82fc9ae 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -206,9 +206,9 @@ static uint64_t sun4u_load_kernel(const char *kernel_=
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
> 2.52.0
>

