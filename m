Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4636C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 05:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrsy0-0001tO-Mb; Wed, 03 Apr 2024 01:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rrsxy-0001oE-FL; Wed, 03 Apr 2024 01:15:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rrsxw-0004m4-E4; Wed, 03 Apr 2024 01:15:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e0ae065d24so50492355ad.1; 
 Tue, 02 Apr 2024 22:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712121314; x=1712726114; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qtWQHaJdJD2wKLpoVHsjrCHwsQKkDHt69WbaoeLbaE=;
 b=cngy0Ma9KXInkr6NCGKB0GYm4RICcW+hQejzukgUt/9sjJCVOkyg2I+ke5ZEGSw9RQ
 O0nst5nKZSsm21xw64NQ8h0aSZ4eiCqsbhs6AYHhpWMsVJ9KgkfMUWVQkX0sG0ZyUXqp
 +CpLur2QLCCkQP+qzGp7tMBsm50mAAxG8weCMav2JbqOT0q7NpLRp7ES9cSwWxYDcem+
 YZnGg2cEmCaGMCZffMtps/GOEGvuzi/eRsI/ZruKKKoVcpynJexlt/pRbUmhY6JL+BR2
 y12k+rcWF1oBG9GsWAd/7ZDhFc33ly/uB2+tPlkALn6s7boCM+++g9BjbDZyxOBmRIlr
 +2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712121314; x=1712726114;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2qtWQHaJdJD2wKLpoVHsjrCHwsQKkDHt69WbaoeLbaE=;
 b=qMTW/a4qIOEn0rkCZM5E+vwPwBBWm0zszax1pxbvjTaMvult72t+2kpf8RSoIlx6pU
 d6ee+DVyhBXHsCDsYuma+LPuJGIrESSXVDGd0/hSViRAggIpIklV3MqfKuxDH1oRgGsq
 gnpWuycIXOvIkHvIHO7MT4GOgdFSRe5Ek9812J0ZnPxyMrOeLetKAEDYFZWoXU5luiLP
 /0j0j46qlCYlhack1e0RcELFt1MIWXYgGcogYtkM6gQ+Coemp1alLUohB5Ap4gy1cdQH
 hPX9Tupu50WM9KZ6GN6qco/m+2PahAJ/yLgYlv+fEmB3IHn07LSlZM3jL2ZoTtdG0fFW
 S5RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdTxEwaPvQyuf3PD5b5oEqSErg2B1/uSL6hmCFIeDYJCGaIhIerGxcdeCyw0yemckaL88vu0y5YSUw1JWLWBXRq7/I4gM=
X-Gm-Message-State: AOJu0Yz7WWYAc3DWfgD0171OWCwR9qimblYWQI44IfzcCyjjXdEXAeI+
 KtNXVuF2fpJUEAiozCguAJYeySBCO90ji7ZLB/eZXOf13QVp9Ds+
X-Google-Smtp-Source: AGHT+IFz92IRKHzWmM+MxK5UnzImjMhXaDIvPlbRGqkuc0UqwV2bga71Z0vSi4i9TFLslRzyvTI70Q==
X-Received: by 2002:a17:902:b70b:b0:1dc:de65:623b with SMTP id
 d11-20020a170902b70b00b001dcde65623bmr10509943pls.60.1712121314101; 
 Tue, 02 Apr 2024 22:15:14 -0700 (PDT)
Received: from localhost (220-245-239-107.tpgi.com.au. [220.245.239.107])
 by smtp.gmail.com with ESMTPSA id
 i15-20020a170902c94f00b001dd02f4c2casm12203979pla.164.2024.04.02.22.15.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 22:15:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Apr 2024 15:15:09 +1000
Message-Id: <D0A8CN9E4ZZG.3RV43XZWO6S5H@gmail.com>
Cc: <qemu-ppc@nongnu.org>, "Richard Henderson" <richard.henderson@linaro.org>
Subject: Re: TCG change broke MorphOS boot on sam460ex
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <fe59ceb1-e8cd-f488-d6f0-6372923a8a33@eik.bme.hu>
 <48e5e0b8-9b0a-4c9f-9f3e-c30e2fddc502@linaro.org>
 <2a286d38-1fd7-d53a-d7db-e953e6aefbf2@eik.bme.hu>
 <3386e6ec-9b87-fa01-9bf0-967a362bf90a@eik.bme.hu>
