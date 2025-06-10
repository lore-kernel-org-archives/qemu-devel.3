Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2626AC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 11:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOxBn-0008WM-1F; Tue, 10 Jun 2025 07:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uOxBl-0008W7-CP
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 07:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uOxBi-0008QR-Vi
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 07:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749555040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aXaYqrKJWDbC3lD1v0M6Jo4gI3/S4jq7guNuzdQpV+0=;
 b=M5s/CYk668OXxPyuSshleuDz2k4SYMO2k8gVFR6JmTrQNbrr7LxV+tgO8EKMM0HgoytqZs
 CSYZAeX3QlLrf2xoC8wHAxYdTm7VUdXutKL1IpjHDjt6bgClQG8OZY6GCl7i0gGtfW45VO
 6Z4RzYBaHsVQvqiuZQpDEALxjUmuWWg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-0O_Aw8a-Pkm5kFk_dLsHJw-1; Tue, 10 Jun 2025 07:30:36 -0400
X-MC-Unique: 0O_Aw8a-Pkm5kFk_dLsHJw-1
X-Mimecast-MFC-AGG-ID: 0O_Aw8a-Pkm5kFk_dLsHJw_1749555036
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4a43ae0dcf7so108731981cf.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 04:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749555036; x=1750159836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aXaYqrKJWDbC3lD1v0M6Jo4gI3/S4jq7guNuzdQpV+0=;
 b=jGbdX4tXFTmf/FMzVFbzSekhw2WRUvRNQiQUvaDLy6tS3hCH+JPaW9lCDktYreC0a2
 TpcLnUXlfes7XxHhvyyXgwxa4NqP+T/AV05ksdD1NuJunhgNIoc2IvOdLxiC++/7+gQn
 DqJ0ZvigauNhR50cH1GLRDIn5GMNuOe9DN3hUUe8GxL2/4rKnJZM99Uo4Ae4pkl4ZfmB
 DQG3E1IAiQDMxIAEB/87bNsfF1s/yyYvJDKrwCZxxEpobfjVIewyMlxHA6l3Cgf4UQOT
 rfGQatIGVGcBzdFwdI6Qs3l3Y5ahAuMcgRcmGAG5FLH8nTXDMkzLJreR/Na4sMoKVR1R
 UNtQ==
X-Gm-Message-State: AOJu0YyzOS9EFSfkjpQMEHu7vEw335yAaBCD1yNYivQrwDLQK0eSlryg
 q4BsYF4EBomcwCGKdakTjRRSccvhtGFI9SfDaHv1D/h1EsutkeBOoF16JsKB2fCDHm4h+5dHfsN
 LmB9CP/0cmOQ5Odpk0s7RwSNnEdmUKWVU+cx+t9MfQtqpCNz0l1jGPS6uOw82WiT2ic9ozmhqUS
 IWxcUObCegV/ywK/nE5GoBcSPmoA1P1a4=
X-Gm-Gg: ASbGncvH2Vx9eXNzj0Dx+du2wTuuDFRcrlKtBQ6xtIMM3un1IDXoUjaFw6BQ3sc+ncX
 0hIbDFSrwYxFT4H1CDM19zvmx2mCHCKxhp7OAEzp8BVPwhuhak/WbNQvtZgUkh3Ame8oRCo4m+N
 +Oo7mhRs52mbkQjZNNK+HYQxgXe1tpi2+iQk8A
X-Received: by 2002:a05:622a:4cc5:b0:494:b1f9:d678 with SMTP id
 d75a77b69052e-4a5b9dea652mr290539581cf.50.1749555036176; 
 Tue, 10 Jun 2025 04:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwmQA2dTlP0SwZNVP9yXTBZViduo8i05G1FZ00xY1lggExsL6+xVSapAVXwXqbdfUJkC7xLsdGWdbV2JNh2vg=
X-Received: by 2002:a05:622a:4cc5:b0:494:b1f9:d678 with SMTP id
 d75a77b69052e-4a5b9dea652mr290539091cf.50.1749555035781; Tue, 10 Jun 2025
 04:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
 <20250529051352.1409904-3-vivek.kasireddy@intel.com>
 <aEFYnTvaDQ6Kd0o4@redhat.com>
 <IA0PR11MB71852C724D241204B8C09AF0F86EA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <aEKVmH8ZxDcGKSeq@redhat.com>
