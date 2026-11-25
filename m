Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35877606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.a=rsa-sha256 header.s=fm3 header.b=ORY1GmZb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LmKX9SbE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWDlG-0003wr-6c; Wed, 25 Nov 2026 09:14:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1xWDkr-0003w6-Sp
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 09:13:52 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1xWDkp-0008LV-MG
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 09:13:49 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 966DC7A0510
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 09:13:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 25 Nov 2026 09:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795616026;
 x=1795702426; bh=MKdXwMc7Q+1c/L43tDZae4RrMB8GYFpyTWDAp7knepQ=; b=
 ORY1GmZbTNXVmzzCuNsgCkVDQkw8seg//+Fz/Y24H395EgIoN073Khxc6DZdcLsB
 C3u//0oL+4zgNhLPy30KEp1nwmIx56kpl5fNSzV5GX085qdiiQW2VK14wHU1c2Zo
 BTLQFnRP29+Lr6oNfGfeJTcwt/3PL+QvGSIzHw0TTcdaGSZGiIX5ZSOoEcvmNxj7
 0EL62LCBAaKcR22u9+Z0rR8xf0TXUzQnlyqEWBQCHqUN89gCYb6Qsi3puUPKDlg/
 FwTOa+itzIobXPOMXPdCkBMp8QfUUsNSwTJDLGpt/lbL+Q+fVVt8uzsKJPqW0CRV
 hkblCerYVzCCEqBAhvsj3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1795616026; x=1795702426; bh=MKdXwMc7Q+1c/L43tDZae4RrMB8GYFpyTWD
 Ap7knepQ=; b=LmKX9SbEKoeyPP8aUl+KpwPUHgu0hKPYw+CUmBd4N6mAkRAJGls
 OMhesE3Rg8ZUPgE0LO624bbFGc15xf+nvmOZpHWCuRSlyXdIWDfxE2DuuMjxwvzR
 UFUWJiVE8m7jWrfAdVkdGGWa4MngzKafcdOBBUcBPLcmEIna+ZGebCfiQCvpVlIK
 cBoMrwL9bkzKeaM6bX22/qkEfNwJM1VgxHHs5T/BuyHqlfQtKGUQuSMwSerJ/S8I
 rKwso7XKUn1ky0t1N8cwbZm4Fb+OwkWxy07wJ3fjCxi4vnG1umcoxyy0IYE2Nti0
 gkd0PkwCsERJmrDKGTZIhv4vXl793gLzHnA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=invisiblethingslab.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795616026; d=invisiblethingslab.com;
 mf=PG1hcm1hcmVrQGludmlzaWJsZXRoaW5nc2xhYi5jb20+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:aZtVoTfuVdQX+sJn1Z3zKP4gCZ8QRXF9LEJ1GmoV31WXGCp
 cAdh3qPZ7lqXhd5Ko+PyldRP9ko/M1I1/GtJSIED7uSaOhBGDBGQMXoLWQwpFCXv
 jLxmRFLRbJB/8s8wQeD47ZvnEappVUT7VASF66+C2wPlQW4xqOOpl+vNazwdYNTs
 L+zo+qGV14fAZYTcUqaOODptrBQds7ShcFZpY/jDLg/Ey/zqIMWLnnVyplsqp83D
 uezf+TQiFIyYDySVSKoGA//QZx2ulUN+oERefKrQYA1v8MU7Q6QbiJBl99vekTK4
 v9G6xLRwixwfXnmWzeBk0fOx9vJCexV/j16OabA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:CrDuLf+kk2/4LiUgM/GwNrN0wXECDETWypiE0zo4I1E=:vMSevYf/RFwV6VLa4XzaGSdhnQ4OU2JKzUtmXPolzHk=;
X-ME-Sender: <xms:Ge0GaxZvi4Q70IHr4J4Gc5-H0EhCIcx8dkvStUjCfgBiKXiQrcMCaw>
 <xme:Ge0Ga_T2oEzSLIkFHTomuwO74IDx0foUbPNtAN-tGn7FqisxUrDHH0fvTYpJvOBTD
 MT394LUSljNK58beXBguFXRgFdoDiMBndo0GYFNklD3UW-vRB50>
X-ME-Received: <xmr:Ge0Ga8TwaiLxO_542n0wPXKJNgghCH1L3Wnop5vurnlsmnACgnzyGx4TuhpQbarh0CeIi_F2uqAp18qxyxuEq6pPGe6ClGR98AtKXMS07Qk>
X-ME-Proxy-Cause: dmFkZTEHyvAZoy8206vhZwbc45trB+HfKVz9kHRSkeHl4oo+I59ZmyLtNRv0E2lQcwSSN3
 e1tYZ6FGrri2BoceUxHz7kaZKBPQ58e7TJyFdlEkQQllEwFOywdLIwRComK31nPL7M2d+8
 cj6rBnJMFY6rqtuiekxFF9uu9xS5XOpCo2gdjeK+6oWSk4MxDWoGdgnadZLLEsJzLFzjZV
 bvqQ5gbxuna61LKyH1x8LCKBjEuBFt2VFRKWicSqbmEh+OBInJe0RyfxXjSCdh8ftgsflR
 //muydgFMPJiARUNVAmY7bZ6BXff/Yu/NVUO/WVSrlYcP7ItWTjMxkYmDMBr9/bqh26UJl
 CqUYT9CoDCBVJVxSTXUgLwn8d3EKe9QY0xMwhahGF15cnOG9WdiagnI3Qc1NyaHO9KGjbH
 oj/Ip6tk/R9/1VSEN+kDH+LkrbxK0dkW52hrp7MUMJ0N3aHhBeHIhGr8tRqY3N+SHrcU35
 GvYR/6j5sI5MXmxwzqdpVN4MacheYfmDJsI/IaIWe2oE0cnC4jCul8mJNzToXqnqEkxMh/
 WT8cKt238aksoh+rhmDOloG2263SxgQcMKoksWr/3FRC7dEuDqDjQrZ8WlK7CTYWuHNZiv
 DnYf6wh6LBUqcCAU1CBmXf/KK1y30sngCLQGh8aZR+8iqMWA74utXFA+DX8A
