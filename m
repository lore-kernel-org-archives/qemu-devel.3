Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F28CC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYZu-0001Lv-8R; Mon, 12 May 2025 15:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEYZq-0001Kh-ED
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEYZo-0008CT-Gg
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747077154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uMZlZOJSdEL7oQRWsosAE6o//xJoSeqU0y/rK4bTQQ4=;
 b=FbGT5dDs6QyOvvGbt8bidsSOP57w2xh6GbeRsQdBWDkUeIhhheIVeFRJ7xVAa2PiqPKCte
 6MANjZZzdILrRo8YoTAsS6Xf5LtZHOyGQNuUcjWQGIcUr6PqGGR7Zi4q8Y2BM8BzTljSFh
 2MhFwCPuxjqXrMSpGQmphfASoUC9aDM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-k2R91MvLM8upWWsazpzzzg-1; Mon,
 12 May 2025 15:12:30 -0400
X-MC-Unique: k2R91MvLM8upWWsazpzzzg-1
X-Mimecast-MFC-AGG-ID: k2R91MvLM8upWWsazpzzzg_1747077149
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65CB11954B0B; Mon, 12 May 2025 19:12:28 +0000 (UTC)
Received: from localhost (unknown [10.2.16.161])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8645B1956095; Mon, 12 May 2025 19:12:26 +0000 (UTC)
Date: Mon, 12 May 2025 15:12:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Xie Yongji <xieyongji@bytedance.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Raphael Norwitz <raphael@enfabrica.net>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [RFC v2 1/4] include: Add tentative virtio-blk FUA write
 definitions
Message-ID: <20250512191225.GK141177@fedora>
References: <20250508162044.857655-1-afaria@redhat.com>
 <20250508162044.857655-2-afaria@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8I4Yj+iPz1zZRL+x"
Content-Disposition: inline
In-Reply-To: <20250508162044.857655-2-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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


--8I4Yj+iPz1zZRL+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 08, 2025 at 05:20:41PM +0100, Alberto Faria wrote:
> Signed-off-by: Alberto Faria <afaria@redhat.com>
> ---
>  include/standard-headers/linux/virtio_blk.h | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8I4Yj+iPz1zZRL+x
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgiSBgACgkQnKSrs4Gr
c8gRzwf/ZcqWBrIRjotLswzY5EqHgv2xdC4HPcJS9VkhfIndThiAcsOnzRMMij2L
xnWjyz++xH2cHHfvV4++E6MUKN9OxI80wRvLywVPLH5AC/5/S4fAY4PWb732ZtwF
6q2fpKZc4yfYs/hR33hLm74Bd4GQ9If0OnCpG2adzEeBVhRitR7svbxUh2DJcLS7
jX3CvmiYoVHxSd8p7LEQHTxWwColjGMTAMv8D2OoJWyHiVEmu3stcbJBVU4RNlUC
CiuH0N77DXCAJUDr3hnkSbj0o8j1nyFcJ05m367stlyJoktZhQ4RAf+tOwnJ3np+
ef9O9Rp7r8IKfi06XSxtWfJcINa8dw==
=7NOz
-----END PGP SIGNATURE-----

--8I4Yj+iPz1zZRL+x--


