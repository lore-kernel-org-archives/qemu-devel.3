Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD9ACA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 14:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvzHQ-0006Jt-Ij; Tue, 09 Sep 2025 10:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvzHO-0006JJ-R7
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvzHF-0001UM-FZ
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757427893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aVURTZ9hBq7zaXkjQ6kQCQgJGKtwzsYsfhiG7EaO9c0=;
 b=AvFdpyaFfP+Ge+1w3HyuvBDFECNhL2uiX3xWnOraZfpkPiLbDuGAwHjIyO6aTVBT1d79ls
 9oQr+Acwp3/H9BkDRhV1gjTU3ckWzZ3O47He+dGszXxF9nPPUDz3tiro26ANSueGt+MVCp
 BwQEhxgryA48rBc0fyhokVXVNJFgWu4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-_aIyCiRHNJStldUTY7cj6A-1; Tue,
 09 Sep 2025 10:24:49 -0400
X-MC-Unique: _aIyCiRHNJStldUTY7cj6A-1
X-Mimecast-MFC-AGG-ID: _aIyCiRHNJStldUTY7cj6A_1757427888
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D09C185FC7B; Tue,  9 Sep 2025 14:24:28 +0000 (UTC)
Received: from localhost (unknown [10.2.16.59])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B6EE1956095; Tue,  9 Sep 2025 14:24:24 +0000 (UTC)
Date: Tue, 9 Sep 2025 10:24:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 peterx@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 07/10] use qemu_set_blocking instead of
 g_unix_set_fd_nonblocking
Message-ID: <20250909142423.GA218449@fedora>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-8-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yzI4PtjSQvBoN2E8"
Content-Disposition: inline
In-Reply-To: <20250903094411.1029449-8-vsementsov@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


--yzI4PtjSQvBoN2E8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 03, 2025 at 12:44:07PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Instead of open-coded g_unix_set_fd_nonblocking() calls, use
> QEMU wrapper qemu_socket_set_nonblock().

The commit description is outdated: the patch actually uses
qemu_set_blocking().

--yzI4PtjSQvBoN2E8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjAOJYACgkQnKSrs4Gr
c8h/Wgf/QAR3AX8c5RTphZ4iXmYcSrNVlhcakYPdHv/HQltlKaOVZ1cQtLsJCqLd
uzVgZbla7Fe/On43w+7a3P+chOKq1HSXjDfyTeIXarzoOVkJQtCKEB/lDLstyHPH
6iFpQq5x/nKIwJH3mOge0Xhnn30C0v3wpB5ozrmxFJpE2CXwER/WxhvgVBM2Fa/c
7wQuqVccGfXQLV8hgmAz1CaU5vakRFRTTuJVrUfOmNtHszpUvWmO1hj/Zpkcfnbz
68qQhRdmvk2HvGqAGrDGP/yWqVGoTEuvXtxN9aLj8raZotB/qDXFZVuN2l5qr9Ge
D099qx6RwllAK29AF1OmZcNp/5L5iw==
=hvs9
-----END PGP SIGNATURE-----

--yzI4PtjSQvBoN2E8--


