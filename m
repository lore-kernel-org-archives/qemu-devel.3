Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD786C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggiD-0006zm-Dz; Mon, 06 Jul 2026 06:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggi8-0006xd-W8
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggi6-0003F5-4K
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so20656195e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334276; x=1783939076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+97oten0hNNuTAbNo9fRI3B+bvLWCRDF1yKEOcFHQOk=;
 b=hdjYnLEUCClZXmkMa/0N89Fsg/JbPb7SkcTCZrcrqRW8+yF5tLBmTRdNm7Izjeul5Y
 9JEAGHSJMczC0y9KEzbhLdKHO/M2bLndK7q5TbTIkg0u1kJMA+xHqac/ue/KkixQU0Hp
 0apIBSCWxX1iusOehkhxBHvuaD1XEQh5OJocBqaDcSmESDMDpkCYHEvOXZxjmZeswtMN
 t3zyUpFOYuhDlKooI4fO2AqcACuwANpTDshwVWBhgttu/M7kvcrOGynfp4mC7Du33ia+
 diB/XweUUTz26MI0YH0Rv5ARDk8d4o6G7xHmTc6nE/l2elFD75mDbGtOpKgE0nEW4q/H
 bRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334276; x=1783939076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+97oten0hNNuTAbNo9fRI3B+bvLWCRDF1yKEOcFHQOk=;
 b=m7ztgYEMzZm0a8eQR7RQzSdAH4lhn4V62EMsfIk57v6ekjc8bqmVYvrJa/iDdWlM2R
 E5nFS75wKFxdp+53BwVEOfxnkPpKgeCjE7qc75DgMac6lJHHxududjb8vnLDfVQR42Au
 NO130QuEI6QWlaxwiN+9DyH/mm6LJFgSHPNBgM18t1iVFkyJuavKt5jE6r1188c72eQt
 9fBdzlnF10IjpT0IDcHHsVNUU4B27+qDwNTxEqyfk+LD7pUz8mtg11im4W96jSLtnO8j
 qr49z+IjDlpGEXAt7hTtYdbKYiJhopvUZ/nQrLQHvh56tK1LAFR9F5etKDr0/YaD2z4E
 zFXQ==
X-Gm-Message-State: AOJu0YwM+5+tW8/3oC1XrE2cA1ILGnbztkLb0cPWivGMNp7I7D4+yPf5
 jY0DXDp1q3k7q6wY+eKxtumUWiJBZptWQou29r3Q5chl5QgNCj/+0MvP1/YbV9XOimZV32dkxJC
 wYrAznc4tjg==
X-Gm-Gg: AfdE7clCCIILC12Gp5vhm4DgYp/RN/DAkkZ8N0RmDOsyi5CcWruLHlPBgmkK12fQuY8
 2CxdLNOtIumEJNd9HFJwmhvd+Nq7HVgQAZ1e5KJP1XNRZHekPXzc34TFuP1TUCu0VP4mUB0F66W
 WYK0VzsptZTPm2dvNygFvri5NxyXoIPgpTn5aWgkv504T1gv16UvqkYZ5qgbNjKoKT82rAW16IB
 FT+EMRmbmr/f7SiziCArlIIAYZ9P0K4Z6vOnm5W1oSC//V1r1fubbxJy4Yf8egPMRxpU4fVLaAD
 QDDl8pOZn1FjLvH/69FREPcV4V4ns77G80aHqDdlpxe7y8JvmyiDZ6AER0kQG7/rn11kw7zEjd4
 7OVFlw7+l3i8HucQKXBtxPXYWMNTRGM04XJzuKIjlRs1s0jaNcBgPId0iSf7A0clK4wUHzxphVp
 4SdLaKUM2060dhkjlcuxik37qXuo4ekbos5xZtS8NoGpX5S2m05tYO8jeSoEo/NxjyLw52JVRD1
 c1lgX7y139uOacio5cw5Q==
X-Received: by 2002:a05:600c:8b76:b0:493:d21f:8f98 with SMTP id
 5b1f17b1804b1-493d21f9075mr97100765e9.36.1783334276480; 
 Mon, 06 Jul 2026 03:37:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.37.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:37:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/49] hw/arm/smmuv3-accel: Fix veventq read returning true on
 EAGAIN/EINTR
Date: Mon,  6 Jul 2026 11:37:05 +0100
Message-ID: <20260706103752.320511-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shameer Kolothum <skolothumtho@nvidia.com>

smmuv3_accel_event_read_validate() returns true for EAGAIN/EINTR, but
no data has been read into the buffer. Callers treat true as success and
proceed to use the uninitialized buffer.

Change the return type to int with three distinct states:
  0  — success, buf is populated and valid
  1  — EAGAIN/EINTR, no data available
 -1  — error, @errp set