X-ME-Proxy: <xmx:Ge0Ga7TFKS4aWOAJETbzSPiRxDX465rdGeFV4yCUzWWMNuTkcftEKg>
 <xmx:Ge0Ga56ibr4qRv6otZlxE2eEFgMlnubKVySWcsWq4RRsvIzh1FG6cw>
 <xmx:Ge0Ga_2K2WwxSUTk34mn17f_ZIEOLDlPVL4hFfUz2zBVePp8q1Jr8w>
 <xmx:Ge0Ga8DD9Kh_N6vrwH2PFth03u0wI51zH2lDpPqCiCfX1Fvx5bMb1A>
 <xmx:Gu0Ga7MpPjMYwgSrsjnfAlYfc2lkhZzcrh17BO5rOG6IRZp0sRNxifO9>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 09:13:44 -0500 (EST)
Date: Wed, 25 Nov 2026 15:13:41 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@vates.tech>
Subject: Re: I/O performance regression between 9.0.2 and 11.1.3 on Xen
Message-ID: <awbtFQSEUtmAyoUj@mail-itl>
References: <awbIcujrsqYLGS1B@mail-itl>
 <179561473234.142606.6830358739051545773@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aE8bv+0KLC0HdSu7"
Content-Disposition: inline
In-Reply-To: <179561473234.142606.6830358739051545773@amd.com>
Received-SPF: pass client-ip=202.12.124.153;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=fhigh-b2-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--aE8bv+0KLC0HdSu7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 15:13:41 +0100
From: Marek =?utf-8?B?PT91dGYtOD9RP01hcmN6eWtvd3NraS1HPUMzPUIzcmVja2k/PQ==?= <marmarek@invisiblethingslab.com>
To: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
	Stefano Stabellini <sstabellini@kernel.org>,
	Anthony PERARD <anthony.perard@vates.tech>
Subject: Re: I/O performance regression between 9.0.2 and 11.1.3 on Xen

On Wed, Nov 25, 2026 at 02:52:12PM +0100, Edgar E. Iglesias wrote:
> On Wed, Nov 25, 2026 at 12:37:22PM +0100, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > And indeed, reverting it on top of 11.1.3 fixes the issue. I assume that
> > page gets mapped and unmapped a lot (for disk I/O?).
> > Let me know if some more information is needed, some logs to collect
> > maybe? Or a simplified test case?
>=20
> Hi Marek,
>=20
> Thanks for bisecting this. We hit the same slowdown and carry a patch
> that keeps foreign DMA mappings cached after their last user releases
> them. That lets repeated I/O to the same guest pages reuse the mapping.
>=20
> I have the patch queued for upstreaming. It=E2=80=99s on the edgar/xen-pv=
h-fixes
> branch in my tree.
>=20
> 3386b77e09 xen-mapcache: Keep released DMA mappings cached
> https://github.com/edgarigl/qemu/commit/3386b77e09e194ffc921c79f28241de8e=
5545748
>=20
> Could you try it on QEMU 11.1.3 with 123acd816dcc still applied and let
> us know whether the Windows install is back to around 7 minutes to
> first reboot?

Yes, that works too, thanks! You can consider it as my Tested-by.


--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--aE8bv+0KLC0HdSu7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmsG7RUACgkQ24/THMrX
1yzufgf/de4CfXwH1vJ3Im5eeNQ50PD/Hip5Tn/rp18UUZ0SuQH9zUURpdxFaFaW
XnYRcOE359/+zpIBfyv+yPHGMjiUOfSKtKiBFPQ81K8aJfNIEgKtxOcqpRA0Za08
0I4H9T5r55DtTgEuao/q9zpHFvbAjZ8vQOx7zt+hw8rw5enm4z7Jy9nWVgo90AwF
r95CX700QIv1JdJdlhckThlMVP7p61yGlOgnjKlbVR6W3ftnOKGclsOk0r9hmg1j
62jPPxqrFaxGT9p3aKXcABAwNkHHHeodMUPlK4G+fajm9mnky4l8ALoKoGjc7e3m
fk+ssuh1LA4FN+n1m+nkLBH4VdeusA==
=M/pY
-----END PGP SIGNATURE-----

--aE8bv+0KLC0HdSu7--

