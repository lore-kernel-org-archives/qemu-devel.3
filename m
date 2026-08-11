Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B10C5B574
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wthSh-0003Y0-Px; Tue, 11 Aug 2026 04:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wthSc-0003XX-NQ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:03:48 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wthSY-0003YF-IX
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:03:44 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c1f5208b38dso87134666b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 01:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786435420; cv=none;
 d=google.com; s=arc-20260327;
 b=c0t/AROLX7JNXLxl8VaSG1uSd8J9FobhEIQUMjVOA/oMu3s15y/wbCEDgrdK04eeO8
 JZoN2Z0W6MDuYmyhVWJJ5NMTBFlSU74PSWA07Aol9gM7ikWghiRA1EkEIom7NojJcfgm
 5pxQpYzsVt2d/LI7SvObauFK7TPMuJEU5twUWuzKamgVKGCWd+JRq4KM9Jxth3mcP5/u
 St7a4JkeQXYf3Mvf33HRme7XNg9GY9jNyjuB+0lHeGkEXRbUo0IZlaL4VpSgDgVBCLPZ
 +2SLxpIEev2sfD5MYNKdVqmFV7GNWYCD2zsWR1/T8aCBCqiOJq2Ad8zpEvDKOkmAOXdx
 BjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fqBlwW6z9w6sMGT5hmHk/u75u+YKjMvOiqEv5IfaHqE=;
 fh=lj2KhW/MAsZ/+uqmxCUPGYBeJsseSAo4tZ2naAjMmts=;
 b=Pmb/J7z1YM8Br4QDUN0hmIrP0RcmUeeJKLBIkUQ93QmQawc08FWjMQRlDvCr1SvG6W
 WlJDd1EHbgWHdmuVr0xX0xJ/IufrI7eOPC1t3jPgF1YwG2q7Ukrat1D703Af909bULvy
 hcQYFEP5e+QDmwisD9XMT03osgjKelvFll0YxWJGCGcE9bfvvhb0YnRo5f5y9+uVBlwB
 K0Q8pmznxx+EM+2wPYYHFWtT1vHrLPQeiGAFgrpWIma34SEYnXIfOP5stfFo69n3YTx3
 8WPI6eYsqSaqmQiX53kYrnVetotv1zfUa9genlJu8lfyULoSVu5zhtpcQN5S1iqBH1a0
 MCTw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1786435420; x=1787040220; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fqBlwW6z9w6sMGT5hmHk/u75u+YKjMvOiqEv5IfaHqE=;
 b=dm0HxLiuqWTQGTOj/nH9RQOvUkDkt7IJyJfS2FtiM15WsNHz+H/hj2caUJd2kpvKa4
 HCjH+X71FwfLT421ta2cipoihiKmeDOnWAhmnl6wEOkKvEoj/q5lWDOjMBKq49/KLZuv
 ArqKYqRAr9qQfEppsfy5GOdG8A/Aa1cztjhzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786435420; x=1787040220;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fqBlwW6z9w6sMGT5hmHk/u75u+YKjMvOiqEv5IfaHqE=;
 b=FTdlypgBN7plZtnSuCj3QfBFo36r5JS9R97O+5z0ZOuQTqrEHAxjyOy8WAIC/z45oi
 vsbNHoMvFlwUSEYBuv7FCzIB8oDftyCJmFO6f9CW+c1n45MmX1WujHJ7sMGkt81NrlOf
 U2WDuYs7PnICQIO8KkYf7mf/rXM8A0YZzvE3hen3BrcnhC0qXg2wSJRs8UbtkUGp5fSu
 OOlCYr7ft2P63zLi1mpqA5rV9+10e/XahJr77AA3mfQ48cQ83WXQ3VaQ1p6EIsHu99yO
 OCsutfI+71X7L/9yKEawvHXqnH6oEZ3IF3xdG4R6Dj1Ia6foZirW6bdMlPWq970fiDdw
 qTlQ==
X-Gm-Message-State: AOJu0YxsjSGNMkU4zyldp0n3oftjYvdrc21yuSy7nB42/dksBAD65tRh
 SPfNzI48OyPvxXxMC9A9xXj0I+IW6ooDNkek+vKAuYJDemiq57MMt2veRnSbhBbKyroGXxx+daP
 K4thUpe/5twOiqsAoyLFO7704m2ryrGnbxE4u1kfttg==
