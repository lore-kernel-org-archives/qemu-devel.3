Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7847C5472D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 06:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjCWX-0001bj-91; Wed, 28 Aug 2024 02:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1sjCWQ-0001b0-2E
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 02:51:14 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1sjCWM-0007bI-UM
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 02:51:13 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6c91f9fb0acso36197867b3.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 23:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724827869; x=1725432669; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sv0Sb1BXFSzV1MyMyHwWOIajrFbm5r3Q7PmnxKBSlhw=;
 b=FBe9kHwoSccrSgysVZUv1Co7aq0AWYfGmo9Ih0Dz3EkN8IdNTKekDclI4zxX+eUePY
 eDxZlOLg2uQtRNFhgk8/JEjYLcl3makhu9P4ZACilai0UUS701xllQiovuJYdBg1TL3t
 zREP0SCBEjOIc5VymxwqT9J/eCie52g4NtmT3qshxvprin3AF/kTjYkFmRPvkvXsGOqx
 r6dnOSe2/gsfGCeDMs2+Km+96rpw6WgVF1jKcaSIJiTdK5KmO3E4AVyz5WJ+82XzwkZD
 EttkjalNJkgmOmzLKaOJFL0ST86BctFIjZ1zxK5tFmxNWgCcc83xcx8B8+GhNCFP3yUS
 sz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724827869; x=1725432669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sv0Sb1BXFSzV1MyMyHwWOIajrFbm5r3Q7PmnxKBSlhw=;
 b=myMtEq0SkfBz8PbWmW5Qf6ir0UQzXByVrVNdhBzbxOzd2JYJgygPA56Ebu23WQbX0L
 Kq/3rLDUGIMqWpRB/Udb9fXWAMH6rNGjztdLB3EmisQGAKywmJtrejEPO6CWnueMnQws
 QhzNlM7yyj6OVqy5buk8E4zmrFtQbd7200F/YfaECqLIjjURRSnVgv8gADxyuV7qSRZJ
 IaxLU0zovJHmkvrdycHyt+1r0afn6HYAvaxzQN9xPqF4J+g+7oz0FAuh7I/PQSodyhm3
 enBafPX/vapLcWrzwVWRRVGFGtAxx7uQwb7qjtNH9s0P1qeWf1ZVZDP8FkEC+OFaFJ/w
 DD9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6J2LVDuGsqK/NV6RVe5L2jurGQeaAADp0hGS6w+U4s4y2ygIHJfR0AxZJZJ7iaia/8/OGf4RbiFxD@nongnu.org
X-Gm-Message-State: AOJu0YxMCl3HMt4MGoCtfbEcUlaSFe9hHG9xjwMZYG1opdFzN32EBL3z
 cS3jn/Q6WFJuvzvIE06RiIKGpiruh5iyuPUDzS1KalMHRZHlVya/ka05969Aq0N6UPlAhj4L2ZY
 OjNSQT/u1uOowy5sw8XK1qSQPz/U=
X-Google-Smtp-Source: AGHT+IEbhi5gmyNnDNQ1tpXr6G1iDnAbiL9QtJW+75xBztrJqBUZxGqciAyka1nsy9GTfOHyUOyI7wROKn/hjYy+Pk4=
X-Received: by 2002:a05:690c:450f:b0:6b2:6cd4:7f94 with SMTP id
 00721157ae682-6c629065707mr184585117b3.43.1724827868904; Tue, 27 Aug 2024
 23:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240807095508.54750-1-yaozhenguo@jd.com>
 <axcmkj7i723brvr4cfed6bcdu3epwk3lz5ikpmngz5nrginjx5@otbycci7thov>
