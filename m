Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10811C3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRoyO-0008Kq-6S; Thu, 11 Jul 2024 04:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRoyK-00088f-5O
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRoyG-0007m1-7y
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720685765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J0MLmWGsC6TVNoDwUvTT7I37s/y+f9HjO5i4IcMCM6k=;
 b=ZUi+QhaUiaZbmZ+ykmUBTLkdMwkKYxc8dF4JywV35CpHxQpAhKhZmiX5nNDaPdOjjVMF9m
 lMcIokghnMuQhSnsDTq58ijglwgA22AirwKvFJ5ikyaUV6NqWkcwvwVuID6HgQS13tDwmE
 4BSpECN2s5AaQ9oShuN0bD2LuBrPRrU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-ouZU4ZpHNxGWMHfsVadZLA-1; Thu,
 11 Jul 2024 04:15:58 -0400
X-MC-Unique: ouZU4ZpHNxGWMHfsVadZLA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C6DA1955BC7; Thu, 11 Jul 2024 08:15:56 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0290819560AA; Thu, 11 Jul 2024 08:15:54 +0000 (UTC)
Date: Thu, 11 Jul 2024 10:15:53 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com,
 slp@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v2 2/5] vhost_user: Add frontend command for shmem
 config
Message-ID: <20240711081553.GA572069@dynamic-pd01.res.v6.highway.a1.net>
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <20240628145710.1516121-3-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A+seTadtYhm8vzwx"
Content-Disposition: inline
In-Reply-To: <20240628145710.1516121-3-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--A+seTadtYhm8vzwx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 04:57:07PM +0200, Albert Esteve wrote:
> The frontend can use this command to retrieve
> VIRTIO Shared Memory Regions configuration from
> the backend. The response contains the number of
> shared memory regions, their size, and shmid.
>=20
> This is useful when the frontend is unaware of
> specific backend type and configuration,
> for example, in the `vhost-user-device` case.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst       | 31 +++++++++++++++++++++++
>  hw/virtio/vhost-user.c            | 42 +++++++++++++++++++++++++++++++
>  include/hw/virtio/vhost-backend.h |  6 +++++
>  include/hw/virtio/vhost-user.h    |  1 +
>  4 files changed, 80 insertions(+)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index d52ba719d5..51f01d1d84 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -348,6 +348,19 @@ Device state transfer parameters
>    In the future, additional phases might be added e.g. to allow
>    iterative migration while the device is running.
> =20
> +VIRTIO Shared Memory Region configuration
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> ++-------------+---------+------------+----+------------+
> +| num regions | padding | mem size 0 | .. | mem size 7 |
> ++-------------+---------+------------+----+------------+
> +
> +:num regions: a 32-bit number of regions
> +
> +:padding: 32-bit
> +
> +:mem size: 64-bit size of VIRTIO Shared Memory Region
> +
>  C structure
>  -----------
> =20
> @@ -369,6 +382,10 @@ In QEMU the vhost-user message is implemented with t=
he following struct:
>            VhostUserConfig config;
>            VhostUserVringArea area;
>            VhostUserInflight inflight;
> +          VhostUserShared object;
> +          VhostUserTransferDeviceState transfer_state;
> +          VhostUserMMap mmap;
> +          VhostUserShMemConfig shmem;
>        };
>    } QEMU_PACKED VhostUserMsg;
> =20
> @@ -1051,6 +1068,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>    #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
>    #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
> +  #define VHOST_USER_PROTOCOL_F_SHMEM                20
> =20
>  Front-end message types
>  -----------------------
> @@ -1725,6 +1743,19 @@ Front-end message types
>    Using this function requires prior negotiation of the
>    ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
> =20
> +``VHOST_USER_GET_SHMEM_CONFIG``
> +  :id: 44
> +  :equivalent ioctl: N/A
> +  :request payload: N/A
> +  :reply payload: ``struct VhostUserShMemConfig``
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> +  successfully negotiated, this message can be submitted by the front-end
> +  to gather the VIRTIO Shared Memory Region configuration. Back-end will=
 respond
> +  with the number of VIRTIO Shared Memory Regions it requires, and each =
shared memory
> +  region size in an array. The shared memory IDs are represented by the =
index
> +  of the array.

Please add:
- The Shared Memory Region size must be a multiple of the page size support=
ed by mmap(2).
- The size may be 0 if the region is unused. This can happen when the
  device does not support an optional feature but does support a feature
  that uses a higher shmid.

--A+seTadtYhm8vzwx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaPlLkACgkQnKSrs4Gr
c8i5Ngf/dDMyT8Er1XkTzi7yEWRZmUi4fpFaiO81+xKSk6HNyeVv2p0ONDFSp+Fu
MNkfWlyz8FhF+QQ1lvb0rxWz63Sry9FvESpV7+1ixpP3Jmx4v9oaDa/91b2ssF9c
d6R/YHJVuctx+oYY0ru4kSOMYxdxlOIjvlKSMVMtBJoFketz+j0RUSi7QoIR2vdR
8HRRcsWGd/buCMN1FjHGG10gFwyi/oJyXi9p/jzLt0zz9iKXINXLdTMBX+RpPk3h
A6IVXp9oYmv3/Jqn6IluOjJIy/yA2WoJxTclvnonzcC4+uy96l3x6J93BUggS49u
uc7tSGdmHxLDpuuMBs+0y557rsI17Q==
=ZDSo
-----END PGP SIGNATURE-----

--A+seTadtYhm8vzwx--


