Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7C4CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZSfv-0001ay-Dm; Tue, 16 Jun 2026 08:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZSfj-0001XM-R1
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZSfh-0007BF-H4
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781612015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=txfFr6yC/zSaR15YKyDsPiWBHnPSiSPU8xjigMFoTAc=;
 b=BTmNWYbpoq2Bkk1/zVuh5JFiH0ix3+UlzITOjcmuR2rjb/7xmSaj4CWnfLI1nLF3abxuxr
 /oP9W0XMOC6kNXVqmBdTWuQXqLBMqomZOsWsr+yvYZcmO0Yp6hP/sdbR5gILwytxeC0Eda
 PzC0mLz4yJY68QdWqNkWAj81mJwVrPQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-u_T2pKI_MvmO1Kwt4gSwVQ-1; Tue,
 16 Jun 2026 08:13:32 -0400
X-MC-Unique: u_T2pKI_MvmO1Kwt4gSwVQ-1
X-Mimecast-MFC-AGG-ID: u_T2pKI_MvmO1Kwt4gSwVQ_1781612011
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED8E619560A2; Tue, 16 Jun 2026 12:13:30 +0000 (UTC)
Received: from localhost (unknown [10.2.16.92])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42D4A1955BC1; Tue, 16 Jun 2026 12:13:30 +0000 (UTC)
Date: Tue, 16 Jun 2026 08:13:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/5] Tests dockerfiles update for 2026-06-15
Message-ID: <20260616121329.GA527218@fedora>
References: <20260615175052.2751738-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dI+0XjAxKaIst8k1"
Content-Disposition: inline
In-Reply-To: <20260615175052.2751738-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--dI+0XjAxKaIst8k1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--dI+0XjAxKaIst8k1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoxPekACgkQnKSrs4Gr
c8imLgf/cjMruAscFV+ePJ8oZO/S3Cehe1EPU7EzNBIUpd75ccRfehfm2R7ZBcya
HxSXEVKnv9L5m6AYQxrH7VtQ7hiYZz2vEmGMAhpSlVjXipsesX4LlNmPDG5ByU3S
msyVKNG+9sdsWc3DVPG2ZY1t0Vhjwqoe0bwUQpvS9IOfO6AGzQVqNDyObttVugEF
3O0CoP1ltf5r+vZBBEt26TG9zpVHqMUa9+rODsWB7x+gIhIQdKvKudVcMY0UISeM
v95ULEKi4nMgy4Edldl91re4RM/Xg8AWC2EJ5R065yq+HeB0BTD3dXut32hfk69w
5CxSOaqen/WHUfK7rXN+/f18+IxHAQ==
=r4SI
-----END PGP SIGNATURE-----

--dI+0XjAxKaIst8k1--


