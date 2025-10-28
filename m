Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA54BCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 14:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDkeZ-0000dr-8u; Tue, 28 Oct 2025 10:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDkeY-0000dP-32
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDkeO-0002af-E6
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761661570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1mGcZWfNuO5W9crD/F+xOnmXUgISDsSAYf26frYiRAQ=;
 b=cHShoxjh2NRESUgu0zmQnHYcp9w/Ueok7/tAfc214ZgmMxIkl175GrP01JUI7zGFUvrSGE
 Ok7Q0jQichdffBHTqRdI+hDbxsKWApFQwiQXdkrDBaMygHnmCdqaMsSCa2vlqgkIasdSYi
 Sw6a7BqUZHtDO+34StXMkmmf1D+1b/w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-JnhFO7QVOda2RvEdLcKPhQ-1; Tue, 28 Oct 2025 10:26:09 -0400
X-MC-Unique: JnhFO7QVOda2RvEdLcKPhQ-1
X-Mimecast-MFC-AGG-ID: JnhFO7QVOda2RvEdLcKPhQ_1761661569
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8a65ae81248so453011385a.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 07:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761661569; x=1762266369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mGcZWfNuO5W9crD/F+xOnmXUgISDsSAYf26frYiRAQ=;
 b=FEpjHZnqjW1GpWe40KvfOtQf1JvJM5ivriKOM36aYeJ6CZcof/hvjL4wPhg9GvVStr
 SLVqif0dq+zlrxl0lL8rqa4yI5Mc9O8/3fsucUCBY/yqovMdwwhMjjI3x3AS65k9b2DO
 slDKypc9peu9alG7MCyTGcanTVz5WsXM5EEWO7ATNrdMhIGsWa7ZQO2EcRD04ZsQsMyA
 ofalAdgyUwHVmazQCFGjEuGuRf7gkmVfmFu7S3q+EH1LE6SYk8wbnfmItdW3uw3bu6Sf
 8a1IM8ZFXOxqU1aFYUOwaFWlJ4UxWxGhp7xxnIArV99sFjmitm4v86Csv8dQSddSBZKP
 BiHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPp9m3AR0BlZ3Ghfue5ECTHMLBFVUFuV/SH+n2jbd/gvV8VaDczfQxWJHX1W3m09JrW7xoaYV/t6BC@nongnu.org
X-Gm-Message-State: AOJu0YwDk/E3mPSj5WHe1YH0A/yXw4X1CeLczxokJkm4vH+GKtT5qYo3
 jec8Kv4GNChH1dhDGorbHWsfj6B8asxymOzzbImnBDLp3ey7rONIKOiXenCBzI/gIC1v9V8Mmur
 U2wcZpp4zXiyC6dZvnldsXANuoDiw7xx//BH0yHFvKdBDBjssIEHYcyD3
X-Gm-Gg: ASbGnctEuAEYRvRb5iI7D4z9hS0UWV3OKLYY0W89OR7ejXvejaf9zdk8A91/9IizMbV
 LzWPCR2VoAmpbP4myh7xqw+YFx+QbouM2reURLOyV2ugv2DzxHL10Kup1MG7esa3PJSx1A6naVC
 8VvktVZ9FEoubvEXy+yIzTXOCtGlscJkh5SDRJBgOWUY8P/gnTgqfbQ7Rgmz1R9V8M9C3GLrGbx
 KVW6J3K4cRhx6QD3XOW3+f/lpGMy+6sNVmkZxcUE9kSeYrKtBleqcW8cL/dWvEW0YFFiL/MuKs9
 1GtDTt4KSuxz1XfC3ICzbasxWjDKKRRadRD4TtlFntHHfvU5pyy30ZmvkopLjq6ucRk=
X-Received: by 2002:a05:620a:4711:b0:856:60d8:3688 with SMTP id
 af79cd13be357-8a6f78fc5eemr456733085a.47.1761661568801; 
 Tue, 28 Oct 2025 07:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGom8WWaQjvwbHzaKMOe4H/MR1y6xlMUehxTRbeI2ZRTkKWNmnC3c+8IR5sgoOUuVVvVn78FQ==
X-Received: by 2002:a05:620a:4711:b0:856:60d8:3688 with SMTP id
 af79cd13be357-8a6f78fc5eemr456728885a.47.1761661568306; 
 Tue, 28 Oct 2025 07:26:08 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fc4csm824278985a.10.2025.10.28.07.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 07:26:06 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:26:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 1/2] migration: Fix regression of passing error_fatal
 into vmstate_load_state()
Message-ID: <aQDSey6h4WIyt0yi@x1.local>
References: <20251028-solve_error_fatal_regression-v2-0-dab24c808a28@redhat.com>
 <20251028-solve_error_fatal_regression-v2-1-dab24c808a28@redhat.com>
 <fba2c2bb-09b8-450a-b4a1-7ecbb997cfff@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fba2c2bb-09b8-450a-b4a1-7ecbb997cfff@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Oct 28, 2025 at 03:42:54PM +0900, Akihiko Odaki wrote:
