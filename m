Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D7FD2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 09:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi7qS-0005ga-0e; Tue, 20 Jan 2026 04:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vi7qP-0005fD-RW
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:16:13 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vi7qO-0003Ay-1f
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:16:13 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-655ae329d6bso7414785a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 01:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768900570; x=1769505370; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xhn/QiNiMTgWfxIv1Fhs6HzzGSSJz4xR89rNsvOz/RE=;
 b=clOpcE7sLyr8pjPrzQZ5f2sZaBEIp3rV6xtKEdSFK35tx7eFBoQLT4nEpdHwuJQzWd
 0w1rOLWh90XQxybDzWBF4tJXNHI1a+M4EmF9CP6q1JDPlMSB3yThouB2DiBXRZKGcfGZ
 GF66obmittVQoIwvKxCktYY/lctQBn+DILlkuBL6USDzxOO87JHZvdqoVrPMvVcpI2nG
 zf9s9+fsM9CzAMRHJch40AImeHzwvyMlLDAu+OjSzwMYedAjL7oAILhChcGJfQFtp7da
 s4sfmTrW/05Ql6asbsfbO4VLpTzPEhlTC2WX28yVKyDRSWQDjRo1eUTfUSZF1lqsCNNN
 wJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768900570; x=1769505370;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xhn/QiNiMTgWfxIv1Fhs6HzzGSSJz4xR89rNsvOz/RE=;
 b=oHFaVjEr0IMVhUqmBPRr2jtnddcH3aCyJZsBtjtgAfwtPvejpYGrbryma0m6TzzT4c
 urBOC4eDMYNAa6TCDIFl9QAb3WEj275g3r6lpvC5jEPGNCbeV4bgb/qAOUv1umu+Or4n
 B6Na+BHztDTXSrZ+LZYYXzKeWIJRiiHUcbvopbhQ0T1iOm3Bvd8ooBvLtdbZhbmnixIW
 oY4fjB8PAjAN6sUeTy10gVeMwQnLRy0n5SCzjccZSZgaZobOhUsrYYKICs0dfTBifD0Z
 o+UyQAIvEfHPnvif5PENDWQniKqBpkyaP9ulzFo79AkAr367vx0xmOHB+orQ2BVu7LT7
 vl6g==
X-Gm-Message-State: AOJu0Yw6pjPBvfFD8Ypf9fcr7Fz2ImpTX9Tn9og0+haRi0qXr89oofDh
 JVN/B+1OOU2SmRiJTeX+hkwPOTzRS5GPiRYPKra5zJi/l8r7CeKXLbjY
X-Gm-Gg: AY/fxX7ls+kz69n1OU+Q0EZA1t5NoHnh5kj1TKnUBXkwNfSh2xg+GQTubworGGPWDBY
 ECVKVrZFF/hHOdmvmIZrwoo2rwR+6YzWXDtDojJ0iLx+OuHe8PJ36uHv+YuEvK3/7iZf/g4WwVh
 NrTGYlrvPhI+12/NzL6wf64GM3h+z/12XiN2BapOmo3te5nYxha1wEZpeqBkggfW26rlq0yvFvU
 aF3C3JjW4vVsVfEhqbHOOGblsk+FrggucIoTow3JfOmvfwX8ytis6QBWDJgXDvcRjB0+Ma76tSk
 GfCBzZ0siV+/QBRabg8tjv2w4mVKgpJ7sPdnab6iNQ7IT7jJmX8gJ8iz38d8gAyp3znUbZmJ7J0
 hqEYN5OFEESCXPUGLgvbKwCbbCiEQOl4eYgT2VeVoa6zWvZSk/wSIH0SFLYyCC2Y5AIr6EYkb0V
 EiruvQ8U+KnqZH5QD0UtXDvqlQjv87WuOPDJbOSmHZAlySqR5qCUVNm4R+
X-Received: by 2002:a17:907:9622:b0:b86:f988:a0c3 with SMTP id
 a640c23a62f3a-b8796b310bemr1193799466b.42.1768900569867; 
 Tue, 20 Jan 2026 01:16:09 -0800 (PST)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168c6dsm1345361066b.19.2026.01.20.01.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 01:16:09 -0800 (PST)
Message-ID: <ef45a24d7052d685f4951aaa6d37ce55b0746698.camel@gmail.com>
Subject: Re: [PATCH v6 08/12] virtio-serial-bus: add terminal resize messages
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent
 Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, Markus Armbruster
 <armbru@redhat.com>,  Eric Blake <eblake@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum	 <marcel.apfelbaum@gmail.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu	 <zhao1.liu@intel.com>, Maximilian
 Immanuel Brandtner <maxbr@linux.ibm.com>,  Szymon Lukasz <noh4hss@gmail.com>
