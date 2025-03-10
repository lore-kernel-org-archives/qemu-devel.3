Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F80BC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1traaQ-0002sc-M3; Mon, 10 Mar 2025 06:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1traaN-0002ru-M6
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1traaL-0003sJ-UY
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741603331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MPh6kvc4uer+wuIZG3khqo7KLg1cGoRUiRXPtjsLOGE=;
 b=KN7xcuBQnPzwkNK7fMSXuvAEFjtcTIM5ZiSV9rZuVpd9FuvYzd83fRu0DgtI6Go2owr/SB
 IwsHPwlKO/FrzWRNM8TDs9Gg0cWxPLZBMRgDCMbLwnX+WIO5C9LnU9XoCvrLUxBxTWlDpI
 TIM8t1QaXOtYVpgA21Scznpzai8Vv/w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-ho0kMMOyPymwv96EOykFrA-1; Mon,
 10 Mar 2025 06:42:05 -0400
X-MC-Unique: ho0kMMOyPymwv96EOykFrA-1
X-Mimecast-MFC-AGG-ID: ho0kMMOyPymwv96EOykFrA_1741603323
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60F161955D4B; Mon, 10 Mar 2025 10:42:03 +0000 (UTC)
Received: from localhost (unknown [10.2.16.19])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 875FA1800373; Mon, 10 Mar 2025 10:42:01 +0000 (UTC)
Date: Mon, 10 Mar 2025 18:41:58 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, afaria@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/5] file-posix: Support FUA writes
Message-ID: <20250310104158.GA359802@fedora>
References: <20250307221634.71951-1-kwolf@redhat.com>
 <20250307221634.71951-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hdEbCDl7qCrUGnbD"
Content-Disposition: inline
In-Reply-To: <20250307221634.71951-2-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--hdEbCDl7qCrUGnbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 11:16:30PM +0100, Kevin Wolf wrote:
> Until now, FUA was always emulated with a separate flush after the write
> for file-posix. The overhead of processing a second request can reduce
> performance significantly for a guest disk that has disabled the write
> cache, especially if the host disk is already write through, too, and
> the flush isn't actually doing anything.
>=20
> Advertise support for REQ_FUA in write requests and implement it for
> Linux AIO and io_uring using the RWF_DSYNC flag for write requests. The
> thread pool still performs a separate fdatasync() call. This can be
> improved later by using the pwritev2() syscall if available.
>=20
> As an example, this is how fio numbers can be improved in some scenarios
> with this patch (all using virtio-blk with cache=3Ddirectsync on an nvme
> block device for the VM, fio with ioengine=3Dlibaio,direct=3D1,sync=3D1):
>=20
>                               | old           | with FUA support
> ------------------------------+---------------+-------------------
> bs=3D4k, iodepth=3D1, numjobs=3D1   |  45.6k iops   |  56.1k iops
> bs=3D4k, iodepth=3D1, numjobs=3D16  | 183.3k iops   | 236.0k iops
> bs=3D4k, iodepth=3D16, numjobs=3D1  | 258.4k iops   | 311.1k iops
>=20
> However, not all scenarios are clear wins. On another slower disk I saw
> little to no improvment. In fact, in two corner case scenarios, I even
> observed a regression, which I however consider acceptable:
>=20
> 1. On slow host disks in a write through cache mode, when the guest is
>    using virtio-blk in a separate iothread so that polling can be
>    enabled, and each completion is quickly followed up with a new
>    request (so that polling gets it), it can happen that enabling FUA
>    makes things slower - the additional very fast no-op flush we used to
>    have gave the adaptive polling algorithm a success so that it kept
>    polling. Without it, we only have the slow write request, which
>    disables polling. This is a problem in the polling algorithm that
>    will be fixed later in this series.
>=20
> 2. With a high queue depth, it can be beneficial to have flush requests
>    for another reason: The optimisation in bdrv_co_flush() that flushes
>    only once per write generation acts as a synchronisation mechanism
>    that lets all requests complete at the same time. This can result in
>    better batching and if the disk is very fast (I only saw this with a
>    null_blk backend), this can make up for the overhead of the flush and
>    improve throughput. In theory, we could optionally introduce a
>    similar artificial latency in the normal completion path to achieve
>    the same kind of completion batching. This is not implemented in this
>    series.
>=20
> Compatibility is not a concern for io_uring, it has supported RWF_DSYNC
> from the start. Linux AIO started supporting it in Linux 4.13 and libaio
> 0.3.111. The kernel is not a problem for any supported build platform,
> so it's not necessary to add runtime checks. However, openSUSE is still
> stuck with an older libaio version that would break the build. We must
> detect this at build time to avoid build failures.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/raw-aio.h |  8 ++++++--
>  block/file-posix.c      | 26 ++++++++++++++++++--------
>  block/io_uring.c        | 13 ++++++++-----
>  block/linux-aio.c       | 24 +++++++++++++++++++++---
>  meson.build             |  4 ++++
>  5 files changed, 57 insertions(+), 18 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--hdEbCDl7qCrUGnbD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfOwfYACgkQnKSrs4Gr
c8idBAgArWUbz+RQI52JsMhcea6wPFbhwu0+LolnONA5qtBY6Qyyf1miyHxv3DpD
fNTVfw41xreL4muy5W338TGknXo9/+aHukd0/pAFN1nCI6IP9ewnANan4Y1fdOrF
TFj4J5yd8womxxLB7YqXzHD6TYWSzBTZ/AOvl1AoJCTRzXYX+6sD5F4A96pWcsH1
zLoZdMTjEtxEXp82x38HLFN27pY+vRebrUev8fpVxiCn81mzxG00toeExeb33VQy
GzyzijEcqoZm5Ewy7S91odQH7dG020Wjbc7nQt3jRTnA8O/HyWpuvyX8ziT3CDHL
/+CDD6KZfTVgUvuc+Gictzh0xMG+Rw==
=MLSL
-----END PGP SIGNATURE-----

--hdEbCDl7qCrUGnbD--


