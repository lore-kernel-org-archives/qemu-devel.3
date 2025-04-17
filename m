Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4B9C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 21:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5WLK-0008Gb-1m; Thu, 17 Apr 2025 17:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5WLC-0008Er-M6
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5WLA-0000ru-VM
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744923607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5WuG4AvBAwu9OYbLvo+ce6CDjtTFDehaXBKHRhMtg94=;
 b=dheNCy5ArpdJeXwXevtMJV2nzyNrTe/SP0fLbAUI03Yr4bciKM1bKg5GnvPLY5WmwRuLKt
 enEfEDxlbkxm2vwJh/u2jdayhnrUMpGx7qEaW3hcXwaePObE2QN9XKMF8EsOWXGxzLwO/m
 /fRK5xkHEbV5l+oAVNmLyeCqfCM/8Wc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-9TOOsjeVMZi2PyIBiTixPg-1; Thu,
 17 Apr 2025 17:00:03 -0400
X-MC-Unique: 9TOOsjeVMZi2PyIBiTixPg-1
X-Mimecast-MFC-AGG-ID: 9TOOsjeVMZi2PyIBiTixPg_1744923599
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4BA719560AE; Thu, 17 Apr 2025 20:59:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.64])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F4C830002C8; Thu, 17 Apr 2025 20:59:58 +0000 (UTC)
Date: Thu, 17 Apr 2025 16:59:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@yandex-team.ru
Subject: Re: [PATCH v2 00/11] Make blockdev-mirror dest sparse in more cases
Message-ID: <20250417205958.GL85491@fedora>
References: <20250417184133.105746-13-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pojihLdjuHk5nXue"
Content-Disposition: inline
In-Reply-To: <20250417184133.105746-13-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--pojihLdjuHk5nXue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Looks good overall. I left some comments on individual patches.

Maybe one day qemu-img convert and the mirror blockjob can be unified.
The write zeroes logic is duplicated.

Stefan

--pojihLdjuHk5nXue
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgBa80ACgkQnKSrs4Gr
c8jIJQf/dfKoMOdpwnQrtOA4K4gcjl6OraMTkmhlpbwCLP/sIYtgEIjvmQoiGLph
waWf9dbOAicHnvaEXCAJskBdU2Gs/iRFwhS25Htc5mKGqWONEVHBYu8va1J7ReHd
nXHIA/fTkkOJAVFTbCX8RrseBTvpeeWM4tNKiCEvEJPvST+59uHbPnLiFAWCUKQS
ZFHFxEWiszVdlEa34vqzaC4cIeVA+M1tY3uUU5m5+BuOXyngKf3dClC+Qv4ih0KM
xAWhugFhTETEf3ilZpbikv8GMgPrM3eZ0P1eS3OOhh08SbRGT4txYXRh5Us+Ixd5
3e6clElDIfRxYDStJvjN2QG+PfcbZQ==
=sNrg
-----END PGP SIGNATURE-----

--pojihLdjuHk5nXue--


