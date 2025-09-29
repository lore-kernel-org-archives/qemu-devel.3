Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB535CCA468
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 19:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3JLu-0001oa-8Q; Mon, 29 Sep 2025 15:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3JLr-0001nk-1s
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3JLk-0007Nl-RX
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759173349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i9h3S52/AXwrfLbY/sDG1zf7lUq1OubGGGdWG/lK4cY=;
 b=EL9Zqh8kFK9IdXCC0vTy0g7mvVC1V8BuNI4UVtSOVnym2klS+yQKNkegKBcB0CcmjGK/Jk
 ECA8JCniV+RgcXCMpXBadc20zAaLskfOUmh+80UJ/afJF/MgZ+jjMIbniJo1tCklgEswEC
 zYoUM5V8Y50WO/TZcjgZx5/6/s0d+Og=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-_jv13phxNhKVHrgOd5WUVg-1; Mon,
 29 Sep 2025 15:15:46 -0400
X-MC-Unique: _jv13phxNhKVHrgOd5WUVg-1
X-Mimecast-MFC-AGG-ID: _jv13phxNhKVHrgOd5WUVg_1759173345
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA1F119774DF; Mon, 29 Sep 2025 19:15:44 +0000 (UTC)
Received: from localhost (unknown [10.2.17.29])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 475EF30002C5; Mon, 29 Sep 2025 19:15:43 +0000 (UTC)
Date: Mon, 29 Sep 2025 15:15:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, stevensd@chromium.org, dbassey@redhat.com,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, slp@redhat.com,
 hi@alyssa.is, Fabiano Rosas <farosas@suse.de>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
 david@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v8 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <20250929191542.GI81824@fedora>
References: <20250910115420.1012191-1-aesteve@redhat.com>
 <CADSE00K1zU9EeHYRCXie=i=jz55YLzExXdJ5_Ng6sH2w0fySVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0skIrjFcQSnorR5J"
Content-Disposition: inline
In-Reply-To: <CADSE00K1zU9EeHYRCXie=i=jz55YLzExXdJ5_Ng6sH2w0fySVQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--0skIrjFcQSnorR5J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 10:28:07AM +0200, Albert Esteve wrote:
> On Wed, Sep 10, 2025 at 1:54=E2=80=AFPM Albert Esteve <aesteve@redhat.com=
> wrote:
> >
> > Hi all,
> >
> > v7->v8
> > - Unified VhostUserShmemObject and VirtioSharedMemoryMapping
> > - Refined shmem_obj lifecycle by transferring ownership
> > - Other small improvements
> > v6->v7
> > - Fixed vhost_user_shmem_object_new to use
> >   memory_region_init_ram_from_fd as before
> > v5->v6
> > - Added intermediate QOM object to manage shared MemoryRegion lifecycle
> >   with reference counting, and automatic cleanup
> > - Resolved BAR conflict, change from 2 to 3 to avoid conflict with
> >   `modern-pio-notify=3Don`
> > - Added SHMEM_CONFIG validation in vhost-user-test
> > - Changed VirtSharedMemory -> VirtioSharedMemory
> > - Changed MappedMemoryRegion -> VirtioSharedMemoryMapping
> > - Changed from heap-allocated MemoryRegion *mr to embedded MemoryRegion
> >   mr in VirtioSharedMemory structure to eliminate memory leaks and
> >   simplify cleanup
> > - Fixed VirtioSharedMemory initialization and cleanup with
> >   memory_region_init() and object_unparent()
> > - Other minor fixes, typos, and updates.
> >
> > This patch series implements dynamic fd-backed memory mapping support
> > for vhost-user backends, enabling backends to dynamically request memory
> > mappings and unmappings during runtime through the new
> > VHOST_USER_BACKEND_SHMEM_MAP/UNMAP protocol messages.
> >
> > This feature benefits various VIRTIO devices that require dynamic shared
> > memory management, including virtiofs (for DAX mappings), virtio-gpu
> > (for resource sharing), and the recently standardized virtio-media.
> >
> > The implementation introduces a QOM-based architecture for managing
> > shared memory lifecycle:
> >
> > - VirtioSharedMemoryMapping: an intermediate object that manages
> >   individual memory mappings by acting as generic container for regions
> >   declared in any vhost-user device type
> > - Dynamic Mapping: backends can request mappings via SHMEM_MAP messages,
> >   with the frontend creating MemoryRegions from the provided file
> >   descriptors and adding them as subregions
> >
> > When a SHMEM_MAP request is received, the frontend:
> > 1. Creates VirtioSharedMemoryMapping to manage the mapping lifecycle
> > 2. Maps the provided fd with memory_region_init_ram_from_fd()
> > 3. Creates a MemoryRegion backed by the mapped memory
> > 4. Adds it as a subregion of the appropiate VIRTIO Shared Memory Region
> >
> > The QOM reference counting ensures automatic cleanup when mappings are
> > removed or the device is destroyed.
> >
> > This patch also includes:
> > - VHOST_USER_GET_SHMEM_CONFIG: a new frontend request allowing generic
> >   vhost-user devices to query shared memory configuration from backends
> >   at device initialization, enabling the generic vhost-user-device
> >   frontend to work with any backend regardless of specific shared memory
> >   requirements.
>=20
> Small bump to avoid this patch series falling too much.

Sorry for the slow review. I've finished now.

Stefan

--0skIrjFcQSnorR5J
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmja2t4ACgkQnKSrs4Gr
c8hQRAf9GwaaGGp5TJXDqCz83QwCd+PQXWRTc0yyY1YvusUO2CZa43+Fnk8Euu+X
yL3hUG8qPGWlZEIA1zs/mMzAVmBjDkaFly+CoM8iB6K+yrj+NpohY1Nu6RmuLAgJ
exqRaMm239CcMVS9bFJr2/0uKLdVdLnyK8Lj5NjZYBuzfXojrWANQUZIOy/+u/3Z
TtYfQJ3Pnciz0Ve4EqkbgI8p+TNEILrLCqQZIhpVSLw42Vb4mOYvUcbyIo/zslnZ
4laXqSbyue5I2VZV3otxgeor+k6ozwxaPdcjxjD0yFOQJVe8uuCXiFw0HeQqA6tp
Em7rPtCfvU2XpeTX3AOAqz46AxjAyQ==
=jfOL
-----END PGP SIGNATURE-----

--0skIrjFcQSnorR5J--


