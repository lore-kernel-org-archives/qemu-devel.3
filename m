Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD7CC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 10:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRrTU-0000Xi-GR; Thu, 11 Jul 2024 06:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1sRrTR-0000TM-Ej
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:56:29 -0400
Received: from fhigh1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1sRrTO-0006wh-EB
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:56:29 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id D8FF811419E7;
 Thu, 11 Jul 2024 06:56:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Thu, 11 Jul 2024 06:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1720695381; x=1720781781; bh=kpdFLKlfvt
 F7R50wPE7ely1RwQ0D/FYuUutE6NfjGBI=; b=tRL88gxuDMX41EQ+rgSU6+iApa
 RZdpSYuxYUg7mbbvqrz645MQbHhU5bDSVm7EaHpq++Ps49LCsETtfl9WD8vuUcX7
 rsetOZcn14rUimbqizc1p726vLcg5nVkyaM/0S6x1SUXHsGe0EWVer6rSidwV/gb
 BWCiykDIKyCRVkfvfCiw9rKRB+hMS0OvfKlbzUOJHBqh7M6GU920TntlZM5Tabbi
 a7U3EIjV1EuY9fGeidZsSNKKte5TQGn7WkjR0+UKV+BcX0BQWSTV0OF/Qv4XE8Ck
 LoZcwyP/kE4NviS7XEe416e3T5XzSUGroX92rw/TWR1L8/To4MrFXoAsfjSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1720695381; x=1720781781; bh=kpdFLKlfvtF7R50wPE7ely1RwQ0D
 /FYuUutE6NfjGBI=; b=Fo4HtHfqGdBSoPYowQ9dSsB+arS2+/OWbMpnm2GiUzjc
 DHkkBsaVhxa41jmfX0nL+BlGLs9vPN4m+1Q2+n1LV62i47g3lh5VRLGMIaRJUdBS
 0bzTwPiJWCxCWy+5Gr74/KWKFA4cdMsd0P+Ms0btcRXkpRGyQCxxFNCvoeg2qryS
 YhtXlDN1dUN93l/eNmQVCd5IU/fxAS0xw5inPlJd4n/zJq5M81eyFfjNSgfNCFpP
 5x86oXoSGLLkK/ttIcXn5FCdE2AcKpqzMt5uqnzByzVCHGpM6s7LBpe77cVD/Uck
 Po0RB39bGExJa0MYjKwQOL0q6ceB8IZKwSJXB0h3pg==
X-ME-Sender: <xms:VLqPZp-COlzJqtWEFtFnMgE-Vqelc_yP5v5-Tvxh1-IuL7XFMYpROw>
 <xme:VLqPZtuTzmp5Jny1hXDUOVMMX-fHeVyG9tADrGgoCfVI2v5UZrUCuVIF6DpZImJay
 ebs-FeGcZJPTVoT7A>
X-ME-Received: <xmr:VLqPZnAOEEJ9Fw59PmzB8C6q4RtV9vCQypMrZ_amLy3H3Id6EZM2-tQRQrp9TUpAU7wpX7Rc30Oo35P3xPxd2JTdNnVT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdefhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufgjfhffkfggtgesghdtreertddttdenucfhrhhomheptehlhihsshgr
 ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnheptddtke
 dtvdeltdeufeetheffjedtjeektdegudegjedujefhveevtdekueejgeejnecuffhomhgr
 ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
X-ME-Proxy: <xmx:VLqPZtcx8kGW6V_vPTq71fIgMdg21Qzr3ZSYOIhxxgyYCZo02p5vLg>
 <xmx:VLqPZuMmXk3MSLyzvihj4hJX7sU5ULC1sxRkZGoxySoNcVqWWmVZIA>
 <xmx:VLqPZvkcMbypCaOgaektqwLxWLU6sSOOb1X4W8FJa-JDVQyBZzIt9w>
 <xmx:VLqPZoudGldVUzFAEUhD95_mGhvddheL51V9pI-NDKzSeUgHE2yBZw>
 <xmx:VbqPZlp2Y_XGDvsU_4dnXmGYXE4aCDJVhoY2C_Pq7_CGudmx5NS2IHBt>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 06:56:20 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 0B33522A4; Thu, 11 Jul 2024 12:56:18 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org, David Stevens
 <stevensd@chromium.org>
Cc: jasowang@redhat.com, david@redhat.com, slp@redhat.com, Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, stefanha@redhat.com, "Michael S. Tsirkin"
 <mst@redhat.com>, Albert Esteve <aesteve@redhat.com>
