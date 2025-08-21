Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A15CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0zf-0003Cz-P6; Thu, 21 Aug 2025 04:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0yu-0001AS-OJ
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0yk-0001l3-0H
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755766138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C4oZ8mxd6KAk7AZUwmcSjbaAZroQn45DoBd6PXtscss=;
 b=a5Bd7Io7FEarZYsZk2tbNwJjojnmezeTN5kkAm9+QNueW866ElArmpi8nEmfXJvGl8aFJY
 rOaTmgcyehsa0JVcFiGgeFmnKD7alvYDZY1CNkHsTwzYl/HVB68gCUIHPr+z22MLBtVdFM
 GN32HHlrWIFCxubc+4iga42g3PiifqQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-gY65hfuKPqWeTfeUOrFkrw-1; Thu, 21 Aug 2025 04:48:56 -0400
X-MC-Unique: gY65hfuKPqWeTfeUOrFkrw-1
X-Mimecast-MFC-AGG-ID: gY65hfuKPqWeTfeUOrFkrw_1755766136
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b474b68cff7so688045a12.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755766132; x=1756370932;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4oZ8mxd6KAk7AZUwmcSjbaAZroQn45DoBd6PXtscss=;
 b=NgnzsfSGnmdGf4d3bpp8iPjthp8PD19p7p9sVE3QI2FNIpxAVtMowExSPuKQ4Bsk8i
 79i3pq7dwSMWz212fX8iVmN5qR/0ALRR82bis7KsmOckbhgr9xyk6k929CLIQHztqknt
 ahGGKGM8lHhpEhNaJMvKEHY/YscjeCMeGxR9aflV9FttBFCmw2iKt1WL93CvQx3Fjupc
 EK0W86ZIjHRNUW+NlcmbjSgLx4LHudpcckcv1z+FRvlQzKJsoLQcuUHy9NIka06zrMnr
 ACLRXTAbANL6aYz9Dd5KV1AaqHyri55qYa+j5O7+Sz4l8AekSvSDIrL5cUyjJwAGD69v
 4knQ==
X-Gm-Message-State: AOJu0YzGZbJtG9J+geQd0iFxwF8xI+MHvekNad835mSRV5i/hMq0pbnX
 JPKvDAeFpmUVmx6iGrrV/t1hoHWQwW0HmYd6WsFkYcxahmfbuPo9GEYzSbQfBjQuTPu0bCX22+Z
 g9rngbCP8z5mxHK2DWVm5OdnY4k0OYVEP0o0kw8lLJZwQoWWtIXRsC/8m
X-Gm-Gg: ASbGncsgXkPS+VzxE57yppr7i5TfApDXGRF/h7/9QLcqriqaaVB0nFolJF9hxy62Gti
 x2Z4o1UqAvOAqVjyr7U6M4RH8SKdYCYUVjgaxEizAumQxws2DE5jbQ0cjC3vfCzHLBinub2aoXj
 QJDAlXW7CnUT1RvlpYjw4BNstr/VNtutYY63u9w3IlP6+PW9fv6FLdP2o9XgKpDw6ZtRsp73Lru
 HNvgE3kop28U3APQ7t7ekuxM6CUaS1wEoBYUtfScrKOTBlOMjjM8ev0yml18FwXNdsZzLtZ/G/f
 piujuSOPCEBrzJ/MEgcwMTcGJ5VhWK3p3d5oleQeunJxccXyaYzI
X-Received: by 2002:a17:902:e74a:b0:240:9ff:d546 with SMTP id
 d9443c01a7336-245febef131mr27186535ad.6.1755766131753; 
 Thu, 21 Aug 2025 01:48:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErEJ+hn1YEBK1qy70quzUOYFEIi3mJ0SOhFG1Xwa1OjxcoQiopz0Twir9LYhPJhAzWcmVviw==
