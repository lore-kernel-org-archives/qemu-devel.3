Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF04FC3ABC6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 20:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD80R-0001sh-2X; Thu, 08 May 2025 16:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uD80P-0001sS-9b
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:38:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uD80N-0007Ra-9W
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746736685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ta0ZnAmXeQ3vt8HugexCP82d3ZKtdiV5L1JSLb+JKgk=;
 b=R/mDBsUXiyAkYTvXSsMW1elm4atOHvGFMvWY+yqBbvyzJWvI5QGkM1O9ZaLy3rTsthg+kE
 MBWJJ4ujLkd97suYZ5r/NgWYqMS+Joqs7HgXvnO8VpXhMZ7hPDRsbAkodGkodMyY6M/BuF
 WYqGRPNLn0YoOlm/ctbA6zcUcGxc7LA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-lwDyMo9EOyimgMPsUwybQQ-1; Thu,
 08 May 2025 16:38:01 -0400
X-MC-Unique: lwDyMo9EOyimgMPsUwybQQ-1
X-Mimecast-MFC-AGG-ID: lwDyMo9EOyimgMPsUwybQQ_1746736679
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8FE819541AF; Thu,  8 May 2025 20:37:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEF0418003FC; Thu,  8 May 2025 20:37:56 +0000 (UTC)
Date: Thu, 8 May 2025 16:37:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: qemu-devel@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Xie Yongji <xieyongji@bytedance.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [RFC 2/4] virtio-blk: Add VIRTIO_BLK_T_OUT_FUA command support
Message-ID: <20250508203755.GA63777@fedora>
References: <20250508002440.423776-1-afaria@redhat.com>
 <20250508002440.423776-3-afaria@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="66o/ExEzAnPSJX0J"
Content-Disposition: inline
In-Reply-To: <20250508002440.423776-3-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--66o/ExEzAnPSJX0J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 08, 2025 at 01:24:38AM +0100, Alberto Faria wrote:
> Signed-off-by: Alberto Faria <afaria@redhat.com>
> ---
>  block/export/virtio-blk-handler.c |  7 ++--
>  hw/block/virtio-blk.c             |  2 ++
>  hw/core/machine.c                 |  4 ++-
>  hw/virtio/virtio-qmp.c            |  2 ++
>  tests/qtest/virtio-blk-test.c     | 56 +++++++++++++++++++++++++++++++
>  5 files changed, 68 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--66o/ExEzAnPSJX0J
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgdFiMACgkQnKSrs4Gr
c8irMQgAvvH7jeQkcFbytmcsYN8vB2sWeUCUrIafSQ9u1WuNPALgK5a0YQZn7qVw
xxxcC4UOzWV6F1HWCSRpaiAEGqg4nNgrs/vl9gvRr4K1k6csv4M97EkQLfM0eioX
xX+iNqXLXDJKRrnaCHkgrzN8h1cOMDKbG5LghE4hPfmCnG+UNq674vJQIzu0GsVx
/ztB7O7wlaMrcDBNzAS+br8ZhPuukE9tJ5TyPWilEQVDO0ew/pHhqf0zz4XPcEcH
Mm4mDvau8y6u9AMAJQdYt2Sd1Fjijwe60mIl/TnOtj71pKTvud7ggHgxAUgS7Wb3
G7hzIdDVDjNpKos3AnHkN+XRM9m4jQ==
=RvWK
-----END PGP SIGNATURE-----

--66o/ExEzAnPSJX0J--