X-Gm-Gg: AR+sD10quCmzdojJy/SC6b3ZzJxc9wxE7+sD6SS5ZnOSNKhyt/eZdxxyQEDUwuQldCH
 q9ShJs+hrwJZRvjZPBN5tF6Yso01sUcBKDdLie4ldyNGFJMIpR6jFdO0l3j2n0VVb+CNVXPjvLP
 Us+RXhADexrAxtNc8CgZr5f4GTxfJppyrn6U/p3fcbpneTgY73huQS/9mzG8y7EXtMCLMpPg1Co
 7IULfNLCuLrEwk259ltumYM8pTkG6dvDuECBEz0xX7ENTDrT9/8V5tFFlcE9mBlbomriVDwcQLz
 dEOFUF19bz9kXR9bXSIqCR+/CsWr3pR0V7NwwaQgJ5wT/l/D/Bt43yzDBmGoEiDRYGwo5CKi4v0
 =
X-Received: by 2002:a17:907:d26:b0:c15:fc5b:6884 with SMTP id
 a640c23a62f3a-c20e623c23bmr62798066b.13.1786435419036; Tue, 11 Aug 2026
 01:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260810121525.100540-1-alexander@mihalicyn.com>
 <87h5l22faq.fsf@draig.linaro.org>
 <CAJqdLrr2hR_ObgzEosMhDvbz+B9sywGQwJPEcjrzhr1imhCptQ@mail.gmail.com>
In-Reply-To: <CAJqdLrr2hR_ObgzEosMhDvbz+B9sywGQwJPEcjrzhr1imhCptQ@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 11 Aug 2026 10:03:27 +0200
X-Gm-Features: AUfX_mw51nf7tFxHAkKDropcsexOUiudL1TH_2vEuw8Z5OKlgNcWK0bnr2Lu-PE
Message-ID: <CAJqdLrqM4tv7b55g+6_heCNBC-9fMC4CEvDK5rxk4tXjygCYvw@mail.gmail.com>
Subject: Re: [PATCH] hw/char/pl011: support backend hotswap
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x62b.google.com
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

Am Mo., 10. Aug. 2026 um 19:31 Uhr schrieb Alexander Mikhalitsyn
<alexander@mihalicyn.com>:
>
> Am Mo., 10. Aug. 2026 um 16:58 Uhr schrieb Alex Benn=C3=A9e <alex.bennee@=
linaro.org>:
> >
> > Alexander Mikhalitsyn <alexander@mihalicyn.com> writes:
> >
> > > From: Aleksanr Mikhalitsyn <alexander@mihalicyn.com>
>
> Ugh, I did git format-patch and copied this patch from my Raspberry PI
> dev/test machine
> and it turns out that I have a stupid typo in my `git config get
> user.name` on that machine.
> I'll drop -v2 a bit later.
>
> > >
> > > Currently, when Incus issues "chardev-change" QMP command to change
> > > chardev backend from ringbuf to socket it receives an error (with aar=
ch64 VM):
> > > "Chardev user does not support chardev hotswap" [1], [2]
> > >
> > > Let's fix this by properly implementing BackendChangeHandler for pl01=
1.
> > >
> > > Link: https://discuss.linuxcontainers.org/t/unable-to-connect-to-vm-c=
onsole-on-arm-architecture/23096/3 [1]
> > > Link: https://github.com/lxc/distrobuilder/issues/892 [2]
> > > Reported-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > > Signed-off-by: Alexander Mikhalitsyn
> > > <aleksandr.mikhalitsyn@futurfusion.io>
>
> Dear Alex,
>
> first of all thank you very much for such a fast reaction and review ;-)
>
> >
> > At first I wondered why the FE needs to care about where the BE is
> > routed to but 7bb86085e61 (char: chardevice hotswap) explains:
> >
> >   However, backends are not stateless and are set up by the frontends
> >   via qemu_chr_fe_<> functions, and it's not (generally) possible to
> >   replay that setup entirely in a backend code, as different chardevs
> >   respond to the setup calls differently, so do frontends work
> >   differently basing on those setup responses. Moreover, some frontend
> >   can generally get and save the backend pointer
> >   (qemu_chr_fe_get_driver()), and it will become invalid after backend
> >   change.
>
> yes, exactly
>
> >
> > > ---
> > >  hw/char/pl011.c | 16 +++++++++++++++-
> > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> > > index cb12c3e224f..3622248ec0c 100644
> > > --- a/hw/char/pl011.c
> > > +++ b/hw/char/pl011.c
> > > @@ -660,12 +660,26 @@ static void pl011_init(Object *obj)
> > >      s->id =3D pl011_id_arm;
> > >  }
> > >
> > > +static int pl011_be_change(void *opaque)
> > > +{
> > > +    PL011State *s =3D opaque;
> > > +    int break_enable =3D s->lcr & LCR_BRK;
> > > +
> > > +    qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_recei=
ve,
> > > +                             pl011_event, pl011_be_change, s, NULL, =
true);
> > > +
> > > +    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
> > > +                      &break_enable);
> >
> > So this is just ensuring that if we switch to a serial backend we
> > properly register the break behaviour on the backend? Is it idempotent?
>
> Right. And AFAIU, `CHR_IOCTL_SERIAL_SET_BREAK` is specific to the
> char-serial device only.
>
> So when we switch, let's say, from a serial to a socket backend, this
> call is basically a no-op.
> But when we switch back from the socket to the serial, this will
> trigger `tcsendbreak(fioc->fd, 1)`, which is not idempotent (and is a
> single-shot action).
>
> But I believe it's not a problem here, because we do it once when we
> *switch* between two different backends, and `fioc->fd` is a fresh fd
> every time.
> My point is that we can't really trigger this thing twice for the same fd=
.
>
> Please, correct me if I'm wrong. I took inspiration from 16550A's
> serial_be_change() when working on this.
>
> =3D=3D=3D=3D BEGIN offtopic :-)
>
> Btw, thanks to your question I did some more research on tcsendbreak()
> and BRK behavior [1] and it feels to me that what we currently have in
> pl011 UARTLCR_H's register handling code is not really correct. See:
>
> static void pl011_write(void *opaque, hwaddr offset,
>                         uint64_t value, unsigned size)
> {
> <..>
>     case 11: /* UARTLCR_H */
>         /* Reset the FIFO state on FIFO enable or disable */
>         if ((s->lcr ^ value) & LCR_FEN) {
>             pl011_reset_rx_fifo(s);
>             pl011_reset_tx_fifo(s);
>         }
>         if ((s->lcr ^ value) & LCR_BRK) {
>
>            // << spec [1] says that setting BRK means "If this bit is
> set to 1, a low-level is continually output on the UARTTXD output,
> after completing transmission of the current character."
>            // what we do is CHR_IOCTL_SERIAL_SET_BREAK which is just
> tcsendbreak(fioc->fd, 1) under the hood which can't emulate continuous
> low-level signal on the UARTTXD output
>            // for the time of BRK bit is set. It only does this for a
> short period of time.
>
>             int break_enable =3D value & LCR_BRK;
>             qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
>                               &break_enable);
>             pl011_loopback_break(s, break_enable);
>         }
>
> I guess we need some pl011 expert in here :-)
>
> [1] https://support.arm.com/documentation/ddi0183/g/programmers-model/reg=
ister-descriptions/line-control-register--uartlcr-h

