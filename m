Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C22DC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 21:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sReYX-0003na-BS; Wed, 10 Jul 2024 17:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sReYV-0003mn-0R
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 17:08:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sReYP-00051M-U1
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 17:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720645724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PiCbPNRVzgqwrnORo/RtJhCR4kBC1pw1pKiWH3RgxyM=;
 b=NRA27LEsXYHCUpQnxkgTkl+F9URIdTdrF8lmXU94r46zumvGcKVUZgYBkPvJMSB3pX7K7U
 S1dwXsdQ2oo7Yytc9qpV2pAK7oHjPTN6aRiUIp2ng5hl5t0Bbd7rWzQyNNDygFZo/P4d0v
 J+jfzTlCrAPXnRs9r536E06FKKVn7ak=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-XZdFQQJdNomL4wShGQaP6g-1; Wed, 10 Jul 2024 17:08:42 -0400
X-MC-Unique: XZdFQQJdNomL4wShGQaP6g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36789d3603aso35422f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 14:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720645721; x=1721250521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PiCbPNRVzgqwrnORo/RtJhCR4kBC1pw1pKiWH3RgxyM=;
 b=HL2pJCFhKHipGO2f4Kiq9gF1Z/ub1auKg6bh3tU43X84RC8a+4hf8FVjLJXm/DrWbC
 mpuL7GuMA0u3o9pWTU9Dq2tvY6x+KWsGZAQHUejqz7bpjCVhQDQdYsRLoEGwxpSfVzpu
 Y/m0rkie3USzmEs+YdeWD/2k2fKISpRwJHzbFNR/Lx4IfV+gVUUNxm/0mXSirAPo4uiG
 mfugB/FwZpZ398AeGwfCsPIrVX1bSCOZH3N/74YfllBEq0mlIBz1fFZdt1aPixRRhTif
 ME4L4ET47XuKUPhhkfjxTNNDhYIm9GmXRmLr548T8Xdle73N0ukeE6wDHM0hgoqNtQXd
 E5eQ==
X-Gm-Message-State: AOJu0YyQax+Y3zMDjn8OgdpYuhMZ3Fpre8cblWXlRpx2kowrkDr7CSPf
 AumxO9RZJ4Sb1GCaXnBdMqHaGgs5PKz0hUBCaPmDAq986GPewsJAo/pgWwhEGVIn6oTu72atMZB
 lALxaTlh97hj3Ck4kI+L67dZYZLjucm32pu8PO9J1IcnrdgXVsQVSlFruXHpQWhlAUBKxoAA6z4
 ku7WeyqD5UsfOz5TWsQ/tjtwVcMEk=
X-Received: by 2002:a5d:43cd:0:b0:367:9801:9c5b with SMTP id
 ffacd0b85a97d-367ceacb4f6mr5055537f8f.50.1720645721518; 
 Wed, 10 Jul 2024 14:08:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRd36lCTaaXmH4o/DaRHx/8k2o1cf+Gkm5bfsEjHXipqcj547vMc3DiYsrgVELknEHeIzx8qcWzNTermaooPM=
X-Received: by 2002:a5d:43cd:0:b0:367:9801:9c5b with SMTP id
 ffacd0b85a97d-367ceacb4f6mr5055528f8f.50.1720645721150; Wed, 10 Jul 2024
 14:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240710062920.73063-1-pbonzini@redhat.com>
 <CAEYr_8kbN6U3wUntTK_kCBQ4fHRsWhjbQBFiX0V0PS6qXfyECA@mail.gmail.com>
In-Reply-To: <CAEYr_8kbN6U3wUntTK_kCBQ4fHRsWhjbQBFiX0V0PS6qXfyECA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 10 Jul 2024 23:08:28 +0200
Message-ID: <CABgObfa_fBmPDMuWpdcb6PxAD71sheogwrG6YwO8wrGZr-GNuA@mail.gmail.com>
Subject: Re: [PATCH 00/10] target/i386/tcg: fixes for seg_helper.c
To: Robert Henry <rrh.henry@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000fe7506061ceb0c64"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000fe7506061ceb0c64
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 10 lug 2024, 23:01 Robert Henry <rrh.henry@gmail.com> ha scritto:

