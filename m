Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C100C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukH84-0007Rg-G4; Fri, 08 Aug 2025 03:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1ukH7Q-0006I8-VU
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:02:29 -0400
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1ukH7N-0005IV-GO
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1754636539; x=1755241339; i=lukasstraub2@web.de;
 bh=kY6T+IZFgTz+axUmLBc82MZSUu7k7YkgyARXRj7Umog=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lDbBZG2nOzuRMYPLdqg2MHFYGXe9c8o8F3telhR5maaSAgNmo1XC9mp4m44buo2T
 Rux9IjwfdyAkUWXc0DL9SmZgqx1q4UmSV1zHsWFMulXBPt+gkkNKudv4s9gfKcU3P
 pcu1WFNGutwMlyRHKFmFyC2T13EmmHhMqB44QUfgEkVQv6T+AFSsRkktA2HsrfEIf
 udtjTUcHypJqhZqu4H/mHRvvLngxssAicXaUsgfSMUThh0z/LcygiEJrD3ZHS9KsG
 wU00hdTUyvx/A4H+wlY1qRWBP/Va5x8iGXtkM4JXSy8usmcyjgEAvekaveyfhP6Ck
 UWnJy2XI4xcnwuqYXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([84.133.41.102]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MEUS0-1urPyS439W-009la4; Fri, 08
 Aug 2025 09:02:19 +0200
Date: Fri, 8 Aug 2025 09:01:28 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
Message-ID: <20250808090054.13cb8342@penguin>
In-Reply-To: <CAK9dgmZb=5uEwVq65Ygcza0+qtng+-5zmtQRdviX2npg_qhJRQ@mail.gmail.com>
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
 <20250807113639.66d1c5bf@penguin>
 <CAK9dgmZb=5uEwVq65Ygcza0+qtng+-5zmtQRdviX2npg_qhJRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gGnbYV52kAMFXmtUKey=5gD";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:0NCxLzQKIB0Q5dZntbybBzCPY3cBJdN3bmSq8do5aCWSU+1pSKv
 x7YTpBG8mDPtNAF+j7SU71isROgcFoT6p66SdZm6345vsFFTM4HjRLJROPgCCRr/WmehcDc
 GoATFUmal5N+Ho8CEIVzL9KzyvAUACZFaoRIZSzLFjHwqbq5vt00vN6o+x9SR7+MwVsypEN
 A1Nrq195LF5lQGRxLanRg==
UI-OutboundReport: notjunk:1;M01:P0:6+rbDfXhPDo=;7gEr7GbRWinIO811IFn9YxQvMtO
 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
 bcNYKFidZjKhMU/vXw7LigEFnGrB6dHk=
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--Sig_/gGnbYV52kAMFXmtUKey=5gD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Aug 2025 10:36:24 +0800
Yong Huang <yong.huang@smartx.com> wrote:

> On Thu, Aug 7, 2025 at 5:36=E2=80=AFPM Lukas Straub <lukasstraub2@web.de>=
 wrote:
>=20
> > On Thu,  7 Aug 2025 10:41:17 +0800
> > yong.huang@smartx.com wrote:
> > =20
> > > From: Hyman Huang <yong.huang@smartx.com>
> > >
> > > When there are network issues like missing TCP ACKs on the send
> > > side during the multifd live migration. At the send side, the error
> > > "Connection timed out" is thrown out and source QEMU process stop
> > > sending data, at the receive side, The IO-channels may be blocked
> > > at recvmsg() and thus the main loop gets stuck and fails to respond
> > > to QMP commands consequently.
> > > ... =20
> >
> > Hi Hyman Huang,
> >
> > Have you tried the 'yank' command to shutdown the sockets? It exactly
> > meant to recover from hangs and should solve your issue.
> >
> > https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#yank-feature=
 =20
>=20
>=20
> Thanks for the comment and advice.
>=20
> Let me give more details about the migration state when the issue happens:
>=20
> On the source side, libvirt has already aborted the migration job:
>=20
> $ virsh domjobinfo fdecd242-f278-4308-8c3b-46e144e55f63
> Job type:         Failed
> Operation:        Outgoing migration
>=20
> QMP query-yank shows that there is no migration yank instance:
>=20
> $ virsh qemu-monitor-command fdecd242-f278-4308-8c3b-46e144e55f63
> '{"execute":"query-yank"}' --pretty
> {
>   "return": [
>     {
>       "type": "chardev",
>       "id": "charmonitor"
>     },
>     {
>       "type": "chardev",
>       "id": "charchannel0"
>     },
>     {
>       "type": "chardev",
>       "id": "libvirt-2-virtio-format"
>     }
>   ],
>   "id": "libvirt-5217"
> }

You are supposed to run it on the destination side, there the migration
yank instance should be present if qemu hangs in the migration code.

Also, you need to execute it as an out-of-band command to bypass the
main loop. Like this:

'{"exec-oob": "yank", "id": "yank0", "arguments": {"instances": [ {"type": =
"migration"} ] } }'

