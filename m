Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CA5C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 10:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1jND-0001f8-Qw; Mon, 07 Apr 2025 06:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u1jNC-0001dG-Ba
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 06:06:34 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u1jN8-0007id-UL
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 06:06:34 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e614da8615so2633099a12.1
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 03:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744020388; x=1744625188; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOSl4UZ0taB9lE+3OurjdhwIwCTnKL5oIL1UkBg8vCs=;
 b=H8MP9gdacF5P9bQzVuq716odokSl2u/lNHR1M4lmJ4y5xl69EO+dSF9JqBuehBEffm
 KM3cdDTiyPJkwKrEpx3qi5eOXH9pnUA86UW4e1dCfAIR1eMMmEfzIeGRk/ruVzOO7n3w
 76H0+yZowdrKeRRELPwpq2WkMe0IdAL/wowlS/oZU6335RtsMgSW012LXSQZDtVPrucA
 KmSRfMTwkY3QPqjhqpn8VHlCPrM5zF6KxScm7vbhL/Fs1j8U9PjPenJTqlEybd8QBC5L
 09sjD5MfWoN/d0z2f9WvJM24otkvISrJ5mq8A1Gm1E9TnEr+mvZdq5rVEdmUXQaCBSjE
 6qRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744020388; x=1744625188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fOSl4UZ0taB9lE+3OurjdhwIwCTnKL5oIL1UkBg8vCs=;
 b=SnT9qjmNc+zwuivSOpB87u7+Zd1PqgpUXpH4QOAxQeErNX+baiBLZ1bXAgGQkPxDkI
 ro5MQJsGg+g0992ZbZegk/n1JtAJqetWLufslJiQ4NtZNkFHadMkC/UyTbHnL70EXRjB
 3IJGpZYLUmAq/DRWLbYbYtsyNpu1tATNYuiZsePcSE+EFOEZtI9X3l7PeivR0J4ADXDQ
 WaQ9bsBTIJydfYdgyjdw1suGsmz3ddZX6gdpkWYDxqfcrtKGjp53ElX72f5xnGtKURIc
 XAkEKEbAbawSDXK9waXRPB1z+wzQ/Mkyav7yEp/gD2v20/yUbRT2Pn1jBQpD2DmlKAHy
 61dg==
X-Gm-Message-State: AOJu0YzqUem8N0mSbuTB/jHan0OC2jyBtTKc4ATkRIjhcfKo5fJPd1Wk
 Dsz2XlQwPMqmLS8RKEbPrQGACC8ysudmCBO42y8+eVhkY9nxDUpAXQ4X75JBNTknW5feMaD23Ch
 ZIklTdkxfMqSITYJ44q8EVJU8LW+kMSWxiXUyHg==
X-Gm-Gg: ASbGnct6E0LELVOqasFuj28ot4K2iZHdyCs2H9QsY7zvFMv84CQcQMcTwQgqBLXVqeF
 +YuaUTaW89zkVFHhNFWDgcj+ZlA7vFhotO3Am5We/3vu9v+7uDPZ22gsyXnjZQiiGchHSgmkxYx
 P4zNuUzZuChOJmtXzBDIbFO0exg14N64o54Hzb3/c=
X-Google-Smtp-Source: AGHT+IGvSi1NZg0UiE5ML5LzUDt30zbumBVWx6kuNDunN8dZ51I+XZFQQm951c8dYEAV2FWMPeaycyXAhAXs9GZnBOU=
X-Received: by 2002:a05:6402:26c5:b0:5ed:599a:3cbe with SMTP id
 4fb4d7f45d1cf-5f0b284dc9amr11075226a12.4.1744020387132; Mon, 07 Apr 2025
 03:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250319192153.28549-1-jim.shu@sifive.com>
 <20250319192153.28549-3-jim.shu@sifive.com>
 <CAKmqyKPo4G3t32=uKbgYoY+nDJOEg+fLJ3yFC1hx2PJEqT=59A@mail.gmail.com>
In-Reply-To: <CAKmqyKPo4G3t32=uKbgYoY+nDJOEg+fLJ3yFC1hx2PJEqT=59A@mail.gmail.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Mon, 7 Apr 2025 18:06:15 +0800
X-Gm-Features: ATxdqUHb0LUdAwTsx9JrBjHKuAHHrcHNKzF2QxS1p9stQ0OqYyyZRBq-nHwG7jM
Message-ID: <CALw707okY8SKmeb7Po-3KxF+CoE5tZGPASv1Tn4BpZB_7D4KMg@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/intc: riscv_aclint: Fix mtime write for sstc
 extension
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x52b.google.com
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

The period of the stimecmp timer is the time until the next S-mode
timer IRQ. The value is calculated as "stimecmp - time". [1]
It is equal to "stimecmp - mtime" since the time CSR is a read-only
shadow of the memory-mapped mtime register.
Thus, changing mtime value will update the period of stimecmp timer.

Similarly, the period of vstimecmp timer is calculated as "vstimecmp -
(mtime + htimedelta)" [2], so changing mtime value will update the
period of vstimecmp timer.

[1] RISC-V Priv spec ch 9.1.1. Supervisor Timer (stimecmp) Register
A supervisor timer interrupt becomes pending, as reflected in the STIP
bit in the mip and sip registers whenever time contains a value
greater than or equal to stimecmp.
[2] RISC-V Priv spec ch19.2.1. Virtual Supervisor Timer (vstimecmp) Registe=
r
A virtual supervisor timer interrupt becomes pending, as reflected in
the VSTIP bit in the hip register, whenever (time + htimedelta),
truncated to 64 bits, contains a value greater than or equal to
vstimecmp

I will add the explaination in the commit log in the v2 patchset, thanks.


Jim Shu

On Fri, Apr 4, 2025 at 11:12=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Thu, Mar 20, 2025 at 5:24=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrot=
e:
> >
> > When changing the mtime value, the period of [s|vs]timecmp timers
> > should also be updated like the period of mtimecmp timer.
>
> Why should they be updated?
>
> Alistair
>
> >
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >  hw/intc/riscv_aclint.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
> > index db374a7c2d..5f4a17e177 100644
> > --- a/hw/intc/riscv_aclint.c
> > +++ b/hw/intc/riscv_aclint.c
> > @@ -28,6 +28,7 @@
> >  #include "qemu/module.h"
> >  #include "hw/sysbus.h"
> >  #include "target/riscv/cpu.h"
> > +#include "target/riscv/time_helper.h"
> >  #include "hw/qdev-properties.h"
> >  #include "hw/intc/riscv_aclint.h"
> >  #include "qemu/timer.h"
> > @@ -240,6 +241,10 @@ static void riscv_aclint_mtimer_write(void *opaque=
, hwaddr addr,
> >              riscv_aclint_mtimer_write_timecmp(mtimer, RISCV_CPU(cpu),
> >                                                mtimer->hartid_base + i,
> >                                                mtimer->timecmp[i]);
> > +            riscv_timer_write_timecmp(env, env->stimer, env->stimecmp,=
 0, MIP_STIP);
> > +            riscv_timer_write_timecmp(env, env->vstimer, env->vstimecm=
p,
> > +                                      env->htimedelta, MIP_VSTIP);
> > +
> >          }
> >          return;
> >      }
> > --
> > 2.17.1
> >
> >

