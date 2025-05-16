Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3202DC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 13:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFujF-0007Zu-JP; Fri, 16 May 2025 09:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1uFujD-0007ZN-LM; Fri, 16 May 2025 09:03:55 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1uFujB-0001lf-LJ; Fri, 16 May 2025 09:03:55 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3081f72c271so1817310a91.0; 
 Fri, 16 May 2025 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747400627; x=1748005427; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e9JiVE9wkHLpF1Lze+QudCejDrSPPWHofW11XWnSNc4=;
 b=Jv5U/zzgz9K/hnO30rwsobGEorlVL4J0qGutT0SzUYWwD4FJ2JFBYGNoAqJ661Wvu/
 HUAYtQjjnAKA7iNvmPA3pNWfuapQ5vXJ92eMk9+hURbaJ2uP4701xUOpkO9zaNC+hlGm
 M+2cmcqXA81169c61NKgx+q5Q7R+8UpH3rcd1viJ3BKIpcAHQ9PjTeshRRBR6UNurnKA
 QcgHvhRCUjC0fs6DjWZHqNfkIP+Bp8aOMp7ow6jHGMAU2W/o9iUgEk8XW+tmb6Rkbnim
 FxQfA6ATmLEmpPhI8zJv0WhXklOYpV1vQLh6xS3xuqhpuDrBh9kCZ3OG/UhGxOoUluau
 7aaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747400627; x=1748005427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e9JiVE9wkHLpF1Lze+QudCejDrSPPWHofW11XWnSNc4=;
 b=ZgVRd1qpFP3wg2bqK4vFVl33XOnvgrKvn+/KgZRcJhT9eLIRTs0lviqo2/o8HAvSuc
 FkG+eMIdKT+y/c60DZcGuHVVAR+u+m7QhiSKElUTQc61uECjTNdL8/ZBpq8Jn3kJj8yy
 GxAzjU5GveWBAvAZ29kSggIvVy/TweanRrLcEC97suFmvB9aO/vCGVh2qzoapo4KuWHE
 fNx4YlSWB1f9nj+dZWOpdME207TFhDokK5eb1RkOZGjxFmK/zm5lsx5xwU07+Cj4eLtE
 AksA6dVshxQHVE0LvkB7Mnhb6o3hgdlN7iHiwxY/dASzqmpc82y8VWvjijI88o+f2pub
 sScA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBhHFnQsS7OQbgT+7+MCrDcKY2LLNqDJ0RncgeUh5GGU0XLXnGo/rX9Ly7vsIV37z5Gphlg3IUYZ1D@nongnu.org,
 AJvYcCWPM3SnoB3Ub08uL0hVcOT9JmpFmYJFPJSTA388JsZww4x/lJnq79htzCBgd4U04jS0yXn9Ha8o1zGqBvs=@nongnu.org
X-Gm-Message-State: AOJu0YxCmY+3UUE2CI80LJL4BVRAJL2txMyr8CSs3Dymx7bj3KgsIA78
 xM4/UuxIa2oA0MYRy5Ngf+MG7o4skFga01wkK5qUKDMwnd/3q5IzbzZt9pN368BhUH4A81XYHWr
 1OoHwZ+yZFRW7Fl41hZAJ6h05SzCAkkM=
X-Gm-Gg: ASbGnctoRtbIZ15WFVVu/ctEGbhGn9cWatitQFQ3wGjJeZYUwfH/o5Dd8qtA779qzNk
 4n9vgguwV40M4N5abmBz65z6lOxDJaCk9n9V4L7GV8wIt70N1q4dfCGi6tIRNk3ZmIq2hTH4gDG
 7te1bzK+z7oxj6chXGO4y+Dw8fI8sCWJgR
X-Google-Smtp-Source: AGHT+IHFfY1QYOheYHxb1gwuR/iWnp7JRj43AO6dgGp9lmzoC6w6GDU0t3omPn43bNudyEB+sY1rManQTSL8B31B3Mk=
X-Received: by 2002:a17:90b:4f4c:b0:309:ebe3:1ef9 with SMTP id
 98e67ed59e1d1-30e830ebf54mr4393761a91.12.1747400627144; Fri, 16 May 2025
 06:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250513112825.1731347-1-hanht2@chinatelecom.cn>
 <5cstdapha4xzmgkuja5ydxxvfgr4ux5iytex3qp65vm5hedp7s@h2mjfv72npyw>
