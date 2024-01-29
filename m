Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2052C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 04:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUIrY-0002V3-LX; Sun, 28 Jan 2024 23:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1rUIrW-0002S4-TB; Sun, 28 Jan 2024 23:03:10 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1rUIrS-0004iE-MF; Sun, 28 Jan 2024 23:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1706500976;
 bh=U1tkh+CicOVk/lr4KCtZbT7hcZDi3iLHMqG+A/NCocQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Spxx1lTr7k5D/jM87LtecsTSLI+RPhjRwAOFQPhPiVswZxO95eT+nYIvAVSH/2haI
 6/WA469S6gJz/GzQGWPKJc3+PeoPH6ReMFSQd3SItOxc4IkdY2SUa/pE0Q5s3WRCCd
 4JAuhEgXUsQLg06e00SuOdpo4CnE2x2s9E4zaXld6W0QDXlgExjA7LtEqO5CYr3SRB
 2ZFqZlJ7MCOh4r34/l2BgMtn3zakB5RlaDoMeyvHAT6ztVjetIadxvWAaXMjW1VZM0
 RpwUXhDPQ2Grg6zpVXYxwXk2m6R3LFQ93H/pbOXBiutg3uZco/ESWdsrK8S7aOEyza
 /tWyxJHFZUdKA==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4TNZQS2Tc1z4wyl; Mon, 29 Jan 2024 15:02:56 +1100 (AEDT)
Date: Mon, 29 Jan 2024 14:58:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: spapr watchdog vs watchdog_perform_action() / QMP
 watchdog-set-action
Message-ID: <ZbciScVElxltEawe@zatzit>
References: <CAFEAcA_KjSgt-oC=d2m6WAdqoRsUcs1W_ji7Ng2fgVjxAWLZEw@mail.gmail.com>
 <87le8byg5f.fsf@pond.sub.org>
 <CAFEAcA-kTwM2U3VE0rX-hZt-5AAVPz7Vc-WEwwqndz+Liie=3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d5T3Ma41lV7ipIGd"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-kTwM2U3VE0rX-hZt-5AAVPz7Vc-WEwwqndz+Liie=3Q@mail.gmail.com>
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--d5T3Ma41lV7ipIGd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 01:08:02PM +0000, Peter Maydell wrote:
> On Fri, 26 Jan 2024 at 20:49, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> > > Hi; one of the "bitesized tasks" we have listed is to convert
> > > watchdog timers which directly call qemu_system_reset_request() on
> > > watchdog timeout to call watchdog_perform_action() instead. This
> > > means they honour the QMP commands that let the user specifiy
> > > the behaviour on watchdog expiry:
> > > https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#qapidoc-141
> > > https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#qapidoc-129
> > > (choices include reset, power off the system, do nothing, etc).
> > >
> > > There are only a few remaining watchdogs that don't use the
> > > watchdog_perform_action() function. In most cases the change
> > > is obvious and easy: just make them do that instead of calling
> > > qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET).
> > >
> > > However, the hw/watchdog/spapr_watchdog.c case is trickier. As
> > > far as I can tell from the sources, this is a watchdog set up via
> > > a hypercall, and the guest makes a choice of "power off, restart,
> > > or dump and restart" for its on-expiry action.
> > >
> > > What should this watchdog's interaction with the watchdog-set-action
> > > QMP command be? If the user says "do X" and the guest says "do Y",
> > > which do we do? (With the current code, we always honour what
> > > the guest asks for and ignore what the user asks for.)
> >
> > Gut reaction: when the user says "do X", the guest should not get a say.
> > But one of the values of X could be "whatever the guest says".

That would also be my inclination.

> Mmm. Slightly awkwardly, we don't currently distinguish between
> "action is reset because the user never expressed a preference"
> and "action is reset because the user specifically asked for that",
> but I guess in theory we could make that distinction. (Conveniently
> there is no QMP action for "query current watchdog-action state",
> so we don't need to worry about reflecting that distinction in the
> QMP interface if we make it.)

I think that change is necessary in order to accomodate this sort of
watchdog with guest-progammable behaviour (which is part of the PAPR
spec, so we shouldn't just ignore it).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d5T3Ma41lV7ipIGd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmW3IkQACgkQzQJF27ox
2GePlQ//RD0iK5Wa/+3JFXiEtd4ZhDCys9XGKCDJcaC4iy75Qxkp60OfZ77T4Cch
HCfX3DaW4zE1kYZ7drPEPDLDPwEqXYWa/DB/j19CKCHmD1B2w5X3hLOgUCQG3lrv
gpwlnnVVxnm1CCrXWmvb6R1WcwIUCyAe70zj+5BWCPnZYx06qEj5CZ24cu/mn3qn
Ny5J/cOYWw01djmG+HEZBgEa6VuY/U05OYe3/mVWITkEtz4EWoIteoXaVN7hshkM
eKKkBQ+cHOHryl8Mfp9YRUXpEssTZvPh++xw1PehCtRUmAhVRCbkueTVjSdTUh6w
sRJkhHdU1P7r/5pb1Iu9V3gGZZnSFo2yxABB+N9tqJy6vcDm1gpuNPOMKAhlibGD
irm1ff0Q1MwnauyuJYLl1Y7R6/d+/cLCtxU7R9qtYrVKNm2+yMaVIbztC5xAFGTM
pd8eV5rYB2qPEXVV9NmFBwkzjeT8Uj3vkOPPiR/cu6EC/3G386WX5TUNKiV2OOm5
bOI9vei81s2SXy7+z48dPozDQxP4A8WrVbbVD+Ru027zPf9/zFYyBIAZ8eXL8fnq
7AhXVrOUTedZJAZ2XbBGsdX4i/nnM+/nI6k25yLwUP/lG+ZyYWmqn48TrSnghA7O
OIx+adyoiczuvbhVAQbKmmOxYDrsDWmaZmTdd8tZJ/qReK/DOKo=
=KTP9
-----END PGP SIGNATURE-----

--d5T3Ma41lV7ipIGd--

