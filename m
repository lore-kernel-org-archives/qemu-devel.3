Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CD9C25B7E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 02:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDxse-00012A-Ez; Sun, 02 Jun 2024 22:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDxsb-0000te-Pt
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 22:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDtHG-0002XV-BX
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 18:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717365728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H0uZo2eAKFLddIXEod5QOKwyHCNDYrXmvAFNdlvNBuI=;
 b=EYE8syMfIkiSbrMXlL1go7Ozj+fyYdW5ddGH88pTTxlCmi+HbFChbHTbSKlK7ws/R9i/29
 XSmjSkxrlSDPwy5he/GCKXG8w+54Guv/XHnLUzdL6tFfUN+/7Yu7QWydW0Q8ts7Eaao2ws
 PFVOP4Fh2X8Lepf9EJgEA6pQU/1ZPJ8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-rwLFvQoeMVugMuyv7wEs2Q-1; Sun, 02 Jun 2024 18:02:06 -0400
X-MC-Unique: rwLFvQoeMVugMuyv7wEs2Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-354fa62abd7so1643054f8f.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 15:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717365725; x=1717970525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0uZo2eAKFLddIXEod5QOKwyHCNDYrXmvAFNdlvNBuI=;
 b=MGd62v4kDuZTPjhrIUVJp4hr8ma+Sf3YIKuksS6/PjZHIVbX9dcDSmEvUED7rXwoQf
 /X+VudUs5PSLub/1j7QIs46F0WwTiTWghu8aOLq6mq42LQ0nfovH4QjdwvHFt3anOA3u
 fuXrDDknj3M5BDjEjCHN18aWPMTelt+BlHKnQFr1dTlb2F2Lepfr4rvFVDAirBTLlh7T
 X/izbR7gywx2zYCQgOt8MCNWTBqMfff4KiiISqnMskR9lB0wzodOADOvJQfhUlaIBwHm
 V+9OAB+l6DsJ5Smu7hlcdu6/pC1yPmX8BS2CUT0eQBkmz7/l4mpRv0/wySd1/hQBk4Kg
 FTbg==
X-Gm-Message-State: AOJu0YyXkHAp5/AIbIgHgs68KqFR8KMixJgERl62r4XDsJD/gJ6p8wKZ
 jvps1LK9hi77jJh9SwK0jDhU9E2+wAboA7XGlFYyOp0fL0a1tV07KfEgzBQS1sVEZtH7KF05TxP
 UyNc8ctw/dWeSSMXDUOWIErRE5hN2FsWxuRTbtoTMOFF4Oa3NzOSW
X-Received: by 2002:adf:f9c7:0:b0:35d:bf0d:c818 with SMTP id
 ffacd0b85a97d-35e0f289a88mr5409931f8f.34.1717365724945; 
 Sun, 02 Jun 2024 15:02:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm6RCohdnxhm7U7sM0z3rsalSFxFAQXHRHDCWpS2O0qxhLPtE3BFVvoGyiyi+LcQ6gq42yWg==
X-Received: by 2002:adf:f9c7:0:b0:35d:bf0d:c818 with SMTP id
 ffacd0b85a97d-35e0f289a88mr5409903f8f.34.1717365724097; 
 Sun, 02 Jun 2024 15:02:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c9d26sm7031469f8f.25.2024.06.02.15.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 15:02:03 -0700 (PDT)
Date: Sun, 2 Jun 2024 18:01:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Use "void *" as parameter for functions that are used
 for aio_set_event_notifier()
