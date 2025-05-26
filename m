Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67193C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 10:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUg1-0002jh-CF; Mon, 26 May 2025 06:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uJUfw-0002jP-Of
 for qemu-devel@nongnu.org; Mon, 26 May 2025 06:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uJUft-0008Kg-Mi
 for qemu-devel@nongnu.org; Mon, 26 May 2025 06:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748253793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XfRqWFA/1d2njlvTb9omadUsmia429DgztI3OIEpGgs=;
 b=jChBKXrEsr8k3mzGaDrRtk2FklMVd7sU+cFLCf71FPKIjzX5SAZctNpT+U9/kvooJ6gUoy
 FeqkMDFUBnYVoCQ+rmOCQjRB67fWZf8yIZDIB5YcTAKOJiUVrworhAkCcY/aBnx0j6Hqnc
 zE/zvdh+U5f0VfpCKm1xAb8mwpGXVn8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-soRh2h5pMWeK6twgPNqaUw-1; Mon, 26 May 2025 06:03:11 -0400
X-MC-Unique: soRh2h5pMWeK6twgPNqaUw-1
X-Mimecast-MFC-AGG-ID: soRh2h5pMWeK6twgPNqaUw_1748253791
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c5c82c6d72so415943385a.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 03:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748253791; x=1748858591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XfRqWFA/1d2njlvTb9omadUsmia429DgztI3OIEpGgs=;
 b=taixduDxLIAwI0oD9rt4RaXW2NFwCd0EJdeHKI888ZKj/1cm4aqWtkrrGi9AE9q65U
 Q7kIqvB4GCcxR0GzEqvMrz0Njv4L0DBMHOwM1UGBME62wNd6gkw6fPe5wJZ+G1DMO/BX
 zLNH5aB+TPSBT0UwVagreXfZsrLUZT9A0DDSlfoV2GHC/5x5WN06ofqZBj5UFf/Yc2Mh
 daa2NjBf4GDVGEkIuboU93vOP10HHy2fvXXIOeI0b66t3Kg9n1quIWpSEowRtLyJSJPg
 v2Fgce3+Egrzi4nJR30MspClGFA5Yydng7bUj6/YG1Rds60rCkq29lhkrer5WU1Bxa4+
 ebgg==
X-Gm-Message-State: AOJu0YxXpReRumxs1EXsZMOTeKBip+whvudQ91vugDWvJBJWPOauOmsg
 2KJvzgIfpHLJ2JwyqHYTueuRJ1rvEeGStD2uXzWjXryLNwQgUmeVyiGuIJJDAxFCJ98R0SS3KYx
 dTJEsN/5FB8SeuGvchodSiwKZN3JDA/oAOnpGQljk+OUxpnWm9jFUPnzD7Y3GMEuyzduooH6t+e
 GioXksFT6lpzuX/aQXvwcvTxltNl9tI/1Ky+Cznc/R9Ywq
X-Gm-Gg: ASbGncvq5NEzjGWKQSsszJA4iNGloCM6V0Gw7g/3M7wtBVl/tfVz2SgZrsrjkVMpfqw
 62DAAk5C4cHtJ89xiPvQ3I7KwgMX1csfLd9i528I9BZVpdVK8RGPTA6HoUSGNKGu3YcDO0oO1YZ
 GKp5aYx95Cr74BhKLzRB7pm5BbdQ==
X-Received: by 2002:a05:6102:41aa:b0:4c1:71b6:6c with SMTP id
 ada2fe7eead31-4e42409f7damr5614309137.7.1748253779940; 
 Mon, 26 May 2025 03:02:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0Jp/OYKatOx62p0yBD+zKi+ZWF6QVlY6dhqURM+HeOpgKBcQ2I4S18YPEgjoBTSUHH/WusyPrnV/wxjpQuZ8=
X-Received: by 2002:a05:622a:429a:b0:494:af61:f9c3 with SMTP id
 d75a77b69052e-49f46651165mr132781281cf.21.1748253760041; Mon, 26 May 2025
 03:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250525132717.527392-1-marcandre.lureau@redhat.com>
 <20250525132717.527392-9-marcandre.lureau@redhat.com>
 <87cybvkhtt.fsf@pond.sub.org>
