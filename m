Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF704CF6495
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 10:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suUs5-0005n9-C8; Sat, 28 Sep 2024 06:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1suUs2-0005lz-LJ
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 06:40:14 -0400
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1suUs0-0000Mr-Qc
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 06:40:14 -0400
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MQuwR-1sWU6g3FLT-00Jq0U; Sat, 28 Sep 2024 12:40:01 +0200
Message-ID: <09a456b8-b8e4-4cf4-af4b-bb79f7b1bfb5@vivier.eu>
Date: Sat, 28 Sep 2024 12:40:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] linux-user: add strace support for openat2
To: Michael Vogt <mvogt@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Vogt <michael.vogt@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <cover.1727119903.git.mvogt@redhat.com>
 <dba054de9c2285aa0908cae22ede2c082ed5af7c.1727119903.git.mvogt@redhat.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <dba054de9c2285aa0908cae22ede2c082ed5af7c.1727119903.git.mvogt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QpB4qgc7zZTD8GEUMz8XPG1Irx2PUxNhlBsNjZS1FPqNfv7loZP
 7noz5fzjd4Ut39ZMqEn9gUlPt/U9r5qto9+PZEDLTuxdleLyMIJXoSGQyH4s1MduCUHZ1fw
 Q9jkECuLWSnIEgxbuf0g+ingRycWvqwNrnDYf/anGai6epYsp3BEyNnB0xz31QoyHpFeBFl
 oAmtB8QWc8DLYVscJt4xw==
UI-OutboundReport: notjunk:1;M01:P0:vVNyz16ZyOU=;EgF+7bUtwCzeAOpwn85tlwUkPDd
 HeV1JqvWHKx5S5Vl+QwcWzMy1T3uAG14xdSjogr9Fe43sNkN4BkjfnK9USEWAJrTd4A5eAPNh
 Jqukk7c5Ohfpyx57YAQjENcS4xGcjlWHpe1SRcJXpkViyy/oq8/4zD/cfZ1o0dzCGBVgLaOPM
 LNiA/yLYc1hFXc5QibENUHX9nP2z0rTSeBvXR2DxqjrltohCupLuyAXPi7QCl/jY+8bavPpbB
 jAmd3xol7+i56CHL1DIyM1cUVIJL0q7cDB0Lnj+NO6FWii1pxlbPclIkYfma/7dc1y85g/J6q
 oqmakNHy5hYVeukEoOak1dT2epfeoO9aqiOgf9f7BucbRi4kk5BaNirZRr9zrU30UdoJ+3u2f
 UWnDH1o5i/33GupeHFg9ylMw13QDIgCfgSiCzbdQ5o3SVQZpPBAC8ePFKMuEJad4KC96KeFd7
 /g2XfWAf2KOtIQ3K8nY0Adz5XVnRhJQyK5ghquugQncsauB8+hy7bZzKhIu6pTehczbHV/K+0
 Kw+s0Gj1CSP5Mky4RtYpGvabmoDpVIS2+PJwXVzixHWeTrL09Ykg487aMMtY969G3r6ZmDD7H
 mMltCL8AohCqIZ7IEovewrBQIhRTYLtjqBYs1GCOrrmM4zi10kGabmVu+S2oSRPvn9W1Wco4Q
 fplQXHG4AUAmvzg4bJaWwhveP4zdiTyzi//NRCSdmlKZ0kiiUllIorG6ePYCInY3OITPpAuj/
 LvTcWt1mbhTMyqVbpJ8uCqwJ+bGep29og==
