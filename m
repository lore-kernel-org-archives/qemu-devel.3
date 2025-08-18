Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6C9CA0EF5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 10:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoJnr-00069S-1D; Tue, 19 Aug 2025 06:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uoJnn-00068R-NT
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uoJnl-0000ux-Pi
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755600168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kaijWsZRrcclAXE1xHRYlwDTBpuRx210vtdfnA46Gfc=;
 b=Eqmhyv31hJ7riRMtCltnYaJ9+yLHKa9w2F7WTPJRpVIjLjk9g8JUMssYRaIJZSQzsCbG3B
 8v4+xxkyiLTmebbgomCIEs1CbTPFktjEWtTIJ1/QKAKO21qu70ww+qdM8pa0lA93Uw2cmg
 0Fk17QA4uAq7oJ4fHXpyDaILi8Y6sk4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-RkzXG3ktPJCCnZ3J-BwcTA-1; Tue,
 19 Aug 2025 06:42:46 -0400
X-MC-Unique: RkzXG3ktPJCCnZ3J-BwcTA-1
X-Mimecast-MFC-AGG-ID: RkzXG3ktPJCCnZ3J-BwcTA_1755600165
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF42818003FC; Tue, 19 Aug 2025 10:42:44 +0000 (UTC)
Received: from localhost (unknown [10.2.16.68])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 334DB19560B0; Tue, 19 Aug 2025 10:42:43 +0000 (UTC)
Date: Mon, 18 Aug 2025 19:14:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, david@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, hi@alyssa.is,
 jasowang@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 dbassey@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, stevensd@chromium.org,
 Fabiano Rosas <farosas@suse.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, slp@redhat.com
Subject: Re: [PATCH v7 6/8] tests/qtest: Add GET_SHMEM validation test
Message-ID: <20250818231438.GA30271@fedora>
References: <20250818100353.1560655-1-aesteve@redhat.com>
 <20250818100353.1560655-7-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SGTrlahYrSgbmtqR"
Content-Disposition: inline
In-Reply-To: <20250818100353.1560655-7-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--SGTrlahYrSgbmtqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 12:03:51PM +0200, Albert Esteve wrote:
> Improve vhost-user-test to properly validate
> VHOST_USER_GET_SHMEM_CONFIG message handling by
> directly simulating the message exchange.
>=20
> The test manually triggers the
> VHOST_USER_GET_SHMEM_CONFIG message by calling
> chr_read() with a crafted VhostUserMsg, allowing direct
> validation of the shmem configuration response handler.

It looks like this test case invokes its own chr_read() function without
going through QEMU, so I don't understand what this is testing?

