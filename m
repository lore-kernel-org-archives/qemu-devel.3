Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71281CD3441
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 15:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slVSY-00022x-A0; Tue, 03 Sep 2024 11:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1slVSV-0001yb-RL
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:28:43 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1slVSS-0004Jw-0q
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:28:43 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7d4c923a3d7so1087198a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 08:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725377318; x=1725982118; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nZKLmNhbOTYVeMkUO3fmu6Ite0f0Jrob/ktJDrRiGMc=;
 b=W1OrYez8eGoqgzE5Xq85C7kwZIsvfc8kacBZCdUoTNMjp2S4Ej79b1dP8h5XqeDBui
 r6R8gkyCHbVzNwZNKoN1Vv5bzDIVZ1QpMtLs+PXW9aokhtNsMEZvZp3BMaDBxARTq5gV
 CloHJxvmc3QPeMcgPBVdq4rVjQ+z7BUQ3XoEdhf74qkY1zQNMNJ1d2M/yg1WXKiFUnpo
 +ipW6oxHr0VX5OMioBZHFKTJ55AdAxBLea2pySC8/8LLQG7+E/JXTeolqmsfe0cBNsH2
 6MLyIbS/oVff/3TDDGVlGsap/Qjez+ysJPK2qBLDFDz3bxD55c8jri4eAsTK3VZNSbCD
 mtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725377318; x=1725982118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nZKLmNhbOTYVeMkUO3fmu6Ite0f0Jrob/ktJDrRiGMc=;
 b=fPqNYhdt4eHjABG9hqIx9qOBm3aW6X6Rlko8UKqWm7KS0UUPfBQLHdBH3hjYg+EU+M
 2eE8Bd9vfslIsfsyZq94+KXAKTKC2SYbJlPHY39fKveSd/FepWOraEL638FknEbghP3X
 FSHE5UWujtNpAHY307Bd1r3B2jDXMds+z27wLzAJOfkSDh+PsCd2+WiT7gyRsUqHIO2c
 p2RFpBFS9RTjbtfLOPR2aAlHaRDVSm2UUfIg67nJEsKj6bjpfzBww42YrdjpJJKpM1al
 NB8brB/tVGyPP1muE8oPdMjMfGCijOMyGfGB548d+WDS7UufRiZf6USfYJT4HG9WI79W
 hRPw==
X-Gm-Message-State: AOJu0Yz0N0Cbax50rwSzLxizi7rjgE3vyHKKd1v9MBwYKcYwW+OCdjd8
 sPjRNtO709asN4mBlMUkQ9DQXVKE3377eqbGll0F5kQEaAEabHC5eQ0nQir/eMI+2TiCwvXyRHs
 mH4LzLkhF+giYnB6GN2B5L2VMixP4fQC33V0=
X-Google-Smtp-Source: AGHT+IFNedrd+nu8uhxJV8Dwo5Q4+3QfFE47PFT7sbPYweRrirbMrGUkgj+s2pzVFQ3X/1GPMa+swE/EJaREZFLcpqw=
X-Received: by 2002:a17:90b:350d:b0:2d3:c9bb:9cd7 with SMTP id
 98e67ed59e1d1-2da55a77e52mr3499326a91.36.1725377317710; Tue, 03 Sep 2024
 08:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240816162044.5764-1-just4now666666@gmail.com>
 <871q2ae24s.fsf@draig.linaro.org>
 <CACkyd_anZKrjNUKE+nwzSvJGQwxQ2zq2J8sGawq3pKYLVT9vXQ@mail.gmail.com>
 <CACkyd_ZNPzhg8pqkdLucyJ70wZKJARR_65r5CJBy0+U=7GR_1Q@mail.gmail.com>
 <87h6b452m5.fsf@draig.linaro.org>
 <CACkyd_YG-r837VfoPaOw5bKCczAUQYFOobW=2SF37esppbc0XQ@mail.gmail.com>
 <CACkyd_ZhByWwPQtFmHGRQxmBcVwCEyeSKX6fqhS3K=1480ASOA@mail.gmail.com>
 <87wmjudwyp.fsf@draig.linaro.org>
 <CACkyd_YpxVdGC04cEEPr4O44P+FQ9P51T32AtBxCmOVV1b9f-g@mail.gmail.com>
 <87jzftdol5.fsf@draig.linaro.org> <87bk15dm7k.fsf@draig.linaro.org>
In-Reply-To: <87bk15dm7k.fsf@draig.linaro.org>
From: Elisha Hollander <just4now666666@gmail.com>
Date: Tue, 3 Sep 2024 18:28:26 +0300
Message-ID: <CACkyd_YYUJYt3jAduOuaWiKcUAMKy3tGNp6Fuh6sHKMB=ZpTyw@mail.gmail.com>
Subject: Re: [PATCH 1/1] allow using a higher icount
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000020315a062138b6a1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=just4now666666@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000020315a062138b6a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

weird...

On Tue, Sep 3, 2024, 14:13 Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > Elisha Hollander <just4now666666@gmail.com> writes:
> >
> >> Sure!
> >>
> >> `build/qemu-system-i386 -plugin build/contrib/plugins/libips.so,ips=3D=
1
> -display curses -bios bios.raw`
> >>
> >> Also, I just tested with 9.1.0-rc4 and it resulted with
> >> `tcg.c:3167:remove_label_use: code should not be reached`
> >
> > I can replicate but it seems to be an edge case with ips=3D1, try a hig=
her
> > number, even ips=3D10 doesn't trigger the crash (but 10 instructions a
> > second is very slow to do anything).
> >
> >   ./qemu-system-i386  -plugin contrib/plugins/libips.so,ips=3D1 -displa=
y
> none -serial mon:stdio
> >   **
> >   ERROR:../../tcg/tcg.c:3167:remove_label_use: code should not be reach=
ed
> >   Bail out! ERROR:../../tcg/tcg.c:3167:remove_label_use: code should no=
t
> be reached
> >   fish: Job 1, './qemu-system-i386  -plugin con=E2=80=A6' terminated by=
 signal
