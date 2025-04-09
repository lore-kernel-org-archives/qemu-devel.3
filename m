Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F63C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 08:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2QqV-0006Vs-Ia; Wed, 09 Apr 2025 04:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2QqL-0006S9-7O
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 04:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2QqJ-0003uk-Kh
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 04:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744187490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vIdJZgzeiFERuYf1bcvOkyGgySRPrq7UtLN7mbjDVak=;
 b=L3WcpkMDiuUasfmDfzuqGlgPEEdBr9RlruWA/R1qJJ+qIYt4aFgSb7hYquUrZ/DVbmMSBm
 Rm+UT8Kb3DMMJdW325YE2vHbXYAy6IzkY20f9PJ/euO5lW/fUWVqIjc1Gasc/cCzhk+Nus
 lWOAtHSoEOfOqmzubktNnqAliFN7Acg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-9OWxBiefMyCnmNcYKpjE2A-1; Wed,
 09 Apr 2025 04:31:28 -0400
X-MC-Unique: 9OWxBiefMyCnmNcYKpjE2A-1
X-Mimecast-MFC-AGG-ID: 9OWxBiefMyCnmNcYKpjE2A_1744187487
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E2F41944D44; Wed,  9 Apr 2025 08:31:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.136])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3305D1828A80; Wed,  9 Apr 2025 08:31:26 +0000 (UTC)
Date: Wed, 9 Apr 2025 04:31:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org
Subject: Re: [PULL 0/2] ppc-for-10.0-3 queue
Message-ID: <20250409083125.GA24088@fedora>
References: <20250408124550.40485-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jXFEBB2BHLWRKu0A"
Content-Disposition: inline
In-Reply-To: <20250408124550.40485-1-npiggin@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--jXFEBB2BHLWRKu0A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--jXFEBB2BHLWRKu0A
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmf2MF0ACgkQnKSrs4Gr
c8hyWQf/UgrDrDLuIlLZ+CgMIFxlrvOQh/DCS09lT9dNWEYJjHakYnI/LWR40x8J
9JMxNF9fVJk1x8nRogyHqKOZU4xSlQXeBNEp+WP9GwPyyw2v8eI8+4DSfs34RY6u
aRoVNGde+xg9JiG+8rstvVWVaaubz3vU3BMF/qI002/EQE+hPzzh6szXlMeGN69v
F0MtwEaIrPatNFrddXC2nt5FCUa37JJnmo/x8ofdHRfojHosoJNuGeOCOzjEw1eh
4LUDU0JOh5n+RmYEXmaS7LX1RgmM8Cl5YefgzZowGgZh1e0V0fgYd+F6c6L/NyqC
71ds28CLrY38x+tMjhr+7bX/QN+7rw==
=8xNc
-----END PGP SIGNATURE-----

--jXFEBB2BHLWRKu0A--


