Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7DBC3ABCC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEZCR-0004KG-CM; Mon, 12 May 2025 15:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEZCP-0004JZ-C3
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uEZCN-0004aq-W5
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747079547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zW4xhqZEnJEGWiwAVw1Kqdxkjf4OsQ7gfI1fiPr26fA=;
 b=AoRrIQ6po/+8JRozO1sJWAn2oA6JWfZukyfH2Ob6GVUchWVi8udlurn0csHQCFPbbBh2Nv
 b62UEuBJXiKMvJQ1oSLfEFKEC1UVDjnqgR4DH+21WWoqPKIXg42L159zy4qqtUGUpkR8SP
 7yFytyAYjkIBwcgdJ97xvfdASXj/CRA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-sZ_UUEy0Pp-t0gdccevZEA-1; Mon,
 12 May 2025 15:52:22 -0400
X-MC-Unique: sZ_UUEy0Pp-t0gdccevZEA-1
X-Mimecast-MFC-AGG-ID: sZ_UUEy0Pp-t0gdccevZEA_1747079540
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4AFB1955D9D; Mon, 12 May 2025 19:52:19 +0000 (UTC)
Received: from localhost (unknown [10.2.16.161])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 385D919560A3; Mon, 12 May 2025 19:52:18 +0000 (UTC)
Date: Mon, 12 May 2025 15:52:17 -0400
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
Subject: Re: [RFC v2 4/4] vduse-blk: Add VIRTIO_BLK_T_OUT_FUA command support
Message-ID: <20250512195217.GO141177@fedora>
References: <20250508162044.857655-1-afaria@redhat.com>
 <20250508162044.857655-5-afaria@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EZqekKMA30pHUOKP"
Content-Disposition: inline
In-Reply-To: <20250508162044.857655-5-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--EZqekKMA30pHUOKP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 08, 2025 at 05:20:44PM +0100, Alberto Faria wrote:
> Signed-off-by: Alberto Faria <afaria@redhat.com>
> ---
>  block/export/vduse-blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EZqekKMA30pHUOKP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgiUXAACgkQnKSrs4Gr
c8gd2AgArUl+DEIU7ABti85dj3td8MIb1OrTqsPxMG4ag+MVe6o119AjQQ4H+vZM
4ZvKvuVvmAlPyF+5WNS4z0Y+cSV/gbeltOnKMcaL0O5OGkmR/hnkYqEPU5o1sHWq
MFOQvujzG5CugjyQFWhsRzVSG4UjkvQ/ZgFbZlkaKSUuTMj/6S9RxVnudtys2Gw/
wtLsh+yjqJ7eq/+JRsrkAmR3o7hkhGCLZWaZoqfqftSDfDerS7v6+jchgdjLpkWr
26oi+CwdjqdQfE1Uw8ejEvodVTjUqCGEKbrLCGVytKdv6vbj+keC77mMCWxz+lD+
cFAD09v2Kwhqd5yPEyeGAy2kfaGrhg==
=LPCu
-----END PGP SIGNATURE-----

--EZqekKMA30pHUOKP--


