Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430E5C52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 06:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se799-0008Ry-OL; Wed, 14 Aug 2024 02:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1se78y-0008Qf-Ed; Wed, 14 Aug 2024 02:06:01 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1se78v-0007EW-O9; Wed, 14 Aug 2024 02:05:59 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5da686531d3so1183084eaf.3; 
 Tue, 13 Aug 2024 23:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723615554; x=1724220354; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQkMJkL9vL2igVIu7c4khKnTRZrEXKbAcPuAdwKii3Y=;
 b=jPvQfr1hapV9jg1aJSng8+f3EPXfsUOty+7FTcKzp/5o+Gzwurp4k4gh3sfvrqyq2R
 /vT9KVgTHk3C8Nsd8HjoH9TM9NYri6CkkVVf8biC9fSAhjBDAN7e8WpEdgVEzqLqWtFQ
 djVyQvlm5ASFd5c4huB+VTBA5S2gXQhfMPx5QzpaeAhcb8ExikOoW+nVoBhVD1fHczWi
 DBvXc3mRDAxuNnK7uDXN4sWqCBLMspNFfUojP19YBmJa1ZIF/l7t2eyWgwRvETmLR8dI
 dzrbEgyif+f2hZ/Dmk8AdrrQ1l3wYrf24NWeZJ+PcIonNYUNHDnM8v23zVBhelxm5jTv
 4VOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723615554; x=1724220354;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nQkMJkL9vL2igVIu7c4khKnTRZrEXKbAcPuAdwKii3Y=;
 b=FuI9RKfPb9fpwkLyBW8XZPM6M5/Db+vIaKbuqFOXmtqlCC2klq9YrmM53j9VvDF+Kp
 XCtK9M9Y1GdmtHOvKVC+8LQpYL9e2lDF3j3uQlE8ZbdENKeUWWQW2kG2tmX1qHJcFxsP
 s6VNZN15a8bXDTvgA4eueSynoxX977siquhx72KUlkE3VQMhxFhfnMwBHShbUmUceO/o
 XLlRCiiH03Fcxb//0xVR7/E49UkoIIyqX04clIoceAOTRhjc2Ok0+a2fwHje1FzOgZjF
 uUTKJhdAbleMIfnojavTgrxblKsjOp8d/J7RVAQ3jaQsBO4oRTm1xYGtCQ6hb5zzR5BH
 VP1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGjhSoIryy0KAuvYTRJWgWmVcs34Y+9pBIM+dtkYyLN72aXJ/ig2iwlDJZh/NKq/UylNW/QfEDWKO2Qkvwrw+iUbpuYeiTL/7XyALTDkbOxRyVSh22WmvuMuXOymEed9i5GWrr80ZacCnKEC5/Q0RKAg==
X-Gm-Message-State: AOJu0YyDzxiIs65cJ1ZA8D0m27u32QEWX6Xymzex0KQcxFKOc+8Tcu/J
 BnnYi0NyJB5SW7t18J0282OT3YQviKH2oq7eP3AwlgKKcCTL5NQF
X-Google-Smtp-Source: AGHT+IHZYl6JElZIGXPo8z9Y26JBm80QMKtE42nqYrE66+zStj03nZGHXrXLbO7RM17UAL7xmLDnBw==
X-Received: by 2002:a05:6358:5292:b0:1b1:a899:95fe with SMTP id
 e5c5f4694b2df-1b1aab56d19mr182206955d.8.1723615554128; 
 Tue, 13 Aug 2024 23:05:54 -0700 (PDT)
