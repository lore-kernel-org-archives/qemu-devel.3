Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41069C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 05:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trrmv-00012N-Ma; Tue, 11 Mar 2025 01:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trrmt-00011h-Pn
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 01:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trrms-0006V3-C5
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 01:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741669457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6S2yWdk92FCjpnBi/j9+Y5EEqiVXLsO+6X2BA1YAUk=;
 b=ZpRIDVsGb53kX1quFfJruEKU7Bpr99+5GKPUJMiCTF2DCBJDox81Bkh+tYbhVjEgD49Kfu
 F9tHS8Qq1Q7Zf1I/a3zjGt2Rsn34r/BN8/3NrX0tgNR0oKlYSwC77rT+r6BZNlq/0TaUTZ
 p41xyUurJr/sJmz3ouk64FhBuHCUfaE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-HYTPZJ9xMz-qbWRQJOnDNQ-1; Tue,
 11 Mar 2025 01:04:15 -0400
X-MC-Unique: HYTPZJ9xMz-qbWRQJOnDNQ-1
X-Mimecast-MFC-AGG-ID: HYTPZJ9xMz-qbWRQJOnDNQ_1741669455
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 065A719560B2; Tue, 11 Mar 2025 05:04:15 +0000 (UTC)
Received: from localhost (unknown [10.2.16.75])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3F1D19560AB; Tue, 11 Mar 2025 05:04:13 +0000 (UTC)
Date: Tue, 11 Mar 2025 13:04:11 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL v2 0/3] Migration patches for 2025-03-10
Message-ID: <20250311050411.GA602871@fedora>
References: <20250310223440.31328-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XVXieqry+E0uKKdx"
Content-Disposition: inline
In-Reply-To: <20250310223440.31328-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--XVXieqry+E0uKKdx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--XVXieqry+E0uKKdx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfPxEsACgkQnKSrs4Gr
c8jJSAf+NcECHFs7Kr9ApcngArlBvQy4IP3eXAPha0fqSorJzb+WSx4dDK8kZ6+n
W36cReXts4JhAa805gra4QwLQliXcjqNm0wIaSSyssOUr4tZ4WxAzJuEJA2roEze
QYl19xMTmqXKDwc2DqCZ17OZerQgnCwiyxvcDTE0VoAbsptkH1S5hoeMlW0gKVNw
qABSzPIRWdqR2vzxdB7XEN/sovhC6/ufCBo7hz5P2WPlQRUkHXAHLWFjftmpjEVj
RFtIW8Q5DQ/5scyaR8tJDLj3jPur08qvzwGPR50JcMdBZ81AV8x5ANZ1SKmsKRIT
bmxjAzEnxejENSSs8xcWEiZQRMTI6g==
=pgIv
-----END PGP SIGNATURE-----

--XVXieqry+E0uKKdx--


