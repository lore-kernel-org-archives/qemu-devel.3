Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D248CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 12:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoL4D-0000ei-I4; Tue, 19 Aug 2025 08:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1uoL4B-0000eL-LZ
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 08:03:51 -0400
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1uoL47-0003Rh-RY
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 08:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1755605023; x=1756209823; i=lukasstraub2@web.de;
 bh=7QshgWLYNC7rWltHMyISJm1anLRBWO0Omw5fT9PAK9I=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=sySbSSza5/IO+nad7gBn/yAQdda80c9FUKb2DwDRj66GA1dfS/eYruKXLkWMJKoS
 TGeJupuZ41+0n9yNFC/GkoXbtPSB0/ASiU5ETa0/DTpsgQpJHNcL3PaeShi7jwKeW
 KibRNXNerXgJQwd0MpLr4B8i6RV3pP0Cb5IFt9rg36XlPYGJE8ahKGLqeMAuVlZBQ
 4u9Byy0yksEvsGDr+THszLc4782erCGQGf4Sd5s6kLO7LD5aEj6oRiHbgMRlLS8Ce
 q3vPRQSP9JkHCHjMuerc/xRsjU9Pn37VQa1vPMz+hqXkgsDOBHPlrJ+ZYGSetRjnt
 cNm6j6jfN9fMoRzNzg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([89.246.98.69]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKtN-1uMiPM11lz-00gCQS; Tue, 19
 Aug 2025 14:03:43 +0200
Date: Tue, 19 Aug 2025 14:03:26 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, Yong
 Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
Message-ID: <20250819140326.6e94b1c9@penguin>
In-Reply-To: <aKRSZ7jCfIzvv4jW@redhat.com>
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
 <20250807113639.66d1c5bf@penguin>
 <CAK9dgmZb=5uEwVq65Ygcza0+qtng+-5zmtQRdviX2npg_qhJRQ@mail.gmail.com>
 <20250808090054.13cb8342@penguin>
 <CAK9dgmbybw+WkC2C_qdZnwSYjGn3Q2Du4yjLOz+EmCx1po8YPg@mail.gmail.com>
 <87o6sp2a0i.fsf@suse.de> <aJYZs9NnAOqVMcd1@x1.local>
 <20250811090345.4360fec4@penguin> <878qjq0xtk.fsf@suse.de>
 <aKRSZ7jCfIzvv4jW@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/skG8F5GyFx8xFmY_goIeBUq";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:SrEqgFenrTYXgDUFAe3kXsmji4snmfm4BobBUc7wvlb5YqYgLEG
 7yBDysM7lltxDpEQ78ZiuU5y7ju0VXz2mmvpxgWyxUxqENmFl/b1iUIM17659Clz3o1cI81
 DyfyVQSXjqKQ1jTrkx7qvm/xNaEfSKNyxNBSZiiZOKPp3vXjguErF0bdSZwKZ51YAiAgbuy
 G6Umxtm00iKOhA+3prIqg==
UI-OutboundReport: notjunk:1;M01:P0:QjAzeZJZXho=;9R33dPPsjfB47UDUXu09WT0m1nf
 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
 JJxP83qroABgIXAAYCi2yrnoLZdb
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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

--Sig_/skG8F5GyFx8xFmY_goIeBUq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Aug 2025 11:31:03 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, Aug 11, 2025 at 10:53:11AM -0300, Fabiano Rosas wrote:
> > Lukas Straub <lukasstraub2@web.de> writes:
> >  =20
> > > On Fri, 8 Aug 2025 11:37:23 -0400
> > > Peter Xu <peterx@redhat.com> wrote:
> > >> ...
> > >> migrate_cancel() should really be an OOB command..  It should be a s=
uperset
> > >> of yank features, plus anything migration speficic besides yanking t=
he
> > >> channels, for example, when migration thread is blocked in PRE_SWITC=
HOVER. =20
> > >
> > > Hmm, I think the migration code should handle this properly even if t=
he
> > > yank command is used. From the POV of migration, it sees that the
> > > connection broke with connection reset. That is the same error as if =
the
> > > other side crashes/is killed or a NAT/stateful firewall in between
> > > reboots.
> > > =20
> >=20
> > That should all work just fine. After yank or after a detectable network
> > failure. The issue here seems to be that the destination recv is hanging
> > indefinitely. I don't think we ever played with socket timeout
> > configurations, or even switching to non-blocking during the sync. This
> > is actually (AFAIK) the first time we get a hang that's not "just" a
> > synchronization issue in the migration code. =20
>=20
> Based on the stack trace, whether the socket is blocking or not isn't a
> problem - QEMU is stuck in a  sem_wait call that will delay the coroutine,
> and thus the thread, indefinitely. IMHO the semaphore usage needs to be
> removed in favour of a synchronization mechanism that can integrate with
> event loop such that the coroutine does not block.
>=20

I don't think that is an issue. The semaphore is just there to sync
with the multifd threads, which are in turn blocking on recvmsg.

Without multifd the main thread would hang in recvmsg as well in this
scenario.

Best Regards,
Lukas Straub

--Sig_/skG8F5GyFx8xFmY_goIeBUq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmikaA4ACgkQNasLKJxd
slj7QQ//VjUbDsvH30KamHBhOPlT2dkbAmOvuXPergJQl5Bp7vpkAvY8FMED6mBc
85Kt+mGBw/0gWsXQXnbjrozVF7fDYhNB6UHRMXtSnuA5OsjOXY5EpsVO+vnytt8A
MjvS8DyDXDckZHzfoRsAtHUmuoH3s3aB05wJN44EqQAANPAB+SZJSBEgnLeP1gei
Ty+jZ9/bKnToeTkaEPZvptkVbscmkGEPEsawqev4XurfMGof32aYeRFd2I4Jmgh3
da317dpv6rm2TbPnrz06ZuoMOSaRaFM4eUm1rVfNS1eLecmj+i5QDHyK3KRrUt5t
sq4DeWImxoG246j3xcY5swqCi/Xwlb/7sXdlkgM1VXtkHPrABGX/DKd9jO9WpMLF
KRCp5xWGRw4XfyvVwmYHKy9+U8VZ3JyYwW5yJ8SjXvfXT+jxfAVZTX5Ev+TdsQqz
Ue845Ew4Hc/Z0eRMtuc7Fec44ULXjhEkRMjugzts3tCe4AIbF0IXAjTO91NwkxSb
ojQ738gtEb7ikITwqQ15m1WPUdfhtg4rKDdUKWnOimmEZSWqmeOt0AlnjiH9qhS+
RUdTkkFZiHowVCyL027nQzJXwvX51t6dwAHrz97qRmxh0+g/Il2vJhC/QnvVFPYk
PeWeYtPyNFGttvb9hBn2WPelYrHfPeoWaTafBpdAQd6NvR6/eQE=
=1N1F
-----END PGP SIGNATURE-----

--Sig_/skG8F5GyFx8xFmY_goIeBUq--

