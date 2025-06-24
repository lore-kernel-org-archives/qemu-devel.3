Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1B7C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7YR-0005Lw-5F; Tue, 24 Jun 2025 13:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uU7YN-0005LE-Rd
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uU7YL-0000SN-QG
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750786523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z1Bphjo4AxqQ0DRouHJ1+8ecvwo1iEElJ69rmOysL7M=;
 b=h58YU2P3zNHbg7CkqWuuYi5j0+Ot4jmHh1GthA8tMItnVGIwwVGNI6nKc3aWdz5Zu4JIjD
 CBQWaiZKsbZgAPEobQe89wi8pJzxrUImEOYXnZ7CwnaN9hpAlj1k+U369cp7MZFZisjXjW
 J8SwZSc6A7Grx833x4ZjlQBeU+XxE8M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-CPuVaZJ1MWis3QMNkwSUgA-1; Tue,
 24 Jun 2025 13:35:17 -0400
X-MC-Unique: CPuVaZJ1MWis3QMNkwSUgA-1
X-Mimecast-MFC-AGG-ID: CPuVaZJ1MWis3QMNkwSUgA_1750786516
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D4F318011DF; Tue, 24 Jun 2025 17:35:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.196])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDF5119560A3; Tue, 24 Jun 2025 17:35:13 +0000 (UTC)
Date: Tue, 24 Jun 2025 13:32:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PULL 00/11] Migration staging patches
Message-ID: <20250624173225.GA16131@fedora>
References: <20250623200656.1882674-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fyFvU8pgx4eoXV/T"
Content-Disposition: inline
In-Reply-To: <20250623200656.1882674-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--fyFvU8pgx4eoXV/T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--fyFvU8pgx4eoXV/T
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmha4SgACgkQnKSrs4Gr
c8jb9QgAyahmdjNSiVnf8nLy1dwnqAKI4s0wztCromMpU5Wx9yp7y/C8htW8RRck
dm0QZnRETJEhlsPNuRcKLrzak1etZTb989yHJZoTRN3w/W/vKesSMBukHPcEmWOI
q6cmenGu0y00ZlCjeQ6J9nDp/u0JZtsDdRVulH9ukHflDj7rbKhdWit073YLC/Uq
Vu/Pye7/eCrFtsYDlMJgzKYGxQ0SsfKA72qMD7P8ANhqXL7Rt7qeDay2NG0oT+7y
np9Jcur1ii7K7DZ09qgFj6o1CBTGtPoF/0jlHKZQkjsUeDWnxlxXvgTsxjIXi+tr
R2eVTQVi9WBnoA7r7EXXlITxDq/B7Q==
=zSAS
-----END PGP SIGNATURE-----

--fyFvU8pgx4eoXV/T--


