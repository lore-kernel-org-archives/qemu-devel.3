Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A76C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk91t-0003Yt-Bv; Tue, 12 Mar 2024 16:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk91p-0003Xh-0L
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:47:17 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk91m-0007qf-5M
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:47:16 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33e99915809so2079591f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 13:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710276432; x=1710881232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKwglOPA8y/N3N22trNzrx+u0Pm0uAQ4EAVcT8Q9wmg=;
 b=momV1PP+MELrvPossUawzMtj7Bp3Cb6uVbK6lIvTFBPNRAK8sgoPnX5ydZk9b/CtYb
 eEQnryd6i8EpH6gHYFQ/7axpQxpcepcA8LXMgOp4c3j1+u/A+11uguZisvM8GNfC6MPU
 h+9Fdjv+X/q0oUdHmxyl1hBKyFNEtQ8Y3S4lAu2XhbqS2JtP3uODnTBCOfJEIq3Vpyxa
 Nrxj85Ch91WwoB376ZR+otcZQ+5QzjM9qpIP+5Idp4cdnTWQIYz4IQOeyGgLX8aZnPh2
 ZrhOps6+5/QJ3ECI4+xzVSKUzrObA10z9E/k43iMvQmf7dN7eSiJAHOBIlC+fg+cGSZU
 mg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710276432; x=1710881232;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FKwglOPA8y/N3N22trNzrx+u0Pm0uAQ4EAVcT8Q9wmg=;
 b=vX04sRFkRx40WpI3sTPM23NpWydJGYnteRmOtF15/3X0o1CAZAzCDkiEOChuPz/y8l
 QZP9ulk4EAU5+PG6/G3MiINcKXbeoAoZyhz7yPjCGJ5erkESv7GzsvEeaFPDcePwzBZm
 /ht52pSCaoGjkDDvIcNBRXT5KaHrKVG8AngyZkJBpFU2HMSk2xSHuaPnNlBff7hrUayu
 OIEktOKpnus8cM8pObs9oc8dV9Ky8h1MYBendbLjNe+IPE9i8DkeuWPfYfAb4Pz1vdZf
 kUEVlqINedWuxX78QIMhiu8TEwKmI2JGVyYSzYakGIIQa4E7dmJkUjdsQBxNd5VRpCII
 rQ6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTgd1ZDzJmHUIkH/FbUB+gr4s9VFTKp1Bmp0JO4gLZzxmQDQ4vlfpJkGUhe8YszHu7wTCYFlc2IE/Q79ESw8LMfJFsuik=
X-Gm-Message-State: AOJu0Yz1azBZ7nNOe6PO9EbFWvSYL0931Zy+jnueXexxgvHf9IKl2KOm
 FcGI/Lr53Rabf6TBe24IFZ+UurL/Pkl6bm4BbKTxuL4IejjGn8xQKAhuKai4CPk=
X-Google-Smtp-Source: AGHT+IGJ3nCJt3dQMh0eM2UBWDmtPgLuTwcTw76CIZfc5p00JD6bk0HqMF7ZBFzfCX3GPUQ1l1hNMA==
X-Received: by 2002:adf:cd11:0:b0:33d:73de:cd95 with SMTP id
 w17-20020adfcd11000000b0033d73decd95mr443947wrm.17.1710276432036; 
 Tue, 12 Mar 2024 13:47:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w17-20020adfee51000000b0033e1be7f3d8sm9871810wro.70.2024.03.12.13.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 13:47:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 046225F888;
 Tue, 12 Mar 2024 20:47:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,
 stefanha@gmail.com,  philmd@linaro.org,  kraxel@redhat.com,
 marcandre.lureau@gmail.com
