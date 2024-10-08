Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887DACEFC37
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 17:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syDy0-0005xB-Mh; Tue, 08 Oct 2024 13:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1syDxw-0005wi-Ty
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 13:25:44 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1syDxv-0000Qp-5I
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 13:25:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cb1dd2886so18905e9.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728408342; x=1729013142; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bfbx6EmxK+mJ0k1bVBhXjrEoburTDH+qO0aKQ385QP4=;
 b=3f/w8W62XhGALvrGsgItepceQd2DWPNMioABYd3BQs2KnYOwOABzTSJwdwD0zin22g
 VT7NZBjpstIkWX0GBUrp1efObq34jQOLpCClH471A4D054zOqQUfD4yat7NoRw9iNx98
 iw1z1A8FRHBkFl1OLrob9SD8+YMZZUIpLQqsR5n4UqFPYRHKzmHeLHnwewHxWF5yPAjF
 lJ7+HCOnFmYN2+Ji1hy0gAJ5CUd2kdW3BwmXifvgFGpwn2h70L00faVbZV1xuXA2Pkr5
 EGE3paXOPuH1Z1DXp6JegaSO8y8hnRuX1hrUtt42iL/CixdzYjvf9jSnsM7B67egmvMH
 jB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728408342; x=1729013142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bfbx6EmxK+mJ0k1bVBhXjrEoburTDH+qO0aKQ385QP4=;
 b=FrmD8gaCNg9oGCmzg8HlTbl0KcH32py8t/u5Y/MtfMVZ/LYsym+h3VGBHYHnvIu4sg
 uEokBGT43extFl4OUYEuKysXqfYWV0GrnZRAIK+3hgRFC3wdETNPnNh+WXITN7TJH7Ft
 zxnSYVMKiq6W8Z5OjYXXrehA+5ib7gy5yEWNuhB52cSOxh1H23jLGDkHAjf4SCWaV092
 TAJ/VGvxMjabFl9Yr1txnYTII5sXvAYl8wetNsEoE3qXBHRPeJ13Mo1O50F8xfxfx3Zs
 6C+nm2A7U7X6Sv3XukRqNPtyrRNwEHohxNIFKBxCdlaxJjcdSsfZh5Sn33fujYsgvTY/
 Cjuw==
X-Gm-Message-State: AOJu0Yzj/mTqhCBJdneoywcpt97eretG2yKj3oBxdsC1ct216Ji3ERdy
 aVRR2fIPeBmk7kotikmcledzz8nGtHrc60iW805sjmAb/Al0yjfeTfVk3rM8lfpkchPxdZLNiL5
 UG7luI/rz1oTfcKgj9Hmj7QBZo+GBZEpgSbjh
X-Google-Smtp-Source: AGHT+IGa6ug6wj9gYyuTbjxFQXfyTbpqWsUw1G45PVzUbImHfnJpD7El1jFRyUgogFAUeCl1+gzyaYFgrhFebgkdp58=
X-Received: by 2002:a05:600c:c0b:b0:42b:a8fc:3937 with SMTP id
 5b1f17b1804b1-42fcdcdbc9emr6126525e9.4.1728408341432; Tue, 08 Oct 2024
 10:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
 <20241008011852.1439154-2-tavip@google.com>
 <7994769f-efed-4eff-aac7-aa3828f603b7@ilande.co.uk>
In-Reply-To: <7994769f-efed-4eff-aac7-aa3828f603b7@ilande.co.uk>
From: Octavian Purdila <tavip@google.com>
Date: Tue, 8 Oct 2024 10:25:29 -0700
Message-ID: <CAGWr4cT=UWvk_v=908bhdbrg61tz8pgpa14_K+vps0d0sTZTJQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/25] fifo32: add peek function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 berrange@redhat.com, eduardo@habkost.net, luc@lmichel.fr, 
 damien.hedde@dahe.fr, alistair@alistair23.me, thuth@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=tavip@google.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.027,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Tue, Oct 8, 2024 at 4:27=E2=80=AFAM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 08/10/2024 02:18, Octavian Purdila wrote:
>
> > Add fifo32_peek() that returns the first element from the queue
> > without popping it.
> >
> > Signed-off-by: Octavian Purdila <tavip@google.com>
> > ---
> >   include/qemu/fifo32.h | 28 ++++++++++++++++++++++++++++
> >   1 file changed, 28 insertions(+)
> >
> > diff --git a/include/qemu/fifo32.h b/include/qemu/fifo32.h
> > index 4e9fd1b5ef..9de1807375 100644
> > --- a/include/qemu/fifo32.h
> > +++ b/include/qemu/fifo32.h
> > @@ -140,6 +140,34 @@ static inline uint32_t fifo32_pop(Fifo32 *fifo)
> >       return ret;
> >   }
> >
> > +/**
> > + * fifo32_peek:
> > + * @fifo: fifo to peek at
> > + *
> > + * Returns the value from the FIFO's head without poping it. Behaviour
> > + * is undefined if the FIFO is empty. Clients are responsible for
> > + * checking for emptiness using fifo32_is_empty().
> > + *
> > + * Returns: the value from the FIFO's head
> > + */
> > +
> > +static inline uint32_t fifo32_peek(Fifo32 *fifo)
> > +{
> > +    uint32_t ret =3D 0, num;
> > +    const uint8_t *buf;
> > +
> > +    buf =3D fifo8_peek_bufptr(&fifo->fifo, 4, &num);
>
> Are you sure that you want to use fifo8_peek_bufptr() as opposed to fifo8=
_peek_buf()
> here? The reason for using the latter function (and why fifo8_*_bufptr() =
functions
> are not generally recommended) is that they will correctly handle the FIF=
O wraparound
> caused by the drifting head pointer which can occur if you don't empty th=
e entire
> FIFO contents in a single *_pop() or *_pop_buf() operation.
>

I don't think that it matters in this case because the size of the
FIFO is always going to be a multiple of 4 and all push and pop
operations happen with 4 bytes as well. Am I missing something?

In any case, if it makes things more clear / consistent I can switch
to fifo8_peek_buf.

> > +    if (num !=3D 4) {
> > +        return ret;
> > +    }
> > +
> > +    for (int i =3D 0; i < sizeof(uint32_t); i++) {
> > +        ret |=3D buf[i] << (i * 8);
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> >   /**
> >    * There is no fifo32_pop_buf() because the data is not stored in the=
 buffer
> >    * as a set of native-order words.
>
>
> ATB,
>
> Mark.
>

