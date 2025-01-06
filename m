Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9A6E77198
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 00:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUbEU-00033a-Ae; Sun, 05 Jan 2025 19:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUbES-00033L-T7; Sun, 05 Jan 2025 19:44:36 -0500
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUbER-0000FE-CT; Sun, 05 Jan 2025 19:44:36 -0500
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-85c5a91374cso6067098241.3; 
 Sun, 05 Jan 2025 16:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736124273; x=1736729073; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBPSN0565DwRfHSLSkdp0aAZd4mGl37SWM8k/2149eQ=;
 b=kU+eCOod3p2lm5X3/PVZcKbDl/1/GOajjcpW1xA6RoTY14ZtTttO74As1hcWli8sP6
 DBsKZ/Dvk9/Al+i/p88rPjHNbEFZ+wohyUUbRbsRDztoAPlDTf09qVqbgADD2CeXjaEt
 FyrDOwQJJ2cGU4VsaLbbQaKenBo+FY5Pe6LC5lhX7XwBZ4RDWYVbaqf5x1wXG+hJx7DW
 m+0/EPs9N13huKPCb+kJnAE6vP2ubCVVl2p0UhunLE2sS60Pd3QJZIp6gpFR30YSg3Pb
 HmaKwbtxLn1T1gMBi+cX65vmOYjQUu1bpO0hpzUKWy46OKDCm7UXuT4/BOUbduoe9JVp
 HDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736124273; x=1736729073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jBPSN0565DwRfHSLSkdp0aAZd4mGl37SWM8k/2149eQ=;
 b=moWPDEb5SzNf+oMwoF8eHCEUBAFuggaBrl8BvlgV9pFdNhJgpsjGMa+S7Tpy3qQxBX
 77qDYQEivxw/Z9MsBrSKvWlLgQqHZn9G7hwQq9PSW0uLsXdNAV88HEI4xLYUWz6l8Hgn
 5944G1sYRijoOFf825sMo1l8gXKqKUQR4BBlIvmbPdpYnkT2sfARK+QmT/Yqr3L7l4/Y
 Oq46PNbZ/UPLYQ/4OiTqHbjU0DUGOxO2vfloXGPZ8CnSQyoe24ZF0LMBVv0KdEvBDi9B
 LjBUg5BhTMoTP5e5FFAy3/Hzoj9GDbmnOFe5amI6GSjfvXBgzpOJStpvgNIKEEatRJVm
 BmVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDFl2ARDJNU2gca6J05Og1r44M2sI2Ew/vUpRZr2xrFw1UsUabfR02B88FkWfbAGXQktO50uMl2Aj5@nongnu.org
X-Gm-Message-State: AOJu0YwBnkoERODKx2OIRavqQYkC8Nk5MnwMkkROFGIzbFivV8lCr+F+
 avtDMcJ4Za+Abo8PM6zJBvKfFsmI+lTov1TVf/1ndOQ7lS7Sc5BEUfUCLv7SHfUe4nMH47q5nh6
 vkMXn3Sj+uifwk4MKs1kusqW18Voceg==
X-Gm-Gg: ASbGncuBo/T9tEtY3s2rXDjGpFR/GkTmymnb7zHU4EtydnPla3OUnNlMvsgvuZ4HTme
 +9DUKaaaZTwS6p6Uf51Quud20wx6oznjMPKPcjqHIDFqo5K3nbqedoPOQGhDg+rdJpIA=
X-Google-Smtp-Source: AGHT+IF4WhxWqQhvHM96EoFogwOP5rASyAm5NQvgP6wWcrLmoypNAn/5RzcF6mrj05LeVdc8kky0nxU373R9TapnpIw=
X-Received: by 2002:a05:6102:c4e:b0:4b1:5cc5:cfa7 with SMTP id
 ada2fe7eead31-4b2cc11f0b4mr45560300137.0.1736124273283; Sun, 05 Jan 2025
 16:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20250102181601.1421059-1-richard.henderson@linaro.org>
 <20250102181601.1421059-2-richard.henderson@linaro.org>
