Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2833C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsrB-0004AR-EG; Tue, 11 Aug 2026 16:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wtsr0-00049r-5w
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 16:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wtsqy-0002vt-Lt
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 16:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786479219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lbn4DfKEELCC3naFsYuVBfw1E42eWFnevQpv2IY+0jY=;
 b=g1AMEMPp2HHIpTrVeXQP6phoSl3G1nygI2aBwY00Z7A7QfEaEJne1mTVI9DXHhu7EocT3Z
 Tshw5U4ZKwIS6rpC0pEmLTcPoVpQx/slz976y2QGBXGeYVBRfDVF64AddkB2EVQ+GglIBE
 49z2xIBUOciRUyctV0Be0hb6AN2PAdY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-jUDkYh-tNBS0oH09LViOHw-1; Tue,
 11 Aug 2026 16:13:29 -0400
X-MC-Unique: jUDkYh-tNBS0oH09LViOHw-1
X-Mimecast-MFC-AGG-ID: jUDkYh-tNBS0oH09LViOHw_1786479207
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33C0519560B6; Tue, 11 Aug 2026 20:13:27 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2E49423; Tue, 11 Aug 2026 20:13:26 +0000 (UTC)
Date: Tue, 11 Aug 2026 16:13:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alexander Bulekov <alxndr@bu.edu>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] tests/qtest: Do not use versioned pc-q35-5.2 machine
 anymore
Message-ID: <20260811201323.GA196609@fedora>
References: <20260811183144.190135-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8ax6qQeLvPVTzRS8"
Content-Disposition: inline
In-Reply-To: <20260811183144.190135-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--8ax6qQeLvPVTzRS8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 02:31:44PM -0400, Stefan Hajnoczi wrote:
> As of QEMU v11.1.0, the v5.2.0 machines are not usable anymore.
>=20
> Use the latest x86 q35 machine instead, otherwise we get:
>=20
>   $ qemu-system-x86_64 -M pc-q35-5.2
>   qemu-system-x86_64: unsupported machine type: "pc-q35-5.2"
>   Use -machine help to list supported machines
>=20
> See commit a35f8577a07 ("include/hw: add macros for deprecation
> & removal of versioned machines") and f59ee044067 ("include/hw/boards:
> cope with dev/rc versions in deprecation checks") for explanation
> on automatically removed versioned machines.
>=20
> This commit message is taken from commit 9eef3854d309 ("tests/qtest: Do
> not use versioned pc-q35-5.0 machine anymore") by Philippe Mathieu-Daud=E9
> <philmd@linaro.org>.
>=20
> Cc: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qtest/fuzz-virtio-scsi-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my staging tree:
https://gitlab.com/stefanha/qemu/commits/staging

Stefan

--8ax6qQeLvPVTzRS8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmp7gmMACgkQnKSrs4Gr
c8gmfAf+OWrs5FA4ysBo5wdLIO+7Im/4OWrW/48qScZeztE2vB1bt8WEWMNSt1CW
dkWAiHRk34ftwggCBYYkL51HliFZT8zqbrox6b/vrEoF31ol63vgPiYRe5ortyhK
TBhyABjndtg7ZwVSltGxbJBEbifkoJHkTgqcZI7b+07xiFcXnVGC088h2mq8ZlYd
Qw3RPHdaY0EetT/Sqdus+Th07L4Y0DhNeWUw6Yf+PhXd6yHAQ7vwH6cWB5gQJamm
EKrOK8521mPaAI1mt42c770uCCHOtt/k70eOgHFlvHW9j1zGL/qGH3jflcXWlBJx
DXzVsetBF7CvzEiAYtlnt9znA8FviQ==
=ZS44
-----END PGP SIGNATURE-----

--8ax6qQeLvPVTzRS8--


