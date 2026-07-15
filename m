Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EEDC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 11:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjxf2-0007WP-6u; Wed, 15 Jul 2026 07:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wjxf0-0007WB-2J; Wed, 15 Jul 2026 07:20:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wjxew-0000uT-DL; Wed, 15 Jul 2026 07:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784114392; bh=CkT4bJbwyMRx4pBtmw+8uKuYm01KqZ1lc9q0lSaydqM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=gofcfqhmosmsUZyjjBZFUkbqyNC8z7Zt4s/y8tZ/qvxZPbQRd8yegRER5xKXvuOo1
 s1fX0tLVJ+kPd0ywFi54QQ4ENhvVL/yTJMctbLT9pfwVRS1yUBFe8YN5rIhlvD05z2
 xUxYRwOFwwYQEL5sLzFbdR1qIo8DDucSf+YOPSAw6esL5fKDMeIen0jX5drdW4tBit
 zTEYPp6ksV/bUUlP4hbQHDEKMgZyh+LFPf7z/fQdJgp/jDU/+xO9HdgiOjbK++FItc
 8GARdoSurKmAr5jwRw/XM3NN5LJC4nugCrWk9kElLIim3Sq73q1jXPT9Rg2vzs9eZa
 C/IBhOh/i9BAA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AB7131C1D5B;
 Wed, 15 Jul 2026 14:19:52 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0249B3EF2C0;
 Wed, 15 Jul 2026 14:19:55 +0300 (MSK)
Message-ID: <bd5e479f-8ed7-405f-b38f-bd73f4990321@tls.msk.ru>
Date: Wed, 15 Jul 2026 14:19:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/alpha: add coredump support
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20260525215308.44096-1-mattst88@gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260525215308.44096-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/26/26 00:53, Matt Turner wrote:
> Define HAVE_ELF_CORE_DUMP and target_elf_gregset_t in target_elf.h,
> mirroring the kernel's elf_gregset_t (ELF_NGREG = 66): r0-r31
> [0..31], f0-f31 [32..63], pc [64], ps [65].  Implement
> elf_core_copy_regs() in elfload.c to populate the gregset from
> CPUAlphaState.
> 
> Without this, bprm->core_dump is NULL for Alpha targets.  When a
> guest signal goes unhandled, dump_core_and_abort() skips the core
> write and falls through to die_with_signal(), which re-raises the
> signal to the host.  The host kernel then writes an x86-64 core file
> for the qemu-alpha process instead of an Alpha guest core.

I'm picking this change up for currently active qemu stable series
(10.0.x and 11.0.x).  While it is not a bugfix per se, but a lack
of feature which can be very useful for debugging.

For 11.0.x, picking up this patch makes subsequent patches in this area
to apply cleanly (e.g. 7a2e863f9dd "populate AT_HWCAP from env->amask").

For 10.0.x, where things are quite a bit different, both mentioned
changes require manual apply, since in there, things are in different
place (in linux-user/elfload.c) and organized a bit differently
(HAVE_ELF_CORE_DUMP vs USE_ELF_CORE_DUMP).  But since I picked this
one for 11.0.x, and since 10.0.x is an LTS series, I'm picking it for
10.0.x anyway.

The result can be seen here:
  https://gitlab.com/mjt0k/qemu/-/commit/bb9f5a3bbc2f06fba918432b40b56e5aeb2b3c76

Hopefully I did the back-port correctly.  It would be nice to have
another view on the result.

Thanks,

/mjt

> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   linux-user/alpha/elfload.c    | 12 ++++++++++++
>   linux-user/alpha/target_elf.h | 13 +++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git ./linux-user/alpha/elfload.c ./linux-user/alpha/elfload.c
> index 1e44475c47..c86f9cf2bb 100644
> --- ./linux-user/alpha/elfload.c
> +++ ./linux-user/alpha/elfload.c
> @@ -3,8 +3,20 @@
>   #include "qemu/osdep.h"
>   #include "qemu.h"
>   #include "loader.h"
> +#include "target_elf.h"
>   
>   
> +void elf_core_copy_regs(target_elf_gregset_t *r, const CPUAlphaState *env)
> +{
> +    int i;
> +
> +    for (i = 0; i < 31; i++) {
> +        r->regs[i] = tswap64(env->ir[i]);
> +    }
> +    r->pc = tswap64(env->pc);
> +    r->ps = 0;
> +}
> +
>   const char *get_elf_cpu_model(uint32_t eflags)
>   {
>       return "ev67";
> diff --git ./linux-user/alpha/target_elf.h ./linux-user/alpha/target_elf.h
> index 864dc6e2e6..bf3bd21b09 100644
> --- ./linux-user/alpha/target_elf.h
> +++ ./linux-user/alpha/target_elf.h
> @@ -11,4 +11,17 @@
>   #define ELF_CLASS               ELFCLASS64
>   #define ELF_MACHINE             EM_ALPHA
>   
> +#define HAVE_ELF_CORE_DUMP      1
> +
> +/*
> + * Matches the kernel's elf_gregset_t (ELF_NGREG = 33):
> + *   r0-r30 at indices 0-30, pc at 31, ps at 32.
> + * r31 (hardwired zero) is not stored; pc occupies index 31.
> + */
> +typedef struct target_elf_gregset_t {
> +    abi_ulong regs[31];  /* integer registers r0-r30  [0..30] */
> +    abi_ulong pc;        /* program counter           [31]    */
> +    abi_ulong ps;        /* processor status          [32]    */
> +} target_elf_gregset_t;
> +
>   #endif