I'm not sure if libvirt can do that, maybe you need to add an
additional qmp socket and do it outside of libvirt. Note that you need
to enable the oob feature during qmp negotiation, like this:

'{ "execute": "qmp_capabilities", "arguments": { "enable": [ "oob" ] } }'

Regards,
Lukas Straub

>=20
> The libvirt migration job is stuck as the following backtrace shows; it
> shows that migration is waiting for the "Finish" RPC on the destination
> side to return.
>=20
> ...
>=20
> IMHO, the key reason for the issue is that QEMU fails to run the main loop
> and fails to respond to QMP, which is not what we usually expected.
>=20
> Giving the Libvirt a window of time to issue a QMP and kill the VM is the
> ideal solution for this issue; this provides an automatic method.
>=20
> I do not dig the yank feature, perhaps it is helpful, but only manually?
>=20
> After all, these two options are not exclusive of one another,  I think.
>=20
>=20
> >
> > Best regards,
> > Lukas Straub
> > =20
>=20
> Thanks,
> Yong
>=20


--Sig_/gGnbYV52kAMFXmtUKey=5gD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmiVoMgACgkQNasLKJxd
slhCIw/+L7wpy4/nO2ywrnXgorAUIzG3VamIUGc4JWamAJmUja+M3ajCk7x2gs1J
mh44WXjs8dbsEPS/2/NmY5637dPR8V8siuFA9ZJ6HcyePGw9Q6Put58FuH2JOgiM
CYgH7aqY9wYHJ2dSxdj1SfJ/QW9gOnz61YxUKe6izj0Mo8uWmnyZgE7TOZWEgLrm
LpxBhcTZ2ed7FUtJ+RWx4hzDaXt2Cck+qx2WrxwFM2zXrOM8IqoK/GEMr7+VU3wk
pMOWjZcAziab6Z56dg5Uzgq3Q0f+ygUCKoOXLVlAyegW7XSMKfkXnXagN8VAtGzX
ncEOEWuQV3FStXcheFSWMqEt/gI4GXc7mpZEH81MGszmjtDNxHggYUtMjSnglkmZ
laJuKT1WJxnbKNkCmLG8T3UKh0dxMCIHnH1SbQ+q1ksYqw97FUGQS2zQCSNIexf1
VVDvHzcR69FFJW6d1eftlck8bB37tqHoK6pashpL+DqCo+GUrwCKPSYZWWQd7So9
Jt1JFc42WWuAFNfOJgbHRaXcLXYpRKgiCB4nR4J37/mE+C7F+XY0oxWnd6cOR8yx
QUL1IlQwh9X5UWL09wWBdzzr61mUhhF80Br6q2EoKbjEYMxJ0By4AQLg/wL5U0Ly
HWtgUnSBE16BK/i0SqSK4s+VCh3uhvoc1dEObKWks8a4VRH/v1w=
=bQOW
-----END PGP SIGNATURE-----

--Sig_/gGnbYV52kAMFXmtUKey=5gD--