Received: from localhost ([1.145.94.19]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e58aa1d2sm6630840b3a.73.2024.08.13.23.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 23:05:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Aug 2024 16:05:34 +1000
Message-Id: <D3FEPPLH78YW.3BYA9B4HYGN1U@gmail.com>
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
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
X-Mailer: aerc 0.18.2
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
 <20240813202329.1237572-17-alex.bennee@linaro.org>
 <20240813164631-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240813164631-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc31.google.com
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

On Wed Aug 14, 2024 at 6:48 AM AEST, Michael S. Tsirkin wrote:
> On Tue, Aug 13, 2024 at 09:23:24PM +0100, Alex Benn=C3=A9e wrote:
> > From: Nicholas Piggin <npiggin@gmail.com>
> >=20
> > The regular qemu_bh_schedule() calls result in non-deterministic
> > execution of the bh in record-replay mode, which causes replay failure.
> >=20
> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > Message-Id: <20240813050638.446172-9-npiggin@gmail.com>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >  hw/net/virtio-net.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 08aa0b65e3..10ebaae5e2 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -40,6 +40,7 @@
> >  #include "migration/misc.h"
> >  #include "standard-headers/linux/ethtool.h"
> >  #include "sysemu/sysemu.h"
> > +#include "sysemu/replay.h"
> >  #include "trace.h"
> >  #include "monitor/qdev.h"
> >  #include "monitor/monitor.h"
> > @@ -417,7 +418,7 @@ static void virtio_net_set_status(struct VirtIODevi=
ce *vdev, uint8_t status)
> >                  timer_mod(q->tx_timer,
> >                                 qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +=
 n->tx_timeout);
> >              } else {
> > -                qemu_bh_schedule(q->tx_bh);
> > +                replay_bh_schedule_event(q->tx_bh);
> >              }
> >          } else {
> >              if (q->tx_timer) {
> > @@ -2672,7 +2673,7 @@ static void virtio_net_tx_complete(NetClientState=
 *nc, ssize_t len)
> >           */
> >          virtio_queue_set_notification(q->tx_vq, 0);
> >          if (q->tx_bh) {
> > -            qemu_bh_schedule(q->tx_bh);
> > +            replay_bh_schedule_event(q->tx_bh);
> >          } else {
> >              timer_mod(q->tx_timer,
> >                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_ti=
meout);
> > @@ -2838,7 +2839,7 @@ static void virtio_net_handle_tx_bh(VirtIODevice =
*vdev, VirtQueue *vq)
> >          return;
> >      }
> >      virtio_queue_set_notification(vq, 0);
> > -    qemu_bh_schedule(q->tx_bh);
> > +    replay_bh_schedule_event(q->tx_bh);
> >  }
> > =20
> >  static void virtio_net_tx_timer(void *opaque)
> > @@ -2921,7 +2922,7 @@ static void virtio_net_tx_bh(void *opaque)
> >      /* If we flush a full burst of packets, assume there are
> >       * more coming and immediately reschedule */
> >      if (ret >=3D n->tx_burst) {
> > -        qemu_bh_schedule(q->tx_bh);
> > +        replay_bh_schedule_event(q->tx_bh);
> >          q->tx_waiting =3D 1;
> >          return;
> >      }
> > @@ -2935,7 +2936,7 @@ static void virtio_net_tx_bh(void *opaque)
> >          return;
> >      } else if (ret > 0) {
> >          virtio_queue_set_notification(q->tx_vq, 0);
> > -        qemu_bh_schedule(q->tx_bh);
> > +        replay_bh_schedule_event(q->tx_bh);
> >          q->tx_waiting =3D 1;
> >      }
> >  }
> > --=20
> > 2.39.2
>
>
> Is this really the only way to fix this? I do not think
> virtio has any business knowing about replay.
> What does this API do, even? BH but not broken with replay?
> Do we ever want replay broken? Why not fix qemu_bh_schedule?
> And when we add another feature which we do not want to break
> will we do foo_bar_replay_bh_schedule_event or what?

I agree with you. We need to do this (a couple of other hw
subsystems already do and likely some are still broken vs
replay and would need to be converted), but I think it's
mostly a case of bad naming. You're right the caller should
not know about replay at all, what it should be is whether
the event is for the target machine or the host harness,
same as timers are VIRTUAL / HOST.

So I think we just need to make a qemu_bh_schedule_<type>,
or qemu_bh_scheudle_event(... QEMU_EVENT_VIRTUAL/HOST/etc).
I had started on a conversion once but not completed it.
I could resurrect if there is agreement on the API?

Thanks,
Nick


