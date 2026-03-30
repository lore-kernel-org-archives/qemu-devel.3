Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BBDFC97F3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ED4-00047O-P8; Mon, 30 Mar 2026 11:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1w7ECv-00046p-OE; Mon, 30 Mar 2026 11:07:13 -0400
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1w7ECq-00087l-Oy; Mon, 30 Mar 2026 11:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1774883226; x=1775488026; i=laurent@vivier.eu;
 bh=kQ5954plKxBBKQ3q3RjNNNB0TMx0FHMLAJvX6Jzsc4Y=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OjY7YTZcVRxCWU0nNlXvGZbFRPdNtzRmrDPKgt4XpWL8HgxW9qiUoPrzIFbTYyjI
 W6T95JnJoXg4tE9jBPAFQd27ihl+ojnJ7Ju2v0KdR7608ZrIH8pWEjzvNCQWgTJ0i
 /XzUbWbq5T/RZtcOyM7E6AyTOHJZBxqgLwD01tiYHAaKQq+JKoOX2Qabid1FnCkjD
 psLWB9YdF4B+wfNE1VpMsgu2CqQxajZecXv8/w7TojlPQ5aL+NV5NPywwuoamjJrx
 UNjHqd/9HDleP8RHcoAOGAgvN4EpgMWExM4sFP9mCcRL6OMNnFPzrtdv5Iw5d9Lus
 qkxaFizocWgDkfArPw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [212.227.17.165]) with ESMTPSA (Nemesis) id 1N2lzA-1vO6qM1U20-014xMP; Mon, 30
 Mar 2026 17:07:06 +0200
Message-ID: <0fa506d4-8031-48c4-ba72-533c05322f96@vivier.eu>
Date: Mon, 30 Mar 2026 17:07:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] include/user/guest-host.h: Provide g2h etc for both
 abi_ptr and vaddr
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260330143123.1685142-1-peter.maydell@linaro.org>
 <20260330143123.1685142-3-peter.maydell@linaro.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20260330143123.1685142-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lwG/i6Uz5vwcsDo++QdkGgeLt9Hc9YsIqrm7wNaYESwIO/e8lU2
 9McShQUeyUDOaupD478JUxEJguGtUaTLwlWEovR8PCXOcy/KCS7rBLN8nBvobfuSBLI6gDM
 J4uMr/eWFK3E6/XjFzJJkKArQiYz0UnPsD0QYjsa454mN6DVV3+HjR8douKMHQ7oC/nuNK/
 EhQj2abVJL2e9zTL54Crw==
UI-OutboundReport: notjunk:1;M01:P0:A7lCcRC3R2A=;tVNn0kMXXYhmmwsMPkAgKPYTm4Y
 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
 0QB6EqO4juoxWcacgFeuPsO3qjWlA=
