Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0A6D46627
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 22:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgVyi-0001w4-Q7; Thu, 15 Jan 2026 17:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vgVyf-0001vZ-7b
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:38:06 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vgVyd-0005KI-Lz
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768516678; x=1769121478; i=lukasstraub2@web.de;
 bh=tVV3Or7iGNjpE396pn3E6elXCh8LpRsZldrsyI9WDR0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=klXMnhm2qvb7TXcbBMRfqft7n+3YTekGTXaZvUb9of2xUhjvopugsxTUWD3cyFDM
 GJTH/QQpJ9MryRafsfDu/V7ZDlzyDWxHl1uphClh12rGSp9E+UuERwn4NeCY6h6qT
 IlR7CPCFfftc0lszxYlsoIBBc+fyBhGfVxl73+xz3tVX9LsYkwP7zortsAvimKddd
 7EQi/yuZyLRAJZpuTsBi8VSLMEi2xmYqi4a/Q6Y18EPE05FxGprYTKmW/sucXZ5Wf
 INVrw0P/lIDlMuuvH4imkrRAoLxzEsuctFdeGScdH6NGx8KpWHZRsuZpQyhxQWS5O
 cHHBcr4N1j2i0MGIng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.100.70]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq1CA-1wBzBn38Zm-00i5MI; Thu, 15
 Jan 2026 23:37:57 +0100
Date: Thu, 15 Jan 2026 23:37:55 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>
Subject: Re: [PATCH 2/3] migration-test: Add -snapshot option for COLO
Message-ID: <20260115233755.0d409373@penguin>
In-Reply-To: <aV1otmGc76_KzZMv@x1.local>
References: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
 <20251230-colo_unit_test_multifd-v1-2-f9734bc74c71@web.de>
 <aV1otmGc76_KzZMv@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TIG6TlkvbROWyC5K84ovprw";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:9QPDiPn+VfqOCnTet6EakxlkyfbHUpNZS8mNw5CCOluhrM/broi
 l2x1WdVF5N0P5ibUtk5kJrYYkenfQxaxpYDnTAOZHO3GK6VnTcF1tS7WNT/r5jafrePPNyF
 SEiMW0enVDVaJQLsaqCprlqm5VvnuRdDfLSnSFneK9Aw9/znJvdjquZYM82cO+TlZ5Yhafb
 UfRKGDslT+vVC1GVMepkQ==
UI-OutboundReport: notjunk:1;M01:P0:tUFJWWo+E6w=;jmylunDnzeBaoBSYgfOuHLa/cpJ
 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
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
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

--Sig_/TIG6TlkvbROWyC5K84ovprw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Jan 2026 14:55:34 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Tue, Dec 30, 2025 at 03:05:45PM +0100, Lukas Straub wrote:
> > For the COLO test, both VMs will run in parallel. Thus both VMs want to=
 open
> > the image read/write at the same time. Using read-only=3Don is not poss=
ible here,
> > because ide-hd does not support read-only backing image. And the image
> > won't boot with ide-cd.
> >=20
> > As a workaround, use the '-snapshot' option where qemu will internally =
create
> > a writable snapshut while leaving the real image read-only.
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  tests/qtest/migration/framework.c | 4 +++-
> >  tests/qtest/migration/framework.h | 1 +
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/=
framework.c
> > index e35839c95f51d851a3fed8e8457ed2d7e927f59b..8c1fc6e009f16dc05a47e91=
7167f62e0250ca992 100644
> > --- a/tests/qtest/migration/framework.c
> > +++ b/tests/qtest/migration/framework.c
> > @@ -322,7 +322,9 @@ int migrate_args(char **from, char **to, const char=
 *uri, MigrateStart *args)
> >          }
> >          arch_opts =3D g_strdup_printf(
> >              "-drive if=3Dnone,id=3Dd0,file=3D%s,format=3Draw "
> > -            "-device ide-hd,drive=3Dd0,secs=3D1,cyls=3D1,heads=3D1", b=
ootpath);
> > +            "-device ide-hd,drive=3Dd0,secs=3D1,cyls=3D1,heads=3D1 %s",
> > +            bootpath,
> > +            args->is_colo ? "-snapshot" : ""); =20
>=20
> We can use opts_source / opts_target for this.

Okay, I will fix this in the next version.

>=20
> >          start_address =3D X86_TEST_MEM_START;
> >          end_address =3D X86_TEST_MEM_END;
> >      } else if (g_str_equal(arch, "s390x")) {
> > diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/=
framework.h
> > index ed85ed502dd01aa809892b68d3934b5107bd3442..2ea13e7758697550b553173=
7e66d6d939dd800d1 100644
> > --- a/tests/qtest/migration/framework.h
> > +++ b/tests/qtest/migration/framework.h
> > @@ -134,6 +134,7 @@ typedef struct {
> >      bool suspend_me;
> >      /* enable OOB QMP capability */
> >      bool oob;
> > +    bool is_colo;
> > =20
> >      /* Do not connect to target monitor and qtest sockets in qtest_ini=
t */
> >      bool defer_target_connect;
> >=20
> > --=20
> > 2.39.5
> >  =20
>=20


--Sig_/TIG6TlkvbROWyC5K84ovprw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmlpbEMACgkQNasLKJxd
slgpPw/+M/H26tSMhUQBrvgMoR86T0Mvd9ahjgD/x1y41arV52t0+aVg8wXneX9T
mos8TpSPhdtFkm2oIkm2B0upf65ZUrnXvN47my/a5DiIIT2/pwPxf1WtQrIfxnHC
UnTxMpiUtCvAP976XwX48gvCyuRGxvkpcGAs4DZNKVVY3P5zXPrF5g5IO7iB81Y0
l2MSXiJe+aqW7ajWDB071nb6do6rzV0ev0PnpbxlEfas00JrZK69T8BmCcrAjqK1
jBULVHC+JO0K2clNVzFkEot3c4WnvQ6JTtP0LRHsEYTWMXakfuv2fZX8g0ta5iuu
EZr0XoEzN1PfDAQeRS8ptY2yNoFGlvlbSJqsmyj+lTQ3OwNHhA2oeR/2Go7WQ/vn
irlDZqR/zRB/evhXe5SBL+D8AOPnhCF9f0zt6m7CTcpldX1wKIqe8jpcHr3xCK/I
AvaWTspRTRIAgCaIya5kUOKP0pZLzKxF2UKgLs819CnypK86ZJj0REjPq++TIaeS
KiWmBsX8I7SErdcjBZkylsO2NTrgizBNS8Wu9sDrjIm7CAmAi/RBVC5jJKlyk6Ut
Ey6Ihty1w8JXvLjYoc8bEUAJkJ1hVfpK4iBqQn2hPRKGpLmurJM6CZ/J4XA55jya
+bJhj6mNaFWxyGKL+Jdl5bW4v/LX4iv0xFUjMVzWjnwYEKVx4vA=
=OneB
-----END PGP SIGNATURE-----

--Sig_/TIG6TlkvbROWyC5K84ovprw--