> >   SIGABRT (Abort)
>
> Well this is fascinating and I suspect Richard needs to comment but:
>
>   ./qemu-system-i386  -plugin contrib/plugins/libips.so,ips=3D9 -display
> none -serial mon:stdio -d in_asm,op,op_opt,out_asm -plugin
> contrib/plugins/libstoptrigger.so,icount=3D20 -D broken.log
>   **
>   ERROR:../../tcg/tcg.c:3167:remove_label_use: code should not be reached
>   Bail out! ERROR:../../tcg/tcg.c:3167:remove_label_use: code should not
> be reached
>   fish: Job 1, './qemu-system-i386  -plugin con=E2=80=A6' terminated by s=
ignal
> SIGABRT (Abort)
>
> and:
>
>  ./qemu-system-i386  -plugin contrib/plugins/libips.so,ips=3D10 -display
> none -serial mon:stdio -d in_asm,op,op_opt,out_asm -plugin
> contrib/plugins/libstoptrigger.so,icount=3D20 -D working.log
>
> But for the life of me I can't see the difference between the two sets
> of input, the first crashes before the optimisation step:
>
> PROLOGUE: [size=3D45]
> 0x7f2198000000:  55                       pushq    %rbp
> 0x7f2198000001:  53                       pushq    %rbx
> 0x7f2198000002:  41 54                    pushq    %r12
> 0x7f2198000004:  41 55                    pushq    %r13
> 0x7f2198000006:  41 56                    pushq    %r14
> 0x7f2198000008:  41 57                    pushq    %r15
> 0x7f219800000a:  48 8b ef                 movq     %rdi, %rbp
> 0x7f219800000d:  48 81 c4 78 fb ff ff     addq     $-0x488, %rsp
> 0x7f2198000014:  ff e6                    jmpq     *%rsi
> 0x7f2198000016:  33 c0                    xorl     %eax, %eax
> 0x7f2198000018:  48 81 c4 88 04 00 00     addq     $0x488, %rsp
> 0x7f219800001f:  c5 f8 77                 vzeroupper
> 0x7f2198000022:  41 5f                    popq     %r15
> 0x7f2198000024:  41 5e                    popq     %r14
> 0x7f2198000026:  41 5d                    popq     %r13
> 0x7f2198000028:  41 5c                    popq     %r12
> 0x7f219800002a:  5b                       popq     %rbx
> 0x7f219800002b:  5d                       popq     %rbp
> 0x7f219800002c:  c3                       retq
>
> ----------------
> IN:
> 0xfffffff0:  ea 5b e0 00 f0           ljmpw    $0xf000:$0xe05b
>
> OP:
>  ld_i32 loc9,env,$0xfffffffffffffff8
>  brcond_i32 loc9,$0x0,lt,$L0
>  ld_i32 tmp18,env,$0xffffffffffffdaf8
>  mul_i32 tmp18,tmp18,$0x18
>  ext_i32_i64 tmp17,tmp18
>  add_i64 tmp17,tmp17,$0x55912c381e38
>  ld_i64 tmp21,tmp17,$0x0
>  add_i64 tmp21,tmp21,$0x1
>  st_i64 tmp21,tmp17,$0x0
>  ld_i32 tmp18,env,$0xffffffffffffdaf8
>  mul_i32 tmp18,tmp18,$0x18
>  ext_i32_i64 tmp17,tmp18
>  add_i64 tmp17,tmp17,$0x55912c381e38
>  ld_i64 tmp21,tmp17,$0x0
>  brcond_i64 tmp21,$0x0,ltu,$L1
>  ld_i32 tmp18,env,$0xffffffffffffdaf8
>  call plugin(0x7f21efe82550),$0x1,$0,tmp18,$0x0
>  set_label $L1
>  st8_i32 $0x1,env,$0xfffffffffffffffc
>
>  ---- 0000000000000ff0 0000000000000000
>  ld_i32 tmp18,env,$0xffffffffffffdaf8
>  shl_i32 tmp18,tmp18,$0x3
>  ext_i32_i64 tmp17,tmp18
>  add_i64 tmp17,tmp17,$0x55912c3803b0
>  ld_i64 tmp21,tmp17,$0x0
>  add_i64 tmp21,tmp21,$0x1
>  st_i64 tmp21,tmp17,$0x0
>  ld_i32 tmp18,env,$0xffffffffffffdaf8
>  shl_i32 tmp18,tmp18,$0x3
>  ext_i32_i64 tmp17,tmp18
>  add_i64 tmp17,tmp17,$0x55912c3803b0
>  ld_i64 tmp21,tmp17,$0x0
>  brcond_i64 tmp21,$0x15,ne,$L2
>  ld_i32 tmp18,env,$0xffffffffffffdaf8
>  call plugin(0x7f21efe7d420),$0x1,$0,tmp18,$0xfffffff0
>  set_label $L2
>  mov_i32 loc0,$0xe05b
>  mov_i32 loc1,$0xf000
>  ext16u_i32 loc13,loc1
>  st_i32 loc13,env,$0x54
>  shl_i32 cs_base,loc13,$0x4
>  mov_i32 eip,loc0
>  call lookup_tb_ptr,$0x6,$1,tmp15,env
>  goto_ptr tmp15
>  set_label $L0
>  exit_tb $0x7f2198000043
>
>  BOOM!!!
>
> and the working case:
>
> PROLOGUE: [size=3D45]
> 0x7f110c000000:  55                       pushq    %rbp
> 0x7f110c000001:  53                       pushq    %rbx
> 0x7f110c000002:  41 54                    pushq    %r12
> 0x7f110c000004:  41 55                    pushq    %r13
> 0x7f110c000006:  41 56                    pushq    %r14
> 0x7f110c000008:  41 57                    pushq    %r15
> 0x7f110c00000a:  48 8b ef                 movq     %rdi, %rbp
> 0x7f110c00000d:  48 81 c4 78 fb ff ff     addq     $-0x488, %rsp
> 0x7f110c000014:  ff e6                    jmpq     *%rsi
> 0x7f110c000016:  33 c0                    xorl     %eax, %eax
> 0x7f110c000018:  48 81 c4 88 04 00 00     addq     $0x488, %rsp
> 0x7f110c00001f:  c5 f8 77                 vzeroupper
> 0x7f110c000022:  41 5f                    popq     %r15
> 0x7f110c000024:  41 5e                    popq     %r14
> 0x7f110c000026:  41 5d                    popq     %r13
> 0x7f110c000028:  41 5c                    popq     %r12
> 0x7f110c00002a:  5b                       popq     %rbx
> 0x7f110c00002b:  5d                       popq     %rbp
> 0x7f110c00002c:  c3                       retq
>
> ----------------
> IN:
> 0xfffffff0:  ea 5b e0 00 f0           ljmpw    $0xf000:$0xe05b
>
> OP:
>  ld_i32 loc9,env,$0xfffffffffffffff8
>  brcond_i32 loc9,$0x0,lt,$L0
>  ld_i32 tmp18,env,$0xffffffffffffdaf8
>  mul_i32 tmp18,tmp18,$0x18
>  ext_i32_i64 tmp17,tmp18
>  add_i64 tmp17,tmp17,$0x55c2cb346e38
>  ld_i64 tmp21,tmp17,$0x0
>  add_i64 tmp21,tmp21,$0x1
>  st_i64 tmp21,tmp17,$0x0
>  ld_i32 tmp18,env,$0xffffffffffffdaf8
>  mul_i32 tmp18,tmp18,$0x18
>  ext_i32_i64 tmp17,tmp18
>  add_i64 tmp17,tmp17,$0x55c2cb346e38
>  ld_i64 tmp21,tmp17,$0x0
>  brcond_i64 tmp21,$0x1,ltu,$L1
>  ld_i32 tmp18,env,$0xffffffffffffdaf8
>  call plugin(0x7f11633ab550),$0x1,$0,tmp18,$0x0
>  set_label $L1
>  st8_i32 $0x1,env,$0xfffffffffffffffc
>
>  ---- 0000000000000ff0 0000000000000000
>  ld_i32 tmp18,env,$0xffffffffffffdaf8
>  shl_i32 tmp18,tmp18,$0x3
>  ext_i32_i64 tmp17,tmp18
>  add_i64 tmp17,tmp17,$0x55c2cb3453b0
>  ld_i64 tmp21,tmp17,$0x0
>  add_i64 tmp21,tmp21,$0x1
>  st_i64 tmp21,tmp17,$0x0
>  ld_i32 tmp18,env,$0xffffffffffffdaf8
>  shl_i32 tmp18,tmp18,$0x3
>  ext_i32_i64 tmp17,tmp18
>  add_i64 tmp17,tmp17,$0x55c2cb3453b0
>  ld_i64 tmp21,tmp17,$0x0
>  brcond_i64 tmp21,$0x15,ne,$L2
>  ld_i32 tmp18,env,$0xffffffffffffdaf8
>  call plugin(0x7f11633a6420),$0x1,$0,tmp18,$0xfffffff0
>  set_label $L2
>  mov_i32 loc0,$0xe05b
>  mov_i32 loc1,$0xf000
>  ext16u_i32 loc13,loc1
>  st_i32 loc13,env,$0x54
>  shl_i32 cs_base,loc13,$0x4
>  mov_i32 eip,loc0
>  call lookup_tb_ptr,$0x6,$1,tmp15,env
>  goto_ptr tmp15
>  set_label $L0
>  exit_tb $0x7f110c000043
>
> OP after optimization and liveness analysis:
>  ld_i32 tmp9,env,$0xfffffffffffffff8      pref=3D0xffff
>  brcond_i32 tmp9,$0x0,lt,$L0              dead: 0 1
>  ld_i32 tmp18,env,$0xffffffffffffdaf8     pref=3D0xffff
>  mul_i32 tmp18,tmp18,$0x18                dead: 1  pref=3D0xffff
>  ext_i32_i64 tmp17,tmp18                  dead: 1  pref=3D0xffff
>  add_i64 tmp17,tmp17,$0x55c2cb346e38      dead: 1  pref=3D0xffff
>  ld_i64 tmp21,tmp17,$0x0                  pref=3D0xffff
>  add_i64 tmp21,tmp21,$0x1                 dead: 1  pref=3D0xffff
>  st_i64 tmp21,tmp17,$0x0                  dead: 0 1
>  ld_i32 tmp18,env,$0xffffffffffffdaf8     pref=3D0xffff
>  mul_i32 tmp18,tmp18,$0x18                dead: 1 2  pref=3D0xffff
>  ext_i32_i64 tmp17,tmp18                  dead: 1  pref=3D0xffff
>  add_i64 tmp17,tmp17,$0x55c2cb346e38      dead: 1 2  pref=3D0xffff
>  ld_i64 tmp21,tmp17,$0x0                  dead: 1  pref=3D0xffff
>  brcond_i64 tmp21,$0x1,ltu,$L1            dead: 0 1
>  ld_i32 tmp18,env,$0xffffffffffffdaf8     dead: 1  pref=3D0x80
>  call plugin(0x7f11633ab550),$0x1,$0,tmp18,$0x0  dead: 0 1
>  set_label $L1
>  st8_i32 $0x1,env,$0xfffffffffffffffc     dead: 0
>
>  ---- 0000000000000ff0 0000000000000000
>  ld_i32 tmp18,env,$0xffffffffffffdaf8     pref=3D0xffff
>  shl_i32 tmp18,tmp18,$0x3                 dead: 1  pref=3D0xffff
>  ext_i32_i64 tmp17,tmp18                  dead: 1  pref=3D0xffff
>  add_i64 tmp17,tmp17,$0x55c2cb3453b0      dead: 1  pref=3D0xffff
>  ld_i64 tmp21,tmp17,$0x0                  pref=3D0xffff
>  add_i64 tmp21,tmp21,$0x1                 dead: 1 2  pref=3D0xffff
>  st_i64 tmp21,tmp17,$0x0                  dead: 0 1
>  ld_i32 tmp18,env,$0xffffffffffffdaf8     pref=3D0xffff
>  shl_i32 tmp18,tmp18,$0x3                 dead: 1 2  pref=3D0xffff
>  ext_i32_i64 tmp17,tmp18                  dead: 1  pref=3D0xffff
>  add_i64 tmp17,tmp17,$0x55c2cb3453b0      dead: 1 2  pref=3D0xffff
>  ld_i64 tmp21,tmp17,$0x0                  dead: 1  pref=3D0xffff
>  brcond_i64 tmp21,$0x15,ne,$L2            dead: 0 1
>  ld_i32 tmp18,env,$0xffffffffffffdaf8     dead: 1  pref=3D0x80
>  call plugin(0x7f11633a6420),$0x1,$0,tmp18,$0xfffffff0  dead: 0 1
>  set_label $L2
>  st_i32 $0xf000,env,$0x54                 dead: 0
>  mov_i32 cs_base,$0xf0000                 sync: 0  dead: 0 1  pref=3D0xff=
ff
>  mov_i32 eip,$0xe05b                      sync: 0  dead: 0 1  pref=3D0xff=
ff
>  call lookup_tb_ptr,$0x6,$1,tmp15,env     dead: 1  pref=3Dnone
>  goto_ptr tmp15                           dead: 0
>  set_label $L0
>  exit_tb $0x7f110c000043
>
> OUT: [size=3D224]
>   -- guest addr 0x0000000000000ff0 + tb prologue
> 0x7f110c000100:  8b 5d f8                 movl     -8(%rbp), %ebx
> 0x7f110c000103:  85 db                    testl    %ebx, %ebx
> 0x7f110c000105:  0f 8c bd 00 00 00        jl       0x7f110c0001c8
> 0x7f110c00010b:  8b 9d f8 da ff ff        movl     -0x2508(%rbp), %ebx
> 0x7f110c000111:  6b db 18                 imull    $0x18, %ebx, %ebx
> 0x7f110c000114:  48 63 db                 movslq   %ebx, %rbx
> 0x7f110c000117:  49 bc 38 6e 34 cb c2 55  movabsq  $0x55c2cb346e38, %r12
> 0x7f110c00011f:  00 00
> 0x7f110c000121:  49 03 dc                 addq     %r12, %rbx
> 0x7f110c000124:  4c 8b 2b                 movq     (%rbx), %r13
> 0x7f110c000127:  49 ff c5                 incq     %r13
> 0x7f110c00012a:  4c 89 2b                 movq     %r13, (%rbx)
> 0x7f110c00012d:  8b 9d f8 da ff ff        movl     -0x2508(%rbp), %ebx
> 0x7f110c000133:  6b db 18                 imull    $0x18, %ebx, %ebx
> 0x7f110c000136:  48 63 db                 movslq   %ebx, %rbx
> 0x7f110c000139:  49 03 dc                 addq     %r12, %rbx
> 0x7f110c00013c:  48 8b 1b                 movq     (%rbx), %rbx
> 0x7f110c00013f:  48 83 fb 01              cmpq     $1, %rbx
> 0x7f110c000143:  0f 82 0d 00 00 00        jb       0x7f110c000156
> 0x7f110c000149:  8b bd f8 da ff ff        movl     -0x2508(%rbp), %edi
> 0x7f110c00014f:  33 f6                    xorl     %esi, %esi
> 0x7f110c000151:  e8 fa b3 3a 57           callq    0x7f11633ab550
> 0x7f110c000156:  c6 45 fc 01              movb     $1, -4(%rbp)
> 0x7f110c00015a:  8b 9d f8 da ff ff        movl     -0x2508(%rbp), %ebx
> 0x7f110c000160:  c1 e3 03                 shll     $3, %ebx
> 0x7f110c000163:  48 63 db                 movslq   %ebx, %rbx
> 0x7f110c000166:  49 bc b0 53 34 cb c2 55  movabsq  $0x55c2cb3453b0, %r12
> 0x7f110c00016e:  00 00
> 0x7f110c000170:  49 03 dc                 addq     %r12, %rbx
> 0x7f110c000173:  4c 8b 2b                 movq     (%rbx), %r13
> 0x7f110c000176:  49 ff c5                 incq     %r13
> 0x7f110c000179:  4c 89 2b                 movq     %r13, (%rbx)
> 0x7f110c00017c:  8b 9d f8 da ff ff        movl     -0x2508(%rbp), %ebx
> 0x7f110c000182:  c1 e3 03                 shll     $3, %ebx
> 0x7f110c000185:  48 63 db                 movslq   %ebx, %rbx
> 0x7f110c000188:  49 03 dc                 addq     %r12, %rbx
> 0x7f110c00018b:  48 8b 1b                 movq     (%rbx), %rbx
> 0x7f110c00018e:  48 83 fb 15              cmpq     $0x15, %rbx
> 0x7f110c000192:  0f 85 10 00 00 00        jne      0x7f110c0001a8
> 0x7f110c000198:  8b bd f8 da ff ff        movl     -0x2508(%rbp), %edi
> 0x7f110c00019e:  be f0 ff ff ff           movl     $0xfffffff0, %esi
> 0x7f110c0001a3:  e8 78 62 3a 57           callq    0x7f11633a6420
> 0x7f110c0001a8:  c7 45 54 00 f0 00 00     movl     $0xf000, 0x54(%rbp)
> 0x7f110c0001af:  c7 45 58 00 00 0f 00     movl     $0xf0000, 0x58(%rbp)
> 0x7f110c0001b6:  c7 45 20 5b e0 00 00     movl     $0xe05b, 0x20(%rbp)
> 0x7f110c0001bd:  48 8b fd                 movq     %rbp, %rdi
> 0x7f110c0001c0:  ff 15 12 00 00 00        callq    *0x12(%rip)
> 0x7f110c0001c6:  ff e0                    jmpq     *%rax
> 0x7f110c0001c8:  48 8d 05 74 fe ff ff     leaq     -0x18c(%rip), %rax
> 0x7f110c0001cf:  e9 44 fe ff ff           jmp      0x7f110c000018
>   -- tb slow paths + alignment
> 0x7f110c0001d4:  90                       nop
> 0x7f110c0001d5:  90                       nop
> 0x7f110c0001d6:  90                       nop
> 0x7f110c0001d7:  90                       nop
>   data: [size=3D8]
> 0x7f110c0001d8:  .quad  0x000055c2ba75abc0
>
> before continuing to execute.
>
> >
> >
> >>
> >> On Mon, Sep 2, 2024, 16:08 Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >>
> >>  Elisha Hollander <just4now666666@gmail.com> writes:
> >>
> >>  > But for qemu_plugin_update_ns
> >>  >
> >>  > On Mon, Sep 2, 2024, 15:38 Elisha Hollander <
> just4now666666@gmail.com> wrote:
> >>  >
> >>  >  Just checked with 9.0.2 it it still gives the error...
> >>  >
> >>  >  On Wed, Aug 28, 2024, 14:05 Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg>
> wrote:
> >>  >
> >>  >  Elisha Hollander <just4now666666@gmail.com> writes:
> >>  >
> >>  >  > Although it gives `undefined symbol:
> qemu_plugin_scoreboard_free`. But
> >>  >  > probably I messed something up...
> >>  >
> >>  >  Are you using an older QEMU? We should trigger an API warning if
> they
> >>  >  are mismatched but maybe thats not working.
> >>  >
> >>  >  >
> >>  >  > On Tue, Aug 27, 2024, 14:59 Elisha Hollander <
> just4now666666@gmail.com> wrote:
> >>  >  >
> >>  >  >  Oh nice, I didn't know that
> >>  >  >
> >>  >  >  On Tue, Aug 27, 2024, 12:39 Alex Benn=C3=A9e <alex.bennee@linar=
o.org>
> wrote:
> >>  >  >
> >>  >  >  Elisha Hollander <just4now666666@gmail.com> writes:
> >>  >  >
> >>  >  >  > Signed-off-by: Elisha Hollander <just4now666666@gmail.com>
> >>  >  >
> >>  >  >  What is the use-case for this patch?
> >>  >  >
> >>  >  >  If you are simply looking to slow the emulated system down
> please have a
> >>  >  >  look at:
> >>  >  >
> >>  >  >
> https://qemu.readthedocs.io/en/master/about/emulation.html#limit-instruct=
ions-per-second
> >>  >  >
> >>  >  >  which uses the plugin system to limit the run rate and sleep if
> its
> >>  >  >  running too fast. The longer term goal is to deprecate the
> icount clock
> >>  >  >  alignment feature from the core code and leave icount to just
> provide
> >>  >  >  the deterministic execution needed for record/replay and revers=
e
> >>  >  >  debugging.
> >>  >  >
> >>  >  >  > ---
> >>  >  >  >  accel/tcg/cpu-exec.c      | 4 +---
> >>  >  >  >  accel/tcg/icount-common.c | 4 ++--
> >>  >  >  >  2 files changed, 3 insertions(+), 5 deletions(-)
> >>  >  >  >
> >>  >  >  > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> >>  >  >  > index 8163295f34..4c2baf8ed4 100644
> >>  >  >  > --- a/accel/tcg/cpu-exec.c
> >>  >  >  > +++ b/accel/tcg/cpu-exec.c
> >>  >  >  > @@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc,
> CPUState *cpu)
> >>  >  >  >  static void print_delay(const SyncClocks *sc)
> >>  >  >  >  {
> >>  >  >  >      static float threshold_delay;
> >>  >  >  > -    static int64_t last_realtime_clock;
> >>  >  >  >      static int nb_prints;
> >>  >  >  >
> >>  >  >  >      if (icount_align_option &&
> >>  >  >  > -        sc->realtime_clock - last_realtime_clock >=3D
> MAX_DELAY_PRINT_RATE &&
> >>  >  >  > +        sc->diff_clk >=3D MAX_DELAY_PRINT_RATE &&
> >>  >  >  >          nb_prints < MAX_NB_PRINTS) {
> >>  >  >  >          if ((-sc->diff_clk / (float)1000000000LL >
> threshold_delay) ||
> >>  >  >  >              (-sc->diff_clk / (float)1000000000LL <
> >>  >  >  > @@ -109,7 +108,6 @@ static void print_delay(const SyncClocks
> *sc)
> >>  >  >  >                          threshold_delay - 1,
> >>  >  >  >                          threshold_delay);
> >>  >  >  >              nb_prints++;
> >>  >  >  > -            last_realtime_clock =3D sc->realtime_clock;
> >>  >  >  >          }
> >>  >  >  >      }
> >>  >  >  >  }
> >>  >  >  > diff --git a/accel/tcg/icount-common.c
> b/accel/tcg/icount-common.c
> >>  >  >  > index 8d3d3a7e9d..f07f8baf4d 100644
> >>  >  >  > --- a/accel/tcg/icount-common.c
> >>  >  >  > +++ b/accel/tcg/icount-common.c
> >>  >  >  > @@ -46,8 +46,8 @@
> >>  >  >  >   * is TCG-specific, and does not need to be built for other
> accels.
> >>  >  >  >   */
> >>  >  >  >  static bool icount_sleep =3D true;
> >>  >  >  > -/* Arbitrarily pick 1MIPS as the minimum allowable speed.  *=
/
> >>  >  >  > -#define MAX_ICOUNT_SHIFT 10
> >>  >  >  > +/* Arbitrarily pick the minimum allowable speed.  */
> >>  >  >  > +#define MAX_ICOUNT_SHIFT 30
> >>  >  >  >
> >>  >  >  >  /* Do not count executed instructions */
> >>  >  >  >  ICountMode use_icount =3D ICOUNT_DISABLED;
> >>  >  >
> >>  >  >  --
> >>  >  >  Alex Benn=C3=A9e
> >>  >  >  Virtualisation Tech Lead @ Linaro
> >>  >
> >>  >  --
> >>  >  Alex Benn=C3=A9e
> >>  >  Virtualisation Tech Lead @ Linaro
> >>
> >>  Can you give me your command line please?
> >>
> >>  --
> >>  Alex Benn=C3=A9e
> >>  Virtualisation Tech Lead @ Linaro
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--00000000000020315a062138b6a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">weird...</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue=
, Sep 3, 2024, 14:13 Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@lin=
aro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org=
" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt; write=
s:<br>
<br>
&gt; Elisha Hollander &lt;<a href=3D"mailto:just4now666666@gmail.com" targe=
t=3D"_blank" rel=3D"noreferrer">just4now666666@gmail.com</a>&gt; writes:<br=
>
&gt;<br>
&gt;&gt; Sure!<br>
&gt;&gt;<br>
&gt;&gt; `build/qemu-system-i386 -plugin build/contrib/plugins/libips.so,ip=
s=3D1 -display curses -bios bios.raw`<br>
&gt;&gt;<br>
&gt;&gt; Also, I just tested with 9.1.0-rc4 and it resulted with<br>
&gt;&gt; `tcg.c:3167:remove_label_use: code should not be reached`<br>
&gt;<br>
&gt; I can replicate but it seems to be an edge case with ips=3D1, try a hi=
gher<br>
&gt; number, even ips=3D10 doesn&#39;t trigger the crash (but 10 instructio=
ns a<br>
&gt; second is very slow to do anything).<br>
&gt;<br>
&gt;=C2=A0 =C2=A0./qemu-system-i386=C2=A0 -plugin contrib/plugins/libips.so=
,ips=3D1 -display none -serial mon:stdio<br>
&gt;=C2=A0 =C2=A0**<br>
&gt;=C2=A0 =C2=A0ERROR:../../tcg/tcg.c:3167:remove_label_use: code should n=
ot be reached<br>
&gt;=C2=A0 =C2=A0Bail out! ERROR:../../tcg/tcg.c:3167:remove_label_use: cod=
e should not be reached<br>
&gt;=C2=A0 =C2=A0fish: Job 1, &#39;./qemu-system-i386=C2=A0 -plugin con=E2=
=80=A6&#39; terminated by signal<br>
&gt;=C2=A0 =C2=A0SIGABRT (Abort)<br>
<br>
Well this is fascinating and I suspect Richard needs to comment but:<br>
<br>
=C2=A0 ./qemu-system-i386=C2=A0 -plugin contrib/plugins/libips.so,ips=3D9 -=
display none -serial mon:stdio -d in_asm,op,op_opt,out_asm -plugin contrib/=
plugins/libstoptrigger.so,icount=3D20 -D broken.log<br>
=C2=A0 **<br>
=C2=A0 ERROR:../../tcg/tcg.c:3167:remove_label_use: code should not be reac=
hed<br>
=C2=A0 Bail out! ERROR:../../tcg/tcg.c:3167:remove_label_use: code should n=
ot be reached<br>
=C2=A0 fish: Job 1, &#39;./qemu-system-i386=C2=A0 -plugin con=E2=80=A6&#39;=
 terminated by signal SIGABRT (Abort)<br>
