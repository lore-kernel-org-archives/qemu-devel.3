Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC57AC9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 19:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhCJA-0004jL-5r; Sat, 17 Jan 2026 14:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vhCJ8-0004ij-Ph
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 14:50:02 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vhCJ6-0003Dw-2N
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 14:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768679381; x=1769284181; i=lukasstraub2@web.de;
 bh=PjczWz/ba7Wi2D37hrw5WftzuO51wsnQ48NvfsxW7p8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RcxoZgLFJfj9EnTNbm/drDnQRqpL1rq/Is5zL7XY9Uvk0bCkdBFUAjHvU2x5QHFa
 dG1aH8MHpZVZa+hOyvXFt6kCf2sjCkPRVv8SdYuewN8z+UeHsbVW69/xj+Ae3yYSX
 Mbo/EW4njlYqPVT6KTll+2Ub3Q3Rx4sX5lMlqX5j+/LxeyEKit+DQ2Q6tN2R/pYoi
 /mqeFEo/UVd+11UdOz838GB/YHDIc2QJX6FesSz/E+Y0PjxK0FGN4plV2AWxv/s6y
 7dH6lkEHQA/osLzovSHzQ8SbaRGg06yHpAmhfm9/DVuuvP4Ac5kDY1xzST8iU/rbc
 ZDfBRX7sjcqiyMSB/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.100.70]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1aHx-1veB6E2YZP-0033Il; Sat, 17
 Jan 2026 20:49:41 +0100
Date: Sat, 17 Jan 2026 20:49:13 +0100
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
Message-ID: <20260117204913.584e1829@penguin>
In-Reply-To: <aWl6ixQpHaMJhV_E@x1.local>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <aWlso1w39cQnEh2t@x1.local> <aWlxY9TWGT1aaMJz@gallifrey>
 <aWl6ixQpHaMJhV_E@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/V_9OQo1NDHngLGwL7jCZxei";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:9aWNVt+S3Yb5isReF3RrBo+Ae1N2il1RP8lgOAGLtxXv5dWlpZu
 5h4ReuSSLuRijDHXqOD7pTO+vE1VkuI+I6s8cwXpd9lOrVsY/JUcg5M9RrLLbZvIE703Vkt
 hnhcokSL7xbZVLfempTezhwrPcTJ7xmqiIqoCM5EYNQdv7IVEm64/35nChYwTzJceA3aN+i
 TGdyS2StSLToN4XMhYHwQ==
UI-OutboundReport: notjunk:1;M01:P0:rUPJE6dSfnM=;EdFv1JSBALThNQH/Di1fNawoB6i
 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
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--Sig_/V_9OQo1NDHngLGwL7jCZxei
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Jan 2026 18:38:51 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Thu, Jan 15, 2026 at 10:59:47PM +0000, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote: =20
> > > On Thu, Jan 15, 2026 at 10:49:29PM +0100, Lukas Straub wrote: =20
> > > > Nack.
> > > >=20
> > > > This code has users, as explained in my other email:
> > > > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/=
T/#mc99839451d6841366619c4ec0d5af5264e2f6464 =20
> > >=20
> > > Please then rework that series and consider include the following (I
> > > believe I pointed out a long time ago somewhere..):
> > >  =20
> >  =20
> > > - Some form of justification of why multifd needs to be enabled for C=
OLO.
> > >   For example, in your cluster deployment, using multifd can improve =
XXX
> > >   by YYY.  Please describe the use case and improvements. =20
> >=20
> > That one is pretty easy; since COLO is regularly taking snapshots, the =
faster
> > the snapshoting the less overhead there is. =20
>=20
> Thanks for chiming in, Dave.  I can explain why I want to request for some
> numbers.
>=20
> Firstly, numbers normally proves it's used in a real system.  It's at lea=
st
> being used and seriously tested.
>=20
> Secondly, per my very limited understanding to COLO... the two VMs in most
> cases should be in-sync state already when both sides generate the same
> network packets.
>=20
> Another sync (where multifd can start to take effect) is only needed when
> there're packets misalignments, but IIUC it should be rare.  I don't know
> how rare it is, it would be good if Lukas could introduce some of those
> numbers in his deployment to help us understand COLO better if we'll need
> to keep it.

It really depends on the workload and if you want to tune for
throughput or latency.

You need to do a checkpoint eventually and the more time passes between
checkpoints the more dirty memory you have to transfer during the
checkpoint.

Also keep in mind that the guest is stopped during checkpoints. Because
even if we continue running the guest, we can not release the mismatched
packets since that would expose a state of the guest to the outside
world that is not yet replicated to the secondary.

So the migration performance is actually the most important part in
COLO to keep the checkpoints as short as possible.

