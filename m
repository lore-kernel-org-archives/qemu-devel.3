Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260A0C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 09:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfbum-0007UL-Gc; Wed, 05 Feb 2025 04:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tfbuj-0007U2-I5
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 04:41:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tfbuh-0001bP-Dd
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 04:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738748500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k44fsQu4a5I+Qs3DQwoAncIS+TEpYkiDGjaxdS9ELgE=;
 b=FCUVnsUrjhGgWwTqB8DhKaRmNlsZBMM1mjRj6fJ9dXYrCXMAFGur8fDEqXYLASNC8MJ30o
 lfrWNVv+EuTn0XIW+IJBFL/EisYsAOMlX3ZlRduvMFD4CzTGf4pCnG5+ek27qC8fBIMYIN
 sOZI65y9f/yIB2OVT99/nFXGhaUG3mY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-bVi5njN1MBCK8HPjCWWXAg-1; Wed, 05 Feb 2025 04:41:39 -0500
X-MC-Unique: bVi5njN1MBCK8HPjCWWXAg-1
X-Mimecast-MFC-AGG-ID: bVi5njN1MBCK8HPjCWWXAg
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e421548eabso31676196d6.0
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 01:41:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738748499; x=1739353299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k44fsQu4a5I+Qs3DQwoAncIS+TEpYkiDGjaxdS9ELgE=;
 b=WcWqND9cYHPs+w6FM0QdMn84tEsTNT1vQ73eWFsW2MxOfMXgzd6nwZD0xn8hCJa6xQ
 /3uhF6FX+MyJEsfTp8XEBPBVbOCJvZcFUX0F7yH3kra2IMRC8eOeHi7zipwqHSUdAfPC
 73mcyYAGqrMwv/WJDLBxJXJDP63fw0SPC3x2eZ1PsUMbKmqzp0iq9O4ork4O5lRBhE58
 +DFMSz4Z2QMV7cLd7K8J7BoDL6qLTc6lGXu3rZlwP0ZRjFdWFRVAiyHwyR0/fPrMIBJB
 SFaMobbFW1cWyLm6eL9rhKbfthfT4xzay7CoYAGm3zSMCQ3f86ilFbufVP8uNGnGfFaD
 IWjA==
X-Gm-Message-State: AOJu0YztemQYevKTvW8PZL0u0cVLXi8Fg3A9W/x+wWC5aVWMuN+NrQh9
 KTwlNNRf7FiwqhGeuITWjrLNr5pGXECsO59f3RaeHDlm26km4yqZeP3dg33119xFHwNNzv3zHnY
 23U/K9LpZTdLzeLEIUN9j++TQIMLM8+pAOa+6/zXXXQfIQMT1fr1h10Ei138/ZKhXfDZTcQxoYK
 VNQJw450DTOM01+1Ut/f5/x70Usxg=
X-Gm-Gg: ASbGncvrb3KnQ8JdIkLTRzvGoFJVzj5EEuQxI0ZH1yxI0WVVxsW3f9eRWASXhbC8UpD
 fHWc0KkRskLfFV78oUqB31bVRK2tTHmvfaAvaSMaW9aJKmJd7evMN+YFRwb9XEKagv/V5Sa7cd3
 WhYD0ALVXl3TNotHC+O+E=
X-Received: by 2002:a05:6214:2241:b0:6e4:2d89:3a92 with SMTP id
 6a1803df08f44-6e42fc33c47mr34000166d6.34.1738748498765; 
 Wed, 05 Feb 2025 01:41:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh6i04hxZFbZ0QqJfxu9dvJZ3yGoPo28k1h/0iGiXOIn7UL7o2AtdTz8p3+an+uhnDDJHgXCz8fZQ40gmrzmM=
X-Received: by 2002:a05:6214:2241:b0:6e4:2d89:3a92 with SMTP id
 6a1803df08f44-6e42fc33c47mr34000066d6.34.1738748498521; Wed, 05 Feb 2025
 01:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20250128120559.729221-1-marcandre.lureau@redhat.com>
 <87msf04wpk.fsf@pond.sub.org>
In-Reply-To: <87msf04wpk.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 5 Feb 2025 13:41:25 +0400
X-Gm-Features: AWEUYZk9GS6INFEcOOxM0WyWBWMU-Dlk2l2AiuCtXOGCqXS4307Uq3cFWZv2muI
Message-ID: <CAMxuvayvp4N9K7TTGzTFvb1Yi1WejbBFQviG7Em9UOJAwkmT6A@mail.gmail.com>
Subject: Re: [PATCH] dbus: add -audio dbus nsamples option
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Wed, Feb 5, 2025 at 12:33=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> marcandre.lureau@redhat.com writes:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Allow to set the number of audio samples per read/write to dbus.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qapi/audio.json      | 22 +++++++++++++++++++++-
> >  audio/dbusaudio.c    | 21 ++++++++++++++++++---
> >  ui/dbus-display1.xml | 12 ++++++++++++
> >  3 files changed, 51 insertions(+), 4 deletions(-)
> >
> > diff --git a/qapi/audio.json b/qapi/audio.json
> > index 519697c0cd..dd5a58d13e 100644
> > --- a/qapi/audio.json
> > +++ b/qapi/audio.json
> > @@ -65,6 +65,26 @@
> >      '*in':  'AudiodevPerDirectionOptions',
> >      '*out': 'AudiodevPerDirectionOptions' } }
> >
> > +##
> > +# @AudiodevDBusOptions:
> > +#
> > +# Options of the D-Bus audio backend.
> > +#
> > +# @in: options of the capture stream
> > +#
> > +# @out: options of the playback stream
> > +#
> > +# @nsamples: set the number of samples per read/write calls (default t=
o 480,
> > +# 10ms at 48kHz).
>
> Markup error.  This is rendered like
>
>     "nsamples": "int" (optional)
>        set the number of samples per read/write calls (default to 480,
>
>     10ms at 48kHz).
>
> Fix:
>
>    # @nsamples: set the number of samples per read/write calls
>    #     (default to 480, 10ms at 48kHz).
>

ack, could you send a patch?

> I'm not sure I understand the parenthesis.  I guess it means default
> value is 480 samples per read/write call, which translates to 10ms when
> sampling at 48kHz.  Correct?

correct, feel free to improve the wording.

> > +#
> > +# Since: 10.0
> > +##
> > +{ 'struct': 'AudiodevDBusOptions',
> > +  'data': {
> > +    '*in':  'AudiodevPerDirectionOptions',
> > +    '*out': 'AudiodevPerDirectionOptions',
> > +    '*nsamples': 'uint32'} }
> > +
>
> Could use 'base': 'AudiodevGenericOptions' instead of duplicating @in
> and @out, but that would deviate from all the other AudiodevFOOOptions.
> I agree with your decision.
>
> >  ##
> >  # @AudiodevAlsaPerDirectionOptions:
> >  #
> > @@ -490,7 +510,7 @@
> >                     'if': 'CONFIG_AUDIO_ALSA' },
> >      'coreaudio': { 'type': 'AudiodevCoreaudioOptions',
> >                     'if': 'CONFIG_AUDIO_COREAUDIO' },
> > -    'dbus':      { 'type': 'AudiodevGenericOptions',
> > +    'dbus':      { 'type': 'AudiodevDBusOptions',
> >                     'if': 'CONFIG_DBUS_DISPLAY' },
> >      'dsound':    { 'type': 'AudiodevDsoundOptions',
> >                     'if': 'CONFIG_AUDIO_DSOUND' },
>
> [...]
>