<br>
and:<br>
<br>
=C2=A0./qemu-system-i386=C2=A0 -plugin contrib/plugins/libips.so,ips=3D10 -=
display none -serial mon:stdio -d in_asm,op,op_opt,out_asm -plugin contrib/=
plugins/libstoptrigger.so,icount=3D20 -D working.log<br>
<br>
But for the life of me I can&#39;t see the difference between the two sets<=
br>
of input, the first crashes before the optimisation step:<br>
<br>
PROLOGUE: [size=3D45]<br>
0x7f2198000000:=C2=A0 55=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pushq=C2=A0 =C2=A0 %rbp<br>
0x7f2198000001:=C2=A0 53=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pushq=C2=A0 =C2=A0 %rbx<br>
0x7f2198000002:=C2=A0 41 54=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 pushq=C2=A0 =C2=A0 %r12<br>
0x7f2198000004:=C2=A0 41 55=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 pushq=C2=A0 =C2=A0 %r13<br>
0x7f2198000006:=C2=A0 41 56=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 pushq=C2=A0 =C2=A0 %r14<br>
0x7f2198000008:=C2=A0 41 57=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 pushq=C2=A0 =C2=A0 %r15<br>
0x7f219800000a:=C2=A0 48 8b ef=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0movq=C2=A0 =C2=A0 =C2=A0%rdi, %rbp<br>
0x7f219800000d:=C2=A0 48 81 c4 78 fb ff ff=C2=A0 =C2=A0 =C2=A0addq=C2=A0 =
=C2=A0 =C2=A0$-0x488, %rsp<br>
0x7f2198000014:=C2=A0 ff e6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 jmpq=C2=A0 =C2=A0 =C2=A0*%rsi<br>
0x7f2198000016:=C2=A0 33 c0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 xorl=C2=A0 =C2=A0 =C2=A0%eax, %eax<br>
0x7f2198000018:=C2=A0 48 81 c4 88 04 00 00=C2=A0 =C2=A0 =C2=A0addq=C2=A0 =
=C2=A0 =C2=A0$0x488, %rsp<br>
0x7f219800001f:=C2=A0 c5 f8 77=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0vzeroupper <br>
0x7f2198000022:=C2=A0 41 5f=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 popq=C2=A0 =C2=A0 =C2=A0%r15<br>
0x7f2198000024:=C2=A0 41 5e=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 popq=C2=A0 =C2=A0 =C2=A0%r14<br>
0x7f2198000026:=C2=A0 41 5d=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 popq=C2=A0 =C2=A0 =C2=A0%r13<br>
0x7f2198000028:=C2=A0 41 5c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 popq=C2=A0 =C2=A0 =C2=A0%r12<br>
0x7f219800002a:=C2=A0 5b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0popq=C2=A0 =C2=A0 =C2=A0%rbx<br>
0x7f219800002b:=C2=A0 5d=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0popq=C2=A0 =C2=A0 =C2=A0%rbp<br>
0x7f219800002c:=C2=A0 c3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retq=C2=A0 =C2=A0 =C2=A0<br>
<br>
----------------<br>
IN: <br>
0xfffffff0:=C2=A0 ea 5b e0 00 f0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lj=
mpw=C2=A0 =C2=A0 $0xf000:$0xe05b<br>
<br>
OP:<br>
=C2=A0ld_i32 loc9,env,$0xfffffffffffffff8<br>
=C2=A0brcond_i32 loc9,$0x0,lt,$L0<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8<br>
=C2=A0mul_i32 tmp18,tmp18,$0x18<br>
=C2=A0ext_i32_i64 tmp17,tmp18<br>
=C2=A0add_i64 tmp17,tmp17,$0x55912c381e38<br>
=C2=A0ld_i64 tmp21,tmp17,$0x0<br>
=C2=A0add_i64 tmp21,tmp21,$0x1<br>
=C2=A0st_i64 tmp21,tmp17,$0x0<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8<br>
=C2=A0mul_i32 tmp18,tmp18,$0x18<br>
=C2=A0ext_i32_i64 tmp17,tmp18<br>
=C2=A0add_i64 tmp17,tmp17,$0x55912c381e38<br>
=C2=A0ld_i64 tmp21,tmp17,$0x0<br>
=C2=A0brcond_i64 tmp21,$0x0,ltu,$L1<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8<br>
=C2=A0call plugin(0x7f21efe82550),$0x1,$0,tmp18,$0x0<br>
=C2=A0set_label $L1<br>
=C2=A0st8_i32 $0x1,env,$0xfffffffffffffffc<br>
<br>
=C2=A0---- 0000000000000ff0 0000000000000000<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8<br>
=C2=A0shl_i32 tmp18,tmp18,$0x3<br>
=C2=A0ext_i32_i64 tmp17,tmp18<br>
=C2=A0add_i64 tmp17,tmp17,$0x55912c3803b0<br>
=C2=A0ld_i64 tmp21,tmp17,$0x0<br>
=C2=A0add_i64 tmp21,tmp21,$0x1<br>
=C2=A0st_i64 tmp21,tmp17,$0x0<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8<br>
=C2=A0shl_i32 tmp18,tmp18,$0x3<br>
=C2=A0ext_i32_i64 tmp17,tmp18<br>
=C2=A0add_i64 tmp17,tmp17,$0x55912c3803b0<br>
=C2=A0ld_i64 tmp21,tmp17,$0x0<br>
=C2=A0brcond_i64 tmp21,$0x15,ne,$L2<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8<br>
=C2=A0call plugin(0x7f21efe7d420),$0x1,$0,tmp18,$0xfffffff0<br>
=C2=A0set_label $L2<br>
=C2=A0mov_i32 loc0,$0xe05b<br>
=C2=A0mov_i32 loc1,$0xf000<br>
=C2=A0ext16u_i32 loc13,loc1<br>
=C2=A0st_i32 loc13,env,$0x54<br>
=C2=A0shl_i32 cs_base,loc13,$0x4<br>
=C2=A0mov_i32 eip,loc0<br>
=C2=A0call lookup_tb_ptr,$0x6,$1,tmp15,env<br>
=C2=A0goto_ptr tmp15<br>
=C2=A0set_label $L0<br>
=C2=A0exit_tb $0x7f2198000043<br>
<br>
=C2=A0BOOM!!!<br>
<br>
and the working case:<br>
<br>
PROLOGUE: [size=3D45]<br>
0x7f110c000000:=C2=A0 55=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pushq=C2=A0 =C2=A0 %rbp<br>
0x7f110c000001:=C2=A0 53=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pushq=C2=A0 =C2=A0 %rbx<br>
0x7f110c000002:=C2=A0 41 54=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 pushq=C2=A0 =C2=A0 %r12<br>
0x7f110c000004:=C2=A0 41 55=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 pushq=C2=A0 =C2=A0 %r13<br>
0x7f110c000006:=C2=A0 41 56=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 pushq=C2=A0 =C2=A0 %r14<br>
0x7f110c000008:=C2=A0 41 57=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 pushq=C2=A0 =C2=A0 %r15<br>
0x7f110c00000a:=C2=A0 48 8b ef=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0movq=C2=A0 =C2=A0 =C2=A0%rdi, %rbp<br>
0x7f110c00000d:=C2=A0 48 81 c4 78 fb ff ff=C2=A0 =C2=A0 =C2=A0addq=C2=A0 =
=C2=A0 =C2=A0$-0x488, %rsp<br>
0x7f110c000014:=C2=A0 ff e6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 jmpq=C2=A0 =C2=A0 =C2=A0*%rsi<br>
0x7f110c000016:=C2=A0 33 c0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 xorl=C2=A0 =C2=A0 =C2=A0%eax, %eax<br>
0x7f110c000018:=C2=A0 48 81 c4 88 04 00 00=C2=A0 =C2=A0 =C2=A0addq=C2=A0 =
=C2=A0 =C2=A0$0x488, %rsp<br>
0x7f110c00001f:=C2=A0 c5 f8 77=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0vzeroupper <br>
0x7f110c000022:=C2=A0 41 5f=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 popq=C2=A0 =C2=A0 =C2=A0%r15<br>
0x7f110c000024:=C2=A0 41 5e=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 popq=C2=A0 =C2=A0 =C2=A0%r14<br>
0x7f110c000026:=C2=A0 41 5d=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 popq=C2=A0 =C2=A0 =C2=A0%r13<br>
0x7f110c000028:=C2=A0 41 5c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 popq=C2=A0 =C2=A0 =C2=A0%r12<br>
0x7f110c00002a:=C2=A0 5b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0popq=C2=A0 =C2=A0 =C2=A0%rbx<br>
0x7f110c00002b:=C2=A0 5d=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0popq=C2=A0 =C2=A0 =C2=A0%rbp<br>
0x7f110c00002c:=C2=A0 c3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retq=C2=A0 =C2=A0 =C2=A0<br>
<br>
----------------<br>
IN: <br>
0xfffffff0:=C2=A0 ea 5b e0 00 f0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lj=
mpw=C2=A0 =C2=A0 $0xf000:$0xe05b<br>
<br>
OP:<br>
=C2=A0ld_i32 loc9,env,$0xfffffffffffffff8<br>
=C2=A0brcond_i32 loc9,$0x0,lt,$L0<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8<br>
=C2=A0mul_i32 tmp18,tmp18,$0x18<br>
=C2=A0ext_i32_i64 tmp17,tmp18<br>
=C2=A0add_i64 tmp17,tmp17,$0x55c2cb346e38<br>
=C2=A0ld_i64 tmp21,tmp17,$0x0<br>
=C2=A0add_i64 tmp21,tmp21,$0x1<br>
=C2=A0st_i64 tmp21,tmp17,$0x0<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8<br>
=C2=A0mul_i32 tmp18,tmp18,$0x18<br>
=C2=A0ext_i32_i64 tmp17,tmp18<br>
=C2=A0add_i64 tmp17,tmp17,$0x55c2cb346e38<br>
=C2=A0ld_i64 tmp21,tmp17,$0x0<br>
=C2=A0brcond_i64 tmp21,$0x1,ltu,$L1<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8<br>
=C2=A0call plugin(0x7f11633ab550),$0x1,$0,tmp18,$0x0<br>
=C2=A0set_label $L1<br>
=C2=A0st8_i32 $0x1,env,$0xfffffffffffffffc<br>
<br>
=C2=A0---- 0000000000000ff0 0000000000000000<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8<br>
=C2=A0shl_i32 tmp18,tmp18,$0x3<br>
=C2=A0ext_i32_i64 tmp17,tmp18<br>
=C2=A0add_i64 tmp17,tmp17,$0x55c2cb3453b0<br>
=C2=A0ld_i64 tmp21,tmp17,$0x0<br>
=C2=A0add_i64 tmp21,tmp21,$0x1<br>
=C2=A0st_i64 tmp21,tmp17,$0x0<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8<br>
=C2=A0shl_i32 tmp18,tmp18,$0x3<br>
=C2=A0ext_i32_i64 tmp17,tmp18<br>
=C2=A0add_i64 tmp17,tmp17,$0x55c2cb3453b0<br>
=C2=A0ld_i64 tmp21,tmp17,$0x0<br>
=C2=A0brcond_i64 tmp21,$0x15,ne,$L2<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8<br>
=C2=A0call plugin(0x7f11633a6420),$0x1,$0,tmp18,$0xfffffff0<br>
=C2=A0set_label $L2<br>
=C2=A0mov_i32 loc0,$0xe05b<br>
=C2=A0mov_i32 loc1,$0xf000<br>
=C2=A0ext16u_i32 loc13,loc1<br>
=C2=A0st_i32 loc13,env,$0x54<br>
=C2=A0shl_i32 cs_base,loc13,$0x4<br>
=C2=A0mov_i32 eip,loc0<br>
=C2=A0call lookup_tb_ptr,$0x6,$1,tmp15,env<br>
=C2=A0goto_ptr tmp15<br>
=C2=A0set_label $L0<br>
=C2=A0exit_tb $0x7f110c000043<br>
<br>
OP after optimization and liveness analysis:<br>
=C2=A0ld_i32 tmp9,env,$0xfffffffffffffff8=C2=A0 =C2=A0 =C2=A0 pref=3D0xffff=
<br>
=C2=A0brcond_i32 tmp9,$0x0,lt,$L0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dead: 0 1<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8=C2=A0 =C2=A0 =C2=A0pref=3D0xffff=
<br>
=C2=A0mul_i32 tmp18,tmp18,$0x18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dead: 1=C2=A0 pref=3D0xffff<br>
=C2=A0ext_i32_i64 tmp17,tmp18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 dead: 1=C2=A0 pref=3D0xffff<br>
=C2=A0add_i64 tmp17,tmp17,$0x55c2cb346e38=C2=A0 =C2=A0 =C2=A0 dead: 1=C2=A0=
 pref=3D0xffff<br>
