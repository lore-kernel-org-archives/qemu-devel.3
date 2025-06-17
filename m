Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489A8C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYeM-0000gR-DI; Tue, 17 Jun 2025 11:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRYL1-000126-0s
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRW65-0006Jk-Iq
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 09:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750165885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h2TGntcr+zj+u3r8lbaMfesldLtCByeQHNI1Obo+p60=;
 b=gyfGs+twX+rEldNRoo/8f+fRrmZJwyetpUVsj7fil5cXeCFY0o8u+QNI9k3YH3++GYj0NQ
 KVCBiZnMfDp6iNxgpYg4H/8sH9xDRGLolwQoKkDOcNtKGTJoAbhZBpIG4k5r45cePdb5AM
 NLXANAdyr92K7H/x6HIFZ00tU/VGeRg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-ip9HfxA3NKOx12fe3hPFmw-1; Tue,
 17 Jun 2025 09:11:21 -0400
X-MC-Unique: ip9HfxA3NKOx12fe3hPFmw-1
X-Mimecast-MFC-AGG-ID: ip9HfxA3NKOx12fe3hPFmw_1750165880
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E4061800291; Tue, 17 Jun 2025 13:11:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CED9F30001B1; Tue, 17 Jun 2025 13:11:19 +0000 (UTC)
Date: Tue, 17 Jun 2025 09:11:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/2] QGA patches for 2025-06-12
Message-ID: <20250617131118.GA115022@fedora>
References: <20250612140857.47286-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y+G0MHw9H0SdMt49"
Content-Disposition: inline
In-Reply-To: <20250612140857.47286-1-kkostiuk@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Y+G0MHw9H0SdMt49
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--Y+G0MHw9H0SdMt49
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhRaXYACgkQnKSrs4Gr
c8iefwf/TTZnygPWGIS12H9rjNHg4qJKDQcAceYTlNlvVMGH0Pw0DGi0I1DM2UXj
d/uNFGN9n0Dl73LaP0T8oorUwlR1oIUWhJ5nJP0fsBo+vznNyMnMpSJU7tib1bn7
6Uhq/h+4y9+yb+k+5F1YciEhhCNWvIdjg1lgZeWe8tB5UaECRUrGU9VNgztzPMo6
JvDYEbP2GrkUotJ5xkEfr585xDiOw3AI/CEMnAL2phgJiT8SWKoteZrtgAWb9lUo
jUP4GsE8GHyXYBIsYZGHBUwpmK7c9Oyq7r+fpvQLcSInBNIlTQ0AUel/LQPHYLPJ
GbpH1+W4liTpC1vFFmoBQRLYa+nOAw==
=n+ps
-----END PGP SIGNATURE-----

--Y+G0MHw9H0SdMt49--