> On 2025/10/28 15:21, Arun Menon wrote:
> > error_fatal is passed to vmstate_load_state() and vmstate_save_state()
> > functions. This was introduced in commit c632ffbd74. This would exit(1)
> > on error, and therefore does not allow to propagate the error back to
> > the caller.
> > 
> > To maintain consistency with prior error handling i.e. either propagating
> > the error to the caller or reporting it, we must set the error within a
> > local Error object instead of using error_fatal.
> > 
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   hw/display/virtio-gpu.c | 19 ++++++++++++++-----
> >   hw/pci/pci.c            | 13 +++++++++++--
> >   hw/s390x/virtio-ccw.c   | 15 +++++++++++++--
> >   hw/scsi/spapr_vscsi.c   |  9 +++++++--
> >   hw/virtio/virtio-mmio.c | 15 +++++++++++++--
> >   hw/virtio/virtio-pci.c  | 15 +++++++++++++--
> >   hw/virtio/virtio.c      | 10 +++++++---
> >   7 files changed, 78 insertions(+), 18 deletions(-)
> > 
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 3a555125be60aa4c243cfb870caa517995de8183..63263ecc5bda889e5327aa59ada53cb41b0219cb 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -1225,7 +1225,9 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
> >   {
> >       VirtIOGPU *g = opaque;
> >       struct virtio_gpu_simple_resource *res;
> > +    Error *err = NULL;
> >       int i;
> > +    int ret = 0;
> 
> I prefer not to have a variable initialized unless necessary because it
> suppresses compiler warnings to tell accidental usage of variable.
> 
> Besides, the code change for other files in this patch and the existing code
> in this file doesn't initialize such variables, making the code style
> inconsistent.
> 
> That said, I feel it is too nitpicky so I give:
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> You may or may not resend this patch to drop the initialization.

I'll fix it when queuing, thanks both.

While at it, I also touched a few other things on reordering of vars
(follow rev-christmas tree), spacing, etc.  The fixup is attached at the
end.  Please shoot if anyone disagrees.

I'll skip patch 2 because we already have a fix here:

https://lore.kernel.org/r/20251021220407.2662288-2-peterx@redhat.com

Thanks,

===8<===

From 3cd8f712b5d18b3729dc78127598ebbb2b1afae2 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 28 Oct 2025 10:23:35 -0400
Subject: [PATCH] fixup! migration: Fix regression of passing error_fatal into
 vmstate_load_state()

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/display/virtio-gpu.c | 6 ++----
 hw/pci/pci.c            | 5 +++--
 hw/s390x/virtio-ccw.c   | 6 ++++--
 hw/scsi/spapr_vscsi.c   | 3 ++-
 hw/virtio/virtio-mmio.c | 2 +-
 hw/virtio/virtio-pci.c  | 4 ++--
 6 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 63263ecc5b..43e88a4daf 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1226,8 +1226,7 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
     VirtIOGPU *g = opaque;
     struct virtio_gpu_simple_resource *res;
     Error *err = NULL;
-    int i;
-    int ret = 0;
+    int i, ret;
 
     /* in 2d mode we should never find unprocessed commands here */
     assert(QTAILQ_EMPTY(&g->cmdq));
@@ -1294,8 +1293,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
     Error *err = NULL;
     struct virtio_gpu_simple_resource *res;
     uint32_t resource_id, pformat;
-    int i;
-    int ret = 0;
+    int i, ret;
 
     g->hostmem = 0;
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0090c72560..ac16c9521d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -921,12 +921,13 @@ const VMStateDescription vmstate_pci_device = {
 
 void pci_device_save(PCIDevice *s, QEMUFile *f)
 {
+    Error *local_err = NULL;
+    int ret;
+
     /* Clear interrupt status bit: it is implicit
      * in irq_state which we are saving.
      * This makes us compatible with old devices
      * which never set or clear this bit. */
-    int ret;
-    Error *local_err = NULL;
     s->config[PCI_STATUS] &= ~PCI_STATUS_INTERRUPT;
     ret = vmstate_save_state(f, &vmstate_pci_device, s, NULL, &local_err);
     if (ret < 0) {
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 41c7d62a48..4a3ffb84f8 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1130,8 +1130,9 @@ static int virtio_ccw_load_queue(DeviceState *d, int n, QEMUFile *f)
 static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
-    int ret;
     Error *local_err = NULL;
+    int ret;
+
     ret = vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
@@ -1141,8 +1142,9 @@ static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
 static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
-    int ret;
     Error *local_err = NULL;
+    int ret;
+
     ret = vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index af4debc2f8..a6591319db 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -628,8 +628,9 @@ static const VMStateDescription vmstate_spapr_vscsi_req = {
 static void vscsi_save_request(QEMUFile *f, SCSIRequest *sreq)
 {
     vscsi_req *req = sreq->hba_private;
-    int rc;
     Error *local_err = NULL;
+    int rc;
+
     assert(req->active);
 
     rc = vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL, &local_err);
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index ffdda63e27..c05c00bcd4 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -624,8 +624,8 @@ static void virtio_mmio_save_extra_state(DeviceState *opaque, QEMUFile *f)
 static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
-    int ret;
     Error *local_err = NULL;
+    int ret;
 
     ret = vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &local_err);
     if (ret < 0) {
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index f245f5c3c5..99cb30fe59 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -187,8 +187,8 @@ static bool virtio_pci_has_extra_state(DeviceState *d)
 static void virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
-    int ret;
     Error *local_err = NULL;
+    int ret;
 
     ret = vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL, &local_err);
     if (ret < 0) {
@@ -199,8 +199,8 @@ static void virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f)
 static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
-    int ret;
     Error *local_err = NULL;
+    int ret;
 
     ret = vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &local_err);
     if (ret < 0) {
-- 
2.50.1


-- 
Peter Xu


