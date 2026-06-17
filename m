Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F587CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 19:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZvyR-00028m-LE; Wed, 17 Jun 2026 15:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZvyP-00028Z-Lj
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZvyO-00036f-B6
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781724651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6DD8VkA1F3Zj0t2+vrADmzSR9Xxuupo14SMPUSGiYto=;
 b=U9CzKrndUDFs8wsChmUam8G8QwUvA+dZOG+ZHmcaVSINF9heXp1zS5dx0IL/MDiUyweJvN
 yXfbR7G9EjVesp/16JIxiJTR4rLIjmUXSGbnjKv3qY0+U2dusjHBMt738/+r2lsEIHmb4C
 xmNMFBWbS4Oo1JUDk7KmICgIsEGfjyM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-OamrF88-Mq6pIJIaHq63wQ-1; Wed,
 17 Jun 2026 15:30:49 -0400
X-MC-Unique: OamrF88-Mq6pIJIaHq63wQ-1
X-Mimecast-MFC-AGG-ID: OamrF88-Mq6pIJIaHq63wQ_1781724648
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 577421956063
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 19:30:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97BA2180049F; Wed, 17 Jun 2026 19:30:47 +0000 (UTC)
Date: Wed, 17 Jun 2026 15:30:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PULL 0/3] Firmware 20260617 patches
Message-ID: <20260617193046.GA694366@fedora>
References: <20260617100922.1302000-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MEsdVh+SnesHWtNf"
Content-Disposition: inline
In-Reply-To: <20260617100922.1302000-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


--MEsdVh+SnesHWtNf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--MEsdVh+SnesHWtNf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoy9eYACgkQnKSrs4Gr
c8gWKQgAkXi9Bj3imActEB0WyAeyVTf6AidVHf+YRMZlWMIW3INMQab2f4TUkZnQ
D8Eg2B4tRHCmaXKKeOObC2Jujensos/5rACgNDmgQ55wsSSVvejVHG5tk7hBqUvI
gdiup3yj9Mpq3TA1/XYJeDM5P7lkH8Zt7fm9FoXPrkQleOEhqoRNV/GGUUAh6Apz
P+R9EPgYxb3W+eQuqGwVsk04G7HUONk0Yf8spSk4wOT5XCt96hboUVAxRWA7SuDq
vKEZWwfP7NRaTFn0EAfR80ib3Cxl1v8sU+fH0tjjCb3hQb47nehglCDkh5N0lRk5
DvzXwwv5z2PvDGT4o/9GtZf5coQwig==
=vS6Q
-----END PGP SIGNATURE-----

--MEsdVh+SnesHWtNf--