Message-ID: <20240602180152-mutt-send-email-mst@kernel.org>
References: <20240529174948.1241574-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529174948.1241574-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, May 29, 2024 at 07:49:48PM +0200, Thomas Huth wrote:
> aio_set_event_notifier() and aio_set_event_notifier_poll() in
> util/aio-posix.c and util/aio-win32.c are casting function pointers of
> functions that take an "EventNotifier *" pointer as parameter to function
> pointers that take a "void *" pointer as parameter (i.e. the IOHandler
> type). When those function pointers are later used to call the referenced
> function, this triggers undefined behavior errors with the latest version
> of Clang in Fedora 40 when compiling with the option "-fsanitize=undefined".
> And this also prevents enabling the strict mode of CFI which is currently
> disabled with -fsanitize-cfi-icall-generalize-pointers. Thus let us avoid
> the problem by using "void *" as parameter in all spots where it is needed.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  Yes, I know, the patch looks ugly ... but I don't see a better way to
>  tackle this. If someone has a better idea, suggestions are welcome!
> 
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
> 
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
>  
>  /*
>   * Set polling begin/end callbacks for an event notifier that has already been
> @@ -491,8 +491,8 @@ void aio_set_event_notifier(AioContext *ctx,
>   */
>  void aio_set_event_notifier_poll(AioContext *ctx,
>                                   EventNotifier *notifier,
> -                                 EventNotifierHandler *io_poll_begin,
> -                                 EventNotifierHandler *io_poll_end);
> +                                 IOHandler *io_poll_begin,
> +                                 IOHandler *io_poll_end);
>  
>  /* Return a GSource that lets the main loop poll the file descriptors attached
>   * to this AioContext.
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 7d5ffdc145..e98cecfdd7 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -396,7 +396,7 @@ void virtio_device_release_ioeventfd(VirtIODevice *vdev);
>  bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev);
>  EventNotifier *virtio_queue_get_host_notifier(VirtQueue *vq);
>  void virtio_queue_set_host_notifier_enabled(VirtQueue *vq, bool enabled);
> -void virtio_queue_host_notifier_read(EventNotifier *n);
> +void virtio_queue_host_notifier_read(void *n);
>  void virtio_queue_aio_attach_host_notifier(VirtQueue *vq, AioContext *ctx);
>  void virtio_queue_aio_attach_host_notifier_no_poll(VirtQueue *vq, AioContext *ctx);
>  void virtio_queue_aio_detach_host_notifier(VirtQueue *vq, AioContext *ctx);
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
>  
>  GSource *iohandler_get_g_source(void);
>  AioContext *iohandler_get_aio_context(void);
> diff --git a/block/linux-aio.c b/block/linux-aio.c
> index ec05d946f3..61f796f7e0 100644
> --- a/block/linux-aio.c
> +++ b/block/linux-aio.c
> @@ -253,9 +253,9 @@ static void qemu_laio_completion_bh(void *opaque)
>      qemu_laio_process_completions_and_submit(s);
>  }
>  
> -static void qemu_laio_completion_cb(EventNotifier *e)
> +static void qemu_laio_completion_cb(void *e)
>  {
> -    LinuxAioState *s = container_of(e, LinuxAioState, e);
> +    LinuxAioState *s = container_of((EventNotifier *)e, LinuxAioState, e);
>  
>      if (event_notifier_test_and_clear(&s->e)) {
>          qemu_laio_process_completions_and_submit(s);
> @@ -271,7 +271,7 @@ static bool qemu_laio_poll_cb(void *opaque)
>      return io_getevents_peek(s->ctx, &events);
>  }
>  
> -static void qemu_laio_poll_ready(EventNotifier *opaque)
> +static void qemu_laio_poll_ready(void *opaque)
>  {
>      EventNotifier *e = opaque;
>      LinuxAioState *s = container_of(e, LinuxAioState, e);
> diff --git a/block/nvme.c b/block/nvme.c
> index 3a3c6da73d..6c254de2a1 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -656,9 +656,9 @@ static void nvme_poll_queues(BDRVNVMeState *s)
>      }
>  }
>  
> -static void nvme_handle_event(EventNotifier *n)
> +static void nvme_handle_event(void *n)
>  {
> -    BDRVNVMeState *s = container_of(n, BDRVNVMeState,
> +    BDRVNVMeState *s = container_of((EventNotifier *)n, BDRVNVMeState,
>                                      irq_notifier[MSIX_SHARED_IRQ_IDX]);
>  
>      trace_nvme_handle_event(s);
> @@ -732,9 +732,9 @@ static bool nvme_poll_cb(void *opaque)
>      return false;
>  }
>  
> -static void nvme_poll_ready(EventNotifier *e)
> +static void nvme_poll_ready(void *e)
>  {
> -    BDRVNVMeState *s = container_of(e, BDRVNVMeState,
> +    BDRVNVMeState *s = container_of((EventNotifier *)e, BDRVNVMeState,
>                                      irq_notifier[MSIX_SHARED_IRQ_IDX]);
>  
>      nvme_poll_queues(s);
> diff --git a/block/win32-aio.c b/block/win32-aio.c
> index 6327861e1d..0c276028cd 100644
> --- a/block/win32-aio.c
> +++ b/block/win32-aio.c
> @@ -92,9 +92,9 @@ static void win32_aio_process_completion(QEMUWin32AIOState *s,
>      qemu_aio_unref(waiocb);
>  }
>  
> -static void win32_aio_completion_cb(EventNotifier *e)
> +static void win32_aio_completion_cb(void *e)
>  {
> -    QEMUWin32AIOState *s = container_of(e, QEMUWin32AIOState, e);
> +    QEMUWin32AIOState *s = container_of((EventNotifier *)e, QEMUWin32AIOState, e);
>      DWORD count;
>      ULONG_PTR key;
>      OVERLAPPED *ov;
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 483dcca308..c4a27e3529 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -329,10 +329,10 @@ int hyperv_post_msg(HvSintRoute *sint_route, struct hyperv_message *src_msg)
>      return 0;
>  }
>  
> -static void sint_ack_handler(EventNotifier *notifier)
> +static void sint_ack_handler(void *notifier)
>  {
> -    HvSintRoute *sint_route = container_of(notifier, HvSintRoute,
> -                                           sint_ack_notifier);
> +    HvSintRoute *sint_route = container_of((EventNotifier *)notifier,
> +                                           HvSintRoute, sint_ack_notifier);
>      event_notifier_test_and_clear(notifier);
>  
>      /*
> diff --git a/hw/hyperv/hyperv_testdev.c b/hw/hyperv/hyperv_testdev.c
> index 9a56ddf83f..d1d6b9fa4c 100644
> --- a/hw/hyperv/hyperv_testdev.c
> +++ b/hw/hyperv/hyperv_testdev.c
> @@ -190,9 +190,10 @@ static void msg_conn_destroy(HypervTestDev *dev, uint8_t conn_id)
>      assert(false);
>  }
>  
> -static void evt_conn_handler(EventNotifier *notifier)
> +static void evt_conn_handler(void *notifier)
>  {
> -    TestEvtConn *conn = container_of(notifier, TestEvtConn, notifier);
> +    TestEvtConn *conn = container_of((EventNotifier *)notifier, TestEvtConn,
> +                                     notifier);
>  
>      event_notifier_test_and_clear(notifier);
>  
> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
> index 490d805d29..f7e1595ac0 100644
> --- a/hw/hyperv/vmbus.c
> +++ b/hw/hyperv/vmbus.c
> @@ -1273,9 +1273,9 @@ void vmbus_free_req(void *req)
>      g_free(req);
>  }
>  
> -static void channel_event_cb(EventNotifier *e)
> +static void channel_event_cb(void *e)
>  {
> -    VMBusChannel *chan = container_of(e, VMBusChannel, notifier);
> +    VMBusChannel *chan = container_of((EventNotifier *)e, VMBusChannel, notifier);
>      if (event_notifier_test_and_clear(e)) {
>          /*
>           * All receives are supposed to happen within the device worker, so
> @@ -2225,10 +2225,10 @@ static void vmbus_resched(VMBus *vmbus)
>      aio_bh_schedule_oneshot(qemu_get_aio_context(), vmbus_run, vmbus);
>  }
>  
> -static void vmbus_signal_event(EventNotifier *e)
> +static void vmbus_signal_event(void *e)
>  {
>      VMBusChannel *chan;
> -    VMBus *vmbus = container_of(e, VMBus, notifier);
> +    VMBus *vmbus = container_of((EventNotifier *)e, VMBus, notifier);
>      unsigned long *int_map;
>      hwaddr addr, len;
>      bool is_dirty = false;
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..c53adf3489 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -4486,9 +4486,9 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
>      return NVME_INVALID_OPCODE | NVME_DNR;
>  }
>  
> -static void nvme_cq_notifier(EventNotifier *e)
> +static void nvme_cq_notifier(void *e)
>  {
> -    NvmeCQueue *cq = container_of(e, NvmeCQueue, notifier);
> +    NvmeCQueue *cq = container_of((EventNotifier *)e, NvmeCQueue, notifier);
>      NvmeCtrl *n = cq->ctrl;
>  
>      if (!event_notifier_test_and_clear(e)) {
> @@ -4526,9 +4526,9 @@ static int nvme_init_cq_ioeventfd(NvmeCQueue *cq)
>      return 0;
>  }
>  
> -static void nvme_sq_notifier(EventNotifier *e)
> +static void nvme_sq_notifier(void *e)
>  {
> -    NvmeSQueue *sq = container_of(e, NvmeSQueue, notifier);
> +    NvmeSQueue *sq = container_of((EventNotifier *)e, NvmeSQueue, notifier);
>  
>      if (!event_notifier_test_and_clear(e)) {
>          return;
> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
> index 3ee9c73b87..98246363b9 100644
> --- a/hw/usb/ccid-card-emulated.c
> +++ b/hw/usb/ccid-card-emulated.c
> @@ -360,9 +360,10 @@ static void *event_thread(void *arg)
>      return NULL;
>  }
>  
> -static void card_event_handler(EventNotifier *notifier)
> +static void card_event_handler(void *notifier)
>  {
> -    EmulatedState *card = container_of(notifier, EmulatedState, notifier);
> +    EmulatedState *card = container_of((EventNotifier *)notifier,
> +                                       EmulatedState, notifier);
>      EmulEvent *event, *next;
>  
>      event_notifier_test_and_clear(&card->notifier);
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
> index fc5f408f77..c9d8418c00 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -351,9 +351,10 @@ static void vhost_handle_guest_kick(VhostShadowVirtqueue *svq)
>   *
>   * @n: guest kick event notifier, the one that guest set to notify svq.
>   */
> -static void vhost_handle_guest_kick_notifier(EventNotifier *n)
> +static void vhost_handle_guest_kick_notifier(void *n)
>  {
> -    VhostShadowVirtqueue *svq = container_of(n, VhostShadowVirtqueue, svq_kick);
> +    VhostShadowVirtqueue *svq = container_of((EventNotifier *)n,
> +                                             VhostShadowVirtqueue, svq_kick);
>      event_notifier_test_and_clear(n);
>      vhost_handle_guest_kick(svq);
>  }
> @@ -556,10 +557,10 @@ size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num)
>   * Note that we are not making any buffers available in the loop, there is no
>   * way that it runs more than virtqueue size times.
>   */
> -static void vhost_svq_handle_call(EventNotifier *n)
> +static void vhost_svq_handle_call(void *n)
>  {
> -    VhostShadowVirtqueue *svq = container_of(n, VhostShadowVirtqueue,
> -                                             hdev_call);
> +    VhostShadowVirtqueue *svq = container_of((EventNotifier *)n,
> +                                             VhostShadowVirtqueue, hdev_call);
>      event_notifier_test_and_clear(n);
>      vhost_svq_flush(svq, true);
>  }
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 4acd77e890..e624dfafc0 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1363,9 +1363,10 @@ static int vhost_virtqueue_set_busyloop_timeout(struct vhost_dev *dev,
>      return 0;
>  }
>  
> -static void vhost_virtqueue_error_notifier(EventNotifier *n)
> +static void vhost_virtqueue_error_notifier(void *n)
>  {
> -    struct vhost_virtqueue *vq = container_of(n, struct vhost_virtqueue,
> +    struct vhost_virtqueue *vq = container_of((EventNotifier *)n,
> +                                              struct vhost_virtqueue,
>                                                error_notifier);
>      struct vhost_dev *dev = vq->dev;
>      int index = vq - dev->vqs;
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 893a072c9d..80589b4823 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3480,16 +3480,17 @@ uint16_t virtio_get_queue_index(VirtQueue *vq)
>      return vq->queue_index;
>  }
>  
> -static void virtio_queue_guest_notifier_read(EventNotifier *n)
> +static void virtio_queue_guest_notifier_read(void *n)
>  {
> -    VirtQueue *vq = container_of(n, VirtQueue, guest_notifier);
> +    VirtQueue *vq = container_of((EventNotifier *)n, VirtQueue, guest_notifier);
>      if (event_notifier_test_and_clear(n)) {
>          virtio_irq(vq);
>      }
>  }
> -static void virtio_config_guest_notifier_read(EventNotifier *n)
> +static void virtio_config_guest_notifier_read(void *n)
>  {
> -    VirtIODevice *vdev = container_of(n, VirtIODevice, config_notifier);
> +    VirtIODevice *vdev = container_of((EventNotifier *)n, VirtIODevice,
> +                                      config_notifier);
>  
>      if (event_notifier_test_and_clear(n)) {
>          virtio_notify_config(vdev);
> @@ -3533,9 +3534,10 @@ EventNotifier *virtio_queue_get_guest_notifier(VirtQueue *vq)
>      return &vq->guest_notifier;
>  }
>  
> -static void virtio_queue_host_notifier_aio_poll_begin(EventNotifier *n)
> +static void virtio_queue_host_notifier_aio_poll_begin(void *n)
>  {
> -    VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
> +    VirtQueue *vq = container_of((EventNotifier *)n, VirtQueue,
> +                                 host_notifier);
>  
>      virtio_queue_set_notification(vq, 0);
>  }
> @@ -3548,16 +3550,16 @@ static bool virtio_queue_host_notifier_aio_poll(void *opaque)
>      return vq->vring.desc && !virtio_queue_empty(vq);
>  }
>  
> -static void virtio_queue_host_notifier_aio_poll_ready(EventNotifier *n)
> +static void virtio_queue_host_notifier_aio_poll_ready(void *n)
>  {
> -    VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
> +    VirtQueue *vq = container_of((EventNotifier *)n, VirtQueue, host_notifier);
>  
>      virtio_queue_notify_vq(vq);
>  }
>  
> -static void virtio_queue_host_notifier_aio_poll_end(EventNotifier *n)
> +static void virtio_queue_host_notifier_aio_poll_end(void *n)
>  {
> -    VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
> +    VirtQueue *vq = container_of((EventNotifier *)n, VirtQueue, host_notifier);
>  
>      /* Caller polls once more after this to catch requests that race with us */
>      virtio_queue_set_notification(vq, 1);
> @@ -3634,9 +3636,9 @@ void virtio_queue_aio_detach_host_notifier(VirtQueue *vq, AioContext *ctx)
>       */
>  }
>  
> -void virtio_queue_host_notifier_read(EventNotifier *n)
> +void virtio_queue_host_notifier_read(void *n)
>  {
> -    VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
> +    VirtQueue *vq = container_of((EventNotifier *)n, VirtQueue, host_notifier);
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
>  
> -static void dummy_io_handler_read(EventNotifier *e)
> +static void dummy_io_handler_read(void *e)
>  {
>  }
>  
> @@ -85,9 +85,10 @@ static void bh_delete_cb(void *opaque)
>      }
>  }
>  
> -static void event_ready_cb(EventNotifier *e)
> +static void event_ready_cb(void *e)
>  {
> -    EventNotifierTestData *data = container_of(e, EventNotifierTestData, e);
> +    EventNotifierTestData *data = container_of((EventNotifier *)e,
> +                                               EventNotifierTestData, e);
>      g_assert(event_notifier_test_and_clear(e));
>      data->n++;
>      if (data->active > 0) {
> @@ -101,7 +102,7 @@ static void event_ready_cb(EventNotifier *e)
>  /* Tests using aio_*.  */
>  
>  static void set_event_notifier(AioContext *nctx, EventNotifier *notifier,
> -                               EventNotifierHandler *handler)
> +                               IOHandler *handler)
>  {
>      aio_set_event_notifier(nctx, notifier, handler, NULL, NULL);
>  }
> diff --git a/tests/unit/test-nested-aio-poll.c b/tests/unit/test-nested-aio-poll.c
> index d8fd92c43b..8f30f7c7e6 100644
> --- a/tests/unit/test-nested-aio-poll.c
> +++ b/tests/unit/test-nested-aio-poll.c
> @@ -28,7 +28,7 @@ typedef struct {
>      bool nested;
>  } TestData;
>  
> -static void io_read(EventNotifier *notifier)
> +static void io_read(void *notifier)
>  {
>      event_notifier_test_and_clear(notifier);
>  }
> @@ -43,9 +43,9 @@ static bool io_poll_false(void *opaque)
>      return false;
>  }
>  
> -static void io_poll_ready(EventNotifier *notifier)
> +static void io_poll_ready(void *notifier)
>  {
> -    TestData *td = container_of(notifier, TestData, poll_notifier);
> +    TestData *td = container_of((EventNotifier *)notifier, TestData, poll_notifier);
>  
>      g_assert(!td->nested);
>      td->nested = true;
> @@ -60,7 +60,7 @@ static void io_poll_ready(EventNotifier *notifier)
>  }
>  
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
>  
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
>  
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
>  
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
>  
>  void aio_set_event_notifier(AioContext *ctx,
>                              EventNotifier *e,
> -                            EventNotifierHandler *io_notify,
> +                            IOHandler *io_notify,
>                              AioPollFn *io_poll,
> -                            EventNotifierHandler *io_poll_ready)
> +                            IOHandler *io_poll_ready)
>  {
>      AioHandler *node;
>  
> @@ -171,8 +171,8 @@ void aio_set_event_notifier(AioContext *ctx,
>  
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
> @@ -520,9 +520,9 @@ static void aio_timerlist_notify(void *opaque, QEMUClockType type)
>      aio_notify(opaque);
>  }
>  
> -static void aio_context_notifier_cb(EventNotifier *e)
> +static void aio_context_notifier_cb(void *e)
>  {
> -    AioContext *ctx = container_of(e, AioContext, notifier);
> +    AioContext *ctx = container_of((EventNotifier *)e, AioContext, notifier);
>  
>      event_notifier_test_and_clear(&ctx->notifier);
>  }
> @@ -541,7 +541,7 @@ static bool aio_context_notifier_poll(void *opaque)
>      return qatomic_read(&ctx->notified);
>  }
>  
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
>  
> -void event_notifier_set_handler(EventNotifier *e,
> -                                EventNotifierHandler *handler)
> +void event_notifier_set_handler(EventNotifier *e, IOHandler *handler)
>  {
>      iohandler_init();
>      aio_set_event_notifier(iohandler_ctx, e, handler, NULL, NULL);
> -- 
> 2.45.1


