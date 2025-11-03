Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7802FCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsuE-0006oq-Mp; Mon, 03 Nov 2025 06:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFsuC-0006od-B4
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 06:39:24 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFsu4-0003Ev-9B
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 06:39:24 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-78677ff31c2so7633897b3.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 03:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762169950; x=1762774750; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6pF3kkuXntak4nnrc0N3uRKfzXMwL4QVoC9oN3Bm58=;
 b=BuYqdBUN5e0W/wyTYayXeYq7l2xUMqaIa1eQpJDzmMUdCovhFeDso7JJjvrWFenb+/
 ybRXJpv2jHnqGorUIhTB6ba/ERJEz7m3qKOo4dCCCBFEs4MUiejUAZ0mDZ7yMM+H+S+C
 BxrtqyyPDhHUvTmK0E22osmWzkeYr3VMTyS0/wYyuncpxTzSss6E6Z1ttw7BPmIP1937
 GZ2DN6iYvuCLqWzK0n7OmiCAswCZrWIvKDe4H28nUwSQOd3J0+rU1ugBGVS1Zdsdb3WA
 iZ05ZfY9zliS5m3FAgmptM66HTot5erlMJy5aLRxK8NCKl8557FywrDuiC0aEmnn1kJt
 XvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762169950; x=1762774750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t6pF3kkuXntak4nnrc0N3uRKfzXMwL4QVoC9oN3Bm58=;
 b=McVHILmdp9yeZZ3ysdjbMv5+oO1+yH5kOylyeJUGIMAXQk2w7qxbNHf3m7ZUNO1Piz
 AYQGpOoejUz/4omCqGvpRw8axUrdyQAW7oGsyHzxsr3hka533i9vRSixIA/nb1CQpvpF
 95/QhNdaMFE0Mf0Qy84+5m3akE/ez5HewsAgVziiATPQmLNII3W8fuNhBV+l192ISACT
 4fWm3PyZnng56XbQL918UWrVFnp8COVemBS3eNTquVGbttRwgtuvaR/WAIrAy2HZcvx0
 PZZJHQZnBGrVAGeKeBlwFC0gwFFH+f7t4YMmlHmqy58Mggp4mvhPyO3dhqv+vc5lK1Qt
 856w==
X-Gm-Message-State: AOJu0Yy9Hn+BdeUssyLMrBnCsskfc9Kb1JCz1UhaQTE7of9T3P8BF81i
 yQYzG3t9L6SYqUfukdkppEH8JFT+oqUHg0BD6hstx+B7FVMcViJnbdp6AOOwmIPyDQdQxr9H+xq
 iWoU4TgsR0AhHEwqdr9kB1A7WqSYJmLrWl+pZ5aFzCg==
X-Gm-Gg: ASbGncuJ+ci0lWoRlecbqGqet+uF9xCvBpenWIqZCSIkLIG6/wpuQhI2ZOotyszOPfH
 R5HJbq29KoshBbkgpp5qCRU+A9lp3ChbvpwHiaBtjAopyOrrkiOXfvh5NrZPSw3jtJoVR1v3OMK
 uQyYXYBEuH23ynqjh9jiFZg+6YSIiDA3GeSE9f0F4t56afdDv+MMpkn/B42GuNvi/g466Sb8Ozi
 T/nyXXlFXZUHrA7SxpDxklWGp/1ULbQDrQePffUbXAfg/GNYAM2armyO575aQ==
X-Google-Smtp-Source: AGHT+IGuDmwrVsFF4MhmH0f8OuwEhToe+IuM8To589yuUiFn/GQaJ2tGNJbj5kV/JtE8yTyghNzZltlHkkYkB1JEkVQ=
X-Received: by 2002:a05:690c:4809:b0:786:6f81:eb21 with SMTP id
 00721157ae682-7866f81ef65mr39474257b3.21.1762169949657; Mon, 03 Nov 2025
 03:39:09 -0800 (PST)
MIME-Version: 1.0
References: <20251028160042.3321933-1-peter.maydell@linaro.org>
 <1a8ea87f-41b2-40a5-8511-df019b5833c5@linaro.org>
In-Reply-To: <1a8ea87f-41b2-40a5-8511-df019b5833c5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Nov 2025 11:38:57 +0000
X-Gm-Features: AWmQ_bmrqGLjfT9XU-Grekc9c2samUx8AXYco0RhjdFbwJy8Fm1zZybN25Uz3mw
Message-ID: <CAFEAcA_sd3-Kj6U3-E3+T5c+KMDy-wBXG-g0meb6Jp2ma1OGsw@mail.gmail.com>
Subject: Re: [PATCH] net: pad packets to minimum length in
 qemu_receive_packet()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Bin Meng <bmeng@tinylab.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 3 Nov 2025 at 11:35, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 28/10/25 17:00, Peter Maydell wrote:
> > In commits like 969e50b61a28 ("net: Pad short frames to minimum size
> > before sending from SLiRP/TAP") we switched away from requiring
> > network devices to handle short frames to instead having the net core
> > code do the padding of short frames out to the ETH_ZLEN minimum size.
> > We then dropped the code for handling short frames from the network
> > devices in a series of commits like 140eae9c8f7 ("hw/net: e1000:
> > Remove the logic of padding short frames in the receive path").
> >
> > This missed one route where the device's receive code can still see a
> > short frame: if the device is in loopback mode and it transmits a
> > short frame via the qemu_receive_packet() function, this will be fed
> > back into its own receive code without being padded.
> >
> > Add the padding logic to qemu_receive_packet().
> >
> > This fixes a buffer overrun which can be triggered in the
> > e1000_receive_iov() logic via the loopback code path.
> >
> > Other devices that use qemu_receive_packet() to implement loopback
> > are cadence_gem, dp8393x, lan9118, msf2-emac, pcnet, rtl8139
> > and sungem.
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3043
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I think this is the right fix, but I'm not very familiar
> > with the net internals...
> > ---
> >   net/net.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/net/net.c b/net/net.c
> > index 27e0d278071..8aefdb3424f 100644
> > --- a/net/net.c
> > +++ b/net/net.c
> > @@ -775,10 +775,20 @@ ssize_t qemu_send_packet(NetClientState *nc, cons=
t uint8_t *buf, int size)
> >
> >   ssize_t qemu_receive_packet(NetClientState *nc, const uint8_t *buf, i=
nt size)
> >   {
> > +    uint8_t min_pkt[ETH_ZLEN];
> > +    size_t min_pktsz =3D sizeof(min_pkt);
> > +
> >       if (!qemu_can_receive_packet(nc)) {
> >           return 0;
> >       }
> >
> > +    if (net_peer_needs_padding(nc)) {
> > +        if (eth_pad_short_frame(min_pkt, &min_pktsz, buf, size)) {
> > +            buf =3D min_pkt;
> > +            size =3D min_pktsz;
> > +        }
> > +    }
> > +
> >       return qemu_net_queue_receive(nc->incoming_queue, buf, size);
> >   }
>
> Nitpicking, variables scope can be reduced:

We can't move min_pkt to inside the if() because that
array has to stay in scope until the call to
qemu_net_queue_receive() returns (we have a live
pointer into it).

thanks
-- PMM

