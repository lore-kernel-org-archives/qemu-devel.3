Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ED1606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=HJGnH4Lq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI0Z-000173-Hg; Fri, 23 Oct 2026 12:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xKI01-0008IW-MD
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:11 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xKHzy-0002iy-JR
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:09 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso693104f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1792772405; x=1793377205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dKo1kqddUpLDSrGeTLF/PFAH7ID1KB9sJ3DC+s5Jzoc=;
 b=HJGnH4Lqdy8Nta97e1JpN7Rds0AuSQYS5ncY2psocbHt/FxzMW6LV7RVtMCTeL0uJc
 yryiuF+t6PHYL8eDQaxwXPblOCws8GFmcAEInrJYUY1c12k4vGjxGZDvz+Gya8FhzMYT
 uRWo0/x4J+/QQ6EAZMPa+Iakj4xrqdAyj+GHcTX/UFF703krImyxkPqdyackN3kVZJm4
 bxydlS0wUeu/QndC6iBUGPd10Wy4MB+8KDzNoCFz7pAbXn2MnD4sOjY0141tg6eWKJtq
 PIPumOlgjBn6FLypyrL+q9rcqwm8PZZUF+kOBnNJ5gnI+qVsuHzMS+a9FQz1m5+DdrIS
 yk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772405; x=1793377205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dKo1kqddUpLDSrGeTLF/PFAH7ID1KB9sJ3DC+s5Jzoc=;
 b=U3eG75CSNKi4SJUXRhs95ABfxdlfTXHxPUT/dfOx7gbf9ou0mjcQpro/9Rfnq0KKWo
 c02VmqdIYEUAIKXTQW9ItlhSlEtDlNvDHTCTjNxSSRtgPQPfqPzoNk6dkYhIKle7enDe
 xEDaBbfxg/JPDcYHUXX/IY/4wVX7caF+jHbd0gzZSSHlEZUiVFmxip/ES3n3Ji/g8PxL
 4uA6i9HJ0TBhzzRlVj6LjjRC6DYfOpSjnx/RGdkfy/MKp/KRuevA5qeEDQFCJK3GhtPt
 DAPim9FP0PjWXqBsbLJZ5E7joAOyJEpMqhMrvuUZ1gMTf3ZO2EPgn1OFg19E1HkIfgVS
 J5ww==
X-Gm-Message-State: AFq9FYLnf419yJZTbWxlUL3utIJaSnEQXHHSDww/3iCmT1VSK55OJJ1t
 tA3hofCcveTcBxQh50gOK1qFEnNO7Ptkedhp828XUxQGPo/F+lNk7/buDI/DWvC7Zmo45BWcFry
 iRioO
X-Gm-Gg: AYBFou39ikind2eHuvxjbkRJuiS8CMEArODpWonRyl19rh+LxgO14qxqFxNvnc6AImo
 KR70fsUfZTZcJVi08FUo3SYQUsq5hoxNTsC+QNt8ijilrURRz+e36YdemDJYm5RsUm8GTsRzXcP
 60BHEIXZT1NmiPUfQWvauFTEh50vOuWCCoJoLM3gg+VrHg1CIDDYGGC7lGkloGQvw5vq0X4DgdO
 QhgQbKDVv8qzx+66j29BTOSS01DbTAZDqlP8tz/dCw0n4eZdR1LsFP5cajJrLEnPSic93Pso4Lb
 T64QB04fGAmDaX3JXqqAU6+JagbXId/P3K+A45/8rCh/+A6oAkUE+XN1W3zfyWmGKUajZrG49df
 oPB9nU746iKCKs25/Ajj45CuNmWVTe2W3/XqEFr44SSO7JrK7K/2xqzrItndQ2TPgBZG46Z8xWB
 L8jZgBI7YCs4R6kbBggnlxvFZPR8NqU+chGNRRi4ZTrPbFTyWDzzec6VB1IW4lVezkymXrypeTn
 S5QxTd0uyrXynZbYQQY7GGBNZ4Nm9xXxuQuMf9dIzerel/GjcUO
