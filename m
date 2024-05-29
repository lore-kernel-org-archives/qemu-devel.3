Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3917C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 18:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCNwg-0002GH-4E; Wed, 29 May 2024 14:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sCNwd-0002FH-Kj
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sCNwW-00007G-Rb
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717006950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Yd9IqXecD4m5rXrMElztzEcg1pPGu0FxXn0cuSQPLM=;
 b=Bs7PAjwZa5zNH900JmhWVyLUwYZVeh2V6+xph6h8yL20dNtIj1imXbVuf06Or9fy0xGwBX
 DwJENSiVw2lA1Phmfoyqz3DAck9TEZlZOSxaHYleRxzSbsmL9ZxzcjnIfAisk5+V51+kmu
 ZRyxRkkXsrhuUG4Un9ig0qxL6Uo7cwc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-YwiOR8IkOWaB6H4Gi8qpiw-1; Wed, 29 May 2024 14:22:25 -0400
X-MC-Unique: YwiOR8IkOWaB6H4Gi8qpiw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DA8F8008A4;
 Wed, 29 May 2024 18:22:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAC432818;
 Wed, 29 May 2024 18:22:23 +0000 (UTC)
Date: Wed, 29 May 2024 14:22:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Use "void *" as parameter for functions that are used
 for aio_set_event_notifier()
Message-ID: <20240529182222.GB1203999@fedora.redhat.com>
References: <20240529174948.1241574-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XTk1rOzjO7XP1y/Z"
Content-Disposition: inline
In-Reply-To: <20240529174948.1241574-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--XTk1rOzjO7XP1y/Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 07:49:48PM +0200, Thomas Huth wrote:
> aio_set_event_notifier() and aio_set_event_notifier_poll() in
> util/aio-posix.c and util/aio-win32.c are casting function pointers of
> functions that take an "EventNotifier *" pointer as parameter to function
> pointers that take a "void *" pointer as parameter (i.e. the IOHandler
> type). When those function pointers are later used to call the referenced
> function, this triggers undefined behavior errors with the latest version
> of Clang in Fedora 40 when compiling with the option "-fsanitize=3Dundefi=
ned".
> And this also prevents enabling the strict mode of CFI which is currently
> disabled with -fsanitize-cfi-icall-generalize-pointers. Thus let us avoid
> the problem by using "void *" as parameter in all spots where it is neede=
d.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Yes, I know, the patch looks ugly ... but I don't see a better way to
>  tackle this. If someone has a better idea, suggestions are welcome!

An alternative is adding EventNotifierHandler *io_read, *io_poll_ready,
*io_poll_begin, and *io_poll_end fields to EventNotifier so that
aio_set_event_notifier() and aio_set_event_notifier_poll() can pass
helper functions to the underlying aio_set_fd_handler() and
aio_set_fd_poll() APIs. These helper functions then invoke the
EventNotifier callbacks:

/* Helpers */
static void event_notifier_io_read(void *opaque)
{
    EventNotifier *notifier =3D opaque;
    notifier->io_read(notifier);
}

static void event_notifier_io_poll_ready(void *opaque)
{
    EventNotifier *notifier =3D opaque;
    notifier->io_poll_ready(notifier);
}

void aio_set_event_notifier(AioContext *ctx,
                            EventNotifier *notifier,
                            EventNotifierHandler *io_read,
                            AioPollFn *io_poll,
                            EventNotifierHandler *io_poll_ready)
{
    notifier->io_read =3D io_read;
    notifier->io_poll_ready =3D io_poll_ready;

    aio_set_fd_handler(ctx, event_notifier_get_fd(notifier),
                       io_read ? event_notifier_io_read : NULL,
		       NULL, io_poll,
                       io_poll_ready ? event_notifier_io_poll_ready : NULL,
		       notifier);
}

=2E..same for aio_set_event_notifier_poll()...

This is not beautiful either but keeps the API type safe and simpler for
users.

