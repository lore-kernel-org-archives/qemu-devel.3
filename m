Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1B6E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 19:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQtQI-0003P6-9a; Thu, 26 Dec 2024 14:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tQtQG-0003OC-1k
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 14:21:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tQtQD-00070z-Pe
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 14:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735240882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EXUSUsZuJVoaSnV3ULC646uuAbqzK1wNRvIpShZu/f4=;
 b=YlW8eMwIEfdbyGd+/xklmYyHjZAUaHtfcFgffUK7HmssE8f3T81i5bSPfg23NV7I+e7SzH
 1ldgYOjgSe/0UBO500A5rn0vtqU2eHC5xFRFN+NIK1gvsr8AnHaF+K/N4CEB1+7geHgovB
 jF+GlxQDylNk9ZOGYR7LZFVfedZbLYs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-h_47GaqUNMKZgHGFb0KWrA-1; Thu,
 26 Dec 2024 14:21:20 -0500
X-MC-Unique: h_47GaqUNMKZgHGFb0KWrA-1
X-Mimecast-MFC-AGG-ID: h_47GaqUNMKZgHGFb0KWrA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0674519560B4
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 19:21:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.87])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C31621956053; Thu, 26 Dec 2024 19:21:18 +0000 (UTC)
Date: Thu, 26 Dec 2024 14:21:15 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL v2 00/17] vfio queue
Message-ID: <20241226192115.GA960922@fedora>
References: <20241226083742.690265-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Rn2fN3Z8uzu2CH30"
Content-Disposition: inline
In-Reply-To: <20241226083742.690265-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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


--Rn2fN3Z8uzu2CH30
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--Rn2fN3Z8uzu2CH30
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdtrKsACgkQnKSrs4Gr
c8iPdAf+PyQet0T71WJoVF0rawf8yuFCbyhaNXKipP9a/OCS45IWqHkN/qgIPI2B
jEVp3Ot+iKLB3ePE73M4GJ8MTsB2aFQeJgPi0Klj6NPu+dCttX7vrQtVMD0pdhre
BhvDaGgdpBWYrxCJq/PiZUmO9bG0+TWNJoF4Edqrm34KVJKcJoMhU4mjUTzLS3ul
UvWWEUNR2gyAPh3lPRL1GGJhinH5SL+JOahzLau0O+2m5I8d+7DVbrKVgOiKXeTm
CzGkHRG29TGqWxxpw5SphPitiKsuZE7VOvbd6JxQ1MALeDnQsXOHGyYKh9dlbpik
t1mSJOxYsRI9nMYr7G/MOyDclJyyMQ==
=JTRJ
-----END PGP SIGNATURE-----

--Rn2fN3Z8uzu2CH30--


