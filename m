Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3609C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 06:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrUtO-0007FJ-MI; Wed, 05 Aug 2026 02:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrUtL-0007ET-U1
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 02:14:15 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrUtI-0003Df-VM
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 02:14:15 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6756Dmwx024605
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 5 Aug 2026 15:13:48 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=CyKDyTaBz/2MJsdBp5tC8lNPN8llp7NKHn/ZufQuMsY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785910428; v=1;
 b=JmSklb0nO7sT+lSQ9rhlTXz10XOxmkcENpZ6kwKAZ+KqEiVZ69cR22O1ZhsgwuWn
 DiSY9cN++6W5GwXnYg+ynw5D4mjU+w8SK8X27+MblUVqHyqSLJboHrOyA+Zr/rNq
 MDmGq/IXjThFOvtzdq8uSWeCcu3WWpJz3v6iKKFbXKn3zcmuvp7/bXBFlNPK+8og
 pJojKfHHGngQdbglPKH+VYzGGW/6d8ETEfb84INYRg7mGqZ7DwNsWEjYroQhKiXZ
 NpNYJ/bWL2XKeatswzZFZWD5VQyoi+IqkBVh5ZAyRH91jBgPESY9Ar8Q8QUlCb07
 e8YjHl53VD9gbLL+AyTCZQ==
Message-ID: <2b220b6f-ed2e-42b4-9f25-a43721ed4753@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 5 Aug 2026 15:13:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dump: add crash_occurred flag to QEMUCPUState
To: =?UTF-8?B?5p2O5bOl5bWYKOadkeWPlCk=?= <zhengrong.lzr@alibaba-inc.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, viktor.prutyanov@phystech.edu, zhao1.liu@intel.com
References: <20260722014840.36671-1-zhengrong.lzr@alibaba-inc.com>
 <20260722014840.36671-2-zhengrong.lzr@alibaba-inc.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260722014840.36671-2-zhengrong.lzr@alibaba-inc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

On 2026/07/22 10:48, 李峥嵘(村叔) wrote:
> Add is_crash_occurred_cpu field to QEMUCPUState so that
> dump-guest-memory can record which CPU triggered the guest
> panic. Bump QEMUCPUSTATE_VERSION to 2.
> 
> The new field is appended after kernel_gs_base, so existing
> tools that check the 'size' field can safely ignore it when
> reading older dumps.

QEMUCPUSTATE_VERSION was not bumped with commit 46fac17dca19 ("dump: add 
kernel_gs_base to QEMU CPU state"), and tools just check the size. 
Probably there is no reason to bump it this time either.

> 
> Signed-off-by: Zhengrong Li <zhengrong.lzr@alibaba-inc.com>

docs/devel/code-provenance.rst says:
 > It is generally expected that the name and email addresses used in one
 > of the ``Signed-off-by`` lines, matches that of the git commit
 > ``Author`` field.
 > It's okay if you subscribe or contribute to the list via more than one
 > address, but using multiple addresses in one commit just confuses
 > things.

The "From" (which will be imported as the "Author" field when applying 
the patch) has Chinese characters while the Signed-off-by line has roman 
characters. Strictly speaking, they should be consistent.

> ---
>   contrib/elf2dmp/qemu_elf.h | 2 ++
>   target/i386/arch_dump.c    | 8 +++++++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
> index adc50238b4..3b28332e67 100644
> --- a/contrib/elf2dmp/qemu_elf.h
> +++ b/contrib/elf2dmp/qemu_elf.h
> @@ -27,6 +27,8 @@ typedef struct QEMUCPUState {
>       QEMUCPUSegment ldt, tr, gdt, idt;
>       uint64_t cr[5];
>       uint64_t kernel_gs_base;
> +    uint8_t  is_crash_occurred_cpu;
> +    uint8_t  pad[7];

Growing QEMUCPUState from 440 to 448 bytes confuses init_states() in 
contrib/elf2dmp/qemu_elf.c and makes valid version-1 notes and appear to 
lack kernel_gs_base, despite that field occupying bytes 432–439. Please 
update the function.

>   } QEMUCPUState;
>   
>   int is_system(QEMUCPUState *s);
> diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
> index 16e47c4747..f1c31984c5 100644
> --- a/target/i386/arch_dump.c
> +++ b/target/i386/arch_dump.c
> @@ -237,7 +237,7 @@ int x86_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>    * please count up QEMUCPUSTATE_VERSION if you have changed definition of
>    * QEMUCPUState, and modify the tools using this information accordingly.
>    */
> -#define QEMUCPUSTATE_VERSION (1)
> +#define QEMUCPUSTATE_VERSION (2)>
>   struct QEMUCPUSegment {
>       uint32_t selector;
> @@ -264,6 +264,8 @@ struct QEMUCPUState {
>        * by checking 'size' field.
>        */
>       uint64_t kernel_gs_base;
> +    uint8_t  is_crash_occurred_cpu;
> +    uint8_t  pad[7];
>   };
>   
>   typedef struct QEMUCPUState QEMUCPUState;
> @@ -279,6 +281,7 @@ static void copy_segment(QEMUCPUSegment *d, SegmentCache *s)
>   
>   static void qemu_get_cpustate(QEMUCPUState *s, CPUX86State *env)
>   {
> +    CPUState *cs = env_cpu(env);
>       memset(s, 0, sizeof(QEMUCPUState));
>   
>       s->version = QEMUCPUSTATE_VERSION;
> @@ -324,6 +327,9 @@ static void qemu_get_cpustate(QEMUCPUState *s, CPUX86State *env)
>   
>   #ifdef TARGET_X86_64
>       s->kernel_gs_base = env->kernelgsbase;
> +    if (cs->crash_occurred) {
> +        s->is_crash_occurred_cpu = 1;
> +    }

cs is declared unconditionally but used only under TARGET_X86_64.
make qemu-system-i386 fails with -Werror=unused-variable. Please Move it 
outside the #ifdef block if you don't have a reason not to do so.

Regards,
Akihiko Odaki

>   #endif
>   }
>   


