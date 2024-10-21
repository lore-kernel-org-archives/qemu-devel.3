Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46F6D3C934
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 01:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2h6Z-000679-MO; Sun, 20 Oct 2024 21:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2h6X-00066N-JO; Sun, 20 Oct 2024 21:21:05 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2h6U-0005Rl-Pa; Sun, 20 Oct 2024 21:21:05 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-50d4780a24eso1155494e0c.3; 
 Sun, 20 Oct 2024 18:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729473661; x=1730078461; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UznisbEf9CBPMHUDTh/7NBJolyhF1qw7Kwjbqtcxcdg=;
 b=czr3dMTgXE91A6NwbCcduXZhDPgVXssCOzzNd2binfzOPF4hbPibFTqlxe4j9uSaiL
 xUGALjwx2bAvzBL0pfK0lTFxKduHKcNpCP9Y6STdGYOXDD7RfQesMaatvqHPc1oiV6IL
 xsLRRQx78VAHmn13gjwA6DcDafzRfRoKZTBoZNEguE3eLfem0IO/o1/idMgiPd4HW64E
 zaVobLlZ/vRqzDkBHEjV2De0ZvNho5vFVAfGDfJKY6U2vdeGCmPPDqb/J2BGy51Z9VtP
 Mm2y5E8fIAVujKOIHbG8JdqERshIABp0xqbZQ4iuTdF+blxB9/TVlGBrlqnUOL4Vf8q7
 uNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729473661; x=1730078461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UznisbEf9CBPMHUDTh/7NBJolyhF1qw7Kwjbqtcxcdg=;
 b=CjaYQwX9FsQJl0vPno2vT3hhiRL+bcaMV2yt+n83tBmarbGIIyy+jL4gjAfqHxE2Do
 E8G/UuGjHKLqvDG5CXWGMC9GrNVE6KMvzXfI3T1J5bS+Q4Bk83W8NmA/ZASiPAwUQq8g
 QRXsW5jcIEea4vaqc+AQF0c1jhIoJ3zPJvfSA6HW4TPD3mwOh6Mnw5Z9DHNuhMH4aZYN
 533GOGbB9ZyFu9pEEpfcKu02+xtWfs4vzUzTkBWDBHrPP/Qt0mH6oyzMFOOrLHZqYamc
 s4NqSCo2MfpryTY3zIn6QPo1npAytN73zq8rRWeqzvdBW2zxmPh+VKcNUXlrJ6cKSBvS
 CqLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4ig6tJu+mHBIqJXi/NiptJFMNi4iggunCr4MzxWsmg0aprBgBikykgGbLltO9yyZl0mbMyNRjs10s@nongnu.org
X-Gm-Message-State: AOJu0Yz3rzSWTdBvjVQeE8FJ2TwUWZ5BIRwQzV2IXJDYbWraSaIK7GZF
 6p2rEgeb1AE/i+gDUlLxVbOVuclgdlEZawFTvkW+fj/1QhV4CfpB2WMy6ifMKNe8WAOlsWlLWGQ
 kfyIAUHS7nvJ5JPm10BHNfHZyU+k=
X-Google-Smtp-Source: AGHT+IHNcuzC143W7nusYkBoXzHm7eI1wxp+Hd4uY0r6p6a7DUutI4Ng6ooY55wVU1Wk16HrSxA3K9/SzEN6b1c0rbc=
X-Received: by 2002:a05:6122:65a1:b0:509:e5b5:d133 with SMTP id
 71dfb90a1353d-50dda165c10mr7173110e0c.6.1729473661129; Sun, 20 Oct 2024
 18:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
 <20241016193140.2206352-4-richard.henderson@linaro.org>