Received-SPF: pass client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Le 23/09/2024 à 21:37, Michael Vogt a écrit :
> This commit adds support for the `openat2()` to `QEMU_STRACE`. It
> will use the `openat2.h` header if available to create user
> readable flags for the `resolve` argument but does not require
> the header otherwise.
> 
> It also makes `copy_struct_from_user()` available via `qemu.h`
> and `open_how_ver0` via `syscall_defs.h` so that strace.c can use
> them.
> 
> Signed-off-by: Michael Vogt <mvogt@redhat.com>
> ---
>   linux-user/qemu.h         |  9 +++++++++
>   linux-user/strace.c       | 40 +++++++++++++++++++++++++++++++++++++++
>   linux-user/strace.list    |  3 +++
>   linux-user/syscall.c      |  8 +-------
>   linux-user/syscall_defs.h |  5 +++++
>   meson.build               |  1 +
>   6 files changed, 59 insertions(+), 7 deletions(-)
> 
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 2e90a97175..98ad848ab2 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -313,6 +313,15 @@ static inline bool access_ok(CPUState *cpu, int type,
>   int copy_from_user(void *hptr, abi_ulong gaddr, ssize_t len);
>   int copy_to_user(abi_ulong gaddr, void *hptr, ssize_t len);
>   
> +/*
> + * copy_struct_from_user() copies a target struct to a host struct, in
> + * a way that guarantees backwards-compatibility for struct syscall
> + * arguments.
> + *
> + * Similar to kernels uaccess.h:copy_struct_from_user()
> + */
> +int copy_struct_from_user(void *dst, size_t ksize, abi_ptr src, size_t usize);
> +
>   /* Functions for accessing guest memory.  The tget and tput functions
>      read/write single values, byteswapping as necessary.  The lock_user function
>      gets a pointer to a contiguous area of guest memory, but does not perform
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index b4d1098170..77d5108e5d 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -13,6 +13,9 @@
>   #include <linux/if_packet.h>
>   #include <linux/in6.h>
>   #include <linux/netlink.h>
> +#ifdef HAVE_OPENAT2_H
> +#include <linux/openat2.h>
> +#endif
>   #include <sched.h>
>   #include "qemu.h"
>   #include "user-internals.h"
> @@ -1063,6 +1066,18 @@ UNUSED static const struct flags open_flags[] = {
>       FLAG_END,
>   };
>   
> +UNUSED static const struct flags openat2_resolve_flags[] = {
> +#ifdef HAVE_OPENAT2_H
> +    FLAG_GENERIC(RESOLVE_NO_XDEV),
> +    FLAG_GENERIC(RESOLVE_NO_MAGICLINKS),
> +    FLAG_GENERIC(RESOLVE_NO_SYMLINKS),
> +    FLAG_GENERIC(RESOLVE_BENEATH),
> +    FLAG_GENERIC(RESOLVE_IN_ROOT),
> +    FLAG_GENERIC(RESOLVE_CACHED),
> +#endif
> +    FLAG_END,
> +};
> +
>   UNUSED static const struct flags mount_flags[] = {
>   #ifdef MS_BIND
>       FLAG_GENERIC(MS_BIND),
> @@ -3483,6 +3498,31 @@ print_openat(CPUArchState *cpu_env, const struct syscallname *name,
>   }
>   #endif
>   
> +#ifdef TARGET_NR_openat2
> +static void
> +print_openat2(CPUArchState *cpu_env, const struct syscallname *name,
> +              abi_long arg0, abi_long arg1, abi_long arg2,
> +              abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    struct open_how_ver0 how = {0};
> +
> +    print_syscall_prologue(name);
> +    print_at_dirfd(arg0, 0);
> +    print_string(arg1, 0);
> +    if (copy_struct_from_user(&how, sizeof(how), arg2, arg3) == 0) {

I think you need also to tswap64() all the fields of how.

> +        print_open_flags(how.flags, 0);
> +        if (how.flags & TARGET_O_CREAT) {
> +            print_file_mode(how.mode, 0);
> +        }
> +        print_flags(openat2_resolve_flags, how.resolve, 0);
> +    } else {
> +        print_pointer(arg2, 0);
> +    }
> +    print_raw_param("size=" TARGET_ABI_FMT_lu, arg3, 1);

Why the "size="?
You can write: print_raw_param(TARGET_ABI_FMT_lu, arg3, 1);

Thanks,
Laurent