I have quite a few more performance and cleanup patches on my hands,
for example to transfer dirty memory between checkpoints.

>=20
> IIUC, the critical path of COLO shouldn't be migration on its own?  It
> should be when heartbeat gets lost; that normally should happen when two
> VMs are in sync.  In this path, I don't see how multifd helps..  because
> there's no migration happening, only the src recording what has changed.
> Hence I think some number with description of the measurements may help us
> understand how important multifd is to COLO.
>=20
> Supporting multifd will cause new COLO functions to inject into core
> migration code paths (even if not much..). I want to make sure such (new)
> complexity is justified. I also want to avoid introducing a feature only
> because "we have XXX, then let's support XXX in COLO too, maybe some day
> it'll be useful".

What COLO needs from migration at the low level:

Primary/Outgoing side:

Not much actually, we just need a way to incrementally send the
dirtied memory and the full device state.
Also, we ensure that migration never actually finishes since we will
never do a switchover. For example we never set
RAMState::last_stage with COLO.

Secondary/Incoming side:

colo cache:
Since the secondary always needs to be ready to take over (even during
checkpointing), we can not write the received ram pages directly to
the guest ram to prevent having half of the old and half of the new
contents.
So we redirect the received ram pages to the colo cache. This is
basically a mirror of the primary side ram.
It also simplifies the primary side since from it's point of view it's
just a normal migration target. So primary side doesn't have to care
about dirtied pages on the secondary for example.

Dirty Bitmap:
With COLO we also need a dirty bitmap on the incoming side to track
1. pages dirtied by the secondary guest
2. pages dirtied by the primary guest (incoming ram pages)
In the last step during the checkpointing, this bitmap is then used
to overwrite the guest ram with the colo cache so the secondary guest
is in sync with the primary guest.

All this individually is very little code as you can see from my
multifd patch. Just something to keep in mind I guess.


At the high level we have the COLO framework outgoing and incoming
threads which just tell the migration code to:
Send all ram pages (qemu_savevm_live_state()) on the outgoing side
paired with a qemu_loadvm_state_main on the incoming side.
Send the device state (qemu_save_device_state()) paired with writing
that stream to a buffer on the incoming side.
And finally flusing the colo cache and loading the device state on the
incoming side.

And of course we coordinate with the colo block replication and
colo-compare.

Best regards,
Lukas Straub

>=20
> After these days, I found removing code is sometimes harder than writting
> new..
>=20
> Thanks,
>=20
> >=20
> > Lukas: Given COLO has a bunch of different features (i.e. the block
> > replication, the clever network comparison etc) do you know which ones
> > are used in the setups you are aware of?
> >=20
> > I'd guess the tricky part of a test would be the network side; I'm
> > not too sure how you'd set that in a test. =20
>=20


--Sig_/V_9OQo1NDHngLGwL7jCZxei
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmlr57oACgkQNasLKJxd
sljG0A/9G90HMtiR0zebleuE24v8JCipuHxHBXZyvm26D5Xp+wrwAHAUZ+2/vA/u
IF2ZX+BRj7Mqrw8/VvYOSaYELgW1/X+xNrCqcsy7zHnAyuq8yzjB35cEFWn9ncOU
ELzA3TnGzKueW4b7Ez7fd1+LztT8a5v2L9X4cVrfT9Q/ODv0RyACGCc1YlMvlWH0
Ynloh8UKKZAHtXPTn5MYFdth5/b8Yd6lLE8OT2wqRw4LUTvYEzSyekAGVmV/dMe+
Tjn9pLV3Nr5xfoV/mdRoboQ3YkCIROogtf7tO2eExEyJVSuOnCiOzXaRjMgMeNAI
m+6S5ts3EAGVsZwCpuS1cb/8jm+wo72oUScXPiBmyJkrBhS6aCrsAhbFck7QEhq9
Fyz47NjpqQMAWDSAcH6xrvyltWIzYIShnZtg8Y0PxLeMwvWEqiLfFBQTL+eweXQn
pfEFT1vxJ6xq/c6jDkAvaEp0xmf2Nw4R3xWKeMFrAyo2ihw82f0Dqcs4VS/Xh1l6
SDRwcfDQRpeRXEiyVW+I7IsfF76mnKnAP5uFs05zep1yHUVm1PRCJQHc74XhHquj
euCDICS6+QwHV2OFAlxMXoQJlGPaSo2eaMvdxoRGdnzt9bgADUxxLupfCMF+O0Cu
V1JhTFcZPPwOT3AhZsqe/yEp09ZsncuDLfXup7fKrx3j2YwpgsQ=
=emU4
-----END PGP SIGNATURE-----

--Sig_/V_9OQo1NDHngLGwL7jCZxei--

