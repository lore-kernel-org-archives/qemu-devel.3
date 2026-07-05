Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8518DC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 17:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgR5y-0007JV-J1; Sun, 05 Jul 2026 13:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wgR5v-0007IF-V9
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 13:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wgR5t-0004F2-5q
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 13:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783274246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NsJUT2rKaP8UThsM1Wq/OSRCokk8TCnBESb4NbeZLfs=;
 b=fwlZHzYah2JXCNfjhpbAY684PrEG++E7OuPaIClgBbPpT/s6Z2NjJMC0yyiTQZT5QFc8zj
 OkB9iS2pz9mgKnVioiC91H2cAyTq+ego2uklN8/pel5p4H4cwXHRZ5C4FnKiye5nwn+YOh
 3W6hWO48fjdA1+a8tD4o4vC8KalDQWA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-niSjuB2hPd-8kT5wZjPKBQ-1; Sun,
 05 Jul 2026 13:57:22 -0400
X-MC-Unique: niSjuB2hPd-8kT5wZjPKBQ-1
X-Mimecast-MFC-AGG-ID: niSjuB2hPd-8kT5wZjPKBQ_1783274241
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52C8E1800596; Sun,  5 Jul 2026 17:57:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.40])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89A11180028B; Sun,  5 Jul 2026 17:57:20 +0000 (UTC)
Date: Sun, 5 Jul 2026 19:57:18 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/7] ppc queue
Message-ID: <20260705175718.GA505568@fedora>
References: <20260703044402.79723-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xbm3fkqR7x4dVn4u"
Content-Disposition: inline
In-Reply-To: <20260703044402.79723-1-harshpb@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--xbm3fkqR7x4dVn4u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--xbm3fkqR7x4dVn4u
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpKmv4ACgkQnKSrs4Gr
c8g2Mwf/Wp5+asRZAD4yp+/1wNEY0Eu3S3En2aYSoGsCTDYlRg8v2u7Lh3IvE8Xf
BIXsyigtrbyXRLNZaUA84iFtIhzvCg6Ec4reVpeGAGGq4Pysik5bjZL5dmbjRfK+
GQXz4QmvlqV0ge5BaCIykiThr7VRwTBpn3K01csJM5SFPZeGf07JzU2pq4gEXHmq
WiAm2AC3a2AxhC1pjmZt7DinA8QW5mZ45rZQh0sN1kTVkSNEHKpeLWT+R1Pg2Ryr
kLkQQexdfVE6//v4l/kmTrJt8ZCzusJE2J1mdDJsd0HUuKm6EvWMe91+hI8i3Cpg
qTAOBnv565Do1F0QdoyBluhWjxYg1w==
=KOye
-----END PGP SIGNATURE-----

--xbm3fkqR7x4dVn4u--


