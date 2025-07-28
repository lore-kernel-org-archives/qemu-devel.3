Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE4EC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNzw-0001qd-Cj; Mon, 28 Jul 2025 09:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ugNw5-0006nM-GZ
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ugNw2-00037V-2Q
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753709429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/rbm2SU34p4El3yDKLAbMqm+2gY/LAdhVQXICTf8HZc=;
 b=Rzyls7rspOXx0KOMQPDdYmXts7d31n9Axa75uZHfjZLFw5ZGF5ty41QvhsrvOVNDHbkGs1
 5tw2qgjIxAWnt8JLix57XDMrHfxW6U3UgoSEvnKQsnV8xEtJkDHUeXWmVZH/KeY0LX2kZs
 PTVGmspcxgmtOTUH+VWkFRVqTsWrTqo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-vcIbiXDsPuubf78NYqi6HA-1; Mon,
 28 Jul 2025 09:30:25 -0400
X-MC-Unique: vcIbiXDsPuubf78NYqi6HA-1
X-Mimecast-MFC-AGG-ID: vcIbiXDsPuubf78NYqi6HA_1753709425
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5A22195608A
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 13:30:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.147])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6307719560A2; Mon, 28 Jul 2025 13:30:24 +0000 (UTC)
Date: Mon, 28 Jul 2025 09:30:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/4] Rust, target/i386 patches for 10.1-rc1
Message-ID: <20250728133023.GA62136@fedora>
References: <20250725125412.1128617-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JeaX7ak6VJ5bEa3J"
Content-Disposition: inline
In-Reply-To: <20250725125412.1128617-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--JeaX7ak6VJ5bEa3J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--JeaX7ak6VJ5bEa3J
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiHe24ACgkQnKSrs4Gr
c8iKeQf/dlIWY/GDjX5T+egBU2iNHgxvxBdcCnYYtqOhxZFSk7RKBwtTkumBz5a8
QA8IY3FL3FAQIMA3QdfNwmer1wBuQk2XKiD6WMVnn5FLZrl6gmKTOOygfYMD102Z
HT+Q3C7BfRp93z9GrP8A76nZm68PxrlYI3TXP2kl59BdkeogL6dxTjZXIBXIotnn
8wYtrmW4zDfF7qgifkWqMMIM5wd8xdzIiFoZt6qPdvK24JtdGkPWSYNahVrDjnAC
P0flSWYQhsP30lyOQuXVjyndat+TfKKSKtjSvo6l9yHw+mkJ3CwdwAF28bxnNO5m
ZLvH0JNcSpPnfoEOvK0JwxaWRYqCYQ==
=Praj
-----END PGP SIGNATURE-----

--JeaX7ak6VJ5bEa3J--


