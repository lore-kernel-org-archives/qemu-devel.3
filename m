Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28358CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 13:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsMTE-0005ar-2I; Thu, 04 Apr 2024 08:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1rsMTC-0005ag-Mp
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:45:30 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1rsMT8-0005Rw-O8
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:45:30 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56c404da0ebso1440309a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712234715; x=1712839515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g35vkAIAzqMYSUGPyJyrxTemWA4rEDig+AfGNwRg+Ok=;
 b=MGpoQyVG8f/e7NiXfLi2CzmLZD5atJHyTdlD4KuNf6jacbjkXhzlHSs9kYcueJFElg
 jvJXivOnHvCQmq4c0Kw4/yVh1rYpgj007YoYvJrg+VoWW4AA2QAJsr0+HmGY+9aiUqzi
 gh0GsCk2gxDk9d09W83UH9B2TQBYZLEXtRfb3odzYUa7FR49Uzg9+tOiDT6puvsGHT8l
 HHh/x2zP70Zp8xQXu2BNkGPg4sEtj3+bjD8ekIYtMnOhsktcFtNNULwvsgQaLR5GO8U4
 rK9r6g7vxTJUWmm7QO1yVPbEG1j/hbH+9piYydFqtVWm6UDvgv49LiGq2bkaoCNiGXPd
 ECCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712234715; x=1712839515;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g35vkAIAzqMYSUGPyJyrxTemWA4rEDig+AfGNwRg+Ok=;
 b=B1WoU6PZL4iMKEV+x7SM6FILBzALccEfcMxUDgn4GsJspRlAVkWVc0nFDpz5HVZnBp
 KIpAsBjlSTCUjVn8DyuVbILE3Gp7Hc73aHWjnOXuRbw6JijMV0E+tfRRmHAldNdLGDy6
 Lm2EiJ242tZ8lVFDMTaTQU1IrgcNiz4GIlbah/cW+zG3ouKxpmbIcdiSh1jXVbx1CqMi
 7QaKuRVHJMloUJ4Hv1hNODYaNk5OUv3aTwQVqPemEaTLxYGfvSYnWIzKsUq1KgoV+oQX
 zkz85IerhNlOXq1CWGoE79zOLYIi+umhP07tI4mwBiRlrlTFlFsitlg72wSjtrKUaevw
 Stug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCKbENWB07mlienJ1H1U6TS+O46zdETLvPP/ZsQCISv84n9j0MBmU/c4IGFShWvn3z2/qvkZ/KNzYDOclFmDGHLMg1YaQ=
X-Gm-Message-State: AOJu0YywJsmtuyWKjrHy9EmQIOF4tLuozKdcQ6iAyAJxRGxEsig1/xA2
 t195FuROvUFm45aunFVwXlGRrHGNsdl5vIGwsh4CNhzpd4shESE=
X-Google-Smtp-Source: AGHT+IFb7sNig3J8ba6a02sgiLx6lHNsPMzb/kKvBatbQS5KP8xOZoznmCtGFWzQ6Qd6+lihKtr8Qg==
X-Received: by 2002:a17:906:4913:b0:a50:f172:699e with SMTP id
 b19-20020a170906491300b00a50f172699emr1648425ejq.33.1712234714549; 
 Thu, 04 Apr 2024 05:45:14 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 xg9-20020a170907320900b00a4e26570581sm8705984ejb.108.2024.04.04.05.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 05:45:14 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: Zheyu Ma <zheyuma97@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] virtio-iommu: Do not process commands with bad size
Date: Thu,  4 Apr 2024 14:45:05 +0200
Message-Id: <20240404124505.2108743-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=zheyuma97@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The device should not handle the commands which have bad request/reply
size, it should just report the error instead of raising an assertation.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/virtio/virtio-iommu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 1326c6ec41..3a7cdfe777 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -770,8 +770,8 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
             return;
         }
 
-        if (iov_size(elem->in_sg, elem->in_num) < sizeof(tail) ||
-            iov_size(elem->out_sg, elem->out_num) < sizeof(head)) {
+        if (iov_size(elem->in_sg, elem->in_num) != sizeof(tail) ||
+            iov_size(elem->out_sg, elem->out_num) != sizeof(head)) {
             virtio_error(vdev, "virtio-iommu bad head/tail size");
             virtqueue_detach_element(vq, elem, 0);
             g_free(elem);
@@ -818,8 +818,6 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
 out:
         sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
                           buf ? buf : &tail, output_size);
-        assert(sz == output_size);
-
         virtqueue_push(vq, elem, sz);
         virtio_notify(vdev, vq);
         g_free(elem);
@@ -852,7 +850,7 @@ static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t reason,
         return;
     }
 
-    if (iov_size(elem->in_sg, elem->in_num) < sizeof(fault)) {
+    if (iov_size(elem->in_sg, elem->in_num) != sizeof(fault)) {
         virtio_error(vdev, "error buffer of wrong size");
         virtqueue_detach_element(vq, elem, 0);
         g_free(elem);
@@ -861,8 +859,6 @@ static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t reason,
 
     sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
                       &fault, sizeof(fault));
-    assert(sz == sizeof(fault));
-
     trace_virtio_iommu_report_fault(reason, flags, endpoint, address);
     virtqueue_push(vq, elem, sz);
     virtio_notify(vdev, vq);
-- 
2.34.1


