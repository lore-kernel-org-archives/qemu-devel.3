Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE20606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.a=rsa-sha256 header.s=fm3 header.b=hpuowITj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JDa842Q8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWBJj-0005uu-Ve; Wed, 25 Nov 2026 06:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1xWBJc-0005sL-5n
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:37:33 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1xWBJZ-0004PQ-Pn
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:37:31 -0500
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 7AD781D004CA
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 06:37:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Wed, 25 Nov 2026 06:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1795606646; x=1795693046; bh=9k
 yUCfChn8pCXHK8yebfiOWuNT9W9TxIjA9i0vqjqas=; b=hpuowITjOHN4aIO0PR
 rEyWrrQOAtDGJ3ir6bIcDK4ulKbAWaZ1h5QDmwlb3yoi9ewPJGuVsLJUupleqUwP
 c3CmNOwk851MCHhgo6YbP57+UmJqtxgDLllf1i6mJ2z9Xu56oj5fVI1BxH/oFJIg
 +6bKSBXHkReD7SoRFy77VpR3zbKpeHtBQPfZmz8D2bgLZwr1Xl47Az+R2XQa/hiJ
 xqfDUyEkhoRDZHcysfRyP+WFuJvuy+1OPeDhKwgCowDCIioSAjR6nuvRVmXLpuo0
 KZv0sv5uwMNk+hvqOL/5IgyC5I6iidYdvdKYgqmsc94TOcA7mNZpyOj/VRJdiG7V
 DGlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795606646; x=
 1795693046; bh=9kyUCfChn8pCXHK8yebfiOWuNT9W9TxIjA9i0vqjqas=; b=J
 Da842Q81UmaDDdZlcNbZKdTuSQiN3tJ8wksuAym6joeeHkmHiVHxxV/g2G0bb83b
 i0YA3STPwGjHs8M3eYIgCYJ/ci+NRhhSfQnaBblOoLFFAzMm79euBk5r+jf/2Md5
 NsK1qMkavN2Vy/swz6rXH2nmi7OHSf8HuidiWykRtPT/mfdfGqVqj5XobaqjrFSA
 d0MWHeA89vJpPnZ0waCLkAZrMke9L16iFe+Cbvdanv09fpGVbbv84jLRWU/PQPvt
 ekllUF7lYBTBbOaZoxe555T1BDuDVYHfwgNeX8HHpRN8KiyaeUFxnyS4eZ1Yd8kY
 ULXIGCZxzjFiKld0jlqaA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=invisiblethingslab.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795606646; d=invisiblethingslab.com;
 mf=PG1hcm1hcmVrQGludmlzaWJsZXRoaW5nc2xhYi5jb20+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:JIelzLxsVT8tyAjZZWauZY6FTotlz6ifXsPDB6TrTCit7EJ
 mBhLeUkmnA7/sbpoJD4oMJJ4OLUqect6M6z5fTxdQfgBt5jOY569LVd9KbVu/21D
 tw3T35Cy6qF6WMGjAxuFpqcNuqnqS2jrLSeINVKxF+PpSyiETkI/XjbSoD/ur1A4
 Gp+z7Hg0bP59RYbbBXea4jIzbAhrEoN5VlTVShRDq9IqmnmtTyzoGcaDN2J+clLL
 GQhmE/972zHD22TtP9mtTQJuiBVyFtlrg7veShXk0TkAGiQrjfS0GAVr5A1RWEea
 Ov9vkcwpQOMdOb5B6iZVaJafWHTL3lzbPeN2qcA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:yHwUnP5w/Bq1V8pwlIGqodEbIbaTKOOc199MPDgXSIw=:ye2bjK0mgrHRU/fjaH47XDXFf57kiI31H4SKA/v08r0=;
X-ME-Sender: <xms:dsgGa4TKW2UVO4voeWx1IG31HNtt0scTduSt7FtIXSebUwarLteXWQ>
 <xme:dsgGa8q45OR4tPX3t3MVEzvRyV4aAp4zSgjQP8N1YSbwHL5upf81Ddj9zRmzbdM--
 QI0gcyZykFK3APxb9OH4fr6HnBBjtUud-ett85x2oOTz0bL2w>
