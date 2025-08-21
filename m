Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19295CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 06:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoz8N-0006gx-7Y; Thu, 21 Aug 2025 02:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uoz8H-0006ga-DU
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 02:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uoz8A-0000Pv-Aq
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 02:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755759026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkbOPZmqkJeCjXvGOqYe1Q+0Vl+FqixoDUVrb+Tr2ho=;
 b=OETSCTd2QxPgUelqIOhSkqKRasksM3HWE3Hs+3QJqPdS7F0wqidmR5ewpFsr1K2wR7tP4p
 esDRPWoTJOflPOIimeWCxZRnJAxKWEX/71fV4hjdUElz+Swfar+QKJUyUSnaS8YXopeY6s
 uVP6Ynh5bI1LnvpC2qu4xGtGRF6H67c=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-WjVr_TsQOhGpVi6jExU6iQ-1; Thu, 21 Aug 2025 02:50:24 -0400
X-MC-Unique: WjVr_TsQOhGpVi6jExU6iQ-1
X-Mimecast-MFC-AGG-ID: WjVr_TsQOhGpVi6jExU6iQ_1755759024
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-244581c62faso9358665ad.2
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 23:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755759024; x=1756363824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fkbOPZmqkJeCjXvGOqYe1Q+0Vl+FqixoDUVrb+Tr2ho=;
 b=S5jQBiRo1OiDljtNmTotRzF/Fy31AgGT6emaFaLqK+x7ujqW8djpNtRCSCKNdxL1Ej
 S3s9YAkvp1aPsoRWujI5+jgpRFyCqtk26IwWlg1xj5row/jbIkTVlMUJWhNpOQ6uIpba
 uf0i8/EW4ta/BlYsNcIY/TgTxNQ9MDrIzZxdHN53UUWSnfwBQQ7Tcj3xXdDz5CvgaE4y
 z6bf/4t2m8MhHKlohvos31j7F+RinZ1H+1ByBBJKA1/8WnCldb7U0CBQ7Kt3FTPwfbfT
 vB70Cs20Lh+G4n7G3Tfr70npOg1ypTBr/VzyJcZtuL9Z2VW3fRz5p1oBPDkBVQG4hDe9
 AbKg==
X-Gm-Message-State: AOJu0Yws4h0JUez2aDm65+aYUCZVhwt2DH2fJ7xI6Jy+KFPcAcDPTcvG
 7k6qy+fXF8PPiWD9N2Q8cSdYVvOZ8r2SnkSsnvukSWsahvz1QHKvNMbeDR1mrkOoSlmnDvRuvR/
 R527AR15/NCw3gkiiaRV3kakrBaXl9gK7s44cXSZf/eZJ6Zc83hbhV2bj/B4EBwxABjmQrpU4CH
 YpwRPEZcja0nPnmaR4YBed31ALK1kYZRg=
X-Gm-Gg: ASbGncslc++oOkJSF7aQTHkVSNyru25DAC/dylV9698T7Fk1gA4M0TzUlmsC6gydxHA
 N93rF39H9bscy7Q0k3SngHxb9ewE5Ga3UFLy7wln+gqMbHXXmQr9OwFgcxOuKqB65945J8atlDZ
 Z4Pfh4BdWUgwq8dquTO/I6
X-Received: by 2002:a17:902:ea05:b0:245:f5b8:87ab with SMTP id
 d9443c01a7336-245febda3demr19343035ad.3.1755759023750; 
 Wed, 20 Aug 2025 23:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu+a13MHeqvtJ195uirZfpsYRx6GFIpcXVxTpNErs4Blh7L9tqIx9WK7xCLTxxrNuGCW1fExt8bDWevxwMYb4=
X-Received: by 2002:a17:902:ea05:b0:245:f5b8:87ab with SMTP id
 d9443c01a7336-245febda3demr19342675ad.3.1755759023259; Wed, 20 Aug 2025
 23:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250818100353.1560655-1-aesteve@redhat.com>
 <20250818100353.1560655-7-aesteve@redhat.com>
 <20250818231438.GA30271@fedora>
 <CADSE00J61r4Wt94s6OfCqt9V8sVaisgDajvKEYFmG1FJKdVfng@mail.gmail.com>
 <20250820203348.GA131468@fedora>
