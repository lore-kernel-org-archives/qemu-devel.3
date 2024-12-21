Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D4AE7718E
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 17:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP3el-0008Ep-7D; Sat, 21 Dec 2024 12:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tP3ej-0008EV-E4
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 12:52:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tP3ei-0003ze-1k
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 12:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734803564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ti59jTsLg0nD8VeEQnGGIf2X/c0VHhlfBEz4lZh9dMk=;
 b=Arq8QzJs5upQZdvX8RnDRICDikoa/ePY5qxiwz185s783183RwTZCI4ZGx5+qCzOzQZnU1
 MXIXZtF7C0vqf65RVaAOUFUoCsa/cxNKTr/KZ55ajFqOU1TrXmVdEBSquybyjSOEQGXM+7
 LAtEmZdLpoVoMeLpRIzYD1U9FOCUCkE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-2wFz8fMxOdOoGQsvj8x3VQ-1; Sat,
 21 Dec 2024 12:52:42 -0500
X-MC-Unique: 2wFz8fMxOdOoGQsvj8x3VQ-1
X-Mimecast-MFC-AGG-ID: 2wFz8fMxOdOoGQsvj8x3VQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00F0D1956086
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 17:52:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F9571956052; Sat, 21 Dec 2024 17:52:40 +0000 (UTC)
Date: Sat, 21 Dec 2024 12:45:23 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v3 00/42] Rust, qdev, target/i386 changes for 2024-12-19
Message-ID: <20241221174523.GA857243@fedora>
References: <20241220143431.653644-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+MR87Lj1diRkRKw2"
Content-Disposition: inline
In-Reply-To: <20241220143431.653644-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.177,
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


--+MR87Lj1diRkRKw2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--+MR87Lj1diRkRKw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdm/rMACgkQnKSrs4Gr
c8jKHwf+P7LuBnOmSysqvwrGNDCR+yZoRSe0JSNCdsBe7ZxYp1CjPou6kKgH+qIg
CIWVXGvGPyx0eW6TsrXR4o8VkfCOqMO34oqAl3riSBobbCaCxs6Y3+Ig7Sf37Mwr
BQP7TFQo/Yj4oHZ49u5Y20iEkKoc5Mhoy/AyZrJ6nEIvIdHtluDP4ylBUdenx6Fk
MtzpnOJTLhv4BVDcN6JagC41wcA+iLTjoKp6+QlvKMQbQmPghbq8DDHuThdYOCzd
4wu+QUs/f93E0m+V/kZ+Tv97l8Sqe7YyEW7lYdXH7RhCp1zeff2SsrCmDmWxakTQ
asv2IqNTfgHCiyiQbzReE6PZeIeErA==
=Os5O
-----END PGP SIGNATURE-----

--+MR87Lj1diRkRKw2--


