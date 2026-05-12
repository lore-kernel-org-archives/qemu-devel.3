Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D8DCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 14:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMo4R-0006tE-0j; Tue, 12 May 2026 10:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wMo4P-0006sz-07
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:26:49 -0400
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wMo4M-0004as-Bo
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1778596000; x=1779200800; i=lukasstraub2@web.de;
 bh=oMUYcgRrKttDC6rJYPfX00NfLN254F2CxiFzDA89wVU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=M3f2DC8visIZGwruuDBXe1+5zOtmScBnBRap02nzTxsZYbD+zBQYWF+pJ0X1bBDF
 pyPGDgZSNoT+XkbPpEybeWTNQ0kfggPaDudOTZn5Aq2Q8ibuDBM2fOYvAJM3rttAU
 Wf91FW9DkLyPX8QQUpwCeywW+gF1cSdHM/cb3fq7mta6vWqXn1cIP6V1b5CiWVVvJ
 WWdeeFPguhOZ2DbSnrbf97pyF0KFozS74JNf5qMHxQzcDi1BexQ/hjRrYDCTqsN6m
 xFw0Dct9vlEOTg1MLzh5iZ1S8+ZeYkhi5fWIv7zIW802Gy/aBnKBAxr42uh5SABGI
 H8kc5YfkXkdOTbST7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPdr-1wiaDR34M5-00MeGJ; Tue, 12
 May 2026 16:26:40 +0200
Date: Tue, 12 May 2026 16:26:30 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda
 <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
Subject: Re: [PATCH v1 15/15] tests/qtest/migration: Unify URIs
Message-ID: <20260512162630.73fea64d@penguin>
In-Reply-To: <20260505160915.25558-16-farosas@suse.de>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-16-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HUX01AzwGPMGCe7ABQ9GIff";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Fq7RMiLM6/Rqf1bxRr+04fCFCeVrs5QE99BlvdLW+m/90HYWZgG
 GkSqiescqs3tCURo/nfCN0wk7eddThlwsguzirud9Y5V+IRCSPleJlPlLcI58tFNggw2p6v
 DecsH8f1fYJrW3KdU7zpOim0fxwvDW67Z+r8iWnJESudZJV5761d4HY+gsOHJVreEwkUyXG
 TOz6ZA9d21+utZd+V0ZDg==
UI-OutboundReport: notjunk:1;M01:P0:90TaNwKYHWQ=;hMmeT4MPR2UtXajuXVgQ719qVE6
 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
 lcI9gToNhGvcApSFVmggzaE3twg=
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/HUX01AzwGPMGCe7ABQ9GIff
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  5 May 2026 13:09:14 -0300
Fabiano Rosas <farosas@suse.de> wrote:

> The migration tests have always used localhost migration and therefore
> the same URI for both sides of migration. Change the listen_uri and
> connect_uri into a single uri variable.
>=20
> For migrations using sockets, there's the possibility of detecting the
> socket address the destination side is using. For those, keep using
> different variables for migrate_qmp and migrate_incoming_qmp.
>=20
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/colo-tests.c    |  8 ++++----
>  tests/qtest/migration/cpr-tests.c     |  6 +++---
>  tests/qtest/migration/file-tests.c    | 10 ++++-----
>  tests/qtest/migration/framework.c     | 29 ++++++++++-----------------
>  tests/qtest/migration/framework.h     | 14 ++++++-------
>  tests/qtest/migration/misc-tests.c    |  4 ++--
>  tests/qtest/migration/precopy-tests.c | 17 ++++++++--------
>  tests/qtest/migration/tls-tests.c     |  2 +-
>  8 files changed, 40 insertions(+), 50 deletions(-)

For migration/colo-tests.c:
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>

--Sig_/HUX01AzwGPMGCe7ABQ9GIff
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmoDOJYACgkQNasLKJxd
slim0g//Q53kztvNJYY4RKXKtEgz6+GM93VUQRDk7JIigCVX5fm0UcY7+D+TCVV4
eBAKfNLYV0uC6nVddTxq0ltpH0i/eQLipaXPDovWEployK1nQXXBlOdM31FtKPaH
DyE7HQ3VDcXwRzP0gxScnGK7aX0DNN5CiiVbaYU/ttfBUrXcmgU2vqm3YZKxwIu8
kt+tdyzhWeGfp2gHTQdVPr3n1cT00ql5MVSJ3NCPyjtEYASadSTmF/NANcfF1TkV
TP4jkMr4ql+jV/37cKRSNyRwBUjCjk2JLBA48D90r/2BgyuPMxHEbAw0jtp+Md6b
aa9LN2kqqkC8xXacIVruEG/FcsvzCvplShCBf8HzfZU0mw71zvbT0/UgtAy1KOBn
ROlgEGgR7iarIULS7ar9yX36UIr6/B+PpRuzGxWomfWtIbJrqHqSKIOWUrlPkUQL
irf6fKUDy+pjCYxSeR6yArwuoxgRKH0HmVGgAR3AfeBPPgxunx3xh+cnov5hTmjN
9f2jj+hhZX27aSUIPWuYOb+UUw9n2T0mkSE0L9wUl8ryQILadPiQ5G3cQ23svUkj
OKv49rrxBwjRTKpeY3nnCjfMIDt8Em5CqrdR2vHq9/zbQ0I05bIexBGVjtEdgpDM
4jYv+OYH5/J5yemaASmpSY1tpXUh+eCcIk0kiCDHVAOhUsE08KQ=
=Z1GC
-----END PGP SIGNATURE-----

--Sig_/HUX01AzwGPMGCe7ABQ9GIff--

