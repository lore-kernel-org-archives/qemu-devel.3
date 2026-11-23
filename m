Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E83606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=SkHLIQjk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVbb5-0003Qq-Sx; Mon, 23 Nov 2026 16:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xVbb3-0003PD-Tq
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 16:29:09 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xVbb0-0000hF-7z
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 16:29:08 -0500
DKIM2-Signature: i=1; m=1; t=1795469341; mf=PGRlbGxlckBnbXguZGU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=; d=gmx.de;
 s=s31663417:rsa-sha256:fnj4AVkQVT2L6V9qly6ftGOM2PPc
 CTnMhwUuyOUc9S5185sV1lfjyxi6YqM5VbywaYWkHQHavwmVZTo8vXcxBi9IORYYgekO0J53hhy
 x0eG9M4XkzdPQ/+gjJHV+JfLV6bq7GAJmfvAvJQKXzd81Q9AxZLv7JD0MlurqaWosskjTD/+/MN
 dii1G0nY4fxqI7iZHSUXaUTQUVp6E32kAIJoZTnVnwagWg2T+x+Nq5txKYl4BNMKggnwqD1b8Bb
 k52moO3H6x/AekAgaetoauuMAF0g3rN+fUC0oYQ20HJWfTyVmWPU3rMDPzoTTZ8qB6orJGIjzxK
 dAzO6wF1XKK0AQ==;
Message-Instance: m=1; h=sha256: rg6bcaX5DSXsruknrkJPwOTbhpbSrI3gLwNBHYVC8D8=:
 O3Qq7tqevCQPrEmZRUbrGml/EYIgnEaIr7GU0BEKFmA=, sha512:
 MZKoT4B443elAGf3c0+Adsny95SGaCB4xeLG9uKZFceOO5x1alfSA57vZCjjBJftLW2K4PptblDxCHRLQM/a5A==:
 F+hzOVoxodoH9EPYLOtT5NVegxC6ZxuDgpovd9/htO7tw0u6mFAcbQD/IB1sJqlDPMfUB035jjtJQM1GoNjRpA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795469337; x=1796074137; i=deller@gmx.de;
 bh=kZtnFsPFYVF0oHUMhQ5zzQcHNixhZwA9v5kXQypgO6A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SkHLIQjkIiwVOfm3FVle/MzhDN8FF+/azZiSJPGu8XW30FGKgIxFmURpfckhPDqw
 jbogdkLeoraVmx/6ijQtG7ILzeuQ5tYqzBUKv4B3Lo7Ic+6iOPd72gfgtk4oQ0XWP
 df8nqVbduyAGHw6uW5C72Q7h6fay6Mf+ZIPxrwMz5sj7ZbC9EJHkT8IhcUi8U5lkc
 +WF1fS0EWQ+uZL8ol6HD49j6CLShQHh4MnpHEdrZnMpdA52OiO840YKpyMg4g8lc+
 tciKvcXme+dwEUXWiWpTgA5pyuhpQO3wy14C28y9xHSIjc67+ivpq6sLKb79rnYoX
 NUgFGil9AbW5kgDIEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJmF-1yIdre1SYF-00o54B; Mon, 23
 Nov 2026 22:28:57 +0100
Message-ID: <6bae4653-e439-4d89-a285-8328965e8d2d@gmx.de>
Date: Mon, 23 Nov 2026 22:28:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/x86_64: fix modify_ldt ABI and lm handling
To: Artemii Mashanov <ralerrdirsardx@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20261027130613.113038-1-ralerrdirsardx@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261027130613.113038-1-ralerrdirsardx@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/dSA0n7xP5JaUaVF0taggqj+9RB4zrcDx3uemMavc6dWGYlYwQN
 BEst/AfgznISfjebz/7jL1cOE3rE82Jl6MskO6B4SZ1rPPp2wOU6M/SGC5Z4tZstkkSNiu9
 zF+23+bIrGBY07fR0pHmjQrRdh6Gin8bJpZH2QoyZBFWnT4hmsk3t6VOnM2zvLuVqzdvXEi
 5xk1Tb7uAA/vpT1NDp8sw==
UI-OutboundReport: notjunk:1;M01:P0:qV0TcbZxStA=;ZGAg45xNULD2FW9Tws2igCEQF70
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 14:06, Artemii Mashanov wrote:
> Linux uses a 16-byte user_desc on x86_64, with a 32-bit base_addr.
> QEMU expects 24 bytes instead and rejects valid modify_ldt writes.
>=20
> Use a 32-bit base_addr and swap it accordingly. Ignore lm when
> building LDT entries, matching Linux. Add a shared i386/x86_64
> regression test for the ABI size and descriptor contents.
>=20
> Based on the diagnosis and proposed fix by naehrwert in issue #4691.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4691
> Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>

Seems we missed to include this patch for 11.2.
I'm not an expert in this area, but the patch seems to be correct.
So I've now queued it up for qemu-v12.0, but still I'm happy to
include futher reviewed-by tags...

Helge

