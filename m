Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DC5C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogCm-0001ZE-MU; Tue, 28 Jul 2026 07:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wogCk-0001Tp-8v
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:42:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wogCi-00027s-91
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785238955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vdpRyrsD+equt8wZID9CkC2SmRvO6/dzCMKm0uhYVDo=;
 b=H3I+WzY4LSfckrmYE2LGVZ03jbQOlbaLOrkSBk+vR8uc8VUnVmamrQK4hfCl/Fj3ThE6lc
 I5sGONRBxwFQEsn7G+jSFxirGuu2iQ27uX4fPdG2dM3fJ3NMCMGr5kAmeMtF7VmokMOdOW
 eU2cGV8nqTBx84Njb9e7hm2VzCU1psc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-j2aKED6mMR-LaAmoUkkXLQ-1; Tue,
 28 Jul 2026 07:42:31 -0400
X-MC-Unique: j2aKED6mMR-LaAmoUkkXLQ-1
X-Mimecast-MFC-AGG-ID: j2aKED6mMR-LaAmoUkkXLQ_1785238950
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 606FD19560B7; Tue, 28 Jul 2026 11:42:30 +0000 (UTC)
Received: from localhost (unknown [10.2.16.73])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CEFC61800345; Tue, 28 Jul 2026 11:42:29 +0000 (UTC)
Date: Tue, 28 Jul 2026 07:42:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL v2 00/30] pci, vhost, virtio, iommu: bugfixes
Message-ID: <20260728114228.GA1017398@fedora>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KP/d15e0Ga9wQB4X"
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

--KP/d15e0Ga9wQB4X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--KP/d15e0Ga9wQB4X
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpolaQACgkQnKSrs4Gr
c8gPdgf+MrOg/Lbfw6z+HYVYtgJbkHVAVd8Kin/uZnnQrX0lItETvdfxs/z62EZs
JUBUVuCa0BrsM7nQaO5cQ9kgiK9rf4tn1C1wr9q2YHRGqnSC6Akaw+djOCiumNvr
2Z0hIetRnVLpnKf/uWiisETjC7sMiGqByeEGzgbk5H37WLK5TXyxiX7ZjC+IPC6w
euqJlc0qpCdrxOZ42LMyHqUkODW3fMtg5r1ujLPI2l9I/IQU+mB/r0Gl0k+a/WG4
AUcqyhZl5+cot95F0txyp497Y2uic4RQOIe08aBSw9NipWspM0YuW2BMmFo0SsUY
vsxSYAtcJ2wUC5FWPqeGRboqAcC5WA==
=WNqx
-----END PGP SIGNATURE-----

--KP/d15e0Ga9wQB4X--


