Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB679FD45F9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 03:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvRro-0003bB-Tn; Wed, 25 Feb 2026 22:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vvRrn-0003ah-Ab
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 22:16:43 -0500
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vvRrl-0004gG-Qa
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 22:16:43 -0500
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-896fcfc591eso4235006d6.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 19:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772075800; x=1772680600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSYA1Q4q/L6p22kNI5axX3mj2bIY09wz5eUmq35S9i8=;
 b=Y0IPvqUcMmUkKW6u0sGmIhYjisM7GTjFJchte7HDU/0V/TFU5M12M5BTNdf7CF/mbn
 5WGz8OulyUhJhdJiTJq6DIOPJzshyyCb1YD299QYGB1Tns0r3/CGXYEbvmDZQvQFnvev
 gqMmxjXJRoaYgufN35t3MWepAWxjm/8kVLPqndW5yyzuvM/jM4X5MH7paA0sCRd+9ZnO
 Cakq2HfL6mOoNHiHJjZiOoymOy/ZYdvWbeaKqlp6ram5rlO2ciXoZK1iSExkeMUQwXdn
 T2XFNbN1xEfafSp4WpcPf6LodA7BypsRnUkj57aDJ1OlTA32jmERa7weYHM+3BqZ4EnZ
 AdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772075800; x=1772680600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TSYA1Q4q/L6p22kNI5axX3mj2bIY09wz5eUmq35S9i8=;
 b=jsWtsSi235wq6rxcg+HLFdXVsXKy7a4B7AM8g9Fep+bMNXgjOnrht7GxdTtbumLjKe
 AzheOVlL+MCdbd/i+7F2OGll9k1cIFnDv+0fXFyHQe6689GnqQLBINkQAplMH6/xhIge
 5razqaAYLqDN49LXNm+dNTRV7Y10vpexYhrfHt5G61H9XiZrJHayMvnz0hcC+Lbe7+pr
 Dj/txdcAMFiWAORLI1WsPp+lc3dBKG1gJWe4QVsuflVUX+2e6rZeuPNuUplph7ww9gtg
 ys0jwXOjRSuHfNKJVaCQOzmGLFMli4AzQkMOdCnEk/Nc7gxEYbE04iWhXgPLUmaGLFhq
 WAFA==
X-Gm-Message-State: AOJu0YyrxjUy8kmGdDxAfqPE1u1lGQPvhXjKznSZ7JQRox6j71Tf2IHA
 I0MXqtwC5js1aPQ+DOU96HFUhAn/STIZ5PuU85O3OlgEVlIRAb30BZpFV5/tIA==
X-Gm-Gg: ATEYQzzEEiiegxjY2MSymjDPCJdXosj/YIVzlUgDRFeFJgCH/A5nPFGMErfkCQ/2V1w
 uhYZ28tySaPBLjSdC0A4JRH9NxywWo4vEphiGeSJuWCwK8wqKMBgfwWU3jHZIm0Zl/0/ksUWBXf
 0duA6kaRZSiP51x2CC4RBtxCHmbGvhYHMDpjBjXkxQBgrSYUOJ9RzuGcjSDsDb2DbGHataCu/Jd
 7CuMPT+YSjeKCEDwTaweJrXzliG4rlMX9H5n/G16NjOn8hkz2XPhDCIaGt9DRtqUP0w3XpnpSmL
 fRZVFMNxeqA/iMNsC468m5uTxqT4S6h4xwsyA+gMLaq6QKrhAKvuhJ6ly9ebNXxsWenrskxhygx
 7N5ETOR96cVO/1UU9XxidjbtABeVPRG8kCvh3BjOZ56VwzaBFJxfxZ7Mo8puErgo+cAdilLW9jC
 lu4//D1JQei3F98Gf7dHx/Pr0Cmr2u7s6FAOUxPb5BInGL7+w0O6g=
X-Received: by 2002:a05:6214:416:b0:896:f73b:c887 with SMTP id
 6a1803df08f44-89979e31ccemr258377086d6.4.1772075800532; 
 Wed, 25 Feb 2026 19:16:40 -0800 (PST)
Received: from localhost.localdomain ([207.98.184.46])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899c715af1fsm7376156d6.1.2026.02.25.19.16.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 19:16:40 -0800 (PST)
From: David Hamilton <dahamilt0@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Hamilton <dahamilt0@gmail.com>
Subject: [PATCH v3 1/2] hw/misc/ivshmem-pci: Handle error from
 kvm_irqchip_add_irqfd_notifier_gsi()
Date: Wed, 25 Feb 2026 22:16:32 -0500
Message-ID: <20260226031633.12369-2-dahamilt0@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260226031633.12369-1-dahamilt0@gmail.com>
References: <20260226031633.12369-1-dahamilt0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=dahamilt0@gmail.com; helo=mail-qv1-xf2e.google.com
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

The return value of kvm_irqchip_add_irqfd_notifier_gsi() was being
ignored. Propagate the error to the caller via errp.

Also change setup_interrupt() to return bool to follow QEMU error
handling conventions, making error checks at call sites simpler.

Resolves the TODO comment at the call site.

Signed-off-by: David Hamilton <dahamilt0@gmail.com>
---
 hw/misc/ivshmem-pci.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index a3a43f53bd..c987eebb98 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -442,13 +442,14 @@ static void ivshmem_add_kvm_msi_virq(IVShmemState *s, int vector,
     s->msi_vectors[vector].pdev = pdev;
 }
 
-static void setup_interrupt(IVShmemState *s, int vector, Error **errp)
+static bool setup_interrupt(IVShmemState *s, int vector, Error **errp)
 {
     EventNotifier *n = &s->peers[s->vm_id].eventfds[vector];
     bool with_irqfd = kvm_msi_via_irqfd_enabled() &&
         ivshmem_has_feature(s, IVSHMEM_MSI);
     PCIDevice *pdev = PCI_DEVICE(s);
     Error *err = NULL;
+    int ret;
 
     IVSHMEM_DPRINTF("setting up interrupt for vector: %d\n", vector);
 
@@ -460,18 +461,22 @@ static void setup_interrupt(IVShmemState *s, int vector, Error **errp)
         ivshmem_add_kvm_msi_virq(s, vector, &err);
         if (err) {
             error_propagate(errp, err);
-            return;
+            return false;
         }
 
         if (!msix_is_masked(pdev, vector)) {
-            kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NULL,
+            ret = kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NULL,
                                                s->msi_vectors[vector].virq);
-            /* TODO handle error */
+            if (ret < 0) {
+                error_setg(errp, "Failed to configure irqfd notifier");
+                return false;
+            }
         }
     } else {
         /* it will be delayed until msix is enabled, in write_config */
         IVSHMEM_DPRINTF("with irqfd, delayed until msix enabled\n");
     }
+    return true;
 }
 
 static void process_msg_shmem(IVShmemState *s, int fd, Error **errp)
-- 
2.50.1 (Apple Git-155)