Dear friends,

I looked closely into this stuff and found something interesting I
would like to share just in case
and discuss. (I'm not an expert in UART or tty code, so I can be wrong
in my understanding.)

1. It seems to me that QEMU BRK emulation code for both PL011 and
16550A is not fully correct.

According to the spec for PL011 [1]:
=3D=3D=3D
Send break. If this bit is set to 1, a low-level is continually output
on the UARTTXD output, after completing transmission of the current
character. For the proper execution of the break command, the software
must set this bit for at least two complete frames.

For normal use, this bit must be cleared to 0.
=3D=3D=3D

According to the spec for 16550A [2]:
=3D=3D=3D
bit 6: When this bit is set a break condition is
forced in the transmission line. The serial output
pin (txd) is forced to the spacing state (zero).
When this bit is cleared, the break state is
removed. The break state has no effect on the
transmitter=E2=80=99s logic, so if several characters are
stored in the transmitter=E2=80=99s FIFO they will be
removed from this FIFO and passed
sequentially to the Transmitter Shift Register
which serializes them. This fact can be useful to
establish the break time making use of the THR
Empty and Transmitter Empty flags of the LSR
=3D=3D=3D

My interpretation of this is that setting a BRK flag for both means
that TX line will be set to spacing state (zero) for an infinite time
(until bit is unset).

Our implementation in QEMU for both just calls qemu_chr_fe_ioctl(..
CHR_IOCTL_SERIAL_SET_BREAK ..) which is just:
=3D=3D=3D
            int enable =3D *(int *)arg;
            if (enable) {
                tcsendbreak(fioc->fd, 1);
            }
=3D=3D=3D
under the hood.

tcsendbreak() in glibc is implemented as ioctl(TCSBRK / TCSBRKP),
which internally sets a BRK bit for a certain
period of time and unsets it back. To be fully sure, I looked into the
Linux kernel, and the call stack is the following:
tty_ioctl(TCSBRK / TCSBRKP) -> send_break():

=3D=3D=3D
/**
 * send_break - performed time break
 * @tty: device to break on
 * @duration: timeout in mS
 *
 * Perform a timed break on hardware that lacks its own driver level timed
 * break functionality.
 *
 * Locking:
 * @tty->atomic_write_lock serializes
 */
