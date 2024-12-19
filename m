Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51888E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJhC-0000Xm-PI; Thu, 19 Dec 2024 11:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tOJhA-0000Ur-Iy
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:48:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tOJh8-0000nP-T4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734626882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kUkw7meMyqgxqJR4PfiO+EidXjAJIMn6oav8a2bLfdw=;
 b=c77AyQlx+kNnXTqi0aNo7SEu2WAkJOhFs17JjzODCrsxW9S7PJiLa0TMx0FtpGw+l6XP3n
 rX7QFgt2yRvjqCBeKTHrOQtw5aBX85zvZONbocSN7Vz/f9uncrJRInq/5+0QmjWjPV+op5
 ZOp2QqsgK6I1UtQCCRtWBuKBkdMTTdI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-Yj0fWm0LMnqRLA2egCJAew-1; Thu,
 19 Dec 2024 11:47:56 -0500
X-MC-Unique: Yj0fWm0LMnqRLA2egCJAew-1
X-Mimecast-MFC-AGG-ID: Yj0fWm0LMnqRLA2egCJAew
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF6261956067; Thu, 19 Dec 2024 16:47:55 +0000 (UTC)
Received: from localhost (unknown [10.2.16.70])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E075195608A; Thu, 19 Dec 2024 16:47:54 +0000 (UTC)
Date: Thu, 19 Dec 2024 07:29:40 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/19] target-arm queue
Message-ID: <20241219122940.GA692667@fedora>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qn8YDedGPI4ZzQxF"
Content-Disposition: inline
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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


--qn8YDedGPI4ZzQxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--qn8YDedGPI4ZzQxF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdkEbQACgkQnKSrs4Gr
c8gvPAf/XikunHDdvVTGSCrvaL05ZVpYO8c8WgK03zudjKqqGlQtB692g7+/Ejoe
AumKwGePfmF12YQ/P0Wv27YRIiV1BZoMVkCE1Hpbc7vDnATIXmL1hpwnHAHCOHGl
fvDTr0zeDQK2z9AykkrinCHgiWdUFJKxej+D0y7eUcop6JwPrn/hb/27Am6v3Btv
AlmvLq6qJg5Wcyg/R+nZeXd/dTrcIUcqIyLcPTvAPEfR2fJTgCRa+5QPnVFyLTMz
/6aiZY6louObOUNRuK0Ru12DCedEeHGHLhFPlli5ZkgyPWC99aog5n+92SNCb+iw
V3Lnk8hLjeKSDatlOIHakS0lE1FUWQ==
=4b30
-----END PGP SIGNATURE-----

--qn8YDedGPI4ZzQxF--