> I have only skimmed the diffs.  Your knowledge of the deep semantics,
> gained by close differential reading of intel and amd docs, is truly
> amazing.  Many thanks for pushing this through!
>

Thanks for bringing this to our attention too, apart from the practical bug
hopefully it will help future readers to have a more precise implementation=
.

I tried to acknowledge your contribution in the commit messages.

I have 2 nits, perhaps stylistic only.
>
> For code like "sp -=3D 2" or "sp +=3D 2" followed or preceded by a write =
to
> the stack pointer of a uint16_t variable 'x',  would it be better/more
> robust to rewrite as: "sp -=3D sizeof(x)"  ?
>

I think that's intentional because the value subtracted is related to the
"stw" or "stl" in the store (likewise for incrementing after a load) more
than to the size of x.

There are a lot of masks constructed using -1.  I think it would be clearer
> to use 0xffffffff (for 32-bit masks) as that reminds the reader that this
> is a bit mask.  But it seems that using -1 is how the original code was
> written.
>

-1 is used for 64-bit masks only. They get unwieldy quickly. :)

Paolo


> On Tue, Jul 9, 2024 at 11:29=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
>
>> This includes bugfixes:
>> - allowing IRET from user mode to user mode with SMAP (do not use implic=
it
>>   kernel accesses, which break if the stack is in userspace)
>>
>> - use DPL-level accesses for interrupts and call gates
>>
>> - various fixes for task switching
>>
>> And two related cleanups: computing MMU index once for far calls and
>> returns
>> (including task switches), and using X86Access for TSS access.
>>
>> Tested with a really ugly patch to kvm-unit-tests, included after
>> signature.
>>
>> Paolo Bonzini (7):
>>   target/i386/tcg: Allow IRET from user mode to user mode with SMAP
>>   target/i386/tcg: use PUSHL/PUSHW for error code
>>   target/i386/tcg: Compute MMU index once
>>   target/i386/tcg: Use DPL-level accesses for interrupts and call gates
>>   target/i386/tcg: check for correct busy state before switching to a
>>     new task
>>   target/i386/tcg: use X86Access for TSS access
>>   target/i386/tcg: save current task state before loading new one
>>
>> Richard Henderson (3):
>>   target/i386/tcg: Remove SEG_ADDL
>>   target/i386/tcg: Reorg push/pop within seg_helper.c
>>   target/i386/tcg: Introduce x86_mmu_index_{kernel_,}pl
>>
>>  target/i386/cpu.h            |  11 +-
>>  target/i386/cpu.c            |  27 +-
>>  target/i386/tcg/seg_helper.c | 606 +++++++++++++++++++----------------
>>  3 files changed, 354 insertions(+), 290 deletions(-)
>>
>> --
>> 2.45.2
>>
>> diff --git a/lib/x86/usermode.c b/lib/x86/usermode.c
>> index c3ec0ad7..0bf40c6d 100644
>> --- a/lib/x86/usermode.c
>> +++ b/lib/x86/usermode.c
>> @@ -5,13 +5,15 @@
>>  #include "x86/desc.h"
>>  #include "x86/isr.h"
>>  #include "alloc.h"
>> +#include "alloc_page.h"
>>  #include "setjmp.h"
>>  #include "usermode.h"
>>
>>  #include "libcflat.h"
>>  #include <stdint.h>
>>
>> -#define USERMODE_STACK_SIZE    0x2000
>> +#define USERMODE_STACK_ORDER   1 /* 8k */
>> +#define USERMODE_STACK_SIZE    (1 << (12 + USERMODE_STACK_ORDER))
>>  #define RET_TO_KERNEL_IRQ      0x20
>>
>>  static jmp_buf jmpbuf;
>> @@ -37,9 +39,14 @@ uint64_t run_in_user(usermode_func func, unsigned int
>> fault_vector,
>>  {
>>         extern char ret_to_kernel;
>>         volatile uint64_t rax =3D 0;
>> -       static unsigned char user_stack[USERMODE_STACK_SIZE];
>> +       static unsigned char *user_stack;
>>         handler old_ex;
>>
>> +       if (!user_stack) {
>> +               user_stack =3D alloc_pages(USERMODE_STACK_ORDER);
>> +               printf("%p\n", user_stack);
>> +       }
>> +
>>         *raised_vector =3D 0;
>>         set_idt_entry(RET_TO_KERNEL_IRQ, &ret_to_kernel, 3);
>>         old_ex =3D handle_exception(fault_vector,
>> @@ -51,6 +58,8 @@ uint64_t run_in_user(usermode_func func, unsigned int
>> fault_vector,
>>                 return 0;
>>         }
>>
>> +       memcpy(user_stack + USERMODE_STACK_SIZE - 8, &func, 8);
>> +
>>         asm volatile (
>>                         /* Prepare kernel SP for exception handlers */
>>                         "mov %%rsp, %[rsp0]\n\t"
>> @@ -63,12 +72,13 @@ uint64_t run_in_user(usermode_func func, unsigned in=
t
>> fault_vector,
>>                         "pushq %[user_stack_top]\n\t"
>>                         "pushfq\n\t"
>>                         "pushq %[user_cs]\n\t"
>> -                       "lea user_mode(%%rip), %%rax\n\t"
>> +                       "lea user_mode+0x800000(%%rip), %%rax\n\t" //
>> smap.flat places usermode addresses at 8MB-16MB
>>                         "pushq %%rax\n\t"
>>                         "iretq\n"
>>
>>                         "user_mode:\n\t"
>>                         /* Back up volatile registers before invoking
>> func */
>> +                       "pop %%rax\n\t"
>>                         "push %%rcx\n\t"
>>                         "push %%rdx\n\t"
>>                         "push %%rdi\n\t"
>> @@ -78,11 +88,12 @@ uint64_t run_in_user(usermode_func func, unsigned in=
t
>> fault_vector,
>>                         "push %%r10\n\t"
>>                         "push %%r11\n\t"
>>                         /* Call user mode function */
>> +                       "add $0x800000,%%rbp\n\t"
>>                         "mov %[arg1], %%rdi\n\t"
>>                         "mov %[arg2], %%rsi\n\t"
>>                         "mov %[arg3], %%rdx\n\t"
>>                         "mov %[arg4], %%rcx\n\t"
>> -                       "call *%[func]\n\t"
>> +                       "call *%%rax\n\t"
>>                         /* Restore registers */
>>                         "pop %%r11\n\t"
>>                         "pop %%r10\n\t"
>> @@ -112,12 +123,11 @@ uint64_t run_in_user(usermode_func func, unsigned
>> int fault_vector,
>>                         [arg2]"m"(arg2),
>>                         [arg3]"m"(arg3),
>>                         [arg4]"m"(arg4),
>> -                       [func]"m"(func),
>>                         [user_ds]"i"(USER_DS),
>>                         [user_cs]"i"(USER_CS),
>>                         [kernel_ds]"rm"(KERNEL_DS),
>>                         [user_stack_top]"r"(user_stack +
>> -                                       sizeof(user_stack)),
>> +                                       USERMODE_STACK_SIZE - 8),
>>                         [kernel_entry_vector]"i"(RET_TO_KERNEL_IRQ));
>>
>>         handle_exception(fault_vector, old_ex);
>> diff --git a/x86/smap.c b/x86/smap.c
>> index 9a823a55..65119442 100644
>> --- a/x86/smap.c
>> +++ b/x86/smap.c
>> @@ -2,6 +2,7 @@
>>  #include <alloc_page.h>
>>  #include "x86/desc.h"
>>  #include "x86/processor.h"
>> +#include "x86/usermode.h"
>>  #include "x86/vm.h"
>>
>>  volatile int pf_count =3D 0;
>> @@ -89,6 +90,31 @@ static void check_smap_nowp(void)
>>         write_cr3(read_cr3());
>>  }
>>
>> +#ifdef __x86_64__
>> +static void iret(void)
>> +{
>> +       asm volatile(
>> +           "mov %%rsp, %%rcx;"
>> +           "movl %%ss, %%ebx; pushq %%rbx; pushq %%rcx;"
>> +           "pushf;"
>> +           "movl %%cs, %%ebx; pushq %%rbx; "
>> +           "lea 1f(%%rip), %%rbx; pushq %%rbx; iretq; 1:"
>> +
>> +               : : : "ebx", "ecx", "cc"); /* RPL=3D0 */
>> +}
>> +
>> +static void test_user_iret(void)
>> +{
>> +       bool raised_vector;
>> +       uintptr_t user_iret =3D (uintptr_t)iret + USER_BASE;
>> +
>> +       run_in_user((usermode_func)user_iret, PF_VECTOR, 0, 0, 0, 0,
>> +                   &raised_vector);
>> +
>> +       report(!raised_vector, "No #PF on CPL=3D3 DPL=3D3 iret");
>> +}
>> +#endif
>> +
>>  int main(int ac, char **av)
>>  {
>>         unsigned long i;
>> @@ -196,7 +222,9 @@ int main(int ac, char **av)
>>
>>         check_smap_nowp();
>>
>> -       // TODO: implicit kernel access from ring 3 (e.g. int)
>> +#ifdef __x86_64__
>> +       test_user_iret();
>> +#endif
>>
>>         return report_summary();
>>  }
>>
>>
>>
>>

--000000000000fe7506061ceb0c64
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 10 lug 2024, 23:01 Robert Henry &lt;<a href=3D"=
mailto:rrh.henry@gmail.com">rrh.henry@gmail.com</a>&gt; ha scritto:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">I have=
 only skimmed the diffs.=C2=A0 Your knowledge of the deep semantics, gained=
 by close differential reading of intel and amd docs, is truly amazing.=C2=
=A0 Many thanks for pushing this through!</div></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Thanks for bringing this to our =
attention too, apart from the practical bug hopefully it will help future r=
eaders to have a more precise implementation.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">I tried to acknowledge your contribution in the commi=
t messages.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div>I have 2 nits, perhaps stylistic only.</div><div><br></div><d=
iv>For code like &quot;sp -=3D 2&quot; or &quot;sp=C2=A0+=3D 2&quot; follow=
ed or preceded by a write to the stack pointer of a uint16_t variable &#39;=
x&#39;,=C2=A0 would it be better/more robust to rewrite as: &quot;sp -=3D s=
izeof(x)&quot;=C2=A0 ?</div></div></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">I think that&#39;s intentional because the va=
lue subtracted is related to the &quot;stw&quot; or &quot;stl&quot; in the =
store (likewise for incrementing after a load) more than to the size of x.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>=
There are a lot of masks constructed using -1.=C2=A0 I think it would be cl=
earer to use 0xffffffff (for 32-bit masks) as that reminds the reader that =
this is a bit mask.=C2=A0 But it seems that using -1 is how the original co=
de was written.<br></div></div></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">-1 is used for 64-bit masks only. They get unwie=
ldy quickly. :)</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=
=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><=
div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Tue, Jul 9, 2024 at 11:29=E2=80=AFPM Paolo Bonzini &lt;<a href=
=3D"mailto:pbonzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzi=
ni@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">This includes bugfixes:<br>
- allowing IRET from user mode to user mode with SMAP (do not use implicit<=
br>
=C2=A0 kernel accesses, which break if the stack is in userspace)<br>
<br>
- use DPL-level accesses for interrupts and call gates<br>
<br>
- various fixes for task switching<br>
<br>
And two related cleanups: computing MMU index once for far calls and return=
s<br>
(including task switches), and using X86Access for TSS access.<br>
<br>
Tested with a really ugly patch to kvm-unit-tests, included after signature=
.<br>
<br>
Paolo Bonzini (7):<br>
=C2=A0 target/i386/tcg: Allow IRET from user mode to user mode with SMAP<br=
>
=C2=A0 target/i386/tcg: use PUSHL/PUSHW for error code<br>
=C2=A0 target/i386/tcg: Compute MMU index once<br>
=C2=A0 target/i386/tcg: Use DPL-level accesses for interrupts and call gate=
s<br>
=C2=A0 target/i386/tcg: check for correct busy state before switching to a<=
br>
=C2=A0 =C2=A0 new task<br>
=C2=A0 target/i386/tcg: use X86Access for TSS access<br>
=C2=A0 target/i386/tcg: save current task state before loading new one<br>
<br>
Richard Henderson (3):<br>
=C2=A0 target/i386/tcg: Remove SEG_ADDL<br>
=C2=A0 target/i386/tcg: Reorg push/pop within seg_helper.c<br>
=C2=A0 target/i386/tcg: Introduce x86_mmu_index_{kernel_,}pl<br>
<br>
=C2=A0target/i386/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 11=
 +-<br>
=C2=A0target/i386/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 27=
 +-<br>
=C2=A0target/i386/tcg/seg_helper.c | 606 +++++++++++++++++++---------------=
-<br>
=C2=A03 files changed, 354 insertions(+), 290 deletions(-)<br>
<br>
-- <br>
2.45.2<br>
<br>
diff --git a/lib/x86/usermode.c b/lib/x86/usermode.c<br>
index c3ec0ad7..0bf40c6d 100644<br>
--- a/lib/x86/usermode.c<br>
+++ b/lib/x86/usermode.c<br>
@@ -5,13 +5,15 @@<br>
=C2=A0#include &quot;x86/desc.h&quot;<br>
=C2=A0#include &quot;x86/isr.h&quot;<br>
=C2=A0#include &quot;alloc.h&quot;<br>
+#include &quot;alloc_page.h&quot;<br>
=C2=A0#include &quot;setjmp.h&quot;<br>
=C2=A0#include &quot;usermode.h&quot;<br>
<br>
=C2=A0#include &quot;libcflat.h&quot;<br>
=C2=A0#include &lt;stdint.h&gt;<br>
<br>
-#define USERMODE_STACK_SIZE=C2=A0 =C2=A0 0x2000<br>
+#define USERMODE_STACK_ORDER=C2=A0 =C2=A01 /* 8k */<br>
+#define USERMODE_STACK_SIZE=C2=A0 =C2=A0 (1 &lt;&lt; (12 + USERMODE_STACK_=
ORDER))<br>
=C2=A0#define RET_TO_KERNEL_IRQ=C2=A0 =C2=A0 =C2=A0 0x20<br>
<br>
=C2=A0static jmp_buf jmpbuf;<br>
@@ -37,9 +39,14 @@ uint64_t run_in_user(usermode_func func, unsigned int fa=
ult_vector,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 extern char ret_to_kernel;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 volatile uint64_t rax =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0static unsigned char user_stack[USERMODE_STACK_=
SIZE];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0static unsigned char *user_stack;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 handler old_ex;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!user_stack) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user_stack =3D allo=
c_pages(USERMODE_STACK_ORDER);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%p\n&q=
uot;, user_stack);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *raised_vector =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_idt_entry(RET_TO_KERNEL_IRQ, &amp;ret_to_ke=
rnel, 3);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 old_ex =3D handle_exception(fault_vector,<br>
@@ -51,6 +58,8 @@ uint64_t run_in_user(usermode_func func, unsigned int fau=
lt_vector,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(user_stack + USERMODE_STACK_SIZE - 8, &a=
mp;func, 8);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 asm volatile (<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Prepare kernel SP for exception handlers */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;mov %%rsp, %[rsp0]\n\t&quot;<br>
@@ -63,12 +72,13 @@ uint64_t run_in_user(usermode_func func, unsigned int f=
ault_vector,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;pushq %[user_stack_top]\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;pushfq\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;pushq %[user_cs]\n\t&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;lea user_mode(%%rip), %%rax\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;lea user_mode+0x800000(%%rip), %%rax\n\t&quot; // smap.flat=
 places usermode addresses at 8MB-16MB<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;pushq %%rax\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;iretq\n&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;user_mode:\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Back up volatile registers before invoking func */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;pop %%rax\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;push %%rcx\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;push %%rdx\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;push %%rdi\n\t&quot;<br>
@@ -78,11 +88,12 @@ uint64_t run_in_user(usermode_func func, unsigned int f=
ault_vector,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;push %%r10\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;push %%r11\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Call user mode function */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;add $0x800000,%%rbp\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;mov %[arg1], %%rdi\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;mov %[arg2], %%rsi\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;mov %[arg3], %%rdx\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;mov %[arg4], %%rcx\n\t&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;call *%[func]\n\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;call *%%rax\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Restore registers */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;pop %%r11\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;pop %%r10\n\t&quot;<br>
@@ -112,12 +123,11 @@ uint64_t run_in_user(usermode_func func, unsigned int=
 fault_vector,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [arg2]&quot;m&quot;(arg2),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [arg3]&quot;m&quot;(arg3),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [arg4]&quot;m&quot;(arg4),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0[func]&quot;m&quot;(func),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [user_ds]&quot;i&quot;(USER_DS),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [user_cs]&quot;i&quot;(USER_CS),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [kernel_ds]&quot;rm&quot;(KERNEL_DS),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [user_stack_top]&quot;r&quot;(user_stack +<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(us=
er_stack)),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0USERMODE_=
STACK_SIZE - 8),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [kernel_entry_vector]&quot;i&quot;(RET_TO_KERNEL_IRQ));<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 handle_exception(fault_vector, old_ex);<br>
diff --git a/x86/smap.c b/x86/smap.c<br>
index 9a823a55..65119442 100644<br>
--- a/x86/smap.c<br>
+++ b/x86/smap.c<br>
@@ -2,6 +2,7 @@<br>
=C2=A0#include &lt;alloc_page.h&gt;<br>
=C2=A0#include &quot;x86/desc.h&quot;<br>
=C2=A0#include &quot;x86/processor.h&quot;<br>
+#include &quot;x86/usermode.h&quot;<br>
=C2=A0#include &quot;x86/vm.h&quot;<br>
<br>
=C2=A0volatile int pf_count =3D 0;<br>
@@ -89,6 +90,31 @@ static void check_smap_nowp(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 write_cr3(read_cr3());<br>
=C2=A0}<br>
<br>
+#ifdef __x86_64__<br>
+static void iret(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0asm volatile(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;mov %%rsp, %%rcx;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;movl %%ss, %%ebx; pushq %%r=
bx; pushq %%rcx;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;pushf;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;movl %%cs, %%ebx; pushq %%r=
bx; &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;lea 1f(%%rip), %%rbx; pushq=
 %%rbx; iretq; 1:&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: : : &quot;ebx&quo=
t;, &quot;ecx&quot;, &quot;cc&quot;); /* RPL=3D0 */<br>
+}<br>
+<br>
+static void test_user_iret(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool raised_vector;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uintptr_t user_iret =3D (uintptr_t)iret + USER_=
BASE;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0run_in_user((usermode_func)user_iret, PF_VECTOR=
, 0, 0, 0, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
raised_vector);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0report(!raised_vector, &quot;No #PF on CPL=3D3 =
DPL=3D3 iret&quot;);<br>
+}<br>
+#endif<br>
+<br>
=C2=A0int main(int ac, char **av)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long i;<br>
@@ -196,7 +222,9 @@ int main(int ac, char **av)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 check_smap_nowp();<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0// TODO: implicit kernel access from ring 3 (e.=
g. int)<br>
+#ifdef __x86_64__<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0test_user_iret();<br>
+#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return report_summary();<br>
=C2=A0}<br>
<br>
<br>
<br>
</blockquote></div>
</blockquote></div></div></div>

--000000000000fe7506061ceb0c64--