static int send_break(struct tty_struct *tty, unsigned int duration)
{
        int retval;

        if (tty->ops->break_ctl =3D=3D NULL)
                return 0;

        if (tty->driver->flags & TTY_DRIVER_HARDWARE_BREAK) // <<<
*not* our case
                return tty->ops->break_ctl(tty, duration);

        /* Do the work ourselves */
        if (tty_write_lock(tty, false) < 0)
                return -EINTR;

        retval =3D tty->ops->break_ctl(tty, -1); // << set BRK bit
        if (!retval) {
                msleep_interruptible(duration);
                retval =3D tty->ops->break_ctl(tty, 0); // << unset BRK bit
        } else if (retval =3D=3D -EOPNOTSUPP) {
                /* some drivers can tell only dynamically */
                retval =3D 0;
        }
        tty_write_unlock(tty);

        if (signal_pending(current))
                retval =3D -EINTR;

        return retval;
}
=3D=3D=3D

tty->ops->break_ctl is just uart_break_ctl() which in turns is just a
wrapper for (struct uart_ops *)->break_ctl().

For PL011 (struct uart_ops *)->break_ctl is pl011_break_ctl():
=3D=3D=3D
static void pl011_break_ctl(struct uart_port *port, int break_state)
{
        struct uart_amba_port *uap =3D
            container_of(port, struct uart_amba_port, port);
        unsigned long flags;
        unsigned int lcr_h;

        uart_port_lock_irqsave(&uap->port, &flags);
        lcr_h =3D pl011_read(uap, REG_LCRH_TX);
        if (break_state =3D=3D -1)
                lcr_h |=3D UART01x_LCRH_BRK;
        else
                lcr_h &=3D ~UART01x_LCRH_BRK;
        pl011_write(lcr_h, uap, REG_LCRH_TX);
        uart_port_unlock_irqrestore(&uap->port, flags);
}
=3D=3D=3D

For 16550A (struct uart_ops *)->break_ctl is serial8250_break_ctl():
=3D=3D=3D
static void serial8250_break_ctl(struct uart_port *port, int break_state)
{
        struct uart_8250_port *up =3D up_to_u8250p(port);

        guard(serial8250_rpm)(up);
        guard(uart_port_lock_irqsave)(port);

        if (break_state =3D=3D -1)
                up->lcr |=3D UART_LCR_SBC;
        else
                up->lcr &=3D ~UART_LCR_SBC;
        serial_port_out(port, UART_LCR, up->lcr);
}
=3D=3D=3D

i.e the same logic.

It means that our current code in QEMU is good enough for simple cases
when the guest sets a BRK bit
for a short period of time. The guest can't really see the difference.
I hoped that this pattern when
BRK bit is set and then cleared is the only way how BRK bit is used in
Linux kernel (then our gap in the
implementation would not be noticeable as Linux kernel is our primary
kernel), but it's not.

We actually have:
=3D=3D=3D
/*
 * Split this up, as gcc can choke on it otherwise..
 */
long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
<...>
        case TIOCSBRK: /* Turn break on, unconditionally */
                if (tty->ops->break_ctl)
                        return tty->ops->break_ctl(tty, -1);
                return 0;
        case TIOCCBRK: /* Turn break off, unconditionally */
                if (tty->ops->break_ctl)
                        return tty->ops->break_ctl(tty, 0);
                return 0;
=3D=3D=3D

So even *userspace* can set BRK bit for PL011/16550A for as long as it want=
s to!

The question is why we don't use these ioctls in QEMU to properly
emulate BRK behavior and instead use ioctl(TCSBRK / TCSBRKP)
which sets BRK bit and clears it after a short period of time?.. There
must be a reason, but I'm not familiar with the code
to see it. Ideas?

Link: https://support.arm.com/documentation/ddi0183/f/programmer-s-model/re=
gister-descriptions/line-control-register--uartlcr-h
[1]
Link: https://caro.su/msx/ocm_de1/16550.pdf [2]

Kind regards,
Alex

>
> >
> > > +
> > > +    return 0;
> > > +}
> > > +
> > >  static void pl011_realize(DeviceState *dev, Error **errp)
> > >  {
> > >      PL011State *s =3D PL011(dev);
> > >
> > >      qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_recei=
ve,
> > > -                             pl011_event, NULL, s, NULL, true);
> > > +                             pl011_event, pl011_be_change, s, NULL, =
true);
> > >  }
> >
> > This does make me wonder if having a static pl011_set_handlers helper
> > would keep things tidy and in one place? Either way:
>
> I'm happy to do this too if you want me to. And probably for
> hw/char/serial.c too, then?
>
> >
> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Thanks ;-)
>
> Giving all the suspicion around UARTLCR_H and BRK behavior I still
> believe that I'm not making things
> worse by this change, but better, cause now we can do backend hotswap.
> But it would be great to fully
> understand that part too.
>
> Kind regards,
> Alex
>
> >
> > >
> > >  static void pl011_reset(DeviceState *dev)
> >
> > --
> > Alex Benn=C3=A9e
> > Virtualisation Tech Lead @ Linaro

