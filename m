Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110D8C27C6E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 18:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHonH-0006GZ-34; Thu, 13 Jun 2024 14:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sHonF-0006GK-IT
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 14:03:25 -0400
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sHonD-0004Zi-Qz
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 14:03:25 -0400
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-375932c953aso6092035ab.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718301801; x=1718906601; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3H34AuMlg7H7IpZ/aoI9mSNwD+sbwbn83dY+ZyAwmoQ=;
 b=TpuPhc91Y/OIX8TIGLEGJqvL0J3LQFXQxWZ6jOswAyvdolypP9rw0GEjqF1pn+vw3l
 AxfBXSbC+7wH1GXpZqc7V1ZiZqGTaYjmKXiDGcW+/iB4ApB7zrMHygn472mdgyEMmoLF
 KckSWRgEwx7tQVcs+8qAtZ5TBwVXPycT1Q1EvJhwONTt4DQ6aS0VoTER+5PSDk9prbI8
 5fxv/wLYG643cLzB/BsR05uPv3E26cN6D2+kZo3mQ4re2e05GdDZL8jB0CeDuVrsutYb
 cpBqkKVQzbDdt4nD82xUEPk2EfC9OkpH/REBFinBYlXv7D+faFzYPTjLH7TxDs+y6i6u
 Bndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718301801; x=1718906601;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3H34AuMlg7H7IpZ/aoI9mSNwD+sbwbn83dY+ZyAwmoQ=;
 b=oZN/04VpZ1IZAPpr4qQGDHLeJOb+AIPX7qwyXnwcLTYkGhqh8LDdwXau/Lxzj+3/We
 BgX52bQTWh0FqZc/LcE23ex47keTH0/Anrkc/wH/AicQXk3NsWDxEFuoT/0dk4NnzApP
 2neKqamPSOVOatBD9PExceEhbyKZWbxPzdxSi3yzUNkKBmJRfoz6o2Ky0GRhawWo6+cX
 GXbY9H9bCWH+9NrNbXByZtxafo7SrlCmTvP8yxvwJkoTVb7aW3A15E96v8uxAZlItTrk
 0LOq+lxWDq9g9Dxhtwb4KpoZnkNdJiw5fXZ4gLLIuop29vSLU6re2hFqySJmAvstBP0H
 pEOQ==
X-Gm-Message-State: AOJu0YyvpKi8q6XnkCiFs15dE3I6HWuInJ31i4cEBMKAp9WnV9K2x53H
 pEKtB2B6yVtz/gLVDs37CqGUJzHh0K9JxBS9v7zCtgd2g7w1ecUS
X-Google-Smtp-Source: AGHT+IEQODMx9Om6Y/C7MkuCMz2GgiTajWvNVgvD5DUYu9LfXQ/W1BlukwAphChD6y4QBC6bYRaqBg==
X-Received: by 2002:a05:6e02:198f:b0:375:a3a9:db41 with SMTP id
 e9e14a558f8ab-375e0e3129fmr3867705ab.15.1718301801506; 
 Thu, 13 Jun 2024 11:03:21 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:284:8201:81c0:582b:6312:c6b:a6f0])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9568ddeb0sm465072173.3.2024.06.13.11.03.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2024 11:03:20 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Ted Woodward'" <tedwood@quicinc.com>,
 "'Matheus Bernardino \(QUIC\)'" <quic_mathbern@quicinc.com>
Cc: <qemu-devel@nongnu.org>, "'Brian Cain'" <bcain@quicinc.com>,
 <alex.bennee@linaro.org>, "'Sid Manning'" <sidneym@quicinc.com>,
 "'Marco Liebel \(QUIC\)'" <quic_mliebel@quicinc.com>,
 <richard.henderson@linaro.org>, <philmd@linaro.org>, <ale@rev.ng>,
 <anjo@rev.ng>
References: <20240612164239.90276-1-ltaylorsimpson@gmail.com>
 <20240612183008.4123155-1-quic_mathbern@quicinc.com>
 <066c01dabd3c$343be980$9cb3bc80$@gmail.com>
 <PH0PR02MB842235CD70F3B06BB27FA447B9C12@PH0PR02MB8422.namprd02.prod.outlook.com>
