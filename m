Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A94C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE79I-0003Ls-H4; Mon, 03 Jun 2024 08:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sE79H-0003LA-E4
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sE79C-00012F-5I
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717419045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ag9QDcPIw8Asa9YU9zMqlGKZHPVSm1Mm+ypr8HygZHk=;
 b=AFPTVXckh5Tyf0nTNAnohLQX2ClM/uw4d/e+U3VoKoOlOFLBTKZhgfUaSD4bMypyohAEwp
 CONWvQdrI9rtNllydLQpYV/BuQjTuSsHx4mrI/fRidhgF9ttkIj34usAiyiZes96LEqXRC
 4XhSYZRtDN5s7VZ6XcScQvFs95Nt+AI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-vQPCZlk2Mxa9ajIBcM7cIQ-1; Mon, 03 Jun 2024 08:50:43 -0400
X-MC-Unique: vQPCZlk2Mxa9ajIBcM7cIQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a68b42049b4so58658766b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717419042; x=1718023842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ag9QDcPIw8Asa9YU9zMqlGKZHPVSm1Mm+ypr8HygZHk=;
 b=VROeVX5OkRtnYfhZNIfNnVm6GHiq4RZt9dZq4V+9kk1CLjDPRbvcSC7eh3WWBd4RDf
 wZBYwwL5+fYimiuRmg8/BdHYhe705M8ZImyRRvwswtokteYMIJitn9JDNo01YUVewyYJ
 jxpqL+c74ahRE4KhNy8pjbHq/AWRY+JET8nwmS2/zKK0apVIknbi7hcmRpsYtHjyl6zh
 xiGaJn4IADTVx2xN5U+ikYpvscO/CwPHq77XRrTUJ5azz4JZaOhv192c6Plg2VssKIKC
 Oewe30r+ppV7HJUGOYAI4S0bKZAA699rp2nYiCq0NsVLbsszg2OmvxROaq/AwAzc8AL7
 WDhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiKWmT9tNHjWpULLT0ubiDY79jbzC+5iMVsd4sjd7iXzzUZ90G4nrmV/DTyCG8H8lyg3YjzceYT2b6Ipk0LUtYAIqZYXg=
X-Gm-Message-State: AOJu0YyOAMmqCgVXM+/srwk3OhsX7HwkrV/ZoBdI2l1r+U9vWRXX6Z3V
 x7jBpM6NTNWY7JWK511C+lCZEFb/aawrTpJlYIt2bNHyNBsHw3xx4sMpGJGdO5LzyuJh9kgjrcJ
 0Z6v+86rrejSMSJ3bNAaxtQLREOflF1j3ZgXj/axEC3GyzHx/SRHAx9tu+w441q1PjDK/TeVluJ
 uh1sWTqkxLCF1SEJopv0A/4gylmmhrAYnwrB4=
X-Received: by 2002:a50:c056:0:b0:572:a770:1371 with SMTP id
 4fb4d7f45d1cf-57a364c3d8amr5914356a12.42.1717419042252; 
 Mon, 03 Jun 2024 05:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMtxnBO6dVDhfOxQUiQcgDVRYaJYn/eT1mIiWNzD8FVokOTym3r57H3puV2D5caT71uGMUJPs0Cr0LRR7LJC0=
X-Received: by 2002:a50:c056:0:b0:572:a770:1371 with SMTP id
 4fb4d7f45d1cf-57a364c3d8amr5914299a12.42.1717419040349; Mon, 03 Jun 2024
 05:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240531175153.2716309-1-tavip@google.com>
 <CAFEAcA_zPR=gd95tkhi8cXaZMf+M2OO2WpF=ZfO1vKhsO9=1cA@mail.gmail.com>
