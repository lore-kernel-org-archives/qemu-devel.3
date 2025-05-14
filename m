Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC8EC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFC4r-00081T-UG; Wed, 14 May 2025 09:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uFC0n-0002OF-Eh
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uFC0l-0003Bh-6p
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747228742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7X5uFNu1w0z5qHUpptqYi9GN2Nnu/gowlooXm6j9/AY=;
 b=DCHUpF5hYx0TGE14ygsY/iKGHTIgbMIOyBoletxOWEWlEVp2+ULGywQOVBn2Gcn9WFLWHx
 BMAm2lFQFKvNF4dlbGvDyiKaqQ2b0nboGWAois1pIIFYga44HYdXmYTNb7d+cRatWa46tD
 iyWd5gB36zyNAwSo+dns7cGCCM0J/LA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-9hcrYFEtMcmUg5qKfWs3GQ-1; Wed,
 14 May 2025 09:18:17 -0400
X-MC-Unique: 9hcrYFEtMcmUg5qKfWs3GQ-1
X-Mimecast-MFC-AGG-ID: 9hcrYFEtMcmUg5qKfWs3GQ_1747228696
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B9B118004AD
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 13:18:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.56])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0004B180045B; Wed, 14 May 2025 13:18:15 +0000 (UTC)
Date: Wed, 14 May 2025 09:18:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/16] Meson, x86, Rust patches for 2025-05-12
Message-ID: <20250514131815.GA265231@fedora>
References: <20250512190524.179419-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2y3b/mQtNzBqReaL"
Content-Disposition: inline
In-Reply-To: <20250512190524.179419-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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


--2y3b/mQtNzBqReaL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--2y3b/mQtNzBqReaL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgkmBYACgkQnKSrs4Gr
c8gD7Qf+NB7TnPUFpy78LTLq7hh8Dhi2DxidxymNQs1vuNIQsqgTm34A6m0zoZEp
hnjW9QWWPbPTjYtDoU4Gbxg00hvAEJ5bFVQuBKvJ9wBZ2eiaHesE0cv88ehjh7xw
+zk46rSABW3fwLIS2S641VVgJWJJVUy8jTp2mafJyxJXSsLWAshA299IF6naVt6Y
AEcx04BmMduXlUCfZbzyaulp06O0Q+RfW+qxjiqvW5JFBsawlZYjbZ4N7TbMAzTc
9G4E1zzdJ2obwyJIun8ClcgmuhDS25VCPokYsooVSvg3zdSRmsstZl5GThHVPzlj
hpvN4hAcIGrFR9H/Sl2BEDI+QMqAZQ==
=z8Ua
-----END PGP SIGNATURE-----

--2y3b/mQtNzBqReaL--


