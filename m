Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A55CD1283
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 06:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrAl0-00047J-St; Mon, 01 Apr 2024 02:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rrAkz-00046l-39; Mon, 01 Apr 2024 02:02:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rrAkx-0005vS-4Z; Mon, 01 Apr 2024 02:02:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0B4EA5AA5A;
 Mon,  1 Apr 2024 09:04:32 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2DB45A80D9;
 Mon,  1 Apr 2024 09:02:51 +0300 (MSK)
Message-ID: <2f0eefc5-8907-4af7-b717-17e17a9a3019@tls.msk.ru>
Date: Mon, 1 Apr 2024 09:02:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: fix direction of "32-bit MMU" test
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-stable@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
References: <20240311075806.668555-1-pbonzini@redhat.com>
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <20240311075806.668555-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

11.03.2024 10:58, Paolo Bonzini wrote:
> The low bit of MMU indices for x86 TCG indicates whether the processor is
> in 32-bit mode and therefore linear addresses have to be masked to 32 bits.
> However, the index was computed incorrectly, leading to possible conflicts
> in the TLB for any address above 4G.
> 
> Analyzed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Fixes: b1661801c18 ("target/i386: Fix physical address truncation", 2024-02-28)
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2206
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Anyone can guess why this rather trivial and obviously correct patch causes segfaults
in a few tests in staging-7.2 - when run in tcg mode, namely:

   pxe-test
   migration-test
   boot-serial-test
   bios-tables-test
   vmgenid-test
   cdrom-test

When reverting this single commit from staging-7.2, it all works fine again.

This area in 7.2 is a bit twisty since I picked up previous commit (for which
this one is a fix), b1661801c18 "target/i386: Fix physical address truncation",
before a few others in the same place, especially before 90f641531c782c8
"target/i386: use separate MMU indexes for 32-bit accesses", so that picking
up the other commits has become more problematic due to differences in context.
Also, 7.2 lacks ace0c5fe59 "target/i386: Populate CPUClass.mmu_index" which moves
one of the places this commit touches to another file.  Hopefully I haven't
screwed up this place entirely and the prob is just some other missing commit.

I'm re-verifying my cherry-picks once again. Meanwhile, help from someone who
is more familiar with this place is definitely welcome.

BTW, Paolo, it looks like this patch is missing two tags - Reviewed-by Richard
and Tested-by Mark.  It's obviously too late to change that now, but it's
something to check for in the future.

Thanks,

/mjt

> ---
>   target/i386/cpu.h | 2 +-
>   target/i386/cpu.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 952174bb6f5..6b057380791 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2334,7 +2334,7 @@ static inline bool is_mmu_index_32(int mmu_index)
>   
>   static inline int cpu_mmu_index_kernel(CPUX86State *env)
>   {
> -    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 1 : 0;
> +    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 0 : 1;
>       int mmu_index_base =
>           !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
>           ((env->hflags & HF_CPL_MASK) < 3 && (env->eflags & AC_MASK)) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 2666ef38089..78524bc6073 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7735,7 +7735,7 @@ static bool x86_cpu_has_work(CPUState *cs)
>   static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
>   {
>       CPUX86State *env = cpu_env(cs);
> -    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 1 : 0;
> +    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
>       int mmu_index_base =
>           (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER64_IDX :
>           !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :


