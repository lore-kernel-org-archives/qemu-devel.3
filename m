Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2520EC9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 20:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhCiV-0005lq-1Q; Sat, 17 Jan 2026 15:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vhCiT-0005kP-Bg
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 15:16:13 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vhCiQ-0007dg-Tn
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 15:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768680949; x=1769285749; i=lukasstraub2@web.de;
 bh=WRxeN71DDAdXeHvvB8HsZ3l/kZum7/nXyy6PHgCeLR4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=osyNI61DYXpwwkVdbttgVhykL9cDQAotgpB1s6ObR1Pj1gO9H8WzHYTuoZjYyJpc
 YoFp0ZqNlXQ8NgrPS0OUUUGj6zVdeFu/7R2H645KA5BdcexxuD9Jnx1+jcs/pEIF4
 0XXJxPQqayHFlmjsp3SvyPH+pw9zVpEpH47nSNgKBg/2aJ9lgjpurc9R5F59eg8rJ
 DdKLoWQklIZFluMs7pRPjeuUlUdBBTUOf6fptWpR88ugt3o46S9HuBUvb5VDZsfKO
 DUkSnG4aDcrQ32Uzf4EnM1rMBjAYIWgYFHrIMw4Ep9iec0LLY6DaaCXiAbyyxfj+E
 YpsZ3YwPlFu9dzn2Bg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.100.70]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAcpW-1vWA5F2fN2-00B2UF; Sat, 17
 Jan 2026 21:15:49 +0100
Date: Sat, 17 Jan 2026 21:15:37 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>, Markus
 Armbruster <armbru@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, =?UTF-8?B?THVrw6HFoQ==?= Doktor
 <ldoktor@redhat.com>, Juan Quintela <quintela@trasno.org>, Zhang Chen
 <zhangckid@gmail.com>, zhanghailiang@xfusion.com, Li Zhijian
 <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <20260117211537.2ebdcb95@penguin>
In-Reply-To: <20260117204913.584e1829@penguin>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <aWlso1w39cQnEh2t@x1.local> <aWlxY9TWGT1aaMJz@gallifrey>
 <aWl6ixQpHaMJhV_E@x1.local> <20260117204913.584e1829@penguin>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/unqY_dVdA3nOUXZsUpSqZiw";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:bGcBWiBehwPa6ndzsEAxGdv/SZUd6wmekHW07OjQB9iAAANN9QF
 pp6eZiT091pTivVE2VWstRR8UrJpvgp8yv2Mvj9VhdU/m4WoTQ440HiE8nD5y7pTBmKeT5y
 EIfk4vBUWubvWxnbSLC4ZKJl8wwAEP618ah/5JuxyRQM9A2qJLPFkftqHgLfDTpnfkDnsAD
 pfsCaxE3LQlwYZWQmT/Kg==
UI-OutboundReport: notjunk:1;M01:P0:vLHfvQOppfM=;jaMHPhjs61p0q9g2syEkwyQE/sd
 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
 rP7/PhyrSTYlUS4+CDarcmTbcsCLt
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--Sig_/unqY_dVdA3nOUXZsUpSqZiw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 17 Jan 2026 20:49:13 +0100
Lukas Straub <lukasstraub2@web.de> wrote:

> On Thu, 15 Jan 2026 18:38:51 -0500
> Peter Xu <peterx@redhat.com> wrote:
>=20
> > On Thu, Jan 15, 2026 at 10:59:47PM +0000, Dr. David Alan Gilbert wrote:=
 =20
> > > * Peter Xu (peterx@redhat.com) wrote:   =20
> > > > On Thu, Jan 15, 2026 at 10:49:29PM +0100, Lukas Straub wrote:   =20
> > > > > Nack.
> > > > >=20
> > > > > This code has users, as explained in my other email:
> > > > > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@pengui=
n/T/#mc99839451d6841366619c4ec0d5af5264e2f6464   =20
> > > >=20
> > > > Please then rework that series and consider include the following (I
> > > > believe I pointed out a long time ago somewhere..):
> > > >    =20
> > >    =20
> > > > - Some form of justification of why multifd needs to be enabled for=
 COLO.
> > > >   For example, in your cluster deployment, using multifd can improv=
e XXX
> > > >   by YYY.  Please describe the use case and improvements.   =20
> > >=20
> > > That one is pretty easy; since COLO is regularly taking snapshots, th=
e faster
> > > the snapshoting the less overhead there is.   =20
> >=20
> > Thanks for chiming in, Dave.  I can explain why I want to request for s=
ome
> > numbers.
> >=20
> > Firstly, numbers normally proves it's used in a real system.  It's at l=
east
> > being used and seriously tested.
> >=20
> > Secondly, per my very limited understanding to COLO... the two VMs in m=
ost
> > cases should be in-sync state already when both sides generate the same
> > network packets.
> >=20
> > Another sync (where multifd can start to take effect) is only needed wh=
en
> > there're packets misalignments, but IIUC it should be rare.  I don't kn=
ow
> > how rare it is, it would be good if Lukas could introduce some of those
> > numbers in his deployment to help us understand COLO better if we'll ne=
ed
> > to keep it. =20
>=20
> It really depends on the workload and if you want to tune for
> throughput or latency.
>=20
> You need to do a checkpoint eventually and the more time passes between
> checkpoints the more dirty memory you have to transfer during the
> checkpoint.
>=20
> Also keep in mind that the guest is stopped during checkpoints. Because
> even if we continue running the guest, we can not release the mismatched
> packets since that would expose a state of the guest to the outside
> world that is not yet replicated to the secondary.
>=20
> So the migration performance is actually the most important part in
> COLO to keep the checkpoints as short as possible.
>=20
> I have quite a few more performance and cleanup patches on my hands,
> for example to transfer dirty memory between checkpoints.
>=20
> >=20
> > IIUC, the critical path of COLO shouldn't be migration on its own?  It
> > should be when heartbeat gets lost; that normally should happen when two
> > VMs are in sync.  In this path, I don't see how multifd helps..  because
> > there's no migration happening, only the src recording what has changed.
> > Hence I think some number with description of the measurements may help=
 us
