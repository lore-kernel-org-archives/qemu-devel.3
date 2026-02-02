Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4899E7DF16
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 18:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmyEc-0001Ci-Q5; Mon, 02 Feb 2026 13:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vmyEY-00016Q-Tg
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 13:01:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vmyEW-0000IZ-Kz
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 13:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770055266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9YNM7Xl0gOpzGCTgddCEXzGfzvYrH8oDg8ctwBbXq8E=;
 b=HvHhl5dLTqo98ggVBrf9kC19h4dCf0lAac7eJvBDM4bKtf2VrgWs9WLn+VNyuw7zwXIHFY
 xvk4l3OpzMQDqARw01dAMPov6zo4SX2Vc5RK3rXE8UxywV6eAZmVHMUFWXjhr7XjIPKfmp
 iz2d2FT1fm5R+oqed9eYfShCj0NLuNc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-gQaBReB9NYehrOfxON5upQ-1; Mon,
 02 Feb 2026 13:01:00 -0500
X-MC-Unique: gQaBReB9NYehrOfxON5upQ-1
X-Mimecast-MFC-AGG-ID: gQaBReB9NYehrOfxON5upQ_1770055259
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF5331954231; Mon,  2 Feb 2026 18:00:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DDD31800577; Mon,  2 Feb 2026 18:00:57 +0000 (UTC)
Date: Mon, 2 Feb 2026 13:00:56 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/6] include/hw/virtio/virtio-access.h: remove target
 specifics define
Message-ID: <20260202180056.GB405548@fedora>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-3-pierrick.bouvier@linaro.org>
 <20260131124842-mutt-send-email-mst@kernel.org>
 <095a1def-1548-4764-84d2-87ffb642bb8e@linaro.org>
 <20260202024813-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pSgvDtVEIDmIA8q/"
Content-Disposition: inline
In-Reply-To: <20260202024813-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--pSgvDtVEIDmIA8q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2026 at 02:50:28AM -0500, Michael S. Tsirkin wrote:
> On Sun, Feb 01, 2026 at 05:24:03PM -0800, Pierrick Bouvier wrote:
> > On 1/31/26 9:48 AM, Michael S. Tsirkin wrote:
> > > On Fri, Jan 30, 2026 at 06:00:56PM -0800, Pierrick Bouvier wrote:
> > > > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > >=20
> > > Performance impact?
> > >=20
> > > the reason we have these is for performance ...
> > >=20
> >=20
> > I would be very happy to run any benchmark that you might judge critica=
l.
> >=20
> > Should we run a disk read/write sequence with a virtio disk, or a downl=
oad
> > with a virtio interface? Any other idea?
>=20
> block for sure, people who care about network perf go the vhost or
> vhost user path.
>=20
> So I CC'd Stefan Hajnoczi. Stefan do you feel this needs a test and what
> kind of test do you suggest as the most representative of I/O overhead?

This command-line lets you benchmark virtio-blk without actual I/O
slowing down the request processing:

  qemu-system-x86_64 \
      -M accel=3Dkvm \
      -cpu host \
      -m 4G \
      --blockdev file,node-name=3Ddrive0,filename=3Dboot.img,cache.direct=
=3Don,aio=3Dnative \
      --blockdev null-co,node-name=3Ddrive1,size=3D$((10 * 1024 * 1024 * 10=
24)) \
      --object iothread,id=3Diothread0 \
      --device virtio-blk-pci,drive=3Ddrive0,iothread=3Diothread0 \
      --device virtio-blk-pci,drive=3Ddrive1,iothread=3Diothread0

Here is a fio command-line for 4 KiB random reads:

  fio \
      --ioengine=3Dlibaio \
      --direct=3D1 \
      --runtime=3D30 \
      --ramp_time=3D10 \
      --rw=3Drandread \
      --bs=3D4k \
      --iodepth=3D128 \
      --filename=3D/dev/vdb \
      --name=3Drandread

This is just a single vCPU, but it should be enough to see if there is
any difference in I/O Operations Per Second (IOPS) or efficiency
(IOPS/CPU utilization).

Stefan

--pSgvDtVEIDmIA8q/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmA5lgACgkQnKSrs4Gr
c8jt5wf/UkeOZdWPQWpHp27wR+PCMdyDe8wo2Bd2HCnVRZcTcr7FtPhC8iFiuiPx
M9Xdjf3rSVhjUIsyIDRC0CqA/+yXwcX7XiXa4JUvTN8m2LQP5PgjgDIIorDTacZD
p9GnDyN49URDdtojxXb88HhK8WAcxHOyLDT3Z6uRpNW950YW0u3w+/lrV+yRC8fX
LjP2BEcMgOShzudIUL1R3zipTO1e1KFEzgWE92It41XaDLADqjQB6PRP6OQrdJ/L
SBJogNhg5N9gGwAK8ZYAd5xtmZ5rGhRCC3AmcZySHznXgct0MrIRSMyzohxfyUl+
AWsTpP3apKBdwmrAFOQ9XJsy5ijESg==
=/B3P
-----END PGP SIGNATURE-----

--pSgvDtVEIDmIA8q/--