> ---
>   linux-user/syscall.c               | 10 +----
>   linux-user/x86_64/target_syscall.h |  4 +-
>   tests/tcg/i386/meson.build         |  1 +
>   tests/tcg/i386/modify-ldt.c        | 72 ++++++++++++++++++++++++++++++
>   tests/tcg/x86_64/meson.build       |  1 +
>   5 files changed, 78 insertions(+), 10 deletions(-)
>   create mode 100644 tests/tcg/i386/modify-ldt.c
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 0380691..a5d827b 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6237,7 +6237,7 @@ static abi_long write_ldt(CPUX86State *env,
>       struct target_modify_ldt_ldt_s ldt_info;
>       struct target_modify_ldt_ldt_s *target_ldt_info;
>       int seg_32bit, contents, read_exec_only, limit_in_pages;
> -    int seg_not_present, useable, lm;
> +    int seg_not_present, useable;
>       uint32_t *lp, entry_1, entry_2;
>  =20
>       if (bytecount !=3D sizeof(ldt_info))
> @@ -6245,7 +6245,7 @@ static abi_long write_ldt(CPUX86State *env,
>       if (!lock_user_struct(VERIFY_READ, target_ldt_info, ptr, 1))
>           return -TARGET_EFAULT;
>       ldt_info.entry_number =3D tswap32(target_ldt_info->entry_number);
> -    ldt_info.base_addr =3D tswapal(target_ldt_info->base_addr);
> +    ldt_info.base_addr =3D tswap32(target_ldt_info->base_addr);
>       ldt_info.limit =3D tswap32(target_ldt_info->limit);
>       ldt_info.flags =3D tswap32(target_ldt_info->flags);
>       unlock_user_struct(target_ldt_info, ptr, 0);
> @@ -6258,11 +6258,6 @@ static abi_long write_ldt(CPUX86State *env,
>       limit_in_pages =3D (ldt_info.flags >> 4) & 1;
>       seg_not_present =3D (ldt_info.flags >> 5) & 1;
>       useable =3D (ldt_info.flags >> 6) & 1;
> -#ifdef TARGET_ABI32
> -    lm =3D 0;
> -#else
> -    lm =3D (ldt_info.flags >> 7) & 1;
> -#endif
>       if (contents =3D=3D 3) {
>           if (oldmode)
>               return -TARGET_EINVAL;
> @@ -6309,7 +6304,6 @@ static abi_long write_ldt(CPUX86State *env,
>           ((seg_not_present ^ 1) << 15) |
>           (seg_32bit << 22) |
>           (limit_in_pages << 23) |
> -        (lm << 21) |
>           0x7000;
>       if (!oldmode)
>           entry_2 |=3D (useable << 20);
> diff --git a/linux-user/x86_64/target_syscall.h b/linux-user/x86_64/targ=
et_syscall.h
> index 68f55f8..06f3af5 100644
> --- a/linux-user/x86_64/target_syscall.h
> +++ b/linux-user/x86_64/target_syscall.h
> @@ -17,7 +17,7 @@
>   #if 0 // Redefine this
>   struct target_modify_ldt_ldt_s {
>   	unsigned int  entry_number;
> -        abi_ulong     base_addr;
> +        abi_uint      base_addr;
>   	unsigned int  limit;
>   	unsigned int  seg_32bit:1;
>   	unsigned int  contents:2;
> @@ -30,7 +30,7 @@ struct target_modify_ldt_ldt_s {
>   #else
>   struct target_modify_ldt_ldt_s {
>   	unsigned int  entry_number;
> -        abi_ulong     base_addr;
> +        abi_uint      base_addr;
>   	unsigned int  limit;
>           unsigned int flags;
>   };
> diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
> index e7c3095..b68b219 100644
> --- a/tests/tcg/i386/meson.build
> +++ b/tests/tcg/i386/meson.build
> @@ -8,6 +8,7 @@ tests +=3D {
>     'hello-i386.c': {
>       'cflags': ['-ffreestanding', '-fno-stack-protector', '-nostdlib'],
>     },
> +  'modify-ldt.c': {},
>     'test-aes.c': {'cflags': ['-O1', '-msse2', '-maes']},
>     'test-i386-adcox.c': {'cflags': ['-O2']},
>     'test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
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
> +    assert(syscall(SYS_modify_ldt, func, desc, sizeof(*desc)) =3D=3D 0)=
;
> +    assert(syscall(SYS_modify_ldt, 0, entries, sizeof(entries)) =3D=3D
> +           sizeof(entries));
> +    /* Linux sets the accessed bit when installing a descriptor. */
> +    assert((entries[desc->entry_number] & ~(UINT64_C(1) << 40)) =3D=3D =
expected);
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
> +    _Static_assert(sizeof(desc) =3D=3D 16, "modify_ldt user_desc must b=
e 16 bytes");
> +    for (unsigned int i =3D 0;
> +         i < sizeof(invalid_sizes) / sizeof(invalid_sizes[0]); i++) {
> +        long ret =3D syscall(SYS_modify_ldt, 0x11, &desc, invalid_sizes=
[i]);
> +
> +        /* Linux returns int-sized errors; libc may have translated the=
m. */
> +        assert((int)ret =3D=3D -EINVAL || (ret =3D=3D -1 && errno =3D=
=3D EINVAL));
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
>                              output: 'test-mmx.h')
>  =20
>   tests +=3D {
> +  '../i386/modify-ldt.c': {},
>     '../i386/test-i386-ssse3.c': {},
>     '../i386/test-3dnow.c': {
>       'cflags': ['-I', meson.current_build_dir(),


