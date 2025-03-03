Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD26C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 12:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp4fJ-0002a5-GV; Mon, 03 Mar 2025 07:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tp4ek-0002XP-DH
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:12:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tp4eg-0004Kv-V9
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741003937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v3aA4ZrqlaDf4B28oWxjJ9dOqQE4/2g8elFbB+mIAmQ=;
 b=PGqXQxXI5hWX4UjloVKn/hJMK79l9mnNLXHsjlaJBjhj5c6aiHDXCLTcbll81Ta1d23DXw
 9dzOkgDqk/ZnvIlbiGI1IMJRUUEGWmUwyuxVSNdKLemoc4uoUVcnhtSsvxPGUwHHdzRhsn
 ++HpCUKwjicxQ/G2Q1H7+S8t62KMkAw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-ATCefLRqMTiSapEv6JCCOg-1; Mon,
 03 Mar 2025 07:12:13 -0500
X-MC-Unique: ATCefLRqMTiSapEv6JCCOg-1
X-Mimecast-MFC-AGG-ID: ATCefLRqMTiSapEv6JCCOg_1741003932
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EB3A1944CEE
 for <qemu-devel@nongnu.org>; Mon,  3 Mar 2025 12:12:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.61])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAFEB1800361; Mon,  3 Mar 2025 12:12:10 +0000 (UTC)
Date: Mon, 3 Mar 2025 20:12:07 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PULL 0/3] SPDX checkpatch
Message-ID: <20250303121207.GA215563@fedora>
References: <20250228154450.3185564-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hc2tQGMYlesg3TWR"
Content-Disposition: inline
In-Reply-To: <20250228154450.3185564-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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


--hc2tQGMYlesg3TWR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--hc2tQGMYlesg3TWR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfFnJcACgkQnKSrs4Gr
c8iYYAgAtAxe0nXDM4y7+PBf5ivZk4C4HRRJaKrsIwke1+V9DEft2ey+wSoVTJnT
C2ytXKKyTQbY2G6jfDW1FiXw3ZIdf+afHBXQxZPBM3zpzbloaJj2zyPh6ZjTazeA
DVbkubBIFp2clwJPER7NPaAkcnZeKuqaKKb/kZ1AfpaTZWRAnOE8B5ZppfMxLZTB
kpeYNZSHbYwjZQlyfLmRC2/fzMcjK2J1I9VDcLunpmGHszZSiAamL6pe08F1rBVb
b5OFkR064kBKoWZB2Rsu2wOiZ6ez7jfgQMBx9qDZTLhnvoJz3UGF9QC9RfNdLCrv
+0WjNNOXLz4ZrGf312FzVZoi+zGP1w==
=slnG
-----END PGP SIGNATURE-----

--hc2tQGMYlesg3TWR--


