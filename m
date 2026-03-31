Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4411061B3F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 12:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7YDU-0006VM-35; Tue, 31 Mar 2026 08:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7YDS-0006Tz-2L
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 08:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7YDP-00053T-VW
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 08:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774960142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HYG+CFBaItHfVTv2BPCYxG0Ufui0NU45dqzk+cgCmjY=;
 b=MH1tEwMMhiDki1ZPtxtgCUIZRtnyopShfOXKClFcfnAw5sBARCV2UMwtTPZxxZJQPTi9eC
 VUDh88dyDdliHRF9Tn4ptWuoBG36+i6d+fXKrcj7UfNhtK2LasZPdWfyRjDTCxrmNPW9f4
 YB8CrK8XBP9VcHegE5c/BcJSGktKoPM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-i8XkGxFFPEynfWqpvxGCnQ-1; Tue,
 31 Mar 2026 08:28:58 -0400
X-MC-Unique: i8XkGxFFPEynfWqpvxGCnQ-1
X-Mimecast-MFC-AGG-ID: i8XkGxFFPEynfWqpvxGCnQ_1774960137
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2470180044D; Tue, 31 Mar 2026 12:28:56 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8ACDD1800594; Tue, 31 Mar 2026 12:28:54 +0000 (UTC)
Date: Tue, 31 Mar 2026 14:28:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, gveitmic@redhat.com,
 bmarzins@redhat.com, fam@euphon.net, qemu-devel@nongnu.org
Subject: Re: [PATCH for-11.0] scsi: Don't consider LOGICAL UNIT NOT SUPPORTED
 guest recoverable
Message-ID: <acu-A-8D4YAHY3Yf@redhat.com>
References: <20260330121635.49205-1-kwolf@redhat.com>
 <20260330181842.GB179613@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rue3bv+sedtpWcUl"
Content-Disposition: inline
In-Reply-To: <20260330181842.GB179613@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
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


--Rue3bv+sedtpWcUl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 30.03.2026 um 20:18 hat Stefan Hajnoczi geschrieben:
> On Mon, Mar 30, 2026 at 02:16:35PM +0200, Kevin Wolf wrote:
> > When commit bdf9613b introduced scsi_sense_buf_is_guest_recoverable(),
> > it included LOGICAL UNIT NOT SUPPORTED in the list of guest recoverable
> > sense codes. It doesn't really explain how the codes to be in the list
> > were selected.
> >=20
> > As the LUN doesn't come from the guest, but from the block backend
> > (usually the SCSI device on the host that was opened with host_device,
> > but it could also be the iscsi block driver), there is really no way the
> > guest could influence this.
> >=20
> > It seems that on some storage arrays, LOGICAL UNIT NOT SUPPORTED can
> > happen during failover operations. When combined with multipath, the
> > request should be retried on another path instead of being reported to
> > the guest, which would offline the filesystem in response.
> >=20
> > Simply returning false in scsi_sense_buf_is_guest_recoverable() will
> > enable the retry logic in file-posix, and will also make sure that if
> > the error persists, the configured error policy is respected so that the
> > VM can be stopped.
> >=20
> > Buglink: https://redhat.atlassian.net/browse/RHEL-158212
> > Fixes: bdf9613b7f87 ('scsi: explicitly list guest-recoverable sense cod=
es')
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  scsi/utils.c | 1 -
> >  1 file changed, 1 deletion(-)
>=20
> Paolo: Are you taking this through your SCSI tree or would you like
> Peter to merge it directly?

I'll send a PR today anyway, so now that it has the R-b from both of
you, I can take it through the block tree.

Kevin

--Rue3bv+sedtpWcUl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmnLvgMACgkQfwmycsiP
L9YKxg/9G+Tl6+bvzdi+LEMfWvwfqGvvmwLoV5nqy693t5mTZ8oqxQ3Pi/gXD9Hy
CO8GK2nTJ+ndg3TcERd82hFaYZEpPdmHfPbwMFWCxeip9b6ANAEap7YLq08GhLDm
WTjoheQnwaRCBlI/GCHTuvTXlyaW03tYcudSzJkvsklOnwoHPhTZG7Q3zBcoQSzB
7ELWWVLszA3pFVLayf7dwIKLmf0C1W7o0baycBL7hxrFlAkryek3ksNqtpVBU/5d
lhdvEKnI21WuvlkSP2OBKX3t+hsDQXxfklzF6sLoNoERjEsRwnMQE37kVPSPR224
1yw/w8iXCERk+mXZCRKfInq5rHLkpefq9fXslgb01HxNZXbL3qaFX+BAWV2Lq7qT
1yMIV45nVO3zzoVBEH4ayhP9d92ItfeF0l6ilCVsKMJlJ6dhnsJ07Qb12r4FeOq8
BwVGDGV/UEU05JoVKp/mx/IJMlu9EyOEkySBthboePrm1HPqlhX/+rnyd6QEkZ7N
tnkpaaDEROIVswcEg4WBlRf53XIZVAifkhnmVKUQlPrgon4PY9tUQWz48EO6Vlmj
EZKbxYl0sMXkYFNOXatLAx9Flg8Xgah7dHiwzmF0RVJJVCJfN5aNCHOY/UGM6S8i
bYDPR2zlhgvywOUFve+ox3pO3oW4Xqp1DLlVmNpYASWb0v/kB68=
=Osfs
-----END PGP SIGNATURE-----

--Rue3bv+sedtpWcUl--


