Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1EAC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 13:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjflI-0007Mk-Tw; Mon, 11 Mar 2024 09:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rjflG-0007MS-UR
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rjflE-0006cC-9E
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710163930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Di+Q64hXZfCGLArLB3biI6wyzdMeduZRRZCrGACPXjM=;
 b=e4KpwpV/km/JtGjoMnyPyNTVo2Y8t4Kn6OWkE7lSqn4EGGqL71YRopWu4j6HK1SghxneMR
 o0yb5fQiOD7LpnicpY+0vFd9gcbwnVlUu1xRx1rIljI8G97LF8y5V9dOpWzm/cUQsR2hna
 mo5SM7uegvnoT5AO1g4tr7QyIiAC1q4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-fi80a4qgPkeulFcz4mAmFQ-1; Mon, 11 Mar 2024 09:32:09 -0400
X-MC-Unique: fi80a4qgPkeulFcz4mAmFQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29bf071cc04so983641a91.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 06:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710163928; x=1710768728;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Di+Q64hXZfCGLArLB3biI6wyzdMeduZRRZCrGACPXjM=;
 b=QVonPy25aS1kUJENMmnha63efjoJ1sr1tSmMYBErLpg8uxeGXm9pATQqguGREzEm0Y
 OEMz5vIoRMjXFK6BMas2PP6qEOviQVdhdZa2EoU+8GNqVyQpjXvWcdBXgCtqcVkn4k1R
 oJGy6UIJFf6VRCyJX8ZOSSko0y3aTYE1eFhBw9rWstMRn85p6qz4Tb1KpukdHhqEyPbn
 vZLDc/ymhXZoZAPH1QPgrW5gd7jJz8B4VOdl1axXXSNwysgWZcC/Y84npOnNkyTHo+n4
 gclq8cXsFnhEU8IJS+nPPRmS/6dNPy5J5bGecEQkQv3b+iYF9xDvhFO9eIb+azoUnq3P
 O+UQ==
X-Gm-Message-State: AOJu0YxtKrh0X3FShrrn5xLGT96kYPPUHHN7dZnnjp6EZVfHf3aBunBq
 KQzbLOAMyFFZy6n8SseYkaJl/mCmR4+2swrUIsAamjqcwbLZsod2ojNjs+IDVJDX2ZlaaoL3sDM
 AeeHfCJRnFYhQKfE079P7O4/BpKq1s2syCbkjn0vQBWptCt4uSyWQCATHhLc4WqOMIXTGqILB7w
 eZ0mV4bwkfOL1SKi8/BoieZ1A36uk=
X-Received: by 2002:a17:90a:eb16:b0:29b:fa9f:af9f with SMTP id
 j22-20020a17090aeb1600b0029bfa9faf9fmr2801694pjz.18.1710163927915; 
 Mon, 11 Mar 2024 06:32:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpoM0vjk2+YivBr1E0DU+/VmInz0KZkR4CnSZP44IvtKkm34A6FmQwTyBoTGhPhlNCJuTK453IiUTXwvJV+H8=
X-Received: by 2002:a17:90a:eb16:b0:29b:fa9f:af9f with SMTP id
 j22-20020a17090aeb1600b0029bfa9faf9fmr2801667pjz.18.1710163927638; Mon, 11
 Mar 2024 06:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240219143423.272012-1-aesteve@redhat.com>
 <20240219143423.272012-4-aesteve@redhat.com>
 <95hkw.qzghj1yo7yd4@linaro.org>
In-Reply-To: <95hkw.qzghj1yo7yd4@linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 11 Mar 2024 14:31:56 +0100
Message-ID: <CADSE00Jb=CgFf9ex-fd8rxxPtGS0bs1=RQsHP3q3E=3C+Cy6-Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] hw/virtio: change dmabuf mutex to QemuMutex
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 stefanha@gmail.com, 
 alex.bennee@linaro.org, philmd@linaro.org, kraxel@redhat.com, 
 marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="0000000000006a48a20613629172"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000006a48a20613629172
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 11:39=E2=80=AFAM Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> wrote:

> Hello Albert,
>
> This is a point of confusion for me; Volker recently pointed out in a
> patch for virtio-snd that all its code runs under the BQL.


Hello Manos,

I updated it to QemuMutex after a suggestion from Alex Benee, but I was not
really aware it existed before his comment. So for your question I had to
check what
exactly BQL stands for in this context (big QEMU lock). Therefore, as you
can see,
I am probably not the right person to answer it.


