Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E56C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 13:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYQF9-0008WC-MH; Mon, 29 Jul 2024 09:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYQF6-0008VD-KJ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 09:16:48 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYQF4-0001Nv-Jb
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 09:16:48 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0468so53898941fa.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722259005; x=1722863805; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UANyp+8rxjJ+X3O5/Dp4xmNtsX1NXYs9fbLe1Rv43m0=;
 b=ZO69wWc1FWl6aQ/wnOq/K8fIGiUgYIaQuxq5I0I9vG4ZmoFmaDi9i4MDI4Fg66Dj1d
 SdMJZXEzKLIC+0Kw+SO+vGo+gumVa/YX1eI11viOiRCYj6MvSq8f36IHWQS+pNc5DloL
 NPAFZeGA5ekhvkscVDYAkJb2b0GlWho6JpEyChIbI7JBxiOESTEuboSTvU28CFU0YrT9
 kPVMGE7u3mwpNj1g5qe84/jNF7J0qo7Pi1RQr2glE7gfHRHbcwInIgdPshDYMpGD+V1+
 D0s/UzIzyHA0RHODtIt52b2k8DmAHUXzP/OZk5cLGWzngVp0CDqxzCW2Y4KMNBtnt07d
 xvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722259005; x=1722863805;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UANyp+8rxjJ+X3O5/Dp4xmNtsX1NXYs9fbLe1Rv43m0=;
 b=PUdUtDJmQd1aP5PUBvkgevmtx1JslRt90kyb3IM8aZlmlx2r138d3trd84Oah5Ia+g
 8/9Vc7PIXj2yl2C0R9ydvSdLAzhJN49FSUo5FpPUdQ1Cpb8gvvKsrBQ+acbD+uvpj1+s
 6O29pLq14VPNYPB6JA0R3b83UDdIcfeFDMRMMM4KSEWWyz8fh4KN6dBxElXW5I1h4moA
 kc7QVYGes9Aw8fI+oz+qKY/RWwIr8L0goNdRIfyjh9QDP/dgQfv2zLNlr2KajBYpf3Il
 Xj1BLWdRv4c9eS2rZ82q9Oga4HbNg1Oz1rFg8h3/CTIi3kho26Sru3W/k+XGRUUXzWei
 +9Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd8Z1991KHa7v9WiOCOmpBX7AJ2z0EckMU2jP1nymqr/TibYjyb/kdxU1Nz1hz6phZANeJLRB1mT9o/bhmFJ85qKqyXEg=
X-Gm-Message-State: AOJu0Ywu862ghpKlquFoisbypkZb6K7DXvKHGezVmkVw/6hdayOAUyH0
 KtxgU4JLQ2S3O6+c2RPpFX3y6Xg0YpIdXJYt1+sHSF51Vk02nukUIgaWPYi6M1qyartx0yivAx6
 nlGgTtMMleX1J3JQeDpgg0e6qzOLXDHatp9uS/w==
X-Google-Smtp-Source: AGHT+IHoH3K8jsPvUE8/B2jMRY92sSIVFeStKFFNhF5Wbzo/vbYaqbH5iav8W3J/lNbtaQtAgsyq841gQxbhhNaJUig=
X-Received: by 2002:a2e:868c:0:b0:2ef:1bd5:bac3 with SMTP id
 38308e7fff4ca-2f12ee55a92mr50331841fa.41.1722259004491; Mon, 29 Jul 2024
 06:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240725235410.451624-1-npiggin@gmail.com>
 <20240725235410.451624-39-npiggin@gmail.com>
 <8d93da65-36a9-4642-9345-1b698191ba49@kaod.org>
In-Reply-To: <8d93da65-36a9-4642-9345-1b698191ba49@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 14:16:33 +0100
Message-ID: <CAFEAcA9E8WRPumTsGh_UCnD-juLFr81BJWZWXEOKTQPkfy8upA@mail.gmail.com>
Subject: Re: [PULL 38/96] hw/ssi: Extend SPI model
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Chalapathi V <chalapathi.v@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Mon, 29 Jul 2024 at 11:33, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 7/26/24 01:53, Nicholas Piggin wrote:
> > From: Chalapathi V <chalapathi.v@linux.ibm.com>
> >
> > In this commit SPI shift engine and sequencer logic is implemented.
> > Shift engine performs serialization and de-serialization according to t=
he
> > control by the sequencer and according to the setup defined in the
> > configuration registers. Sequencer implements the main control logic an=
d
> > FSM to handle data transmit and data receive control of the shift engin=
e.




