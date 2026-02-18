Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CAAE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 20:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsoZy-0001gs-6Z; Wed, 18 Feb 2026 15:55:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vsoZw-0001fb-Oe
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:55:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vsoZv-0000hg-FU
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771448122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVcCNmjU6eTCFSAhvCq6gVPNtSuIYEUzu70Z2uqg0Go=;
 b=diLYyd+PxRznL8SZYRLSHugQ3Sw48ciSXrNG50mYP4MZ91AFTVycHKOV4giu52hCYZ6QRh
 aEXSvSeuxQb9ug3UVAbBY+ks0935znsACMaYnmghFwmnN3/pUPz3y8xd7pBTM/gOxG4s9f
 UdXmCC+xuhYgVPJOCqpH9l7zOaoulNI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-U-sxCxIbMwayZy7xnbs4_g-1; Wed,
 18 Feb 2026 15:55:21 -0500
X-MC-Unique: U-sxCxIbMwayZy7xnbs4_g-1
X-Mimecast-MFC-AGG-ID: U-sxCxIbMwayZy7xnbs4_g_1771448120
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 070CD18003FC; Wed, 18 Feb 2026 20:55:20 +0000 (UTC)
Received: from localhost (unknown [10.2.17.113])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34124180066F; Wed, 18 Feb 2026 20:55:19 +0000 (UTC)
Date: Wed, 18 Feb 2026 15:55:18 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V4 3/4] iothread: track virtio-blk devices using IOThread
 reference counting
Message-ID: <20260218205518.GC620422@fedora>
References: <20260213171622.55629-1-zhangckid@gmail.com>
 <20260213171622.55629-3-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7GBJYTkJD72b0ZjT"
Content-Disposition: inline
In-Reply-To: <20260213171622.55629-3-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--7GBJYTkJD72b0ZjT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 14, 2026 at 01:16:21AM +0800, Zhang Chen wrote:
> Future work will extend this ref/unref mechanism to other iothread-capable
> devices (e.g. virtio-scsi).

All IOThread users should be tracked so that this mechanism is used
consistently. Otherwise it will be hard to change the behavior in the
future: software that runs against multiple QEMU versions won't be able
to rely on finding certain objects in the list if not all objects are
added from the beginning.

Stefan

--7GBJYTkJD72b0ZjT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmWJzYACgkQnKSrs4Gr
c8iLFggAkeTvxQ3i11pAREiO4R61JC1S8TfvSQI5SxHqcsNAiXN1n42e8VBD+Gxy
vHnrMJxKOXIfh2AyEYFlV9HWJCY+Oy9D5VCszuvb3C+22OUqivGM+CjqdWf5jE+Z
JfMHWE9MWcRjZ6uwm1z5MNbYWs2wndVW5x/CI9NJcS4SU3QqhULuXXLwVdvwts1c
ocP8a3VSiHK5Iytk6xeognFN1bIMOEmrkYQ7kIO6dBnzOAkuoQmUAX0mBHtYaibi
yQkWQYq2lwwIv350Da0SlCx5fqX8PtrDUzK/INgtwt88fUEMna87YSyuLmLH/q9B
DUQ/GbchU2M9jjmN9KW0QWNVkkGsjQ==
=1N6L
-----END PGP SIGNATURE-----

--7GBJYTkJD72b0ZjT--


