Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3A5C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 07:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seUfO-0008EO-LH; Thu, 15 Aug 2024 03:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1seUfG-0008D9-9m; Thu, 15 Aug 2024 03:12:54 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1seUfE-0001vp-99; Thu, 15 Aug 2024 03:12:53 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-710dc3015bfso441476b3a.0; 
 Thu, 15 Aug 2024 00:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723705969; x=1724310769; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p44C8fERsSRYQkkQyzymFn1pVVaUH+QWqY2k98VCWpA=;
 b=ZaC+8okAiyrmrGxWInCQHIyMFpLGrJJX80fin7uIg65x/5wpfV0kkE60jCkJWr9he0
 2U4/C5CIRFxrA6HvZwCV8TlZ4KoeU+3l1pUMYToAS26O99F7Vbd5INY3iGnVXKkV0Qjx
 FhIZZxico/T4tMMw7anWRVsVZDmUyU/ZcwJgSarm7g8khIKNVY9rXuO9OFUjAxINMAZ6
 pO1uFTcbaEAv3FVd2PGkD5FK8V51w86flKCsuSZvTJrDMH1NWk3Ks675O4l3vkEoJyWt
 xv3Vptky2Jdf+SY2FOLPyvstSAI4hBJybMJ4z2riRe4YMpOFCuz3WZjal9HJ3b7rxDi1
 JD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723705969; x=1724310769;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p44C8fERsSRYQkkQyzymFn1pVVaUH+QWqY2k98VCWpA=;
 b=R+unl9+L1o5JfDT3EyQhA+NYbuamGjT7VykY8Wg6nT/5aRCaaAjYzQqPYyEd96J76D
 Cs5FzIOVo/l7THlK/kJBFqzd2QqboPOL6UZzF04PFAnrqbksi+2b+scRY/jnxAvEJ4gf
 u9xX3Ex2KHpFhkuKwp2makbqzuju9XOqKnqkJAdxuma6gPZwal9sVkHzBnV0SeGOopMA
 Eud/E1B019ovl4+4IySegKLbiyH3Q7TVhElGGHgVKTnE3I3es2lk1uFO0mX0blyh4ntW
 Y0QwXdpeu0D9noe+WmuIpaP6dB+HFJc/62q69pAacwVRSdjKvgMAzfx0NLr5PNR6KR5z
 CZlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj3Xr/ArOLhKaTtNTanBBKkSKykL3ipoXrqCo4gxsiGv8tUZIRjUcCQ3zvwmKb6ptDKaEcDEKpUAYDqEhjLHbgooJ/qw/PbdjYpuUUKQCm+e2pmqPxFGUkbTMZjcGpDx2I6TTVdOFgn0zc+y4ksdT/jA==
X-Gm-Message-State: AOJu0Yy5/fJOaR9j7zGrZC89zb4Y2RnAXqwe89UCjF6eO+ePJd49+x7v
 ZV37o0D/fvK+jyN0OHWBwgsMf6W6noKeZ5NUHwmdKwipM2csrIFE
X-Google-Smtp-Source: AGHT+IE7rhqF7AoUY4l8ZHu5L54QNuP56/MeZb/fUoS7zwo8PbyG03bMmxV/Akc8UpDL2PaAff/3lg==
X-Received: by 2002:a05:6a00:816:b0:70d:26cd:9741 with SMTP id
 d2e1a72fcca58-71276fbd507mr3022597b3a.12.1723705969120; 
 Thu, 15 Aug 2024 00:12:49 -0700 (PDT)