In-Reply-To: <axcmkj7i723brvr4cfed6bcdu3epwk3lz5ikpmngz5nrginjx5@otbycci7thov>
From: Zhenguo Yao <yaozhenguo1@gmail.com>
Date: Wed, 28 Aug 2024 14:50:57 +0800
Message-ID: <CA+WzARk-_GWGsGqKT84irMn1mNtZ=rx5t7tcvTP6+0eV4GXWsA@mail.gmail.com>
Subject: Re: [PATCH] virtio/vhost-user: fix qemu crash when hotunplug
 vhost-user-net device
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: alex.bennee@linaro.org, mst@redhat.com, qemu-devel@nongnu.org, 
 yaozhenguo@jd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=yaozhenguo1@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

I am very sorry that my previous description was not accurate. Below I
will describe the steps to reproduce this problem and my analysis in
detail.The conditions for reproducing this problem are quite
demanding. First, let me introduce my environment. I use DPDK vdpa to
drive
DPU to implement a vhost-user type network card. DPDK vdpa software
communicates with QEMU through the vhost protocol. The steps to
reproduce are as follows:

1. Start a Windows virtual machine.
2. Use the vish command to hotplug and unplug a 32 queues
vhost-user-net network card.
3. After a while, QEMU will crash.

I added some logs to locate this problem. The following is how I
located the root cause of this problem based on logs and code
analysis. The steps to reproduce the problem involve hot plugging and
hot unplugging of network cards. Hot plugging of network cards
involves two processes. Process A is to insert the device into qemu,
and process B is the process of guest operating system initializing
the network card. When process A is completed, the virsh attach-device
command returns. At this time, you can call virsh detach-device to
perform hot unplug operations. Generally, this will not be a problem
because the network card initializes very quickly. However, since my
network card is a vhost-user type network card, and it is implemented
by DPDK vdpa, there is an asynchronous situation. When the Guest
operating system is initializing the network card, some messages from
vhost-user returned to QEMU may be delayed. The problem occurs here.

For example, the message VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG is
responsible for assigning the value of VhostUserHostNotifier->addr,
which is the hot plug process B. There are also two processes for hot
unplugging devices. libvirt will send two QMP commands to qemu: one is
device_del and the other is netdev_del. If this message arrives after
the first hot unplug command, there will be problems. The following is
a detailed analysis: The key function of the device_del command
execution: virtio_set_status->vhost_dev_stop. In the vhost_dev_stop
function, all queues will be traversed and
vhost_user_get_vring_base-->vhost_user_host_notifier_remove will be
called because VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG has not
arrived in some queues at this time, so VhostUserHostNotifier->addr
has no value at this time, so nothing will be done at this time. For
those with values, vhost_user_host_notifier_free will be submitted to
the rcu thread
and clear n->addr.

Next, libvirt will send the netdev_del QMP command.
netdev_del--> vhost_user_cleanup

Because some queues VhostUserHostNotifier->addr are not empty at this
time, there will be the following call path:

1. vhost_user_host_notifier_remove->call_rcu(n,
vhost_user_host_notifier_free, rcu);
2. g_free_rcu(n, rcu);

The same rcu was submitted twice. In call_rcu1, if two identical nodes
are added to the node list, only one will be successfully added, but
rcu_call_count will be added twice. When rcu processes rcu node, it
will check whether rcu_call_count is empty. If not, it will take the
node from node list. Because the actual node in node list is one less
than rcu_call_count, it will cause rcu_call_count to be not empty, but
there is no node in node list. In this way, rcu thread will abort, the
code is as follows:
if (head =3D=3D &dummy && qatomic_mb_read(&tail) =3D=3D &dummy.next) {
    abort();
}
This is the reason why QEMU crashed. Since the latest QEMU cannot run
in our environment due to incompatibility of vhost-user messages, and
this problem is difficult to reproduce, I was unable to reproduce the
problem on the latest qemu. However, from the upstream code, since
VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG is asynchronous, we cannot
assume that all VhostUserHostNotifier->addr in vhost_user_cleanup are
empty. If addr is not empty, there will be a problem. Otherwise,
vhost_user_host_notifier_remove is not necessary to call in
vhost_user_cleanup.