>=20
> Added TestServerShmem structure to track shmem
> configuration state, including nregions_sent and
> sizes_sent arrays for comprehensive validation.
> The test verifies that the response contains the expected
> number of shared memory regions and their corresponding
> sizes.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  tests/qtest/vhost-user-test.c | 91 +++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>=20
> diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
> index 75cb3e44b2..44a5e90b2e 100644
> --- a/tests/qtest/vhost-user-test.c
> +++ b/tests/qtest/vhost-user-test.c
> @@ -88,6 +88,7 @@ typedef enum VhostUserRequest {
>      VHOST_USER_SET_VRING_ENABLE =3D 18,
>      VHOST_USER_GET_CONFIG =3D 24,
>      VHOST_USER_SET_CONFIG =3D 25,
> +    VHOST_USER_GET_SHMEM_CONFIG =3D 44,
>      VHOST_USER_MAX
>  } VhostUserRequest;
> =20
> @@ -109,6 +110,20 @@ typedef struct VhostUserLog {
>      uint64_t mmap_offset;
>  } VhostUserLog;
> =20
> +#define VIRTIO_MAX_SHMEM_REGIONS 256
> +
> +typedef struct VhostUserShMemConfig {
> +    uint32_t nregions;
> +    uint32_t padding;
> +    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
> +} VhostUserShMemConfig;
> +
> +typedef struct TestServerShmem {
> +    bool test_enabled;
> +    uint32_t nregions_sent;
> +    uint64_t sizes_sent[VIRTIO_MAX_SHMEM_REGIONS];
> +} TestServerShmem;
> +
>  typedef struct VhostUserMsg {
>      VhostUserRequest request;
> =20
> @@ -124,6 +139,7 @@ typedef struct VhostUserMsg {
>          struct vhost_vring_addr addr;
>          VhostUserMemory memory;
>          VhostUserLog log;
> +        VhostUserShMemConfig shmem;
>      } payload;
>  } QEMU_PACKED VhostUserMsg;
> =20
> @@ -170,6 +186,7 @@ typedef struct TestServer {
>      bool test_fail;
>      int test_flags;
>      int queues;
> +    TestServerShmem shmem;
>      struct vhost_user_ops *vu_ops;
>  } TestServer;
> =20
> @@ -513,6 +530,31 @@ static void chr_read(void *opaque, const uint8_t *bu=
f, int size)
>          qos_printf("set_vring(%d)=3D%s\n", msg.payload.state.index,
>                     msg.payload.state.num ? "enabled" : "disabled");
>          break;
> +   =20
> +    case VHOST_USER_GET_SHMEM_CONFIG:
> +        if (!s->shmem.test_enabled) {
> +            /* Reply with error if shmem feature not enabled */
> +            msg.flags |=3D VHOST_USER_REPLY_MASK;
> +            msg.size =3D sizeof(uint64_t);
> +            msg.payload.u64 =3D -1; /* Error */
> +            qemu_chr_fe_write_all(chr, (uint8_t *) &msg, VHOST_USER_HDR_=
SIZE + msg.size);
> +        } else {
> +            /* Reply with test shmem configuration */
> +            msg.flags |=3D VHOST_USER_REPLY_MASK;
> +            msg.size =3D sizeof(VhostUserShMemConfig);
> +            msg.payload.shmem.nregions =3D 2; /* Test with 2 regions */
> +            msg.payload.shmem.padding =3D 0;
> +            msg.payload.shmem.memory_sizes[0] =3D 0x100000; /* 1MB */
> +            msg.payload.shmem.memory_sizes[1] =3D 0x200000; /* 2MB */
> +           =20
> +            /* Record what we're sending for test validation */
> +            s->shmem.nregions_sent =3D msg.payload.shmem.nregions;
> +            s->shmem.sizes_sent[0] =3D msg.payload.shmem.memory_sizes[0];
> +            s->shmem.sizes_sent[1] =3D msg.payload.shmem.memory_sizes[1];
> +           =20
> +            qemu_chr_fe_write_all(chr, (uint8_t *) &msg, VHOST_USER_HDR_=
SIZE + msg.size);
> +        }
> +        break;
> =20
>      default:
>          qos_printf("vhost-user: un-handled message: %d\n", msg.request);
> @@ -809,6 +851,22 @@ static void *vhost_user_test_setup_shm(GString *cmd_=
line, void *arg)
>      return server;
>  }
> =20
> +static void *vhost_user_test_setup_shmem_config(GString *cmd_line, void =
*arg)
> +{
> +    TestServer *server =3D test_server_new("vhost-user-test", arg);
> +    test_server_listen(server);
> +
> +    /* Enable shmem testing for this server */
> +    server->shmem.test_enabled =3D true;
> +
> +    append_mem_opts(server, cmd_line, 256, TEST_MEMFD_SHM);
> +    server->vu_ops->append_opts(server, cmd_line, "");
> +
> +    g_test_queue_destroy(vhost_user_test_cleanup, server);
> +
> +    return server;
> +}
> +
>  static void test_read_guest_mem(void *obj, void *arg, QGuestAllocator *a=
lloc)
>  {
>      TestServer *server =3D arg;
> @@ -1089,6 +1147,33 @@ static struct vhost_user_ops g_vu_net_ops =3D {
>      .get_protocol_features =3D vu_net_get_protocol_features,
>  };
> =20
> +/* Test function for VHOST_USER_GET_SHMEM_CONFIG message */
> +static void test_shmem_config(void *obj, void *arg, QGuestAllocator *all=
oc)
> +{
> +    TestServer *s =3D arg;
> +   =20
> +    g_assert_true(s->shmem.test_enabled);
> +   =20
> +    g_mutex_lock(&s->data_mutex);
> +    s->shmem.nregions_sent =3D 0;
> +    s->shmem.sizes_sent[0] =3D 0;
> +    s->shmem.sizes_sent[1] =3D 0;
> +    g_mutex_unlock(&s->data_mutex);
> +   =20
> +    VhostUserMsg msg =3D {
> +        .request =3D VHOST_USER_GET_SHMEM_CONFIG,
> +        .flags =3D VHOST_USER_VERSION,
> +        .size =3D 0,
> +    };
> +    chr_read(s, (uint8_t *) &msg, VHOST_USER_HDR_SIZE);
> +
> +    g_mutex_lock(&s->data_mutex);
> +    g_assert_cmpint(s->shmem.nregions_sent, =3D=3D, 2);
> +    g_assert_cmpint(s->shmem.sizes_sent[0], =3D=3D, 0x100000); /* 1MB */
> +    g_assert_cmpint(s->shmem.sizes_sent[1], =3D=3D, 0x200000); /* 2MB */
> +    g_mutex_unlock(&s->data_mutex);
> +}
> +
>  static void register_vhost_user_test(void)
>  {
>      QOSGraphTestOptions opts =3D {
> @@ -1136,6 +1221,12 @@ static void register_vhost_user_test(void)
>      qos_add_test("vhost-user/multiqueue",
>                   "virtio-net",
>                   test_multiqueue, &opts);
> +   =20
> +    opts.before =3D vhost_user_test_setup_shmem_config;
> +    opts.edge.extra_device_opts =3D "";
> +    qos_add_test("vhost-user/shmem-config",
> +                 "virtio-net",
> +                 test_shmem_config, &opts);
>  }
>  libqos_init(register_vhost_user_test);
> =20
> --=20
> 2.49.0
>=20

--SGTrlahYrSgbmtqR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmijs94ACgkQnKSrs4Gr
c8gllQf/bRd+9/ZViGBNd0GgI2JP2k2nz+o6V9pLhN0wQppIKMUKCW971qKVn1q6
nECgUUUTHjO3cubDRpEpqSLnm3nlmFAxSwT2peRdQ0Duxo0bldmp9ajXPrPsUtAQ
vnN8yHJd3VpXDrRaCvRwQUHTidSe6+oqvAeisieLYYuexDKYVvD3bxFgUiDdQ4r/
L4+3PeEODtMOgtUZnJAemHCHfpWLF+I5BmuE8fE/rOp+hO1fkBY+rR0l9HBaxzAk
0BRMUL476xKmbx5LIH9iFMvkyS8ZTqGluhWiN/eJhnCKHBnV8UZdCLSXr8s+3++D
IFTIm42VTWCvO1bTRAto5WcN1mwoUw==
=S/kB
-----END PGP SIGNATURE-----

--SGTrlahYrSgbmtqR--


