Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D51C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 15:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5nls-0004M2-M6; Fri, 18 Apr 2025 11:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5nlr-0004LP-Kd
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 11:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5nlY-0000OP-9B
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 11:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744990591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nJJvajBp4bJagqvJ5Ki8oSVwgmYBNFr3f8ktNekkasY=;
 b=WZbUHuJ5H49eRoHM+MpPp+r1Xp1bFTH4ywMzQgueHJnREqnxiJEyf3J5yUol/aRJ0tejI3
 VdkpMFDowL3+5eBUNli6W99G6E/y13287W8Yzmr32rQxr+u8tSj2ZYz2xedGJNRW9P3Xoy
 B5YAxloLAidPfpYMxeccnsY7oJwz7tE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-ZCux15SbNUun18C0UNUaLw-1; Fri,
 18 Apr 2025 11:35:01 -0400
X-MC-Unique: ZCux15SbNUun18C0UNUaLw-1
X-Mimecast-MFC-AGG-ID: ZCux15SbNUun18C0UNUaLw_1744990500
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FC12197701B; Fri, 18 Apr 2025 15:34:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.183])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 840611956095; Fri, 18 Apr 2025 15:34:57 +0000 (UTC)
Date: Fri, 18 Apr 2025 11:34:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: lma <lma@suse.de>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-block@nongnu.org
Subject: Re: A question about how to calculate the "Maximum transfer length"
 in case of its absence in the Block Limits VPD device response from the
 hardware
Message-ID: <20250418153456.GA128796@fedora>
References: <20db3af2ece22f598b54a47ec350b466@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rqqd6H6I9CEZswqe"
Content-Disposition: inline
In-Reply-To: <20db3af2ece22f598b54a47ec350b466@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--Rqqd6H6I9CEZswqe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 07:27:26PM +0800, lma wrote:
> Hi all,
>=20
> In case of SCSI passthrough, If the Block Limits VPD device response is
> absent from hardware, QEMU handles it.
>=20
> There are several variables involved in this process as follows:
> * The bl.max_transfer
> * The bl.max_iov that is associated with IOV_MAX.
> * The bl.max_hw_iov that is associated with the max_segments sysfs setting
> for the relevant block device on the host.
> * The bl.max_hw_transfer that is associated with the BLKSECTGET ioctl, in
> other words related to the current max_sectors_kb sysfs setting of the
> relevant block device on the host.
>=20
> Then take the smallest value and return it as the result of "Maximum
> transfer length" after relevant calculation, See:
> static uint64_t calculate_max_transfer(SCSIDevice *s)
> {
>     uint64_t max_transfer =3D blk_get_max_hw_transfer(s->conf.blk);
>     uint32_t max_iov =3D blk_get_max_hw_iov(s->conf.blk);
>=20
>     assert(max_transfer);
>     max_transfer =3D MIN_NON_ZERO(max_transfer,
>                                 max_iov * qemu_real_host_page_size());
>=20
>     return max_transfer / s->blocksize;
> }
>=20
>=20
> However, due to the limitation of IOV_MAX, no matter how powerful the host
> scsi hardware is, the "Maximum transfer length" that qemu emulates in bl =
vpd
> page is capped at 8192 sectors in case of 4kb page size and 512 bytes
> logical block size.
> For example=EF=BC=9A
> host:~ # sg_vpd -p bl /dev/sda
> Block limits VPD page (SBC)
>   ......
>   Maximum transfer length: 0 blocks [not reported]
>   ......
>=20
>=20
> host:~ # cat /sys/class/block/sda/queue/max_sectors_kb
> 16384
>=20
> host:~ # cat /sys/class/block/sda/queue/max_hw_sectors_kb
> 32767
>=20
> host:~ # cat /sys/class/block/sda/queue/max_segments
> 4096
>=20
>=20
> Expected:
> guest:~ # sg_vpd -p bl /dev/sda
> Block limits VPD page (SBC)
>   ......
>   Maximum transfer length: 0x8000
>   ......
>=20
> guest:~ # cat /sys/class/block/sda/queue/max_sectors_kb
> 16384
>=20
> guest:~ # cat /sys/class/block/sda/queue/max_hw_sectors_kb
> 32767
>=20
>=20
> Actual:
> guest:~ # sg_vpd -p bl /dev/sda
> Block limits VPD page (SBC)
>   ......
>   Maximum transfer length: 0x2000
>   ......
>=20
> guest:~ # cat /sys/class/block/sda/queue/max_sectors_kb
> 4096
>=20
> guest:~ # cat /sys/class/block/sda/queue/max_hw_sectors_kb
> 32767
>=20
>=20
> It seems the current design logic is not able to fully utilize the
> performance of the scsi hardware. I have two questions:
> 1. I'm curious that is it reasonable to drop the logic about IOV_MAX
> limitation, directly use the return value of BLKSECTGET as the maximum
> transfer length when QEMU emulates the block limit page of scsi vpd?
>    If we doing so, we will have maximum transfer length in the guest that=
 is
> consistent with the capabilities of the host hardware=E3=80=82
>=20
> 2. Besides, Assume I set a value(eg: 8192 in kb) to max_sectors_kb in gue=
st
> which doesn't exceed the capabilities of the host hardware(eg: 16384 in k=
b)
> but exceeds the limit(eg: 4096 in kb) caused by IOV_MAX,
>    Any risks in readv()/writev() of raw-posix?

Not a definitive answer, but just something to encourage discussion:

In theory IOV_MAX should not be factored into the Block Limits VPD page
Maximum Transfer Length field because there is already a HBA limit on
the maximum number of segments. For example, virtio-scsi has a seg_max
Configuration Space field that guest drivers honor independently of
Maximum Transfer Length.

However, I can imagine why MAX_IOV needs to be factored in:

1. The maximum number of segments might be hardcoded in guest drivers
   for some SCSI HBAs and QEMU has no way of exposing MAX_IOV to the
   guest in that case.

2. Guest physical RAM addresses translate to host virtual memory. That
   means 1 segment as seen by the guest might actually require multiple
   physical DMA segments on the host. A conservative calculation that
   assumes the worst-case 1 iovec per 4 KB memory page prevents the
   host maximum segments limit (note this is not the Maximum Transfer
   Length limit!) from being exceeded.

So there seem to be at least two problems here. If you relax the
calculation there will be corner cases that break because the guest can
send too many segments.

Stefan

--Rqqd6H6I9CEZswqe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgCcSAACgkQnKSrs4Gr
c8ivMwf9FdoO+zLXdYYwI4lqB951OrcIswP/E5VOdFGh9OWC9L7V10VxaeSc6ptA
YUCwyCvasIP6tC9HVS7OVnli8Hc7Du+kZTgLM7ta99xCAAYhfB2ofzSpnH1nUaW8
SjlVor44v9nsspHWaKKiDTLM7IYWnDcbjK5kdE44yetlAx7am2GSYX6/HideH2OK
8Ab4vyAiNN42pkJBjw4CiAwjwtinZ8M6oCFMLb3MR+tZnZyAl/UeoZU2NQsyebcX
si7lHngtfWfypHdcKNPM4/HeCb2RKKwAqdIN+794xuhHmxaDNq8qngCY16XeaBp8
8iXjz0NZv3OXxD5j3JYAK3IDPaRPkw==
=ulgG
-----END PGP SIGNATURE-----

--Rqqd6H6I9CEZswqe--


