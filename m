Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75A7C28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 04:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tswyK-00060B-CF; Fri, 14 Mar 2025 00:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tswy7-0005u6-8E
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 00:48:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tswy5-0001E4-CW
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 00:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741927698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OgwknA0OqK1jeB7aElaM+vvNApnDBftMyaLLTB7XLQY=;
 b=iKATr4ZEh2fKxm1KzdwtXKQHwdjS3C4vjZYgdGfAr62Bw0RsLy6fkqQV39rdewN/O32Upe
 trAMT7/HUUxGtZRSbkFJ4IOZfueLhlqA/cc0L70KpIEgXaMhqOZCoZqWne1QnM3j+TVF4B
 U3uA8QFSrsZeG/WnY+fmpLi+JJADJd0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-xiLFTkC2MhqZisUZg_3NbQ-1; Fri,
 14 Mar 2025 00:48:16 -0400
X-MC-Unique: xiLFTkC2MhqZisUZg_3NbQ-1
X-Mimecast-MFC-AGG-ID: xiLFTkC2MhqZisUZg_3NbQ_1741927695
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04350180025A; Fri, 14 Mar 2025 04:48:15 +0000 (UTC)
Received: from localhost (unknown [10.2.16.3])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1840519373D7; Fri, 14 Mar 2025 04:48:12 +0000 (UTC)
Date: Fri, 14 Mar 2025 12:46:56 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/23] Block layer patches
Message-ID: <20250314044656.GA1118247@fedora>
References: <20250313170135.81463-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1xDHscEFSgLivmzQ"
Content-Disposition: inline
In-Reply-To: <20250313170135.81463-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--1xDHscEFSgLivmzQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--1xDHscEFSgLivmzQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfTtMAACgkQnKSrs4Gr
c8gRXwf/SFjKH2ZqZLu6QGcLz5NQ9sO06Hyp/zNMbpI71wCXElyXhN9C9hDLc3pZ
rav6jiH4Bc+LuGnlU4bqbwyI/Z2F3NWd2gW2jMEKKSIfQubOe2Gudd9ZcGRXaepG
GN+HF5kQ/9xl51jzM9yTPKCGq9nV+wmSWPfszp9jkKwU/S08KF1A7B8UIT2urM3m
rso/rmyV/1HiPPXoGMvv6MHELSet6F5SzuptykSvC4Iyo+U9VLMMhA+tAoRMGnvk
VLCHDH26Ku7zbTlyWOzKoNohsA50Mf7K+Z6wf5mFlX8Qbsj3ESTSPmlIzDuXgnF8
vsoDL/q9s6v/NC4qlCrHUYhuob050A==
=2XLi
-----END PGP SIGNATURE-----

--1xDHscEFSgLivmzQ--