=C2=A0ld_i64 tmp21,tmp17,$0x0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 pref=3D0xffff<br>
=C2=A0add_i64 tmp21,tmp21,$0x1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0dead: 1=C2=A0 pref=3D0xffff<br>
=C2=A0st_i64 tmp21,tmp17,$0x0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 dead: 0 1<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8=C2=A0 =C2=A0 =C2=A0pref=3D0xffff=
<br>
=C2=A0mul_i32 tmp18,tmp18,$0x18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dead: 1 2=C2=A0 pref=3D0xffff<br>
=C2=A0ext_i32_i64 tmp17,tmp18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 dead: 1=C2=A0 pref=3D0xffff<br>
=C2=A0add_i64 tmp17,tmp17,$0x55c2cb346e38=C2=A0 =C2=A0 =C2=A0 dead: 1 2=C2=
=A0 pref=3D0xffff<br>
=C2=A0ld_i64 tmp21,tmp17,$0x0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 dead: 1=C2=A0 pref=3D0xffff<br>
=C2=A0brcond_i64 tmp21,$0x1,ltu,$L1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dead: 0 1<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8=C2=A0 =C2=A0 =C2=A0dead: 1=C2=A0=
 pref=3D0x80<br>
=C2=A0call plugin(0x7f11633ab550),$0x1,$0,tmp18,$0x0=C2=A0 dead: 0 1<br>
=C2=A0set_label $L1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
=C2=A0st8_i32 $0x1,env,$0xfffffffffffffffc=C2=A0 =C2=A0 =C2=A0dead: 0<br>
<br>
=C2=A0---- 0000000000000ff0 0000000000000000<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8=C2=A0 =C2=A0 =C2=A0pref=3D0xffff=
<br>
=C2=A0shl_i32 tmp18,tmp18,$0x3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0dead: 1=C2=A0 pref=3D0xffff<br>
=C2=A0ext_i32_i64 tmp17,tmp18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 dead: 1=C2=A0 pref=3D0xffff<br>
=C2=A0add_i64 tmp17,tmp17,$0x55c2cb3453b0=C2=A0 =C2=A0 =C2=A0 dead: 1=C2=A0=
 pref=3D0xffff<br>