Subject: Re: [RFC PATCH v2 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
In-Reply-To: <20240628145710.1516121-1-aesteve@redhat.com>
References: <20240628145710.1516121-1-aesteve@redhat.com>
Date: Thu, 11 Jul 2024 12:56:09 +0200
Message-ID: <87bk34i4dy.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=103.168.172.152; envelope-from=hi@alyssa.is;
 helo=fhigh1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Adding David Stevens, who implemented SHMEM_MAP and SHMEM_UNMAP in
crosvm a couple of years ago.

David, I'd be particularly interested for your thoughts on the MEM_READ
and MEM_WRITE commands, since as far as I know crosvm doesn't implement
anything like that.  The discussion leading to those being added starts
here:

https://lore.kernel.org/qemu-devel/20240604185416.GB90471@fedora.redhat.com/

It would be great if this could be standardised between QEMU and crosvm
(and therefore have a clearer path toward being implemented in other VMMs)!

Albert Esteve <aesteve@redhat.com> writes:

> Hi all,
>
> v1->v2:
> - Corrected typos and clarifications from
>   first review
> - Added SHMEM_CONFIG frontend request to
>   query VIRTIO shared memory regions from
>   backends
> - vhost-user-device to use SHMEM_CONFIG
>   to request and initialise regions
> - Added MEM_READ/WRITE backend requests
>   in case address translation fails
>   accessing VIRTIO Shared Memory Regions
>   with MMAPs
>
> This is an update of my attempt to have
> backends support dynamic fd mapping into VIRTIO
> Shared Memory Regions. After the first review
> I have added more commits and new messages
> to the vhost-user protocol.
> However, I still have some doubts as to
> how will this work, specially regarding
> the MEM_READ and MEM_WRITE commands.
> Thus, I am still looking for feedback,
> to ensure that I am going in the right
> direction with the implementation.
>
> The usecase for this patch is, e.g., to support
> vhost-user-gpu RESOURCE_BLOB operations,
> or DAX Window request for virtio-fs. In
> general, any operation where a backend
> need to request the frontend to mmap an
> fd into a VIRTIO Shared Memory Region,
> so that the guest can then access it.
>
> After receiving the SHMEM_MAP/UNMAP request,
> the frontend will perform the mmap with the
> instructed parameters (i.e., shmid, shm_offset,
> fd_offset, fd, lenght).
>
> As there are already a couple devices
> that could benefit of such a feature,
> and more could require it in the future,
> the goal is to make the implementation
> generic.
>
> To that end, the VIRTIO Shared Memory
> Region list is declared in the `VirtIODevice`
> struct.
>
> This patch also includes:
> SHMEM_CONFIG frontend request that is
> specifically meant to allow generic
> vhost-user-device frontend to be able to
> query VIRTIO Shared Memory settings from the
> backend (as this device is generic and agnostic
> of the actual backend configuration).
>
> Finally, MEM_READ/WRITE backend requests are
> added to deal with a potential issue when having
> any backend sharing a descriptor that references
> a mapping to another backend. The first
> backend will not be able to see these
> mappings. So these requests are a fallback
> for vhost-user memory translation fails.
>
> Albert Esteve (5):
>   vhost-user: Add VIRTIO Shared Memory map request
>   vhost_user: Add frontend command for shmem config
>   vhost-user-dev: Add cache BAR
>   vhost_user: Add MEM_READ/WRITE backend requests
>   vhost_user: Implement mem_read/mem_write handlers
>
>  docs/interop/vhost-user.rst               |  58 ++++++
>  hw/virtio/vhost-user-base.c               |  39 +++-
>  hw/virtio/vhost-user-device-pci.c         |  37 +++-
>  hw/virtio/vhost-user.c                    | 221 ++++++++++++++++++++++
>  hw/virtio/virtio.c                        |  12 ++
>  include/hw/virtio/vhost-backend.h         |   6 +
>  include/hw/virtio/vhost-user.h            |   1 +
>  include/hw/virtio/virtio.h                |   5 +
>  subprojects/libvhost-user/libvhost-user.c | 149 +++++++++++++++
>  subprojects/libvhost-user/libvhost-user.h |  91 +++++++++
>  10 files changed, 614 insertions(+), 5 deletions(-)
>
> --=20
> 2.45.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmaPukkACgkQ+dvtSFmy
ccDxzRAAgD4LIuzalRQjnwetGr35hryeR1h5+u/g5QJMGTvvEFY3HC9VrlZrVCyd
VhtbfdVKZQU7FKsxmMYQcE/wOCxkaFLdbxLnyfbtIOWgAbULYsasb4OZblnXt5k2
bDS4Flj6rz9Nk73WzA6zNiTDVQiODBB5OWTjaT6RhUaHcEVRbmG69hFjm26P2cKx
BE+4cV2DNzQDmoYBC3SvvOZyz8mXlV/im+xl/ZtLxX5g8NRLNES56Hrx/218dUUh
Gl1QhJltcd2kIOhKJBcZ79oYC5CuT80PxvQ7Ax2ZDDtfYg+7NGUeYObgUwKetFqM
T6yVM6T1w/dappJE9JrMod8ezGQ+FnAY0PVG72lcZJd4wnJJDTOTA64AGXDH68C5
SzDDOU//DlkdGMbHALWDT7cr6hwip6LXywaUBKwbrX+1CP01FxA1HVKmth11/tU2
XrUx4NHd+GbpvWBg9nwbhDfMJxO9F17Xo/Ngrdo7IweAYLDtM/TMRWzrgrnejwEo
NlW/fBRkN4xxHK1bBd0gvCMkcI58sPrcCa0ODQvUxvhNHe0OoHKkbdMtV8DnczR9
LndeaPYwKA5bm4MHqhQUEytywmgwQpKctGiaTu4MCHdpF3fSgzN7wdsfC8Msl/uQ
W225dXW33DNZBPqb6uL/RWF3ebFsYoh2s3MQqwTfk1lzPD3/ZlM=
=DpX1
-----END PGP SIGNATURE-----
--=-=-=--

