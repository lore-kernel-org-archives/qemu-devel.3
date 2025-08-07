Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303AAC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 19:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk5qc-00050C-Go; Thu, 07 Aug 2025 15:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uk5qZ-0004ri-9R
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 15:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uk5qX-0000zo-Gu
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 15:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754593212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x6yFzOA41+6qOidr15zxQ7h+EXYBAcj1QoeGNwvorH8=;
 b=M5S9qwS+8+DcvJa4Jbem/ct0RJI8vIx2KsCgjTKuO+1dF+NIy2kKWUPKaNPC2YEBxJd21q
 azdftTYLTKnnEzLmJrSmv3OtkaUUcRrk2q8VmBA2VkQsSdVHiGL63r2yNqubBefPDTtFYX
 O66wXVn4aRMOKJ9kb4MZJXyUVk9IfIo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-T_6LpCeFOsOb_p9XsburFA-1; Thu,
 07 Aug 2025 15:00:08 -0400
X-MC-Unique: T_6LpCeFOsOb_p9XsburFA-1
X-Mimecast-MFC-AGG-ID: T_6LpCeFOsOb_p9XsburFA_1754593207
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 600471800291; Thu,  7 Aug 2025 19:00:07 +0000 (UTC)
Received: from localhost (unknown [10.2.16.155])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 698FE19560B0; Thu,  7 Aug 2025 19:00:06 +0000 (UTC)
Date: Thu, 7 Aug 2025 15:00:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 0/1] Migration patches for 2025-08-05
Message-ID: <20250807190004.GA125618@fedora>
References: <20250805202946.19644-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IFOAsvGIuPT46dU5"
Content-Disposition: inline
In-Reply-To: <20250805202946.19644-1-farosas@suse.de>
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


--IFOAsvGIuPT46dU5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--IFOAsvGIuPT46dU5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiU97QACgkQnKSrs4Gr
c8isRQgAhH0YPt2d/IBTPQjL0of+S0mP64dK39azsWN+FdqvYeQMtWzm2k2t5JDZ
Glf817krCTfKoz5cMb7BlrUoimfgLAqQJjEj4smqUrMZYNr6uh1UqQyJWD0UedOI
zM58NPGVIGCPMDH4BKAy5QMfTbhQE/eUAzWZ7UdeiSAqmi/9zxn962jTv6d1THiW
5Je7ucQUSpAmyxSntfD52iUWHwoyXS9vG5ZgDUKn6TjMch0CGa7nf4gG8dTX0Ee4
4+K20UTbzb3RemNsLgOjINN6xp/jWyuuIzYfkznZu5fAcGsqZBxxYJiwPMfZpHDE
U2fO0D2FEDmxOwpgkTwdyITh5BylSw==
=KhXO
-----END PGP SIGNATURE-----

--IFOAsvGIuPT46dU5--


