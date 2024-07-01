Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2B7C3065B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 19:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOMkK-0003JC-Ls; Mon, 01 Jul 2024 15:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOMk2-00034r-1M
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOMjz-0007Bh-E9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719862266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=njKMayec6ThpYCpMzop/1PZx1Bhuy3U/3YeJhBpOYN4=;
 b=e2Zdb1YG0USLUw2RURX/xa+2TT9ukLGgQV5BOoAE3BgamehKTN73d357qtfP8zP7/ByvNS
 4ttHa0ctDl/JGZnFaN48rfZxqG1BOBOJuDIhIv2gyx1DIC2NB20vrrfjw8Vmat0x6zARtO
 X3L3LVfLeTYXQWSzAoG/LosJE/ESSo4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-k0dqQKebPU6AYtSHVTEZlA-1; Mon, 01 Jul 2024 15:30:58 -0400
X-MC-Unique: k0dqQKebPU6AYtSHVTEZlA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3625b8355b5so2695715f8f.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 12:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719862256; x=1720467056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=njKMayec6ThpYCpMzop/1PZx1Bhuy3U/3YeJhBpOYN4=;
 b=NLLorclJ/EX26o6PGq8GojwaAxySn+elDW2ns+xLVvrrHp+RCHMgyG6SkAymCUkSK3
 doqWatTUJXk9zbg4mnuHdVsAMD1TOCwWD0lDpSNAi++U5jplrn5iOIgyBadCsjAxSFI9
 ji2ktpPqLPaSgpzn/H+Sf3Kt2tkHB1f/RHsXf3ipQCw5ls3S0eNsim76CFdhL1rGZUtb
 4hNY5KvZPUzNdgkEDZt1SkylFZ0F6n6BxU+FSGTwVDeF3utE7ZhJXAsUcg6DtfuVQj6+
 NgQaY4c8rRNa8wTUcHMRkCKYzuAruU/1rYzOYa2fR5MCXe5jhJU4mQciUDshGjxU2NXs
 H1EA==
X-Gm-Message-State: AOJu0YwlrroRkMe6e0zJXp2m8p3I1pX0KHaVymVhtIbAhOHU/HVvDDXP
 MBiWtRVXzdNBZk8ALez0Tko5+3WW7A+0X5D1pRMUPSgRlsG8D3s3m0ukh170qUen5kw/X+d1xJ9
 +A1tgAckKWA3LZ7jl7k8M5zzI5XblK2ITipRL983g439pd0L8A8KLUswOpnqWY/wxXXFMt4FKJV
 rZDMTrxqgCFdQYk6pEH+VdKo0A9Hng7rW1oDw=
X-Received: by 2002:adf:fa51:0:b0:363:7816:7567 with SMTP id
 ffacd0b85a97d-367756a9da3mr5296654f8f.26.1719862256166; 
 Mon, 01 Jul 2024 12:30:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+cD37jm9S/nVl3TqQZXrdEwSUN9R9FXhGrY7UOTRMmbWqqFRGFzYfJkz47U0/0EJcN8lBeH8PlZDb+Di4ecM=
X-Received: by 2002:adf:fa51:0:b0:363:7816:7567 with SMTP id
 ffacd0b85a97d-367756a9da3mr5296640f8f.26.1719862255812; Mon, 01 Jul 2024
 12:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240701025115.1265117-1-richard.henderson@linaro.org>
 <CABgObfYq5Ti6UC7Os9nhyi5XU0VmLvT80rF2tZ4hR9A7cRHjBg@mail.gmail.com>
 <8036cb57-1474-4ff6-bcee-e7c3f7070119@linaro.org>
In-Reply-To: <8036cb57-1474-4ff6-bcee-e7c3f7070119@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Jul 2024 21:30:41 +0200
Message-ID: <CABgObfb2OOMYQ5ctCUmHpj+AzOyJXNE+TN39+T-h3Xqr4KMssQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] target/i386: CCOp cleanups
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 1, 2024 at 9:05=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> > no objections at all to introducing more asserts. I think keeping the
> > array is a better underlying implementation for cc_op_live() however.
>
> Hmm.  I had an implementation that would detect missing entries at runtim=
e, but this one
> detects missing entries at compile time.

But how common is it to add new CCOps? I find the array more readable
(and it can also be printed quickly from gdb), while the switch
statement optimizes for a really rare case.

> > I'm also not very fond of mixing "sized" and "unsized" CCOps in the
> > 4..7 range, there's no real reason why CC_OP_DYNAMIC and CC_OP_CLR
> > must be close to CC_OP_EFLAGS and the ADCOX CCOps.  I also think it's
> > clearer to keep CC_OP_POPCNT[BWLQ] (even though in practice only one
> > will be used because popcnt needs zero extension anyway).
>
> My objection to keeping the unused POPCNT* enumerators is that it interfe=
res with proper
> cooperation with -Wswitch, to diagnose missing enumerators.  This is also=
 why I removed
> CC_OP_NB.

Yes, I agree with removing CC_OP_NB. However the unused POPCNT[BWLQ]
can be implemented trivially (they're all the same).

> > As an aside, I'm wondering if CC_OP_CLR is particularly important; I
> > expect "xor reg, reg" to be followed by more ALU operations most of
> > the time and to not be followed by a jump, so it only saves a spill if
> > xor reg, reg is followed by a lot or store. If gen_XOR used either
> > CC_OP_LOGICn or CC_OP_EFLAGS for "xor reg, reg", the values in
> > decode->cc_op_* (CC_OP_DST=3D0 for CC_OP_LOGICn; CC_OP_SRC=3DCC_Z|CC_P =
for
> > CC_OP_EFLAGS) would be constant and wouldn't add to register pressure.
>
> You could easily be right.  Improvements to tcg in the last 11 years may =
have made it
> redundant, or it might have been wishful thinking even at the time.

Maybe. Just looking at the last couple years, with PCREL the cost of
translation has decreased substantially, and with the new decoder the
number of tcg ops has increased a bit. In both cases that means that
counting the tcg ops becomes less important.

BTW I found an easy way to implement X86_SPECIAL_BitTest without
crashes (just use cpu_regs[op->n] when computing the displacement
since you cannot have ah/bh/ch/dh). But I think it will be for 9.2.
Maybe these patches can wait too?

Paolo