In-Reply-To: <aEKVmH8ZxDcGKSeq@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Jun 2025 15:30:24 +0400
X-Gm-Features: AX0GCFtN6mU0HMZ_54isl_2XuwE9eA7o4K_b4Hd74gPdLHonTQtBh_iwZUjOW2k
Message-ID: <CAMxuvaz1wJw-qMDDPwj_BOGPL0zdgBsi647B6+AG+OdOOomhDQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] ui/spice: Add an option for users to provide a
 preferred codec
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Frediano Ziglio <freddy77@gmail.com>, "Kasireddy,
 Vivek" <vivek.kasireddy@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, "Kim,
 Dongwon" <dongwon.kim@intel.com>, 
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Content-Type: multipart/alternative; boundary="0000000000006c5794063736065e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000006c5794063736065e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Jun 6, 2025 at 11:16=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Fri, Jun 06, 2025 at 06:10:31AM +0000, Kasireddy, Vivek wrote:
> > Hi Daniel,
> >
> > > Subject: Re: [PATCH v5 2/7] ui/spice: Add an option for users to
> provide a
> > > preferred codec
> > >
> > > On Wed, May 28, 2025 at 10:11:13PM -0700, Vivek Kasireddy wrote:
> > > > Giving users an option to choose a particular codec will enable
> > > > them to make an appropriate decision based on their hardware and
> > > > use-case.
> > > >
> > > > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > > > Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > > > Cc: Frediano Ziglio <freddy77@gmail.com>
> > > > Cc: Dongwon Kim <dongwon.kim@intel.com>
> > > > Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
> > > > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > > > ---
> > > >  qemu-options.hx |  5 +++++
> > > >  ui/spice-core.c | 12 ++++++++++++
> > > >  2 files changed, 17 insertions(+)
> > > >
> > > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > > index 7eb8e02b4b..fcddb583c9 100644
> > > > --- a/qemu-options.hx
> > > > +++ b/qemu-options.hx
> > > > @@ -2281,6 +2281,7 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
> > > >      "
>  [,streaming-video=3D[off|all|filter]][,disable-copy-paste=3Don|off]\n"
> > > >      "
>  [,disable-agent-file-xfer=3Don|off][,agent-mouse=3D[on|off]]\n"
> > > >      "       [,playback-compression=3D[on|off]][,seamless-
> > > migration=3D[on|off]]\n"
> > > > +    "       [,video-codecs=3D<encoder>:<codec>\n"
> > > >      "       [,gl=3D[on|off]][,rendernode=3D<file>]\n"
> > > >      "                enable spice\n"
> > > >      "                at least one of {port, tls-port} is
> mandatory\n",
> > > > @@ -2369,6 +2370,10 @@ SRST
> > > >      ``seamless-migration=3D[on|off]``
> > > >          Enable/disable spice seamless migration. Default is off.
> > > >
> > > > +    ``video-codecs=3D<encoder>:<codec>``
> > > > +        Provide the preferred codec the Spice server should use.
> > > > +        Default would be spice:mjpeg.
> > >
> > > This looks like two distinct settings overloaded into one command
> > > line parameter, which is a design anti-pattern.
> > >
> > > Why can't this be done as separate parameters
> > The Spice server API used by Qemu (spice_server_set_video_codecs)
> > to set the preferred codec requires the video-codecs string to be in
> > encoder:codec format. AFAIK, there is no other option or API to set
> > the encoder and codec values separately.
>
> QEMU can accept the separate parameters and format them into the string
> format that the spice API requires so our public API is not impacted
> by this spice design choice.
>
>
Apparently you cannot mix and match freely, it has a rather fixed set of
actually working values.

See here and related code:
https://gitlab.freedesktop.org/spice/spice/-/blob/master/server/reds.cpp?re=
f_type=3Dheads#L3468

Tbh, I don't think the encoder matters much, and I don't know why it was
decided to associate it with video codec names.

Maybe the spice API should provide a simpler form: accept only codec names.

In the meantime, qemu should perhaps add the "working" encoder prefixes
(spice: for mjpeg, gstreamer: for others)  itself and not expose any extra
option to the user?

--0000000000006c5794063736065e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0</div><div dir=3D"ltr"><br></div>=
<div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"=
gmail_attr">On Fri, Jun 6, 2025 at 11:16=E2=80=AFAM Daniel P. Berrang=C3=A9=
 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Jun =
06, 2025 at 06:10:31AM +0000, Kasireddy, Vivek wrote:<br>
&gt; Hi Daniel,<br>
&gt; <br>
&gt; &gt; Subject: Re: [PATCH v5 2/7] ui/spice: Add an option for users to =
provide a<br>
&gt; &gt; preferred codec<br>
&gt; &gt; <br>
&gt; &gt; On Wed, May 28, 2025 at 10:11:13PM -0700, Vivek Kasireddy wrote:<=
br>
&gt; &gt; &gt; Giving users an option to choose a particular codec will ena=
ble<br>
&gt; &gt; &gt; them to make an appropriate decision based on their hardware=
 and<br>
