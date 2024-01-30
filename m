Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41D1C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 12:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUnR8-0007jV-7D; Tue, 30 Jan 2024 07:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rUnR4-0007bJ-Qp
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:41:54 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rUnR2-0003b8-25
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:41:54 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-295c67ab2ccso121672a91.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 04:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1706618510; x=1707223310; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZGwxZb9AEKdQmBPPo1ZiTL9DBvhxnDTfHx7Qf4FIA8=;
 b=emHbpR4yjXTVCc55Bo5ACV7BN1NxOKUMNABZKPhM/8xHtjaEbLtiAFVCoIZ3MEjlz8
 Dij91mxNzdFJSg3+uAH/xuTiZsjZ/nf7SWYXKtH3oRGbbeqDhyxpGaIViHDnutK8eHsW
 Kli5N9SuCv4TAPei3oIU7nMcuqSKBN7vFAP00yKcTzT1j9P1iG6si9YW1IGWgh/d1qow
 96/Si5LncFeDfcNK6v867Izaiv/xzmecKktQUBisP6CNkQb7+xinw6Yt9E5NA7JD99f3
 +XoIVi4dkwBZQN0KE2ZxZ0NJtsB7lu2JuieDr+xCJfEqwmEeaU0l97CDxnhNFdCZbVoD
 zG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706618510; x=1707223310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JZGwxZb9AEKdQmBPPo1ZiTL9DBvhxnDTfHx7Qf4FIA8=;
 b=Nsb7tbxvgiTX9Qe0QWuDbRag/++vvC/a00cXXJyROu1iAtEa7eOxFP0fr1vs5L8Pt+
 l1Z/Vzipn8yfo5ZUkQT/0gYa8Eo784T7xZKW4exs8BUvb3eu4jPxIPycFwv/0YF+aYIv
 8k7BKrIAtrY7SmLVQuLfqHf7U2eoYelM5Ce6tMRQj5fqwdCTrLAtQ8FjLsUhlHzDtHxs
 kVC+GoyWi0CsajPflDMXpLdkx6m6Py/NsRRW2fMYNu6jexqpDvwz7DtEZ8Rq5PBw3Hbe
 ZS9apUAkzutDEXHZ02JRKdzFRd8LmhF46ToTvyOIROQzXdAyMQ66HLPvMG5FJYKFHvLE
 aW1A==
X-Gm-Message-State: AOJu0YzBLHrfuUDD8PsMqrW57H9RS4LTw+xUaKcRzUVPtbPaZuREti4H
 pfVrVx8aEcOkQVQiFNglwSpxctvxHAvQ8JONTex+xMNeZfwYIr9r3jIwS809AwOV0rroJ1k3SD/
 CdF8UUB2DL4I8EizJDmqWogCH8I17FvhyErzP
X-Google-Smtp-Source: AGHT+IE88SIPTQ9wuzc8MKzbk/1ujZLqaRT7yrs76NfueljqZdFzjDyf9jkFJdw9zgY42G8fRiL383+QCkRG071qNjA=
X-Received: by 2002:a17:90b:1244:b0:290:8bbf:e4c0 with SMTP id
 gx4-20020a17090b124400b002908bbfe4c0mr3892953pjb.39.1706618510563; Tue, 30
 Jan 2024 04:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20240116130213.172358-1-chigot@adacore.com>
 <20240116130213.172358-8-chigot@adacore.com>
 <61f637bc-96da-48f6-8798-95426060deff@linaro.org>
In-Reply-To: <61f637bc-96da-48f6-8798-95426060deff@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Tue, 30 Jan 2024 13:41:39 +0100
Message-ID: <CAJ307EgiXGn0U19GTN72nqqcB6_SAqyYckqnf3V_teFHP+wSpg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] leon3: check cpu_id in the tiny bootloader
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=chigot@adacore.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Jan 30, 2024 at 10:15=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 16/1/24 14:02, Cl=C3=A9ment Chigot wrote:
> > Now that SMP is possible, the asr17 must be checked in the little boot =
code
> > or the secondary CPU will reinitialize the Timer and the Uart.
> >
> > Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> > ---
> >   hw/sparc/leon3.c | 22 ++++++++++++++++++++--
> >   1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> > index eacd85ee4f..87a8044a3e 100644
> > --- a/hw/sparc/leon3.c
> > +++ b/hw/sparc/leon3.c
> > @@ -100,13 +100,27 @@ static uint32_t *gen_store_u32(uint32_t *code, hw=
addr addr, uint32_t val)
> >
> >   /*
> >    * When loading a kernel in RAM the machine is expected to be in a di=
fferent
> > - * state (eg: initialized by the bootloader). This little code reprodu=
ces
> > - * this behavior.
> > + * state (eg: initialized by the bootloader).  This little code reprod=
uces
> > + * this behavior.  Also this code can be executed by the secondary cpu=
s as
> > + * well since it looks at the %asr17 register before doing any
> > + * initialization, it allows to use the same reset address for all the
> > + * cpus.
> >    */
> >   static void write_bootloader(CPUSPARCState *env, uint8_t *base,
> >                                hwaddr kernel_addr)
> >   {
> >       uint32_t *p =3D (uint32_t *) base;
> > +    uint32_t *sec_cpu_branch_p =3D NULL;
> > +
> > +    /* If we are running on a secondary CPU, jump directly to the kern=
el.  */
> > +
> > +    stl_p(p++, 0x85444000); /* rd %asr17, %g2      */
> > +    stl_p(p++, 0x8530a01c); /* srl  %g2, 0x1c, %g2 */
> > +    stl_p(p++, 0x80908000); /* tst  %g2            */
> > +    /* Fill that later.  */
>
>        /* Filled below. */
>
> > +    sec_cpu_branch_p =3D p;
> > +    stl_p(p++, 0x0BADC0DE); /* bne xxx             */
> > +    stl_p(p++, 0x01000000); /* nop */
> >
> >       /* Initialize the UARTs                                        */
> >       /* *UART_CONTROL =3D UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; =
*/
> > @@ -120,6 +134,10 @@ static void write_bootloader(CPUSPARCState *env, u=
int8_t *base,
> >       /* *GPTIMER0_CONFIG =3D GPTIMER_ENABLE | GPTIMER_RESTART;        =
*/
> >       p =3D gen_store_u32(p, 0x80000318, 3);
> >
> > +    /* Now, the relative branch above can be computed.  */
> > +    stl_p(sec_cpu_branch_p, 0x12800000
> > +          + (p - sec_cpu_branch_p));
> > +
> >       /* JUMP to the entry point                                     */
> >       stl_p(p++, 0x82100000); /* mov %g0, %g1 */
> >       stl_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
>
> Alternatively have main_cpu_reset / secondary_cpu_reset handlers.
> You could split BL in HWINIT / JUMP, have HWINIT() return # instr
> used and adjust secondary_cpu_reset entry.

Indeed that would make this code a bit easier to maintain. I'll keep
it for a future MR if you don't mind.
Thanks for the idea anyway.

> Anyway,
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

