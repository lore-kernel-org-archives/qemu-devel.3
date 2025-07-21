Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC55C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 14:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udr3Y-0007ma-Pb; Mon, 21 Jul 2025 09:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udr3S-0007MP-0p
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udr3L-0003HU-Nv
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753106378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jjy4soXLJByikHcJAa+KD5WyHvHrqVm2rnCsQI9/2O4=;
 b=LysXso/IQTLE/5iD5ckHNqytgzAvXZdHGT/ovlhJM/hfEzfdfiAnN9FfVUzsXeEqcWw2Q4
 P3CXAWlDAEE9+wgajxgb1TKKMBceq9mpmIAv6LOWPIbAnu5BxAZR30cDBcMUNbf9MGvc2n
 vjvQV5J7rNoGxBNHzwAE+wLc82upXRQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-MuMd7hjROA6GvTbnRJNTog-1; Mon,
 21 Jul 2025 09:59:36 -0400
X-MC-Unique: MuMd7hjROA6GvTbnRJNTog-1
X-Mimecast-MFC-AGG-ID: MuMd7hjROA6GvTbnRJNTog_1753106375
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F64319560B0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 13:59:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0A621956094; Mon, 21 Jul 2025 13:59:34 +0000 (UTC)
Date: Mon, 21 Jul 2025 09:59:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/5] Functional test patches and 32-bit arm Linux header
 removal
Message-ID: <20250721135932.GA51077@fedora>
References: <20250721081614.262563-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TnwnJBNFsABlGJ/J"
Content-Disposition: inline
In-Reply-To: <20250721081614.262563-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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


--TnwnJBNFsABlGJ/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--TnwnJBNFsABlGJ/J
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh+R8QACgkQnKSrs4Gr
c8j09Af/XU80ZI7o1mCyUqTMMIcxTHRDBs4lNBJmO4xvTeqM6P4NtpVGRWNf4CXG
PcuSZAzLpdPMXbOOT4iEdA3+Q8fI6Wug713eQgpJXK+FC+G4owQUjBXM80P0XmzU
eib5MSJAUjsKmYBOZsyJWn7kFFl28AE0k0a6PNaLBuifhILzcDT5NKkG7foI0nOa
7YRxYULiZYgiRn3MglNJKvimOjzVqIYwZQ6RwIkbB15BRPncXsOvhizHv29KhFVr
rVq4lxjSbOj/od0KOO+Y+uTbNl1bKOrIm8i39IFUXOX2co1er7FfytqVINcFgyhR
pD99RXpULdu96hheoAZz+f7u6EQ4yw==
=CyV/
-----END PGP SIGNATURE-----

--TnwnJBNFsABlGJ/J--


