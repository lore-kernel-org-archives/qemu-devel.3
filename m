Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323FFC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 21:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u83z6-0004Ow-Ch; Thu, 24 Apr 2025 17:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u83yl-0004He-Dh
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u83yj-0002E7-PA
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745529568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vSVkpAOV1VCQSuqueA9LqvLELy+yggvZjD8cN3MeY5Q=;
 b=Gra8poD8bjoSvxD/4zJj5y9lXYBM+hP/IrDPP6F96r4d53Gljc9dKBzU3TK5woqoukqs9w
 PjedIWKnfaxsp7KM9KLVmKg4xHE+8nYwd1y2jnsIb458/L+D0EY+mhQAuJ7FVgMQcR3fCz
 Az2Vb018EKQ5YSyU+0QV1er6DySblWw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-Cc86aMAoN5Cs3hb9EgBhBA-1; Thu,
 24 Apr 2025 17:19:26 -0400
X-MC-Unique: Cc86aMAoN5Cs3hb9EgBhBA-1
X-Mimecast-MFC-AGG-ID: Cc86aMAoN5Cs3hb9EgBhBA_1745529565
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 410AE180036F
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 21:19:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.253])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8126919560A3; Thu, 24 Apr 2025 21:19:24 +0000 (UTC)
Date: Thu, 24 Apr 2025 17:19:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/3] Miscellaneous patches for 2025-04-24
Message-ID: <20250424211923.GA457844@fedora>
References: <20250424075916.1522767-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S5bBsNursoDiycig"
Content-Disposition: inline
In-Reply-To: <20250424075916.1522767-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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


--S5bBsNursoDiycig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--S5bBsNursoDiycig
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgKqtsACgkQnKSrs4Gr
c8jYuggAma5XlSVPrN0eBD+0lubGz/E1lOyk2iiyomJPzo/c3LX5JNb82OZKh16m
oY70HsAZ9yfukEwOJRU3LsACbC+rAaP6zg6zZgFtj9jRQuBPoCqoImcy9/87H/Yj
P3pDaBhgNAyaq4RAqR+VE2mvHaBMZLN6Iyy5rj5d3MD8YK8ZQBEuL01S+Wz/8ACj
dmtODR+MAPatNZvxbybJ1XRzBetKatwOpTdDT1V8oOMkkV4NGMI5mON8+zrjPP1m
i+tsFaZebTKTLyvlsng4ElXZIyXajAeQ4FviVtD4sfqd99AJxIUdpTNh0YeqV286
ZwnhblyKMl8ILeW8ygSsIOGdbSxq2w==
=E6rI
-----END PGP SIGNATURE-----

--S5bBsNursoDiycig--


