Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05691CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8y37-0000cU-7N; Wed, 15 Oct 2025 05:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1v8y35-0000cL-7J
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1v8y2y-00032m-Cd
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760521424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ItUx4XDJnOGSq1SZwde42TUR9IsEzMHG61dNrtb/+wE=;
 b=KVgfBg6N3aV8Q9gdpaPCW8INDHC+55F7pbRC75aj1Z5uZaBusG+/r+oJ+UQ/fVWlxsU6hz
 KJNSR0TFGfBIHOl7G5tHVC++JXKSwuvfd8v0UCkKFQcJ/XnP6sApSIEMxxvIItC/ojDeNL
 1Gp4eIwYr1qlR0zrgDI52J2iUf9alf4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-dAdlkQINMDekIw09U588bw-1; Wed, 15 Oct 2025 05:43:42 -0400
X-MC-Unique: dAdlkQINMDekIw09U588bw-1
X-Mimecast-MFC-AGG-ID: dAdlkQINMDekIw09U588bw_1760521422
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3307af9b595so9637059a91.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 02:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760521422; x=1761126222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ItUx4XDJnOGSq1SZwde42TUR9IsEzMHG61dNrtb/+wE=;
 b=Vyk+/ikaI1RUD7T2Vhdul5rZuThFl6XlL2qWcOD9t7AMZabAUUNaLm9S9RuznSnM0f
 pC0GReDfQAEi6WoBARmc7oopP+KppiHPHEKkm6mCcYQTwTniCwJwXjje0XWbxO91FA5j
 7deDqH3/GFm8B6j/0dB9udCjAEhzFwLjIoF6oBDtI4QXaiBrUqQGCIHd8pdi6lln8u71
 cir1D6dLDF8KHa1gVC2IWIXPBSOnpvoHf0LKQqbRCQX0fC5GUPXjTQRk3a5TercS9R1E
 UACZ2qFTLd9AjXgf+bbwZIR8QoWH3uvmzuo0ZP3tMer3lNWhx1MIb4R5WK10IoNzXYut
 gGIA==
X-Gm-Message-State: AOJu0Yz8c98AcRoUADEpCRf9ybiOdcBlUWKoh7bNguVHNGo8hOIYN/DO
 r9X1aA88WlH8mRCSsY9Y3jLO+fNb8ecEb3HNgw4gRQND9wbueogJx/4lw69unaLbcM9rrh5Tl8+
 0JvkH7Rf6RnAM40X9lJWHt+CTsHO1Z6vDt/0froYGHkfY6kOogU1C4+0mJUuLywNgJKj+jdED4b
 LhwCpGLGuraqEILIyMnbj+vlNfDvST9Vw=
X-Gm-Gg: ASbGncsXPStEk9yhyWQcXQvUX+cg/FZp61+rRPgVeOUwIP+I1xU9I5/+FUer2oZEca0
 WQ/esGJhP653XHbuzJHT0hC4OUR8rP7K88Tm5a3/2yzUNiwl+6CaNoMWrTwtTV+i7CZrecQYdzN
 KFASGwC0R7fpDPzU34oytid6p44nJypLnlQZh7HF5pxj0Lll/avC3Y
X-Received: by 2002:a17:90b:1806:b0:32b:bac7:5a41 with SMTP id
 98e67ed59e1d1-33b513eabc3mr38522425a91.37.1760521421599; 
 Wed, 15 Oct 2025 02:43:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0/9//78/nLCb5HOVfzvY+o9ScSIsqrYDx3QLhiBmg6wBfpRBue25Xck/ge1qE+hjJUE2T3Y9fxL+jUY25blk=
X-Received: by 2002:a17:90b:1806:b0:32b:bac7:5a41 with SMTP id
 98e67ed59e1d1-33b513eabc3mr38522396a91.37.1760521421162; Wed, 15 Oct 2025
 02:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20251015092851.2850617-1-marcandre.lureau@redhat.com>
 <aO9qTkR8xik0iYVE@redhat.com>
In-Reply-To: <aO9qTkR8xik0iYVE@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 15 Oct 2025 13:43:29 +0400
X-Gm-Features: AS18NWAV-5SFF77snA-51g1SRYj8ag8lAJ9kQcYEcKv3WlQmOCh43ZxeAak5Pik
Message-ID: <CAMxuvax6A-2C7CsB_9LPDPod7U0Zqi7geUusiU=hz5yBcKAZ5g@mail.gmail.com>
Subject: Re: [PATCH v2] RFC: audio: deprecate HMP audio commands
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 "reviewer:Incompatible changes" <devel@lists.libvirt.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000eda1d806412f5539"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000eda1d806412f5539
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel

On Wed, Oct 15, 2025 at 1:33=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Wed, Oct 15, 2025 at 01:28:51PM +0400, marcandre.lureau@redhat.com
> wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > The command is niche and better served by the host audio system.
> > There is no QMP equivalent, fortunately. You can capture the audio
> > stream via remote desktop protocols too (dbus, vnc, spice).
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  docs/about/deprecated.rst | 20 ++++++++++++++++++++
> >  meson.build               |  4 ++++
> >  audio/audio-hmp-cmds.c    |  7 +++++++
> >  audio/meson.build         |  5 +++--
> >  hmp-commands-info.hx      |  2 ++
> >  hmp-commands.hx           |  2 ++
> >  6 files changed, 38 insertions(+), 2 deletions(-)
>
> Please remove the build system changes, as that is not something that
> is done with deprecation.
>
>
The reason I'd like to have those build system changes is to be able to
build a version of QEMU without those commands. Furthermore, we can already
clearly isolate the parts to be removed.

With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000eda1d806412f5539
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Daniel</div><br><div class=3D"gmail_qu=
ote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oc=
t 15, 2025 at 1:33=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto=
:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On Wed, Oct 15, 2025 at 01:28:51PM=
 +0400, <a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">ma=
rcandre.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; The command is niche and better served by the host audio system.<br>
&gt; There is no QMP equivalent, fortunately. You can capture the audio<br>
&gt; stream via remote desktop protocols too (dbus, vnc, spice).<br>
&gt; <br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; ---<br>
&gt;=C2=A0 docs/about/deprecated.rst | 20 ++++++++++++++++++++<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 4 ++++<br>
&gt;=C2=A0 audio/audio-hmp-cmds.c=C2=A0 =C2=A0 |=C2=A0 7 +++++++<br>
&gt;=C2=A0 audio/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +++=
--<br>
&gt;=C2=A0 hmp-commands-info.hx=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
&gt;=C2=A0 hmp-commands.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
2 ++<br>
&gt;=C2=A0 6 files changed, 38 insertions(+), 2 deletions(-)<br>
<br>
Please remove the build system changes, as that is not something that<br>
is done with deprecation.<br>
<br></blockquote><div><br></div><div>The reason I&#39;d like to have those =
build system changes is to be able to build a version of QEMU without those=
 commands. Furthermore, we can already clearly isolate the parts to be remo=
ved.=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div>

--000000000000eda1d806412f5539--