In-Reply-To: <20250820203348.GA131468@fedora>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 21 Aug 2025 08:50:10 +0200
X-Gm-Features: Ac12FXxKfsF4rmB0jo6j19HO6Wm08Zj7Lw3BTUO2br7gtKVPmfalEWlKITbAHk4
Message-ID: <CADSE00LVbpzB9Y1PHyb4HZHE+K1U3gNg4rGST=5FjdYEO0pWzQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] tests/qtest: Add GET_SHMEM validation test
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, david@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, hi@alyssa.is, jasowang@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, dbassey@redhat.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 stevensd@chromium.org, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, slp@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 20, 2025 at 10:33=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Tue, Aug 19, 2025 at 02:16:47PM +0200, Albert Esteve wrote:
> > On Tue, Aug 19, 2025 at 12:42=E2=80=AFPM Stefan Hajnoczi <stefanha@redh=
at.com> wrote:
> > >
> > > On Mon, Aug 18, 2025 at 12:03:51PM +0200, Albert Esteve wrote:
> > > > Improve vhost-user-test to properly validate
> > > > VHOST_USER_GET_SHMEM_CONFIG message handling by
> > > > directly simulating the message exchange.
> > > >
> > > > The test manually triggers the
> > > > VHOST_USER_GET_SHMEM_CONFIG message by calling
> > > > chr_read() with a crafted VhostUserMsg, allowing direct
> > > > validation of the shmem configuration response handler.
> > >
> > > It looks like this test case invokes its own chr_read() function with=
out
> > > going through QEMU, so I don't understand what this is testing?
> >
> > I spent some time trying to test it, but in the end I could not
> > instatiate vhost-user-device because it is non user_creatable. I did
> > not find any test for vhost-user-device anywhere else either. But I
> > had already added most of the infrastructure here so I fallback to
> > chr_read() communication to avoid having to delete everything. My
> > though was that once we have other devices that use shared memory,
> > they could tweak the test to instantiate the proper device and test
> > this and the map/unmap operations.
> >
> > Although after writing this, I think other devices will actually a
> > specific layout for their shared memory. So
> > VHOST_USER_GET_SHMEM_CONFIG is only ever going to be used by
> > vhost-user-device.
> >
> > In general, trying to test this patch series has been a headache other
> > than trying with external device code I have. If you have an idea that
> > I could try to test this, I can try. Otherwise, probably is best to
> > remove this commit from the series and wait for another vhost-user
> > device that uses map/unmap to land to be able to test it.
>
> Alex Bennee has renamed vhost-user-device to vhost-user-test-device and
> set user_creatable =3D true:
> https://lore.kernel.org/qemu-devel/20250820195632.1956795-1-alex.bennee@l=
inaro.org/T/#t

Oh, great! Thanks for letting me know.

That allows having a QTest with the vhost-user-test-device available
and run it in piplines if necessary, without manually
changing/recompiling. I'll try to add it to the test again in this
commit.

Thank you, Stefan and Alyssa, for the hints.

