Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E20EC19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 11:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4fX7-0007r2-V0; Wed, 08 May 2024 07:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4fX5-0007ql-UJ
 for qemu-devel@nongnu.org; Wed, 08 May 2024 07:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4fWv-000867-Lv
 for qemu-devel@nongnu.org; Wed, 08 May 2024 07:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715167929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iEXrr769AeCWP9uV7eTYpMz9BjTkxPnBGaG7tynWfFA=;
 b=M31pVVQf2VpsDVLlkRKmLZYHokBvCX4pDj+p3wPIeyZJslXlN2WPFnUu0fdS3A6s9sAgcp
 AbYEs8BR3DYZ1OiFfyvw+bgFTY9mwOUQ6RBBrbD8uhJiM59Hkx6FhOPhDW/CseuGU7jkAU
 8gSmkp5gY+wZtmaHG3KCCa9a01tNhzE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-fp14U7-MNP2AcDdcnfV6xA-1; Wed, 08 May 2024 07:32:08 -0400
X-MC-Unique: fp14U7-MNP2AcDdcnfV6xA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59caea8836so242889266b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 04:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715167926; x=1715772726;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iEXrr769AeCWP9uV7eTYpMz9BjTkxPnBGaG7tynWfFA=;
 b=ru1XBWBnHKMGeKjfIkoXnPRsiKOxgLhVgARIWcvySsbK5JZZ083kTYvsNaf432EGMx
 +TqtW9MLeSjDwNvOMnV1spes/87kK6Bj5nTA2ZZAJP5kLszyL9YbSgXxwLl/blK2AVtp
 ZIVsLqvQgqnX0XF8GBFNSiqGkadvV/zNFmMWu/oiCozirq4fjphZu0AI0ElY9WXctGC1
 m4HnSMA/UEkl55ZLDV/gXI8mJhWR07epwThC9w8JsTdKKRAsT1PbxkHv7yGGfQjF8XAB
 QUuZ3Yjp3wPXewvtsx11s4zvP2lY8CgdcaJ3rFH2HYARPx93ReQS4ccFAKELqh7JONlD
 rbUQ==
X-Gm-Message-State: AOJu0Yy+H4M3PGix0s/eKuPAVKmOithMau+xXV/46pyn7vQ44JOfLfeJ
 6aXL1QdkpTZAXBPuWFlrHfFREDRDJ2WV/g8NtslHFK0WOPPZw4Vs6q988sT8TNZ2kRYGEsFfmUm
 YYnCZB113c8J8iqksnXuzTZ6/TxsEUG/u22MOT1aJnP/kHKLtd3Fjj0+mzdcpoe39XCnFnijwHv
 68/+zCEZ3AoYKVOCd/2lBCKWCNjrCgTpMX3Art
X-Received: by 2002:a50:c2d2:0:b0:572:8b30:bef7 with SMTP id
 4fb4d7f45d1cf-5731d99aa44mr1568950a12.2.1715167926374; 
 Wed, 08 May 2024 04:32:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZkyz/I0hb6GGtFkj2IL3kMPUp9+jdhkJEKZ7Xxoj/1H+6pinc325rQoatTm18D5tIbgGRZA==
X-Received: by 2002:a50:c2d2:0:b0:572:8b30:bef7 with SMTP id
 4fb4d7f45d1cf-5731d99aa44mr1568937a12.2.1715167925831; 
 Wed, 08 May 2024 04:32:05 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 bd14-20020a056402206e00b00572bd30320esm7497648edb.82.2024.05.08.04.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 04:32:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	mst@redhat.com
Subject: [PATCH] virtio-blk: remove SCSI passthrough functionality
Date: Wed,  8 May 2024 13:32:03 +0200
Message-ID: <20240508113203.36767-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The legacy SCSI passthrough functionality has never been enabled for
VIRTIO 1.0 and was deprecated more than four years ago.