In-Reply-To: <20241016193140.2206352-4-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2024 11:20:35 +1000
Message-ID: <CAKmqyKNr_tvSakP74CV1pBsGL-7XSsPW326FJud3cOVSmxAV9Q@mail.gmail.com>
Subject: Re: [PATCH v6 03/14] util: Add RISC-V vector extension probe in
 cpuinfo
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 zhiwei_liu@linux.alibaba.com, 
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Thu, Oct 17, 2024 at 5:35=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>
> Add support for probing RISC-V vector extension availability in
> the backend. This information will be used when deciding whether
> to use vector instructions in code generation.
>
> Cache lg2(vlenb) for the backend. The storing of lg2(vlenb) means
> we can convert all of the division into subtraction.
>
> While the compiler doesn't support RISCV_HWPROBE_EXT_ZVE64X,
> we use RISCV_HWPROBE_IMA_V instead. RISCV_HWPROBE_IMA_V is more
> strictly constrainted than RISCV_HWPROBE_EXT_ZVE64X. At least in
> current QEMU implemenation, the V vector extension depends on the
> zve64d extension.
>
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Message-ID: <20241007025700.47259-2-zhiwei_liu@linux.alibaba.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  host/include/riscv/host/cpuinfo.h |  2 ++
>  util/cpuinfo-riscv.c              | 24 ++++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/host/include/riscv/host/cpuinfo.h b/host/include/riscv/host/=
cpuinfo.h
> index 2b00660e36..cdc784e7b6 100644
> --- a/host/include/riscv/host/cpuinfo.h
> +++ b/host/include/riscv/host/cpuinfo.h
> @@ -10,9 +10,11 @@
>  #define CPUINFO_ZBA             (1u << 1)
>  #define CPUINFO_ZBB             (1u << 2)
>  #define CPUINFO_ZICOND          (1u << 3)
> +#define CPUINFO_ZVE64X          (1u << 4)
>
>  /* Initialized with a constructor. */
>  extern unsigned cpuinfo;
> +extern unsigned riscv_lg2_vlenb;
>
>  /*
>   * We cannot rely on constructor ordering, so other constructors must
> diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
> index 8cacc67645..16114ffd32 100644
> --- a/util/cpuinfo-riscv.c
> +++ b/util/cpuinfo-riscv.c
> @@ -4,6 +4,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/host-utils.h"
>  #include "host/cpuinfo.h"
>
>  #ifdef CONFIG_ASM_HWPROBE_H
> @@ -13,6 +14,7 @@
>  #endif
>
>  unsigned cpuinfo;
> +unsigned riscv_lg2_vlenb;
>  static volatile sig_atomic_t got_sigill;
>
>  static void sigill_handler(int signo, siginfo_t *si, void *data)
> @@ -34,7 +36,7 @@ static void sigill_handler(int signo, siginfo_t *si, vo=
id *data)
>  /* Called both as constructor and (possibly) via other constructors. */
>  unsigned __attribute__((constructor)) cpuinfo_init(void)
>  {
> -    unsigned left =3D CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND;
> +    unsigned left =3D CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND | CPUIN=
FO_ZVE64X;
>      unsigned info =3D cpuinfo;
>
>      if (info) {
> @@ -50,6 +52,9 @@ unsigned __attribute__((constructor)) cpuinfo_init(void=
)
>  #endif
>  #if defined(__riscv_arch_test) && defined(__riscv_zicond)
>      info |=3D CPUINFO_ZICOND;
> +#endif
> +#if defined(__riscv_arch_test) && defined(__riscv_zve64x)
> +    info |=3D CPUINFO_ZVE64X;
>  #endif
>      left &=3D ~info;
>
> @@ -65,7 +70,8 @@ unsigned __attribute__((constructor)) cpuinfo_init(void=
)
>              && pair.key >=3D 0) {
>              info |=3D pair.value & RISCV_HWPROBE_EXT_ZBA ? CPUINFO_ZBA :=
 0;
>              info |=3D pair.value & RISCV_HWPROBE_EXT_ZBB ? CPUINFO_ZBB :=
 0;
> -            left &=3D ~(CPUINFO_ZBA | CPUINFO_ZBB);
> +            info |=3D pair.value & RISCV_HWPROBE_IMA_V ? CPUINFO_ZVE64X =
: 0;
> +            left &=3D ~(CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZVE64X);
>  #ifdef RISCV_HWPROBE_EXT_ZICOND
>              info |=3D pair.value & RISCV_HWPROBE_EXT_ZICOND ? CPUINFO_ZI=
COND : 0;
>              left &=3D ~CPUINFO_ZICOND;
> @@ -113,6 +119,20 @@ unsigned __attribute__((constructor)) cpuinfo_init(v=
oid)
>          assert(left =3D=3D 0);
>      }
>
> +    if (info & CPUINFO_ZVE64X) {
> +        /*
> +         * We are guaranteed by RVV-1.0 that VLEN is a power of 2.
> +         * We are guaranteed by Zve64x that VLEN >=3D 64, and that
> +         * EEW of {8,16,32,64} are supported.
> +         *
> +         * Cache VLEN in a convenient form.
> +         */
> +        unsigned long vlenb;
> +        /* Read csr "vlenb" with "csrr %0, vlenb" : "=3Dr"(vlenb) */
> +        asm volatile(".insn i 0x73, 0x2, %0, zero, -990" : "=3Dr"(vlenb)=
);
> +        riscv_lg2_vlenb =3D ctz32(vlenb);
> +    }
> +
>      info |=3D CPUINFO_ALWAYS;
>      cpuinfo =3D info;
>      return info;
> --
> 2.43.0
>
>