=C2=A0ld_i64 tmp21,tmp17,$0x0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 pref=3D0xffff<br>
=C2=A0add_i64 tmp21,tmp21,$0x1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0dead: 1 2=C2=A0 pref=3D0xffff<br>
=C2=A0st_i64 tmp21,tmp17,$0x0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 dead: 0 1<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8=C2=A0 =C2=A0 =C2=A0pref=3D0xffff=
<br>
=C2=A0shl_i32 tmp18,tmp18,$0x3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0dead: 1 2=C2=A0 pref=3D0xffff<br>
=C2=A0ext_i32_i64 tmp17,tmp18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 dead: 1=C2=A0 pref=3D0xffff<br>
=C2=A0add_i64 tmp17,tmp17,$0x55c2cb3453b0=C2=A0 =C2=A0 =C2=A0 dead: 1 2=C2=
=A0 pref=3D0xffff<br>
=C2=A0ld_i64 tmp21,tmp17,$0x0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 dead: 1=C2=A0 pref=3D0xffff<br>
=C2=A0brcond_i64 tmp21,$0x15,ne,$L2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dead: 0 1<br>
=C2=A0ld_i32 tmp18,env,$0xffffffffffffdaf8=C2=A0 =C2=A0 =C2=A0dead: 1=C2=A0=
 pref=3D0x80<br>