In-Reply-To: <CAFEAcA_zPR=gd95tkhi8cXaZMf+M2OO2WpF=ZfO1vKhsO9=1cA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 3 Jun 2024 16:50:28 +0400
Message-ID: <CAMxuvawJhdLnERBvtRvLCOJgtV727JEcdNNTSA=LUC8Vfa_reg@mail.gmail.com>
Subject: Re: [PATCH] chardev: add path option for pty backend
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Octavian Purdila <tavip@google.com>, qemu-devel@nongnu.org,
 eblake@redhat.com, armbru@redhat.com, Paulo Neves <ptsneves@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi

On Mon, Jun 3, 2024 at 4:23=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Fri, 31 May 2024 at 22:21, Octavian Purdila <tavip@google.com> wrote:
> >
> > Add path option to the pty char backend which will create a symbolic
> > link to the given path that points to the allocated PTY.
> >
> > Based on patch from Paulo Neves:
> >
> > https://patchew.org/QEMU/1548509635-15776-1-git-send-email-ptsneves@gma=
il.com/
> >
> > Tested with the following invocations that the link is created and
> > removed when qemu stops:
> >
> >   qemu-system-x86_64 -nodefaults -mon chardev=3Dcompat_monitor \
> >   -chardev pty,path=3Dtest,id=3Dcompat_monitor0
> >
> >   qemu-system-x86_64 -nodefaults -monitor pty:test
> >
> > Also tested that when a link path is not passed invocations still work,=
 e.g.:
> >
> >   qemu-system-x86_64 -monitor pty
>
> Could we have some justification here for why the new
> functionality is useful, please? (e.g. what new use cases
> it permits).
>

It avoids the need to HMP/QMP query the allocated pty path. I don't
think there are other benefits.

> > --- a/qapi/char.json
> > +++ b/qapi/char.json
> > @@ -509,7 +509,7 @@
> >  ##
> >  # @ChardevHostdevWrapper:
> >  #
> > -# @data: Configuration info for device and pipe chardevs
> > +# @data: Configuration info for device, pty and pipe chardevs
> >  #
> >  # Since: 1.4
> >  ##
> > @@ -650,7 +650,7 @@
> >              'pipe': 'ChardevHostdevWrapper',
> >              'socket': 'ChardevSocketWrapper',
> >              'udp': 'ChardevUdpWrapper',
> > -            'pty': 'ChardevCommonWrapper',
> > +            'pty': 'ChardevHostdevWrapper',
> >              'null': 'ChardevCommonWrapper',
> >              'mux': 'ChardevMuxWrapper',
> >              'msmouse': 'ChardevCommonWrapper',
>
> Does this break QAPI compatibility?
>
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 8ca7f34ef0..5eec194242 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -3569,7 +3569,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
> >      "-chardev console,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappe=
nd=3Don|off]\n"
> >      "-chardev serial,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPAT=
H][,logappend=3Don|off]\n"
> >  #else
> > -    "-chardev pty,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=
=3Don|off]\n"
> > +    "-chardev pty,id=3Did[,path=3Dpath][,mux=3Don|off][,logfile=3DPATH=
][,logappend=3Don|off]\n"
> >      "-chardev stdio,id=3Did[,mux=3Don|off][,signal=3Don|off][,logfile=
=3DPATH][,logappend=3Don|off]\n"
> >  #endif
> >  #ifdef CONFIG_BRLAPI
> > @@ -3808,12 +3808,16 @@ The available backends are:
> >
> >      ``path`` specifies the name of the serial device to open.
> >
> > -``-chardev pty,id=3Did``
> > +``-chardev pty,id=3Did[,path=3Dpath]``
> >      Create a new pseudo-terminal on the host and connect to it. ``pty`=
`
> >      does not take any options.
>
> We just added an option, so we should delete the line saying
> that it doesn't take any options :-)
>
> >
> >      ``pty`` is not available on Windows hosts.
> >
> > +    ``path`` specifies the symbolic link path to be created that
> > +    points to the pty device.
>
> I think we could usefully make this a little less terse. Perhaps
>    If ``path`` is specified, QEMU will create a symbolic link at
>    that location which points to the new PTY device.
> ?
>
> thanks
> -- PMM
>