Subject: Re: [PATCH v4 3/5] hw/virtio: change dmabuf mutex to QemuMutex
In-Reply-To: <CADSE00Jb=CgFf9ex-fd8rxxPtGS0bs1=RQsHP3q3E=3C+Cy6-Q@mail.gmail.com>
 (Albert Esteve's message of "Mon, 11 Mar 2024 14:31:56 +0100")
References: <20240219143423.272012-1-aesteve@redhat.com>
 <20240219143423.272012-4-aesteve@redhat.com>
 <95hkw.qzghj1yo7yd4@linaro.org>
 <CADSE00Jb=CgFf9ex-fd8rxxPtGS0bs1=RQsHP3q3E=3C+Cy6-Q@mail.gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Tue, 12 Mar 2024 20:47:10 +0000
Message-ID: <87le6nmb3l.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Albert Esteve <aesteve@redhat.com> writes:

> On Tue, Feb 20, 2024 at 11:39=E2=80=AFAM Manos Pitsidianakis <manos.pitsi=
dianakis@linaro.org> wrote:
>
>  Hello Albert,
>
>  This is a point of confusion for me; Volker recently pointed out in a=20
>  patch for virtio-snd that all its code runs under the BQL.=20
>
> Hello Manos,
>
> I updated it to QemuMutex after a suggestion from Alex Benee, but I was n=
ot
> really aware it existed before his comment. So for your question I had to=
 check what
> exactly BQL stands for in this context (big QEMU lock). Therefore, as you=
 can see,
> I am probably not the right person to answer it.=20
>=20=20
>  Is this code
>  ever called without BQL, for example do the backend read/write functions=
=20
>  from vhost-user.c run without the BQL?
>
> To my understanding, they should as every access to the shared table may =
incur
> in a race. But I'd need to read the code better to verify if that is
> indeed the case.

The BQL will be held for any MMIO access but that is not all the
accesses that happen with VirtIO. Access to the shared buffers is
controlled by protocol and certain accesses need to be atomic.

The question is are all these functions triggered by MMIO operations or
by other events?

>
> The only thing I can say is that, if this change is confusing or may lead=
 to issues
> related to the scope of the lock, it may be better to dismiss the change =
and
> split it to its own specific patch, so I have the chance to verify the ch=
ance in
> a better way without delaying the other commits here.
>=20=20
>=20=20
>  On Mon, 19 Feb 2024 16:34, Albert Esteve <aesteve@redhat.com> wrote:
>  >Change GMutex by QemuMutex to be able to use
>  >lock contexts with `WITH_QEMU_LOCK_GUARD`.
>  >
>  >As the lock needs to be initialised and there
>  >is no central point for initialisation, add
>  >an init public function and call it from
>  >virtio.c, each time a new backend structure
>  >is initialised.
>  >
>  >Signed-off-by: Albert Esteve <aesteve@redhat.com>
>  >---
>  > hw/display/virtio-dmabuf.c        | 55 +++++++++++++++++--------------
>  > hw/virtio/virtio.c                |  3 ++
>  > include/hw/virtio/virtio-dmabuf.h |  5 +++
>  > tests/unit/test-virtio-dmabuf.c   |  5 +++
>  > 4 files changed, 43 insertions(+), 25 deletions(-)
>  >
>  >diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
>  >index 497cb6fa7c..961094a561 100644
>  >--- a/hw/display/virtio-dmabuf.c
>  >+++ b/hw/display/virtio-dmabuf.c
>  >@@ -11,11 +11,12 @@
>  >  */
>  >=20
>  > #include "qemu/osdep.h"
>  >+#include "include/qemu/lockable.h"
>  >=20
>  > #include "hw/virtio/virtio-dmabuf.h"
>  >=20
>  >=20
>  >-static GMutex lock;
>  >+static QemuMutex lock;
>  > static GHashTable *resource_uuids;
>  >=20
>  > /*
>  >@@ -27,23 +28,27 @@ static int uuid_equal_func(const void *lhv, const v=
oid *rhv)
>  >     return qemu_uuid_is_equal(lhv, rhv);
>  > }
>  >=20
>  >+void virtio_dmabuf_init(void) {
>  >+    qemu_mutex_init(&lock);
>  >+}
>  >+
>  > static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *va=
lue)
>  > {
>  >     bool result =3D true;
>  >=20
>  >-    g_mutex_lock(&lock);
>  >-    if (resource_uuids =3D=3D NULL) {
>  >-        resource_uuids =3D g_hash_table_new_full(qemu_uuid_hash,
>  >-                                               uuid_equal_func,
>  >-                                               NULL,
>  >-                                               g_free);
>  >-    }
>  >-    if (g_hash_table_lookup(resource_uuids, uuid) =3D=3D NULL) {
>  >-        g_hash_table_insert(resource_uuids, uuid, value);
>  >-    } else {
>  >-        result =3D false;
>  >+    WITH_QEMU_LOCK_GUARD(&lock) {
>  >+        if (resource_uuids =3D=3D NULL) {
>  >+            resource_uuids =3D g_hash_table_new_full(qemu_uuid_hash,
>  >+                                                uuid_equal_func,
>  >+                                                NULL,
>  >+                                                g_free);
>  >+        }
>  >+        if (g_hash_table_lookup(resource_uuids, uuid) =3D=3D NULL) {
>  >+            g_hash_table_insert(resource_uuids, uuid, value);
>  >+        } else {
>  >+            result =3D false;
>  >+        }
>  >     }
>  >-    g_mutex_unlock(&lock);
>  >=20
>  >     return result;
>  > }
>  >@@ -87,9 +92,9 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct v=
host_dev *dev)
>  > bool virtio_remove_resource(const QemuUUID *uuid)
>  > {
>  >     bool result;
>  >-    g_mutex_lock(&lock);
>  >-    result =3D g_hash_table_remove(resource_uuids, uuid);
>  >-    g_mutex_unlock(&lock);
>  >+    WITH_QEMU_LOCK_GUARD(&lock) {
>  >+        result =3D g_hash_table_remove(resource_uuids, uuid);
>  >+    }
>  >=20
>  >     return result;
>  > }
>  >@@ -98,11 +103,11 @@ static VirtioSharedObject *get_shared_object(const=
 QemuUUID *uuid)
>  > {
>  >     gpointer lookup_res =3D NULL;
>  >=20
>  >-    g_mutex_lock(&lock);
>  >-    if (resource_uuids !=3D NULL) {
>  >-        lookup_res =3D g_hash_table_lookup(resource_uuids, uuid);
>  >+    WITH_QEMU_LOCK_GUARD(&lock) {
>  >+        if (resource_uuids !=3D NULL) {
>  >+            lookup_res =3D g_hash_table_lookup(resource_uuids, uuid);
>  >+        }
>  >     }
>  >-    g_mutex_unlock(&lock);
>  >=20
>  >     return (VirtioSharedObject *) lookup_res;
>  > }
>  >@@ -138,9 +143,9 @@ SharedObjectType virtio_object_type(const QemuUUID =
*uuid)
>  >=20
>  > void virtio_free_resources(void)
>  > {
>  >-    g_mutex_lock(&lock);
>  >-    g_hash_table_destroy(resource_uuids);
>  >-    /* Reference count shall be 0 after the implicit unref on destroy =
*/
>  >-    resource_uuids =3D NULL;
>  >-    g_mutex_unlock(&lock);
>  >+    WITH_QEMU_LOCK_GUARD(&lock) {
>  >+        g_hash_table_destroy(resource_uuids);
>  >+        /* Reference count shall be 0 after the implicit unref on dest=
roy */
>  >+        resource_uuids =3D NULL;
>  >+    }
>  > }
>  >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>  >index d229755eae..88189e7178 100644
>  >--- a/hw/virtio/virtio.c
>  >+++ b/hw/virtio/virtio.c
>  >@@ -29,6 +29,7 @@
>  > #include "hw/virtio/virtio-bus.h"
>  > #include "hw/qdev-properties.h"
>  > #include "hw/virtio/virtio-access.h"
>  >+#include "hw/virtio/virtio-dmabuf.h"
>  > #include "sysemu/dma.h"
>  > #include "sysemu/runstate.h"
>  > #include "virtio-qmp.h"
>  >@@ -3221,6 +3222,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t dev=
ice_id, size_t config_size)
>  >     int i;
>  >     int nvectors =3D k->query_nvectors ? k->query_nvectors(qbus->paren=
t) : 0;
>  >=20
>  >+    // Ensure virtio dmabuf table is initialised.
>  >+    virtio_dmabuf_init();
>  >     if (nvectors) {
>  >         vdev->vector_queues =3D
>  >             g_malloc0(sizeof(*vdev->vector_queues) * nvectors);
>  >diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virt=
io-dmabuf.h
>  >index 891a43162d..627d84dce9 100644
>  >--- a/include/hw/virtio/virtio-dmabuf.h
>  >+++ b/include/hw/virtio/virtio-dmabuf.h
>  >@@ -50,6 +50,11 @@ typedef struct VirtioSharedObject {
>  >     } value;
>  > } VirtioSharedObject;
>  >=20
>  >+/**
>  >+ * virtio_dmabuf_init() - Initialise virtio dmabuf internal structures.
>  >+ */
>  >+void virtio_dmabuf_init(void);
>  >+
>  > /**
>  >  * virtio_add_dmabuf() - Add a new dma-buf resource to the lookup table
>  >  * @uuid: new resource's UUID
>  >diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-d=
mabuf.c
>  >index a45ec52f42..20213455ee 100644
>  >--- a/tests/unit/test-virtio-dmabuf.c
>  >+++ b/tests/unit/test-virtio-dmabuf.c
>  >@@ -27,6 +27,7 @@ static void test_add_remove_resources(void)
>  >     QemuUUID uuid;
>  >     int i, dmabuf_fd;
>  >=20
>  >+    virtio_dmabuf_init();
>  >     for (i =3D 0; i < 100; ++i) {
>  >         qemu_uuid_generate(&uuid);
>  >         dmabuf_fd =3D g_random_int_range(3, 500);
>  >@@ -46,6 +47,7 @@ static void test_add_remove_dev(void)
>  >     struct vhost_dev *dev =3D g_new0(struct vhost_dev, 1);
>  >     int i;
>  >=20
>  >+    virtio_dmabuf_init();
>  >     for (i =3D 0; i < 100; ++i) {
>  >         qemu_uuid_generate(&uuid);
>  >         virtio_add_vhost_device(&uuid, dev);
>  >@@ -64,6 +66,7 @@ static void test_remove_invalid_resource(void)
>  >     QemuUUID uuid;
>  >     int i;
>  >=20
>  >+    virtio_dmabuf_init();
>  >     for (i =3D 0; i < 20; ++i) {
>  >         qemu_uuid_generate(&uuid);
>  >         g_assert_cmpint(virtio_lookup_dmabuf(&uuid), =3D=3D, -1);
>  >@@ -78,6 +81,7 @@ static void test_add_invalid_resource(void)
>  >     struct vhost_dev *dev =3D NULL;
>  >     int i, dmabuf_fd =3D -2, alt_dmabuf =3D 2;
>  >=20
>  >+    virtio_dmabuf_init();
>  >     for (i =3D 0; i < 20; ++i) {
>  >         qemu_uuid_generate(&uuid);
>  >         /* Add a new resource with invalid (negative) resource fd */
>  >@@ -108,6 +112,7 @@ static void test_free_resources(void)
>  >     QemuUUID uuids[20];
>  >     int i, dmabuf_fd;
>  >=20
>  >+    virtio_dmabuf_init();
>  >     for (i =3D 0; i < ARRAY_SIZE(uuids); ++i) {
>  >         qemu_uuid_generate(&uuids[i]);
>  >         dmabuf_fd =3D g_random_int_range(3, 500);
>  >--=20
>  >2.43.1
>  >
>  >

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

