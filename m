Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19799E8306F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 09:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnCfX-00055p-0c; Tue, 03 Feb 2026 04:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnCfV-00051T-9W
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 04:25:57 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnCfT-0007WF-Jt
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 04:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770110748; x=1770715548; i=lukasstraub2@web.de;
 bh=KimShHiFnCpHv8wKzcePDlciUwe+jClbgUSdBXLo+FA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rb2guCDcRCePrPCrc30UPWDDs6hhYG/yvacXFa7xsDhK5aAJ4g8uwIw1w9sDM7IY
 NZffZWRkHNGNZDwm0vg0KgknjdJFUdJEUp4bPxim5g4Ug6CeivW3tRcGy2w/xjcgc
 aX802MXHFbPA5JJhTF+vrqrMiPZ6xmo+q6Mhkrzmnmq1yhm3lJClbJIgtZF+hobRE
 xi9nrBVrCVUTzEXxxVmqtB4R0KHNWyNQm1uBPxPc1sU9m6XDONK24sxIZIrH2PRuG
 W/cr/Vxtln3EWj/Z6fZQE4pGI61jDAHdPelMdSXte/GCMvKEVYG3RCxDCERntWE3b
 ZFLJO6U0SSdUD+NGOQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjxiM-1vOpDI28VM-00brFd; Tue, 03
 Feb 2026 10:25:48 +0100
Date: Tue, 3 Feb 2026 10:25:46 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 05/10] colo: Fix crash during device vmstate load
Message-ID: <20260203102546.5552be86@penguin>
In-Reply-To: <aYCw0Qz_OQwlUrjM@x1.local>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-5-ae926ccd8eae@web.de>
 <aXkiX-jvFOieE9FG@x1.local> <20260130134942.721a2758@penguin>
 <aYCw0Qz_OQwlUrjM@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZDYzr+VR1x4ZbaZYp2o9uIp";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:NJtaEb4pwojb9DqGTiGxvgfTG54HeXUVei2eUqxnYMaVKMrhWRL
 ho76UV9YLBFrgcr/Cd7sUUJsRAps/XL4TPA3BczqtlMku75uLU7uG0/WaxuAgUWrqhqtzuT
 iY+Ktx9mO+spa50x2QSf4XWlo711WMoVXDymyjsjd+z1a38f/XJ1CHpbKlfqr8nbsbIxinL
 3j0vRV9wnMWS844/gYChQ==
UI-OutboundReport: notjunk:1;M01:P0:zCanBBBNfuE=;3qahGCsfUlU/ERy7OawY9tvHoF/
 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
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

--Sig_/ZDYzr+VR1x4ZbaZYp2o9uIp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Feb 2026 09:12:33 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Fri, Jan 30, 2026 at 01:49:42PM +0100, Lukas Straub wrote:
> > On Tue, 27 Jan 2026 15:38:55 -0500
> > Peter Xu <peterx@redhat.com> wrote:
> >  =20
> > > On Sun, Jan 25, 2026 at 09:40:10PM +0100, Lukas Straub wrote: =20
> > > > With colo we load device vmstate during each checkpoint, on top of
> > > > a vm that was already running. Some devices expect a reset before
> > > > loading vmstate on such a previously running vm.
> > > >=20
> > > > This fixes a crash when using COLO with Q35 machine.
> > > >=20
> > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>   =20
> > >=20
> > > Yes makes sense, maybe you can add some comments into the code too si=
nce
> > > this was overlooked before,
> > >=20
> > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > >=20
> > > Have you tried to measure how many overheads will this introduce to l=
oading
> > > each snapshot? =20
> >=20
> > It's a large overhead actually, between 10-20 milliseconds. =20
>=20
> This can be mentioned in the commit message.
>=20
> IIUC reset() may or may not be required while loading a snapshot.
> Normally, a device reset() should reset all dev registers and internal
> states, OTOH loadvm() will reload most of them once more.. so less
> efficient.
>=20
> Maybe there's chance to "fix" q35 instead reducing this overhead, but I'll
> leave that to be your call; to me this fix is clean from maint POV.
>=20
> Thanks,
>=20

Yes, I think this fix is fine for now. It more correct like this and we
can improve performance later while keeping it correct.

Regards,
Lukas Straub

--Sig_/ZDYzr+VR1x4ZbaZYp2o9uIp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmBvxoACgkQNasLKJxd
slgL7A/+JR+2QAaExy995T9rfQc+llid07bTlsOWM3zoDy4geYY2zKdm/VXUFwzn
jqhNHFRv1jKYll249XoEb2UeaRxWWsjjcn/rzu1M80C+5C891l/GUJSc/Q0T/xRy
GDcHcpXiyF654EhlLNdAMfvUV4ksD487ioPe10lC2kE+SrDMGJgagiN9hEL0i8Pn
8PZYlfODxCU8W4sn/x2ZuhKZyWzOr+GqjDHak9OirRDEjcHlvOAfdU1FfebX2njC
hbRrjom3ez4a55YX3xNWoQ0ZYkqphTBZj6gfmALglNLovxjJU/1geG3ENUj/u7DA
8X04r6xpKnYpEN6uY/TFwljDDcddSzvda70iSJi1Jhvgvrdjh73EYJHwRMYp7aEy
D+08amn1nwCJaecKqiT4rRnGpL4U/kza4zf8KTBY813oF7UZPU/2ENyKDnpU6dcR
5aU0MWt/Ox86WA/r6x7Th4iNWHGlND4pHDOtywy1F/z1NMG3ZbPZ1UWP0Z4Z+Sgs
yBG9rLS4ljzs0sEPLNNpunuBYPTeGwG7qJhJVw151cu36DziDDwwhubkZ1/VZUmO
4QyPVNyx7HTpyuOTy9fygqVZXM7K6L9X6VA6fnSY24FmUjRBoftxNC5GtsoNQaXR
O4AxPbmQLS/gdpla5nxjK8MJipbczFAziNXMb+wDh+n6QirLIUc=
=zm3g
-----END PGP SIGNATURE-----

--Sig_/ZDYzr+VR1x4ZbaZYp2o9uIp--

