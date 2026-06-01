Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528DCCD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU3DI-0005gn-Th; Mon, 01 Jun 2026 10:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU3D5-0005P5-IB
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wU3D3-0005kv-78
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780322499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ifzRtFEYwt6skNgJORA66eL//JsAQHyYbhcuEObjXb4=;
 b=cFjq7aAVu/xZN1jKGg1045Ota3ZSg+TXt5n8YazTL+dBQDLgGukad4JmP7+DgiH8UxaLjL
 3et/iQNFY8o0hDxgsJVCN2zsSgwgDs5MVAjA9X1sZtON+7U2ZkmMaB1EK6VbqBRdSqvE+c
 WycG6Y4rQYWEZfZ1IScB2CRWaHJfKA8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-hRO7bEWAPl-X5w_sw03Lkg-1; Mon,
 01 Jun 2026 10:01:30 -0400
X-MC-Unique: hRO7bEWAPl-X5w_sw03Lkg-1
X-Mimecast-MFC-AGG-ID: hRO7bEWAPl-X5w_sw03Lkg_1780322488
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28459195C242; Mon,  1 Jun 2026 14:01:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 421D430001BE; Mon,  1 Jun 2026 14:01:08 +0000 (UTC)
Date: Mon, 1 Jun 2026 10:01:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 sin99xx <sin99xx@proton.me>, Fabiano Rosas <farosas@suse.de>,
 Wang Jihe <wangjihe.mail@gmail.com>
Subject: Re: [PULL 0/7] 9p queue 2026-06-01
Message-ID: <20260601140107.GA410817@fedora>
References: <cover.1780307575.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="keO/RZWe4ynETLK+"
Content-Disposition: inline
In-Reply-To: <cover.1780307575.git.qemu_oss@crudebyte.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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


--keO/RZWe4ynETLK+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--keO/RZWe4ynETLK+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmodkKMACgkQnKSrs4Gr
c8hSpwgAn9NWU2VQD73HvhYa9YpYcja3P3iR0iR7IaLE7qsi7T0UpMGijJVLmQJv
vniKmTTRH7eQLOIBRCT8ehaR5LyOTUibxmSdMUKRu2m7xHuY+/HdbeIWY/1BTHB6
zn1GGHbYgzVqov/SYebchOiRrcrOyjD6aQERdiXNpIMVdMQjkbJWfnXz5P3lGBKD
uZns8D5WaFb8Zv/Ax1fJysmrWDoBADQca81CPuNFH4+Ceztoibtw79mqgWrFOpDY
n8S2XMIm2yuJarYCJRodTG9v3k7y6oceR/61RWNTNwsqUSWy5woz5Lhn+nLYgImX
03aBMm1vZYMIi2g2D1bk1pRoQTEjVQ==
=6Cvf
-----END PGP SIGNATURE-----

--keO/RZWe4ynETLK+--


