Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC3606A8AE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=YlD/Eg+h;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=W1iI+M3g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZAW-0006Pm-Uu; Thu, 12 Nov 2026 13:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRZAO-0006NT-K8
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:04:57 -0500
Received: from flow-a3-smtp.messagingengine.com ([103.168.172.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRZAK-00078q-0G
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:04:56 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailflow.phl.internal (Postfix) with ESMTP id BA07D1381CAA
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 13:04:50 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 12 Nov 2026 13:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1794506690; x=
 1794513890; bh=xa/ssCPwwHANyJIJt9yRWm7kj2gDcuMXfN7GWyrYCpc=; b=Y
 lD/Eg+hxtRcGpXEdFGAiVMh4BKveviYmzjHWoFG4vuVZbKffppqGrnmOTAbVMSqp
 HXWfj1+RglIWWcZyo8oLkKCyHCAE0u1VzC/Qt3p9rbupQhz/xVlbgfNOZF5OljcH
 GFGF1XMVG6dnSCdHMZkELQS8s0h4B2YwTWNoVxQRsoX5rjVjVQa9Ph1rE8hGIEhQ
 7jkW9ZOeixoH6PneUifctO3SNYGfCJF0in9GYdmOIeP0m/SoQmHaC/GlIomVa2iC
 fWpjWZ9d48ITSjApl4joN/Sirwd4V431i2Q8LOoePI24F0Nyfmq3pvmgNnsCCQRP
 odrA/Hnn6UFTBvsy4E/5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1794506690; x=1794513890; bh=xa/ssCPwwHANyJIJt9yRWm7kj2gDcuMXfN7
 GWyrYCpc=; b=W1iI+M3gLujehHJLW4kEA8Q5z13Evjq4SFMSlf6fO8vhf/mHpfI
 eFGCNSBED61bX1a1wAwDZhS9+nyO+ozH6+qYc5wbIkI3CdRq7SR/qie3gMXzUlLc
 aXk23Xy0D8nWb0C5p0xuxW77UMxOkGFVTB4J2SDgpPBR9hKGvMkO1LV1SqryQhfz
 wiutbQY67BbtzTurb5MqjidsAdUU7DYiJVSjrEdUwKI5h7nHAEG3wNIGmAqQsppK
 J3m57MqF1pJUfvmpaOgbfdEeiLAKJvxsSg5m/0gEkTwQjGI8po/Rz02EQp0Hcn+a
 RP0WPkHOMsAxTQoTXAwgur82kuS/6kgymTA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794506690; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:Yog/VI8QgJfH6Bpl+ukTC/+ItDMbKER/B84S1I5hY6eovGX
 0bvpJblPfRlTtfpINCBVdqOM/xmaZnavmnOXtsz21cbeEyfTH9tOaeVahiFNQj0z
 5arzcuy/rnfsJ7CswLHXbOYnxkAf8xN4qtVNdzwaVkQnQXwXOvsJ4+atTO9o8ZWu
 HAypYlPiyyjlEOlzRefmqfSkNlhK4pEwOPURpWzvOnesqbkfqfzLCIiObqpd+Eh8
 67Ru6TDMtQW+L1HW9jWe4Zw2Y14zaevOMosH4dkTFr+th7vUd/pfp/pE9Oq5BFNr
 Fau9lmGbWnf+0KrvN4jS2Kb9Lbz/zWGTU6occuw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:ymYsZSQOJlOIpV1RHn+3xBTeZAG+2rIXIcD1TZmEs64=:xa/ssCPwwHANyJIJt9yRWm7kj2gDcuMXfN7GWyrYCpc=;
X-ME-Sender: <xms:wv_1av-p8eI185KQT5bNxuMw5N1RghPCvv4gc9LZXZwzL02oMPPKpw>
 <xme:wv_1alzbAev2fdk12iIZ-myc3b2KJKBTsR6EGud7C_GLOpCuZHNN-exTn4SHLw_1M
 31np7aZhN2BTvHwjMLT3Vw560FWYDTEB59J01LtYT0HZtw-i-IKoRc>
X-ME-Received: <xmr:wv_1as5piS_SGJs6r2-vaRpXm6p39xh-Fsp_mYNnMduBULFZueeYAKp953xzW9jhLCurW_Ox6Ww5o8kXwkyZeN3YbEs8_zk>
X-ME-Proxy-Cause: dmFkZTFqSH1iywOREeYxx4GI2l1NeMHhX+lGo+FywMKn5z60CJw7Ikp29TFYEOck/FXmb9
 m4wJDLqUCW/2Y8z+PYTBxQwLialj2baaXF0bRHV7Cwp2uoAMGwWwTtDXDZvNrFSAPRQvE5
 39jcC8qHgu8zGBVHgUM00WLSfPIoJ4P6aRxkMRhO4OHUwvYBJSUfhFCtjX7FQAHY52hVMO
 GSadACMqH6SVk62BXXBmY2dObuCx5OgQP8qTSCqGZzYtPkufZomnMZHF+ZcpHiH78UMk2/
 QSnkxKsWUicLJfsgMhZZUHYC5fe1lcKIagR/s9Tn44IHoP+lqivkMRjKKzkvI6MPTgMbZF
 2dWB4g2vAVrn0YU5IxfY0q110kJ2x2jXzceXt4+EjFnZKx57rjujE/5h1vmBOBEPDsf3h2
 LyhjDuADEFmExZcL/AyTvxIa0zflHCj2P9jimDFgqWrD3qOyVbxfHXa80l92XMNw8kb3Vu
 P8NXGBHr8Uz4q9e5GOtJdo4Jy1J4r/BCXEq2WQPZa+Ye0yAj92+N6b+tnStSkMuTWXtc5W
 hVgGBUIMRnfjA1WeMWvnJDsfZyCn/pFuGBRVr5waW1jv0QWqYoEAVEMb3QzOADEgeCrAJS
 wXwRLk8yuLZ4I4K44Z9m0mV/38AKSL4Mz7/+eoH6euJMGAwwjU1jJ+ZtLXjQ
X-ME-Proxy: <xmx:wv_1as8b4m5iPowsJCxSXhyfFcTW4o1HRMHoR8ayI6qhf28HwhchEA>
 <xmx:wv_1ahqPohPdGq3jfYOYKw8dTMtJDiAw-AALF1VPDRT-6m5GetGf2Q>
 <xmx:wv_1atpnqVXlaiz2DWMR7LlcXPR2zZ_-bNVgkx_NDhWh4bSMVx2D9Q>
 <xmx:wv_1ak2ipZ0kRnSpF7cgnYwL3PMxIPwL5nnq6AfBnGrUT49dsVeZ6w>
 <xmx:wv_1avp038KlmlkVdvouSzCf35SpCJcMM2cTJLx7s2LwMANNlvkj6ps3>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 13:04:49 -0500 (EST)
Date: Thu, 12 Nov 2026 19:04:47 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Tommaso Califano <tcalifano@redhat.com>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel-bounces+tcalifano=redhat.com@nongnu.org
Subject: Re: [PATCH 1/3] hw/nvme: reject fdp.runs smaller than the lba data
 size
Message-ID: <avX_vc432uGe1kmf@AALNPWKJENSEN.aal.scsc.local>
References: <20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com>
 <20261112-nvme-for-rc-v1-1-69b3e5dcd5c8@samsung.com>
 <DMT9BXQ9TPPI.2JEJKF00POB19@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KmbT3ZzqtvM7pde6"
Content-Disposition: inline
In-Reply-To: <DMT9BXQ9TPPI.2JEJKF00POB19@redhat.com>
Received-SPF: pass client-ip=103.168.172.138; envelope-from=its@irrelevant.dk;
 helo=flow-a3-smtp.messagingengine.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--KmbT3ZzqtvM7pde6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 12 14:13, Tommaso Califano wrote:
> On Thu Nov 12, 2026 at 10:53 AM CET, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >
> > The reclaim unit accounting in nvme_do_write_fdp spins forever if RUNS
> > is configured to be smaller than LBADS.
> >
> > Reject such an invalid configuration upfront.
> >
> > Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
>=20
> /s/Link/Resolves
>=20

Issue #4520 is a bulk report that unfortunately contains more than just
one issue. I didn't want automation to close the issue. That's why I
used Link instead of Resolves.

> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>=20
> Maybe Fixes tag and QEMU stable in cc?

Doh. Yes.

Thanks!

--KmbT3ZzqtvM7pde6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmr1/70ACgkQTeGvMW1P
DelOEgf/VFIhKLY+shehnzbLc9q1dOJAU4SMyT1oGW57/PtC/HoeFbAqWJ9Cy0cL
AYwWLhnM6WgtSnUo0wmFVOMggAiwHOd6scO0J4jTtdUpNray58gMfpbOOOodYrfy
Q8e5AQUZXMgU4/BdrEZL9LtaDaG0OjHFJklW3MlREM3k8dPCYAHsZlS/eSnifl92
39QN5OHeUuHlZM0x9XCIZZdhXVPSKAuVHJrW7ht3cxg/yIvtNuNayoMwGjAI7xpa
bun+pqALj/iN+CGy8X/kgZ4uWoJ5RRnrf/lvXsJTuyksk7fNk7bAevbVHS3oiumb
Fgy0uqe8MFKgB0V5tKwWNes389flyQ==
=zsHv
-----END PGP SIGNATURE-----

--KmbT3ZzqtvM7pde6--

