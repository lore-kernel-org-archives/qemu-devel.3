Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E54CF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 14:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sskTn-0008Kn-6o; Mon, 23 Sep 2024 10:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sskTM-0007tf-D9; Mon, 23 Sep 2024 10:55:32 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sskTK-0006vJ-Mz; Mon, 23 Sep 2024 10:55:32 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-49bc13c3a47so1759545137.3; 
 Mon, 23 Sep 2024 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727103329; x=1727708129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBoxVH+Ru8Cf8WZg/qIWXUyc6DjCMqmFHFamf1lm7RE=;
 b=O+A5gp2KibcsHS6l/OT6m9KQFwRCDD4jWJB8uuIXj/rqQVK8JqbkyIj7FHocmYneeB
 9eSAaZGorwz2ZXH/K2+0kYFZ5GeJViv2c0DKQQ/7Cw05Q9oRbBXGvDuIHf0drdNdW8bp
 GPPnR3QLuLySe6jzXbEVnQE6v6cMhUooAfFWHx710V6nVf2P3u8cHQpmMUkJDJR5E4wa
 76iukecFbWjToZhvr9/MzOd1DLMa8iSHQcOyRyrVFxnccUGNuIVUB7ZRxUEWe9wCuLeX
 EPzgwMFCz88zBOHe8GoRhKt70EAik7iiHk+iA3yKa9GTMuBByGfwy2eSfpN8ObVFYquo
 HfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727103329; x=1727708129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBoxVH+Ru8Cf8WZg/qIWXUyc6DjCMqmFHFamf1lm7RE=;
 b=MmRC9r/U0yQvsfuMQJmFXf+3X1hlqiTaq8jKlHihm1n7HqFSCCckC5E6nmnPQc9RoD
 Ns53546fN3a2kNU44cWU3ce55dKo1gdYEYXA78YS29vENUm0neOorIfRsZSKuxzFW7xs
 vthugnXCo4+d3d1cJMUSGhr46fzXiV9HWsrQOroqbpEDaX/W0k6wYxRUvSSAQpdgCAdW
 FXcNFvWWRMkh6CGumLwFr7yFrCHioqxuimPrjraHgA4qQcEKqbSBzjyWzqJNMi61N3sp
 Tyqbxzg5yG5gqxFVUZTdhQZZaMkKCdOTtNtQNNBD5/vZp755lUNX6dL3DJUY29g91tDV
 S2Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUgltTyIDYqZiIW+tSI1u1Rerm2EFL3GiD6Bpo5th2Y8xi9/KYGb0JaVwomC/sIZz0NZbs9xYmRw==@nongnu.org
X-Gm-Message-State: AOJu0Yz4G3drq8CH8RWpM5E2QXmEzMySblgpGCXMUiU5rrFTpAaNZNZa
 R9bJ7CJoN+Jx3gxP+dENxkvYaov+jiluvoNiUPNX23XG2ys2c0oRcT6TM1cF
X-Google-Smtp-Source: AGHT+IEVIq+5zTRJIDiwVEZ//hmPV3dnxQ6KGiEO/YrKl7+YpgOR25Qn3clhu6UZuNekZAImrbXJhA==
X-Received: by 2002:a05:6102:94c:b0:498:e25c:738f with SMTP id
 ada2fe7eead31-49fc7624bf3mr7212517137.18.1727103328687; 
 Mon, 23 Sep 2024 07:55:28 -0700 (PDT)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-849399971dfsm3226559241.26.2024.09.23.07.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 07:55:27 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH v2 2/4] hw/xen: xenpvh: Disable buffered IOREQs for ARM
Date: Mon, 23 Sep 2024 16:55:18 +0200
Message-ID: <20240923145520.1323504-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240923145520.1323504-1-edgar.iglesias@gmail.com>
References: <20240923145520.1323504-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vs1-xe30.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Add a way to enable/disable buffered IOREQs for PVH machines
and disable them for ARM. ARM does not support buffered
IOREQ's nor the legacy way to map IOREQ info pages.

See the following for more details:
https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=2fbd7e609e1803ac5e5c26e22aa8e4b5a6cddbb1
https://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=xen/arch/arm/ioreq.c;h=2e829d2e7f3760401b96fa7c930e2015fb1cf463;hb=HEAD#l138

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xen-pvh.c                | 3 +++
 hw/i386/xen/xen-pvh.c           | 3 +++
 hw/xen/xen-pvh-common.c         | 2 +-
 include/hw/xen/xen-pvh-common.h | 3 +++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 04cb9855af..28af3910ea 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -66,6 +66,9 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
      */
     mc->max_cpus = GUEST_MAX_VCPUS;
 
+    /* Xen/ARM does not use buffered IOREQs.  */
+    xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_OFF;
+
     /* List of supported features known to work on PVH ARM.  */
     xpc->has_tpm = true;
     xpc->has_virtio_mmio = true;
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index 45645667e9..f1f02d3311 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -89,6 +89,9 @@ static void xen_pvh_machine_class_init(ObjectClass *oc, void *data)
     /* We have an implementation specific init to create CPU objects.  */
     xpc->init = xen_pvh_init;
 
+    /* Enable buffered IOREQs.  */
+    xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_ATOMIC;
+
     /*
      * PCI INTX routing.
      *
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 08641fdcec..76a9b2b945 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -195,7 +195,7 @@ static void xen_pvh_init(MachineState *ms)
 
     xen_pvh_init_ram(s, sysmem);
     xen_register_ioreq(&s->ioreq, ms->smp.max_cpus,
-                       HVM_IOREQSRV_BUFIOREQ_ATOMIC,
+                       xpc->handle_bufioreq,
                        &xen_memory_listener);
 
     if (s->cfg.virtio_mmio_num) {
diff --git a/include/hw/xen/xen-pvh-common.h b/include/hw/xen/xen-pvh-common.h
index bc09eea936..5cdd23c2f4 100644
--- a/include/hw/xen/xen-pvh-common.h
+++ b/include/hw/xen/xen-pvh-common.h
@@ -43,6 +43,9 @@ struct XenPVHMachineClass {
      */
     int (*set_pci_link_route)(uint8_t line, uint8_t irq);
 
+    /* Allow implementations to optionally enable buffered ioreqs.  */
+    uint8_t handle_bufioreq;
+
     /*
      * Each implementation can optionally enable features that it
      * supports and are known to work.
-- 
2.43.0


