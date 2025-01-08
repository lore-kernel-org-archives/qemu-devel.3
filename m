Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EEAE77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 19:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVbVr-0003md-TA; Wed, 08 Jan 2025 14:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tVbVf-0003mF-Q0
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 14:14:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tVbVa-0005Dj-O5
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 14:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736363662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u4lbV4oBuMUsVjULWGR7v3XbBX6BlV2flSamLKP7eR8=;
 b=ZQ5v+jCEgXaPuRCpf1kduojioD8us0QDQiyCi6Torw+LkDr+9njvSVdQK0ubFiBHPqBO52
 V+Ulx+Xew4FbakAwa8cKubx8Tm2mEz7gPt7l+St4Y9RfQN8WwM0Y7wt+TE44V8/cYsm7ep
 inHP3/ONUzYMfiBaoFmWw9ETS9L3vY0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-xLhKmGn_PTKWOURbonsYfA-1; Wed,
 08 Jan 2025 14:14:19 -0500
X-MC-Unique: xLhKmGn_PTKWOURbonsYfA-1
X-Mimecast-MFC-AGG-ID: xLhKmGn_PTKWOURbonsYfA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E28A719560B3
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2025 19:14:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.61])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F4F319560AE; Wed,  8 Jan 2025 19:14:17 +0000 (UTC)
Date: Wed, 8 Jan 2025 14:14:16 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 00/14] Fixes for tests and removal of deprecated features
Message-ID: <20250108191416.GA156472@fedora>
References: <20250108084511.238458-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NVrZtDCdsiZY837h"
Content-Disposition: inline
In-Reply-To: <20250108084511.238458-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--NVrZtDCdsiZY837h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--NVrZtDCdsiZY837h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmd+zocACgkQnKSrs4Gr
c8hhnwf+PnlVMzc0j7FG7RcC0suKpwITRJ6desTDQv4S42DV17NaZOhOBFx2p9WG
MCbiNjthJAU1tWjHRcKZyw9hItt6h7nKglvZf6Gj9e2LuCh3zBh+Kf+KIFxIrIyi
jzumZ44kVg3l1RpRb2F7LuWmnT/4q9mqOloMB+Lxb/fLbxQEtHy+akrH4Foe1NCQ
ao24un5EeopaH3wMSPqM72u/lW8QHAPh+liouB82WfNKmsg3+h/n9UHERvNZ64yc
5FHbHyNiVZM21F/pIPHhSkysxcNw8mFtvR+qckhpEMEVHMu9kXaW3eLijbCHH7T4
0XVxOreI16vUpidTlQRPWkzJTMtKcw==
=PL3Y
-----END PGP SIGNATURE-----

--NVrZtDCdsiZY837h--