In-Reply-To: <3386e6ec-9b87-fa01-9bf0-967a362bf90a@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue Apr 2, 2024 at 9:32 PM AEST, BALATON Zoltan wrote:
> On Thu, 21 Mar 2024, BALATON Zoltan wrote:
> > On 27/2/24 17:47, BALATON Zoltan wrote:
> >> Hello,
> >>=20
> >> Commit 18a536f1f8 (accel/tcg: Always require can_do_io) broke booting=
=20
> >> MorphOS on sam460ex (this was before 8.2.0 and I thought I've verified=
 it=20
> >> before that release but apparently missed it back then). It can be=20
> >> reproduced with https://www.morphos-team.net/morphos-3.18.iso and foll=
owing=20
> >> command:
> >>=20
> >> qemu-system-ppc -M sam460ex -serial stdio -d unimp,guest_errors \
> >>  =C2=A0 -drive if=3Dnone,id=3Dcd,format=3Draw,file=3Dmorphos-3.18.iso =
\
> >>  =C2=A0 -device ide-cd,drive=3Dcd,bus=3Dide.1
>
> Any idea on this one? While MorphOS boots on other machines and other OSe=
s=20
> seem to boot on this machine it may still suggest there's some problem=20
> somewhere as this worked before. So it may worth investigating it to make=
=20
> sure there's no bug that could affect other OSes too even if they boot. I=
=20
> don't know how to debug this so some help would be needed.

In the bad case it crashes after running this TB:

----------------
IN:
0x00c01354:  38c00040  li       r6, 0x40
0x00c01358:  38e10204  addi     r7, r1, 0x204
0x00c0135c:  39010104  addi     r8, r1, 0x104
0x00c01360:  39410004  addi     r10, r1, 4
0x00c01364:  39200000  li       r9, 0
0x00c01368:  7cc903a6  mtctr    r6
0x00c0136c:  84c70004  lwzu     r6, 4(r7)
0x00c01370:  7cc907a4  tlbwehi  r6, r9
0x00c01374:  84c80004  lwzu     r6, 4(r8)
0x00c01378:  7cc90fa4  tlbwelo  r6, r9
0x00c0137c:  84ca0004  lwzu     r6, 4(r10)
0x00c01380:  7cc917a4  tlbwehi  r6, r9
0x00c01384:  39290001  addi     r9, r9, 1
0x00c01388:  4200ffe4  bdnz     0xc0136c
----------------
IN:
0x00c01374: unable to read memory
----------------

"unable to read memory" is the tracer, it does actually translate
the address, but it points to a wayward real address which returns
0 to TCG, which is an invalid instruction.

The good case instead doesn't exit the TB after 0x00c01370 but after
the complete loop at the bdnz. That look like this after the same
first TB:

----------------
IN:
0x00c0136c:  84c70004  lwzu     r6, 4(r7)
0x00c01370:  7cc907a4  tlbwehi  r6, r9
0x00c01374:  84c80004  lwzu     r6, 4(r8)
0x00c01378:  7cc90fa4  tlbwelo  r6, r9
0x00c0137c:  84ca0004  lwzu     r6, 4(r10)
0x00c01380:  7cc917a4  tlbwehi  r6, r9
0x00c01384:  39290001  addi     r9, r9, 1
0x00c01388:  4200ffe4  bdnz     0xc0136c
----------------
IN:
0x00c0138c:  4c00012c  isync

All the tlbwe are executed in the same TB. MMU tracing shows the
first tlbwehi creates a new valid(!) TLB for 0x00000000-0x100000000
that has a garbage RPN because the tlbwelo did not run yet.

What's happening in the bad case is that the translator breaks
and "re-fetches" instructions in the middle of that sequence, and
that's where the bogus translation causes 0 to be returned. The
good case the whole block is executed in the same fetch which
creates correct translations.

So it looks like a morphos bug, the can-do-io change just happens
to cause it to re-fetch in that place, but that could happen for
a number of reasons, so you can't rely on TLB *only* changing or
ifetch *only* re-fetching at a sync point like isync.

I would expect code like this to write an invalid entry with tlbwehi,
then tlbwelo to set the correct RPN, then make the entry valid with
the second tlbwehi. It would probably fix the bug if you just did the
first tlbwehi with r6=3D0 (or at least without the 0x200 bit set).

Thanks,
Nick