>
> >
> >
> >
> > >
> > > >
> > > > Added TestServerShmem structure to track shmem
> > > > configuration state, including nregions_sent and
> > > > sizes_sent arrays for comprehensive validation.
> > > > The test verifies that the response contains the expected
> > > > number of shared memory regions and their corresponding
> > > > sizes.
> > > >
> > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > > ---
> > > >  tests/qtest/vhost-user-test.c | 91 +++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 91 insertions(+)
> > > >
> > > > diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user=
-test.c
> > > > index 75cb3e44b2..44a5e90b2e 100644
> > > > --- a/tests/qtest/vhost-user-test.c
> > > > +++ b/tests/qtest/vhost-user-test.c
> > > > @@ -88,6 +88,7 @@ typedef enum VhostUserRequest {
> > > >      VHOST_USER_SET_VRING_ENABLE =3D 18,
> > > >      VHOST_USER_GET_CONFIG =3D 24,
> > > >      VHOST_USER_SET_CONFIG =3D 25,
> > > > +    VHOST_USER_GET_SHMEM_CONFIG =3D 44,
> > > >      VHOST_USER_MAX
> > > >  } VhostUserRequest;
> > > >
> > > > @@ -109,6 +110,20 @@ typedef struct VhostUserLog {
> > > >      uint64_t mmap_offset;
> > > >  } VhostUserLog;
> > > >
> > > > +#define VIRTIO_MAX_SHMEM_REGIONS 256
> > > > +
> > > > +typedef struct VhostUserShMemConfig {
> > > > +    uint32_t nregions;
> > > > +    uint32_t padding;
> > > > +    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
> > > > +} VhostUserShMemConfig;
> > > > +
> > > > +typedef struct TestServerShmem {
> > > > +    bool test_enabled;
> > > > +    uint32_t nregions_sent;
> > > > +    uint64_t sizes_sent[VIRTIO_MAX_SHMEM_REGIONS];
> > > > +} TestServerShmem;
> > > > +
> > > >  typedef struct VhostUserMsg {
> > > >      VhostUserRequest request;
> > > >
> > > > @@ -124,6 +139,7 @@ typedef struct VhostUserMsg {
> > > >          struct vhost_vring_addr addr;
> > > >          VhostUserMemory memory;
> > > >          VhostUserLog log;
> > > > +        VhostUserShMemConfig shmem;
> > > >      } payload;
> > > >  } QEMU_PACKED VhostUserMsg;
> > > >
> > > > @@ -170,6 +186,7 @@ typedef struct TestServer {
> > > >      bool test_fail;
> > > >      int test_flags;
> > > >      int queues;
> > > > +    TestServerShmem shmem;
> > > >      struct vhost_user_ops *vu_ops;
> > > >  } TestServer;
> > > >
> > > > @@ -513,6 +530,31 @@ static void chr_read(void *opaque, const uint8=
_t *buf, int size)
> > > >          qos_printf("set_vring(%d)=3D%s\n", msg.payload.state.index=
,
> > > >                     msg.payload.state.num ? "enabled" : "disabled")=
;
> > > >          break;
> > > > +
> > > > +    case VHOST_USER_GET_SHMEM_CONFIG:
> > > > +        if (!s->shmem.test_enabled) {
> > > > +            /* Reply with error if shmem feature not enabled */
> > > > +            msg.flags |=3D VHOST_USER_REPLY_MASK;
> > > > +            msg.size =3D sizeof(uint64_t);
> > > > +            msg.payload.u64 =3D -1; /* Error */
> > > > +            qemu_chr_fe_write_all(chr, (uint8_t *) &msg, VHOST_USE=
R_HDR_SIZE + msg.size);
> > > > +        } else {
> > > > +            /* Reply with test shmem configuration */
> > > > +            msg.flags |=3D VHOST_USER_REPLY_MASK;
> > > > +            msg.size =3D sizeof(VhostUserShMemConfig);
> > > > +            msg.payload.shmem.nregions =3D 2; /* Test with 2 regio=
ns */
> > > > +            msg.payload.shmem.padding =3D 0;
> > > > +            msg.payload.shmem.memory_sizes[0] =3D 0x100000; /* 1MB=
 */
> > > > +            msg.payload.shmem.memory_sizes[1] =3D 0x200000; /* 2MB=
 */
> > > > +
> > > > +            /* Record what we're sending for test validation */
> > > > +            s->shmem.nregions_sent =3D msg.payload.shmem.nregions;
> > > > +            s->shmem.sizes_sent[0] =3D msg.payload.shmem.memory_si=
zes[0];
> > > > +            s->shmem.sizes_sent[1] =3D msg.payload.shmem.memory_si=
zes[1];
> > > > +
> > > > +            qemu_chr_fe_write_all(chr, (uint8_t *) &msg, VHOST_USE=
R_HDR_SIZE + msg.size);
> > > > +        }
> > > > +        break;
> > > >
> > > >      default:
> > > >          qos_printf("vhost-user: un-handled message: %d\n", msg.req=
uest);
> > > > @@ -809,6 +851,22 @@ static void *vhost_user_test_setup_shm(GString=
 *cmd_line, void *arg)
