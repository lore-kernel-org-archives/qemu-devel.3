Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8563C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNBP-0001YS-Fn; Tue, 20 May 2025 09:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uHNBM-0001YE-Fb
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uHNBJ-0001fS-LG
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747748334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7lKWiJDQ9/A2wgLrl/NX0vEhDJWc4Q9+jRFZdayEm34=;
 b=ic5n956clOscADfYg5nceEbCey6h1xco/PlzmU8ilXmA6kwDWphZD2iuChB4Zndp/gbpm6
 juNIoitHl6RRTlObwlHvjNPUasrB3Jzdm1ph7mZS8hVyKUmwnus5uEGO4aLfIdjcj1nppm
 njZvO+WqIvNCjQ3KTqnHbNNT9DUTUoc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-5uZsmAtPO9OrrDMMf-hATA-1; Tue,
 20 May 2025 09:38:52 -0400
X-MC-Unique: 5uZsmAtPO9OrrDMMf-hATA-1
X-Mimecast-MFC-AGG-ID: 5uZsmAtPO9OrrDMMf-hATA_1747748331
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AEF91956080; Tue, 20 May 2025 13:38:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.246])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C49E918003FC; Tue, 20 May 2025 13:38:50 +0000 (UTC)
Date: Mon, 19 May 2025 17:17:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL 00/56] riscv-to-apply queue
Message-ID: <20250519211710.GA58530@fedora>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o6O44qMTf0P9sSD5"
Content-Disposition: inline
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.487, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--o6O44qMTf0P9sSD5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--o6O44qMTf0P9sSD5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgrn9UACgkQnKSrs4Gr
c8gOqwgAgMQcDjnC3C2vvbH/G1gloiNKvKDpQ3q3pu1vuPO4u9x3HK0fDO4b8jCd
sOuQTwIGSjNsJiu/VSRkUSyGfzk+SKZtNtdNgs7Z6Iufd7rIPl/J49c5A2uuJIne
UqHphJrCyMchN8TPbGLudEFcvBvHQPE7S2ZqQw7fv9dc7njLBY819EckEj5MuJp6
RSakmxqHe0tpBlRbPnsTFBCN8SHrLT2Mzqj+vR9zeJ6veQ5mQyWPyU6T8qpS06eH
74VMydJvM5t4WPj99vQxts33ce/gUUd89jA5YpjmgM01EDX2NGQxMcZr6kYOQcGm
+booarNkOe9F3mIs4Pc/wK1cU+pLaQ==
=jruk
-----END PGP SIGNATURE-----

--o6O44qMTf0P9sSD5--


