Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C63AC4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkjtc-0007Ni-9M; Fri, 17 Jul 2026 10:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wkjta-0007N9-NU
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wkjtY-00024N-57
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784299830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2A4e6NAceI09f8Az9qor3pnc0IukgrgtBIfkiCLRuLs=;
 b=UgLssqNapT2dK3mU2TMEHbkh8XQ1novlLOSpcG4A8LE/nuWjd5b2m9vEnDDlF1HzLimYbJ
 pdRlXnTfDAYVB/ea2BVJaEW0FcaeYJrUaD5aTWndd685Y4HqBB4Bw1BcxaXqCGvifZIT8z
 6HOT2ePofZk8FYRQSo4/8L/9sySSw9E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-U9bXjv0cNru3iVL-mXDG3Q-1; Fri,
 17 Jul 2026 10:50:28 -0400
X-MC-Unique: U9bXjv0cNru3iVL-mXDG3Q-1
X-Mimecast-MFC-AGG-ID: U9bXjv0cNru3iVL-mXDG3Q_1784299827
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1322194510B
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 14:50:27 +0000 (UTC)
Received: from localhost (unknown [10.2.16.229])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89E681956050; Fri, 17 Jul 2026 14:50:26 +0000 (UTC)
Date: Fri, 17 Jul 2026 15:50:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/4] Miscellaneous patches for 2026-07-14
Message-ID: <20260717145024.GA749073@fedora>
References: <20260714091700.3797064-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EsJHgA3nR4nunQbP"
Content-Disposition: inline
In-Reply-To: <20260714091700.3797064-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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


--EsJHgA3nR4nunQbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--EsJHgA3nR4nunQbP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpaQTAACgkQnKSrs4Gr
c8i8Owf/YmHP1tAo4lNxV3/FFhElSm01JUYfRw1V3TTnpfh5qWLW+gyel0kEKcd1
aAqpSrce+ea/kL5D/hysu124i7pIVZrJW7oKRR+K+fier6QR8L6HqYMKQWEHR7N4
sR/BPJB4db38KrOVHu8iHMu632MYdyxYgtXsxTlRhHTYSbRYHJcrr/IcT9ovbqgq
jAWhU5XURfrIROwtJOpiNkjeqVN1jwygDkUL2Wx5uRNxJBHzn9arG7b4ZsDfsxUa
tyGrspVA+r9HxT9OjO6Jme2BrYGIZDgpM26GuQ+fB3cBJAIf3tS0f4QZOpXzlPPm
tLKqkeAoV6v86OdQxoG46kQpysLe2g==
=9C90
-----END PGP SIGNATURE-----

--EsJHgA3nR4nunQbP--


