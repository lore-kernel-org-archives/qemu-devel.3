Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2BBC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRYs-0006av-DN; Thu, 15 May 2025 01:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uFRYq-0006ab-4A
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:55:16 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uFRYg-0001LM-DX
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:55:08 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b239763eeddso340071a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747288504; x=1747893304; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Bi3+gfxN1cvGcai+VyiRjyCq02Xonm6DTcPgs7EuXJ0=;
 b=kTT8O3V0rlwCyaw+4FqmW5qnfdhRY22nvLm28Zo38KWFYE5VA4NpZZmvr217mKI5Ld
 SMnhP6JzGmhbktWUluxYVdO/jCbS3uiA5o7H2YO96hn59ffdY1MbnAEbUWUtesRbRWt2
 giBKmuSlywyFeg11cp6inM5pfy5IPDhH19u/DoIZBobqZumovrbNyHNZ5lEEE818lgag
 G/TYSCc3far4wD6idhkeAeAR4iC7EHHborwcMwet14KAoD8AEOSGPsO/90gQbYyD1+9t
 SCMz4GwyRrYTZk1QdxbdFx5VGPgVEyJBD5zSA/uafRaswte5q88fTAH6h8JOKETVjmov
 QDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747288504; x=1747893304;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bi3+gfxN1cvGcai+VyiRjyCq02Xonm6DTcPgs7EuXJ0=;
 b=mKAVjSWoEgko1kgd20KyptC4x2ZH/ixVkLWTjEj5KVLfLTJk4H4HTU13uPicyTfIBq
 k0kXsMYTWEwevyQ5knDe434AIuhKq+aMQ33qNgv0r83M3agipbCYSGzGAPK+lP18+ah9
 SL0ZxCQaWwtyn/fMLkVqOvOHH9q+9keiPA2qQr1zkQxGEurYMC/icRLhC5kwNkTEApaP
 Bq6EVQsFvLVFLDWAFob8/6y40/l6B246MSd2Efy2AwxXAlNHidGt+0xXJrXYmtIHEUoY
 wz2RzSOXguHrp+oAe53Ax352BxdS6nZ3ufKSY6VlQuxd9CYTeRJkt0KnA6Cgic2Yjhcx
 0XLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp20s5PH6EpIBjSIqw9L/jMVxdV4F/8g0RYiOQ0Fm86AIIOJ9yC8j5QI/0gHpY/KFdLL66jJvUqhWb@nongnu.org
X-Gm-Message-State: AOJu0Yz5iW8ZgwoCWwRhquJ5ab6jhqtacRgLkXlri6U9ts2fF2/Wm276
 RU/iOvW6FrIUgiLiNlOOdjb1WU/7UTWrSUKW3fHlWe/7zXTGOey0KH5r2Zlj
X-Gm-Gg: ASbGncv+0wXLF4AXXC5Q9ocybc6Y5jN/Z5SGrEI8TbZfzMQBZAp2boz8Pv8ahW+97E2
 7KTmghOpb+UCGOrHrUDSqRc/4LSipev7g19GMMtySF6Z9sPsjS4/lrYhMSku/YLA2BuAUskJeoi
 qiSY6Wzl3GlCRA5WT9quLWAPmaYgNvqXJv6E7N/aAZ7ajMpptUYn+TuaSB3ecvz4F/ErDb8Q5DJ
 /ZiqmtnOyhRzF1ViSfRXsKqiB52v8OA2icgoBt85gUU058TFJOoVNBlwyV7oZ5raLG2v6slXhcl
 veq9HlLq3O60KfxVpbO8fjgFQJ7Papg4bv5H51mnOLq0r1G+ftBfGZ19QA8ugB4=
X-Google-Smtp-Source: AGHT+IFs+tTb7+vHGM4g5il82GqWfhER7eI9NNvRDpimOX4dal/K7LbRYXux432d9kEOygghx47BsQ==
X-Received: by 2002:a17:90a:d88c:b0:2ee:af31:a7bd with SMTP id
 98e67ed59e1d1-30e5156789emr1862321a91.5.1747288504149; 
 Wed, 14 May 2025 22:55:04 -0700 (PDT)
Received: from [10.239.152.184] ([134.134.139.75])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e371d626esm2415577a91.44.2025.05.14.22.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 22:55:03 -0700 (PDT)
Message-ID: <39f140999474ba4798d8015c704f33dc5555cbc4.camel@gmail.com>
Subject: Re: [PATCH 1/9] ui/gtk: Document scale and coordinate handling
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau
 <marcandre.lureau@redhat.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau
 <marcandre.lureau@gmail.com>
Date: Thu, 15 May 2025 13:55:00 +0800
In-Reply-To: <a1bfa963-e4e2-f869-92e2-12312ad5dc89@eik.bme.hu>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
 <20250511073337.876650-2-weifeng.liu.z@gmail.com>
 <hyeijrn3pxl5r5ij2zryiaar5xcqpj7oigpzwgdl3bl5wslddu@fdfgzn27uy52>
 <ce6e4a42353118fe41e59f2e6ef79d6df959692b.camel@gmail.com>
 <a1bfa963-e4e2-f869-92e2-12312ad5dc89@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pg1-x52c.google.com
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