X-Received: by 2002:a05:6000:4552:b0:48c:490a:336b with SMTP id
 ffacd0b85a97d-48e38546c58mr3010498f8f.5.1792772404720; 
 Fri, 23 Oct 2026 09:20:04 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a960:ee49:ec13:ac39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d417e6dsm720356f8f.44.2026.10.23.09.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:20:04 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-stable@nongnu.org,
 Ilya Rudakov <irudakov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/1] virtio-scsi: fix hot-plug event racing device realize
Date: Fri, 23 Oct 2026 18:19:59 +0200
Message-ID: <20261023162000.2796947-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023162000.2796947-1-den@openvz.org>
References: <20261023162000.2796947-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=den@openvz.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

virtio_scsi_hotplug() is the HotplugHandler plug() callback, which
device_set_realized() calls before it sets dev->realized. The callback
pushes VIRTIO_SCSI_T_TRANSPORT_RESET/RESCAN to the guest at once, but
until realized is set the request path ignores the new device:
virtio_scsi_device_get() -> scsi_device_get() skips unrealized devices,
and so does REPORT LUNS. A guest that reacts to the event quickly, on a
vCPU while the request queue is served by an iothread, scans the target
and gets VIRTIO_SCSI_S_BAD_TARGET.

Neither Linux nor Windows retries that scan, so the hot-plugged disk or
CD-ROM stays invisible until somebody rescans the bus by hand. Linux
calls scsi_scan_target() once from the event handler. Windows storport
clears its rescan flag before enumerating the bus and never sets it
again for a failed target.

Push the event, and the REPORTED LUNS CHANGED unit attention that goes
with it, from a main-loop bottom half instead. It runs under the BQL,
which device_add holds until device_set_realized() returns, so the guest
is only told about a device it can reach. The iothread context would not
do: its bottom half could run before realized is set, and the realized
check and scsi_bus_set_ua() rely on the BQL as plug() did. The bottom
half is only scheduled when the guest negotiated VIRTIO_SCSI_F_HOTPLUG,
as before, so cold-plugged devices do not get one. It still checks that
the device is realized: nothing orders it against a device_del that
follows device_add, and an unplugged device has no parent bus.

Fixes: 8ddf958e8d62 ("scsi/scsi-bus: scsi_device_find: don't return unrealized devices")
Cc: qemu-stable@nongnu.org
Reported-by: Ilya Rudakov <irudakov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
---
 hw/scsi/virtio-scsi.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index d7e2662aa7..9ea1acb84c 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1151,6 +1151,29 @@ static void virtio_scsi_pre_hotplug(const HotplugHandler *hotplug_dev,
     sd->hba_supports_iothread = true;
 }
 
+static void virtio_scsi_hotplug_notify_bh(void *opaque)
+{
+    SCSIDevice *sd = opaque;
+    DeviceState *dev = DEVICE(sd);
+
+    /* Nothing orders us against a following device_del */
+    if (qdev_is_realized(dev)) {
+        VirtIOSCSI *s = VIRTIO_SCSI(dev->parent_bus->parent);
+        VirtIOSCSIEventInfo info = {
+            .event   = VIRTIO_SCSI_T_TRANSPORT_RESET,
+            .reason  = VIRTIO_SCSI_EVT_RESET_RESCAN,
+            .address = {
+                .id  = sd->id,
+                .lun = sd->lun,
+            },
+        };
+
+        virtio_scsi_push_event(s, &info);
+        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
+    }
+    object_unref(OBJECT(sd));
+}
+
 static void virtio_scsi_hotplug(const HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
@@ -1169,17 +1192,10 @@ static void virtio_scsi_hotplug(const HotplugHandler *hotplug_dev, DeviceState *
     }
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
-        VirtIOSCSIEventInfo info = {
-            .event   = VIRTIO_SCSI_T_TRANSPORT_RESET,
-            .reason  = VIRTIO_SCSI_EVT_RESET_RESCAN,
-            .address = {
-                .id  = sd->id,
-                .lun = sd->lun,
-            },
-        };
-
-        virtio_scsi_push_event(s, &info);
-        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
+        /* The request path ignores @sd until it is realized, so notify after */
+        object_ref(OBJECT(sd));
+        aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                                virtio_scsi_hotplug_notify_bh, sd);
     }
 }
 

base-commit: b6c4b7e86dec12d07f5cac65265b986d38ee9002
-- 
2.53.0


