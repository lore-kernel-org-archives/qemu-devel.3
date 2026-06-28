Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC2BC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdnI6-0005VD-G4; Sun, 28 Jun 2026 07:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wdnI2-0005Uj-AN
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 07:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wdnI0-0003Pp-8G
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 07:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782644579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e5Ud9dWT5ez1TnJXcx2OMkKfQAQ+FZO2SWXTyd4uZSQ=;
 b=FCI42DMdPFTDfWZBXNy6Ms/a0pyhwKQpkSFGw6/07nsHlPRCe4/j/RPcfwNjmgN30h4pnT
 SwdEPLagFYRF06rL2yqqyTsxyVpCdyCd5c5z1VYEGT93cGOWPmZnVQRkIpDB0PA+WYZ8sp
 rwpCGL4ssPpIG7BRZwSrotqweoXyQYc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-gsqiOIkUOj6bjTaZmywT8Q-1; Sun,
 28 Jun 2026 07:02:56 -0400
X-MC-Unique: gsqiOIkUOj6bjTaZmywT8Q-1
X-Mimecast-MFC-AGG-ID: gsqiOIkUOj6bjTaZmywT8Q_1782644576
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E58091956088
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 11:02:55 +0000 (UTC)
Received: from localhost (unknown [10.2.16.34])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D09AD6E; Sun, 28 Jun 2026 11:02:54 +0000 (UTC)
Date: Sun, 28 Jun 2026 13:01:48 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/45] target/i386, CLI deprecation patches for 2026-06-25
Message-ID: <20260628110148.GA350800@fedora>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lx9Z7c0+gaEu2X4P"
Content-Disposition: inline
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


--lx9Z7c0+gaEu2X4P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--lx9Z7c0+gaEu2X4P
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpA/xwACgkQnKSrs4Gr
c8gQmwf9GzkvDfTximBfdzh9mJVyf76TNDAob2woTi26GdhlSHofB7gEsU05d+Kk
5vMrSOZRRLy1BscI7TT+ymAmO1T98Zrenz0iVJGQhmSv+KD6a1dqoVBmXheZLsEw
6PdqRf/E0fi7Y+gVIKNvhlHwh3D1c9DwuJnhgiuSQ9lLA2H0J0JZvcJOxbZULXwT
60ru4yLn1A3YGqM4ACtwZirJzJYpl6gApIw6yhqEB6jCEKY6AKWQ3B1IwEaydvKU
nYq0mJbZR1P8t5GHLM0MXOFjgc+J0W4lDsTgSU9dWVm7FU4LOsU3S19l4zc8on3B
bPqRtr1xU0Z0csAPK1zwCpE5MG0R/Q==
=jhak
-----END PGP SIGNATURE-----

--lx9Z7c0+gaEu2X4P--