Get rid of it---almost, because QEMU is advertising it unconditionally
for legacy virtio-blk devices.  Just parse the header and return a
nonzero status.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/deprecated.rst       |  10 --
 docs/about/removed-features.rst |   8 ++
 hw/block/virtio-blk.c           | 166 +++-----------------------------
 hw/core/machine.c               |   2 -
 4 files changed, 19 insertions(+), 167 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 03f8b1b655e..9bfaeda3adb 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -282,16 +282,6 @@ Device options
 Emulated device options
 '''''''''''''''''''''''
 
-``-device virtio-blk,scsi=on|off`` (since 5.0)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  VIRTIO 1.0
-and later do not support it because the virtio-scsi device was introduced for
-full SCSI support.  Use virtio-scsi instead when SCSI passthrough is required.
-
-Note this also applies to ``-device virtio-blk-pci,scsi=on|off``, which is an
-alias.
-
 ``-device nvme-ns,eui64-default=on|off`` (since 7.1)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 53ca08aba9c..1044d657c1a 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -505,6 +505,14 @@ configurations (e.g. -smp 8,sockets=0) is removed since 9.0, users have
 to ensure that all the topology members described with -smp are greater
 than zero.
 
+``-device virtio-blk,scsi=on|off`` (since 9.1)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  VIRTIO 1.0
+and later do not support it because the virtio-scsi device was introduced for
+full SCSI support.  Use virtio-scsi instead when SCSI passthrough is required.
+
+
 User-mode emulator command line arguments
 -----------------------------------------
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index bb86e65f652..73bdfd6122a 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -172,57 +172,6 @@ static void virtio_blk_discard_write_zeroes_complete(void *opaque, int ret)
     virtio_blk_free_request(req);
 }
 
-#ifdef __linux__
-
-typedef struct {
-    VirtIOBlockReq *req;
-    struct sg_io_hdr hdr;
-} VirtIOBlockIoctlReq;
-
-static void virtio_blk_ioctl_complete(void *opaque, int status)
-{
-    VirtIOBlockIoctlReq *ioctl_req = opaque;
-    VirtIOBlockReq *req = ioctl_req->req;
-    VirtIOBlock *s = req->dev;
-    VirtIODevice *vdev = VIRTIO_DEVICE(s);
-    struct virtio_scsi_inhdr *scsi;
-    struct sg_io_hdr *hdr;
-
-    scsi = (void *)req->elem.in_sg[req->elem.in_num - 2].iov_base;
-
-    if (status) {
-        status = VIRTIO_BLK_S_UNSUPP;
-        virtio_stl_p(vdev, &scsi->errors, 255);
-        goto out;
-    }
-
-    hdr = &ioctl_req->hdr;
-    /*
-     * From SCSI-Generic-HOWTO: "Some lower level drivers (e.g. ide-scsi)
-     * clear the masked_status field [hence status gets cleared too, see
-     * block/scsi_ioctl.c] even when a CHECK_CONDITION or COMMAND_TERMINATED
-     * status has occurred.  However they do set DRIVER_SENSE in driver_status
-     * field. Also a (sb_len_wr > 0) indicates there is a sense buffer.
-     */
-    if (hdr->status == 0 && hdr->sb_len_wr > 0) {
-        hdr->status = CHECK_CONDITION;
-    }
-
-    virtio_stl_p(vdev, &scsi->errors,
-                 hdr->status | (hdr->msg_status << 8) |
-                 (hdr->host_status << 16) | (hdr->driver_status << 24));
-    virtio_stl_p(vdev, &scsi->residual, hdr->resid);
-    virtio_stl_p(vdev, &scsi->sense_len, hdr->sb_len_wr);
-    virtio_stl_p(vdev, &scsi->data_len, hdr->dxfer_len);
-
-out:
-    virtio_blk_req_complete(req, status);
-    virtio_blk_free_request(req);
-    g_free(ioctl_req);
-}
-
-#endif
-
 static VirtIOBlockReq *virtio_blk_get_request(VirtIOBlock *s, VirtQueue *vq)
 {
     VirtIOBlockReq *req = virtqueue_pop(vq, sizeof(VirtIOBlockReq));
@@ -233,20 +182,14 @@ static VirtIOBlockReq *virtio_blk_get_request(VirtIOBlock *s, VirtQueue *vq)
     return req;
 }
 
-static int virtio_blk_handle_scsi_req(VirtIOBlockReq *req)
+static void virtio_blk_handle_scsi(VirtIOBlockReq *req)
 {
-    int status = VIRTIO_BLK_S_OK;
-    struct virtio_scsi_inhdr *scsi = NULL;
+    int status;
+    struct virtio_scsi_inhdr *scsi;
     VirtIOBlock *blk = req->dev;
     VirtIODevice *vdev = VIRTIO_DEVICE(blk);
     VirtQueueElement *elem = &req->elem;
 
-#ifdef __linux__
-    int i;
-    VirtIOBlockIoctlReq *ioctl_req;
-    BlockAIOCB *acb;
-#endif
-
     /*
      * We require at least one output segment each for the virtio_blk_outhdr
      * and the SCSI command block.
@@ -262,95 +205,16 @@ static int virtio_blk_handle_scsi_req(VirtIOBlockReq *req)
     /*
      * The scsi inhdr is placed in the second-to-last input segment, just
      * before the regular inhdr.
+     *
+     * Just put anything nonzero so that the ioctl fails in the guest.
      */
     scsi = (void *)elem->in_sg[elem->in_num - 2].iov_base;
-
-    if (!virtio_has_feature(blk->host_features, VIRTIO_BLK_F_SCSI)) {
-        status = VIRTIO_BLK_S_UNSUPP;
-        goto fail;
-    }
-
-    /*
-     * No support for bidirection commands yet.
-     */
-    if (elem->out_num > 2 && elem->in_num > 3) {
-        status = VIRTIO_BLK_S_UNSUPP;
-        goto fail;
-    }
-
-#ifdef __linux__
-    ioctl_req = g_new0(VirtIOBlockIoctlReq, 1);
-    ioctl_req->req = req;
-    ioctl_req->hdr.interface_id = 'S';
-    ioctl_req->hdr.cmd_len = elem->out_sg[1].iov_len;
-    ioctl_req->hdr.cmdp = elem->out_sg[1].iov_base;
-    ioctl_req->hdr.dxfer_len = 0;
-
-    if (elem->out_num > 2) {
-        /*
-         * If there are more than the minimally required 2 output segments
-         * there is write payload starting from the third iovec.
-         */
-        ioctl_req->hdr.dxfer_direction = SG_DXFER_TO_DEV;
-        ioctl_req->hdr.iovec_count = elem->out_num - 2;
-
-        for (i = 0; i < ioctl_req->hdr.iovec_count; i++) {
-            ioctl_req->hdr.dxfer_len += elem->out_sg[i + 2].iov_len;
-        }
-
-        ioctl_req->hdr.dxferp = elem->out_sg + 2;
-
-    } else if (elem->in_num > 3) {
-        /*
-         * If we have more than 3 input segments the guest wants to actually
-         * read data.
-         */
-        ioctl_req->hdr.dxfer_direction = SG_DXFER_FROM_DEV;
-        ioctl_req->hdr.iovec_count = elem->in_num - 3;
-        for (i = 0; i < ioctl_req->hdr.iovec_count; i++) {
-            ioctl_req->hdr.dxfer_len += elem->in_sg[i].iov_len;
-        }
-
-        ioctl_req->hdr.dxferp = elem->in_sg;
-    } else {
-        /*
-         * Some SCSI commands don't actually transfer any data.
-         */
-        ioctl_req->hdr.dxfer_direction = SG_DXFER_NONE;
-    }
-
-    ioctl_req->hdr.sbp = elem->in_sg[elem->in_num - 3].iov_base;
-    ioctl_req->hdr.mx_sb_len = elem->in_sg[elem->in_num - 3].iov_len;
-
-    acb = blk_aio_ioctl(blk->blk, SG_IO, &ioctl_req->hdr,
-                        virtio_blk_ioctl_complete, ioctl_req);
-    if (!acb) {
-        g_free(ioctl_req);
-        status = VIRTIO_BLK_S_UNSUPP;
-        goto fail;
-    }
-    return -EINPROGRESS;
-#else
-    abort();
-#endif
+    virtio_stl_p(vdev, &scsi->errors, 255);
+    status = VIRTIO_BLK_S_UNSUPP;
 
 fail:
-    /* Just put anything nonzero so that the ioctl fails in the guest.  */
-    if (scsi) {
-        virtio_stl_p(vdev, &scsi->errors, 255);
-    }
-    return status;
-}
-
-static void virtio_blk_handle_scsi(VirtIOBlockReq *req)
-{
-    int status;
-
-    status = virtio_blk_handle_scsi_req(req);
-    if (status != -EINPROGRESS) {
-        virtio_blk_req_complete(req, status);
-        virtio_blk_free_request(req);
-    }
+    virtio_blk_req_complete(req, status);
+    virtio_blk_free_request(req);
 }
 
 static inline void submit_requests(VirtIOBlock *s, MultiReqBuffer *mrb,
@@ -1379,13 +1243,9 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
     virtio_add_feature(&features, VIRTIO_BLK_F_GEOMETRY);
     virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
     virtio_add_feature(&features, VIRTIO_BLK_F_BLK_SIZE);
-    if (virtio_has_feature(features, VIRTIO_F_VERSION_1)) {
-        if (virtio_has_feature(s->host_features, VIRTIO_BLK_F_SCSI)) {
-            error_setg(errp, "Please set scsi=off for virtio-blk devices in order to use virtio 1.0");
-            return 0;
-        }
-    } else {
+    if (!virtio_has_feature(features, VIRTIO_F_VERSION_1)) {
         virtio_clear_feature(&features, VIRTIO_F_ANY_LAYOUT);
+        /* Added for historical reasons, removing it could break migration.  */
         virtio_add_feature(&features, VIRTIO_BLK_F_SCSI);
     }
 
@@ -2132,10 +1992,6 @@ static Property virtio_blk_properties[] = {
     DEFINE_PROP_STRING("serial", VirtIOBlock, conf.serial),
     DEFINE_PROP_BIT64("config-wce", VirtIOBlock, host_features,
                       VIRTIO_BLK_F_CONFIG_WCE, true),
-#ifdef __linux__
-    DEFINE_PROP_BIT64("scsi", VirtIOBlock, host_features,
-                      VIRTIO_BLK_F_SCSI, false),
-#endif
     DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
                     true),
     DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues,
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4ff60911e74..8cbbd529845 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -264,8 +264,6 @@ GlobalProperty hw_compat_2_5[] = {
 const size_t hw_compat_2_5_len = G_N_ELEMENTS(hw_compat_2_5);
 
 GlobalProperty hw_compat_2_4[] = {
-    /* Optional because the 'scsi' property is Linux-only */
-    { "virtio-blk-device", "scsi", "true", .optional = true },
     { "e1000", "extra_mac_registers", "off" },
     { "virtio-pci", "x-disable-pcie", "on" },
     { "virtio-pci", "migrate-extra", "off" },
-- 
2.45.0


