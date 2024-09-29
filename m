Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6450FCF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 15:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suw7m-0002Gl-3O; Sun, 29 Sep 2024 11:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suw7k-0002CN-6E
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 11:46:16 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suw7i-0003PM-Dj
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 11:46:15 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c46c2bf490so1995268a12.3
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2024 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727624772; x=1728229572; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VbcYB2aavj/5TqCNud8D39R30hil+emPTkJ6og9lp7k=;
 b=ZpUGA6q70JhcjMY37AjGUvcmAU1A24hv/75KKpt1D1DkhodmuDpt3MfiAcf5ennWHA
 tOmGXjlHcPptEXwc7XNT+w0ISBANRhnazyArKbzT8KXPp7ijJjKIKwlGcXGbbJyzPPfW
 8WdzzxB/cSwgrYa29o4IeechCKXq+JF99PAB7wb2KKqtzZCzo785mmHk01x08DHj4864
 Sge4JbYKdL4WORUAvZsLTijeKOxSqRUOR/Kam/g3/CqYRpDhCKRAOGu1ibDFuERNK2vt
 c2hVYP/OFV3X9qDTwHrVNFCVLGgoQ/8kkW3p5qX47IvgkF6yjvRkkJFVY44Bxm8ItdJK
 BPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727624772; x=1728229572;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VbcYB2aavj/5TqCNud8D39R30hil+emPTkJ6og9lp7k=;
 b=PKnMzhIFL3BpJ0XJ6V75IYz6xW8KYAI5XE8s8dTmTO7hVgtIYDJ4lK0br7kJePosqe
 muHsc1fSbVFD5Wa8E12DjQsM6l2eGTD8RSF2fZfmKNK8ytoBd3ctaVH1FPwgi0thkP2m
 b72EiYxCmleiWKYMZxA2dgTvKtuA6gYqJznHCmf3jiMVjCjlHVAlT/wyHIu6ieDk5xVL
 QXSLZmNXDVHV1JViwv14pYprx2UxZE8Rzwp0Iomewna8EjXbuZ+Ac1t1H4166pTa6sMh
 lgOPd+3Da4fi3ONoPanvmUZ8ZnxEeb/NgWM28hxWiLGExf8x3i3bHnraOKls+bw+90/w
 XAGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJlAIILYcXuux9CWhCJZ3dqGfeAmgecVVwVCLeLoSUvRclXgkACX7srxW/1U1ZJDUzHh0vG+BHUG3E@nongnu.org
X-Gm-Message-State: AOJu0YyQI7yZ0vr6dGB1OQG5qNWlCk5XovQF7YeMOTJjjHS8Mo45c67k
 N6JsVvwnx/r715fCoZSqV5DYORaLdSK2fYcObn5aqmSe1STe6LMDXX9wh3/D7XGbUTMrxtnCP9c
 QgRaYw11PYFbYAfmHzMlgLc+dsFUrbFuxtSfsLQ==
X-Google-Smtp-Source: AGHT+IFE7JjZneF7EIwar+DGR8RmEAVIPZBGgv4qLXGliB0qs+fKwLt3jmw+b2H28vPd5dEkcWzfab6dDV69BJGtJKE=
X-Received: by 2002:a05:6402:35d5:b0:5c8:8652:dfd1 with SMTP id
 4fb4d7f45d1cf-5c88652e212mr14181470a12.1.1727624772281; Sun, 29 Sep 2024
 08:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <20240924221751.2688389-17-alistair.francis@wdc.com>
 <CAFEAcA8rdFYACFKdJga72WA4ET9NFRwrOifdbTYDBxY6G6uOXA@mail.gmail.com>
 <634d685c-7e36-409e-9b41-b9162a5acf9c@ventanamicro.com>
In-Reply-To: <634d685c-7e36-409e-9b41-b9162a5acf9c@ventanamicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 29 Sep 2024 16:46:01 +0100
Message-ID: <CAFEAcA-=s9zatyYYOP01BO1o7jPpY45mWkDM3N_yydD=Ka3GNw@mail.gmail.com>
Subject: Re: [PULL v2 16/47] hw/riscv: add RISC-V IOMMU base emulation
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org, 
 Tomasz Jeznach <tjeznach@rivosinc.com>, Sebastien Boeuf <seb@rivosinc.com>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Sat, 28 Sept 2024 at 22:01, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 9/28/24 5:22 PM, Peter Maydell wrote:
> > On Tue, 24 Sept 2024 at 23:19, Alistair Francis <alistair23@gmail.com> wrote:

> >> +/* Register helper functions */
> >> +static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
> >> +    unsigned idx, uint32_t set, uint32_t clr)
> >> +{
> >> +    uint32_t val;
> >> +    qemu_spin_lock(&s->regs_lock);
> >> +    val = ldl_le_p(s->regs_rw + idx);
> >> +    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
> >> +    qemu_spin_unlock(&s->regs_lock);
> >> +    return val;
> >> +}
> >
> > This looks very weird. Nobody else's IOMMU implementation
> > grabs a spinlock while it is accessing guest register data.
> > Why is riscv special? Why a spinlock? (We use spinlocks
> > only very very sparingly in general.)
>
>
> The first versions of the IOMMU used qemu threads. I believe this is where
> the locks come from (both from registers and from the cache).
>
> I'm not sure if we're ever going to hit a race condition without the locks
> in the current code (i.e. using mmio ops only). I think I'll make an attempt
> to remove the locks and see if something breaks.

Generally access to the backing for guest registers in a
device model is protected by the fact that the iothread lock
(BQL) is held while the guest is accessing a device. I think for
iommu devices there may be some extra complication because they
get called as part of the translate-this-address codepath
where I think the BQL is not held, and so they typically
have some qemu_mutex to protect themselves[*]. But they
don't generally need/want to do the handling at this very
fine-grained per-read/write level.

[*] This is just what I've gathered from a quick read through
our other iommu implementations; don't take it as gospel.

If you do need to do something complicated with locking it would
be good to have a comment somewhere explaining why and what
the locking principles are.

thanks
-- PMM