=C2=A0call plugin(0x7f11633a6420),$0x1,$0,tmp18,$0xfffffff0=C2=A0 dead: 0 1=
<br>
=C2=A0set_label $L2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
=C2=A0st_i32 $0xf000,env,$0x54=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0dead: 0<br>
=C2=A0mov_i32 cs_base,$0xf0000=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0sync: 0=C2=A0 dead: 0 1=C2=A0 pref=3D0xffff<br>
=C2=A0mov_i32 eip,$0xe05b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sync: 0=C2=A0 dead: 0 1=C2=A0 pref=3D0xffff<br>
=C2=A0call lookup_tb_ptr,$0x6,$1,tmp15,env=C2=A0 =C2=A0 =C2=A0dead: 1=C2=A0=
 pref=3Dnone<br>
=C2=A0goto_ptr tmp15=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dead: 0<br>
=C2=A0set_label $L0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
=C2=A0exit_tb $0x7f110c000043=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <br>
<br>
OUT: [size=3D224]<br>
=C2=A0 -- guest addr 0x0000000000000ff0 + tb prologue<br>
0x7f110c000100:=C2=A0 8b 5d f8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0movl=C2=A0 =C2=A0 =C2=A0-8(%rbp), %ebx<br>
0x7f110c000103:=C2=A0 85 db=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 testl=C2=A0 =C2=A0 %ebx, %ebx<br>
0x7f110c000105:=C2=A0 0f 8c bd 00 00 00=C2=A0 =C2=A0 =C2=A0 =C2=A0 jl=C2=A0=
 =C2=A0 =C2=A0 =C2=A00x7f110c0001c8<br>