X-Received: by 2002:a17:902:e74a:b0:240:9ff:d546 with SMTP id
 d9443c01a7336-245febef131mr27185945ad.6.1755766131077; 
 Thu, 21 Aug 2025 01:48:51 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:48:50 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:14:18 +0530
Subject: [PATCH v12 24/27] migration: Remove error variant of
 vmstate_save_state() function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-propagate_tpm_error-v12-24-72b803e707dc@redhat.com>
References: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
In-Reply-To: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17961; i=armenon@redhat.com;
 h=from:subject:message-id; bh=/s/cuzwco7b+2YPmQUpSMmbH2Kdk7Fa5fcCzhZGbSK4=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayO6k9dfyuhdKSjVlZj1cGrtuZK+q0J1Vwb+16fS/XW
 ewKgQodpSwMYlwMsmKKLA1fA2SbAgojIm1fXoeZw8oEMoSBi1MAJrKth5Hhvfj+kmWd7af2OrA/
 nZkgeuqEV84drt71QkxrzIIN5TllGf7Znn389qmrxP/jsR7HL6tMr1zS4n3m5T/JKSIVC28b7y9
 lAAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This commit removes the redundant vmstate_save_state_with_err()
function.

Previously, commit 969298f9d7 introduced vmstate_save_state_with_err()
to handle error propagation, while vmstate_save_state() existed for
non-error scenarios.
This is because there were code paths where vmstate_save_state_v()
(called internally by vmstate_save_state) did not explicitly set
errors on failure.

This change unifies error handling by
 - updating vmstate_save_state() to accept an Error **errp argument.
 - vmstate_save_state_v() ensures errors are set directly within the errp
   object, eliminating the need for two separate functions.

All calls to vmstate_save_state_with_err() are replaced with
vmstate_save_state(). This simplifies the API and improves code
maintainability.

vmstate_save_state() that only calls vmstate_save_state_v(),
by inference, also has errors set in errp in case of failure.
The errors are reported using warn_report_err().
If we want the function to exit on error, then &error_fatal is
passed.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 hw/display/virtio-gpu.c     |  3 ++-
 hw/pci/pci.c                |  2 +-
 hw/s390x/virtio-ccw.c       |  2 +-
 hw/scsi/spapr_vscsi.c       |  2 +-
 hw/vfio/pci.c               |  4 ++--
 hw/virtio/virtio-mmio.c     |  2 +-
 hw/virtio/virtio-pci.c      |  2 +-
 hw/virtio/virtio.c          |  6 ++++--
 include/migration/vmstate.h |  2 --
 migration/cpr.c             |  3 +--
 migration/savevm.c          | 11 ++++++++---
 migration/vmstate-types.c   | 23 ++++++++++++++++++-----
 migration/vmstate.c         | 10 ++--------
 tests/unit/test-vmstate.c   | 20 +++++++++++++++++---
 ui/vdagent.c                |  3 ++-
 15 files changed, 61 insertions(+), 34 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5dc31bc6bfb0272e29a4364ab10de2595a4bedf7..477ec700a130d77ad93346c264bb7eaa8bca76d5 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1246,7 +1246,8 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
     }
     qemu_put_be32(f, 0); /* end of list */
 
-    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL);
+    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL,
+                              &error_fatal);
 }
 
 static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 6be932d3bb67ff0c4808707db2a7b6378a90e82b..e53fd270118293ca82f40d45d8f97f62612736a1 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -926,7 +926,7 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
      * This makes us compatible with old devices
      * which never set or clear this bit. */
     s->config[PCI_STATUS] &= ~PCI_STATUS_INTERRUPT;
-    vmstate_save_state(f, &vmstate_pci_device, s, NULL);
+    vmstate_save_state(f, &vmstate_pci_device, s, NULL, &error_fatal);
     /* Restore the interrupt status bit. */
     pci_update_irq_status(s);
 }
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 6a9641a03d5d3a38a4de7ceb9deffc0cc303bcff..4cb1ced001ae241c53c503ebfd7c90e336799c37 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1130,7 +1130,7 @@ static int virtio_ccw_load_queue(DeviceState *d, int n, QEMUFile *f)
 static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
