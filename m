Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A796C197BF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 18:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnj1a-0005DN-7D; Thu, 27 Feb 2025 13:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnj1U-0005Ba-Ai
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 13:54:17 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnj1R-0005mh-J8
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 13:54:16 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6f666c94285so12160797b3.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 10:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740682445; x=1741287245; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVmkhnO1xd6/jMeYQxgCgkhwXVcijlfp5dWT6YBhEkg=;
 b=kl+HXetgPbeUgkpbjQrgUR6RyPwznA7osdiE8BUUVfVkwOPeUYKw56vOsPN7kVvPej
 N1mN2dZfmSKAaSjOzsqyK1O6Vaq6fucDSul7nu0+UoN5VNp6FVwXhVsCVPeEFdXtm0XV
 6SEAvhnl6skT7nDhpg6pA3MfVKP1vh0Pg/FeixrTnHy/AFHACGBWa90NXkf4oDAlZrjl
 9N702ait9WIL8HjjZzheTHHr7Z+bX/otBfwYWDdeHgWi7DtvIEtxMZl41zGyF27pzBny
 FO5rBO8s7thI61NoxKIDc2DJyYRcT/muFcbZsJkROYCoLx4mIyF5+rtRCVpuQt9xbDAd
 0hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740682445; x=1741287245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hVmkhnO1xd6/jMeYQxgCgkhwXVcijlfp5dWT6YBhEkg=;
 b=P77lZK+e+TLY0oVY40rk7NWDwwkxHb5M9n6ah3U4xQJ870LVzh+GJ34TwhE0rIw7FE
 LFWbIAdFKMuDoSmPUnh6WteL8uALhiyk/PxmKTaPi1JYhxUk5q9Bk+SsneOoq6PVm34F
 UuaCmhCR4WU9iKipsB8GSa24tGV/WcADc3nNGPsi25VbGlSHC4ctTZ3f2iTe7UTb5PBG
 djnArBo8CL1qKXbAwGxkyIH3Su0hdztCXANH0lGwD2rJtpCtwXTOZeVJnZq2F9I+eLzC
 YSSX3aT9PsU9g/1Lc7xsfDJMaPav1+f6fefHQe2jio1cO04h3UoYE8awKFK/hEAqxlyY
 co7A==
X-Gm-Message-State: AOJu0YyHwTC7YnVzwK9fM0Nsl2XMHLWA1eWl3/ryvQ3OZdd/qvnKQzPi
 9+Srza7WdtaCuADrsMg+e+T4eRNV40EHIkixmw8O0KB62jI4grP/7F6Fn8g+szEwgMMw4oyRffP
 IS405MramLfQq3DBRA8LdDFz2RIlzdiKe0t52Pw==
X-Gm-Gg: ASbGncsXldWr9Clj8TuPymKDl1ccBFQthAdkOzM+NJEK1zpIlp3bXySpde1/hKCSqUy
 5ajc1hhzR75urVSQ09TWvFSoVpcMsYfA+a4Emk2DeJJZCJSy6Dq7FWNIi4LprK+0lnsMtZVeZBE
 UoYPhHfg9S
X-Google-Smtp-Source: AGHT+IGklIX64S8vsIsMBjghZBaI0X4+Hw6L66/R8AptvHW7tsXn5hN5u8XxMV79JhEvK+Q9wVMaTZ+lJf7KDvLoTlE=
X-Received: by 2002:a05:6902:2412:b0:e60:9961:f832 with SMTP id
 3f1490d57ef6-e60b2ebfaf7mr312725276.23.1740682445107; Thu, 27 Feb 2025
 10:54:05 -0800 (PST)
MIME-Version: 1.0
References: <20250227164538.814576-1-pbonzini@redhat.com>
 <20250227164538.814576-5-pbonzini@redhat.com>
 <CAFEAcA_WOxLvWnp8Tp-Q5xj3_cEs2OGhAbVFtymGwXYKxUePYg@mail.gmail.com>
 <CABgObfZVxw2BnVYqbsaoy9W+YUgygOaYGpfW=D+7mfmQe8h+OA@mail.gmail.com>
In-Reply-To: <CABgObfZVxw2BnVYqbsaoy9W+YUgygOaYGpfW=D+7mfmQe8h+OA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2025 18:53:53 +0000
X-Gm-Features: AQ5f1JrzqRXmi0GsXXdPW3VhSB0N-CTUhfnwNRxFnEd1eFlUi12ZqArOfk2tIyo
Message-ID: <CAFEAcA-CgYt2p6JqzU0ttCwDpfp4bbMWM2SAn8xmSE9BmC6xeA@mail.gmail.com>
Subject: Re: [PATCH 4/5] rust: pl011: switch to safe chardev operation
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 27 Feb 2025 at 18:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Thu, Feb 27, 2025 at 6:25=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> > Thinking about other devices, presumably for more complex
> > devices we might need to pass more than just a single 'bool'
> > back from PL011Registers::write. What other kinds of thing
> > might we need to do in the FooState function, and (since
> > the pl011 code is presumably going to be used as a template
> > for those other devices) is it worth having something that
> > expresses that better than just a raw 'bool' return ?
>
> Ideally nothing, especially considering that more modern devices have
> edge-triggered interrupts like MSIs, instead of level-triggered
> interrupts that need qemu_set_irq() calls. But if you have something a
> lot more complex than a bool I would pass down the PL011State and do
> something like pl011.schedule_update_irq() which updates a BqlCell<>.
> The device could then use a bottom half or process them after
> "drop(regs)".
>
> HPET has another approach, which is to store a backpointer from
> HPETTimer to the HPETState, so that it can do
>
>     self.get_state().irqs[route].pulse();
>
> without passing down anything. The reason for this is that it has
> multiple timers on the same routine, and it assigns the timers to
> separate HPETTimers. I would not use it for PL011 because all accesses
> to the PL011Registers go through the PL011State.

I think the idea I vaguely have in the back of my mind is that
maybe it's a nice idea to have a coding structure that enforces
"you update your own internal state, and only then do things that
might involve calling out to the outside world, and if there's
something that you need to do with the result of that callout,
there's an easy mechanism for 'this is what I will want to do
next after that' continuations".

The fact that our C device implementations don't do that is
kind of the underlying cause of all the "recursive entry back
into the device via DMA" problems that we squashed with the
big hammer of "just forbid it entirely". It's also in a way
the problem underlying the race condition segfault here:
https://lore.kernel.org/qemu-devel/CAFEAcA9odnPo2LPip295Uztri7JfoVnQbkJ=3DW=
n+k8dQneB_ynQ@mail.gmail.com/T/#u
(memory_region_snapshot_and_clear_dirty() drops the BKL, no
callers expect that, segfaults in the calling code in the
framebuffer device models if something else gets in and
e.g. resizes the framebuffer in the middle of a display update).

So I was sort of wondering if the pl011 structure was aiming
at providing that kind of separation of "internal state" and
"external interactions", such that the compiler would complain
if you tried to do an externally-interacting thing while your
internal state was not consistent.

thanks
-- PMM

