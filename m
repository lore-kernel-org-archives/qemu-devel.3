Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F442606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pqA0BJ36
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMA52-0005GZ-R7; Wed, 28 Oct 2026 16:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA4z-0005FB-8Q
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:17:01 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA4x-0002Jx-K5
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:17:00 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-369f33df08eso2611480eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793218618; x=1793823418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+9DnP+gTwSEOX7zrI2haaQoi28yWED+v2p12ws9Ei1k=;
 b=pqA0BJ369esX7TW4TefNW9h7r0U9jonXkHfaoDAbrgk6+VMitcMtnqoNjuvn3Gb3fS
 Hl5Ro948xAH2ka/Wa13sYeL37k4R+rtENYSUYWuqbGFg5SVufYlOqWSfLNu8v1WGT29I
 Cu/qEfZGAunMpHORyB1FFJq0fZobx5OgnaZOo/t2jnaeO+phWjABhXSwmZZKyCzlLrIW
 Eu0qnQCVPcF/0d+mBARIOgeqpkSJ819YwOEXuX8UOckVRpa5dnq9CGvDaIUc807A75Uz
 rHyB9MyFP2Rj7NW/zMtQ+lDnypwQKhnfJT+wZ3y55AjroDHNJBWN4mhN5XzgO7YcUpQN
 9lTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793218618; x=1793823418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+9DnP+gTwSEOX7zrI2haaQoi28yWED+v2p12ws9Ei1k=;
 b=ap7mSCCTT7PLmo7yNwt62JKdf37ySogyX+vWXKFKft1uyuoI+MA/fUbOONjY9y3GDE
 OBIWVrgcPlXuh7VUrbp0FBN4LlUH/L8ZmvjhnI22JEp1xc0WTvy4Tx37//Hjq2Xn33fa
 sFZCvSBchAfElJQ5QrsnnwN4Cynj2HoVUNY6db6enXhJ11NjzTedy9D+9jO6cuNazCYO
 J6k1cxhSG7eCfDv+MwdE+JWdO9W40RStYdoaffxUC6tBkXXTBeAIhMIp1ZOf6y3koiPm
 l/vRb4mFPjHvDf+hjV2IX3Ml5DKc/hD+dx66bitadBSlp/3Q8wlZeQ4mL4EwhMdbRgon
 JIRg==
X-Gm-Message-State: AFq9FYII3WFrdIKrcWakBH1ibx6Vx5XZsEWkX0AZ1wdqnVM+cM/V0bHE
 Cw0Djt1GhgEpqapy6ZZ7ivBk6kOt+5ZATWjlEeCAiOf1FBHekrCjP3fLgeVz4mdQ
X-Gm-Gg: AYBFou2JWghWFloSJfJpaJol05WDdn0I3uciEO9S7WEwF4Q5WtFo2HXWSopMnl+6Q37
 pyymhl+M2OZaMTTNhsBvsNCd43Y6MuRLhgp7CKx4BWpm78gZJfcnNuC6TJ5xZRRMg+8ABuUgj+0
 FviMKr+n8dWiTXaLYUZueIxtcFg0KFq5xmmZ7hRot9meTOPSZuspk1NRVnY4xZstJN2PH7U4j+k
 xcu+aISawF0wyEXBe8exWMfaQHghGOQR0KdB9hxI2EHOsR7LOBbu0AaoyQq4ugyVjsJaee9r/U2
 Z3l2X2oDlJQt6xqOD1XJb+7OJK4L7LYbP/S8YNDurPi3hS6Xj7tlLHP+ysG9q/L3f3ZacKd/Whq
 47h4qsqX2GoMwd6tI3EHJs0T0zZeWEqF4za/iRbRhVJ8qundsEsThDy7mD1AEEwY0QBEYUt8aP7
 N2ttbAQc1pGMEi87r38jAWmRrBsYsEXxcnbEMTyxM1p3C4KISylIgq5IkxRPORp8L9Vdyrrh9sn
 /SOPmlwSOO4fvnSEQInPdLmi1hCcyQjUpLDnILwbjDgsLn4Bs2yNEERiva2JR4BTNXVtAOhI9lX
 ayYOZvHmfScZRY9f2rPVvHGRn12YCXlFLPy0sLkFduNyQmUN8xCJJ721jvVjLXq1Dia6+A==
X-Received: by 2002:a05:7300:fe43:b0:36a:1bd4:627f with SMTP id
 5a478bee46e88-36a200b7256mr4740544eec.14.1793218618082; 
 Wed, 28 Oct 2026 13:16:58 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36a23951e00sm12016896eec.20.2026.10.28.13.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:16:56 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 08/12] hw/virtio/virtio-pci: pass is_available through
 VirtioPCIDeviceTypeInfo
Date: Thu, 29 Oct 2026 04:15:52 +0800
Message-ID: <20261028201557.2688-9-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261028201557.2688-1-luoyonggang@gmail.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

virtio_pci_types_register() builds the base, generic, transitional
and non-transitional TypeInfos for one virtio-pci device. Copy an
is_available callback onto each of them so a device can register
target-specific variants of the same names.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/virtio/virtio-pci.c         | 4 ++++
 include/hw/virtio/virtio-pci.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c73f1f546cb..1ce39e92e9d 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2522,11 +2522,13 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         .class_size    = t->class_size,
         .abstract      = true,
         .interfaces    = t->interfaces,
+        .is_available  = t->is_available,
     };
     TypeInfo generic_type_info = {
         .name = t->generic_name,
         .parent = base_type_info.name,
         .class_init = virtio_pci_generic_class_init,
+        .is_available = t->is_available,
         .interfaces = (const InterfaceInfo[]) {
             { INTERFACE_PCIE_DEVICE },
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -2562,6 +2564,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
             .name          = t->non_transitional_name,
             .parent        = base_type_info.name,
             .instance_init = virtio_pci_non_transitional_instance_init,
+            .is_available  = t->is_available,
             .interfaces = (const InterfaceInfo[]) {
                 { INTERFACE_PCIE_DEVICE },
                 { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -2576,6 +2579,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
             .name          = t->transitional_name,
             .parent        = base_type_info.name,
             .instance_init = virtio_pci_transitional_instance_init,
+            .is_available  = t->is_available,
             .interfaces = (const InterfaceInfo[]) {
                 /*
                  * Transitional virtio devices work only as Conventional PCI
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index ee50fb0d551..6c3561d319a 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -236,6 +236,7 @@ typedef struct VirtioPCIDeviceTypeInfo {
     void (*instance_init)(Object *obj);
     void (*instance_finalize)(Object *obj);
     void (*class_init)(ObjectClass *klass, const void *data);
+    bool (*is_available)(void);
     const InterfaceInfo *interfaces;
 } VirtioPCIDeviceTypeInfo;
 
-- 
2.55.0.windows.3


