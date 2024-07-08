Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF21C38150
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 02:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQdx7-0005zj-5u; Sun, 07 Jul 2024 22:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQdx5-0005wg-AU; Sun, 07 Jul 2024 22:18:03 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQdx3-0001f0-NG; Sun, 07 Jul 2024 22:18:03 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4f2faade55dso818589e0c.1; 
 Sun, 07 Jul 2024 19:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720405080; x=1721009880; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AFd01aSinDCDSIJRGZ8lfM1/Yd4+kDLHBz7S4maifSQ=;
 b=bVXfO079PyvfQSnwucgQxjaKIJV9C3FAwdftID7Ir5xGLwdvwVgUpHW0XKfQkl3mqH
 VOIAhU9UIktiLs25ABw/Fr50yWOVDjNkn8sdrJcayKsq/9VZ7HqEDl/HRqWlJeoYY+nx
 WTwRFnGPqKSGU8XuQEQ3P/GWPqkwgS0ZKmvUN8Rk4B8ru3LYu3MYyKbx19c1XQd78rT1
 twLU627+YXEl1dTy0jyP98QQAJTY4czo9PK/epqVHSUH0ok8774CJeHXIDQfbw5Z1f4h
 O2cs5tg2ZlbyCzFzbAcKnZjzqSPhF8q/1SrIo96HuCPgtQ7VY40ZZi7K5cioBOFLJ29O
 1CiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720405080; x=1721009880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AFd01aSinDCDSIJRGZ8lfM1/Yd4+kDLHBz7S4maifSQ=;
 b=l7BapZJnOK3ynaFE0dQ11t7rXF1KfpQ3dVZ9H0g/lQIi/PCLbBLUG3X5eEBIsN2KdG
 3ANwC6vTvX4v6Ex5XxbzHjNMqiRMZupXV0oiQiyYh+MvU8yg4MsOERt+B7QmljV6E1AI
 ynm3JbO38F6KF/TqeL49jbm0OD9dvEe4EHqTOivFcCEsTisb0IEr6R8Rrl0/NxZuHHV2
 2eorUJG6MqXkbZH+uDr6h74CShtyGRbFVCv3zk6Xc8ziuQQzM6IhZ/dwehXrxPzd8XKo
 BG7KOCZMJDb54iGxkM3QyqhgAnnbc3jGOw/dNnppVNeM5YXscFJi+qvOHKMZ5NWSx6aG
 rjwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9DDq1Q6qLNMfaML3fVMzXw5XkCAV2FHUNRI5K5XMSklIqDyaekm4l5XjcglTb20RtIxc5rMcCa3r53D+elzFYbQEG3vPLfqIMbPf63CSd49ZR35gJsvTnAdX4Wg==
X-Gm-Message-State: AOJu0Yx8F1gASe0rESYCZ+G8csaSBtwk7C3TjtadvqrntmaxjRlt/jXR
 w/qf9tvi2HRibrjaLkDZ2UJ6ltV8UpbppIzAaeZyOdguYhkSbbZsvCE+Hr8EIM2Vall4xWYdfmq
 MbZw03rfLSZmZr65Zl1w/evj6oFw=
X-Google-Smtp-Source: AGHT+IHhKzY5U5RdZv94MjI4ajI/auti668gQU0AKWEOghbQavHM+TbGTCNnoMAkcza18kc9hl6QFWc67p2neeDCQVc=
X-Received: by 2002:a1f:7246:0:b0:4f3:62b:84eb with SMTP id
 71dfb90a1353d-4f3062b8822mr6195950e0c.9.1720405080013; Sun, 07 Jul 2024
 19:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240703213102.254927-1-zheyuma97@gmail.com>
 <CAFEAcA_9_fymBmp4Ei+ZxP3PB6u3JckTxufLcJn6JKuf4Yjkaw@mail.gmail.com>
In-Reply-To: <CAFEAcA_9_fymBmp4Ei+ZxP3PB6u3JckTxufLcJn6JKuf4Yjkaw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 8 Jul 2024 12:17:34 +1000
Message-ID: <CAKmqyKN0nzbNReKrpH3_Qw7bJu2k8r5yddJPcYxN4ji1X2QQ9w@mail.gmail.com>
Subject: Re: [PATCH] hw/intc: sifive_plic: Fix heap-buffer-overflow in SiFive
 PLIC read operation
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Zheyu Ma <zheyuma97@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Jul 4, 2024 at 7:33=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Wed, 3 Jul 2024 at 22:32, Zheyu Ma <zheyuma97@gmail.com> wrote:
> >
> > The sifive_plic_read function in hw/intc/sifive_plic.c had a potential
> > heap-buffer-overflow issue when reading from the pending_base region.
> > This occurred because the code did not check if the calculated word ind=
ex
> > was within valid bounds before accessing the pending array.
> >
> > This fix prevents out-of-bounds memory access, ensuring safer and more
> > robust handling of PLIC reads.
> >
> > ASAN log:
> > =3D=3D78800=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on addre=
ss 0x602000038a14 at pc 0x5baf49d0d6cb bp 0x7ffc2ea4e180 sp 0x7ffc2ea4e178
> > READ of size 4 at 0x602000038a14 thread T0
> >     #0 0x5baf49d0d6ca in sifive_plic_read hw/intc/sifive_plic.c:151:16
> >     #1 0x5baf49f7f3bb in memory_region_read_accessor system/memory.c:44=
5:11
> >
> > Reproducer:
> > cat << EOF | qemu-system-riscv64  -display \
> > none -machine accel=3Dqtest, -m 512M -machine shakti_c -m 2G -qtest std=
io
> > readl 0xc001004
> > EOF
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >  hw/intc/sifive_plic.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
> > index e559f11805..d2a90dfd3a 100644
> > --- a/hw/intc/sifive_plic.c
> > +++ b/hw/intc/sifive_plic.c
> > @@ -147,7 +147,14 @@ static uint64_t sifive_plic_read(void *opaque, hwa=
ddr addr, unsigned size)
> >                              (plic->num_sources + 31) >> 3)) {
> >          uint32_t word =3D (addr - plic->pending_base) >> 2;
> >
> > -        return plic->pending[word];
> > +        if (word < plic->bitfield_words) {
> > +            return plic->pending[word];
> > +        } else {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "sifive_plic_read: Word out of bounds for pe=
nding_base read: word=3D%u\n",
> > +                          word);
> > +            return 0;
> > +        }
>
> This seems a bit odd. This part of the code is guarded by
>
>     } else if (addr_between(addr, plic->pending_base,
>                             (plic->num_sources + 31) >> 3)) {
>
> and we calculate plic->bitfield_words in realize based on
> plic->num_sources:
>     s->bitfield_words =3D (s->num_sources + 31) >> 5;
>
> so presumably the intention was that we put enough words
> in the bitfield for the number of sources we have, so that
> the array access wouldn't overrun. Maybe we got the
> calculation wrong?

Yeah, the calculation is wrong here.

We have

s->bitfield_words =3D (s->num_sources + 31) >> 5;
...
s->pending =3D g_new0(uint32_t, s->bitfield_words);

But then the check is

    } else if (addr_between(addr, plic->pending_base,
                            (plic->num_sources + 31) >> 3)) {

So when we allocate we shift by 5, but then when we check we only shift by =
3.

So that's the bug. It's not immediately obvious what the correct fix
is though, do you mind having a look?

Alistair

>
> thanks
> -- PMM
>