> Is this code
> ever called without BQL, for example do the backend read/write functions
> from vhost-user.c run without the BQL?
>

To my understanding, they should as every access to the shared table may
incur
in a race. But I'd need to read the code better to verify if that is
indeed the case.

The only thing I can say is that, if this change is confusing or may lead
to issues
related to the scope of the lock, it may be better to dismiss the change an=
d
split it to its own specific patch, so I have the chance to verify the
chance in
a better way without delaying the other commits here.


>
> On Mon, 19 Feb 2024 16:34, Albert Esteve <aesteve@redhat.com> wrote:
> >Change GMutex by QemuMutex to be able to use
> >lock contexts with `WITH_QEMU_LOCK_GUARD`.
> >
> >As the lock needs to be initialised and there
> >is no central point for initialisation, add
> >an init public function and call it from
> >virtio.c, each time a new backend structure
> >is initialised.
> >
> >Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >---
> > hw/display/virtio-dmabuf.c        | 55 +++++++++++++++++--------------
> > hw/virtio/virtio.c                |  3 ++
> > include/hw/virtio/virtio-dmabuf.h |  5 +++
> > tests/unit/test-virtio-dmabuf.c   |  5 +++
> > 4 files changed, 43 insertions(+), 25 deletions(-)
> >
> >diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> >index 497cb6fa7c..961094a561 100644
> >--- a/hw/display/virtio-dmabuf.c
> >+++ b/hw/display/virtio-dmabuf.c
> >@@ -11,11 +11,12 @@
> >  */
> >
> > #include "qemu/osdep.h"
> >+#include "include/qemu/lockable.h"
> >
> > #include "hw/virtio/virtio-dmabuf.h"
> >
> >
> >-static GMutex lock;
> >+static QemuMutex lock;
> > static GHashTable *resource_uuids;
> >
> > /*
> >@@ -27,23 +28,27 @@ static int uuid_equal_func(const void *lhv, const
> void *rhv)
> >     return qemu_uuid_is_equal(lhv, rhv);
> > }
> >
> >+void virtio_dmabuf_init(void) {
> >+    qemu_mutex_init(&lock);
> >+}
> >+
> > static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject
> *value)
> > {
> >     bool result =3D true;
> >
> >-    g_mutex_lock(&lock);
> >-    if (resource_uuids =3D=3D NULL) {
> >-        resource_uuids =3D g_hash_table_new_full(qemu_uuid_hash,
> >-                                               uuid_equal_func,
> >-                                               NULL,
> >-                                               g_free);
> >-    }
> >-    if (g_hash_table_lookup(resource_uuids, uuid) =3D=3D NULL) {
> >-        g_hash_table_insert(resource_uuids, uuid, value);
> >-    } else {
> >-        result =3D false;
> >+    WITH_QEMU_LOCK_GUARD(&lock) {
> >+        if (resource_uuids =3D=3D NULL) {
> >+            resource_uuids =3D g_hash_table_new_full(qemu_uuid_hash,
> >+                                                uuid_equal_func,
> >+                                                NULL,
> >+                                                g_free);
> >+        }
> >+        if (g_hash_table_lookup(resource_uuids, uuid) =3D=3D NULL) {
> >+            g_hash_table_insert(resource_uuids, uuid, value);
> >+        } else {
> >+            result =3D false;
> >+        }
> >     }
> >-    g_mutex_unlock(&lock);
> >
> >     return result;
> > }
> >@@ -87,9 +92,9 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct
> vhost_dev *dev)
> > bool virtio_remove_resource(const QemuUUID *uuid)
> > {
> >     bool result;
> >-    g_mutex_lock(&lock);
> >-    result =3D g_hash_table_remove(resource_uuids, uuid);
> >-    g_mutex_unlock(&lock);
> >+    WITH_QEMU_LOCK_GUARD(&lock) {
> >+        result =3D g_hash_table_remove(resource_uuids, uuid);
> >+    }
> >
> >     return result;
> > }
> >@@ -98,11 +103,11 @@ static VirtioSharedObject *get_shared_object(const
> QemuUUID *uuid)
> > {
> >     gpointer lookup_res =3D NULL;
> >
> >-    g_mutex_lock(&lock);
> >-    if (resource_uuids !=3D NULL) {
> >-        lookup_res =3D g_hash_table_lookup(resource_uuids, uuid);
> >+    WITH_QEMU_LOCK_GUARD(&lock) {
> >+        if (resource_uuids !=3D NULL) {
> >+            lookup_res =3D g_hash_table_lookup(resource_uuids, uuid);
> >+        }
> >     }
> >-    g_mutex_unlock(&lock);
> >
> >     return (VirtioSharedObject *) lookup_res;
> > }
> >@@ -138,9 +143,9 @@ SharedObjectType virtio_object_type(const QemuUUID
> *uuid)
> >
> > void virtio_free_resources(void)
> > {
> >-    g_mutex_lock(&lock);
> >-    g_hash_table_destroy(resource_uuids);
> >-    /* Reference count shall be 0 after the implicit unref on destroy *=
/
> >-    resource_uuids =3D NULL;
> >-    g_mutex_unlock(&lock);
> >+    WITH_QEMU_LOCK_GUARD(&lock) {
> >+        g_hash_table_destroy(resource_uuids);
> >+        /* Reference count shall be 0 after the implicit unref on
> destroy */
> >+        resource_uuids =3D NULL;
> >+    }
> > }
> >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >index d229755eae..88189e7178 100644
> >--- a/hw/virtio/virtio.c
> >+++ b/hw/virtio/virtio.c
> >@@ -29,6 +29,7 @@
> > #include "hw/virtio/virtio-bus.h"
> > #include "hw/qdev-properties.h"
> > #include "hw/virtio/virtio-access.h"
> >+#include "hw/virtio/virtio-dmabuf.h"
> > #include "sysemu/dma.h"
> > #include "sysemu/runstate.h"
> > #include "virtio-qmp.h"
> >@@ -3221,6 +3222,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t
> device_id, size_t config_size)
> >     int i;
> >     int nvectors =3D k->query_nvectors ? k->query_nvectors(qbus->parent=
) :
> 0;
> >
> >+    // Ensure virtio dmabuf table is initialised.
> >+    virtio_dmabuf_init();
> >     if (nvectors) {
> >         vdev->vector_queues =3D
> >             g_malloc0(sizeof(*vdev->vector_queues) * nvectors);
> >diff --git a/include/hw/virtio/virtio-dmabuf.h
> b/include/hw/virtio/virtio-dmabuf.h
> >index 891a43162d..627d84dce9 100644
> >--- a/include/hw/virtio/virtio-dmabuf.h
> >+++ b/include/hw/virtio/virtio-dmabuf.h
> >@@ -50,6 +50,11 @@ typedef struct VirtioSharedObject {
> >     } value;
> > } VirtioSharedObject;
> >
> >+/**
> >+ * virtio_dmabuf_init() - Initialise virtio dmabuf internal structures.
> >+ */
> >+void virtio_dmabuf_init(void);
> >+
> > /**
> >  * virtio_add_dmabuf() - Add a new dma-buf resource to the lookup table
> >  * @uuid: new resource's UUID
> >diff --git a/tests/unit/test-virtio-dmabuf.c
> b/tests/unit/test-virtio-dmabuf.c
> >index a45ec52f42..20213455ee 100644
> >--- a/tests/unit/test-virtio-dmabuf.c
> >+++ b/tests/unit/test-virtio-dmabuf.c
> >@@ -27,6 +27,7 @@ static void test_add_remove_resources(void)
> >     QemuUUID uuid;
> >     int i, dmabuf_fd;
> >
> >+    virtio_dmabuf_init();
> >     for (i =3D 0; i < 100; ++i) {
> >         qemu_uuid_generate(&uuid);
> >         dmabuf_fd =3D g_random_int_range(3, 500);
> >@@ -46,6 +47,7 @@ static void test_add_remove_dev(void)
> >     struct vhost_dev *dev =3D g_new0(struct vhost_dev, 1);
> >     int i;
> >
> >+    virtio_dmabuf_init();
> >     for (i =3D 0; i < 100; ++i) {
> >         qemu_uuid_generate(&uuid);
> >         virtio_add_vhost_device(&uuid, dev);
> >@@ -64,6 +66,7 @@ static void test_remove_invalid_resource(void)
> >     QemuUUID uuid;
> >     int i;
> >
> >+    virtio_dmabuf_init();
> >     for (i =3D 0; i < 20; ++i) {
> >         qemu_uuid_generate(&uuid);
> >         g_assert_cmpint(virtio_lookup_dmabuf(&uuid), =3D=3D, -1);
> >@@ -78,6 +81,7 @@ static void test_add_invalid_resource(void)
> >     struct vhost_dev *dev =3D NULL;
> >     int i, dmabuf_fd =3D -2, alt_dmabuf =3D 2;
> >
> >+    virtio_dmabuf_init();
> >     for (i =3D 0; i < 20; ++i) {
> >         qemu_uuid_generate(&uuid);
> >         /* Add a new resource with invalid (negative) resource fd */
> >@@ -108,6 +112,7 @@ static void test_free_resources(void)
> >     QemuUUID uuids[20];
> >     int i, dmabuf_fd;
> >
> >+    virtio_dmabuf_init();
> >     for (i =3D 0; i < ARRAY_SIZE(uuids); ++i) {
> >         qemu_uuid_generate(&uuids[i]);
> >         dmabuf_fd =3D g_random_int_range(3, 500);
> >--
> >2.43.1
> >
> >
>
>

--0000000000006a48a20613629172
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 20, 2024 at 11:39=
=E2=80=AFAM Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@l=
inaro.org">manos.pitsidianakis@linaro.org</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Hello Albert,<br>
<br>
This is a point of confusion for me; Volker recently pointed out in a <br>
patch for virtio-snd that all its code runs under the BQL. </blockquote><di=
v><br></div><div><div>Hello Manos,</div><div><br></div><div>I updated it to=
 QemuMutex after a suggestion from Alex Benee, but I was not</div><div>real=
ly aware it existed before his comment. So for your question I had to check=
 what</div><div>exactly BQL stands for in this context (big QEMU lock). The=
refore, as you can see,</div><div>I am probably not the right person to ans=
wer it.=C2=A0</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Is this code<br>
ever called without BQL, for example do the backend read/write functions <b=
r>
from vhost-user.c run without the BQL?<br></blockquote><div><br></div><div>=
To my understanding, they should as every access to the shared table may in=
cur</div><div>in a race. But I&#39;d need to read the code better to verify=
=C2=A0if that is indeed=C2=A0the case.</div><div><br></div><div>The only th=
ing I can say is that, if this change is confusing or may lead to issues</d=
iv><div>related to the scope of the lock, it may be better to dismiss the c=
hange and</div><div>split it to its own specific patch, so I have the chanc=
e to verify the chance in</div><div>a better way without delaying the other=
 commits here.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
On Mon, 19 Feb 2024 16:34, Albert Esteve &lt;<a href=3D"mailto:aesteve@redh=
at.com" target=3D"_blank">aesteve@redhat.com</a>&gt; wrote:<br>
&gt;Change GMutex by QemuMutex to be able to use<br>
&gt;lock contexts with `WITH_QEMU_LOCK_GUARD`.<br>
&gt;<br>
&gt;As the lock needs to be initialised and there<br>
&gt;is no central point for initialisation, add<br>
&gt;an init public function and call it from<br>
&gt;virtio.c, each time a new backend structure<br>
&gt;is initialised.<br>
&gt;<br>
&gt;Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" =
target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt;---<br>
&gt; hw/display/virtio-dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 55 +++++++++++=
++++++--------------<br>
&gt; hw/virtio/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 3 ++<br>
&gt; include/hw/virtio/virtio-dmabuf.h |=C2=A0 5 +++<br>
&gt; tests/unit/test-virtio-dmabuf.c=C2=A0 =C2=A0|=C2=A0 5 +++<br>
&gt; 4 files changed, 43 insertions(+), 25 deletions(-)<br>
&gt;<br>
&gt;diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c<br=
>
&gt;index 497cb6fa7c..961094a561 100644<br>
&gt;--- a/hw/display/virtio-dmabuf.c<br>
&gt;+++ b/hw/display/virtio-dmabuf.c<br>
&gt;@@ -11,11 +11,12 @@<br>
&gt;=C2=A0 */<br>
&gt; <br>
&gt; #include &quot;qemu/osdep.h&quot;<br>
&gt;+#include &quot;include/qemu/lockable.h&quot;<br>
&gt; <br>
&gt; #include &quot;hw/virtio/virtio-dmabuf.h&quot;<br>
&gt; <br>
&gt; <br>
&gt;-static GMutex lock;<br>
&gt;+static QemuMutex lock;<br>
&gt; static GHashTable *resource_uuids;<br>
&gt; <br>
&gt; /*<br>
&gt;@@ -27,23 +28,27 @@ static int uuid_equal_func(const void *lhv, const v=
oid *rhv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0return qemu_uuid_is_equal(lhv, rhv);<br>
&gt; }<br>
&gt; <br>
&gt;+void virtio_dmabuf_init(void) {<br>
&gt;+=C2=A0 =C2=A0 qemu_mutex_init(&amp;lock);<br>
&gt;+}<br>
&gt;+<br>
&gt; static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *va=
lue)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool result =3D true;<br>
&gt; <br>
&gt;-=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
&gt;-=C2=A0 =C2=A0 if (resource_uuids =3D=3D NULL) {<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_uuids =3D g_hash_table_new_full(q=
emu_uuid_hash,<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uuid_equal_func,<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL,<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0g_free);<br>
&gt;-=C2=A0 =C2=A0 }<br>
&gt;-=C2=A0 =C2=A0 if (g_hash_table_lookup(resource_uuids, uuid) =3D=3D NUL=
L) {<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_hash_table_insert(resource_uuids, uuid, =
value);<br>
&gt;-=C2=A0 =C2=A0 } else {<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D false;<br>
&gt;+=C2=A0 =C2=A0 WITH_QEMU_LOCK_GUARD(&amp;lock) {<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (resource_uuids =3D=3D NULL) {<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_uuids =3D g_hash_ta=
ble_new_full(qemu_uuid_hash,<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uuid_equal_func,<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 NULL,<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 g_free);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_hash_table_lookup(resource_uuids, uu=
id) =3D=3D NULL) {<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_hash_table_insert(resource=
_uuids, uuid, value);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D false;<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;-=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0return result;<br>
&gt; }<br>
&gt;@@ -87,9 +92,9 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct v=
host_dev *dev)<br>
&gt; bool virtio_remove_resource(const QemuUUID *uuid)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool result;<br>
&gt;-=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
&gt;-=C2=A0 =C2=A0 result =3D g_hash_table_remove(resource_uuids, uuid);<br=
>
&gt;-=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
&gt;+=C2=A0 =C2=A0 WITH_QEMU_LOCK_GUARD(&amp;lock) {<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_hash_table_remove(resource_uu=
ids, uuid);<br>
&gt;+=C2=A0 =C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0return result;<br>
&gt; }<br>
&gt;@@ -98,11 +103,11 @@ static VirtioSharedObject *get_shared_object(const=
 QemuUUID *uuid)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0gpointer lookup_res =3D NULL;<br>
&gt; <br>
&gt;-=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
&gt;-=C2=A0 =C2=A0 if (resource_uuids !=3D NULL) {<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 lookup_res =3D g_hash_table_lookup(resourc=
e_uuids, uuid);<br>
&gt;+=C2=A0 =C2=A0 WITH_QEMU_LOCK_GUARD(&amp;lock) {<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (resource_uuids !=3D NULL) {<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lookup_res =3D g_hash_table_=
lookup(resource_uuids, uuid);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;-=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0return (VirtioSharedObject *) lookup_res;<br>
&gt; }<br>
&gt;@@ -138,9 +143,9 @@ SharedObjectType virtio_object_type(const QemuUUID =
*uuid)<br>
&gt; <br>
&gt; void virtio_free_resources(void)<br>
&gt; {<br>
&gt;-=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
&gt;-=C2=A0 =C2=A0 g_hash_table_destroy(resource_uuids);<br>
&gt;-=C2=A0 =C2=A0 /* Reference count shall be 0 after the implicit unref o=
n destroy */<br>
&gt;-=C2=A0 =C2=A0 resource_uuids =3D NULL;<br>
&gt;-=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
&gt;+=C2=A0 =C2=A0 WITH_QEMU_LOCK_GUARD(&amp;lock) {<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_hash_table_destroy(resource_uuids);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Reference count shall be 0 after the im=
plicit unref on destroy */<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_uuids =3D NULL;<br>
&gt;+=C2=A0 =C2=A0 }<br>
&gt; }<br>
&gt;diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>
&gt;index d229755eae..88189e7178 100644<br>
&gt;--- a/hw/virtio/virtio.c<br>
&gt;+++ b/hw/virtio/virtio.c<br>
&gt;@@ -29,6 +29,7 @@<br>
&gt; #include &quot;hw/virtio/virtio-bus.h&quot;<br>
&gt; #include &quot;hw/qdev-properties.h&quot;<br>
&gt; #include &quot;hw/virtio/virtio-access.h&quot;<br>
&gt;+#include &quot;hw/virtio/virtio-dmabuf.h&quot;<br>
&gt; #include &quot;sysemu/dma.h&quot;<br>
&gt; #include &quot;sysemu/runstate.h&quot;<br>
&gt; #include &quot;virtio-qmp.h&quot;<br>
&gt;@@ -3221,6 +3222,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t dev=
ice_id, size_t config_size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0int nvectors =3D k-&gt;query_nvectors ? k-&gt;query=
_nvectors(qbus-&gt;parent) : 0;<br>
&gt; <br>
&gt;+=C2=A0 =C2=A0 // Ensure virtio dmabuf table is initialised.<br>
&gt;+=C2=A0 =C2=A0 virtio_dmabuf_init();<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (nvectors) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev-&gt;vector_queues =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_malloc0(sizeof(*vdev-=
&gt;vector_queues) * nvectors);<br>
&gt;diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virt=
io-dmabuf.h<br>
&gt;index 891a43162d..627d84dce9 100644<br>
&gt;--- a/include/hw/virtio/virtio-dmabuf.h<br>
&gt;+++ b/include/hw/virtio/virtio-dmabuf.h<br>
&gt;@@ -50,6 +50,11 @@ typedef struct VirtioSharedObject {<br>
&gt;=C2=A0 =C2=A0 =C2=A0} value;<br>
&gt; } VirtioSharedObject;<br>
&gt; <br>
&gt;+/**<br>
&gt;+ * virtio_dmabuf_init() - Initialise virtio dmabuf internal structures=
.<br>
&gt;+ */<br>
&gt;+void virtio_dmabuf_init(void);<br>
&gt;+<br>
&gt; /**<br>
&gt;=C2=A0 * virtio_add_dmabuf() - Add a new dma-buf resource to the lookup=
 table<br>
&gt;=C2=A0 * @uuid: new resource&#39;s UUID<br>
&gt;diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-d=
mabuf.c<br>
&gt;index a45ec52f42..20213455ee 100644<br>
&gt;--- a/tests/unit/test-virtio-dmabuf.c<br>
&gt;+++ b/tests/unit/test-virtio-dmabuf.c<br>
&gt;@@ -27,6 +27,7 @@ static void test_add_remove_resources(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0QemuUUID uuid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0int i, dmabuf_fd;<br>
&gt; <br>
&gt;+=C2=A0 =C2=A0 virtio_dmabuf_init();<br>
&gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 100; ++i) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_uuid_generate(&amp;uuid);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf_fd =3D g_random_int_range(3, 5=
00);<br>
&gt;@@ -46,6 +47,7 @@ static void test_add_remove_dev(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct vhost_dev *dev =3D g_new0(struct vhost_dev, =
1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; <br>
&gt;+=C2=A0 =C2=A0 virtio_dmabuf_init();<br>
&gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 100; ++i) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_uuid_generate(&amp;uuid);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_add_vhost_device(&amp;uuid, de=
v);<br>
&gt;@@ -64,6 +66,7 @@ static void test_remove_invalid_resource(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0QemuUUID uuid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; <br>
&gt;+=C2=A0 =C2=A0 virtio_dmabuf_init();<br>
&gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 20; ++i) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_uuid_generate(&amp;uuid);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_cmpint(virtio_lookup_dmabuf(=
&amp;uuid), =3D=3D, -1);<br>
&gt;@@ -78,6 +81,7 @@ static void test_add_invalid_resource(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct vhost_dev *dev =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0int i, dmabuf_fd =3D -2, alt_dmabuf =3D 2;<br>
&gt; <br>
&gt;+=C2=A0 =C2=A0 virtio_dmabuf_init();<br>
&gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 20; ++i) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_uuid_generate(&amp;uuid);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Add a new resource with invalid (n=
egative) resource fd */<br>
&gt;@@ -108,6 +112,7 @@ static void test_free_resources(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0QemuUUID uuids[20];<br>
&gt;=C2=A0 =C2=A0 =C2=A0int i, dmabuf_fd;<br>
&gt; <br>
&gt;+=C2=A0 =C2=A0 virtio_dmabuf_init();<br>
&gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ARRAY_SIZE(uuids); ++i) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_uuid_generate(&amp;uuids[i]);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dmabuf_fd =3D g_random_int_range(3, 5=
00);<br>
&gt;-- <br>
&gt;2.43.1<br>
&gt;<br>
&gt;<br>
<br>
</blockquote></div></div>

--0000000000006a48a20613629172--


