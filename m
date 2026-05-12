Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45262CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 14:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMo55-0006vX-NL; Tue, 12 May 2026 10:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wMo4t-0006uw-MF
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:27:19 -0400
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wMo4r-0004mg-Vz
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1778596024; x=1779200824; i=lukasstraub2@web.de;
 bh=JmqYOe1iTLLMA3W0BdjEDMJya0CQ2CZWBgTZLbbYVUI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DwwK2Tsf+gYMD8CXHA9CuLBYzAlXveo1DFK5wes/Wnptc7EPlESy234WnZ6zm2ze
 KkyEmN6KwmzvojZUGn9qWdJqOGwUY8YykVkkue3Zi3lBh8M2/VSp7xmXEfu4KdB/h
 8B7uzcNPkf2kN3bjRWDIXlL/TZRqRmDlIlGMIlm5QEeOIhJgTOEulupT8/bA7ipNV
 xfnBGapNcXoGpfM7bpCETn8X6xMzc2KLb/XYS/yVcAmnbjkr9aiq/rHwhGDZHnxfp
 rHtvMx1jWyHbTPg8LyU1n8/B3qNcYF4l4r5kl8wiqfVsSn6LvyBPKmmXmNSh99le1
 L9syTpDFTsViyMk3SQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuFD7-1xGpZa3tKn-013WXd; Tue, 12
 May 2026 16:27:03 +0200
Date: Tue, 12 May 2026 16:27:02 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda
 <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
Subject: Re: [PATCH v1 14/15] tests/qtest/migration: Stop passing URI into
 migrate_start
Message-ID: <20260512162702.3468d827@penguin>
In-Reply-To: <20260505160915.25558-15-farosas@suse.de>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-15-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//WBT7yiJMxIP_/GgtQpEYjR";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:kxK91AX53ekLQAFHD2nX7Z6eJjLzghooVOfM+vI8fP7k/6jdWcM
 ox+/18unFjqkmyVeo3j+RjLDzr24w4kSdw0P4AzQoZMniIUGoYbadxqydrwiOPlQYVheIGB
 IXJlvCplrz7oMRN9Er1W0t8duasyTTUPT9TuzEAC06MT2OyzShH0BrI0g0bXBV3o0wAbeID
 il5KsRD8l26m8LBfuFEGg==
UI-OutboundReport: notjunk:1;M01:P0:8jT3Eg6fzls=;7aQli1Rerdl9cOoQcx6sEfPHmte
 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
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
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

--Sig_//WBT7yiJMxIP_/GgtQpEYjR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  5 May 2026 13:09:13 -0300
Fabiano Rosas <farosas@suse.de> wrote:

> Don't allow changing the default -incoming URI via migrate_start. The
> default is now -incoming defer. If a test really needs to alter this
> (such as with CPR), the target_opts variable is still available to
> change the command line.
>=20
> (aside from the larger goal of using defer, this change is a step
> towards allowing migrate_start() to be invoked only once for all
> tests)
>=20
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/colo-tests.c    |  2 +-
>  tests/qtest/migration/cpr-tests.c     |  6 +++---
>  tests/qtest/migration/file-tests.c    |  3 +--
>  tests/qtest/migration/framework.c     | 17 ++++++++---------
>  tests/qtest/migration/framework.h     |  5 ++---
>  tests/qtest/migration/misc-tests.c    | 10 +++++-----
>  tests/qtest/migration/precopy-tests.c | 12 ++++++------
>  7 files changed, 26 insertions(+), 29 deletions(-)

For migration/colo-tests.c:
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>

--Sig_//WBT7yiJMxIP_/GgtQpEYjR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmoDOLYACgkQNasLKJxd
slhslQ/9GyKG6TT/TyPTnwvUE+nWtwMDozTDJ2yEjFbKVwLT4OWKSMJizZR+L6QS
V3o/9LJnIkuRUi6MksFpzpUlXgytVldNZl/TMRuLrQT42A7Mp8yXIqbZpa9hSsgm
p+Nbl6EH1L+CDfPCWq8MsMEKDDZQRCfXep1fNr2fNypDAszC4PMUXUDEMzuyo7hT
IbhuDPQwiLM9dStIoEjIVijgWZRVG6D/eT36JQUQ3skT0EPJtxBtNmU2vV7dPu46
kuTW12YSljoJzUYBPWAdjv2o5HtMZUN3GVZ0qL6Epy+SlaPgLQ8LCGx6Nljl9u8l
f8/OHBl6M3c+BKnUdfi+7sJhR4K0HJsyREEhyuvrnEXAoooym1A7JNqQ3kQ1T9SP
i2pxHgunMh/ulW8B7i+DWMR10QAbBX89gkA/bEkjTfyUuDp3eIl/IkJwdubBNMlr
0V24ZOBFZjuvRb6gXcnnuPsASYGpZ3skCPx0VO4kSw+SYcK4julEZf71WJR8KCNV
SfOUSwMFR4lUgM3ODKQv6zXIdWVcnyVWVjpyJGnq1QKKE9sj+mTFWsdzlHkq0Z2n
FwYsEQ6+f293dBZqYV1wAqqecYxdks31Igo05gMD7rzdCKq2Px+tCmcL3dVVQL3y
+53huG9qBPkUOnCpdAXfR0u737geRpcq/B0aZ2k2vqMj04USkuw=
=FaYE
-----END PGP SIGNATURE-----

--Sig_//WBT7yiJMxIP_/GgtQpEYjR--

