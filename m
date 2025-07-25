Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466EFC87FCF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKIi-0007KB-0B; Fri, 25 Jul 2025 11:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ufKIC-0006iK-4O
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ufKI8-0005XJ-8y
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753457095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tkBOOJtduUiB9TfvrVi+7aC3ICYbpVR/s41PFX+ahcg=;
 b=aeHv/v7vQyFQ9GH7cAklKHg7QJspLhOnt5SEu9VHLfRxd6j6K638nmtyskFw24/ZP++304
 Cj8714NCw5bMNBesmBns1QJuQsjuOh7cum+8LL5S0GV2UXQPR8UaBPflWXZ0X1kU5ekyTa
 7WzM13jRVHLnqkZkER4UeKs4btzhAK8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-acOJa7n6PIeY95c6YiAP4A-1; Fri,
 25 Jul 2025 11:24:51 -0400
X-MC-Unique: acOJa7n6PIeY95c6YiAP4A-1
X-Mimecast-MFC-AGG-ID: acOJa7n6PIeY95c6YiAP4A_1753457091
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C523E1955F25; Fri, 25 Jul 2025 15:24:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.248])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F37F21956096; Fri, 25 Jul 2025 15:24:49 +0000 (UTC)
Date: Fri, 25 Jul 2025 11:24:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 0/7] Migration patches for 2025-07-22
Message-ID: <20250725152448.GA603918@fedora>
References: <20250722234215.6807-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RJdPqnBuhQIbcvJb"
Content-Disposition: inline
In-Reply-To: <20250722234215.6807-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--RJdPqnBuhQIbcvJb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--RJdPqnBuhQIbcvJb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiDocAACgkQnKSrs4Gr
c8hoQgf/bZvmhfQvB0xbfO/wRUlc47SJNiuAlaw+kotIFwB6vTx7r5eQhrgSZuj2
yIGSDuVqn1cJk1rNhU6duqtKQINuPnzykPkGPNDW2MXABJkiKnpn1i00BbRJtoaV
kZLQX5siL97Fzmn7yoMowUQ6nyszYrlk6kYtvJbKUiVyUVgfa+r7w41NpxSMfmhY
R/ELSOHxL5Iq+5Ikgp8CTPXqoTBKbDpVz4WQvWPfBsN9+fSVR365Wn6V+uyCukDD
cjvqAz6knJ8ooQcxgiPrDjniu7tSSF4b0dXsgqT5yCR2pSkOzGyBCceb/E+AcLLL
4NZPnEPguv9dQZ+STr9IBzKQQYAenQ==
=n5q5
-----END PGP SIGNATURE-----

--RJdPqnBuhQIbcvJb--