In-Reply-To: <5cstdapha4xzmgkuja5ydxxvfgr4ux5iytex3qp65vm5hedp7s@h2mjfv72npyw>
From: Huaitong Han <oenhan@gmail.com>
Date: Fri, 16 May 2025 21:03:33 +0800
X-Gm-Features: AX0GCFul_QcBAuRnYsa7GIrThL1CPQejvhfP2PRo9wp0llHKRFlUMp5Cttz75Bs
Message-ID: <CAAuJbeKtVjDzxBLkX86tHFnmXNBzTRpunAQ7WmBQXpYrSs-kig@mail.gmail.com>
Subject: Re: [PATCH V2] vhost: Don't set vring call if guest notifier is unused
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, cohuck@redhat.com, 
 pasic@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com, 
 leiyang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>, 
 Jidong Xia <xiajd@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=oenhan@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2025=E5=B9=B45=E6=9C=8816=
=E6=97=A5=E5=91=A8=E4=BA=94 16:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, May 13, 2025 at 07:28:25PM +0800, oenhan@gmail.com wrote:
> >From: Huaitong Han <hanht2@chinatelecom.cn>
> >
> >The vring call fd is set even when the guest does not use MSI-X (e.g., i=
n the
> >case of virtio PMD), leading to unnecessary CPU overhead for processing
> >interrupts.
> >
> >The commit 96a3d98d2c("vhost: don't set vring call if no vector") optimi=
zed the
> >case where MSI-X is enabled but the queue vector is unset. However, ther=
e's an
> >additional case where the guest uses INTx and the INTx_DISABLED bit in t=
he PCI
> >config is set, meaning that no interrupt notifier will actually be used.
> >
> >In such cases, the vring call fd should also be cleared to avoid redunda=
nt
> >interrupt handling.
> >
> >Fixes: 96a3d98d2c("vhost: don't set vring call if no vector")
> >Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
> >Signed-off-by: Jidong Xia <xiajd@chinatelecom.cn>
> >Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
> >---
> >V2:
> >- Retain the name `query_guest_notifiers`
> >- All qtest/unit test cases pass
> >- Fix V1 patch style problems
> >
> > hw/pci/pci.c                   |  2 +-
> > hw/s390x/virtio-ccw.c          |  7 +++++--
> > hw/virtio/vhost.c              |  3 +--
> > hw/virtio/virtio-pci.c         | 10 ++++++++--
> > include/hw/pci/pci.h           |  1 +
> > include/hw/virtio/virtio-bus.h |  2 +-
> > 6 files changed, 17 insertions(+), 8 deletions(-)
> >
> >diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >index 352b3d12c8..45b491412a 100644
> >--- a/hw/pci/pci.c
> >+++ b/hw/pci/pci.c
> >@@ -1712,7 +1712,7 @@ static void pci_update_mappings(PCIDevice *d)
> >     pci_update_vga(d);
> > }
> >
> >-static inline int pci_irq_disabled(PCIDevice *d)
> >+int pci_irq_disabled(PCIDevice *d)
>
> Since it was inline, will it be better to move the whole function to
> include/hw/pci/pci.h and keep it inline?
>
I did try moving the function to include/hw/pci/pci.h and marking it
inline, but ran into compilation issues due to the use of the incomplete
PCIDevice type.
Specifically, accessing d->config triggers the following error:
include/hw/pci/pci.h:674:26: error: invalid use of incomplete typedef
=E2=80=98PCIDevice=E2=80=99
return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DISABLE;
Including hw/pci/pci_device.h in pci.h to resolve this introduces
further issues, so I suggest to keep the function as a non-inline
helper in the .c file.