Resolves: Coverity CID 1660057
Fixes: d4aea0f75b ("hw/arm/smmuv3-accel: Introduce common helper for veventq read")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260625122843.107584-1-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel-stubs.c |  6 +++---
 hw/arm/smmuv3-accel.c       | 30 ++++++++++++++++++++----------
 hw/arm/smmuv3-accel.h       |  4 ++--
 hw/arm/tegra241-cmdqv.c     | 11 ++++++++---
 4 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
index 147ae06163..b8dd7e7b89 100644
--- a/hw/arm/smmuv3-accel-stubs.c
+++ b/hw/arm/smmuv3-accel-stubs.c
@@ -47,10 +47,10 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     return true;
 }
 
-bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
-                                      void *buf, size_t size, Error **errp)
+int smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                     void *buf, size_t size, Error **errp)
 {
-    return true;
+    return 0;
 }
 
 
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 5e83dbd8ee..91aca1aa14 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -441,8 +441,13 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
-bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
-                                      void *buf, size_t size, Error **errp)
+/*
+ * Returns  0 on success (buf is populated and valid).
+ * Returns  1 if the read should be retried (EAGAIN/EINTR).
+ * Returns -1 on error with @errp set.
+ */
+int smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                     void *buf, size_t size, Error **errp)
 {
     uint32_t last_seq = veventq->last_event_seq;
     uint32_t id = veventq->veventq_id;
@@ -452,22 +457,22 @@ bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
     bytes = read(veventq->veventq_fd, buf, size);
     if (bytes <= 0) {
         if (errno == EAGAIN || errno == EINTR) {
-            return true;
+            return 1;
         }
         error_setg(errp, "vEVENTQ(type %u id %u): read failed (%m)", type, id);
-        return false;
+        return -1;
     }
     hdr = (struct iommufd_vevent_header *)buf;
     if (bytes == sizeof(*hdr) &&
         (hdr->flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
         error_setg(errp, "vEVENTQ(type %u id %u): overflowed", type, id);
         veventq->event_start = false;
-        return false;
+        return -1;
     }
     if (bytes < size) {
         error_setg(errp, "vEVENTQ(type %u id %u): short read(%zd/%zd bytes)",
                           type, id, bytes, size);
-        return false;
+        return -1;
     }
     /* Check sequence in hdr for lost events if any */
     if (veventq->event_start && (hdr->sequence - last_seq != 1)) {
@@ -476,7 +481,7 @@ bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
     }
     veventq->last_event_seq = hdr->sequence;
     veventq->event_start = true;
-    return true;
+    return 0;
 }
 
 static void smmuv3_accel_event_read(void *opaque)
@@ -488,13 +493,18 @@ static void smmuv3_accel_event_read(void *opaque)
         struct iommu_vevent_arm_smmuv3 vevent;
     } buf;
     Error *local_err = NULL;
+    int ret;
 
-    if (!smmuv3_accel_event_read_validate(veventq,
-                                          IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &buf,
-                                          sizeof(buf), &local_err)) {
+    ret = smmuv3_accel_event_read_validate(veventq,
+                                           IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &buf,
+                                           sizeof(buf), &local_err);
+    if (ret < 0) {
         warn_report_err_once(local_err);
         return;
     }
+    if (ret > 0) {
+        return; /* EAGAIN/EINTR */
+    }
     smmuv3_propagate_event(s, (Evt *)&buf.vevent);
 }
 
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index dd755c394d..ea11d513cc 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -97,8 +97,8 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
 void smmuv3_accel_idr_override(SMMUv3State *s);
 bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
-bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
-                                      void *buf, size_t size, Error **errp);
+int smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                     void *buf, size_t size, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj);
 
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 29c488e0e4..7223aa9d1d 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -841,13 +841,18 @@ static void tegra241_cmdqv_event_read(void *opaque)
         struct iommu_vevent_tegra241_cmdqv vevent;
     } buf;
     Error *local_err = NULL;
+    int ret;
 
-    if (!smmuv3_accel_event_read_validate(veventq,
-                                          IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
-                                          &buf, sizeof(buf), &local_err)) {
+    ret = smmuv3_accel_event_read_validate(veventq,
+                                           IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
+                                           &buf, sizeof(buf), &local_err);
+    if (ret < 0) {
         warn_report_err_once(local_err);
         return;
     }
+    if (ret > 0) {
+        return; /* EAGAIN/EINTR */
+    }
 
     if (buf.vevent.lvcmdq_err_map[0] || buf.vevent.lvcmdq_err_map[1]) {
         cmdqv->vintf_cmdq_err_map[0] =
-- 
2.43.0


