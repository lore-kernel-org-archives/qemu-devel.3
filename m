Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CDDC3ABC9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 02:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF2D3-0003XB-B9; Tue, 13 May 2025 22:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uF2D0-0003Wh-P0
 for qemu-devel@nongnu.org; Tue, 13 May 2025 22:51:02 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uF2Cy-0001lo-Ov
 for qemu-devel@nongnu.org; Tue, 13 May 2025 22:51:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22fbbf9c01bso52307295ad.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 19:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747191059; x=1747795859; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dLWEgJABiENSVVLSR6HV7vU5EjLKWYMzAoabF8kwAUE=;
 b=fALCuFQRUuFacdJuzVKMxV9FnmZaWVwCmR5ZXlYx6RJcvpFaQFloDMd80x+oPAXvr0
 XPlfd3C/D/ehxgGs9AJXdX5FCvwKRuSmtj9CgxWyuSAFpQ7WQpNYvMRdMUWG4BBzo3W0
 nzWUXo8WNXaSDWVRCoi9EWhUjEb4f8oJbpEcKsraaqBfN/lLhg6K+I9whoJrEX+KmmNQ
 /amI9ZtbJYEW/Rm7dXBi5QsRAe2/z+og7qKPPc7jLj/jAe2TYbCy6ovYvciOdsjrMU72
 LbCnf9JvElQKdOr7cfUeFkTHJRGabfxa8jDUUoP3a7zRL1IdnCl+1A2NhI2uB9Zbo+Bn
 7A8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747191059; x=1747795859;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dLWEgJABiENSVVLSR6HV7vU5EjLKWYMzAoabF8kwAUE=;
 b=tVmM188YuqgHedPccANzRKHIPVGuOlSjmwNkYuRudMLq9pGCJTnwe5CzGsn7Ag4c2L
 l6m+FAQdQg1EUQrcYWi3NbkzopgLKp4piwIFjW5bfpdRNs5Txnz0ts4k5URx0ehJVNAF
 SM38P0uLsgurhwJcQW0mkwyo5KOukZ0wPByvpKQJPW4X4CM2i5UZu75uMn9bVT72DzCG
 rNSlkYt4qSUV6BIiWMPczUvNhOv9t1BQyXwowdPTcE5/ODvVO7OPtAXU7nshS6VRAw2s
 9fDwUYIACI+uiJnuzw9NofGKi1s4+tKPX6RtE8/dC0uUpAJO7whfubW5QyTzN/6lg7Vu
 4DCA==
X-Gm-Message-State: AOJu0YxmjGS4p2Q92uHCuT1YR+2wl3+1U1OWxZkVuKvTmvHahaCqJa8I
 34cgHINm9poud//FTEGN/eyVzzxhvL+/RHgIkUgSFyxuFn3M8DXq
X-Gm-Gg: ASbGnctpzYeIFFkgfR9q3jTlnb6Zex2Sy8/Cj5xtKOKSVi0dFMMxnLlTihXuBKfnUUm
 Jq7AeCf1sm4c/RPdTjC9xWuaUwKqLMS5eeIkcc6eG2H+RDbRzBlWsjTb7tM+ljF1wICeAtxZZhc
 lBMO7Rti9vL55wyFfssaFPZyq7zolHaqKzyEdTJYPE3vSji0SPHb2Y29E/e4VixwaNyj65pmtLV
 oDAZKKVcTLwhDEgE0oH+EwfAYsfoPZEhyVFx0Hp9TBx8PUzvYfqIbyC1QynIj26HkWYkQlRkGnv
 /oQ0ecS2257NxTfSZldy2qCyO/qIgF5xXEuqGkvmFkCXcj1fVGIo59TWwAOeIk8=
X-Google-Smtp-Source: AGHT+IHj4acyvC6ctips+JtuUU7agPz9x78XHG67ExUTO6PzyyUZ6LLc8oK51q1+RrKbotTGQOLPRg==
X-Received: by 2002:a17:902:d2cf:b0:223:5e56:a1ce with SMTP id
 d9443c01a7336-23198148cf8mr27225275ad.32.1747191058839; 
 Tue, 13 May 2025 19:50:58 -0700 (PDT)
Received: from [10.239.152.184] ([134.134.139.75])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc828b3a0sm89319595ad.179.2025.05.13.19.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 19:50:58 -0700 (PDT)
Message-ID: <ce6e4a42353118fe41e59f2e6ef79d6df959692b.camel@gmail.com>
Subject: Re: [PATCH 1/9] ui/gtk: Document scale and coordinate handling
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau
 <marcandre.lureau@redhat.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau
 <marcandre.lureau@gmail.com>