> > understand how important multifd is to COLO.
> >=20
> > Supporting multifd will cause new COLO functions to inject into core
> > migration code paths (even if not much..). I want to make sure such (ne=
w)
> > complexity is justified. I also want to avoid introducing a feature only
> > because "we have XXX, then let's support XXX in COLO too, maybe some day
> > it'll be useful". =20
>=20
> What COLO needs from migration at the low level:
>=20
> Primary/Outgoing side:
>=20
> Not much actually, we just need a way to incrementally send the
> dirtied memory and the full device state.
> Also, we ensure that migration never actually finishes since we will
> never do a switchover. For example we never set
> RAMState::last_stage with COLO.
>=20
> Secondary/Incoming side:
>=20
> colo cache:
> Since the secondary always needs to be ready to take over (even during
> checkpointing), we can not write the received ram pages directly to
> the guest ram to prevent having half of the old and half of the new
> contents.
> So we redirect the received ram pages to the colo cache. This is
> basically a mirror of the primary side ram.
> It also simplifies the primary side since from it's point of view it's
> just a normal migration target. So primary side doesn't have to care
> about dirtied pages on the secondary for example.
>=20
> Dirty Bitmap:
> With COLO we also need a dirty bitmap on the incoming side to track
> 1. pages dirtied by the secondary guest
> 2. pages dirtied by the primary guest (incoming ram pages)
> In the last step during the checkpointing, this bitmap is then used
> to overwrite the guest ram with the colo cache so the secondary guest
> is in sync with the primary guest.
>=20
> All this individually is very little code as you can see from my
> multifd patch. Just something to keep in mind I guess.

PS:
Also when the primary or secondary dies, from qemu's point of view the
migration socket(s) starts blocking. So the migration code needs to be
able to recover from such a hanging/blocking socket. This works fine
right now with yank.

>=20
>=20
> At the high level we have the COLO framework outgoing and incoming
> threads which just tell the migration code to:
> Send all ram pages (qemu_savevm_live_state()) on the outgoing side
> paired with a qemu_loadvm_state_main on the incoming side.
> Send the device state (qemu_save_device_state()) paired with writing
> that stream to a buffer on the incoming side.
> And finally flusing the colo cache and loading the device state on the
> incoming side.
>=20
> And of course we coordinate with the colo block replication and
> colo-compare.
>=20
> Best regards,
> Lukas Straub
>=20
> >=20
> > After these days, I found removing code is sometimes harder than writti=
ng
> > new..
> >=20
> > Thanks,
> >  =20
> > >=20
> > > Lukas: Given COLO has a bunch of different features (i.e. the block
> > > replication, the clever network comparison etc) do you know which ones
> > > are used in the setups you are aware of?
> > >=20
> > > I'd guess the tricky part of a test would be the network side; I'm
> > > not too sure how you'd set that in a test.   =20
> >  =20
>=20


--Sig_/unqY_dVdA3nOUXZsUpSqZiw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmlr7ekACgkQNasLKJxd
sliznxAAnGvjCTGaAzsNUzowmiS2T4ptAuA2vlZ05GU9TZai7XQ1YRbXWtsBXtNH
QDqX+5qaDMn7N7cqcWCCBPXhDkxIrlWrtiX07kl+wrF8ydrJ9oeze+JiIWZoYJSc
Yl0Ff62L6mVYg/76JqbZ0Tzj5PVZHVOPMiQo8dz/UiPpc13+BW+UoOoWyV0GlNG2
Sq0PecPCzq1KKIASyG+50O/9lw2GkDXf9vOgFy3Fd/8REg7J98ltcmCDB/JkYSyA
Ce9ZJFNtkLv3KRa06ddS4N3nbeeTBfyI+sJogb8SooY0ehOn62whBU7Nc3IEjKiz
0Z5adG1OEwMiPE71qnbWfeu66l5/wN71j0ioqCx30DURI5iVP4cKG+O/emKNCxiv
UKqabCLaqUNfvpGyh4vImw+91jeSfvsN1fojjeHcemQWmYYv9dqllp6KCL2qEsUB
dprK6qQV6OC/oIpYtix1f1J9eDIOkikdt+1cJkmlHHkFIReyo4mdhyCNDV3acM3Y
uPRMqbZ4Y+Prvym1ADIPSrJu05vXtMedsXqxUDjMbkDW3X/vKarjmW6qO/qtS/aG
a12VVwIl3HN9B5DE5Gkh1u+f/JDk18DlMIXyU95SXCo9fVbpMbO3+oECKnyjNprO
DNBUlnkAJ8beu6bL97YA+9a4m/T7mro6tuG3IjUoJwnaSJQmab8=
=fkoR
-----END PGP SIGNATURE-----

--Sig_/unqY_dVdA3nOUXZsUpSqZiw--

