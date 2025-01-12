Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D5DE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 15:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX029-0003kV-03; Sun, 12 Jan 2025 10:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tX027-0003k7-4X
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 10:37:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tX025-00042m-No
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 10:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736696262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GOTuIMYuKcRM6lFlbApDZ6V5z8ATDhtL+RSEN1WOlEc=;
 b=K6gJeNWJyxHrDZ4fNa+Rt2oQnuIC2G0fTJsN9XtIUnL7Y67u5yRIE+b9wtgMNETWsp7KRJ
 lzbBNkKvY+UfwVPoRa6UCEjMQOLmv+Fuq5DqAB8YuUVCPIGksrx4/DDk7HgMtdhQuLHTZ1
 aWcjN4E3fsBH7gP457CFh98oLciElDI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-23wtQXeYO7iLMzz-rKa6EQ-1; Sun,
 12 Jan 2025 10:37:38 -0500
X-MC-Unique: 23wtQXeYO7iLMzz-rKa6EQ-1
X-Mimecast-MFC-AGG-ID: 23wtQXeYO7iLMzz-rKa6EQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 411B81956053; Sun, 12 Jan 2025 15:37:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BFDF30001BE; Sun, 12 Jan 2025 15:37:36 +0000 (UTC)
Date: Sun, 12 Jan 2025 10:37:35 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 00/25] Migration patches for 2025-01-10
Message-ID: <20250112153735.GA31245@fedora>
References: <20250110121413.12336-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BxdhHSnUhXTWGWT4"
Content-Disposition: inline
In-Reply-To: <20250110121413.12336-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.025,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.798,
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


--BxdhHSnUhXTWGWT4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--BxdhHSnUhXTWGWT4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeD4b8ACgkQnKSrs4Gr
c8iRcQgAkpb04H4oaySO29CF6+HrKvC/NZHJQCGLsHC8bXc3QRYTMRWxgwEmkJGB
5iRJOfHWeYxBnB4D9x9VxRdvW1rb4Uhb0/5JoiajyS9EvatRvnmM4MsiuJ6IJeSI
z1UoqzxEpunKQf5fKNskkrq6UMimrm0YHnfT7uqRetE8F5K9k8H7SDesmnqdNI5U
yghCSZxZUr6D8xWjSzYXvZ9kF0brvjyjk1SV7H570XvaOkDpCUJqp/kRhtsAC1/u
IxkAMryHUMfBmSwfGouxuYCdwvk95jRYAwB01N6jATyLvxd6Dq5F5eHv3sEXYLzE
Z+bT5E17u3i25GRT8QA8kSBHQ1zcOg==
=KcMq
-----END PGP SIGNATURE-----

--BxdhHSnUhXTWGWT4--