0x7f110c00010b:=C2=A0 8b 9d f8 da ff ff=C2=A0 =C2=A0 =C2=A0 =C2=A0 movl=C2=
=A0 =C2=A0 =C2=A0-0x2508(%rbp), %ebx<br>
0x7f110c000111:=C2=A0 6b db 18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0imull=C2=A0 =C2=A0 $0x18, %ebx, %ebx<br>
0x7f110c000114:=C2=A0 48 63 db=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0movslq=C2=A0 =C2=A0%ebx, %rbx<br>
0x7f110c000117:=C2=A0 49 bc 38 6e 34 cb c2 55=C2=A0 movabsq=C2=A0 $0x55c2cb=
346e38, %r12<br>
0x7f110c00011f:=C2=A0 00 00<br>
0x7f110c000121:=C2=A0 49 03 dc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0addq=C2=A0 =C2=A0 =C2=A0%r12, %rbx<br>
0x7f110c000124:=C2=A0 4c 8b 2b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0movq=C2=A0 =C2=A0 =C2=A0(%rbx), %r13<br>
0x7f110c000127:=C2=A0 49 ff c5=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0incq=C2=A0 =C2=A0 =C2=A0%r13<br>
0x7f110c00012a:=C2=A0 4c 89 2b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0movq=C2=A0 =C2=A0 =C2=A0%r13, (%rbx)<br>
0x7f110c00012d:=C2=A0 8b 9d f8 da ff ff=C2=A0 =C2=A0 =C2=A0 =C2=A0 movl=C2=
=A0 =C2=A0 =C2=A0-0x2508(%rbp), %ebx<br>
0x7f110c000133:=C2=A0 6b db 18=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0imull=C2=A0 =C2=A0 $0x18, %ebx, %ebx<br>
0x7f110c000136:=C2=A0 48 63 db=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0movslq=C2=A0 =C2=A0%ebx, %rbx<br>
0x7f110c000139:=C2=A0 49 03 dc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0addq=C2=A0 =C2=A0 =C2=A0%r12, %rbx<br>
0x7f110c00013c:=C2=A0 48 8b 1b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0movq=C2=A0 =C2=A0 =C2=A0(%rbx), %rbx<br>
0x7f110c00013f:=C2=A0 48 83 fb 01=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cmpq=C2=A0 =C2=A0 =C2=A0$1, %rbx<br>
0x7f110c000143:=C2=A0 0f 82 0d 00 00 00=C2=A0 =C2=A0 =C2=A0 =C2=A0 jb=C2=A0=
 =C2=A0 =C2=A0 =C2=A00x7f110c000156<br>
0x7f110c000149:=C2=A0 8b bd f8 da ff ff=C2=A0 =C2=A0 =C2=A0 =C2=A0 movl=C2=
=A0 =C2=A0 =C2=A0-0x2508(%rbp), %edi<br>
0x7f110c00014f:=C2=A0 33 f6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 xorl=C2=A0 =C2=A0 =C2=A0%esi, %esi<br>
0x7f110c000151:=C2=A0 e8 fa b3 3a 57=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0callq=C2=A0 =C2=A0 0x7f11633ab550<br>
0x7f110c000156:=C2=A0 c6 45 fc 01=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 movb=C2=A0 =C2=A0 =C2=A0$1, -4(%rbp)<br>
0x7f110c00015a:=C2=A0 8b 9d f8 da ff ff=C2=A0 =C2=A0 =C2=A0 =C2=A0 movl=C2=
=A0 =C2=A0 =C2=A0-0x2508(%rbp), %ebx<br>
0x7f110c000160:=C2=A0 c1 e3 03=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0shll=C2=A0 =C2=A0 =C2=A0$3, %ebx<br>
0x7f110c000163:=C2=A0 48 63 db=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0movslq=C2=A0 =C2=A0%ebx, %rbx<br>
0x7f110c000166:=C2=A0 49 bc b0 53 34 cb c2 55=C2=A0 movabsq=C2=A0 $0x55c2cb=
3453b0, %r12<br>
0x7f110c00016e:=C2=A0 00 00<br>
0x7f110c000170:=C2=A0 49 03 dc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0addq=C2=A0 =C2=A0 =C2=A0%r12, %rbx<br>
0x7f110c000173:=C2=A0 4c 8b 2b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0movq=C2=A0 =C2=A0 =C2=A0(%rbx), %r13<br>
0x7f110c000176:=C2=A0 49 ff c5=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0incq=C2=A0 =C2=A0 =C2=A0%r13<br>
0x7f110c000179:=C2=A0 4c 89 2b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0movq=C2=A0 =C2=A0 =C2=A0%r13, (%rbx)<br>
0x7f110c00017c:=C2=A0 8b 9d f8 da ff ff=C2=A0 =C2=A0 =C2=A0 =C2=A0 movl=C2=
=A0 =C2=A0 =C2=A0-0x2508(%rbp), %ebx<br>
0x7f110c000182:=C2=A0 c1 e3 03=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0shll=C2=A0 =C2=A0 =C2=A0$3, %ebx<br>
0x7f110c000185:=C2=A0 48 63 db=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0movslq=C2=A0 =C2=A0%ebx, %rbx<br>
0x7f110c000188:=C2=A0 49 03 dc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0addq=C2=A0 =C2=A0 =C2=A0%r12, %rbx<br>
0x7f110c00018b:=C2=A0 48 8b 1b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0movq=C2=A0 =C2=A0 =C2=A0(%rbx), %rbx<br>
0x7f110c00018e:=C2=A0 48 83 fb 15=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cmpq=C2=A0 =C2=A0 =C2=A0$0x15, %rbx<br>
0x7f110c000192:=C2=A0 0f 85 10 00 00 00=C2=A0 =C2=A0 =C2=A0 =C2=A0 jne=C2=
=A0 =C2=A0 =C2=A0 0x7f110c0001a8<br>
0x7f110c000198:=C2=A0 8b bd f8 da ff ff=C2=A0 =C2=A0 =C2=A0 =C2=A0 movl=C2=
=A0 =C2=A0 =C2=A0-0x2508(%rbp), %edi<br>
0x7f110c00019e:=C2=A0 be f0 ff ff ff=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0movl=C2=A0 =C2=A0 =C2=A0$0xfffffff0, %esi<br>
0x7f110c0001a3:=C2=A0 e8 78 62 3a 57=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0callq=C2=A0 =C2=A0 0x7f11633a6420<br>
0x7f110c0001a8:=C2=A0 c7 45 54 00 f0 00 00=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =
=C2=A0 =C2=A0$0xf000, 0x54(%rbp)<br>
0x7f110c0001af:=C2=A0 c7 45 58 00 00 0f 00=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =
=C2=A0 =C2=A0$0xf0000, 0x58(%rbp)<br>
0x7f110c0001b6:=C2=A0 c7 45 20 5b e0 00 00=C2=A0 =C2=A0 =C2=A0movl=C2=A0 =
=C2=A0 =C2=A0$0xe05b, 0x20(%rbp)<br>
0x7f110c0001bd:=C2=A0 48 8b fd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0movq=C2=A0 =C2=A0 =C2=A0%rbp, %rdi<br>
0x7f110c0001c0:=C2=A0 ff 15 12 00 00 00=C2=A0 =C2=A0 =C2=A0 =C2=A0 callq=C2=
=A0 =C2=A0 *0x12(%rip)<br>
0x7f110c0001c6:=C2=A0 ff e0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 jmpq=C2=A0 =C2=A0 =C2=A0*%rax<br>
0x7f110c0001c8:=C2=A0 48 8d 05 74 fe ff ff=C2=A0 =C2=A0 =C2=A0leaq=C2=A0 =
=C2=A0 =C2=A0-0x18c(%rip), %rax<br>
0x7f110c0001cf:=C2=A0 e9 44 fe ff ff=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0jmp=C2=A0 =C2=A0 =C2=A0 0x7f110c000018<br>
=C2=A0 -- tb slow paths + alignment<br>
0x7f110c0001d4:=C2=A0 90=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nop=C2=A0 =C2=A0 =C2=A0 <br>
0x7f110c0001d5:=C2=A0 90=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nop=C2=A0 =C2=A0 =C2=A0 <br>
0x7f110c0001d6:=C2=A0 90=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nop=C2=A0 =C2=A0 =C2=A0 <br>
0x7f110c0001d7:=C2=A0 90=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nop=C2=A0 =C2=A0 =C2=A0 <br>
=C2=A0 data: [size=3D8]<br>
0x7f110c0001d8:=C2=A0 .quad=C2=A0 0x000055c2ba75abc0<br>
<br>
before continuing to execute.<br>
<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Sep 2, 2024, 16:08 Alex Benn=C3=A9e &lt;<a href=3D"mailto:=
alex.bennee@linaro.org" target=3D"_blank" rel=3D"noreferrer">alex.bennee@li=
naro.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 Elisha Hollander &lt;<a href=3D"mailto:just4now666666@gmail.=
com" target=3D"_blank" rel=3D"noreferrer">just4now666666@gmail.com</a>&gt; =
writes:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 &gt; But for qemu_plugin_update_ns<br>
&gt;&gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt; On Mon, Sep 2, 2024, 15:38 Elisha Hollander &lt;<a href=
=3D"mailto:just4now666666@gmail.com" target=3D"_blank" rel=3D"noreferrer">j=
ust4now666666@gmail.com</a>&gt; wrote:<br>
&gt;&gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 Just checked with 9.0.2 it it still gives the err=
or...<br>
&gt;&gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 On Wed, Aug 28, 2024, 14:05 Alex Benn=C3=A9e &lt;=
<a href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank" rel=3D"noreferr=
er">alex.bennee@linaro.org</a>&gt; wrote:<br>
&gt;&gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 Elisha Hollander &lt;<a href=3D"mailto:just4now66=
6666@gmail.com" target=3D"_blank" rel=3D"noreferrer">just4now666666@gmail.c=
om</a>&gt; writes:<br>
&gt;&gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt; Although it gives `undefined symbol: qemu_pl=
ugin_scoreboard_free`. But<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt; probably I messed something up...<br>
&gt;&gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 Are you using an older QEMU? We should trigger an=
 API warning if they<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 are mismatched but maybe thats not working.<br>