> > > >      return server;
> > > >  }
> > > >
> > > > +static void *vhost_user_test_setup_shmem_config(GString *cmd_line,=
 void *arg)
> > > > +{
> > > > +    TestServer *server =3D test_server_new("vhost-user-test", arg)=
;
> > > > +    test_server_listen(server);
> > > > +
> > > > +    /* Enable shmem testing for this server */
> > > > +    server->shmem.test_enabled =3D true;
> > > > +
> > > > +    append_mem_opts(server, cmd_line, 256, TEST_MEMFD_SHM);
> > > > +    server->vu_ops->append_opts(server, cmd_line, "");
> > > > +
> > > > +    g_test_queue_destroy(vhost_user_test_cleanup, server);
> > > > +
> > > > +    return server;
> > > > +}
> > > > +
> > > >  static void test_read_guest_mem(void *obj, void *arg, QGuestAlloca=
tor *alloc)
> > > >  {
> > > >      TestServer *server =3D arg;
> > > > @@ -1089,6 +1147,33 @@ static struct vhost_user_ops g_vu_net_ops =
=3D {
> > > >      .get_protocol_features =3D vu_net_get_protocol_features,
> > > >  };
> > > >
> > > > +/* Test function for VHOST_USER_GET_SHMEM_CONFIG message */
> > > > +static void test_shmem_config(void *obj, void *arg, QGuestAllocato=
r *alloc)
> > > > +{
> > > > +    TestServer *s =3D arg;
> > > > +
> > > > +    g_assert_true(s->shmem.test_enabled);
> > > > +
> > > > +    g_mutex_lock(&s->data_mutex);
> > > > +    s->shmem.nregions_sent =3D 0;
> > > > +    s->shmem.sizes_sent[0] =3D 0;
> > > > +    s->shmem.sizes_sent[1] =3D 0;
> > > > +    g_mutex_unlock(&s->data_mutex);
> > > > +
> > > > +    VhostUserMsg msg =3D {
> > > > +        .request =3D VHOST_USER_GET_SHMEM_CONFIG,
> > > > +        .flags =3D VHOST_USER_VERSION,
> > > > +        .size =3D 0,
> > > > +    };
> > > > +    chr_read(s, (uint8_t *) &msg, VHOST_USER_HDR_SIZE);
> > > > +
> > > > +    g_mutex_lock(&s->data_mutex);
> > > > +    g_assert_cmpint(s->shmem.nregions_sent, =3D=3D, 2);
> > > > +    g_assert_cmpint(s->shmem.sizes_sent[0], =3D=3D, 0x100000); /* =
1MB */
> > > > +    g_assert_cmpint(s->shmem.sizes_sent[1], =3D=3D, 0x200000); /* =
2MB */
> > > > +    g_mutex_unlock(&s->data_mutex);
> > > > +}
> > > > +
> > > >  static void register_vhost_user_test(void)
> > > >  {
> > > >      QOSGraphTestOptions opts =3D {
> > > > @@ -1136,6 +1221,12 @@ static void register_vhost_user_test(void)
> > > >      qos_add_test("vhost-user/multiqueue",
> > > >                   "virtio-net",
> > > >                   test_multiqueue, &opts);
> > > > +
> > > > +    opts.before =3D vhost_user_test_setup_shmem_config;
> > > > +    opts.edge.extra_device_opts =3D "";
> > > > +    qos_add_test("vhost-user/shmem-config",
> > > > +                 "virtio-net",
> > > > +                 test_shmem_config, &opts);
> > > >  }
> > > >  libqos_init(register_vhost_user_test);
> > > >
> > > > --
> > > > 2.49.0
> > > >
> >


