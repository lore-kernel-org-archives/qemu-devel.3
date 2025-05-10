Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3F8C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 15:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDmbG-00058E-5z; Sat, 10 May 2025 11:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uDmbF-000585-9X
 for qemu-devel@nongnu.org; Sat, 10 May 2025 11:58:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uDmbD-0006fz-MT
 for qemu-devel@nongnu.org; Sat, 10 May 2025 11:58:53 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22fa414c565so21986725ad.2
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 08:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746892730; x=1747497530; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7w6u/K+jjAGvqxuoEObDTwiO8Ld7zXcOM3VbP7umGmA=;
 b=cTXXjxEn0Voh8PIUuvTEtNLDNoLwVqA6z8HGE1swLYbRZ/U3tQc+grt8yf6XOgd1WK
 r4L4C4fShl3Y3XRI2vgB18JGeR2Nw3HypgNKDQkthBGd3O/cIF1byKEWoLbD/s2Iw7A8
 vmftDEufwbMpoB2dNui/z3Iq/CCyj6YzOqzydCu0mHpgetx/wsWaelzyD4OayeodoouG
 J7mxu+QEysCundYBOGDqM8+nLpLEg8bRHJ123BZe4WJyBwvVodpE5bi74k1xXmhtcLSy
 PZqKc+TWvs4iGjoIAUI9fztbF89Pbz2y2eEMi7b7U3HhHO9tlB+a68L4YLeftVGZ0BUQ
 tl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746892730; x=1747497530;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7w6u/K+jjAGvqxuoEObDTwiO8Ld7zXcOM3VbP7umGmA=;
 b=eR21zbaQuB3+XnxDWrStH5TbrXtlaXoMOH1dS/gFyAYefLy8NlGo8O3JukYymWmjLe
 S7m0VamBJd2Juy3TTSLfrPNITaZ4IpnEs8mh2/eUyQTyWm+wbKsgtuuQMHHm0+C0ohZw
 zVrAbHctoG3bBgkA9VOBsp2Xs0zvq6mI2AFCOZ5vrnKB7wje5flQC52Kw5zSwClq8437
 FDq3yf+Lgn+bIlHw1H9tMYU2FbuFPvWbM79Qgg+kSPfMNPWrobardhjQYbtz7LgID3Oc
 PxLzXcKkOeAMejceln5fRPBzRojC5bXEI88PTvE0Asj0+sjZKXzjV5oEv2G5NqtB9yR9
 EsYw==
X-Gm-Message-State: AOJu0YyTC7UOjfj12NlmELsQXBm2N950t0sWmG3jboZIYKfr1fNYfWbh
 n6fw1ofESYpw+6BFTqJT+ZmRSVK3yH8Us6NODbkuuNyiKmnAuZ/t
X-Gm-Gg: ASbGnctU4sw9FnHi1km7Hmcrr7km6gdiG72MDLx61w3Sy5CJqC4BTrUpv6pmqe6aBwR
 lgF7FcbumgES9+OKTfGWQ4hXqgUPuUtTnraHLsWjOPY1NgdwUsSrjumXCal0IucOfLqu5UCmtX2
 jo2KpOJrnsfVCRIchaUqGO2FvQRknnVUOv+ZWQ1g/mWA/FVvfD7tSNXdSAHmW5+xjht/S7fAm8D
 TpSp0gPytFcg/jid9RNTFW8K/rsacppGDxsvb3G3jiJe0fjbwHUEpzA1pCu7oHAmKAhYRu+3MTI
 KTQuUTRkGtWe5jqyzrVFHWWTTi1mXQlzfZWZmyNo265/StXhKKYTKYfE/twIsihu
X-Google-Smtp-Source: AGHT+IFRAvOdAMCg+z6xRSunGjqNjPV8Cvypw++eo58yvyT+ICQdtUpBXpdGtd+5l/4gq42zpH4cSQ==
X-Received: by 2002:a17:902:da8e:b0:22e:7971:4d48 with SMTP id
 d9443c01a7336-22fc918bc44mr108302955ad.45.1746892730020; 
 Sat, 10 May 2025 08:58:50 -0700 (PDT)
Received: from [192.168.31.160] ([117.143.179.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc829eb97sm34276555ad.215.2025.05.10.08.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 08:58:49 -0700 (PDT)
Message-ID: <a3e34458ddc2754390eaed7a8788d910450c5459.camel@gmail.com>
Subject: Re: [PATCH] ui/gtk: Properly apply x/y scale when rendering GL area
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, hikalium <hikalium@hikalium.com>, Alexander
 Orzechowski <orzechowski.alexander@gmail.com>, Gerd Hoffmann
 <kraxel@redhat.com>
Date: Sat, 10 May 2025 23:58:26 +0800
In-Reply-To: <CAJ+F1C+jPtvsY0yy9rZJLRLME9cC=p1bRGrXA3G1XQfJUmDXrg@mail.gmail.com>
References: <20250419094959.224954-1-weifeng.liu.z@gmail.com>
 <CAJ+F1C+jPtvsY0yy9rZJLRLME9cC=p1bRGrXA3G1XQfJUmDXrg@mail.gmail.com>
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

Hi Marc-Andr=C3=A9,

I am WIP on a patch set including a successor of this one as well as
other fixes, doc and refactoring regarding scale handling. Hopefully
the patch set would make scale handling into good shape. I will send
the patch set out ASAP.

Best regards,
Weifeng

On Mon, 2025-04-28 at 15:23 +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Sat, Apr 19, 2025 at 1:51=E2=80=AFPM Weifeng Liu <weifeng.liu.z@gmail.=
com> wrote:
> >=20
> > On startup, scale_x and scale_y were set to 1 that didn't reflect the
> > real situation of the scan-out, resulting in incorrect cursor
> > coordinates to be sent when moving the mouse pointer. Simply updating
> > the scales before rendering the image fixes this issue.
> >=20
> > Cc: hikalium <hikalium@hikalium.com>
> > Cc: Alexander Orzechowski <orzechowski.alexander@gmail.com>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
>=20
>=20
> Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> (Hopefully someone has enough motivation to actually understand this
> change better - otherwise I'll simply queue it?)
>=20
> > ---
> >  ui/gtk-gl-area.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> > index 2c9a0db425..01235f876a 100644
> > --- a/ui/gtk-gl-area.c
> > +++ b/ui/gtk-gl-area.c
> > @@ -42,6 +42,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
> >  #ifdef CONFIG_GBM
> >      QemuDmaBuf *dmabuf =3D vc->gfx.guest_fb.dmabuf;
> >  #endif
> > +    int fbw, fbh;
> >      int ww, wh, ws, y1, y2;
> >=20
> >      if (!vc->gfx.gls) {
> > @@ -53,6 +54,11 @@ void gd_gl_area_draw(VirtualConsole *vc)
> >      ww =3D gtk_widget_get_allocated_width(vc->gfx.drawing_area) * ws;
> >      wh =3D gtk_widget_get_allocated_height(vc->gfx.drawing_area) * ws;
> >=20
> > +    fbw =3D surface_width(vc->gfx.ds);
> > +    fbh =3D surface_height(vc->gfx.ds);
> > +    vc->gfx.scale_x =3D (double)ww / fbw / ws;
> > +    vc->gfx.scale_y =3D (double)wh / fbh / ws;
> > +
> >      if (vc->gfx.scanout_mode) {
> >          if (!vc->gfx.guest_fb.framebuffer) {
> >              return;
> > --
> > 2.49.0
> >=20
> >=20
>=20

