Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F56D2F358
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 18:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfitX-0005gK-RX; Tue, 13 Jan 2026 13:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vfisy-0005YC-MF
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 13:13:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vfisw-0007zs-Rl
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 13:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768327972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYui2i1hQ7LVffqnmW2T9U1xwARvetElHKxctWqTjNo=;
 b=USc8X6VlMt+OsGVqQYZhUoSbNZGd9w0QQxenUtk/yGGGAPS6PzDt4IAUWk+v/Dn4HPKXBZ
 WZum2Uv2YrFexiWa+mAlW4xViZS8Sm7utabOmHBVsTzr/s7rPsCGU5SmDxZ4EI8hodU1zz
 /gPOpvp9fO/GYPCjBQihCqYLoMNxkaA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-iIDlxvY5PsyLnLoB3ImLOg-1; Tue,
 13 Jan 2026 13:12:48 -0500
X-MC-Unique: iIDlxvY5PsyLnLoB3ImLOg-1
X-Mimecast-MFC-AGG-ID: iIDlxvY5PsyLnLoB3ImLOg_1768327966
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E559A1955F34; Tue, 13 Jan 2026 18:12:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.89])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0990430001A2; Tue, 13 Jan 2026 18:12:43 +0000 (UTC)
Date: Tue, 13 Jan 2026 13:12:42 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 mzamazal@redhat.com, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 0/5] support inflight migration
Message-ID: <20260113181242.GB528940@fedora>
References: <20260113095813.134810-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lVzFgWl4xxlRkd0j"
Content-Disposition: inline
In-Reply-To: <20260113095813.134810-1-dtalexundeer@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--lVzFgWl4xxlRkd0j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2026 at 02:58:09PM +0500, Alexandr Moshkov wrote:

Peter: Please review the migration aspects (especially the vmstates).
Thank you!

> v6:
> - fix documentation about new protocol feature
> - add check to ensure that inflight buffer subsection has been successfully loaded
> - disable support for the new feature if in-flight or inflight migration is not supported.

Aside from the comment I posted:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

This patch series should go through Michael Tsirkin's VIRTIO/vhost tree.

--lVzFgWl4xxlRkd0j
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmlmixoACgkQnKSrs4Gr
c8gqpAf7BnhCzUazDaA9ZO1q8fUjkEgNhEQnAQhtHKHWOiK2SLxnnQJ/Ub77R2a/
dN962xmc4tjpDeMYgou6eRyyGFt1gC17AW4AFFShDENkarArqSWbpxeDZmaHVXVF
UA1Jd8VaCzeMReiAXmbm71nf65OnUK4ZHLVWilEhnOEyCE+I6Ma8QaSaOUTcFO3G
9e/glq8lIddQ/UXhbTZ2jwqRh6QI6S/JrV3LJP3zE3QlSqERRCNb+1EaoyFVud9v
lQRFjW3JctZIzbkgGXKUeSdCgU6lJIM8nOZB7/7kL0VbJ8kdms6ojgKllbwozQRo
iSRKOxM89Bwlq9+1J0QXvx23KUu7RQ==
=gow+
-----END PGP SIGNATURE-----

--lVzFgWl4xxlRkd0j--