Date: Tue, 20 Jan 2026 10:16:08 +0100
In-Reply-To: <aW9AEjN3TDov1jLj@redhat.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <20260119-console-resize-v6-8-33a7b0330a7a@gmail.com>
 <aW37oZ1X_7O6AXvo@redhat.com>
 <20260119044148-mutt-send-email-mst@kernel.org>
 <aW9AEjN3TDov1jLj@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2026-01-20 at 08:43 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Jan 19, 2026 at 04:43:21AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Jan 19, 2026 at 09:38:41AM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > > On Mon, Jan 19, 2026 at 04:27:51AM +0100, Filip Hejsek wrote:
> > > > Implement the part of the virtio spec that allows to notify the vir=
tio
> > > > driver about terminal resizes. The virtio spec contains two methods=
 to
> > > > achieve that:
> > > >=20
> > > > For legacy drivers, we have only one port and we put the terminal s=
ize
> > > > in the config space and inject the config changed interrupt.
> > > >=20
> > > > For multiport devices, we use the control virtqueue to send a packe=
t
> > > > containing the terminal size. Note that old versions of the Linux k=
ernel
> > > > used an incorrect order for the fields (rows then cols instead of c=
ols
> > > > then rows), until it was fixed by commit 5326ab737a47278dbd16ed3ee7=
380b26c7056ddd.
> > > >=20
> > > > As a result, when using a Linux kernel older than 6.15, the number =
of rows
> > > > and columns will be swapped.
> > > >=20
> > > > Based on a patch originally written by Szymon Lukasz <noh4hss@gmail=
.com>,
> > > > but partially rewritten to fix various corner cases.
> > > >=20
> > > > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > > > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > > > ---
> > > >  hw/char/trace-events              |  1 +
> > > >  hw/char/virtio-serial-bus.c       | 76 +++++++++++++++++++++++++++=
++++++++++--
> > > >  hw/core/machine.c                 |  4 ++-
> > > >  include/hw/virtio/virtio-serial.h |  5 +++
> > > >  4 files changed, 83 insertions(+), 3 deletions(-)
> > > >=20
> > >=20
> > > > @@ -1158,6 +1228,8 @@ static const Property virtio_serial_propertie=
s[] =3D {
> > > >                                                    31),
> > > >      DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_featur=
es,
> > > >                        VIRTIO_CONSOLE_F_EMERG_WRITE, true),
> > > > +    DEFINE_PROP_BIT64("console-size", VirtIOSerial, host_features,
> > > > +                      VIRTIO_CONSOLE_F_SIZE, true),
> > > >  };
> > >=20
> > > Given the horrible mess with the kernel intentionally changing its
> > > behaviour after 15 years, I don't think we can we set this to be
> > > enabled by default.
> > >=20
> > > The recent behaviour change is never going to be backported to enough
> > > stable distros that we can rely on the new behaviour, and thanks to
> > > the change we can't rely on the old behaviour either. We're doomed no
> > > matter what ordernig we use.
> > >=20
> > > Thus, IMHO, this has to stay set to false indefinitely.
> >=20
> > Not sure. But what we can do is add another flag to detect new kernels.
> > I'll try to think of a good name but suggestions are welcome.
>=20
> How can we detect the kernel ? There's no feature flag that can be
> negotiated or detected to report the changed kernel behaviour
> AFAICS. We have no visibility of kernel version, and even if we did,
> the possibility of backports would make that unreliable too. The
> inability to auto-detect anything is what makes the kernel behaviour
> change so awful.
>=20
> We can add a nother qemu flag "console-size-inverted" to flip QEMU
> between the 2 behaviours, but that still won't let us be able to
> enable 'console-size' by default without guaranteed regressions.
> The 'console-size-inverted' flag would merely flip the breakage
> between different groups of guest OS.

We could add a new virtio feature flag, and by default only enable
resizing when the guest supports this new flag. Kernels that support
the flag would work by default, and kernels that have the correct order
but don't yet support the flag would require manually enabling the
feature.

In any case, we will probably need to add some documentation for the
property. I'm trying to find a good place for it, but it seems that the
virtconsole and virtio-serial-bus devices are not actually documented
anywhere at all. They should probably be documented in the man page,
right?

>=20
> > > >  static void virtio_serial_class_init(ObjectClass *klass, const voi=
d *data)
> > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > index 6411e68856..50554b8900 100644
> > > > --- a/hw/core/machine.c
> > > > +++ b/hw/core/machine.c
> > > > @@ -38,7 +38,9 @@
> > > >  #include "hw/acpi/generic_event_device.h"
> > > >  #include "qemu/audio.h"
> > > > =20
> > > > -GlobalProperty hw_compat_10_2[] =3D {};
> > > > +GlobalProperty hw_compat_10_2[] =3D {
> > > > +    { "virtio-serial-device", "console-size", "off" },
> > > > +};
> > > >  const size_t hw_compat_10_2_len =3D G_N_ELEMENTS(hw_compat_10_2);
> > > > =20
> > > >  GlobalProperty hw_compat_10_1[] =3D {
>=20
> With regards,
> Daniel

