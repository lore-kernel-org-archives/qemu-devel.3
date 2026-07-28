Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB362C54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogCI-0000oB-W5; Tue, 28 Jul 2026 07:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wogCH-0000lg-Ks
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wogCG-00025v-AB
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785238927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iiywScpFu9qmiBfByk3O0hWAf014c26yh4BQjAiwYoA=;
 b=U7FTZZZnowAAg9QHWIJUEznVExnRtyQg8vcJVX8iMhjTdKH3R11/+qIvLBwvdNt3uxJOvr
 5MAV3837EEryXrKy+xXQOSXn4brbLTvR7V90VI8EbeMOKJxlufKz44tpC9W4o5xFpzhVGM
 Ya0LtzNKEqW98H8165Cl8QBhq+INz4I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-R4PeHH4mNKKSOIX5qPgleA-1; Tue,
 28 Jul 2026 07:42:05 -0400
X-MC-Unique: R4PeHH4mNKKSOIX5qPgleA-1
X-Mimecast-MFC-AGG-ID: R4PeHH4mNKKSOIX5qPgleA_1785238925
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DCA019560B5
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 11:42:05 +0000 (UTC)
Received: from localhost (unknown [10.2.16.73])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9529F1800480; Tue, 28 Jul 2026 11:42:04 +0000 (UTC)
Date: Tue, 28 Jul 2026 07:41:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/5] Various fixes for 11.1-rc2
Message-ID: <20260728114156.GA1016646@fedora>
References: <20260727125207.646148-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iYHYcPSx7eRDqXAJ"
Content-Disposition: inline
In-Reply-To: <20260727125207.646148-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--iYHYcPSx7eRDqXAJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--iYHYcPSx7eRDqXAJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpolYQACgkQnKSrs4Gr
c8igXQf9FWxD76Z55D98iOd9s6f9cAmtwMWfoUBChACskTyBKrqhx39j3OGzFbQ2
zQQfhJjr+bmr2g8+S62LxzqSwTDw9xdoUvfBCa5m/PGz0RmQrCf5xP/awlvQCifl
GYCDNj95KRssZ83LTutv4yZuuI4h5nttA2fni21lAdJHjmtj/B+8A8pgC8P3CjTq
+xfZvFPdHywmqtFAzBZNbQyoyRSAaC5RkZs0HpsRjUNv6QoJq+cvKMJZsge8XdBU
8is/+X1yTYRWFb0M8xdbTE4MeoIpwtEzMXRgbAeWWn1yWSwdYf58OmC01B9gOk6l
3QbTi8NGZd5AiNFpyHjO7FmwbxQyGA==
=rq/x
-----END PGP SIGNATURE-----

--iYHYcPSx7eRDqXAJ--


