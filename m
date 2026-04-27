Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F213AFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRP2-00034N-Pe; Mon, 27 Apr 2026 15:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHRP1-00033n-30
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wHROz-0006y7-Fi
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777317232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQz6nNDWd2Wl6uRKub4QO3wgZza547aoatoPIJcxMEc=;
 b=V54p2LDWMjdeZG7t5hOkgrAW0x/2/WSizX71UsFwGt70jUA03L7g/bwjiH+rEfsVdmmzjw
 UxmzNywkEVfbjRa7pBP/maU45gJUYdlUx+9pgfABvAxwYiFCC00/o7TFgwNuK4hXAkX30N
 9+JFK9Qk28wgWG2IoGRfUhLa4Mhwi+Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-T9jRNAAVOw-Td5qIV-Ljgw-1; Mon,
 27 Apr 2026 15:13:49 -0400
X-MC-Unique: T9jRNAAVOw-Td5qIV-Ljgw-1
X-Mimecast-MFC-AGG-ID: T9jRNAAVOw-Td5qIV-Ljgw_1777317228
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82A2818005A9; Mon, 27 Apr 2026 19:13:47 +0000 (UTC)
Received: from localhost (unknown [10.44.34.59])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3FC17195608E; Mon, 27 Apr 2026 19:13:45 +0000 (UTC)
Date: Mon, 27 Apr 2026 15:13:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>,
 Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: Excessive IO PSI for iothread when using io_uring since QEMU 10.2
Message-ID: <20260427191343.GD218226@fedora>
References: <017dc767-90e3-4983-8417-e541b3fb04f6@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SRpG6vD1rt4wnVTq"
Content-Disposition: inline
In-Reply-To: <017dc767-90e3-4983-8417-e541b3fb04f6@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--SRpG6vD1rt4wnVTq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 12:25:41PM +0200, Fiona Ebner wrote:
> Dear maintainers,
>=20
> since QEMU 10.2, if io_uring is enabled, it will be used for the event
> loop of iothreads and this causes an IO pressure stall value of nearly
> 100 when idle.
>=20
> The issue was also reported on the kernel mailing list [0]. The
> suggestion from Jens Axboe was to just turn off the iowait accounting
> completely. But since (for block/file-posix.c), there is actual IO
> submitted via the same ring, I wasn't sure if that is the right approach.
>=20
> So the idea was to keep track of whether the event loop is otherwise
> idle and only use the IORING_ENTER_NO_IOWAIT flag in that case [1].
>=20
> However, doing so would only help for block/file-posix.c, which submits
> IO via luring_co_submit() -> fdmon_io_uring_add_sqe(). For example, for
> block/rbd.c, only a poll SQE for the AioHandler node's fd is used. When
> submitting that poll SQE in the iothread, we would need to be able to
> know if IO for RBD is currently in-flight or not to be able to decide
> whether to use the IORING_ENTER_NO_IOWAIT flag or not. Is there a good
> way to do this (in a general way)?
>=20
> Or should the flag really always be used (if supported by the kernel)?
> Is there a way to tell io_uring/kernel that we are an event loop and our
> waiting should only be accounted for when there is actual IO in-flight?
>=20
> Happy to hear your opinions and suggestions!
>=20
> [0]:
> https://lore.kernel.org/io-uring/14bc6266-5bc9-4454-9518-d1016bfe417b@pro=
xmox.com/T/

Hi Fiona,
Jens replied yesterday confirmed your suspicion that the number of
inflight requests is not being tracked correctly.

Is there still a problem after fixing the kernel's inflight counting? If
not, then no QEMU change is necessary and that seems like the cleanest
solution anyway. The kernel should know whether there is I/O in flight
and so it doesn't seem right that userspace needs to hint this.

Stefan

>=20
> [1]:
> https://lore.proxmox.com/pve-devel/525c4dad-6d04-41f0-8a21-9302b0c6baa4@p=
roxmox.com/T/
>=20
> Best Regards,
> Fiona
>=20

--SRpG6vD1rt4wnVTq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnvtWcACgkQnKSrs4Gr
c8jAcQgAsRsNwv3SsYO7maAN2VVpgGoIzuf2Pe+vtvu8yUTjvsWmV/PTS8S69Osr
IGq0GLgFViMO1yjoU0K5p1tzaXjyGWcXxNXeHC6CqYuWnPEGqeE66nMdRXJ4zfgR
TOVqjMkwzQOJOyF9TxEL0UJDikexVnM8AXFkCzeqaCUB4ipcLHm/unKJ6hPoFIZ/
P4CgHqNrnjrbFRSay11gX6Jd3OEsWW4Gm8zIWfrQ+/yp4N0OBYUS1g/aTCUy2epu
bwRwUPNVPkC6iXpcjfvWPUz5LxAff4p6Zc7UJ61TEv808gDBFbVUIUNKqyraAmzE
7ZEshVGgqFXJrUlEU0tJmE/Tuqb9Gg==
=n2QB
-----END PGP SIGNATURE-----

--SRpG6vD1rt4wnVTq--


