Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22EDCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZSfA-0001Oy-P0; Tue, 16 Jun 2026 08:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZSf9-0001Oi-Ms
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:13:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZSf8-000707-2t
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781611980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zCeAQbJaSAi6rh5KiePDjvfyFMKzVookuKTTrSZlTeY=;
 b=jHeBAmHR+LHCosEf9RJNZnHx4vqNanz8aogEGH7Mk3Te42EY3uZ97/7hLKKvEnbcnAzQsx
 AQ2I7l4qDJ0pCwvMI5GRxwtclJ1LKRn02tEryPcDh+E9HRkow12bMWLZ1fMeTnrrgzILxZ
 O4cEa3b+OKz5CEcwiHnKruVy6p+3Nx0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-bvlu9ryKNMGXxHIEG4Bq4g-1; Tue,
 16 Jun 2026 08:12:57 -0400
X-MC-Unique: bvlu9ryKNMGXxHIEG4Bq4g-1
X-Mimecast-MFC-AGG-ID: bvlu9ryKNMGXxHIEG4Bq4g_1781611976
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D67B19560A1; Tue, 16 Jun 2026 12:12:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.92])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A4321956053; Tue, 16 Jun 2026 12:12:55 +0000 (UTC)
Date: Tue, 16 Jun 2026 08:12:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 000/106] pci, vhost, virtio, iommu: features, fixes,
 cleanups
Message-ID: <20260616121251.GA527003@fedora>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P1rmSxmNP5/MxJ5p"
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--P1rmSxmNP5/MxJ5p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--P1rmSxmNP5/MxJ5p
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoxPcMACgkQnKSrs4Gr
c8gREAf/Ybm+aiumD332xx7ws88JUy1IpXiwK+Svf7BDNt40/E0J6LwnXBGPoHEF
OoZFw2fghtoEr8RksFMhBvVl5YSc0luZL3O0N5Fes16Iq6ZcuW0HfihijAEYrbdm
ieHw5VeK55ZTijf+asVKapbAkZq9xJ0Zf708YQUAIdUoz3ee+K6VkQI1gDQumtG+
OdSy/5gTiCKX2gfRtOVx97CKce/oZSP6ttfzOIKQcNV5LVcNeG4fpAswiP4QeEQl
mUH2qu/1LDn6o72EfthxfNHrWmjSch+mHy/JJsJW7u13WllFFVXvXuBc8pNpegSU
QaxUBPhWDGaruxENfKSxegwTqO28xw==
=dKUK
-----END PGP SIGNATURE-----

--P1rmSxmNP5/MxJ5p--