Received: from localhost ([1.145.66.109]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af3aeaasm535479b3a.191.2024.08.15.00.12.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 00:12:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Aug 2024 17:12:32 +1000
Message-Id: <D3GARIYVC16C.20SXVKSIMLED4@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, "Michael S.
 Tsirkin" <mst@redhat.com>
Cc: <qemu-devel@nongnu.org>, "Alistair Francis" <alistair.francis@wdc.com>,
 "Michael Roth" <michael.roth@amd.com>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Mahmoud Mandour" <ma.mandourr@gmail.com>, "Pavel
 Dovgalyuk" <pavel.dovgaluk@ispras.ru>, "Yoshinori Sato"
 <ysato@users.sourceforge.jp>, "Weiwei Li" <liwei1518@gmail.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, =?utf-8?q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, "Markus Armbruster" <armbru@redhat.com>,
 "David Hildenbrand" <david@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, "Eric Auger"
 <eric.auger@redhat.com>, "Song Gao" <gaosong@loongson.cn>,
 <qemu-arm@nongnu.org>, "Peter Xu" <peterx@redhat.com>, "Jiri Pirko"
 <jiri@resnulli.us>, "Eric Blake" <eblake@redhat.com>, "Fabiano Rosas"
 <farosas@suse.de>, <qemu-s390x@nongnu.org>, "Peter Maydell"
 <peter.maydell@linaro.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>, "John Snow" <jsnow@redhat.com>, "Alexandre
 Iooss" <erdnaxe@crans.org>, "Konstantin Kostiuk" <kkostiuk@redhat.com>,
 "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, "Cleber Rosa"
 <crosa@redhat.com>, "Ilya Leoshkevich" <iii@linux.ibm.com>,
 <qemu-riscv@nongnu.org>, "Thomas Huth" <thuth@redhat.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "Richard Henderson" <richard.henderson@linaro.org>,
 "Jason Wang" <jasowang@redhat.com>, "Bin Meng" <bmeng.cn@gmail.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Pavel Dovgalyuk"
 <Pavel.Dovgalyuk@ispras.ru>
Subject: Re: [PATCH v2 16/21] virtio-net: Use replay_schedule_bh_event for
 bhs that affect machine state
X-Mailer: aerc 0.18.2
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
 <20240813202329.1237572-17-alex.bennee@linaro.org>
 <20240813164631-mutt-send-email-mst@kernel.org>
 <D3FEPPLH78YW.3BYA9B4HYGN1U@gmail.com>
 <20240814030308-mutt-send-email-mst@kernel.org>
 <87y14z81ak.fsf@draig.linaro.org>
In-Reply-To: <87y14z81ak.fsf@draig.linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Aug 15, 2024 at 3:25 AM AEST, Alex Benn=C3=A9e wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
>
> > On Wed, Aug 14, 2024 at 04:05:34PM +1000, Nicholas Piggin wrote:
> >> On Wed Aug 14, 2024 at 6:48 AM AEST, Michael S. Tsirkin wrote:
> >> > On Tue, Aug 13, 2024 at 09:23:24PM +0100, Alex Benn=C3=A9e wrote:
> >> > > From: Nicholas Piggin <npiggin@gmail.com>
> >> > >=20
> >> > > The regular qemu_bh_schedule() calls result in non-deterministic
> >> > > execution of the bh in record-replay mode, which causes replay fai=
lure.
> >> > >=20
> >> > > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> > > Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> >> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> > > Message-Id: <20240813050638.446172-9-npiggin@gmail.com>
> >> > > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> > > ---
> >> > >  hw/net/virtio-net.c | 11 ++++++-----
> >> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> >> > >=20
> >> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >> > > index 08aa0b65e3..10ebaae5e2 100644
> >> > > --- a/hw/net/virtio-net.c
> >> > > +++ b/hw/net/virtio-net.c
> >> > > @@ -40,6 +40,7 @@
> >> > >  #include "migration/misc.h"
> >> > >  #include "standard-headers/linux/ethtool.h"
> >> > >  #include "sysemu/sysemu.h"
> >> > > +#include "sysemu/replay.h"
> >> > >  #include "trace.h"
> >> > >  #include "monitor/qdev.h"
> >> > >  #include "monitor/monitor.h"
> >> > > @@ -417,7 +418,7 @@ static void virtio_net_set_status(struct VirtI=
ODevice *vdev, uint8_t status)
> >> > >                  timer_mod(q->tx_timer,
> >> > >                                 qemu_clock_get_ns(QEMU_CLOCK_VIRTU=
AL) + n->tx_timeout);
> >> > >              } else {
> >> > > -                qemu_bh_schedule(q->tx_bh);
> >> > > +                replay_bh_schedule_event(q->tx_bh);
> >> > >              }
> >> > >          } else {
> >> > >              if (q->tx_timer) {
> >> > > @@ -2672,7 +2673,7 @@ static void virtio_net_tx_complete(NetClient=
State *nc, ssize_t len)
> >> > >           */
> >> > >          virtio_queue_set_notification(q->tx_vq, 0);
> >> > >          if (q->tx_bh) {
> >> > > -            qemu_bh_schedule(q->tx_bh);
> >> > > +            replay_bh_schedule_event(q->tx_bh);
> >> > >          } else {
> >> > >              timer_mod(q->tx_timer,
> >> > >                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->=
tx_timeout);
> >> > > @@ -2838,7 +2839,7 @@ static void virtio_net_handle_tx_bh(VirtIODe=
vice *vdev, VirtQueue *vq)
> >> > >          return;
> >> > >      }
> >> > >      virtio_queue_set_notification(vq, 0);
> >> > > -    qemu_bh_schedule(q->tx_bh);
> >> > > +    replay_bh_schedule_event(q->tx_bh);
> >> > >  }
> >> > > =20
> >> > >  static void virtio_net_tx_timer(void *opaque)
> >> > > @@ -2921,7 +2922,7 @@ static void virtio_net_tx_bh(void *opaque)
> >> > >      /* If we flush a full burst of packets, assume there are
> >> > >       * more coming and immediately reschedule */
> >> > >      if (ret >=3D n->tx_burst) {
> >> > > -        qemu_bh_schedule(q->tx_bh);
> >> > > +        replay_bh_schedule_event(q->tx_bh);
> >> > >          q->tx_waiting =3D 1;
> >> > >          return;
> >> > >      }
> >> > > @@ -2935,7 +2936,7 @@ static void virtio_net_tx_bh(void *opaque)
> >> > >          return;
> >> > >      } else if (ret > 0) {
> >> > >          virtio_queue_set_notification(q->tx_vq, 0);
> >> > > -        qemu_bh_schedule(q->tx_bh);
> >> > > +        replay_bh_schedule_event(q->tx_bh);
> >> > >          q->tx_waiting =3D 1;
> >> > >      }
> >> > >  }
> >> > > --=20
> >> > > 2.39.2
> >> >
> >> >
> >> > Is this really the only way to fix this? I do not think
> >> > virtio has any business knowing about replay.
> >> > What does this API do, even? BH but not broken with replay?
> >> > Do we ever want replay broken? Why not fix qemu_bh_schedule?
> >> > And when we add another feature which we do not want to break
> >> > will we do foo_bar_replay_bh_schedule_event or what?
> >>=20
> >> I agree with you. We need to do this (a couple of other hw
> >> subsystems already do and likely some are still broken vs
> >> replay and would need to be converted), but I think it's
> >> mostly a case of bad naming. You're right the caller should
> >> not know about replay at all, what it should be is whether
> >> the event is for the target machine or the host harness,
> >> same as timers are VIRTUAL / HOST.
> >> So I think we just need to make a qemu_bh_schedule_<type>,
> >> or qemu_bh_scheudle_event(... QEMU_EVENT_VIRTUAL/HOST/etc).
> >
> > Or just pass QEMUClockType?

Could be a good idea. Although I'm not sure what to do with
all types, maybe we can restrict what is supported.

> Is this wider re-factoring something that can wait for the next
> developer cycle?

I would say so. It's not quite trivial to do nicely since
things are a bit tangled between util/async and replay.

> >> I had started on a conversion once but not completed it.
> >> I could resurrect if there is agreement on the API?
>
> I would certainly welcome it being cleaned up. The supported replay
> devices are very piecemeal at the moment.

I'll tidy up and post an RFC for how the new API might look.

Thanks,
Nick

