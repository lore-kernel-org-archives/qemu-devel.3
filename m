Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC198C55179
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqrEk-0001Ju-Le; Mon, 03 Aug 2026 07:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1wqrEh-0001JZ-U3
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 07:53:39 -0400
Received: from mail-ua1-f49.google.com ([209.85.222.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1wqrEb-0004ZS-IX
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 07:53:35 -0400
Received: by mail-ua1-f49.google.com with SMTP id
 a1e0cc1a2514c-977bbf2eb3aso751966241.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 04:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785758012; x=1786362812;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nF1vhNpaBlVQXaTiQuSq2URjmBitCLtKJIgx6H39Z+U=;
 b=TlmZU6y0fkmjoInQeDRyyvcgwxo0MQoQLMGm4W8ghHAMmHJGL7GL2tURixw4ZrbN4T
 e0OcXnMPM20baRcwgJsXiok1G52mbr0vSKeuf6CBtVvA1A9/oHZopIDEK4fbCQGXIv1v
 TEfyfcDC3ERKSLR8ig+0M4e7wuOlg0oqsqcVzdM6jGVunaCPQb29EcXyHHy9QCaeLbgt
 IjcdmS1Z9KOuahkaUT7wTXw5NoaHkcmfQL8j+GjGPBL2gdHRcQGEw3pZpadTJX/Wo4oF
 v/TYXxLhPtKSkDKKq9PIEDr3eZiXAIxgKvizpw/uO3oA8LFtgrDmziUTWWgMGfNeZgXz
 lyyw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCDeUyMiEs46+VTOWV8rdVkjS5UA8mxSx6v9OeO7rgdzKIZfxb5dkuWGrb0av+Ya4EzlCFlls1kWK4@nongnu.org
X-Gm-Message-State: AOJu0Ywmyb9Rg4lnMRl8RBCBnXhT6zzEKRcrQwCEvhTJYXEORBvkFZhm
 Iy0C3dnMhQWJnkOP+Q0OhyQ0PR/tyxN8tU3vKRwZawuLZl3Y0TKMcB2ge9dVy/Mf
X-Gm-Gg: AR+sD101uWyHbvwRnIIxBjlHYT0P/OcgWg4vMI/Qj5K79z9zsXXZOb9RV7xOX4B4D8p
 xoUI/qIHaF7OUK7Cc4gJnAuiZtGMbJxxzocT9q2Q3Lk4kYbqWtBypIChEKWlKfuxK3vOczPW2mP
 FZrvAv4fWztQcuihXUR8FbGdX0dOWpYUggIRKIJgL4dnan3Z6yH0TuDFQppUZyysYw7PJYOh/Zi
 hUuStrSFmyqoyR0NmMkMMcn7LExKRHcSdFcG7/B7epOzoIGUU261r+x7ozJ2s7QehRsk1CWnpPd
 oDX5blYotl33+PJzmabD2sNlrHthwj/UH5SYk/QHgIBYp9vRz50WvjST+mbVjASTINL7kDXynTE
 Y0ol6QfmlpZhV6f8o408VXOCWkw4vX5mF9ju07w0/qPrJ3uVNF4HuyV2xEJFrZhLrqC9u/PZ5ea
 I6CPsuTZzIp3O/L7a3d7W6DuqD9NzGHnbXQJTjHXVeeZGxUJK+l+ckG8yEZEaMnjAK9eskMv4Qi
 dmP4N1RUhiKNYKPXLWWnu9MWw==
X-Received: by 2002:a05:6102:94d:b0:740:22ba:8a4e with SMTP id
 ada2fe7eead31-75b222654aemr5131478137.6.1785758011901; 
 Mon, 03 Aug 2026 04:53:31 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com.
 [209.85.217.53]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e6a40a5csm6212927241.10.2026.08.03.04.53.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 04:53:31 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-738bcf9a573so1062367137.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 04:53:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqNgZwfJBXtxtFKBTUoEu9awqCw26COM1LfwTPVXUHoh269H+Kqxc4Q+KrNRWXjQypt7hd6u0rYO7R3@nongnu.org
X-Received: by 2002:a05:6102:1591:b0:740:2974:1b19 with SMTP id
 ada2fe7eead31-75b21d62f06mr6144315137.4.1785758011219; Mon, 03 Aug 2026
 04:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260728192913.61279-1-deller@kernel.org>
 <CAFEAcA_8o2A8FDsJKacde+pdj4HzA5c7aTw=k7tmONYXD4=c_w@mail.gmail.com>
 <244987da-f6d8-47a8-ac4a-16a71c660e36@gmx.de>
 <CAFEAcA9F8rauUNc2NAqbnf1f7-0O_ivft1XOftwt1hW0YWeeJw@mail.gmail.com>
 <a8c13cdc-54c3-4913-bc6e-956cbfe082cb@gmx.de>
 <89e75011-61fb-4cbc-9583-4117005e58dc@gmx.de>
In-Reply-To: <89e75011-61fb-4cbc-9583-4117005e58dc@gmx.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Aug 2026 13:53:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV6pwzjmC8cnhxhTNAvHh7yC3_C5LdVe4RbiaZamMUQgw@mail.gmail.com>
X-Gm-Features: AUfX_my3VnNuW4JRO5szmPOHoPyZtpemhqyO-_qjLmVKmfoRw9opDc8LPXNvtiw
Message-ID: <CAMuHMdV6pwzjmC8cnhxhTNAvHh7yC3_C5LdVe4RbiaZamMUQgw@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Fix msqid_ds struct wrt 32-bit big endian
 architectures
To: Helge Deller <deller@gmx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@kernel.org>,
 qemu-devel@nongnu.org, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.222.49;
 envelope-from=geert.uytterhoeven@gmail.com; helo=mail-ua1-f49.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

CC linux-m68k

On Sat, 1 Aug 2026 at 23:39, Helge Deller <deller@gmx.de> wrote:
>
> (Adding Geert as kernel m68k maintainer)
>
> On 8/1/26 22:58, Helge Deller wrote:
> > On 8/1/26 14:11, Peter Maydell wrote:
> >> On Fri, 31 Jul 2026 at 20:36, Helge Deller <deller@gmx.de> wrote:
> >>>
> >>> Hello Peter,
> >>>
> >>> On 7/31/26 20:05, Peter Maydell wrote:
> >>>> On Tue, 28 Jul 2026 at 20:32, Helge Deller <deller@kernel.org> wrote:
> >>>>>
> >>>>> From: Helge Deller <deller@gmx.de>
> >>>>>
> >>>>> Make sure that the time entries (msg_stime, msg_rtime and msg_ctime)
> >>>>> are defined as 64-bit time_t values, since the userspace may access
> >>>>> the whole 64-bit value. By this change we fix the word ordering for
> >>>>> 32-bit big endian architectures as well.
> >>>>>
> >>>>> This fixes the msgctl01 LTP testcase on hppa32.
> >>>>>
> >>>>> Signed-off-by: Helge Deller <deller@gmx.de>
> >>>>> ---
> >>>>>    linux-user/syscall.c | 30 ++++++++++++------------------
> >>>>>    1 file changed, 12 insertions(+), 18 deletions(-)
> >>>>>
> >>>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> >>>>> index 740142825d..c93b770ced 100644
> >>>>> --- a/linux-user/syscall.c
> >>>>> +++ b/linux-user/syscall.c
> >>>>> @@ -4216,21 +4216,15 @@ static inline abi_long do_semtimedop(int semid,
> >>>>>    }
> >>>>>    #endif
> >>>>
> >>>> I see this has already gone into git, but some late review
> >>>> comments. I suspect this is mostly me being confused rather
> >>>> than actual problems.
> >>>>
> >>>>>
> >>>>> +#define target_time64_t         abi_ullong
> >>>>> +#define target_swap_time64(x)   tswap64(x)
> >>>>> +
> >>>>>    struct target_msqid_ds
> >>>>
> >>>> Is this the kernel's "struct msqid_ds" (which it calls "Obsolete, used
> >>>> only for backwards compatibility and libc5 compiles") or its msqid64_ds?
> >>>
> >>> Yes, it's msqid64_ds.
> >>>
> >>>> The layout matches msqid64_ds, which makes our struct a bit
> >>>> confusingly named.
> >>>
> >>> True.
> >>> In a follow-up patch this better should be renamed to target_msqid64_ds.
> >>>
> >>>>>    {
> >>>>>        struct target_ipc_perm msg_perm;
> >>>>> -    abi_ulong msg_stime;
> >>>>> -#if TARGET_ABI_BITS == 32
> >>>>> -    abi_ulong __unused1;
> >>>>> -#endif
> >>>>> -    abi_ulong msg_rtime;
> >>>>> -#if TARGET_ABI_BITS == 32
> >>>>> -    abi_ulong __unused2;
> >>>>> -#endif
> >>>>> -    abi_ulong msg_ctime;
> >>>>> -#if TARGET_ABI_BITS == 32
> >>>>> -    abi_ulong __unused3;
> >>>>> -#endif
> >>>>> +    target_time64_t msg_stime;
> >>>>> +    target_time64_t msg_rtime;
> >>>>> +    target_time64_t msg_ctime;
> >>>>
> >>>> Assuming msqid64_ds, the kernel version of this struct has a comment:
> >>>>    * 64 bit architectures use a 64-bit long time field here, while
> >>>>    * 32 bit architectures have a pair of unsigned long values.
> >>>>    * On big-endian systems, the lower half is in the wrong place.
> >>>
> >>> Those comments are from the generic header:
> >>> include/uapi/asm-generic/msgbuf.h
> >>> and I think the last sentence about big-endian systems is wrong, as
> >>> most platforms provide an own architecture-specific header file, e.g:
> >>> arch/xtensa/include/uapi/asm/msgbuf.h
> >>> and the big-endian platforms seem to have their high-word first.
> >>
> >> The comment is correct for any bigendian 32-bit system that
> >> uses the kernel's asm-generic structure. Maybe there just aren't
> >> any of those that we care about?
> >
> > m68k could be a problem.
> > The other big-arches seem to be handled correctly by the kernel:
> > arch/sparc/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> > arch/parisc/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> > arch/xtensa/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> > arch/x86/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> > arch/powerpc/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> > arch/mips/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> > arch/mips/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> > arch/mips/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> >
> >>>> That would make tswap64() not the right swap for 32-bit big
> >>>> endian guests.
> >>>
> >>> I did my testing on the 32-bit hppa/parisc platform, and with my patch
> >>> the results in qemu were correct and were the same as on physical machines.
> >>>
> >>> I just tried in a 32-bit powerpc chroot and the msgctl01 now succeeds there as well.
> >>> So, I think my patch is generally ok.
> >>
> >> Yeah, 32-bit powerpc also provides its own structure definition.
> >>
> >> I think it's worth having a comment about this, at least, because
> >> otherwise the obvious assumption is that our struct which has
> >> no target-specific ifdefs is supposed to match the kernel's
> >> asm-generic struct.
> >
> > Yes, I will the testing on m68k, afterwards I can come up with a proposal.
> > Maybe it makes sense to modify the kernel comment too....
>
>
> The msgctl01 testcase from LTP gives this preprocessed code on m68k:
> ...
> # 27 "/usr/include/m68k-linux-gnu/bits/types/struct_msqid_ds.h" 3 4
> struct msqid_ds
> {
>
> # 1 "/usr/include/m68k-linux-gnu/bits/types/struct_msqid64_ds_helper.h" 1 3 4
> # 20 "/usr/include/m68k-linux-gnu/bits/types/struct_msqid64_ds_helper.h" 3 4
>    struct ipc_perm msg_perm;
>    __time64_t msg_stime;
>    __time64_t msg_rtime;
>    __time64_t msg_ctime;
>    __syscall_ulong_t __msg_cbytes;
>    msgqnum_t msg_qnum;
>    msglen_t msg_qbytes;
>    __pid_t msg_lspid;
>    __pid_t msg_lrpid;
>    unsigned long int __glibc_reserved4;
>    unsigned long int __glibc_reserved5;
> # 31 "/usr/include/m68k-linux-gnu/bits/types/struct_msqid_ds.h" 2 3 4
> # 53 "/usr/include/m68k-linux-gnu/bits/types/struct_msqid_ds.h" 3 4
> };
>
> but the testcase fails with:
> msgctl01.c:53: TFAIL: msg_ctime = 6a6e65d900000000, expected 6a6e65d9
>
> So, for m68k either the glibc or the kernel is wrong.
> At least they don't agree with each other.
>
> I think it would be beneficial, if the m68k kernel would follow m68k's
> glibc implementation of msqid64_ds.
>
> Helge