&gt;&gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt; On Tue, Aug 27, 2024, 14:59 Elisha Hollander=
 &lt;<a href=3D"mailto:just4now666666@gmail.com" target=3D"_blank" rel=3D"n=
oreferrer">just4now666666@gmail.com</a>&gt; wrote:<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 Oh nice, I didn&#39;t know that<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 On Tue, Aug 27, 2024, 12:39 Alex Benn=
=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank" rel=
=3D"noreferrer">alex.bennee@linaro.org</a>&gt; wrote:<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 Elisha Hollander &lt;<a href=3D"mailto=
:just4now666666@gmail.com" target=3D"_blank" rel=3D"noreferrer">just4now666=
666@gmail.com</a>&gt; writes:<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; Signed-off-by: Elisha Hollander &=
lt;<a href=3D"mailto:just4now666666@gmail.com" target=3D"_blank" rel=3D"nor=
eferrer">just4now666666@gmail.com</a>&gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 What is the use-case for this patch?<b=
r>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 If you are simply looking to slow the =
emulated system down please have a<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 look at:<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 <a href=3D"https://qemu.readthe=
docs.io/en/master/about/emulation.html#limit-instructions-per-second" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://qemu.readthedocs.io/en=
/master/about/emulation.html#limit-instructions-per-second</a><br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 which uses the plugin system to limit =
the run rate and sleep if its<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 running too fast. The longer term goal=
 is to deprecate the icount clock<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 alignment feature from the core code a=
nd leave icount to just provide<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 the deterministic execution needed for=
 record/replay and reverse<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 debugging.<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; ---<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 accel/tcg/cpu-exec.c=C2=A0 =
=C2=A0 =C2=A0 | 4 +---<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 accel/tcg/icount-common.c |=
 4 ++--<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 2 files changed, 3 insertio=
ns(+), 5 deletions(-)<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; diff --git a/accel/tcg/cpu-exec.c=
 b/accel/tcg/cpu-exec.c<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; index 8163295f34..4c2baf8ed4 1006=
44<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; --- a/accel/tcg/cpu-exec.c<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; +++ b/accel/tcg/cpu-exec.c<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; @@ -95,11 +95,10 @@ static void a=
lign_clocks(SyncClocks *sc, CPUState *cpu)<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 static void print_delay(con=
st SyncClocks *sc)<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 {<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 static float =
threshold_delay;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; -=C2=A0 =C2=A0 static int64_t las=
t_realtime_clock;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 static int nb=
_prints;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 <br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (icount_al=
ign_option &amp;&amp;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sc-&=
gt;realtime_clock - last_realtime_clock &gt;=3D MAX_DELAY_PRINT_RATE &amp;&=
amp;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sc-&=
gt;diff_clk &gt;=3D MAX_DELAY_PRINT_RATE &amp;&amp;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 nb_prints &lt; MAX_NB_PRINTS) {<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if ((-sc-&gt;diff_clk / (float)1000000000LL &gt; threshold_delay) ||<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (-sc-&gt;diff_clk / (float)1000000000LL &lt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; @@ -109,7 +108,6 @@ static void p=
rint_delay(const SyncClocks *sc)<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 threshold_delay - =
1,<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 threshold_delay);<=
br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 nb_prints++;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 last_realtime_clock =3D sc-&gt;realtime_clock;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 }<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 }<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; diff --git a/accel/tcg/icount-com=
mon.c b/accel/tcg/icount-common.c<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; index 8d3d3a7e9d..f07f8baf4d 1006=
44<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; --- a/accel/tcg/icount-common.c<b=
r>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; +++ b/accel/tcg/icount-common.c<b=
r>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; @@ -46,8 +46,8 @@<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0* is TCG-specific, an=
d does not need to be built for other accels.<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0*/<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 static bool icount_sleep =
=3D true;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; -/* Arbitrarily pick 1MIPS as the=
 minimum allowable speed.=C2=A0 */<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; -#define MAX_ICOUNT_SHIFT 10<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; +/* Arbitrarily pick the minimum =
allowable speed.=C2=A0 */<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt; +#define MAX_ICOUNT_SHIFT 30<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 <br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 /* Do not count executed in=
structions */<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 ICountMode use_icount =3D I=
COUNT_DISABLED;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 -- <br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 Alex Benn=C3=A9e<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 Virtualisation Tech Lead @ Linaro<br>
&gt;&gt;=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 -- <br>
&gt;&gt;=C2=A0 &gt;=C2=A0 Alex Benn=C3=A9e<br>
&gt;&gt;=C2=A0 &gt;=C2=A0 Virtualisation Tech Lead @ Linaro<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 Can you give me your command line please?<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 -- <br>
&gt;&gt;=C2=A0 Alex Benn=C3=A9e<br>
&gt;&gt;=C2=A0 Virtualisation Tech Lead @ Linaro<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>

--00000000000020315a062138b6a1--