In-Reply-To: <20250102181601.1421059-2-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 10:44:07 +1000
Message-ID: <CAKmqyKP2qj4fsUCMfrxNpaydo=bJJKsUg-wSo0G7KqsPSLw=Pg@mail.gmail.com>
Subject: Re: [PATCH 1/2] util/cpuinfo-riscv: Detect Zbs
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Fri, Jan 3, 2025 at 4:28=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  host/include/riscv/host/cpuinfo.h |  5 +++--
>  util/cpuinfo-riscv.c              | 18 ++++++++++++++++--
>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/host/include/riscv/host/cpuinfo.h b/host/include/riscv/host/=
cpuinfo.h
> index cdc784e7b6..b2b53dbf62 100644
> --- a/host/include/riscv/host/cpuinfo.h
> +++ b/host/include/riscv/host/cpuinfo.h
> @@ -9,8 +9,9 @@
>  #define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
>  #define CPUINFO_ZBA             (1u << 1)
>  #define CPUINFO_ZBB             (1u << 2)
> -#define CPUINFO_ZICOND          (1u << 3)
> -#define CPUINFO_ZVE64X          (1u << 4)
> +#define CPUINFO_ZBS             (1u << 3)
> +#define CPUINFO_ZICOND          (1u << 4)
> +#define CPUINFO_ZVE64X          (1u << 5)
>
>  /* Initialized with a constructor. */
>  extern unsigned cpuinfo;
> diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
> index 971c924012..0291b7218a 100644
> --- a/util/cpuinfo-riscv.c
> +++ b/util/cpuinfo-riscv.c
> @@ -36,7 +36,8 @@ static void sigill_handler(int signo, siginfo_t *si, vo=
id *data)
>  /* Called both as constructor and (possibly) via other constructors. */
>  unsigned __attribute__((constructor)) cpuinfo_init(void)
>  {
> -    unsigned left =3D CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND | CPUIN=
FO_ZVE64X;
> +    unsigned left =3D CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZBS
> +                  | CPUINFO_ZICOND | CPUINFO_ZVE64X;
>      unsigned info =3D cpuinfo;
>
>      if (info) {
> @@ -50,6 +51,9 @@ unsigned __attribute__((constructor)) cpuinfo_init(void=
)
>  #if defined(__riscv_arch_test) && defined(__riscv_zbb)
>      info |=3D CPUINFO_ZBB;
>  #endif
> +#if defined(__riscv_arch_test) && defined(__riscv_zbs)
> +    info |=3D CPUINFO_ZBS;
> +#endif
>  #if defined(__riscv_arch_test) && defined(__riscv_zicond)
>      info |=3D CPUINFO_ZICOND;
>  #endif
> @@ -71,7 +75,8 @@ unsigned __attribute__((constructor)) cpuinfo_init(void=
)
>              && pair.key >=3D 0) {
>              info |=3D pair.value & RISCV_HWPROBE_EXT_ZBA ? CPUINFO_ZBA :=
 0;
>              info |=3D pair.value & RISCV_HWPROBE_EXT_ZBB ? CPUINFO_ZBB :=
 0;
> -            left &=3D ~(CPUINFO_ZBA | CPUINFO_ZBB);
> +            info |=3D pair.value & RISCV_HWPROBE_EXT_ZBS ? CPUINFO_ZBS :=
 0;
> +            left &=3D ~(CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZBS);
>  #ifdef RISCV_HWPROBE_EXT_ZICOND
>              info |=3D pair.value & RISCV_HWPROBE_EXT_ZICOND ? CPUINFO_ZI=
COND : 0;
>              left &=3D ~CPUINFO_ZICOND;
> @@ -117,6 +122,15 @@ unsigned __attribute__((constructor)) cpuinfo_init(v=
oid)
>              left &=3D ~CPUINFO_ZBB;
>          }
>
> +        if (left & CPUINFO_ZBS) {
> +            /* Probe for Zbs: bext zero,zero,zero. */
> +            got_sigill =3D 0;
> +            asm volatile(".insn r 0x33, 5, 0x24, zero, zero, zero"
> +                         : : : "memory");
> +            info |=3D got_sigill ? 0 : CPUINFO_ZBS;
> +            left &=3D ~CPUINFO_ZBS;
> +        }
> +
>          if (left & CPUINFO_ZICOND) {
>              /* Probe for Zicond: czero.eqz zero,zero,zero. */
>              got_sigill =3D 0;
> --
> 2.43.0
>
>

