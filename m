Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDC8CD3439
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 18:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKgqw-0005q1-Ec; Wed, 06 May 2026 14:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKgql-0005m3-7y
 for qemu-devel@nongnu.org; Wed, 06 May 2026 14:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wKgqi-0006oE-Nt
 for qemu-devel@nongnu.org; Wed, 06 May 2026 14:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778091595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G5JUKQ3rHb5x7/ZMIX6EkjuvYoZZbCSw7wuwt2YI3hk=;
 b=SUFsfHwrzfMQeznjbgx8BUNDktzSW5xYI9wkL3q6p8NftwozgS9YLgIQXdLq69Z89JsrbL
 YFMgy2G5rWVAaL/ia7HVz4xzu8pNjPIJxZpUaewi7rVXSAvHKl8KCCSi7sN5PRSKmemk97
 omn/8SicfBDrDiRkYGc1WJGsQqWayNU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-xa7GoqYpP66NLeHJQTdarw-1; Wed,
 06 May 2026 14:19:53 -0400
X-MC-Unique: xa7GoqYpP66NLeHJQTdarw-1
X-Mimecast-MFC-AGG-ID: xa7GoqYpP66NLeHJQTdarw_1778091592
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB9501956055; Wed,  6 May 2026 18:19:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.44])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 770D91803A8E; Wed,  6 May 2026 18:19:50 +0000 (UTC)
Date: Wed, 6 May 2026 14:19:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 00/23] Next patches
Message-ID: <20260506181950.GA208960@fedora>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q4YnS/NK9CZNmEgD"
Content-Disposition: inline
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Q4YnS/NK9CZNmEgD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--Q4YnS/NK9CZNmEgD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmn7hkUACgkQnKSrs4Gr
c8ik2Af9EDQgt7xsCJ0TtdI1QrvL7PYVW8mf1iuzoCE0Vj0k4O9af3mu7LGrOFQw
EZb+Cg+OTBQGuctQgOXsyKXkhgiWwU52nHhIOMP/qGKGoD5ZaDFRoi4WaiLocZXn
SMFjEYbEj6m+Np7SiJyfe7SBktcEEI4lMcs/bMt5NbSwXOC09/GBcy/ExG9KFQQ1
nvdhPY9Vf5njPJQiXmS1CBKpWk7MJ9bFqti88tjyDH/kdH5X2KgvyGud9KVzDEP4
/eqGlJ+OS0RrcelQ/piUysnjGg6jAcflEWm4gEO5HdFQnzi92Zt7q72lR41lMdpe
FzZgQ0gqYVEq/U+iOhui5QfP0mruJw==
=ueEU
-----END PGP SIGNATURE-----

--Q4YnS/NK9CZNmEgD--