-    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL);
+    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL, &error_fatal);
 }
 
 static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 8622419497db650523d51bcb41557bbca254eaa3..026657c85f3bd2629165add466b20c85b3521f1e 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -630,7 +630,7 @@ static void vscsi_save_request(QEMUFile *f, SCSIRequest *sreq)
     vscsi_req *req = sreq->hba_private;
     assert(req->active);
 
-    vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL);
+    vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL, &error_fatal);
 
     trace_spapr_vscsi_save_request(req->qtag, req->cur_desc_num,
                                    req->cur_desc_offset);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a65e34b6979eadfa0851666aeae7cf731a00fa40..d931fd1d84239c1775677683b6d92475c385c540 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2780,8 +2780,8 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
-    return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config, vdev, NULL,
-                                       errp);
+    return vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL,
+                              errp);
 }
 
 static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 0a688909fc606a3c9fde933667ae8c309ab527d0..fb58c36452730cfc92a0d26ff13e01e2d6654960 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -613,7 +613,7 @@ static void virtio_mmio_save_extra_state(DeviceState *opaque, QEMUFile *f)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
 
-    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL);
+    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL, &error_fatal);
 }
 
 static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b04faa1e5c91b5cef40e54ec41d92422d16bfc13..d2595fbd55151aba2579bb01a59577c1a40b71e0 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -154,7 +154,7 @@ static void virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
 
-    vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL);
+    vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL, &error_fatal);
 }
 
 static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 419f3516c9f0a3df43831eebc77aa1e6dfcd0f41..4a8d26c202bdda7ee64f2d4a983da0d6ceb2f6f6 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2992,6 +2992,7 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint32_t guest_features_lo = (vdev->guest_features & 0xffffffff);
     int i;
+    Error *local_err = NULL;
 
     if (k->save_config) {
         k->save_config(qbus->parent, f);
@@ -3035,14 +3036,15 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
     }
 
     if (vdc->vmsd) {
-        int ret = vmstate_save_state(f, vdc->vmsd, vdev, NULL);
+        int ret = vmstate_save_state(f, vdc->vmsd, vdev, NULL, &local_err);
         if (ret) {
+            warn_report_err(local_err);
             return ret;
         }
     }
 
     /* Subsections */
-    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
+    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL, &error_fatal);
 }
 
 /* A wrapper for use as a VMState .put function */
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 056781b1c21e737583f081594d9f88b32adfd674..5fe9bbf39058d0cf97c1adab54cc516dbe8dc32a 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1198,8 +1198,6 @@ extern const VMStateInfo vmstate_info_qlist;
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp);
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, JSONWriter *vmdesc);
-int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc, Error **errp);
 int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                          void *opaque, JSONWriter *vmdesc,
diff --git a/migration/cpr.c b/migration/cpr.c
index 8abb6db76d2474157f804ece4c35ebfc8c22d21a..038f48f810aceb66d7988852240e2e5d9840ad1a 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -182,9 +182,8 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
     qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
     qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
 
