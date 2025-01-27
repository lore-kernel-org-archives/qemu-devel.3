Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35854C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQ6a-0003kN-VA; Mon, 27 Jan 2025 09:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tcQ6O-0002rq-1S
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:28:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tcQ6M-0003aw-E2
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737988113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1RQLuVyclcQ21hUyrJVWshdy3P1WZgfMm5ztUm2h/bw=;
 b=XJi4L7IScjVtVMb55wuTrSuyiEILbF75s5Bmbwh01mZJBYlR6HzMI14s671d/Atcz6X2Q8
 wO1Qn6RpGvqYm8RrVnxnAcRACv3gpGNHk+f8QhbW9hOMc00quLNb4QnCfHd6wz2eKAmKEi
 HYyNs/JmaUT/PgGu58rIaXRjvCw4zjA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-j84bU4wfP7KjePpHBirFWg-1; Mon, 27 Jan 2025 09:28:32 -0500
X-MC-Unique: j84bU4wfP7KjePpHBirFWg-1
X-Mimecast-MFC-AGG-ID: j84bU4wfP7KjePpHBirFWg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e1fd40acso2662116f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 06:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737988111; x=1738592911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1RQLuVyclcQ21hUyrJVWshdy3P1WZgfMm5ztUm2h/bw=;
 b=a83xEuCsiyvOeE5MVwjq4MrOR5d+4uRlvaO92mUeEFi16cTehcus3IRcfAQ49b5YOg
 y+HYMoYHbJvdxHUpOpiRN31b/WQXjnmUYVICVfJulcIXzTzuCPHb6xlFeJCeFQXUsyGx
 oZBD83x5iFO3TljAYw+sOXaAZVGavBnsOG0TiAL5Ag+EHPfDyxUE9Gd4y4ZO01KysyJV
 8OYgFdxd/n8RTU5G1gjKViJ1hPMhmJ7AUR/o175eIJnLOBy+G40Jza0dNa5m6Ak50jN1
 x2xpD6MNhOKY389mjEh3mPL2YyCgLzhmPaxwcQvroMaG0yxzX8CfbVAjVhP4AC6lTx49
 WMCw==
X-Gm-Message-State: AOJu0YxXj7wEwHrpwysFLHec8Xbd+nT/aAaefnvlxDXkiHy1dusaHrUO
 Y3Ev8+im/k1g67B5gC5GvCs4xpeyMihZS5TUi00P6rldytR2Q9CS3w+mUCw0RrxFwUfjg4c2GHx
 77EvX44Aih7egyLzaHPHvQCR2VvSH0MAXFyimB2+gcWx57XOwXgGDbSBi7YPmSDBYuAXin91DVQ
 lh7F72eWkPtv9jHrAUR53GmN4xK7RiBoxVYXY=
X-Gm-Gg: ASbGnct5E+dw8nHv9kG9hzfxHvaU6PkHi+oLOpdKNaSFjDaSZl/cfJTJ5dDPuGPAS+A
 FlFPgZhaygVhDuYM6MzI+KQXilBv83wFJr3HZ5sad/KtF/6NoHC8u/qwyo4htgNrx32m0FIK1cG
 oX/3A5Bh31HTlHZ934X6yRB9Pvz12e/KkYKo8sWun9LsEBsczJoBpdcbrG6mcBq3Rt88ch/e4/u
 xSwcbdd0HDaeD78hJ5XPKTrBjj0iR3pwDWrfYwB/Z+wFXvrjxnLwuPWcf3NQ+XaXiBQYYxdTx1Z
 cMI5XmkhoxrQLPYUGCIVegEUWLFLpuHmA/DZArqYQVZ/vGEGOdzZbbpg3sGl7tOWRQ==
X-Received: by 2002:a5d:47af:0:b0:38b:ed7b:f77d with SMTP id
 ffacd0b85a97d-38bf59ed576mr39492709f8f.52.1737988111642; 
 Mon, 27 Jan 2025 06:28:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFr/nZGNiwWlsgIB+QXgYuao+fM4EChbbTxjrKpkwfiqCptXt81afFyf5OjP1zQhELU+2ax2A==
X-Received: by 2002:a5d:47af:0:b0:38b:ed7b:f77d with SMTP id
 ffacd0b85a97d-38bf59ed576mr39492641f8f.52.1737988110513; 
 Mon, 27 Jan 2025 06:28:30 -0800 (PST)
Received: from localhost
 (p200300cbc736ca00b4c324bdc2f5863c.dip0.t-ipconnect.de.
 [2003:cb:c736:ca00:b4c3:24bd:c2f5:863c])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38c2a1ca723sm11136903f8f.101.2025.01.27.06.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 06:28:30 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH v1 2/2] s390x/s390-virtio-ccw: Support plugging PCI-based
 virtio memory devices
Date: Mon, 27 Jan 2025 15:28:24 +0100
Message-ID: <20250127142824.494644-3-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127142824.494644-1-david@redhat.com>
References: <20250127142824.494644-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Let's just wire it up, unlocking virtio-mem-pci support on s390x.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3af613d4e9..71f3443a53 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -554,8 +554,7 @@ static void s390_machine_device_pre_plug(HotplugHandler *hotplug_dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
         virtio_ccw_md_pre_plug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
-        error_setg(errp,
-                   "PCI-attached virtio based memory devices not supported");
+        virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     }
 }
 
@@ -566,7 +565,8 @@ static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         s390_cpu_plug(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW) ||
+               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         /*
          * At this point, the device is realized and set all memdevs mapped, so
          * qemu_maxrampagesize() will pick up the page sizes of these memdevs
@@ -580,7 +580,11 @@ static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
                        " initial memory");
             return;
         }
-        virtio_ccw_md_plug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
+        if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
+            virtio_ccw_md_plug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
+        } else {
+            virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
+        }
     }
 }
 
@@ -589,10 +593,12 @@ static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         error_setg(errp, "CPU hot unplug not supported on this machine");
-        return;
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
         virtio_ccw_md_unplug_request(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev),
                                      errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
+                                     errp);
     }
 }
 
@@ -601,7 +607,9 @@ static void s390_machine_device_unplug(HotplugHandler *hotplug_dev,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
         virtio_ccw_md_unplug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
-     }
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_unplug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
+    }
  }
 
 static CpuInstanceProperties s390_cpu_index_to_props(MachineState *ms,
-- 
2.48.1


