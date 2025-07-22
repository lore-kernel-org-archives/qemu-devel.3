Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C010C83F25
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 11:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueB4D-0006fp-Gv; Tue, 22 Jul 2025 07:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ueB31-0005EQ-3H
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 07:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ueB2v-000592-8x
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 07:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753183230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4jf+wH78yqLmtVM6d/V/k6k0/8Epu00t8sJLoGx1Pj8=;
 b=hPj2XnokMurOHN1BqBH13xBuWLvUhNwpRjBuhwsaCfZiVuA6pWqREzJuwyvYyZzGaymEYw
 tM1TAeS/IiRS7TJNyLy44k6RN/2vy/7sPTaPSaQakuugGbKS8SEUihSFFSvflMHtWRB4Ig
 SuS6TIu11WzDngZCz+j013R5ImESN/U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-iFWSs8mSNgec10aE-a8czQ-1; Tue,
 22 Jul 2025 07:20:27 -0400
X-MC-Unique: iFWSs8mSNgec10aE-a8czQ-1
X-Mimecast-MFC-AGG-ID: iFWSs8mSNgec10aE-a8czQ_1753183226
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EF9C1956088; Tue, 22 Jul 2025 11:20:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.10])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 752DD19560AD; Tue, 22 Jul 2025 11:20:24 +0000 (UTC)
Date: Tue, 22 Jul 2025 07:20:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/50] ppc queue
Message-ID: <20250722112023.GA187149@fedora>
References: <20250721162233.686837-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tkpqxKdBKXZivAbe"
Content-Disposition: inline
In-Reply-To: <20250721162233.686837-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--tkpqxKdBKXZivAbe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--tkpqxKdBKXZivAbe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh/c/cACgkQnKSrs4Gr
c8g+8wgAk4R1tT3dyfEo1xxyo/mIKxGCNUNXejJvkisCne/wggBSuL3WoOQ/M4ma
C5d9/U7Tp6Btxf72u3LVDWtv5QDP3NnamFSqiHRg/cIfvsPh4W6sKFiv6TIt4Nnk
Jqc7i+m+gFSdpYn5MjD6SdX98QFV7Phpa2JphXptf6a4GbzVRwsMPaXMowPwxxCq
oB0+1SC0xiRE1vMq8jXsQ4sFrCKzzlU8HRge/umM8Q/UivsBC61wWr6J3VuWumIe
S8Zt1whEdzEL0zOb3irXE320wM6E8Pn5geSxqPcJniJMgwQ4CM3B0HdA1JW5TGi4
5vs+xGygSan1klWDqTNlDMmm1295Gw==
=Gcik
-----END PGP SIGNATURE-----

--tkpqxKdBKXZivAbe--


