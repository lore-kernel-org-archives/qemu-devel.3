Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46064C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eCo-0002qN-Ng; Mon, 21 Sep 2026 09:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCl-0002pi-9u
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCj-0002jJ-Tx
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789997829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+MReMFvlqvtNw+bmlwKyZlVOomCQ+e8ahH9+hb4unM=;
 b=WM/hF5u2uVMbA4NPftOkjyXTb1I/U0pQpROxd9BZIw/hQmGqHnLlivbxpQmeODgiFWKcrO
 IMTSKpeskPOH9c1bOQuP4LBHte7oZHP3gmflGvhHiNOMs1CrR3XaTUzd1s4AUApHz1d/30
 LsFSQ/C+2UOBuZ9+VAvZG8XOC2wMjpg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-r9Vvw7C6NkmzXvtPvtncBg-1; Mon,
 21 Sep 2026 09:37:07 -0400
X-MC-Unique: r9Vvw7C6NkmzXvtPvtncBg-1
X-Mimecast-MFC-AGG-ID: r9Vvw7C6NkmzXvtPvtncBg_1789997826
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD86D1953970; Mon, 21 Sep 2026 13:37:06 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5839419539A7; Mon, 21 Sep 2026 13:37:06 +0000 (UTC)
Date: Wed, 16 Sep 2026 15:48:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V17 08/13] virtio-balloon: Update tracking iothread users
 with holder
Message-ID: <20260916194841.GE162769@fedora>
References: <20260915101655.3216101-1-zhangckid@gmail.com>
 <20260915101655.3216101-9-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8WXjo8glMSiVo5Zu"
Content-Disposition: inline
In-Reply-To: <20260915101655.3216101-9-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 46
X-Spam_score: 4.6
X-Spam_bar: ++++
X-Spam_report: (4.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--8WXjo8glMSiVo5Zu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 06:16:50PM +0800, Zhang Chen wrote:
> Replace raw object_ref/unref calls with
> iothread_ref_and_get/unref_and_put_aio_context.
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  hw/virtio/virtio-balloon.c         | 21 ++++++++++++++++-----
>  include/hw/virtio/virtio-balloon.h |  1 +
>  2 files changed, 17 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8WXjo8glMSiVo5Zu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqq8pkACgkQnKSrs4Gr
c8g2TAgAtcKOng0EMlG0fSwVtKWtrbHa9B53xhKxlEDp8nGg4XdmGaZFYitT+GTz
7GR3zkGIjU7ON3V1kQjCPEjMOMn8bA8BtaAf2iQtYldB5vg9CfcVvdUGMVQ60sHu
yceKHMdS4KT1lM57Cfd84vlUhMeLvkf6WNdsy4j1QHf73AbpeXocxYGzqGhwiND/
EsTyn5Hy60gsbnDfCCWMPxB9d7IpRgCvpmwjMU8ukDmLc4U8+/KujXHMYH8BFoYF
IxRn/kHGD0w20iFQBw6xymWc21p0MWCSHvcT9hMY+aFEqr/G/38t+yw9Qh2rAQ0m
fVZtfH5K/pviVsRc5PHQtkre6nMnyw==
=hvVs
-----END PGP SIGNATURE-----

--8WXjo8glMSiVo5Zu--


