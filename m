Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248DEC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 13:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpp1E-0002px-R5; Wed, 05 Mar 2025 08:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tpp1B-0002pe-9l
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 08:42:38 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tpp19-0006C5-By
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 08:42:37 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2232aead377so134499825ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 05:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741182151; x=1741786951; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R46TJVIijYtm/jyKQDqBlv5bgX/Ay8z556uEiy5GzpI=;
 b=jNcOAr5PJLDby5ulkvk++750Z6IgaJuzRZPoUYxnoSvte3QGCtgsOGKLCwVKBkFjY/
 bYR7ON1fPHrwDx3RsQLnJU9r4URzQ2Qba/bLUzduqqBZlyLKmzXPaC57CxL6Dav8xfBd
 /H8q40VjlWZkbgqvzKuhRqdWgG6olTTKpyT38hexaXUSzdWqEmdr7CMzmSOxSZrBG6uT
 x1DHN3Z/4yMCe2tmEZjFpwXDnuEPQCW94wRmtUEKXoDshHC+8UsuGWsa2xE5ua9POAex
 xH8ec0E8mPmixnBeNWpq5HnmDSGgwC0APOcr+YAV77HYECmpOMOtTv03HwZ2o6h+kS5n
 op+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741182151; x=1741786951;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R46TJVIijYtm/jyKQDqBlv5bgX/Ay8z556uEiy5GzpI=;
 b=WVA9r41Xi8GONosLzPmxRgo48s4KxoH/RksuQUFoP+fClGzFPeiVarinIY00s1GdIP
 EVrUbrDA38boCRgB6KRfkfrj5XmZCzIJQj6aORsefF7QXdzWljK/P205j1N86Ko4uicI
 ICwAZxfYWdvVWOA7TAzb7D08zIud/tdOrunVbPhwZrMKrhDUiRG6ZeBCxriB+WyJGQla
 ks5B6MFhlYV4DIu0nPulpU7elYfKQnLPdtm9jRXAel7MOBqYiW+syU+AIk3ekx7aQtjM
 F0Kl+Oq4ms5vWRcBYUXurQqF7h2lp2PVaR7tSNPkZbAk+XODIQQuFhyvPdFPbpwjUDiz
 361w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIGNVMfLLj2ZHhSdocAh0bG3W8iCG7hwazs/2UtCqYyidrUY4kUoQzJzkciCFs/++DVGHFsxgjn7lu@nongnu.org
X-Gm-Message-State: AOJu0YxJZx1Y4DoblWHBkf7DnAoKg5RG879KIuOoTsf6uo08zJhDxIml
 /GItr/FyhNZkcQ1WWHH9KAIVPZdNGgoOpol2tqxVgo8GvSCtpPof
X-Gm-Gg: ASbGncuwtt/G5b3Qf9vZEXMqHJMFiWY24YuvQ7PB605PwrpQEK8ugRMAkUbJfq9v390
 ErqikFurQr6rWahqSwwR4LFavL84yGzHJkpf3kUtuIrkwl2dD4RDaC77X7+iLgNPJ/SKVUd60xT
 n2ZfR+6MV0TP1rP1wUfrL5SeIj84qJ78MBGZ5XZUzPicXh8q/yCgIjpl/ziwtB6O0/9O912GlXD
 K18YQwVIEzk72ADqp7+X0h/E7uPoc2o2FsghrOXG89yR+fd3DUZ4yjyKLNPxJ/qe7nkyDn5LoT5
 cfDMcw+2bqNfTd9lfqzKK1c1zNy9JEP7ViHAYX8fdlk01Nh0F1rzjPd65GzFN+g=
X-Google-Smtp-Source: AGHT+IFtLAjRlcc3VGvKswso+JrMX2mpl+6j8YyRMgRaT8EGOyvzkU2m1/TdjVPHjj9qx8J+WcO9SA==
X-Received: by 2002:a17:902:ec85:b0:223:5c33:56b4 with SMTP id
 d9443c01a7336-223f1c80be8mr46232765ad.20.1741182151158; 
 Wed, 05 Mar 2025 05:42:31 -0800 (PST)
Received: from localhost (n11648126014.netvigator.com. [116.48.126.14])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223504dc4b4sm112545605ad.171.2025.03.05.05.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 05:42:30 -0800 (PST)
From: Stefan Hajnoczi <stefanha@gmail.com>
X-Google-Original-From: Stefan Hajnoczi <stefanha@fedora>
Date: Wed, 5 Mar 2025 21:42:25 +0800
To: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, imammedo@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] microvm: do not use the lastest cpu version
Message-ID: <20250305134225.GA256646@fedora>
References: <20250220065326.312596-1-anisinha@redhat.com>
 <Z7bZBsqO6MxhFKVp@intel.com>
 <CAK3XEhM505AFFND17_SOOJnTPB+u2+hKXDdo01oyza9T1=H2ww@mail.gmail.com>
 <CAK3XEhMbLHKt8-kV=BzKgZpdbtmRDC+qM3bfqz9BYfupR13t2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CDSscDYY+6yD/NPh"
