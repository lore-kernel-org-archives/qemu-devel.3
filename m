Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3388C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 07:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscdc-0003fD-N8; Thu, 13 Mar 2025 03:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tscdW-0003Rd-CE
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tscdU-0007vS-R8
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741849543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1sM14Pv2ym1srmynTZq9WR9nahRRaZgdf/4A4aKi8wU=;
 b=NiX+HXES+OrMC8jxOZL98uHZ8qfPNI3nLcpFB/xrxnkx27gqHLOMpaTKrUasB9p0foukVj
 BESrUvVlC5XkAncUkoWbBtzt/xlUt77vVoQ9LCSXb6eXAcyDUaGfQdb8aPJl2i2Y9e/W/R
 aQpu4Z+Vg94KqkrOgKklpeS6p1LvSr0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-S8HVLhyXP7K-boB_Pr2xyQ-1; Thu,
 13 Mar 2025 03:05:39 -0400
X-MC-Unique: S8HVLhyXP7K-boB_Pr2xyQ-1
X-Mimecast-MFC-AGG-ID: S8HVLhyXP7K-boB_Pr2xyQ_1741849538
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A28D5180035E; Thu, 13 Mar 2025 07:05:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.45])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C8616300376F; Thu, 13 Mar 2025 07:05:36 +0000 (UTC)
Date: Thu, 13 Mar 2025 15:05:34 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org
Subject: Re: [PULL 00/72] ppc-for-10.0-1 queue
Message-ID: <20250313070534.GA1086185@fedora>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XGxfe5NHL/rKOlrH"
Content-Disposition: inline
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--XGxfe5NHL/rKOlrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--XGxfe5NHL/rKOlrH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfSg74ACgkQnKSrs4Gr
c8hXwQf/aP4Z2Ukx7cl0x/pFodbXlUe8QddF8EK5A9GcVRzFeKae7KorkwYNwvLE
eZhISIXKGMoyBgH8rqGvHk0XEADtwXKYwWSaU7PgSVdqgLvv/o2a445/W/Gjb7UF
YWSMstiPdG1wYuK8e3bPkvrZfYUHX04AmLAfERQMTx/sc/A9DNmSIzNRzXFXFsCK
/CL5hKVgjIembECzx/RrSLntntadRV0PZnVBeyHVIuySfKnfd0ebqGw4oEYa3oRb
E7MUiTN21/pDxz1bcu7t/Z1lqwdSkybeloli9A/To3vRHUT2EYC92wZ5Rz/IIZBR
jhgNv1UGT2pZoIVHLeeCatt/aW7R+g==
=YERN
-----END PGP SIGNATURE-----

--XGxfe5NHL/rKOlrH--