>=20
>  include/block/aio.h                |  8 ++++----
>  include/hw/virtio/virtio.h         |  2 +-
>  include/qemu/main-loop.h           |  3 +--
>  block/linux-aio.c                  |  6 +++---
>  block/nvme.c                       |  8 ++++----
>  block/win32-aio.c                  |  4 ++--
>  hw/hyperv/hyperv.c                 |  6 +++---
>  hw/hyperv/hyperv_testdev.c         |  5 +++--
>  hw/hyperv/vmbus.c                  |  8 ++++----
>  hw/nvme/ctrl.c                     |  8 ++++----
>  hw/usb/ccid-card-emulated.c        |  5 +++--
>  hw/virtio/vhost-shadow-virtqueue.c | 11 ++++++-----
>  hw/virtio/vhost.c                  |  5 +++--
>  hw/virtio/virtio.c                 | 26 ++++++++++++++------------
>  tests/unit/test-aio.c              |  9 +++++----
>  tests/unit/test-nested-aio-poll.c  |  8 ++++----
>  util/aio-posix.c                   | 14 ++++++--------
>  util/aio-win32.c                   | 10 +++++-----
>  util/async.c                       |  6 +++---
>  util/main-loop.c                   |  3 +--
>  20 files changed, 79 insertions(+), 76 deletions(-)
>=20
> diff --git a/include/block/aio.h b/include/block/aio.h
> index 8378553eb9..01e7ea069d 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -476,9 +476,9 @@ void aio_set_fd_handler(AioContext *ctx,
>   */
>  void aio_set_event_notifier(AioContext *ctx,
>                              EventNotifier *notifier,
> -                            EventNotifierHandler *io_read,
> +                            IOHandler *io_read,
>                              AioPollFn *io_poll,
> -                            EventNotifierHandler *io_poll_ready);
> +                            IOHandler *io_poll_ready);
> =20
>  /*
>   * Set polling begin/end callbacks for an event notifier that has alread=
y been
> @@ -491,8 +491,8 @@ void aio_set_event_notifier(AioContext *ctx,
>   */
>  void aio_set_event_notifier_poll(AioContext *ctx,
>                                   EventNotifier *notifier,
> -                                 EventNotifierHandler *io_poll_begin,
> -                                 EventNotifierHandler *io_poll_end);
> +                                 IOHandler *io_poll_begin,
> +                                 IOHandler *io_poll_end);
> =20
>  /* Return a GSource that lets the main loop poll the file descriptors at=
tached
>   * to this AioContext.
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 7d5ffdc145..e98cecfdd7 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -396,7 +396,7 @@ void virtio_device_release_ioeventfd(VirtIODevice *vd=
ev);
>  bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev);
>  EventNotifier *virtio_queue_get_host_notifier(VirtQueue *vq);
>  void virtio_queue_set_host_notifier_enabled(VirtQueue *vq, bool enabled);
> -void virtio_queue_host_notifier_read(EventNotifier *n);
> +void virtio_queue_host_notifier_read(void *n);
>  void virtio_queue_aio_attach_host_notifier(VirtQueue *vq, AioContext *ct=
x);
>  void virtio_queue_aio_attach_host_notifier_no_poll(VirtQueue *vq, AioCon=
text *ctx);
>  void virtio_queue_aio_detach_host_notifier(VirtQueue *vq, AioContext *ct=
x);
> diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
> index 5764db157c..ba73a0c6da 100644
> --- a/include/qemu/main-loop.h
> +++ b/include/qemu/main-loop.h
> @@ -241,8 +241,7 @@ void qemu_set_fd_handler(int fd,
>   * @handler: A level-triggered callback that is fired when @e
>   * has been set.  @e is passed to it as a parameter.
>   */
> -void event_notifier_set_handler(EventNotifier *e,
> -                                EventNotifierHandler *handler);
> +void event_notifier_set_handler(EventNotifier *e, IOHandler *handler);
> =20
>  GSource *iohandler_get_g_source(void);
>  AioContext *iohandler_get_aio_context(void);
> diff --git a/block/linux-aio.c b/block/linux-aio.c
> index ec05d946f3..61f796f7e0 100644
> --- a/block/linux-aio.c
> +++ b/block/linux-aio.c
> @@ -253,9 +253,9 @@ static void qemu_laio_completion_bh(void *opaque)
>      qemu_laio_process_completions_and_submit(s);
>  }
> =20
> -static void qemu_laio_completion_cb(EventNotifier *e)
> +static void qemu_laio_completion_cb(void *e)
>  {
> -    LinuxAioState *s =3D container_of(e, LinuxAioState, e);
> +    LinuxAioState *s =3D container_of((EventNotifier *)e, LinuxAioState,=
 e);
> =20
>      if (event_notifier_test_and_clear(&s->e)) {
>          qemu_laio_process_completions_and_submit(s);
> @@ -271,7 +271,7 @@ static bool qemu_laio_poll_cb(void *opaque)
>      return io_getevents_peek(s->ctx, &events);
>  }
> =20
> -static void qemu_laio_poll_ready(EventNotifier *opaque)
> +static void qemu_laio_poll_ready(void *opaque)
>  {
>      EventNotifier *e =3D opaque;
>      LinuxAioState *s =3D container_of(e, LinuxAioState, e);
> diff --git a/block/nvme.c b/block/nvme.c
> index 3a3c6da73d..6c254de2a1 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -656,9 +656,9 @@ static void nvme_poll_queues(BDRVNVMeState *s)
>      }
>  }
> =20
> -static void nvme_handle_event(EventNotifier *n)
> +static void nvme_handle_event(void *n)
>  {
> -    BDRVNVMeState *s =3D container_of(n, BDRVNVMeState,
> +    BDRVNVMeState *s =3D container_of((EventNotifier *)n, BDRVNVMeState,
>                                      irq_notifier[MSIX_SHARED_IRQ_IDX]);
> =20
>      trace_nvme_handle_event(s);
> @@ -732,9 +732,9 @@ static bool nvme_poll_cb(void *opaque)
>      return false;
>  }
> =20
> -static void nvme_poll_ready(EventNotifier *e)
> +static void nvme_poll_ready(void *e)
>  {
> -    BDRVNVMeState *s =3D container_of(e, BDRVNVMeState,
> +    BDRVNVMeState *s =3D container_of((EventNotifier *)e, BDRVNVMeState,
>                                      irq_notifier[MSIX_SHARED_IRQ_IDX]);
> =20
>      nvme_poll_queues(s);
> diff --git a/block/win32-aio.c b/block/win32-aio.c
> index 6327861e1d..0c276028cd 100644
> --- a/block/win32-aio.c
> +++ b/block/win32-aio.c
> @@ -92,9 +92,9 @@ static void win32_aio_process_completion(QEMUWin32AIOSt=
ate *s,
>      qemu_aio_unref(waiocb);
>  }
> =20
> -static void win32_aio_completion_cb(EventNotifier *e)
> +static void win32_aio_completion_cb(void *e)
>  {
> -    QEMUWin32AIOState *s =3D container_of(e, QEMUWin32AIOState, e);
> +    QEMUWin32AIOState *s =3D container_of((EventNotifier *)e, QEMUWin32A=
IOState, e);
>      DWORD count;
>      ULONG_PTR key;
>      OVERLAPPED *ov;
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 483dcca308..c4a27e3529 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -329,10 +329,10 @@ int hyperv_post_msg(HvSintRoute *sint_route, struct=
 hyperv_message *src_msg)
>      return 0;
>  }
> =20
> -static void sint_ack_handler(EventNotifier *notifier)
> +static void sint_ack_handler(void *notifier)
>  {
> -    HvSintRoute *sint_route =3D container_of(notifier, HvSintRoute,
> -                                           sint_ack_notifier);
> +    HvSintRoute *sint_route =3D container_of((EventNotifier *)notifier,
> +                                           HvSintRoute, sint_ack_notifie=
r);
>      event_notifier_test_and_clear(notifier);
> =20
>      /*
> diff --git a/hw/hyperv/hyperv_testdev.c b/hw/hyperv/hyperv_testdev.c
> index 9a56ddf83f..d1d6b9fa4c 100644
> --- a/hw/hyperv/hyperv_testdev.c
> +++ b/hw/hyperv/hyperv_testdev.c
> @@ -190,9 +190,10 @@ static void msg_conn_destroy(HypervTestDev *dev, uin=
t8_t conn_id)
>      assert(false);
>  }
> =20
> -static void evt_conn_handler(EventNotifier *notifier)
> +static void evt_conn_handler(void *notifier)
>  {
> -    TestEvtConn *conn =3D container_of(notifier, TestEvtConn, notifier);
> +    TestEvtConn *conn =3D container_of((EventNotifier *)notifier, TestEv=
tConn,
> +                                     notifier);
> =20
>      event_notifier_test_and_clear(notifier);
> =20
> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
> index 490d805d29..f7e1595ac0 100644
> --- a/hw/hyperv/vmbus.c
> +++ b/hw/hyperv/vmbus.c
> @@ -1273,9 +1273,9 @@ void vmbus_free_req(void *req)
>      g_free(req);
>  }
> =20
> -static void channel_event_cb(EventNotifier *e)
> +static void channel_event_cb(void *e)
>  {
> -    VMBusChannel *chan =3D container_of(e, VMBusChannel, notifier);
> +    VMBusChannel *chan =3D container_of((EventNotifier *)e, VMBusChannel=
, notifier);
>      if (event_notifier_test_and_clear(e)) {
>          /*
>           * All receives are supposed to happen within the device worker,=
 so
> @@ -2225,10 +2225,10 @@ static void vmbus_resched(VMBus *vmbus)
>      aio_bh_schedule_oneshot(qemu_get_aio_context(), vmbus_run, vmbus);
>  }
> =20
> -static void vmbus_signal_event(EventNotifier *e)
> +static void vmbus_signal_event(void *e)
>  {
>      VMBusChannel *chan;
> -    VMBus *vmbus =3D container_of(e, VMBus, notifier);
> +    VMBus *vmbus =3D container_of((EventNotifier *)e, VMBus, notifier);
>      unsigned long *int_map;
>      hwaddr addr, len;
>      bool is_dirty =3D false;
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..c53adf3489 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -4486,9 +4486,9 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeReques=
t *req)
>      return NVME_INVALID_OPCODE | NVME_DNR;
>  }
> =20
> -static void nvme_cq_notifier(EventNotifier *e)
> +static void nvme_cq_notifier(void *e)
>  {
> -    NvmeCQueue *cq =3D container_of(e, NvmeCQueue, notifier);
> +    NvmeCQueue *cq =3D container_of((EventNotifier *)e, NvmeCQueue, noti=
fier);
>      NvmeCtrl *n =3D cq->ctrl;
> =20
>      if (!event_notifier_test_and_clear(e)) {
> @@ -4526,9 +4526,9 @@ static int nvme_init_cq_ioeventfd(NvmeCQueue *cq)
>      return 0;
>  }
> =20
> -static void nvme_sq_notifier(EventNotifier *e)
> +static void nvme_sq_notifier(void *e)
>  {
> -    NvmeSQueue *sq =3D container_of(e, NvmeSQueue, notifier);
> +    NvmeSQueue *sq =3D container_of((EventNotifier *)e, NvmeSQueue, noti=
fier);
> =20
>      if (!event_notifier_test_and_clear(e)) {
>          return;
> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
> index 3ee9c73b87..98246363b9 100644
> --- a/hw/usb/ccid-card-emulated.c
> +++ b/hw/usb/ccid-card-emulated.c
> @@ -360,9 +360,10 @@ static void *event_thread(void *arg)
>      return NULL;
>  }
> =20
> -static void card_event_handler(EventNotifier *notifier)
> +static void card_event_handler(void *notifier)
>  {
> -    EmulatedState *card =3D container_of(notifier, EmulatedState, notifi=
er);
> +    EmulatedState *card =3D container_of((EventNotifier *)notifier,
> +                                       EmulatedState, notifier);
>      EmulEvent *event, *next;
> =20
>      event_notifier_test_and_clear(&card->notifier);
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index fc5f408f77..c9d8418c00 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -351,9 +351,10 @@ static void vhost_handle_guest_kick(VhostShadowVirtq=
ueue *svq)
>   *
>   * @n: guest kick event notifier, the one that guest set to notify svq.
>   */
> -static void vhost_handle_guest_kick_notifier(EventNotifier *n)
> +static void vhost_handle_guest_kick_notifier(void *n)
>  {
> -    VhostShadowVirtqueue *svq =3D container_of(n, VhostShadowVirtqueue, =
svq_kick);
> +    VhostShadowVirtqueue *svq =3D container_of((EventNotifier *)n,
> +                                             VhostShadowVirtqueue, svq_k=
ick);
>      event_notifier_test_and_clear(n);
>      vhost_handle_guest_kick(svq);
>  }
> @@ -556,10 +557,10 @@ size_t vhost_svq_poll(VhostShadowVirtqueue *svq, si=
ze_t num)
>   * Note that we are not making any buffers available in the loop, there =
is no
>   * way that it runs more than virtqueue size times.
>   */
> -static void vhost_svq_handle_call(EventNotifier *n)
> +static void vhost_svq_handle_call(void *n)
>  {
> -    VhostShadowVirtqueue *svq =3D container_of(n, VhostShadowVirtqueue,
> -                                             hdev_call);
> +    VhostShadowVirtqueue *svq =3D container_of((EventNotifier *)n,
> +                                             VhostShadowVirtqueue, hdev_=
call);
>      event_notifier_test_and_clear(n);
>      vhost_svq_flush(svq, true);
>  }
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 4acd77e890..e624dfafc0 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1363,9 +1363,10 @@ static int vhost_virtqueue_set_busyloop_timeout(st=
ruct vhost_dev *dev,
>      return 0;
>  }
> =20
> -static void vhost_virtqueue_error_notifier(EventNotifier *n)
> +static void vhost_virtqueue_error_notifier(void *n)
>  {
> -    struct vhost_virtqueue *vq =3D container_of(n, struct vhost_virtqueu=
e,
> +    struct vhost_virtqueue *vq =3D container_of((EventNotifier *)n,
> +                                              struct vhost_virtqueue,
>                                                error_notifier);
>      struct vhost_dev *dev =3D vq->dev;
>      int index =3D vq - dev->vqs;
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 893a072c9d..80589b4823 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3480,16 +3480,17 @@ uint16_t virtio_get_queue_index(VirtQueue *vq)
>      return vq->queue_index;
>  }
> =20
> -static void virtio_queue_guest_notifier_read(EventNotifier *n)
> +static void virtio_queue_guest_notifier_read(void *n)
>  {
> -    VirtQueue *vq =3D container_of(n, VirtQueue, guest_notifier);
> +    VirtQueue *vq =3D container_of((EventNotifier *)n, VirtQueue, guest_=
notifier);
>      if (event_notifier_test_and_clear(n)) {
>          virtio_irq(vq);
>      }
>  }
> -static void virtio_config_guest_notifier_read(EventNotifier *n)
> +static void virtio_config_guest_notifier_read(void *n)
>  {
> -    VirtIODevice *vdev =3D container_of(n, VirtIODevice, config_notifier=
);
> +    VirtIODevice *vdev =3D container_of((EventNotifier *)n, VirtIODevice,
> +                                      config_notifier);
> =20
>      if (event_notifier_test_and_clear(n)) {
>          virtio_notify_config(vdev);
> @@ -3533,9 +3534,10 @@ EventNotifier *virtio_queue_get_guest_notifier(Vir=
tQueue *vq)
>      return &vq->guest_notifier;
>  }
> =20
> -static void virtio_queue_host_notifier_aio_poll_begin(EventNotifier *n)
> +static void virtio_queue_host_notifier_aio_poll_begin(void *n)
>  {
> -    VirtQueue *vq =3D container_of(n, VirtQueue, host_notifier);
> +    VirtQueue *vq =3D container_of((EventNotifier *)n, VirtQueue,
> +                                 host_notifier);
> =20
>      virtio_queue_set_notification(vq, 0);
>  }
> @@ -3548,16 +3550,16 @@ static bool virtio_queue_host_notifier_aio_poll(v=
oid *opaque)
>      return vq->vring.desc && !virtio_queue_empty(vq);
>  }
> =20
> -static void virtio_queue_host_notifier_aio_poll_ready(EventNotifier *n)
> +static void virtio_queue_host_notifier_aio_poll_ready(void *n)
>  {
> -    VirtQueue *vq =3D container_of(n, VirtQueue, host_notifier);
> +    VirtQueue *vq =3D container_of((EventNotifier *)n, VirtQueue, host_n=
otifier);
> =20
>      virtio_queue_notify_vq(vq);
>  }
> =20
> -static void virtio_queue_host_notifier_aio_poll_end(EventNotifier *n)
> +static void virtio_queue_host_notifier_aio_poll_end(void *n)
>  {
> -    VirtQueue *vq =3D container_of(n, VirtQueue, host_notifier);
> +    VirtQueue *vq =3D container_of((EventNotifier *)n, VirtQueue, host_n=
otifier);
> =20
>      /* Caller polls once more after this to catch requests that race wit=
h us */
>      virtio_queue_set_notification(vq, 1);
> @@ -3634,9 +3636,9 @@ void virtio_queue_aio_detach_host_notifier(VirtQueu=
e *vq, AioContext *ctx)
>       */
>  }
> =20
> -void virtio_queue_host_notifier_read(EventNotifier *n)
> +void virtio_queue_host_notifier_read(void *n)
>  {
> -    VirtQueue *vq =3D container_of(n, VirtQueue, host_notifier);
> +    VirtQueue *vq =3D container_of((EventNotifier *)n, VirtQueue, host_n=
otifier);
>      if (event_notifier_test_and_clear(n)) {
>          virtio_queue_notify_vq(vq);
>      }
> diff --git a/tests/unit/test-aio.c b/tests/unit/test-aio.c
> index e77d86be87..b83e2fdc49 100644
> --- a/tests/unit/test-aio.c
> +++ b/tests/unit/test-aio.c
> @@ -70,7 +70,7 @@ static void timer_test_cb(void *opaque)
>      }
>  }
> =20
> -static void dummy_io_handler_read(EventNotifier *e)
> +static void dummy_io_handler_read(void *e)
>  {
>  }
> =20
> @@ -85,9 +85,10 @@ static void bh_delete_cb(void *opaque)
>      }
>  }
> =20
> -static void event_ready_cb(EventNotifier *e)
> +static void event_ready_cb(void *e)
>  {
> -    EventNotifierTestData *data =3D container_of(e, EventNotifierTestDat=
a, e);
> +    EventNotifierTestData *data =3D container_of((EventNotifier *)e,
> +                                               EventNotifierTestData, e);
>      g_assert(event_notifier_test_and_clear(e));
>      data->n++;
>      if (data->active > 0) {
> @@ -101,7 +102,7 @@ static void event_ready_cb(EventNotifier *e)
>  /* Tests using aio_*.  */
> =20
>  static void set_event_notifier(AioContext *nctx, EventNotifier *notifier,
> -                               EventNotifierHandler *handler)
> +                               IOHandler *handler)
>  {
>      aio_set_event_notifier(nctx, notifier, handler, NULL, NULL);
>  }
> diff --git a/tests/unit/test-nested-aio-poll.c b/tests/unit/test-nested-a=
io-poll.c
> index d8fd92c43b..8f30f7c7e6 100644
> --- a/tests/unit/test-nested-aio-poll.c
> +++ b/tests/unit/test-nested-aio-poll.c
> @@ -28,7 +28,7 @@ typedef struct {
>      bool nested;
>  } TestData;
> =20
> -static void io_read(EventNotifier *notifier)
> +static void io_read(void *notifier)
>  {
>      event_notifier_test_and_clear(notifier);
>  }
> @@ -43,9 +43,9 @@ static bool io_poll_false(void *opaque)
>      return false;
>  }
> =20
> -static void io_poll_ready(EventNotifier *notifier)
> +static void io_poll_ready(void *notifier)
>  {
> -    TestData *td =3D container_of(notifier, TestData, poll_notifier);
> +    TestData *td =3D container_of((EventNotifier *)notifier, TestData, p=
oll_notifier);
> =20
>      g_assert(!td->nested);
>      td->nested =3D true;
> @@ -60,7 +60,7 @@ static void io_poll_ready(EventNotifier *notifier)
>  }
> =20
>  /* dummy_notifier never triggers */
> -static void io_poll_never_ready(EventNotifier *notifier)
> +static void io_poll_never_ready(void *notifier)
>  {
>      g_assert_not_reached();
>  }
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 266c9dd35f..c6766daa54 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -194,23 +194,21 @@ static void aio_set_fd_poll(AioContext *ctx, int fd,
> =20
>  void aio_set_event_notifier(AioContext *ctx,
>                              EventNotifier *notifier,
> -                            EventNotifierHandler *io_read,
> +                            IOHandler *io_read,
>                              AioPollFn *io_poll,
> -                            EventNotifierHandler *io_poll_ready)
> +                            IOHandler *io_poll_ready)
>  {
>      aio_set_fd_handler(ctx, event_notifier_get_fd(notifier),
> -                       (IOHandler *)io_read, NULL, io_poll,
> -                       (IOHandler *)io_poll_ready, notifier);
> +                       io_read, NULL, io_poll, io_poll_ready, notifier);
>  }
> =20
>  void aio_set_event_notifier_poll(AioContext *ctx,
>                                   EventNotifier *notifier,
> -                                 EventNotifierHandler *io_poll_begin,
> -                                 EventNotifierHandler *io_poll_end)
> +                                 IOHandler *io_poll_begin,
> +                                 IOHandler *io_poll_end)
>  {
>      aio_set_fd_poll(ctx, event_notifier_get_fd(notifier),
> -                    (IOHandler *)io_poll_begin,
> -                    (IOHandler *)io_poll_end);
> +                    io_poll_begin, io_poll_end);
>  }
> =20
>  static bool poll_set_started(AioContext *ctx, AioHandlerList *ready_list,
> diff --git a/util/aio-win32.c b/util/aio-win32.c
> index d144f9391f..1d698ed431 100644
> --- a/util/aio-win32.c
> +++ b/util/aio-win32.c
> @@ -28,7 +28,7 @@ struct AioHandler {
>      EventNotifier *e;
>      IOHandler *io_read;
>      IOHandler *io_write;
> -    EventNotifierHandler *io_notify;
> +    IOHandler *io_notify;
>      GPollFD pfd;
>      int deleted;
>      void *opaque;
> @@ -132,9 +132,9 @@ void aio_set_fd_handler(AioContext *ctx,
> =20
>  void aio_set_event_notifier(AioContext *ctx,
>                              EventNotifier *e,
> -                            EventNotifierHandler *io_notify,
> +                            IOHandler *io_notify,
>                              AioPollFn *io_poll,
> -                            EventNotifierHandler *io_poll_ready)
> +                            IOHandler *io_poll_ready)
>  {
>      AioHandler *node;
> =20
> @@ -171,8 +171,8 @@ void aio_set_event_notifier(AioContext *ctx,
> =20
>  void aio_set_event_notifier_poll(AioContext *ctx,
>                                   EventNotifier *notifier,
> -                                 EventNotifierHandler *io_poll_begin,
> -                                 EventNotifierHandler *io_poll_end)
> +                                 IOHandler *io_poll_begin,
> +                                 IOHandler *io_poll_end)
>  {
>      /* Not implemented */
>  }
> diff --git a/util/async.c b/util/async.c
> index 0467890052..d606901049 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -520,9 +520,9 @@ static void aio_timerlist_notify(void *opaque, QEMUCl=
ockType type)
>      aio_notify(opaque);
>  }
> =20
> -static void aio_context_notifier_cb(EventNotifier *e)
> +static void aio_context_notifier_cb(void *e)
>  {
> -    AioContext *ctx =3D container_of(e, AioContext, notifier);
> +    AioContext *ctx =3D container_of((EventNotifier *)e, AioContext, not=
ifier);
> =20
>      event_notifier_test_and_clear(&ctx->notifier);
>  }
> @@ -541,7 +541,7 @@ static bool aio_context_notifier_poll(void *opaque)
>      return qatomic_read(&ctx->notified);
>  }
> =20
> -static void aio_context_notifier_poll_ready(EventNotifier *e)
> +static void aio_context_notifier_poll_ready(void *e)
>  {
>      /* Do nothing, we just wanted to kick the event loop */
>  }
> diff --git a/util/main-loop.c b/util/main-loop.c
> index a0386cfeb6..035b4e5769 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -645,8 +645,7 @@ void qemu_set_fd_handler(int fd,
>                         opaque);
>  }
> =20
> -void event_notifier_set_handler(EventNotifier *e,
> -                                EventNotifierHandler *handler)
> +void event_notifier_set_handler(EventNotifier *e, IOHandler *handler)
>  {
>      iohandler_init();
>      aio_set_event_notifier(iohandler_ctx, e, handler, NULL, NULL);
> --=20
> 2.45.1
>=20

--XTk1rOzjO7XP1y/Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZXcl0ACgkQnKSrs4Gr
c8gUagf/YGPrZU3ub/t9GoU9xuMLpOLczbGi0aTVdMsqp+ejcOSuqf6oIVxpsaWr
cqjtmmpOUiA/0B89h3bRRd/tP8e6jxvEyJvgAfjvdnGgZQA8vpS0jLSXCb7ig5tA
QsRd4T5mPyVpyJvZ4c/jr3msQKzO0SMYAzU4qdC60Jjkq7fJhrtfnxx9Pv6y3vtB
uGzkR+Zd0G5srsPo7TW1aUVcAKVTDAPQwnwdUKc5tlwiR0eEpt61ypj/lT8WEVyW
9hZXdAMNBVopM+4qVmNZuHxDzMd0e3d347xio1r20uUM2zCDzGitLuQmJ3XZGrsS
WNtvTvD5fCEs4+Oy7J8w8WmLIVbplA==
=l8Cg
-----END PGP SIGNATURE-----

--XTk1rOzjO7XP1y/Z--


