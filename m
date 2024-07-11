Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F285C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRtQq-00021n-M4; Thu, 11 Jul 2024 09:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRtQh-0001vv-BQ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRtQd-0006jE-Jm
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720702902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jb6tTwWJXG8OEb4wcLbXp4BQTeJ46LKczLBVJnvd/mk=;
 b=JL8n0AGssguVBgrxzk/idgpCiKgvmHSeDEuskX4YcXiH9bds7Z+0UhmaTIAJBlZKElFVT8
 ro3MuFwBcglJGJ0EzENT/xz+YPR1zU+jMUB1aE6FOVQrGgDNRUtBIRNBMcdPbix9OAfe31
 k3G8HPf3COqywxZ+5qrmkqX2K22uEjk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-8uBUfLc-ONSYeDcN2oUmiw-1; Thu,
 11 Jul 2024 09:01:37 -0400
X-MC-Unique: 8uBUfLc-ONSYeDcN2oUmiw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D9E51955F45; Thu, 11 Jul 2024 13:01:33 +0000 (UTC)
Received: from localhost (unknown [10.39.192.146])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C9F73000182; Thu, 11 Jul 2024 13:01:31 +0000 (UTC)
Date: Thu, 11 Jul 2024 15:01:30 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v8 08/10] hw/nvme: enable ONCS and rescap function
Message-ID: <20240711130130.GC16124@fedora.home>
References: <20240709024706.4108-1-luchangqi.123@bytedance.com>
 <20240709024706.4108-9-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NRTYrKkXDk1OTc5W"
Content-Disposition: inline
In-Reply-To: <20240709024706.4108-9-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--NRTYrKkXDk1OTc5W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 10:47:04AM +0800, Changqi Lu wrote:
> This commit enables ONCS to support the reservation
> function at the controller level. Also enables rescap
> function in the namespace by detecting the supported reservation
> function in the backend driver.
>=20
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  hw/nvme/ctrl.c       | 3 ++-
>  hw/nvme/ns.c         | 5 +++++
>  include/block/nvme.h | 2 +-
>  3 files changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NRTYrKkXDk1OTc5W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaP16kACgkQnKSrs4Gr
c8ig5QgAxKdjpeyahTmdIiN9CIywpczepBdSConuTr9wX3gEMrDIwnD6+nVS5+cw
KBHuEuXXl5kf4qX7GCuSb777nmtwSaq0MtkWyip3VYzyk7LxFuqOI80a2RIe1NxR
Azrwl/UQxMB85i/PEb9eVwhNq5rTb49/YUsR//dMqmlHC2+uzYeUPXsX7TV5+dtc
LDEWtcAFn51nLvce5uLOSOFEaqYiUEfYa4k9Nhz5KFRolnk09hkeytuxTF+bPzDf
BXXUGrJ7rkpXR/TWvCYNrwBVahXON9zwPpnmrqjcxDLbvcze48nFqbgqDVfZHjH7
rujvNSzUnu7h1OyOvpGsnvEflLVPVg==
=LX2O
-----END PGP SIGNATURE-----

--NRTYrKkXDk1OTc5W--