In-Reply-To: <PH0PR02MB842235CD70F3B06BB27FA447B9C12@PH0PR02MB8422.namprd02.prod.outlook.com>
Subject: RE: [PATCH] Hexagon: lldb read/write predicate registers p0/p1/p2/p3
Date: Thu, 13 Jun 2024 12:03:19 -0600
Message-ID: <06e801dabdbb$f9de7250$ed9b56f0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHMHiXUmCnzvbCFbV64tIsn2swJnwIEBIVEAir82UQCs7Xr6bGsIe7A
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Ted Woodward <tedwood@quicinc.com>
> Sent: Thursday, June 13, 2024 9:03 AM
> To: ltaylorsimpson@gmail.com; Matheus Bernardino (QUIC)
> <quic_mathbern@quicinc.com>
> Cc: qemu-devel@nongnu.org; Brian Cain <bcain@quicinc.com>;
> alex.bennee@linaro.org; Sid Manning <sidneym@quicinc.com>; Marco
> Liebel (QUIC) <quic_mliebel@quicinc.com>; richard.henderson@linaro.org;
> philmd@linaro.org; ale@rev.ng; anjo@rev.ng
> Subject: RE: [PATCH] Hexagon: lldb read/write predicate registers
> p0/p1/p2/p3
> 
> 
> 
> > -----Original Message-----
> > From: ltaylorsimpson@gmail.com <ltaylorsimpson@gmail.com>
> > Sent: Wednesday, June 12, 2024 9:49 PM
> > To: Matheus Bernardino (QUIC) <quic_mathbern@quicinc.com>
> > Cc: qemu-devel@nongnu.org; Brian Cain <bcain@quicinc.com>; Ted
> > Woodward <tedwood@quicinc.com>; alex.bennee@linaro.org; Sid
> Manning
> > <sidneym@quicinc.com>; Marco Liebel (QUIC)
> <quic_mliebel@quicinc.com>;
> > richard.henderson@linaro.org; philmd@linaro.org; ale@rev.ng;
> > anjo@rev.ng
> > Subject: RE: [PATCH] Hexagon: lldb read/write predicate registers
> > p0/p1/p2/p3
> >
> > > -----Original Message-----
> > > From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> > > Sent: Wednesday, June 12, 2024 12:30 PM
> > > To: ltaylorsimpson@gmail.com
> > > Cc: qemu-devel@nongnu.org; bcain@quicinc.com;
> tedwood@quicinc.com;
> > > alex.bennee@linaro.org; quic_mathbern@quicinc.com;
> > > sidneym@quicinc.com; quic_mliebel@quicinc.com;
> > > richard.henderson@linaro.org; philmd@linaro.org; ale@rev.ng;
> > > anjo@rev.ng
> > > Subject: Re: [PATCH] Hexagon: lldb read/write predicate registers
> > > p0/p1/p2/p3
> > >
> > > On Wed, 12 Jun 2024 10:42:39 -0600 Taylor Simpson
> > > <ltaylorsimpson@gmail.com> wrote:
> > > >
> > > > diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
> > > > index
> > > > 502c6987f0..e67e627fc9 100644
> > > > --- a/target/hexagon/gdbstub.c
> > > > +++ b/target/hexagon/gdbstub.c
> > > > @@ -56,6 +64,15 @@ int hexagon_gdb_write_register(CPUState *cs,
> > > uint8_t *mem_buf, int n)
> > > >          return sizeof(target_ulong);
> > > >      }
> > > >
> > > > +    n -= TOTAL_PER_THREAD_REGS;
> > > > +
> > > > +    if (n < NUM_PREGS) {
> > > > +        env->pred[n] = ldtul_p(mem_buf);
> > > > +        return sizeof(uint8_t);
> > >
> > > I wonder, shouldn't this be sizeof(target_ulong) since we wrote a
> > > target_ulong?
> >
> > Good question.
> >
> > From the architecture point of view, predicates are 8 bits (Section
> > 2.2.5 of the
> > v73 Hexagon PRM).  However, we model them in QEMU as target_ulong
> > because TCG variables must be either 32 bits or 64 bits.  There isn't
> > an option for 8 bits.  Whenever we write to a predicate, do "and" with
> > 0xff first to ensure there are only 8 bits written (see
> > gen_log_pred_write in target/hexagon/genptr.c).
> >
> > I did some more digging and here is what I found:
> > - Since we have bitsize="8" in hexagon-core.xml, lldb will reject any
> > attempt to write something larger.
> >   (lldb) reg write p1 0x1ff
> >   error: Failed to write register 'p1' with value '0x1ff': value 0x1ff
> > is too large to fit in a 1 byte unsigned integer value
> > - For the lldb "reg write" command, the return value from
> > hexagon_gdb_write_register isn't used.
> > - The only place the return value is used is in handle_write_all_regs.
> > This function is called in response to a "G" packet from the debugger.
> > I don't know if/when lldb uses this packet, but it seems like it would
> > count on it being 8 bits since that's what is in hexagon-core.xml.
> >
> > Ted <tedwood@quicinc.com>, when would lldb generate a "G" packet, and
> > what assumptions will it make about the size of predicate registers?
> 
> When you use the expression parser to call a function, lldb will save the
> current state, set up the function call, set a breakpoint on a return (by
> changing the lr register and setting a breakpoint on the new address), set
the
> PC to the function address, and resume. After the breakpoint is hit, lldb
will
> restore the saved state.
> 
> Since QEMU doesn't support the lldb RSP extension
> QSaveRegisterState/QRestoreRegisterState,
> lldb will use G/g packets to save and restore the register state.
> 
> lldb doesn't interpret the values from the G/g packets. It just saves and
> restores them, so I don't think the new predicate definitions will matter
for
> that. You can test this out by changing the predicate registers, then
calling a
> function with the expression parser. Not a varargs function, since the IR
> interpreter doesn't handle those.
> 
> Ted

Thanks Ted!  We do indeed execute handle_write_all_regs when we print the
result of a function call in lldb.

So, the answer to Metheus' question is "no".  We should return sizeof
uint8_t.  However, we should also mask off the high bits from the value
returned from ldtul_p before assigning to the predicate register.  This
avoids putting bits from subsequent items in the buffer into the register.
    env->pred[n] = ldtul_p(mem_buf) & 0xff;

I'll send v2 of the patch with this change shortly.

Taylor