Received-SPF: pass client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Le 30/03/2026 =C3=A0 16:31, Peter Maydell a =C3=A9crit=C2=A0:
> In commit 7804c84a ("include/user: Use vaddr in guest-host.h") we
> changed all the functions in guest-host.h that took or returned their
> guest address argument in type abi_ptr to instead use vaddr.
>=20
> This introduced regressions for the case of a 32-bit guest and an
> address above 2GB for the common situation where the address is a
> syscall argument stored in a variable of type 'abi_long'.  With
> abi_ptr (which will be an unsigned 32-bit type for 32-bit guests),
> the address is cast to unsigned 32-bit, and then zero-extended to
> 64-bits in g2h_untagged_vaddr().  With the switch to vaddr (which is
> always a 64-bit unsigned type), the guest address will instead be
> sign-extended to 64 bits, which gives the wrong answer.
>=20
> Fix this by providing two versions of the affected functions: the
> standard names (g2h(), g2h_untagged(), guest_addr_valid_untagged(),
> guest_range_valid_untagged(), cpu_untagged_addr()) return to using
> the logically-correct abi_ptr type; new versions with a _vaddr()
> prefix use the vaddr type.
>=20
> accel/tcg/user-exec.c must change to use the _vaddr() versions; this
> is the only file that uses guest-host.h that we want to compile once.
> All the other uses are in linux-user and bsd-user code that
> inherently has to know the sizes of target-ABI types.
>=20
> Cc: qemu-stable@nongnu.org
> Fixes: 7804c84a ("include/user: Use vaddr in guest-host.h")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3333
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   accel/tcg/user-exec.c     | 26 ++++++++--------
>   include/user/guest-host.h | 62 +++++++++++++++++++++++++++++++++++----
>   2 files changed, 69 insertions(+), 19 deletions(-)
>=20
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index f8b4a26711..d283d3cc72 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -647,7 +647,7 @@ void tb_lock_page0(tb_page_addr_t address)
>  =20
>       if (prot & PAGE_WRITE) {
>           pageflags_set_clear(start, last, 0, PAGE_WRITE);
> -        mprotect(g2h_untagged(start), last - start + 1,
> +        mprotect(g2h_untagged_vaddr(start), last - start + 1,
>                    prot & (PAGE_READ | PAGE_EXEC) ? PROT_READ : PROT_NON=
E);
>       }
>   }
> @@ -734,7 +734,7 @@ int page_unprotect(CPUState *cpu, tb_page_addr_t add=
ress, uintptr_t pc)
>           if (prot & PAGE_EXEC) {
>               prot =3D (prot & ~PAGE_EXEC) | PAGE_READ;
>           }
> -        mprotect((void *)g2h_untagged(start), len, prot & PAGE_RWX);
> +        mprotect((void *)g2h_untagged_vaddr(start), len, prot & PAGE_RW=
X);
>       }
>       mmap_unlock();
>  =20
> @@ -763,7 +763,7 @@ static int probe_access_internal(CPUArchState *env, =
vaddr addr,
>           g_assert_not_reached();
>       }
>  =20
> -    if (guest_addr_valid_untagged(addr)) {
> +    if (guest_addr_valid_untagged_vaddr(addr)) {
>           int page_flags =3D page_get_flags(addr);
>           if (page_flags & acc_flag) {
>               if (access_type !=3D MMU_INST_FETCH
> @@ -792,7 +792,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr=
, int size,
>  =20
>       g_assert(-(addr | TARGET_PAGE_MASK) >=3D size);
>       flags =3D probe_access_internal(env, addr, size, access_type, nonf=
ault, ra);
> -    *phost =3D (flags & TLB_INVALID_MASK) ? NULL : g2h(env_cpu(env), ad=
dr);
> +    *phost =3D (flags & TLB_INVALID_MASK) ? NULL : g2h_vaddr(env_cpu(en=
v), addr);
>       return flags;
>   }
>  =20
> @@ -805,13 +805,13 @@ void *probe_access(CPUArchState *env, vaddr addr, =
int size,
>       flags =3D probe_access_internal(env, addr, size, access_type, fals=
e, ra);
>       g_assert((flags & ~TLB_MMIO) =3D=3D 0);
>  =20
> -    return size ? g2h(env_cpu(env), addr) : NULL;
> +    return size ? g2h_vaddr(env_cpu(env), addr) : NULL;
>   }
>  =20
>   void *tlb_vaddr_to_host(CPUArchState *env, vaddr addr,
>                           MMUAccessType access_type, int mmu_idx)
>   {
> -    return g2h(env_cpu(env), addr);
> +    return g2h_vaddr(env_cpu(env), addr);
>   }
>  =20
>   tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
> @@ -822,7 +822,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState=
 *env, vaddr addr,
>       flags =3D probe_access_internal(env, addr, 1, MMU_INST_FETCH, fals=
e, 0);
>       g_assert(flags =3D=3D 0);
>  =20
> -    *hostp =3D g2h_untagged(addr);
> +    *hostp =3D g2h_untagged_vaddr(addr);
>       return addr;
>   }
>  =20
> @@ -938,7 +938,7 @@ static void *cpu_mmu_lookup(CPUState *cpu, vaddr add=
r,
>           cpu_loop_exit_sigbus(cpu, addr, type, ra);
>       }
>  =20
> -    ret =3D g2h(cpu, addr);
> +    ret =3D g2h_vaddr(cpu, addr);
>       set_helper_retaddr(ra);
>       return ret;
>   }
> @@ -968,7 +968,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>           }
>           if (is_write) {
>               if (flags & PAGE_WRITE) {
> -                memcpy(g2h(cpu, addr), buf, l);
> +                memcpy(g2h_vaddr(cpu, addr), buf, l);
>               } else {
>                   /* Bypass the host page protection using ptrace. */
>                   if (fd =3D=3D -1) {
> @@ -987,13 +987,13 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>                    */
>                   tb_invalidate_phys_range(NULL, addr, addr + l - 1);
>                   written =3D pwrite(fd, buf, l,
> -                                 (off_t)(uintptr_t)g2h_untagged(addr));
> +                                 (off_t)(uintptr_t)g2h_untagged_vaddr(a=
ddr));
>                   if (written !=3D l) {
>                       goto out_close;
>                   }
>               }
>           } else if (flags & PAGE_READ) {
> -            memcpy(buf, g2h(cpu, addr), l);
> +            memcpy(buf, g2h_vaddr(cpu, addr), l);
>           } else {
>               /* Bypass the host page protection using ptrace. */
>               if (fd =3D=3D -1) {
> @@ -1003,7 +1003,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>                   }
>               }
>               if (pread(fd, buf, l,
> -                      (off_t)(uintptr_t)g2h_untagged(addr)) !=3D l) {
> +                      (off_t)(uintptr_t)g2h_untagged_vaddr(addr)) !=3D =
l) {
>                   goto out_close;
>               }
>           }
> @@ -1231,7 +1231,7 @@ static void *atomic_mmu_lookup(CPUState *cpu, vadd=
r addr, MemOpIdx oi,
>           cpu_loop_exit_atomic(cpu, retaddr);
>       }
>  =20
> -    ret =3D g2h(cpu, addr);
> +    ret =3D g2h_vaddr(cpu, addr);
>       set_helper_retaddr(retaddr);
>       return ret;
>   }
> diff --git a/include/user/guest-host.h b/include/user/guest-host.h
> index 8f7ef75896..ef83ad8a18 100644
> --- a/include/user/guest-host.h
> +++ b/include/user/guest-host.h
> @@ -29,7 +29,12 @@ extern unsigned long reserved_va;
>    */
>   extern unsigned long guest_addr_max;
>  =20
> -static inline vaddr cpu_untagged_addr(CPUState *cs, vaddr x)
> +/*
> + * These functions take the guest virtual address as a vaddr,
> + * and are suitable for use from target-independent code.
> + */
> +
> +static inline vaddr cpu_untagged_addr_vaddr(CPUState *cs, vaddr x)
>   {
>       const TCGCPUOps *tcg_ops =3D cs->cc->tcg_ops;
>       if (tcg_ops->untagged_addr) {
> @@ -39,22 +44,22 @@ static inline vaddr cpu_untagged_addr(CPUState *cs, =
vaddr x)
>   }
>  =20
>   /* All direct uses of g2h and h2g need to go away for usermode softmmu=
.  */
> -static inline void *g2h_untagged(vaddr x)
> +static inline void *g2h_untagged_vaddr(vaddr x)
>   {
>       return (void *)((uintptr_t)(x) + guest_base);
>   }
>  =20
> -static inline void *g2h(CPUState *cs, vaddr x)
> +static inline void *g2h_vaddr(CPUState *cs, vaddr x)
>   {
> -    return g2h_untagged(cpu_untagged_addr(cs, x));
> +    return g2h_untagged_vaddr(cpu_untagged_addr_vaddr(cs, x));
>   }
>  =20
> -static inline bool guest_addr_valid_untagged(vaddr x)
> +static inline bool guest_addr_valid_untagged_vaddr(vaddr x)
>   {
>       return x <=3D guest_addr_max;
>   }
>  =20
> -static inline bool guest_range_valid_untagged(vaddr start, vaddr len)
> +static inline bool guest_range_valid_untagged_vaddr(vaddr start, vaddr =
len)
>   {
>       return len - 1 <=3D guest_addr_max && start <=3D guest_addr_max - =
len + 1;
>   }
> @@ -73,4 +78,49 @@ static inline bool guest_range_valid_untagged(vaddr s=
tart, vaddr len)
>       h2g_nocheck(x); \
>   })
>  =20
> +#ifdef COMPILING_PER_TARGET
> +
> +/*
> + * These functions take the guest virtual address as an abi_ptr.  This
> + * is an important difference from a vaddr for the common case where
> + * the address is a syscall argument in a variable of type abi_long,
> + * which may be smaller than the vaddr type. If you pass an address in
> + * an abi_long to these functions then the value will be converted to
> + * an unsigned type and then zero extended to give the vaddr. If you
> + * use the g2h_vaddr() and similar functions which take an argument of
> + * type vaddr, then the value will be sign-extended, giving the wrong
> + * answer for addresses above the 2GB mark on 32-bit guests.
> + *
> + * Providing these functions with their traditional QEMU semantics is
> + * less bug-prone than requiring many callsites to remember to cast
> + * their abi_long variable to an abi_ptr before calling.
> + */
> +
> +static inline void *g2h(CPUState *cs, abi_ptr x)
> +{
> +    return g2h_vaddr(cs, x);
> +}
> +
> +static inline void *g2h_untagged(abi_ptr x)
> +{
> +    return g2h_untagged_vaddr(x);
> +}
> +
> +static inline bool guest_addr_valid_untagged(abi_ptr x)
> +{
> +    return guest_addr_valid_untagged_vaddr(x);
> +}
> +
> +static inline bool guest_range_valid_untagged(abi_ptr start, abi_ptr le=
n)
> +{
> +    return guest_range_valid_untagged_vaddr(start, len);
> +}
> +
> +static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
> +{
> +    return cpu_untagged_addr_vaddr(cs, x);
> +}
> +
> +#endif
> +
>   #endif


Reviewed-by: Laurent Vivier <laurent@vivier.eu>