&gt; &gt; &gt; use-case.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" t=
arget=3D"_blank">kraxel@redhat.com</a>&gt;<br>
&gt; &gt; &gt; Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; &gt; &gt; Cc: Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@co=
llabora.com" target=3D"_blank">dmitry.osipenko@collabora.com</a>&gt;<br>
&gt; &gt; &gt; Cc: Frediano Ziglio &lt;<a href=3D"mailto:freddy77@gmail.com=
" target=3D"_blank">freddy77@gmail.com</a>&gt;<br>
&gt; &gt; &gt; Cc: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com"=
 target=3D"_blank">dongwon.kim@intel.com</a>&gt;<br>
&gt; &gt; &gt; Cc: Michael Scherle &lt;<a href=3D"mailto:michael.scherle@rz=
.uni-freiburg.de" target=3D"_blank">michael.scherle@rz.uni-freiburg.de</a>&=
gt;<br>
&gt; &gt; &gt; Signed-off-by: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.k=
asireddy@intel.com" target=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 qemu-options.hx |=C2=A0 5 +++++<br>
&gt; &gt; &gt;=C2=A0 ui/spice-core.c | 12 ++++++++++++<br>
&gt; &gt; &gt;=C2=A0 2 files changed, 17 insertions(+)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/qemu-options.hx b/qemu-options.hx<br>
&gt; &gt; &gt; index 7eb8e02b4b..fcddb583c9 100644<br>
&gt; &gt; &gt; --- a/qemu-options.hx<br>
&gt; &gt; &gt; +++ b/qemu-options.hx<br>
&gt; &gt; &gt; @@ -2281,6 +2281,7 @@ DEF(&quot;spice&quot;, HAS_ARG, QEMU_O=
PTION_spice,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,strea=
ming-video=3D[off|all|filter]][,disable-copy-paste=3Don|off]\n&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,disab=
le-agent-file-xfer=3Don|off][,agent-mouse=3D[on|off]]\n&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,playb=
ack-compression=3D[on|off]][,seamless-<br>
&gt; &gt; migration=3D[on|off]]\n&quot;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,video-code=
cs=3D&lt;encoder&gt;:&lt;codec&gt;\n&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0[,gl=3D=
[on|off]][,rendernode=3D&lt;file&gt;]\n&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 enable spice\n&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 at least one of {port, tls-port} is mandatory\n&quot;=
,<br>
&gt; &gt; &gt; @@ -2369,6 +2370,10 @@ SRST<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 ``seamless-migration=3D[on|off]``<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Enable/disable spice seaml=
ess migration. Default is off.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 ``video-codecs=3D&lt;encoder&gt;:&lt;codec&gt=
;``<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Provide the preferred codec the=
 Spice server should use.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Default would be spice:mjpeg.<b=
r>
&gt; &gt; <br>
&gt; &gt; This looks like two distinct settings overloaded into one command=
<br>
&gt; &gt; line parameter, which is a design anti-pattern.<br>
&gt; &gt; <br>
&gt; &gt; Why can&#39;t this be done as separate parameters<br>
&gt; The Spice server API used by Qemu (spice_server_set_video_codecs)<br>
&gt; to set the preferred codec requires the video-codecs string to be in<b=
r>
&gt; encoder:codec format. AFAIK, there is no other option or API to set<br=
>
&gt; the encoder and codec values separately.<br>
<br>
QEMU can accept the separate parameters and format them into the string<br>
format that the spice API requires so our public API is not impacted<br>
by this spice design choice.<br><br></blockquote><div><br></div><div><div>A=
pparently you cannot mix and match freely, it has a rather fixed set of act=
ually working values.</div><div><br></div><div>See here and related code:=
=C2=A0</div><div><a href=3D"https://gitlab.freedesktop.org/spice/spice/-/bl=
ob/master/server/reds.cpp?ref_type=3Dheads#L3468">https://gitlab.freedeskto=
p.org/spice/spice/-/blob/master/server/reds.cpp?ref_type=3Dheads#L3468</a><=
/div><div><br></div></div><div>Tbh, I don&#39;t think the encoder matters m=
uch, and I don&#39;t know why it was decided to associate it with video cod=
ec names.</div><div><br></div><div>Maybe the spice API should provide a sim=
pler form: accept only codec names.</div><div><br></div><div>In the meantim=
e, qemu should perhaps add the &quot;working&quot;=C2=A0encoder prefixes (s=
pice: for mjpeg, gstreamer: for others)=C2=A0 itself and not expose any ext=
ra option to the user?</div><div><br></div></div></div>

--0000000000006c5794063736065e--