Content-Disposition: inline
In-Reply-To: <CAK3XEhMbLHKt8-kV=BzKgZpdbtmRDC+qM3bfqz9BYfupR13t2w@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=stefanha@gmail.com; helo=mail-pl1-x629.google.com
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


--CDSscDYY+6yD/NPh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 01:24:25PM +0530, Ani Sinha wrote:
> On Sat, Mar 1, 2025 at 9:04=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wr=
ote:
> >
> > On Thu, Feb 20, 2025 at 12:36=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com>=
 wrote:
> > >
> > > On Thu, Feb 20, 2025 at 12:23:26PM +0530, Ani Sinha wrote:
> > > > Date: Thu, 20 Feb 2025 12:23:26 +0530
> > > > From: Ani Sinha <anisinha@redhat.com>
> > > > Subject: [PATCH v2] microvm: do not use the lastest cpu version
> > > > X-Mailer: git-send-email 2.45.2
> > > >
> > > > commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be aliases=
")
> > > > introduced 'default_cpu_version' for PCMachineClass. This created t=
hree
> > > > categories of CPU models:
> > > >  - Most unversioned CPU models would use version 1 by default.
> > > >  - For machines 4.0.1 and older that do not support cpu model alias=
es, a
> > > >    special default_cpu_version value of CPU_VERSION_LEGACY is used.
> > > >  - It was thought that future machines would use the latest value o=
f cpu
> > > >    versions corresponding to default_cpu_version value of
> > > >    CPU_VERSION_LATEST [1].
> > > >
> > > > All pc machines still use the default cpu version of 1 for
> > > > unversioned cpu models. CPU_VERSION_LATEST is a moving target and
> > > > changes with time. Therefore, if machines use CPU_VERSION_LATEST, i=
t would
> > > > mean that over a period of time, for the same versioned machine typ=
e,
> > > > the cpu version would be different depending on what the latest was=
 at that
> > > > time. This would break guests even when they use a constant specific
> > > > versioned machine type.
> > > > Additionally, microvm machines are not versioned anyway and therefo=
re
> > > > there is no requirement to use the latest cpu model by default.
> > > > Let microvms use the non-versioned cpu model and remove all referen=
ces
> > > > to CPU_VERSION_LATEST as there are no other users (nor we anticipate
> > > > future consumers of CPU_VERSION_LATEST).
> > > >
> > > > Those users who need spefific cpu versions can use explicit version=
 in
> > > > the QEMU command line to select the specific cpu version desired.
> > > >
> > > > CI pipline does not break with this change.
> > > >
> > > > 1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")
> > > >
> > > > CC: imammedo@redhat.com
> > > > CC: zhao1.liu@intel.com
> > > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > > Reviewed-by: Sergio Lopez <slp@redhat.com>
> > > > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > > > ---
> > > >  hw/i386/microvm.c |  2 +-
> > > >  target/i386/cpu.c | 15 ---------------
> > > >  target/i386/cpu.h |  4 ----
> > > >  3 files changed, 1 insertion(+), 20 deletions(-)
> > > >
> > > > changelog:
> > > > v2: tags added, more explanation in the commit log.
> > >
> > > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> > >
> >
> > Who is picking this up?
>=20
> I sent a pull request for this and a couple other reviewed patches
> myself. Two reasons:
> - wanted to see this in the upstream sooner as some other bits of the
> work is pending on it.
> - I never sent a pull request before and wanted to go through the
> process to learn how to do it in case I needed it in the future.
>=20
> i hope the PR is ok. If not, I can resend after corrections. I used
> Peter's script https://git.linaro.org/people/peter.maydell/misc-scripts.g=
it/plain/make-pullreq

This should go via Paolo's tree. I have pinged him to remind him of your
patches.

Please only send pull requests for subsystems where you are listed as
the maintainer in the MAINTAINERS file.

It doesn't scale when people send me PRs directly because I need to do a
bunch of extra sanity checking and helping people get their one-off PRs
properly signed and formatted. I also don't like to bypass
sub-maintainers because I'm less qualified to do the final review than
the sub-maintainers themselves.

Thanks,
Stefan

--CDSscDYY+6yD/NPh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfIVMEACgkQnKSrs4Gr
c8g3LAf/Sem5eVOycQtxoAtWOS3sTsqUIx2i+RAmo+ujNB8roNE8L0fbFEtEZ6Cc
CgZ/U/I2UXwHikTib2MXjshaKY+IGIja03Sh2sWF4ETnHADag8SbK7xXFO22oZqM
A+IlRrsP5fqfsL/YO+0pTnBt88gM5ordE77NmgopRTZn2LlyqNOY7uE8b91Cb0ef
rSlOGAxhnQrr0h0HrX/+uiy5rFWZJuNQyTMvWJsCHMafhTE436ocqlWUkQUrhF11
8SbGlu/MyCwqSR6W11qa9d4QLqQLp1ZMsiqh2hxvD0AEBCq2Yei42g8jotvJTI5o
Je7uadm510tHIlurehOEdphkIwBQlw==
=4X2t
-----END PGP SIGNATURE-----

--CDSscDYY+6yD/NPh--

