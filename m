Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD66606A891
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UM1WVLmR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTEbR-0007ZI-0B; Tue, 17 Nov 2026 03:31:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1xTEbK-0007Yo-2r
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 03:31:40 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1xTEbH-0001nL-5e
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 03:31:37 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8b0dba37a7fso41028947b3.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 00:31:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794904294; cv=none;
 d=google.com; s=arc-20260327;
 b=n1l4LOR6W8k2hWXZTtPp/wozszYvavvn3kdfNSqmghazD95cFh1LbtxwRB8Ji4jj+r
 VA+uX/gSLJat70r5ohjp2ih1VjVLCnZqB9gg1h0/7on7OAsyrQATH7sndSLWm18kz6qZ
 Es/UJUolwA7gzl1/5IBI+cNoeNA0+0hrDTnFbKYSJYAYucgh8vZOjufojY7jgdh2uYHx
 dRlhF+TrWx34bEd+HauuywTSpKHYYqvWv1Cc0tmcHH0INNJqP72iumqzpVDgsJ8Tog35
 xlW/LTvnhOMwbnQ+Q5t7XSoqVl4B31PsR0FFEc0RXW/S06wZFAhyGTPjaOSh7d0OQS0c
 D5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eAgNS6yL9X2jabg4qcURC6HMXosGY3Sud4DfXFOKdTE=;
 fh=kcRckPYkpczKkk0OKEnjS6iMZzWEE5C9DIfv7ZXcqJQ=;
 b=fe3WNUjErpYAcveVRANvQfwjQzMqGKv6Q3JpUP3fZTlOQ5BTDNVO3QbHTL/IdLP3IT
 wwgww7wtiKp5MYCpzLgz9StC4ZVOYhBoDO+utIa/yzqdYrf/1DT3giUXLLUzNSPTSkPz
 uvNEzUjMy19DmeFHpSuf0/BzQQQaXFa/xrbBZmhSIy30k79eG+bE8GDDPzFZhKmWiWmf
 iBpsjdgPhuMcscdap4qjhqv76LUjh5vFa+pSuZLXy9wjqOGH4ETSDFYTpAFOGbRYIOcv
 2A80Kyzzck/tgIBkO56bjVC+k8lqc0ld3MLeTKfmexXBONqxbWE3+VC9AU2HUCBpHDOs
 6MlQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794904294; x=1795509094; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eAgNS6yL9X2jabg4qcURC6HMXosGY3Sud4DfXFOKdTE=;
 b=UM1WVLmRWD1FVPkFRgHJIRQYRwKa4nEBFRXxBjmMO4JrWn7LKWoJDLCyiihQLeB4fe
 RLZwG3wAw2xAQNhWbliM0znEUu6Ryh8MSnCZl3K7joSXSNqrcylLclQADwhCLuy+algV
 nneho0tGA22dr1+W96VYpBIp7zKfzvw+B+gKDXxIj0R0JqPEjstk1ZtvwWQ+viMM4vw/
 JSz1LIbaLehRBEWCNpdlGShSgNv6KAR1/rSeNRQ2ORTGM8BlHdd3GNzJDZg62ui7a2c6
 VtrCaZPiCPHS8L3QHcfIDLLnB53eBvfWSV7ukgO4p7W4YytvTthxFZIX7+Keq+Iwm20E
 3uFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794904294; x=1795509094;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eAgNS6yL9X2jabg4qcURC6HMXosGY3Sud4DfXFOKdTE=;
 b=fArNGPuOklEn7+ZnU/VBc5obb9FlfPBey5ipq4PDq2jalJvUk0qGIPXT3gMjcavckg
 qqqwk4okANqwec71vmgR016Ue14nNfuoHYYVB5m3Sw25YWLarrOSKQpanj9tlDZR22MM
 DffXmr7OjxkkLTyxBuTk6mJYbtAyJGSYXkxgLGqQUg64XCBbp2bnxdhOIy5lELJLc4Kz
 OmtBlHqTsUy2cPXVjgsuLXzClSjE4IKLTAJYeyazguC0egJqlPKQBsnI36rMThwqnSbe
 FM300Qu+LsLiLhRqS8jxP9MNERjFS4gpUBsOBxg5xQxgO/eiV9YCzJbRTTQmLiQ8i9vn
 WQWQ==