On Wed, 2025-05-14 at 13:50 +0200, BALATON Zoltan wrote:
> On Wed, 14 May 2025, Weifeng Liu wrote:
> > Hi Gerd,
> > On Mon, 2025-05-12 at 13:46 +0200, Gerd Hoffmann wrote:
> > > On Sun, May 11, 2025 at 03:33:11PM +0800, Weifeng Liu wrote:
> > > > The existence of multiple scaling factors forces us to deal
> > > > with
> > > > various
> > > > coordinate systems and this would be confusing. It would be
> > > > beneficial
> > > > to define the concepts clearly and use consistent
> > > > representation
> > > > for
> > > > variables in different coordinates.
> > > >=20
> > > > Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
> > > > ---
> > > > =C2=A0ui/gtk.c | 65
> > > > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > =C2=A01 file changed, 65 insertions(+)
> > > >=20
> > > > diff --git a/ui/gtk.c b/ui/gtk.c
> > > > index 982037b2c0..9f3171abc5 100644
> > > > --- a/ui/gtk.c
> > > > +++ b/ui/gtk.c
> > > > @@ -800,6 +800,71 @@ void
> > > > gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget
> > > > *widget)
> > > > =C2=A0#endif
> > > > =C2=A0}
> > > > =C2=A0
> > > > +/**
> > > > + * DOC: Coordinate handling.
> > > > + *
> > > > + * We are coping with sizes and positions in various
> > > > coordinates
> > > > and the
> > > > + * handling of these coordinates is somewhat confusing. It
> > > > would
> > > > benefit us
> > > > + * all if we define these coordinates explicitly and clearly.
> > > > Besides, it's
> > > > + * also helpful to follow the same naming convention for
> > > > variables
> > > > + * representing values in different coordinates.
> > > > + *
> > > > + * I. Definitions
> > > > + *
> > > > + * - (guest) buffer coordinate: this is the coordinates that
> > > > the
> > > > guest will
> > > > + *=C2=A0=C2=A0 see. The x/y offsets and width/height specified in
> > > > commands
> > > > sent by
> > > > + *=C2=A0=C2=A0 guest is basically in buffer coordinate.
> > > > + *
> > > > + * - (host) pixel coordinate: this is the coordinate in pixel
> > > > level on the
> > > > + *=C2=A0=C2=A0 host destop. A window/widget of width 300 in pixel
> > > > coordinate
> > > > means it
> > > > + *=C2=A0=C2=A0 occupies 300 pixels horizontally.
> > > > + *
> > > > + * - (host) logical window coordinate: the existence of global
> > > > scaling
> > > > + *=C2=A0=C2=A0 factor in desktop level makes this kind of coordina=
te
> > > > play a
> > > > role. It
> > > > + *=C2=A0=C2=A0 always holds that (logical window size) * (global s=
cale
> > > > factor) =3D
> > > > + *=C2=A0=C2=A0 (pixel size).
> > > > + *
> > > > + * - global scale factor: this is specified in desktop level
> > > > and
> > > > is
> > > > + *=C2=A0=C2=A0 typically invariant during the life cycle of the pr=
ocess.
> > > > Users with
> > > > + *=C2=A0=C2=A0 high-DPI monitors might set this scale, for example=
, to
> > > > 2, in
> > > > order to
> > > > + *=C2=A0=C2=A0 make the UI look larger.
> > > > + *
> > > > + * - zooming scale: this can be freely controlled by the QEMU
> > > > user
> > > > to zoom
> > > > + *=C2=A0=C2=A0 in/out the guest content.
> > > > + *
> > > > + * II. Representation
> > > > + *
> > > > + * We'd like to use consistent representation for variables in
> > > > different
> > > > + * coordinates:
> > > > + * - buffer coordinate: prefix fb
> > > > + * - pixel coordinate: prefix p
> > > > + * - logical window coordinate: prefix w
> > > > + *
> > > > + * For scales:
> > > > + * - global scale factor: prefix gs
> > > > + * - zooming scale: prefix scale/s
> > > > + *
> > > > + * Example: fbw, pw, ww for width in different coordinates
> > > > + *
> > > > + * III. Equation
> > > > + *
> > > > + * - fbw * gs * scale_x =3D pw
> > >=20
> > > Well.=C2=A0 That is one possible approach (and this is what qemu is
> > > doing
> > > today, for historical reasons, because most code dates back to
> > > pre
> > > high-dpi days).
> > >=20
> > > A possible alternative would be to go for fbw * scale_x =3D pw,
> > > i.e.
> > > let
> > > the guest run in pixel coordinates instead of window
> > > coordinates.=C2=A0
> > > The
> > > guest would do the high-dpi scaling then.=C2=A0 That requires setting
> > > physical display width and height in ui_info, so the guest can
> > > figure
> > > what the display resolution is and go into high-dpi mode if
> > > needed.
>=20
> Does that assume the guest knows about hidpi and has its own scale
> factor?=20
> What if I want to run an old guest that cannot do hidpi on a modern
> host.=20
> Can I still specify a scale factor to scale it up to usable size?
> That's a=20
> use case I care about which might be unusual but does exist.
>=20

Yeah, that use case will be supported by introducing a non-high-dpi
compatibility mode as suggested by Gerd. In this mode, the guest images
will be scaled by global desktop scale factor.

Best regards,
Weifeng

> Regards,
> BALATON Zoltan
>=20
> >=20
> > Thanks for your suggestion. Sounds like code could be simplified
> > and be
> > much easier to understand in this way. I will investigate it on top
> > of
> > this change.
> >=20
> > Best regards,
> > Weifeng
> >=20
> > > We probably also need a non-high-dpi compatibility mode for old
> > > guests.
> > > That mode would start with "zooming scale =3D global scale" instead
> > > of
> > > "zooming scale =3D 1", and the dpi calculation would have to
> > > consider
> > > that too.
> > >=20
> > > (maybe best done on top of this nice cleanup).
> > >=20
> > > take care,
> > > =C2=A0 Gerd
> >=20