> Thanks,
> Stefano
>
> > {
> >     return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DIS=
ABLE;
> > }
> >diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> >index d2f85b39f3..632708ba4d 100644
> >--- a/hw/s390x/virtio-ccw.c
> >+++ b/hw/s390x/virtio-ccw.c
> >@@ -936,11 +936,14 @@ static void virtio_ccw_vmstate_change(DeviceState =
*d, bool running)
> >     }
> > }
> >
> >-static bool virtio_ccw_query_guest_notifiers(DeviceState *d)
> >+static bool virtio_ccw_query_guest_notifiers(DeviceState *d, int n)
> > {
> >     CcwDevice *dev =3D CCW_DEVICE(d);
> >+    VirtioCcwDevice *vdev =3D VIRTIO_CCW_DEVICE(d);
> >+    VirtIODevice *virtio_dev =3D virtio_bus_get_device(&vdev->bus);
> >
> >-    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA);
> >+    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA)
> >+            && virtio_queue_vector(virtio_dev, n) !=3D VIRTIO_NO_VECTOR=
;
> > }
> >
> > static int virtio_ccw_get_mappings(VirtioCcwDevice *dev)
> >diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >index 4cae7c1664..2a9a839763 100644
> >--- a/hw/virtio/vhost.c
> >+++ b/hw/virtio/vhost.c
> >@@ -1341,8 +1341,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
> >     }
> >
> >     if (k->query_guest_notifiers &&
> >-        k->query_guest_notifiers(qbus->parent) &&
> >-        virtio_queue_vector(vdev, idx) =3D=3D VIRTIO_NO_VECTOR) {
> >+        !k->query_guest_notifiers(qbus->parent, idx)) {
> >         file.fd =3D -1;
> >         r =3D dev->vhost_ops->vhost_set_vring_call(dev, &file);
> >         if (r) {
> >diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> >index 0fa8fe4955..d62e199489 100644
> >--- a/hw/virtio/virtio-pci.c
> >+++ b/hw/virtio/virtio-pci.c
> >@@ -1212,10 +1212,16 @@ static int virtio_pci_set_guest_notifier(DeviceS=
tate *d, int n, bool assign,
> >     return 0;
> > }
> >
> >-static bool virtio_pci_query_guest_notifiers(DeviceState *d)
> >+static bool virtio_pci_query_guest_notifiers(DeviceState *d, int n)
> > {
> >     VirtIOPCIProxy *proxy =3D to_virtio_pci_proxy(d);
> >-    return msix_enabled(&proxy->pci_dev);
> >+    VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> >+
> >+    if (msix_enabled(&proxy->pci_dev)) {
> >+        return virtio_queue_vector(vdev, n) !=3D VIRTIO_NO_VECTOR;
> >+    } else {
> >+        return !pci_irq_disabled(&proxy->pci_dev);
> >+    }
> > }
> >
> > static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, boo=
l assign)
> >diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> >index c2fe6caa2c..8c24bd97db 100644
> >--- a/include/hw/pci/pci.h
> >+++ b/include/hw/pci/pci.h
> >@@ -668,6 +668,7 @@ void lsi53c8xx_handle_legacy_cmdline(DeviceState *ls=
i_dev);
> >
> > qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
> > void pci_set_irq(PCIDevice *pci_dev, int level);
> >+int pci_irq_disabled(PCIDevice *d);
> >
> > static inline void pci_irq_assert(PCIDevice *pci_dev)
> > {
> >diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-b=
us.h
> >index 7ab8c9dab0..75d43b508a 100644
> >--- a/include/hw/virtio/virtio-bus.h
> >+++ b/include/hw/virtio/virtio-bus.h
> >@@ -48,7 +48,7 @@ struct VirtioBusClass {
> >     int (*load_done)(DeviceState *d, QEMUFile *f);
> >     int (*load_extra_state)(DeviceState *d, QEMUFile *f);
> >     bool (*has_extra_state)(DeviceState *d);
> >-    bool (*query_guest_notifiers)(DeviceState *d);
> >+    bool (*query_guest_notifiers)(DeviceState *d, int n);
> >     int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
> >     int (*set_host_notifier_mr)(DeviceState *d, int n,
> >                                 MemoryRegion *mr, bool assign);
> >--
> >2.43.5
> >
>