X-Gm-Message-State: APuU4Z9mBLG+OuqvswSdN65CjwMcUD+7F92SpCuOzmuO51RT6pCGkB9e
 nTwd4s/el8lT6uKzBIpBtRpYPcmPfMcYGU2aVq+KFGtKhAy6Me0ltnatW4qfqtPfJS0qbhbC77F
 /W9lG/SaJ3Y7F45Dn11TcCaHqL+fe1CX8SgC2
X-Gm-Gg: AZFdTZeND8AxH1H+x61Z4yvwa1wfgP0KY30z5J55XV6SlgQvQUpDdW5WUVNqeCHG+3a
 ab4eT2jx2CdbwryWZs9LWa2gXG801A+lo5IT8UzkY0+BDoTvVdx89cTVSYIPxBTCu/lFuahUYVE
 cQxiFJDzOnG8sGceJU4Vxw39o1TyD08Ao1HB9j9SM0nixWpmWtE/JgwG851zKPS7UjB8CMVAr/5
 SNurIvOqYOgDvqOl0Hz4m841XOD81YcFLIwA5DIx8QkHzDCjYyd0CMEMH+/90P6PWTdhuol7Qre
 rsA8BYyvtfbP45W8t8NBnketZMzXeqcdG7nZ7LJ3g48AG2FzTSyE6d5Dkxu0i9jlN42e1xWpiCz
 Hs1UK7h+bk00Cbe+AS29xd5wAdJ2eTlLxQFEq0gLg3tm6JMpWOnDYBShrBn0yC1jgs5gjned3f+
 LdIMG0i4qEbGYiKrEd9GXN8R+spw3y
X-Received: by 2002:a53:c808:0:b0:675:c1e8:d522 with SMTP id
 956f58d0204a3-67d89745f29mr4321658d50.134.1794904293554; Tue, 17 Nov 2026
 00:31:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027130613.113038-1-ralerrdirsardx@gmail.com>
In-Reply-To: <20261027130613.113038-1-ralerrdirsardx@gmail.com>
From: Artemii Mashanov <ralerrdirsardx@gmail.com>
Date: Tue, 17 Nov 2026 11:31:22 +0300
X-Gm-Features: AclHuK8hCD3OhNUAbEAbaRv-nNWiRmFeZiKQkFwhV1LLMxRp5K4s1MQxfVdPbEU
Message-ID: <CAGHp__ZfCyvBz02hCYD+D901gCpVOCrVz7CMzOBMt0hpQ8JPCQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user/x86_64: fix modify_ldt ABI and lm handling
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=ralerrdirsardx@gmail.com; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Ping on this patch. Could someone please take a look when time permits?

Please let me know if any changes or additional testing are needed.

Thanks,
Artemii

