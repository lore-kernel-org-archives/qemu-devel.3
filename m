Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BADEC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnelV-00006S-Up; Thu, 27 Feb 2025 09:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnel6-0007sD-DA
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnel3-0003ra-Cg
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxYYY1R7biz/YFz8OOn3xrn4YUgJT/5akSv9YjxqfqA=;
 b=J6/uHhb87Tv6c8wm0IR7tLWF0QpISWJpZsEhg3iwpr5Ri/GVQx8IY1nW2b42bgF4a2zffQ
 Ue6FERRqcKGvN83dwNpv/kF24F4TeTgp1t/P8NBnIuj9aIlhXe/h2AD6x0+Kvw85juAQZt
 bkPSZ8rgkwPdMw43WdHsT5hHeU7Xwjw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-DIR0lcozOUKqRndGKx9XJg-1; Thu, 27 Feb 2025 09:20:59 -0500
X-MC-Unique: DIR0lcozOUKqRndGKx9XJg-1
X-Mimecast-MFC-AGG-ID: DIR0lcozOUKqRndGKx9XJg_1740666057
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-abb61c30566so93541766b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666056; x=1741270856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxYYY1R7biz/YFz8OOn3xrn4YUgJT/5akSv9YjxqfqA=;
 b=dv83nZ1TnZasMO81CvhKve9sVG6s227WpjeGe/HPgbb313KBPcpYLuIUyhQrsESTZX
 shWIavKXQYlZiZ3Mgy8x0u0F1p/CMhQTZ1c6OuvBTv4PuhB+6kKfcc+lClLoJlMfI9Av
 avRZHqeBLtVtmN0aIAf+49mwQfClW3swthRnniVtt5dXdmElUBcT1uxkC21CDrO7dCZQ
 Nqb+dK+q79KuwZQ9YXSvzc1iTH7poMceSdilYwAe/4Z2SfrPJYUReLTKIauFxJ8vqI7Q
 AjvusNNOjM02vm+h0NqLusnM0tFOqBAvKq+dgFsjbBEY+GH0Ks6ntKOqIHK7WUtuPf2B
 iqBQ==
X-Gm-Message-State: AOJu0YyJbMUOyvTs+NO6rWbRVy447ILOi0Mswv2nMOZ6KEeuYebERbXG
 xKWhsG4IcBxY+/fQnP5jE3+R7gQESeNoA/gKDGUgujGVYQKDGPZ0ChqFhO6JtYdytBvJYC8Pm2n
 rcKAFp8l0XmMrl3fH2VILykTNApY0lxi0g0UkZOgma6Ki3gi7jfUDX4kDcWfoE3xZBuhApfPWq+
 7Y8G4q0JImalmr/RFvk3VW5AWPBz/NO0IsXV0xX8g=
X-Gm-Gg: ASbGncuZyXZY5J3FPbcyx/Z5v1jBF4CmQqeHKlHPqcF8Cs4abynEWvcY1PBb14EVUNA
 ObVZeO/OHP5cSOqhcL5MtG2NX5wiaUg11mzeuqBg53Eyto4/vgVZbR3z/zv9y+9SNRIRN7WQfdz
 b2T3mkpn0INemVTOV/rLgwO2qkvRndYlX4Y2ecOhb6Lba+EzOOTUBbwhlY6iXOtD6L0X7F9Vtrp
 9ZQTfCV1/wjelcz2XtjpMtZR1/jr+P/JZhUFmJ7ttJfsQcy34+w/Gxr7xphmGy3lP795aNyXi08
 PXcpoy7JPB8XYRwDyr81
X-Received: by 2002:a17:907:c407:b0:abc:4b7:e3d3 with SMTP id
 a640c23a62f3a-abeeedcfecbmr1035342766b.27.1740666055907; 
 Thu, 27 Feb 2025 06:20:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbnHBHIeA7vDAqGtZEUn8x3VOIc4qFSRAuXBDdTB6Angr8zSECngHltyIUGtquqaCepK9zNg==
X-Received: by 2002:a17:907:c407:b0:abc:4b7:e3d3 with SMTP id
 a640c23a62f3a-abeeedcfecbmr1035339566b.27.1740666055459; 
 Thu, 27 Feb 2025 06:20:55 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c6ee4b3sm127042766b.112.2025.02.27.06.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alireza Sanaee <alireza.sanaee@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 28/34] i386/cpu: add has_caches flag to check smp_cache
 configuration
Date: Thu, 27 Feb 2025 15:19:46 +0100
Message-ID: <20250227141952.811410-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Alireza Sanaee <alireza.sanaee@huawei.com>

Add has_caches flag to SMPCompatProps, which helps in avoiding
extra checks for every single layer of caches in x86 (and ARM in
future).

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/r/20250110145115.1574345-6-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/boards.h   |  3 +++
 hw/core/machine-smp.c |  2 ++
 target/i386/cpu.c     | 11 +++++------
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 9360d1ce394..f22b2e7fc75 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -156,6 +156,8 @@ typedef struct {
  * @modules_supported - whether modules are supported by the machine
  * @cache_supported - whether cache (l1d, l1i, l2 and l3) configuration are
  *                    supported by the machine
+ * @has_caches - whether cache properties are explicitly specified in the
+ *               user provided smp-cache configuration
  */
 typedef struct {
     bool prefer_sockets;
@@ -166,6 +168,7 @@ typedef struct {
     bool drawers_supported;
     bool modules_supported;
     bool cache_supported[CACHE_LEVEL_AND_TYPE__MAX];
+    bool has_caches;
 } SMPCompatProps;
 
 /**
diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 4e020c358b6..0be0ac044c2 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -332,6 +332,8 @@ bool machine_parse_smp_cache(MachineState *ms,
             return false;
         }
     }
+
+    mc->smp_props.has_caches = true;
     return true;
 }
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 005ca4235df..2f9c604552b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8203,13 +8203,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
     MachineState *ms = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
 
-    /*
-     * TODO: Add a SMPCompatProps.has_caches flag to avoid useless updates
-     * if user didn't set smp_cache.
-     */
-    if (!x86_cpu_update_smp_cache_topo(ms, cpu, errp)) {
-        return;
+    if (mc->smp_props.has_caches) {
+        if (!x86_cpu_update_smp_cache_topo(ms, cpu, errp)) {
+            return;
+        }
     }
 
     qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
-- 
2.48.1