> > +static inline uint8_t get_seq_index(PnvSpi *s)
> > +{
> > +    return GETFIELD(SPI_STS_SEQ_INDEX, s->status);
> > +}
>
> Coverity reports :
>
> >>>     CID 1558827:    (OVERRUN)
> >>>     Overrunning array "s->seq_op" of 8 bytes at byte offset 16 using =
index "get_seq_index(s) + 1" (which evaluates to 16).
>
>
> get_seq_index() can return a value between 0 and 15 and it is used in a c=
ouple
> of places to index array s->seq_op[] which is an 8 bytes array.
>
> Should we increase the size of the seq_op array ?

I think in most places this can't happen, because:

> > +    /*
> > +     * There are only 8 possible operation IDs to iterate through thou=
gh
> > +     * some operations may cause more than one frame to be sequenced.
> > +     */
> > +    while (get_seq_index(s) < NUM_SEQ_OPS) {

The loop condition enforces that the sequence index is < 8.

> > +        opcode =3D s->seq_op[get_seq_index(s)];

Coverity isn't smart enough to be able to tell that this
call to get_seq_index() must return the same value as the
previous one and so be in bounds for the array, which is why it's
complaining.

On the other hand:
 * this is also not totally obvious to humans
 * it means we're doing the shift-and-mask ops to get the
   sequence index out every time

Maybe we should keep it in a variable? (Depends whether there's
a bunch of places in the loop that want to update the index, or
if we just do that at the end of the loop.)

Another option would be to have a version of get_seq_index() that
asserts that the index is valid.

The other design approach available here is to have the device
state struct hold the underlying information in a split-out way
(so e.g s->seq_index and other fields), and then assemble those
into a 32-bit value for the status register in the "guest reads/writes
the register codepath).

That said, there is also a case which I suspect really is an
overrun bug:

> > +        case SEQ_OP_SHIFT_N1:
> > +            s->status =3D SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STA=
TE_EXECUTE);
> > +            trace_pnv_spi_sequencer_op("SHIFT_N1", get_seq_index(s));
> > +            /*
> > +             * Only allow a shift_n1 when the state is not IDLE or DON=
E.
> > +             * In either of those two cases the sequencer is not in a =
proper
> > +             * state to perform shift operations because the sequencer=
 has:
> > +             * - processed a responder deselect (DONE)
> > +             * - processed a stop opcode (IDLE)
> > +             * - encountered an error (IDLE)
> > +             */
> > +            if ((GETFIELD(SPI_STS_SHIFTER_FSM, s->status) =3D=3D FSM_I=
DLE) ||
> > +                (GETFIELD(SPI_STS_SHIFTER_FSM, s->status) =3D=3D FSM_D=
ONE)) {
> > +                qemu_log_mask(LOG_GUEST_ERROR, "Shift_N1 not allowed i=
n "
> > +                              "shifter state =3D 0x%llx", GETFIELD(
> > +                        SPI_STS_SHIFTER_FSM, s->status));
> > +                /*
> > +                 * Set sequencer FSM error bit 3 (general_SPI_status[3=
])
> > +                 * in status reg.
> > +                 */
> > +                s->status =3D SETFIELD(SPI_STS_GEN_STATUS_B3, s->statu=
s, 1);
> > +                trace_pnv_spi_sequencer_stop_requested("invalid shifte=
r state");
> > +                stop =3D true;
> > +            } else {
> > +                /*
> > +                 * Look for the special case where there is a shift_n1=
 set for
> > +                 * transmit and it is followed by a shift_n2 set for t=
ransmit
> > +                 * AND the combined transmit length of the two operati=
ons is
> > +                 * less than or equal to the size of the TDR register.=
 In this
> > +                 * case we want to use both this current shift_n1 opco=
de and the
> > +                 * following shift_n2 opcode to assemble the frame for
> > +                 * transmission to the responder without requiring a r=
efill of
> > +                 * the TDR between the two operations.
> > +                 */
> > +                if (PNV_SPI_MASKED_OPCODE(s->seq_op[get_seq_index(s) +=
 1])
> > +                                =3D=3D SEQ_OP_SHIFT_N2) {

Here we look at the seq_op[] array for get_seq_index(s) + 1,
so if we're on the last iteration of the loop because the seq
index is 7 we'll read off the end of the array at index 8.

(Presumably the correct behaviour if the shift_n1 is the last
operation is that it's not this special case.)

> > +                    send_n1_alone =3D false;
> > +                }
> > +                s->status =3D SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
> > +                                FSM_SHIFT_N1);

thanks
-- PMM