=D0=B2=D1=82, 27 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 16:07, Art=
emii Mashanov <ralerrdirsardx@gmail.com>:
>
> Linux uses a 16-byte user_desc on x86_64, with a 32-bit base_addr.
> QEMU expects 24 bytes instead and rejects valid modify_ldt writes.
>
> Use a 32-bit base_addr and swap it accordingly. Ignore lm when
> building LDT entries, matching Linux. Add a shared i386/x86_64
> regression test for the ABI size and descriptor contents.
>
> Based on the diagnosis and proposed fix by naehrwert in issue #4691.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4691
> Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
> ---
>  linux-user/syscall.c               | 10 +----
>  linux-user/x86_64/target_syscall.h |  4 +-
>  tests/tcg/i386/meson.build         |  1 +
>  tests/tcg/i386/modify-ldt.c        | 72 ++++++++++++++++++++++++++++++
>  tests/tcg/x86_64/meson.build       |  1 +
>  5 files changed, 78 insertions(+), 10 deletions(-)
>  create mode 100644 tests/tcg/i386/modify-ldt.c
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 0380691..a5d827b 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6237,7 +6237,7 @@ static abi_long write_ldt(CPUX86State *env,
>      struct target_modify_ldt_ldt_s ldt_info;
>      struct target_modify_ldt_ldt_s *target_ldt_info;
>      int seg_32bit, contents, read_exec_only, limit_in_pages;
> -    int seg_not_present, useable, lm;
> +    int seg_not_present, useable;
>      uint32_t *lp, entry_1, entry_2;
>
>      if (bytecount !=3D sizeof(ldt_info))
> @@ -6245,7 +6245,7 @@ static abi_long write_ldt(CPUX86State *env,
>      if (!lock_user_struct(VERIFY_READ, target_ldt_info, ptr, 1))
>          return -TARGET_EFAULT;
>      ldt_info.entry_number =3D tswap32(target_ldt_info->entry_number);
> -    ldt_info.base_addr =3D tswapal(target_ldt_info->base_addr);
> +    ldt_info.base_addr =3D tswap32(target_ldt_info->base_addr);
>      ldt_info.limit =3D tswap32(target_ldt_info->limit);
>      ldt_info.flags =3D tswap32(target_ldt_info->flags);
>      unlock_user_struct(target_ldt_info, ptr, 0);
> @@ -6258,11 +6258,6 @@ static abi_long write_ldt(CPUX86State *env,
>      limit_in_pages =3D (ldt_info.flags >> 4) & 1;
>      seg_not_present =3D (ldt_info.flags >> 5) & 1;
>      useable =3D (ldt_info.flags >> 6) & 1;
> -#ifdef TARGET_ABI32
> -    lm =3D 0;
> -#else
> -    lm =3D (ldt_info.flags >> 7) & 1;
> -#endif
>      if (contents =3D=3D 3) {
>          if (oldmode)
>              return -TARGET_EINVAL;
> @@ -6309,7 +6304,6 @@ static abi_long write_ldt(CPUX86State *env,
>          ((seg_not_present ^ 1) << 15) |
>          (seg_32bit << 22) |
>          (limit_in_pages << 23) |
> -        (lm << 21) |
>          0x7000;
>      if (!oldmode)
>          entry_2 |=3D (useable << 20);
> diff --git a/linux-user/x86_64/target_syscall.h b/linux-user/x86_64/targe=
t_syscall.h
> index 68f55f8..06f3af5 100644
> --- a/linux-user/x86_64/target_syscall.h
> +++ b/linux-user/x86_64/target_syscall.h
> @@ -17,7 +17,7 @@
>  #if 0 // Redefine this
>  struct target_modify_ldt_ldt_s {
>         unsigned int  entry_number;
> -        abi_ulong     base_addr;
> +        abi_uint      base_addr;
>         unsigned int  limit;
>         unsigned int  seg_32bit:1;
>         unsigned int  contents:2;
> @@ -30,7 +30,7 @@ struct target_modify_ldt_ldt_s {
>  #else
>  struct target_modify_ldt_ldt_s {
>         unsigned int  entry_number;
> -        abi_ulong     base_addr;
> +        abi_uint      base_addr;
>         unsigned int  limit;
>          unsigned int flags;
>  };
> diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
> index e7c3095..b68b219 100644
> --- a/tests/tcg/i386/meson.build
> +++ b/tests/tcg/i386/meson.build
> @@ -8,6 +8,7 @@ tests +=3D {
>    'hello-i386.c': {
>      'cflags': ['-ffreestanding', '-fno-stack-protector', '-nostdlib'],
>    },
> +  'modify-ldt.c': {},
>    'test-aes.c': {'cflags': ['-O1', '-msse2', '-maes']},
>    'test-i386-adcox.c': {'cflags': ['-O2']},
>    'test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
> diff --git a/tests/tcg/i386/modify-ldt.c b/tests/tcg/i386/modify-ldt.c
> new file mode 100644
> index 0000000..4bfa4ea
> --- /dev/null
> +++ b/tests/tcg/i386/modify-ldt.c
> @@ -0,0 +1,72 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#define _GNU_SOURCE
> +#include <asm/ldt.h>
> +#include <assert.h>
> +#include <errno.h>
> +#include <stdint.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +
> +static void check_entry(const struct user_desc *desc, int func,
> +                        uint64_t expected)
> +{
> +    uint64_t entries[2];
> +
> +    assert(syscall(SYS_modify_ldt, func, desc, sizeof(*desc)) =3D=3D 0);
> +    assert(syscall(SYS_modify_ldt, 0, entries, sizeof(entries)) =3D=3D
> +           sizeof(entries));
> +    /* Linux sets the accessed bit when installing a descriptor. */
> +    assert((entries[desc->entry_number] & ~(UINT64_C(1) << 40)) =3D=3D e=
xpected);
> +}
> +
> +int main(void)
> +{
> +    struct user_desc desc =3D {
> +        .entry_number =3D 1,
> +        .base_addr =3D 0x89abcdef,
> +        .limit =3D 0x54321,
> +        .seg_32bit =3D 1,
> +        .limit_in_pages =3D 1,
> +        .useable =3D 1,
> +    };
> +    const unsigned int invalid_sizes[] =3D {0, 15, 17, 24};
> +
> +    _Static_assert(sizeof(desc) =3D=3D 16, "modify_ldt user_desc must be=
 16 bytes");
> +    for (unsigned int i =3D 0;
> +         i < sizeof(invalid_sizes) / sizeof(invalid_sizes[0]); i++) {
> +        long ret =3D syscall(SYS_modify_ldt, 0x11, &desc, invalid_sizes[=
i]);
> +
> +        /* Linux returns int-sized errors; libc may have translated them=
. */
> +        assert((int)ret =3D=3D -EINVAL || (ret =3D=3D -1 && errno =3D=3D=
 EINVAL));
> +    }
> +    for (int func =3D 1; func <=3D 0x11; func +=3D 0x10) {
> +        for (int contents =3D MODIFY_LDT_CONTENTS_DATA;
> +             contents <=3D MODIFY_LDT_CONTENTS_CODE; contents +=3D 2) {
> +            uint64_t expected =3D UINT64_C(0x89c5f2abcdef4321);
> +
> +            desc.contents =3D contents;
> +            if (contents =3D=3D MODIFY_LDT_CONTENTS_CODE) {
> +                expected |=3D UINT64_C(1) << 43;
> +            }
> +            if (func =3D=3D 0x11) {
> +                expected |=3D UINT64_C(1) << 52;
> +            }
> +            check_entry(&desc, func, expected);
> +#ifdef __x86_64__
> +            desc.lm =3D 1;
> +            check_entry(&desc, func, expected);
> +            desc.lm =3D 0;
> +#endif
> +        }
> +    }
> +    desc =3D (struct user_desc) {
> +        .entry_number =3D 1,
> +        .read_exec_only =3D 1,
> +        .seg_not_present =3D 1,
> +    };
> +#ifdef __x86_64__
> +    desc.lm =3D 1;
> +#endif
> +    check_entry(&desc, 0x11, 0);
> +    return 0;
> +}
> diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
> index ad4d1f5..56f4e8a 100644
> --- a/tests/tcg/x86_64/meson.build
> +++ b/tests/tcg/x86_64/meson.build
> @@ -25,6 +25,7 @@ test_mmx_h =3D custom_target('test_mmx_h',
>                             output: 'test-mmx.h')
>
>  tests +=3D {
> +  '../i386/modify-ldt.c': {},
>    '../i386/test-i386-ssse3.c': {},
>    '../i386/test-3dnow.c': {
>      'cflags': ['-I', meson.current_build_dir(),
> --
> 2.55.0
>