X-ME-Received: <xmr:dsgGa-K8shwZiKI7XnBp1yUdkdWPj7ZZsGFRAAk_IVwghN_JmUDmv3UCAQtLJ0A_pErdY1XRLfQuklZIEM97gnndz12lKGIrcHbY6TiN1z8>
X-ME-Proxy-Cause: dmFkZTEN7JTuSK3BXL9J06e6DyHkHlK4zk89f9wWQjaGK5q69GmZf0bpLrr1DxccWaK5Y0
 SyfHLuPTM2nWzNZRKHoMsLaQsE19+rKMap3R/EJsB1mL5JPBxZtzQHWcx2tqmeABKpHqjx
 L79zz7FEYCkwn8VD5hZalLBsWmpk48GNR6/UsSxVyAoxzieXkbuQjJszERSDa5PkQqqcqE
 wolPBNtb66kqC7D5lOAVaQuKLvjPqW2Etdb4R6ac4DjXysvl9FK/Lgf0O6OS1EuFrRsMhe
 7AdHeHmWp4PrhUDUjCTc5nQXN9gdgM6sYQ+y48iDBCFmA9cfnbLp8q9sCG48xH4bcr8Zp2
 5aIt8+fstCGEyuR+uW9lwYwWEqHJlobu6nGSsydYDnQY/6j09U+/fSOLMoCOoceOBqm0zk
 C8+YPfW1uRbIR5E5y1oTh/rkr00/eFi0YUZLH9TVsQv8Oua0JpSm2TvptpAEVXaWKgkNzH
 ICqZLc7m9daV+Jx7XmOLWnAeY9RCnRtFIscjk3KTGFDLQrVIyNqopmmd4PQIdJMAIAv2qD
 QxDAqUz7AV8yxJ2BzfKT5kBliBO0Ro8P4G5ld/feLIJWh7upvqvsWdmzN2ItyxRWWd1olZ
 RzdhfnBdAkBLCgzHB9ZjjsRfwCy4br8mJkP1iD/heRamtAdBittJm27mVKpg
X-ME-Proxy: <xmx:dsgGa3qixm-2Woc0hNufI3k_57rpg4CbKGTocUoAPBn0yACz18y97w>
 <xmx:dsgGa-yGGtefqyWJA1kpRXIajnh3GadyQse7cyOeWb09MjuW5xSmqg>
 <xmx:dsgGazPUD3lOaqX71ZeFcTeZc-uPXSZkgIRwUrOljnuTVDJK9pwamg>
 <xmx:dsgGa75zoPPeSTi18TDwxoIa8ElFcUSDaPFnkDMO8kuxFepZSC823w>
 <xmx:dsgGa3k83LzwZlbh5xrsV6bsrhZriX4tCG8A025C_-irFy94_7W7q39O>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 06:37:25 -0500 (EST)
Date: Wed, 25 Nov 2026 12:37:22 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Cc: xen-devel <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@vates.tech>
Subject: I/O performance regression between 9.0.2 and 11.1.3 on Xen
Message-ID: <awbIcujrsqYLGS1B@mail-itl>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HkaqPo3myGkwPubi"
Content-Disposition: inline
Received-SPF: pass client-ip=202.12.124.145;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=fout-b2-smtp.messagingengine.com
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--HkaqPo3myGkwPubi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 12:37:22 +0100
From: Marek =?utf-8?B?PT91dGYtOD9RP01hcmN6eWtvd3NraS1HPUMzPUIzcmVja2k/PQ==?= <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Cc: xen-devel <xen-devel@lists.xenproject.org>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Anthony PERARD <anthony.perard@vates.tech>
Subject: I/O performance regression between 9.0.2 and 11.1.3 on Xen

Hi,

After updating QEMU in a stubdomain on Qubes OS (Xen)[1], I got severe
performance regression. The benchmark I noticed it on is Windows
installation time - the first phase (until first reboot) went from
~7 min up to ~30 min. The version range isn't exactly trivial, but on
the other hand the issue is 100% reliable, so I easily bisected it. The
result:

123acd816dccbd358570ec7ab79c5cb2c863780b is the first bad commit
commit 123acd816dccbd358570ec7ab79c5cb2c863780b
Author: Edgar E. Iglesias <edgar.iglesias@amd.com>
Date:   Mon Apr 29 19:12:42 2024 +0200

    xen: mapcache: Unmap first entries in buckets
   =20
    When invalidating memory ranges, if we happen to hit the first
    entry in a bucket we were never unmapping it. This was harmless
    for foreign mappings but now that we're looking to reuse the
    mapcache for transient grant mappings, we must unmap entries
    when invalidated.
   =20
    Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
    Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

 hw/xen/xen-mapcache.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

And indeed, reverting it on top of 11.1.3 fixes the issue. I assume that
page gets mapped and unmapped a lot (for disk I/O?).=20
Let me know if some more information is needed, some logs to collect
maybe? Or a simplified test case?

[1] https://github.com/QubesOS/qubes-vmm-xen-stubdom-linux/pull/77

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--HkaqPo3myGkwPubi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmsGyHIACgkQ24/THMrX
1yzdOwf7B5Kq+AczMv0z9ygk2CD9DzRyle/A5QEG/cmVOphk7jyB2TahAkIb+xT5
R4Y3Az9ycSE0+jS1HM1V5NI41nLwi3eVyFJwER6bNkbZbHcmT4dbYwe36NveNbPr
ElfZ6qAaZpqfQNrI4JY71E0RbpFm/nobwF7+WZreG4pbI4shUfJ40/1nt7gLjgsa
XvzjxNH0j2KftVi1+OpKhMDgbZfv/CDlwuz33+nLzhh9suiZHAdHIirO+GnSyhY3
ZLSHB1ceyny0vMwweyzXHCAjsDDJF2gFfHmukuhgPrFeke6LXDXkW+MVkfi+EoCG
/kyy1PyEiqfeTBquI3Yt2LiFkXRAHQ==
=Plij
-----END PGP SIGNATURE-----

--HkaqPo3myGkwPubi--

