Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8EFD74940
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 21:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5tZs-0002PT-7Z; Tue, 29 Oct 2024 17:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tZl-0002Mt-21
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tZi-0007cv-O7
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730236585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2WucjuAZvLcYLETBN7D9EbmGFAmMsBIxe7HZXwoj7cY=;
 b=OXZLzWujElQxy7wsw/6MiuvgxA4ind6v7M3y6L0krmhADK/V2N62KYsYUfA1baPF9/sFyY
 Qw4ZkdV/hSQMX+NCGI6JDC33Y2lHmORoj7apAlQun9m0PWfEw7B5mXN2RHSbOLP0B2sz5A
 dEFHDylnHDaCmrlPUgYIOLseUMTM1Nc=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-3Avnn1PCOE28yGNyOuRYug-1; Tue, 29 Oct 2024 17:16:23 -0400
X-MC-Unique: 3Avnn1PCOE28yGNyOuRYug-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5eb9c053637so5280606eaf.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 14:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730236582; x=1730841382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WucjuAZvLcYLETBN7D9EbmGFAmMsBIxe7HZXwoj7cY=;
 b=LF/uUZgf1Hlc3avxFdKqqV1SS3Mc2X7uYpzhaJYqPE89PmyOxzp46ZimwFRyp/WQpS
 3UOKxgwXr+pCP2SMX82LIkNyIiog1iNTU6D4CZKQfNZulkUwEBNyxvZ5QZ8ZIpYgTK1u
 WCGmDqeLs667+ySDN1h3hEmyBsFqHSaNVAYr3jlGQWBRZ/HFu4XpQtw3gvaUdeZPl7HB
 sUzpixX5ONfmHkHOO1cxyhtkW5Bku4/qBfVMGVHckbN0w0Rr6+XgmcUOiB/VskD6oL0/
 LLw0cyBZjOrztFpA/uuSbhW1XUIcKEH4buv3sI1PZp4w6R+XGvQWeHpUHxFuUkmuwaY4
 7yTw==
X-Gm-Message-State: AOJu0YzOl6jD7PfXt5g9LflVwPa08igo8G7jYWOqvZfEOQGNSqjv12//
 aAjhjohTVbREsEAuPRquJx8b6MSFHXFjHNeX3zklsmALeV8R12chUMi09e2eMoS20HQ9X+YCw9T
 Nl3Bc1sDfPGJNbM8igoznYTCEcLND6FCSXRvxubujr/9vym1hGrxpk6NBi68jBbTE9Ic2Lt6C+k
 xIArXGIYgwZaCens5kJvSXKglTNJcZlDaLuA==
X-Received: by 2002:a05:6359:4105:b0:1b1:acd5:dd98 with SMTP id
 e5c5f4694b2df-1c3f9dfd566mr638240755d.7.1730236582611; 
 Tue, 29 Oct 2024 14:16:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgOmcFAnUN1KgLuP3yZyH/g++S30HGw1Ujy8xWARa1hYx5rmwLhGRQJDQtqAYoYiVkNtjEVA==
X-Received: by 2002:a05:6359:4105:b0:1b1:acd5:dd98 with SMTP id
 e5c5f4694b2df-1c3f9dfd566mr638236755d.7.1730236582196; 
 Tue, 29 Oct 2024 14:16:22 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46132292c97sm48481691cf.49.2024.10.29.14.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 14:16:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC v2 5/7] x86/iommu: Make x86-iommu a singleton object
Date: Tue, 29 Oct 2024 17:16:05 -0400
Message-ID: <20241029211607.2114845-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241029211607.2114845-1-peterx@redhat.com>
References: <20241029211607.2114845-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

X86 IOMMUs cannot be created more than one on a system yet.  Make it a
singleton so it guards the system from accidentally create yet another
IOMMU object when one already presents.

Now if someone tries to create more than one, e.g., via:

  ./qemu -M q35 -device intel-iommu -device intel-iommu

The error will change from:

  qemu-system-x86_64: -device intel-iommu: QEMU does not support multiple vIOMMUs for x86 yet.

To:

  qemu-system-x86_64: -device intel-iommu: Class 'intel-iommu' only supports one instance

Unfortunately, yet we can't remove the singleton check in the machine
hook (pc_machine_device_pre_plug_cb), because there can also be
virtio-iommu involved, which doesn't share a common parent class yet.

But with this, it should be closer to reach that goal to check singleton by
QOM one day.

Note: after this patch, x86_iommu_get_default() might be called very early,
even before machine is created (e.g., cmdline "-device intel-iommu,help").
In this case we need to be prepared with such, and that also means the
default iommu is not yet around.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/x86-iommu.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 60af896225..ec45b80306 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -26,6 +26,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "sysemu/kvm.h"
+#include "qom/object_interfaces.h"
 
 void x86_iommu_iec_register_notifier(X86IOMMUState *iommu,
                                      iec_notify_fn fn, void *data)
@@ -79,9 +80,15 @@ void x86_iommu_irq_to_msi_message(X86IOMMUIrq *irq, MSIMessage *msg_out)
 
 X86IOMMUState *x86_iommu_get_default(void)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
-    PCMachineState *pcms =
-        PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
+    Object *machine = qdev_get_machine();
+    PCMachineState *pcms;
+
+    /* If machine has not been created, so is the vIOMMU */
+    if (!machine) {
+        return NULL;
+    }
+
+    pcms = PC_MACHINE(object_dynamic_cast(machine, TYPE_PC_MACHINE));
 
     if (pcms &&
         object_dynamic_cast(OBJECT(pcms->iommu), TYPE_X86_IOMMU_DEVICE)) {
@@ -133,10 +140,19 @@ static Property x86_iommu_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static Object *x86_iommu_get_instance(void)
+{
+    return object_ref(OBJECT(x86_iommu_get_default()));
+}
+
 static void x86_iommu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    SingletonClass *singleton = SINGLETON_CLASS(klass);
+
     dc->realize = x86_iommu_realize;
+    singleton->get_instance = x86_iommu_get_instance;
+
     device_class_set_props(dc, x86_iommu_properties);
 }
 
@@ -152,6 +168,10 @@ static const TypeInfo x86_iommu_info = {
     .class_init    = x86_iommu_class_init,
     .class_size    = sizeof(X86IOMMUClass),
     .abstract      = true,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_SINGLETON },
+        { }
+    }
 };
 
 static void x86_iommu_register_types(void)
-- 
2.45.0