Date: Wed, 14 May 2025 10:50:55 +0800
In-Reply-To: <hyeijrn3pxl5r5ij2zryiaar5xcqpj7oigpzwgdl3bl5wslddu@fdfgzn27uy52>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
 <20250511073337.876650-2-weifeng.liu.z@gmail.com>
 <hyeijrn3pxl5r5ij2zryiaar5xcqpj7oigpzwgdl3bl5wslddu@fdfgzn27uy52>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pl1-x635.google.com
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

Hi Gerd,

On Mon, 2025-05-12 at 13:46 +0200, Gerd Hoffmann wrote:
> On Sun, May 11, 2025 at 03:33:11PM +0800, Weifeng Liu wrote:
> > The existence of multiple scaling factors forces us to deal with
> > various
> > coordinate systems and this would be confusing. It would be
> > beneficial
> > to define the concepts clearly and use consistent representation
> > for
> > variables in different coordinates.
> >=20
> > Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
> > ---
> > =C2=A0ui/gtk.c | 65
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > =C2=A01 file changed, 65 insertions(+)
> >=20
> > diff --git a/ui/gtk.c b/ui/gtk.c
> > index 982037b2c0..9f3171abc5 100644
> > --- a/ui/gtk.c
> > +++ b/ui/gtk.c
> > @@ -800,6 +800,71 @@ void
> > gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget
> > *widget)
> > =C2=A0#endif
> > =C2=A0}
> > =C2=A0
> > +/**
> > + * DOC: Coordinate handling.
> > + *
> > + * We are coping with sizes and positions in various coordinates
> > and the
> > + * handling of these coordinates is somewhat confusing. It would
> > benefit us
> > + * all if we define these coordinates explicitly and clearly.
> > Besides, it's
> > + * also helpful to follow the same naming convention for variables
> > + * representing values in different coordinates.
> > + *
> > + * I. Definitions
> > + *
> > + * - (guest) buffer coordinate: this is the coordinates that the
> > guest will
> > + *=C2=A0=C2=A0 see. The x/y offsets and width/height specified in comm=
ands
> > sent by
> > + *=C2=A0=C2=A0 guest is basically in buffer coordinate.
> > + *
> > + * - (host) pixel coordinate: this is the coordinate in pixel
> > level on the
> > + *=C2=A0=C2=A0 host destop. A window/widget of width 300 in pixel coor=
dinate
> > means it
> > + *=C2=A0=C2=A0 occupies 300 pixels horizontally.
> > + *
> > + * - (host) logical window coordinate: the existence of global
> > scaling
> > + *=C2=A0=C2=A0 factor in desktop level makes this kind of coordinate p=
lay a
> > role. It
> > + *=C2=A0=C2=A0 always holds that (logical window size) * (global scale
> > factor) =3D
> > + *=C2=A0=C2=A0 (pixel size).
> > + *
> > + * - global scale factor: this is specified in desktop level and
> > is
> > + *=C2=A0=C2=A0 typically invariant during the life cycle of the proces=
s.
> > Users with
> > + *=C2=A0=C2=A0 high-DPI monitors might set this scale, for example, to=
 2, in
> > order to
> > + *=C2=A0=C2=A0 make the UI look larger.
> > + *
> > + * - zooming scale: this can be freely controlled by the QEMU user
> > to zoom
> > + *=C2=A0=C2=A0 in/out the guest content.
> > + *
> > + * II. Representation
> > + *
> > + * We'd like to use consistent representation for variables in
> > different
> > + * coordinates:
> > + * - buffer coordinate: prefix fb
> > + * - pixel coordinate: prefix p
> > + * - logical window coordinate: prefix w
> > + *
> > + * For scales:
> > + * - global scale factor: prefix gs
> > + * - zooming scale: prefix scale/s
> > + *
> > + * Example: fbw, pw, ww for width in different coordinates
> > + *
> > + * III. Equation
> > + *
> > + * - fbw * gs * scale_x =3D pw
>=20
> Well.=C2=A0 That is one possible approach (and this is what qemu is doing
> today, for historical reasons, because most code dates back to pre
> high-dpi days).
>=20
> A possible alternative would be to go for fbw * scale_x =3D pw, i.e.
> let
> the guest run in pixel coordinates instead of window coordinates.=C2=A0
> The
> guest would do the high-dpi scaling then.=C2=A0 That requires setting
> physical display width and height in ui_info, so the guest can figure
> what the display resolution is and go into high-dpi mode if needed.
>=20

Thanks for your suggestion. Sounds like code could be simplified and be
much easier to understand in this way. I will investigate it on top of
this change.

Best regards,
Weifeng

> We probably also need a non-high-dpi compatibility mode for old
> guests.
> That mode would start with "zooming scale =3D global scale" instead of
> "zooming scale =3D 1", and the dpi calculation would have to consider
> that too.
>=20
> (maybe best done on top of this nice cleanup).
>=20
> take care,
> =C2=A0 Gerd

