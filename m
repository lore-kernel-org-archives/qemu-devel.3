Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16900CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 19:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtubQ-0002ox-Vv; Mon, 08 Apr 2024 15:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtubN-0002ob-KV
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 15:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtubM-0002h5-1g
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 15:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712604259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hjo+SWrDeRFizEqN4vD72bf+/sx6nq47cFfphoqPEzc=;
 b=OanLIl9b0GnIqxYyf9hesMAZDdC+bueipuLKsmwA8yPNNprTzTNGglQZUpMU4xkwiICaA6
 W1rA7OdPRrHf/cgwlv7NeCJvX4WKeridDDLrXU+kTLGfIWr1fKEzmmrMsqAmXqH/p45ifm
 OtT3czESAi2REDlZ9wYc3mOk/XMENaI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-L8y3KZ4UMrmH2FPLA_bcZg-1; Mon, 08 Apr 2024 15:24:17 -0400
X-MC-Unique: L8y3KZ4UMrmH2FPLA_bcZg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-343e00c8979so2177804f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 12:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712604256; x=1713209056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hjo+SWrDeRFizEqN4vD72bf+/sx6nq47cFfphoqPEzc=;
 b=YpZ15QPqytLFzFIZS+MuK4U5PvDvPTanrwB1CYIBS44cQLlP9SYqddhGfVJoeNurWM
 Y7kOut9t53UlYwEGXPSVyJ4Z4s9vwbIBhF1OBiuzna/FyrOUlE6HG5N54q5aTV/rzK8b
 svQ/4WWmBnBbNrbn9LR6PJvwBUR9X9Sijr/Qn6m9uv27zDzYXN6CiXOSHdRON3zxTV79
 h4A7yUF0UdKknGry4HbV0Wl0CTUYRMlS6dDERlUThaYaecOCLCNSsTmQ4sh8h/VCiE7J
 hg1T/QcqxYCxMZa/9+8L6F8k2KUlfj10fls1Pr3oBy7MGUU58getKt9ReU7QIEt84c9s
 yi2g==
X-Gm-Message-State: AOJu0YxP3ZrsqQxJxpM80rgmuQrKqf3rmGs0TBy0qIXJv5S6nJ4apB0+
 uLJOMVIrBvqOV/D9BXtxZ/6AIgZe2zIHysXV0V2NMMmYpSogQr7dRO85RAOPrgjZRdL6fdhT9QK
 AYEvrri/wRJcdyO/ahlOeimd1tLxRHMpI9xalgRLUahW6+aCKqzmtfMYVBXXjErMCHs8MRonjop
 BKIIdzfYpH7J8IL07shJEWOtRLKOkQ6ixj5K+G
X-Received: by 2002:adf:e24e:0:b0:33e:9116:bef4 with SMTP id
 bl14-20020adfe24e000000b0033e9116bef4mr6545889wrb.14.1712604255977; 
 Mon, 08 Apr 2024 12:24:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8BP0RNkpmrgEVrqUTnFcaRLX44cFDR/qm1jQFsb2U8U6o2jrmsLyP18HwbNx4Ad9fV+CROQ==
X-Received: by 2002:adf:e24e:0:b0:33e:9116:bef4 with SMTP id
 bl14-20020adfe24e000000b0033e9116bef4mr6545863wrb.14.1712604254629; 
 Mon, 08 Apr 2024 12:24:14 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 m6-20020adff386000000b00343300a4eb8sm9620299wro.49.2024.04.08.12.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 12:24:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 3/3] kvm: error out of kvm_irqchip_add_msi_route() in case of
 full route table
Date: Mon,  8 Apr 2024 21:24:04 +0200
Message-ID: <20240408192404.542506-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408192404.542506-1-pbonzini@redhat.com>
References: <20240408192404.542506-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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

From: Igor Mammedov <imammedo@redhat.com>

subj is calling kvm_add_routing_entry() which simply extends
  KVMState::irq_routes::entries[]
but doesn't check if number of routes goes beyond limit the kernel
is willing to accept. Which later leads toi the assert

  qemu-kvm: ../accel/kvm/kvm-all.c:1833: kvm_irqchip_commit_routes: Assertion `ret == 0' failed

typically it happens during guest boot for large enough guest

Reproduced with:
  ./qemu --enable-kvm -m 8G -smp 64 -machine pc \
     `for b in {1..2}; do echo -n "-device pci-bridge,id=pci$b,chassis_nr=$b ";
        for i in {0..31}; do touch /tmp/vblk$b$i;
           echo -n "-drive file=/tmp/vblk$b$i,if=none,id=drive$b$i,format=raw
                    -device virtio-blk-pci,drive=drive$b$i,bus=pci$b ";
      done; done`

While crash at boot time is bad, the same might happen at hotplug time
which is unacceptable.
So instead calling kvm_add_routing_entry() unconditionally, check first
that number of routes won't exceed KVM_CAP_IRQ_ROUTING. This way virtio
device insteads killin qemu, will gracefully fail to initialize device
as expected with following warnings on console:
    virtio-blk failed to set guest notifier (-28), ensure -accel kvm is set.
    virtio_bus_start_ioeventfd: failed. Fallback to userspace (slower).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20240408110956.451558-1-imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a8cecd040eb..931f74256e8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1999,12 +1999,17 @@ int kvm_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev)
         return -EINVAL;
     }
 
-    trace_kvm_irqchip_add_msi_route(dev ? dev->name : (char *)"N/A",
-                                    vector, virq);
+    if (s->irq_routes->nr < s->gsi_count) {
+        trace_kvm_irqchip_add_msi_route(dev ? dev->name : (char *)"N/A",
+                                        vector, virq);
 
-    kvm_add_routing_entry(s, &kroute);
-    kvm_arch_add_msi_route_post(&kroute, vector, dev);
-    c->changes++;
+        kvm_add_routing_entry(s, &kroute);
+        kvm_arch_add_msi_route_post(&kroute, vector, dev);
+        c->changes++;
+    } else {
+        kvm_irqchip_release_virq(s, virq);
+        return -ENOSPC;
+    }
 
     return virq;
 }
-- 
2.44.0


