Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E0FCE8E96
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 16:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4196-0003wR-In; Thu, 24 Oct 2024 12:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t418a-0003tx-Sl
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 12:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t418Y-0002we-JN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 12:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729788996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0kLRIPNRsyiUEIuptSmNc8rruH765h3xOHpyL+r4uw=;
 b=SFztNE60EY86SVUKL/uWH5gxEz4x8TpJNJfJQ/snsg+LcPvKqdOOyzupxU332s7RoevEov
 FlKj60pmLwkX4M7yK6PcrZmZmbPc6aUO8FxmIHwIOddpX8hyEO0K/yyHin0vEoHUDiNcH/
 M1xp6XtwJwt+lmHMYLSvBev+IbOSQOA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-fAtS33IKPi63denm6uL7yw-1; Thu, 24 Oct 2024 12:56:35 -0400
X-MC-Unique: fAtS33IKPi63denm6uL7yw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cdf0589e8aso15307156d6.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 09:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729788994; x=1730393794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0kLRIPNRsyiUEIuptSmNc8rruH765h3xOHpyL+r4uw=;
 b=n0uPClROqKuXG7wr4SP5xdFg1oO15GmwS3bnQqNEPqeYYqC9YY23/WRwUbI0vobCIR
 AYTYLzXn3laZz5quxVVcmNY2N0Rwqx+j9SJsVmbSgr6l7aKPXZ/5ontUJlU6i98g1zNk
 CuqEZ0pLM86iwYo1jcVzP5aCuDVpVDrAPaWD2wxhIKBxZI8kBBetmF0+94Fs6DZWwDZ6
 GtESv211L6XejDB6COxCi14cKZefDPFQhRd8AV5GUCifLCaZev64hb6H9olAawUIHnad
 d5mj4R7wM91C4576JaGdCDiM6BZgIxU15WLGRn3kmFpr82GVhBEtu0OiKnoNPecqKalB
 mW1A==
X-Gm-Message-State: AOJu0YxQ/c7+vupOr9SeEdh97rCDB/J4lgjARWMUMKs0uCYeLCclTz8O
 0icwn9GTGzbgOnsCh8XjM29pwJq/eJw/G/HypW687Kus2mduaOltbwYyReqnGG+PJm3p6t3585z
 +YFZEzOVMF1sxjs/VJgVOE5FgxUt0czTXDcpBpq0g8r28g+NimfEkgjDXYCisb0OgPn40crY5Ol
 +HMtMgVWHev+YqUevDpXq4DrYgQKIX4qhd3A==
X-Received: by 2002:a05:6214:4b08:b0:6ce:d6c:499b with SMTP id
 6a1803df08f44-6ce3427b2d2mr79501936d6.42.1729788994212; 
 Thu, 24 Oct 2024 09:56:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4neWev4q6Z4s9HREWkITl0xNMDbmLGQIm86O/0DXT0Uyol03xhdKJKN0gtBVqo6enK+iUNQ==
X-Received: by 2002:a05:6214:4b08:b0:6ce:d6c:499b with SMTP id
 6a1803df08f44-6ce3427b2d2mr79501606d6.42.1729788993831; 
 Thu, 24 Oct 2024 09:56:33 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008aff31sm51871076d6.12.2024.10.24.09.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 09:56:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/4] x86/iommu: Make x86-iommu a singleton object
Date: Thu, 24 Oct 2024 12:56:25 -0400
Message-ID: <20241024165627.1372621-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241024165627.1372621-1-peterx@redhat.com>
References: <20241024165627.1372621-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/x86-iommu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 60af896225..4bfeb08705 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -26,6 +26,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "sysemu/kvm.h"
+#include "qom/object_interfaces.h"
 
 void x86_iommu_iec_register_notifier(X86IOMMUState *iommu,
                                      iec_notify_fn fn, void *data)
@@ -133,10 +134,19 @@ static Property x86_iommu_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static Object *x86_iommu_get_instance(Error **errp)
+{
+    return OBJECT(x86_iommu_get_default());
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
 
@@ -152,6 +162,10 @@ static const TypeInfo x86_iommu_info = {
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


