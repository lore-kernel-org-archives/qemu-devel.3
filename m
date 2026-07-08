Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1DEC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 08:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whNQu-0008Gb-3m; Wed, 08 Jul 2026 04:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1whNQi-0007xv-D8
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 04:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1whNQf-0003d8-J7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 04:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783498488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3jz5RarcF3NOcxaORcb5cuayrC3jlvsDkcwjHxXjyjw=;
 b=P+sy/fyKwoe/D8jv2xmQ/G2jOyan5CPBdJMvBCh7+90S8PW5BFwpuulhxs5FG3Cm9ZJH6F
 VAvD26PT3Ep4HDHxN8uy1o7S6t5uXhL9bdagXfCPSwIo0EVgBhgFgImLWhRxWGQuWgCJi0
 edUCIjQzzNPHbq9zGi7RVcBPr8oVKTs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-ZacqDbhxO5aMtDXDHbWXeQ-1; Wed,
 08 Jul 2026 04:14:44 -0400
X-MC-Unique: ZacqDbhxO5aMtDXDHbWXeQ-1
X-Mimecast-MFC-AGG-ID: ZacqDbhxO5aMtDXDHbWXeQ_1783498483
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63A2E1955F19; Wed,  8 Jul 2026 08:14:43 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3C7F3000C10; Wed,  8 Jul 2026 08:14:42 +0000 (UTC)
Date: Wed, 8 Jul 2026 07:53:59 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 0/8] aspeed queue
Message-ID: <20260708055359.GA553641@fedora>
References: <20260707124349.662198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+2Big6IGbfQRlCsc"
Content-Disposition: inline
In-Reply-To: <20260707124349.662198-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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


--+2Big6IGbfQRlCsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--+2Big6IGbfQRlCsc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpN5fcACgkQnKSrs4Gr
c8jh+wf/QQJlU17K2EOz7PFZpNxIUUJsdEURdGseMKeTWefHTxdtOgV7R79Inn3a
P33NWe3bAMDPuBVIxYpe1EYgVF9MWORRH/51sK6nyNS9NHCI47GU4+ucFM0snvjM
o9/ZYXzdtFWisiHZFROz6CRLgk3NDzXUaONEDozvXiKcGsC2E+jPP1YAWrNnxcTV
bmKejYgpvRNysm2JfMM61SobU13U9WVJ1LzD7OaPTgPDdhQz1VEv10F6fks0c3XP
u3Ewvuyk8xPrrpfeRw5wuXjR+/lYIVkRrg55gsNEuANUyb8Vus7PDHhLFTG8x5Rj
5xKPfDl2pOc6mt2ZFsd1WzyUk4jxCA==
=kVvb
-----END PGP SIGNATURE-----

--+2Big6IGbfQRlCsc--


