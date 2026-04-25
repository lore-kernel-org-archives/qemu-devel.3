Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B56FF8863
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 20:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGjA5-0004Tf-Rn; Sat, 25 Apr 2026 15:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wGjA3-0004TQ-Fu
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 15:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wGjA0-0002bB-UN
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 15:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777147167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bdlDS5/1kZb6iO4CJAqSlKyAeDSr7u6cNCDdoqkPxdc=;
 b=E8VGq+hzm4sqDFVqfraP9JVWnQObLHAwWIACwJdZY/TsDsPBT/cp3FqNzOIVTuc4Dorxc+
 770+EKHYs+n2Ijz2v45u/dwc9BPWI4icxw9xQ1uKuvejXckic+0G054ivCkIqsPBrKp2Kv
 DXqE8o8bnzJWHV4HgpVBrUOCPUUO7E4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-snbl1YbaPVCKKxznHNAJVA-1; Sat,
 25 Apr 2026 15:59:26 -0400
X-MC-Unique: snbl1YbaPVCKKxznHNAJVA-1
X-Mimecast-MFC-AGG-ID: snbl1YbaPVCKKxznHNAJVA_1777147165
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FC7619560B4
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 19:59:25 +0000 (UTC)
Received: from localhost (unknown [10.44.32.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 587993000C20; Sat, 25 Apr 2026 19:59:23 +0000 (UTC)
Date: Sat, 25 Apr 2026 08:30:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/25] Build, memory, i386 patches for 2026-04-23
Message-ID: <20260425123045.GA129209@fedora>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LB8r1W0+frAspfZh"
Content-Disposition: inline
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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


--LB8r1W0+frAspfZh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--LB8r1W0+frAspfZh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnss/UACgkQnKSrs4Gr
c8jpiQgAih+OgOOk2jAyiv5tJFvhgufixzRtBEIv3jY3win5i/Te46TdUPsM3Rpz
FuxI6PQ2ARlOo/OJst1O54epIwCYPLkW14ppVSwCcsge48EV13+0QgJwnjFgWFUG
qHBP40Osu81Ru+qzgXNcC5eVq6btPNUp6a0F/CXXl5RdstiN1LgSit7sz+r6fh3Z
t8MeIa+JValDURXaGcaYCqWF0ey1D64EGYDlWlSBo+/sng1KEKoB05XBx55vOxyD
keip9ost0QzaEx9Tz6Z2oOXWnsjtNjemTFMIc5dMXBwhWFLmv0caPm95Kp2AWgT9
OgcpyVCqFfxmUx5MppBULQ2pmRSJYQ==
=WXFn
-----END PGP SIGNATURE-----

--LB8r1W0+frAspfZh--