Therefore, the two tasks of vhost_user_host_notifier_free and free
VhostUserHostNotifier need to be placed in a rcu node, and use
n->need_free to determine whether it is free VhostUserHostNotifier.

Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=8827=
=E6=97=A5=E5=91=A8=E4=BA=8C 16:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Aug 07, 2024 at 05:55:08PM GMT, yaozhenguo wrote:
> >When hotplug and hotunplug vhost-user-net device quickly.
>
> I'd replace the . with ,
>
> >qemu will crash. BT is as below:
> >
> >0  __pthread_kill_implementation () at /usr/lib64/libc.so.6
> >1  raise () at /usr/lib64/libc.so.6
> >2  abort () at /usr/lib64/libc.so.6
> >3  try_dequeue () at ../util/rcu.c:235
> >4  call_rcu_thread (opaque=3Dopaque@entry=3D0x0) at ../util/rcu.c:288
> >5  qemu_thread_start (args=3D0x55b10d9ceaa0) at ../util/qemu-thread-posi=
x.c:541
> >6  start_thread () at /usr/lib64/libc.so.6
> >7  clone3 () at /usr/lib64/libc.so.6
> >
> >1. device_del qmp process
> >
> >virtio_set_status
> >  vhost_dev_stop
> >    vhost_user_get_vring_base
> >      vhost_user_host_notifier_remove
> >
> >vhost_user_slave_handle_vring_host_notifier maybe called asynchronous af=
ter
>   ^
> Now it's called vhost_user_backend_handle_vring_host_notifier, I'd
> suggest to use the new name.
>
> >vhost_user_host_notifier_remove. vhost_user_host_notifier_remove will
> >not
> >all call_rcu because of notifier->addr is NULL at this time.
>
> s/all/call ?
>
Yes
> >
> >2. netdev_del qmp process
> >
> >vhost_user_cleanup
> >       vhost_user_host_notifier_remove
> >       g_free_rcu
> >
> >vhost_user_host_notifier_remove and g_free_rcu will sumbit same rcu_head
>
> s/sumbit/submit
>
Sorry about this mistake
> >to rcu node list. rcu_call_count add twice but only one node is added.
> >rcu thread will abort when calling try_dequeue with node list is empty.
>
> What's not clear to me is how 1 and 2 are related, could you explain
> that?
>
Libvirt will send two QMP commands in succession when the network card
is hot-unplugged, which can help understand the problem. However, I
did not describe it clearly. Please see the detailed description at
the top.
> >Fix this by moving g_free(n) to vhost_user_host_notifier_free.
> >`
> >Fixes: 503e355465 ("virtio/vhost-user: dynamically assign VhostUserHostN=
otifiers")
> >Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
> >---
> > hw/virtio/vhost-user.c         | 23 +++++++++++------------
> > include/hw/virtio/vhost-user.h |  1 +
> > 2 files changed, 12 insertions(+), 12 deletions(-)
> >
> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >index 00561daa06..7ab37c0da2 100644
> >--- a/hw/virtio/vhost-user.c
> >+++ b/hw/virtio/vhost-user.c
> >@@ -1188,6 +1188,12 @@ static void vhost_user_host_notifier_free(VhostUs=
erHostNotifier *n)
> >     assert(n && n->unmap_addr);
> >     munmap(n->unmap_addr, qemu_real_host_page_size());
> >     n->unmap_addr =3D NULL;
> >+    if (n->need_free) {
> >+        memory_region_transaction_begin();
> >+        object_unparent(OBJECT(&n->mr));
> >+        memory_region_transaction_commit();
> >+        g_free(n);
> >+    }
> > }
> >
> > /*
> >@@ -1195,7 +1201,7 @@ static void vhost_user_host_notifier_free(VhostUse=
rHostNotifier *n)
> >  * under rcu.
> >  */
> > static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
> >-                                            VirtIODevice *vdev)
> >+                                            VirtIODevice *vdev, bool fr=
ee)
> > {
> >     if (n->addr) {
> >         if (vdev) {
> >@@ -1204,6 +1210,7 @@ static void vhost_user_host_notifier_remove(VhostU=
serHostNotifier *n,
> >         assert(!n->unmap_addr);
> >         n->unmap_addr =3D n->addr;
> >         n->addr =3D NULL;
> >+        n->need_free =3D free;
> >         call_rcu(n, vhost_user_host_notifier_free, rcu);
> >     }
> > }
> >@@ -1280,7 +1287,7 @@ static int vhost_user_get_vring_base(struct vhost_=
dev *dev,
> >
> >     VhostUserHostNotifier *n =3D fetch_notifier(u->user, ring->index);
> >     if (n) {
> >-        vhost_user_host_notifier_remove(n, dev->vdev);
> >+        vhost_user_host_notifier_remove(n, dev->vdev, false);
> >     }
> >
> >     ret =3D vhost_user_write(dev, &msg, NULL, 0);
> >@@ -1562,7 +1569,7 @@ static int vhost_user_backend_handle_vring_host_no=
tifier(struct vhost_dev *dev,
> >      * new mapped address.
> >      */
> >     n =3D fetch_or_create_notifier(user, queue_idx);
> >-    vhost_user_host_notifier_remove(n, vdev);
> >+    vhost_user_host_notifier_remove(n, vdev, false);
> >
> >     if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
> >         return 0;
> >@@ -2737,13 +2744,7 @@ static void vhost_user_state_destroy(gpointer dat=
a)
> > {
> >     VhostUserHostNotifier *n =3D (VhostUserHostNotifier *) data;
> >     if (n) {
> >-        vhost_user_host_notifier_remove(n, NULL);
> >-        object_unparent(OBJECT(&n->mr));
> >-        /*
> >-         * We can't free until vhost_user_host_notifier_remove has
> >-         * done it's thing so schedule the free with RCU.
> >-         */
> >-        g_free_rcu(n, rcu);
> >+        vhost_user_host_notifier_remove(n, NULL, true);
>
> I'm not sure I understand the problem well, but could it be that now we
> don't see the problem anymore, but we have a memory leak?
>
> Here for example could it be the case that `n->addr` is NULL and
> therefore `vhost_user_host_notifier_free` with `n->need_free =3D true`
> will never be submitted?
>
Please see the detailed description at the top.
> >     }
> > }
> >
> >@@ -2765,9 +2766,7 @@ void vhost_user_cleanup(VhostUserState *user)
> >     if (!user->chr) {
> >         return;
> >     }
> >-    memory_region_transaction_begin();
> >     user->notifiers =3D (GPtrArray *) g_ptr_array_free(user->notifiers,
> >     true);
> >-    memory_region_transaction_commit();
>
> This is no longer necessary, because the `user->notifiers` free function
> no longer calls `object_unparent(OBJECT(&n->mr))`, right?
>
> Maybe it's worth mentioning in the commit description.
>
Yes, I originally thought so. But after reading the code carefully, I
found that my understanding was not correct.It is still needed here,
because the user->notifiers free function will call
virtio_queue_set_host_notifier_mr. This should also require
memory_region_transaction_commit. Is this correct?

> >     user->chr =3D NULL;
> > }
> >
> >diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-us=
er.h
> >index 324cd8663a..a171f29e0b 100644
> >--- a/include/hw/virtio/vhost-user.h
> >+++ b/include/hw/virtio/vhost-user.h
> >@@ -54,6 +54,7 @@ typedef struct VhostUserHostNotifier {
> >     void *addr;
> >     void *unmap_addr;
> >     int idx;
> >+    bool need_free;
> > } VhostUserHostNotifier;
> >
> > /**
> >--
> >2.43.0
> >
>