In-Reply-To: <87cybvkhtt.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 26 May 2025 12:02:28 +0200
X-Gm-Features: AX0GCFtb6cuOEwDB7r0LHZNdZcGc4ke41kQ9XNOtIRQCe5IeNcPEg2GnrpxnciQ
Message-ID: <CAMxuvawUQ0o1i7zgop7rQd-75CB69HpJaLstM8ZjrpgHZ0rT-g@mail.gmail.com>
Subject: Re: [PULL 8/9] alsaaudio: Set try-poll to false by default
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, 
 BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005846c80636070c16"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000005846c80636070c16
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, May 26, 2025 at 8:27=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> marcandre.lureau@redhat.com writes:
>
> > From: BALATON Zoltan <balaton@eik.bme.hu>
> >
> > Quoting Volker R=C3=BCmelin: "try-poll=3Don tells the ALSA backend to t=
ry to
> > use an event loop instead of the audio timer. This works most of the
> > time. But the poll event handler in the ALSA backend has a bug. For
> > example, if the guest can't provide enough audio frames in time, the
> > ALSA buffer is only partly full and the event handler will be called
> > again and again on every iteration of the main loop. This increases
> > the processor load and the guest has less processor time to provide
> > new audio frames in time. I have two examples where a guest can't
> > recover from this situation and the guest seems to hang."
> >
> > One reproducer I've found is booting MorphOS demo iso on
> > qemu-system-ppc -machine pegasos2 -audio alsa which should play a
> > startup sound but instead it freezes. Even when it does not hang it
> > plays choppy sound. Volker suggested using command line to set
> > try-poll=3Doff saying: "The try-poll=3Doff arguments are typically
> > necessary, because the alsa backend has a design issue with
> > try-poll=3Don. If the guest can't provide enough audio frames, it's
> > really unhelpful to ask for new audio frames on every main loop
> > iteration until the guest can provide enough audio frames. Timer based
> > playback doesn't have that problem."
> >
> > But users cannot easily find this option and having a non-working
> > default is really unhelpful so to make life easier just set it to
> > false by default which works until the issue with the alsa backend can
> > be fixed.
> >
> > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > [ Marc-Andr=C3=A9 - Updated QAPI and CLI doc ]
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Message-Id: <20250316002046.D066A4E6004@zero.eik.bme.hu>
> > ---
> >  qapi/audio.json   | 2 +-
> >  audio/alsaaudio.c | 2 +-
> >  qemu-options.hx   | 4 ++--
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/qapi/audio.json b/qapi/audio.json
> > index dd5a58d13e..49633cf317 100644
> > --- a/qapi/audio.json
> > +++ b/qapi/audio.json
> > @@ -96,7 +96,7 @@
> >  # @period-length: the period length in microseconds
> >  #
> >  # @try-poll: attempt to use poll mode, falling back to non-polling
> > -#     access on failure (default true)
> > +#     access on failure (default false)
> >  #
> >  # Since: 4.0
> >  ##
>
> Missed this when it was posted (it wasn't cc'ed to me).  Flipping the
> default is technically an incompatible change.  I understand the
> justification, and I'm not passing judgement on its validity; that's the
> audio maintainers job.  I just want to ask: does this need a release
> note?
>
>
I doubt anyone will care as long as it doesn't break (that we can't know).

I added a note to https://wiki.qemu.org/ChangeLog/10.1#Audio


We normally record incompatible changes in docs/about/deprecated.rst and
> then docs/about/removed-features.rst, but these don't fit here.
>
> [...]
>
>