-    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0);
+    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0, errp);
     if (ret) {
-        error_setg(errp, "vmstate_save_state error %d", ret);
         qemu_fclose(f);
         return ret;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index 2e2b38def670d7d5cadbb9665d0b19b008a0a373..46339b4944f0350024c130aba872483d0988fea5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1056,8 +1056,8 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc,
     if (!se->vmsd) {
         vmstate_save_old_style(f, se, vmdesc);
     } else {
-        ret = vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmdesc,
-                                          errp);
+        ret = vmstate_save_state(f, se->vmsd, se->opaque, vmdesc,
+                                 errp);
         if (ret) {
             return ret;
         }
@@ -1285,6 +1285,7 @@ void qemu_savevm_state_header(QEMUFile *f)
 {
     MigrationState *s = migrate_get_current();
     JSONWriter *vmdesc = s->vmdesc;
+    Error *local_err = NULL;
 
     trace_savevm_state_header();
     qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
@@ -1303,7 +1304,11 @@ void qemu_savevm_state_header(QEMUFile *f)
             json_writer_start_object(vmdesc, "configuration");
         }
 
-        vmstate_save_state(f, &vmstate_configuration, &savevm_state, vmdesc);
+        vmstate_save_state(f, &vmstate_configuration, &savevm_state,
+                           vmdesc, &local_err);
+        if (local_err) {
+            warn_report_err(local_err);
+        }
 
         if (vmdesc) {
             json_writer_end_object(vmdesc);
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index f41670cc853c5b41ccc8def354886a8e5c1451fd..a06364f68bca7b140c695af6b9fb75563b9fdfff 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -565,10 +565,14 @@ static int put_tmp(QEMUFile *f, void *pv, size_t size,
     const VMStateDescription *vmsd = field->vmsd;
     void *tmp = g_malloc(size);
     int ret;
+    Error *local_err = NULL;
 
     /* Writes the parent field which is at the start of the tmp */
     *(void **)tmp = pv;
-    ret = vmstate_save_state(f, vmsd, tmp, vmdesc);
+    ret = vmstate_save_state(f, vmsd, tmp, vmdesc, &local_err);
+    if (ret) {
+        warn_report_err(local_err);
+    }
     g_free(tmp);
 
     return ret;
@@ -676,13 +680,15 @@ static int put_qtailq(QEMUFile *f, void *pv, size_t unused_size,
     size_t entry_offset = field->start;
     void *elm;
     int ret;
+    Error *local_err = NULL;
 
     trace_put_qtailq(vmsd->name, vmsd->version_id);
 
     QTAILQ_RAW_FOREACH(elm, pv, entry_offset) {
         qemu_put_byte(f, true);
-        ret = vmstate_save_state(f, vmsd, elm, vmdesc);
+        ret = vmstate_save_state(f, vmsd, elm, vmdesc, &local_err);
         if (ret) {
+            warn_report_err(local_err);
             return ret;
         }
     }
@@ -711,6 +717,7 @@ static gboolean put_gtree_elem(gpointer key, gpointer value, gpointer data)
     struct put_gtree_data *capsule = (struct put_gtree_data *)data;
     QEMUFile *f = capsule->f;
     int ret;
+    Error *local_err = NULL;
 
     qemu_put_byte(f, true);
 
@@ -718,16 +725,20 @@ static gboolean put_gtree_elem(gpointer key, gpointer value, gpointer data)
     if (!capsule->key_vmsd) {
         qemu_put_be64(f, (uint64_t)(uintptr_t)(key)); /* direct key */
     } else {
-        ret = vmstate_save_state(f, capsule->key_vmsd, key, capsule->vmdesc);
+        ret = vmstate_save_state(f, capsule->key_vmsd, key, capsule->vmdesc,
+                                 &local_err);
         if (ret) {
+            warn_report_err(local_err);
             capsule->ret = ret;
             return true;
         }
     }
 
     /* put the data */
-    ret = vmstate_save_state(f, capsule->val_vmsd, value, capsule->vmdesc);
+    ret = vmstate_save_state(f, capsule->val_vmsd, value, capsule->vmdesc,
+                             &local_err);
     if (ret) {
+        warn_report_err(local_err);
         capsule->ret = ret;
         return true;
     }
@@ -861,14 +872,16 @@ static int put_qlist(QEMUFile *f, void *pv, size_t unused_size,
     size_t entry_offset = field->start;
     void *elm;
     int ret;
+    Error *local_err = NULL;
 
     trace_put_qlist(field->name, vmsd->name, vmsd->version_id);
     QLIST_RAW_FOREACH(elm, pv, entry_offset) {
         qemu_put_byte(f, true);
-        ret = vmstate_save_state(f, vmsd, elm, vmdesc);
+        ret = vmstate_save_state(f, vmsd, elm, vmdesc, &local_err);
         if (ret) {
             error_report("%s: failed to save %s (%d)", field->name,
                          vmsd->name, ret);
+            warn_report_err(local_err);
             return ret;
         }
     }
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 6324e5b17addcd1b4f2fcdddbd47c3e4befc1d50..93b703cd61d811875e05880714a0d5113a4136d4 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -410,12 +410,6 @@ bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque)
 
 
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, JSONWriter *vmdesc_id)
-{
-    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, NULL);
-}
-
-int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc_id, Error **errp)
 {
     return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, errp);
@@ -516,7 +510,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
                 if (inner_field->flags & VMS_STRUCT) {
                     ret = vmstate_save_state(f, inner_field->vmsd,
-                                             curr_elem, vmdesc_loop);
+                                             curr_elem, vmdesc_loop, errp);
                 } else if (inner_field->flags & VMS_VSTRUCT) {
                     ret = vmstate_save_state_v(f, inner_field->vmsd,
                                                curr_elem, vmdesc_loop,
@@ -678,7 +672,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
             qemu_put_byte(f, len);
             qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
             qemu_put_be32(f, vmsdsub->version_id);
-            ret = vmstate_save_state_with_err(f, vmsdsub, opaque, vmdesc, errp);
+            ret = vmstate_save_state(f, vmsdsub, opaque, vmdesc, errp);
             if (ret) {
                 return ret;
             }
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index cfab58c7f45ba50f70af164c3e58b01aaf9cc656..0137eb9f606680ccc6d006f100233b6cd30275b5 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -67,9 +67,13 @@ static QEMUFile *open_test_file(bool write)
 static void save_vmstate(const VMStateDescription *desc, void *obj)
 {
     QEMUFile *f = open_test_file(true);
+    Error *local_err = NULL;
 
     /* Save file with vmstate */
-    int ret = vmstate_save_state(f, desc, obj, NULL);
+    int ret = vmstate_save_state(f, desc, obj, NULL, &local_err);
+    if (ret) {
+        warn_report_err(local_err);
+    }
     g_assert(!ret);
     qemu_put_byte(f, QEMU_VM_EOF);
     g_assert(!qemu_file_get_error(f));
@@ -438,10 +442,15 @@ static const VMStateDescription vmstate_skipping = {
 
 static void test_save_noskip(void)
 {
+    Error *local_err = NULL;
     QEMUFile *fsave = open_test_file(true);
     TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
                        .skip_c_e = false };
-    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
+    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL,
+                                 &local_err);
+    if (ret) {
+        warn_report_err(local_err);
+    }
     g_assert(!ret);
     g_assert(!qemu_file_get_error(fsave));
 
@@ -460,10 +469,15 @@ static void test_save_noskip(void)
 
 static void test_save_skip(void)
 {
+    Error *local_err = NULL;
     QEMUFile *fsave = open_test_file(true);
     TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
                        .skip_c_e = true };
-    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
+    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL,
+                                 &local_err);
+    if (ret) {
+        warn_report_err(local_err);
+    }
     g_assert(!ret);
     g_assert(!qemu_file_get_error(fsave));
 
diff --git a/ui/vdagent.c b/ui/vdagent.c
index bec728668de4d2410c3b741bcb0a21deb373dcd3..08b645fa0ba07506aba3aa90a5cf356ad6fb359f 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -992,7 +992,8 @@ static int put_cbinfo(QEMUFile *f, void *pv, size_t size,
         }
     }
 
-    return vmstate_save_state(f, &vmstate_cbinfo_array, &cbinfo, vmdesc);
+    return vmstate_save_state(f, &vmstate_cbinfo_array, &cbinfo, vmdesc,
+                              &error_fatal);
 }
 
 static int get_cbinfo(QEMUFile *f, void *pv, size_t size,

-- 
2.50.1


