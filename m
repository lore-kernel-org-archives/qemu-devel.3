Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6775EC021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 23:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlcWi-0007cC-JW; Fri, 21 Feb 2025 18:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tlcWh-0007c0-37
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 18:33:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tlcWf-0005jT-NW
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 18:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740180824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5jFSfD0yOwfUZ96Bb3G+y7AK/QkqjtC8dQtGgMcAEX8=;
 b=cDdCf/AGRvLZbwQbEOki7WlVaHDc5N/WaBsRIEmtW2u6RuQMO0SxKldMwLiA1Oe1l+343D
 LYoGugRaZdHAEbVeomPHCxKqmAdGCpheja9uQWz5wfzxk35kiRl4Fqu7y41GC5nRZymFJ2
 jSXSTJBzTD179IInQqb3UL4dv81Jd34=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-_y7S-GWROR2teUXPnqRXfQ-1; Fri,
 21 Feb 2025 18:33:39 -0500
X-MC-Unique: _y7S-GWROR2teUXPnqRXfQ-1
X-Mimecast-MFC-AGG-ID: _y7S-GWROR2teUXPnqRXfQ_1740180818
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5343E19560AF; Fri, 21 Feb 2025 23:33:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6ADEE1800265; Fri, 21 Feb 2025 23:33:35 +0000 (UTC)
Date: Sat, 22 Feb 2025 07:17:30 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/41] virtio,pc,pci: features, fixes, cleanups
Message-ID: <20250221231730.GA15811@fedora>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qViognktsHJHA5AI"
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--qViognktsHJHA5AI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--qViognktsHJHA5AI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAme5CYoACgkQnKSrs4Gr
c8hoWQgAuDCTP31R4rqVJXz0cAvvcE1o1EmWry2ZKI2lTUKWhSuKGkrz7Y80KIqB
woG5xCcAhOa+eO5EpiBXCCPnN7VnKJbcEJ2fYskT57O8849UUaytkhbtKHVmyppF
xaAWAJvNFTWFM7Yfq+iVypFNQxOWaLxPOoigiDZdAAYkY/U2/l0g+dVYWWZxyB3F
lZTwDcW3SdJj+hnKtFf5BpiHHsp3HgUrDgvRUZxpS+G+ElEFv0vvr37l4c68SG40
+szPFFyOGVqj1BsvdfBZ6qG4uTrQL8gWVR/yHc8WfumRh4wbcM1ldRSakihaRn4V
phrAt0ubnYbgMqD3LvJZDo8HJFjPkg==
=cuwj
-----END PGP SIGNATURE-----

--qViognktsHJHA5AI--