--0000000000005846c80636070c16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 26, 2=
025 at 8:27=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redha=
t.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><a href=3D"mailto:marcandre.lureau@redhat.com" targ=
et=3D"_blank">marcandre.lureau@redhat.com</a> writes:<br>
<br>
&gt; From: BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu" target=
=3D"_blank">balaton@eik.bme.hu</a>&gt;<br>
&gt;<br>
&gt; Quoting Volker R=C3=BCmelin: &quot;try-poll=3Don tells the ALSA backen=
d to try to<br>
&gt; use an event loop instead of the audio timer. This works most of the<b=
r>
&gt; time. But the poll event handler in the ALSA backend has a bug. For<br=
>
&gt; example, if the guest can&#39;t provide enough audio frames in time, t=
he<br>
&gt; ALSA buffer is only partly full and the event handler will be called<b=
r>
&gt; again and again on every iteration of the main loop. This increases<br=
>
&gt; the processor load and the guest has less processor time to provide<br=
>
&gt; new audio frames in time. I have two examples where a guest can&#39;t<=
br>
&gt; recover from this situation and the guest seems to hang.&quot;<br>
&gt;<br>
&gt; One reproducer I&#39;ve found is booting MorphOS demo iso on<br>
&gt; qemu-system-ppc -machine pegasos2 -audio alsa which should play a<br>
&gt; startup sound but instead it freezes. Even when it does not hang it<br=
>
&gt; plays choppy sound. Volker suggested using command line to set<br>
&gt; try-poll=3Doff saying: &quot;The try-poll=3Doff arguments are typicall=
y<br>
&gt; necessary, because the alsa backend has a design issue with<br>
&gt; try-poll=3Don. If the guest can&#39;t provide enough audio frames, it&=
#39;s<br>
&gt; really unhelpful to ask for new audio frames on every main loop<br>
&gt; iteration until the guest can provide enough audio frames. Timer based=
<br>
&gt; playback doesn&#39;t have that problem.&quot;<br>
&gt;<br>
&gt; But users cannot easily find this option and having a non-working<br>
&gt; default is really unhelpful so to make life easier just set it to<br>
&gt; false by default which works until the issue with the alsa backend can=
<br>
&gt; be fixed.<br>
&gt;<br>
&gt; Signed-off-by: BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu=
" target=3D"_blank">balaton@eik.bme.hu</a>&gt;<br>
&gt; Acked-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; [ Marc-Andr=C3=A9 - Updated QAPI and CLI doc ]<br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; Message-Id: &lt;<a href=3D"mailto:20250316002046.D066A4E6004@zero.eik.=
bme.hu" target=3D"_blank">20250316002046.D066A4E6004@zero.eik.bme.hu</a>&gt=
;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/audio.json=C2=A0 =C2=A0| 2 +-<br>
&gt;=C2=A0 audio/alsaaudio.c | 2 +-<br>
&gt;=C2=A0 qemu-options.hx=C2=A0 =C2=A0| 4 ++--<br>
&gt;=C2=A0 3 files changed, 4 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/qapi/audio.json b/qapi/audio.json<br>
&gt; index dd5a58d13e..49633cf317 100644<br>
&gt; --- a/qapi/audio.json<br>
&gt; +++ b/qapi/audio.json<br>
&gt; @@ -96,7 +96,7 @@<br>
&gt;=C2=A0 # @period-length: the period length in microseconds<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @try-poll: attempt to use poll mode, falling back to non-polli=
ng<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0access on failure (default true)<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0access on failure (default false)<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Since: 4.0<br>
&gt;=C2=A0 ##<br>
<br>
Missed this when it was posted (it wasn&#39;t cc&#39;ed to me).=C2=A0 Flipp=
ing the<br>
default is technically an incompatible change.=C2=A0 I understand the<br>
justification, and I&#39;m not passing judgement on its validity; that&#39;=
s the<br>
audio maintainers job.=C2=A0 I just want to ask: does this need a release<b=
r>
note?<br>
<br></blockquote><div><br></div><div>I doubt anyone will care as long as it=
 doesn&#39;t break (that we can&#39;t know).</div><div><br></div><div>I add=
ed a note to <a href=3D"https://wiki.qemu.org/ChangeLog/10.1#Audio">https:/=
/wiki.qemu.org/ChangeLog/10.1#Audio</a></div><div><br></div><div><br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
We normally record incompatible changes in docs/about/deprecated.rst and<br=
>
then docs/about/removed-features.rst, but these don&#39;t fit here.<br>
<br>
[...]<br>
<br>
</blockquote></div></div>

--0000000000005846c80636070c16--


