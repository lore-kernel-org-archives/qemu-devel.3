Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AEDC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66mn-0003K0-38; Sun, 12 May 2024 06:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mh-0003I8-PS
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mc-0005yp-6B
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gfN5pIMWePirJMYr8BLI6kCZBJjEIGwqQo+31f8yoso=;
 b=NZLPMaqgDrxSOsBqY5GnjUsN/z4lU5yLhTrDaHCeVPT94nHaryyPOos10gwkcegKwOo3q4
 3RokoXaUlhGK4/tZ3FA53R1oLDLfa14BZxUxSB57V2yQUbyGgrLJTa61aGC8Dv+cGIr35/
 hI4aS+GacAC+pLyPN1Z3Ucckyt9nC8g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-FwzJYihPN_mw7YOdGf24FQ-1; Sun, 12 May 2024 06:50:18 -0400
X-MC-Unique: FwzJYihPN_mw7YOdGf24FQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59a5b06802so183941066b.1
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511017; x=1716115817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gfN5pIMWePirJMYr8BLI6kCZBJjEIGwqQo+31f8yoso=;
 b=gDPTNO7Nyr5o3PE45HuDkrH4BzT912aA+rOAfMYPVRoQyTZsTaU7+Zwq6l3nTMEq4G
 xrXZVUKsCj9zIL3CvzI4/BLT5UFLn0Oc/j8lNgog5JfnnGPoVST+tslBtM1dEJcAs1FD
 udHUqsrco3Ii7Eot8X8XddX8bOHlT8VbOBewPhWo3JNShyHmpc+hrHsu8ECBPLt7kzFP
 eAwtASBoH91kdZNsBhaz0+d56ID67jRYnoAlYIHeDvgVQy/eExJVDruJeT1QUcnRX10g
 vHPP/n1sgNYqTec8H7z0b2ZFunBh/BMaP0ShXbCUMcrxLqZy1qZvo2vn9crIc/kWsg1a
 kJVw==
X-Gm-Message-State: AOJu0Yw9ZM4TOECn6pgqwxq2SaEzTQq15DZwDAeiBVtsd07CYHLadwm7
 uXFMHGs5zDkmERJdbOhx+XejemkkQK08O23wukqN8Ih981wLPCF77EOOKNQNyhzQytPUMA0amqX
 QNB3Lzml+YeZRDEVjfXOnx1JAlD6zv21mFgieLA9RqX789KW+KARK+iC000tYkqFE9ThhXtdVdi
 YCpkM3T8YcC34x72pT+NC/efyZ5qNXrO/MvZwJ
X-Received: by 2002:a17:906:13c8:b0:a59:cbb5:e09e with SMTP id
 a640c23a62f3a-a5a2d6669b6mr458407766b.58.1715511016928; 
 Sun, 12 May 2024 03:50:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTBdq/PtFKE3Kd5gsBGvxpmDaY7rjCnTkAsGbZEyLx7yRKhUaLxtf+NaWp/QmaT9JlCcFHAQ==
X-Received: by 2002:a17:906:13c8:b0:a59:cbb5:e09e with SMTP id
 a640c23a62f3a-a5a2d6669b6mr458407266b.58.1715511016463; 
 Sun, 12 May 2024 03:50:16 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a534bfb05sm182150566b.36.2024.05.12.03.50.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/27] s390: move css_migration_enabled from machine to css.c
Date: Sun, 12 May 2024 12:49:29 +0200
Message-ID: <20240512104945.130198-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
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

The CSS subsystem uses global variables, just face the truth and use
a variable also for whether the CSS vmstate is in use; remove the
indirection of fetching it from the machine type, which makes the
TCG code depend unnecessarily on the virtio-ccw machine.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240509170044.190795-4-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/s390x/css.h             |  6 ++++++
 include/hw/s390x/s390-virtio-ccw.h |  7 -------
 hw/s390x/css.c                     | 10 +++++++---
 hw/s390x/s390-virtio-ccw.c         | 15 +++------------
 4 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index ba72ee3dd20..8289e458370 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -333,4 +333,10 @@ static inline int ccw_dstream_read_buf(CcwDataStream *cds, void *buff, int len)
 #define ccw_dstream_read(cds, v) ccw_dstream_read_buf((cds), &(v), sizeof(v))
 #define ccw_dstream_write(cds, v) ccw_dstream_write_buf((cds), &(v), sizeof(v))
 
+/**
+ * true if (vmstate based) migration of the channel subsystem
+ * is enabled, false if it is disabled.
+ */
+extern bool css_migration_enabled;
+
 #endif
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 7605d06bff1..996864a34e2 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -46,7 +46,6 @@ struct S390CcwMachineClass {
     /*< public >*/
     bool ri_allowed;
     bool cpu_model_allowed;
-    bool css_migration_enabled;
     bool hpage_1m_allowed;
     int max_threads;
 };
@@ -58,10 +57,4 @@ bool cpu_model_allowed(void);
 /* 1M huge page mappings allowed by the machine */
 bool hpage_1m_allowed(void);
 
-/**
- * Returns true if (vmstate based) migration of the channel subsystem
- * is enabled, false if it is disabled.
- */
-bool css_migration_enabled(void);
-
 #endif
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 295530963a6..b2d5327dbf4 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -23,6 +23,8 @@
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-ccw.h"
 
+bool css_migration_enabled = true;
+
 typedef struct CrwContainer {
     CRW crw;
     QTAILQ_ENTRY(CrwContainer) sibling;
@@ -180,7 +182,7 @@ static const VMStateDescription vmstate_orb = {
 
 static bool vmstate_schdev_orb_needed(void *opaque)
 {
-    return css_migration_enabled();
+    return css_migration_enabled;
 }
 
 static const VMStateDescription vmstate_schdev_orb = {
@@ -388,7 +390,7 @@ static int subch_dev_post_load(void *opaque, int version_id)
         css_subch_assign(s->cssid, s->ssid, s->schid, s->devno, s);
     }
 
-    if (css_migration_enabled()) {
+    if (css_migration_enabled) {
         /* No compat voodoo to do ;) */
         return 0;
     }
@@ -412,7 +414,9 @@ static int subch_dev_post_load(void *opaque, int version_id)
 
 void css_register_vmstate(void)
 {
-    vmstate_register(NULL, 0, &vmstate_css, &channel_subsys);
+    if (css_migration_enabled) {
+        vmstate_register(NULL, 0, &vmstate_css, &channel_subsys);
+    }
 }
 
 IndAddr *get_indicator(hwaddr ind_addr, int len)
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 756b4f40aed..3d0bc3e7f2e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -283,11 +283,9 @@ static void ccw_init(MachineState *machine)
     s390_enable_css_support(s390_cpu_addr2state(0));
 
     ret = css_create_css_image(VIRTUAL_CSSID, true);
-
     assert(ret == 0);
-    if (css_migration_enabled()) {
-        css_register_vmstate();
-    }
+
+    css_register_vmstate();
 
     /* Create VirtIO network adapters */
     s390_create_virtio_net(BUS(css_bus), mc->default_nic);
@@ -749,7 +747,6 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
 
     s390mc->ri_allowed = true;
     s390mc->cpu_model_allowed = true;
-    s390mc->css_migration_enabled = true;
     s390mc->hpage_1m_allowed = true;
     s390mc->max_threads = 1;
     mc->init = ccw_init;
@@ -819,11 +816,6 @@ static const TypeInfo ccw_machine_info = {
     },
 };
 
-bool css_migration_enabled(void)
-{
-    return get_machine_class()->css_migration_enabled;
-}
-
 #define DEFINE_CCW_MACHINE(suffix, verstr, latest)                            \
     static void ccw_machine_##suffix##_class_init(ObjectClass *oc,            \
                                                   void *data)                 \
@@ -1179,7 +1171,6 @@ static void ccw_machine_2_9_instance_options(MachineState *machine)
 
 static void ccw_machine_2_9_class_options(MachineClass *mc)
 {
-    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
     static GlobalProperty compat[] = {
         { TYPE_S390_STATTRIB, "migration-enabled", "off", },
         { TYPE_S390_FLIC_COMMON, "migration-enabled", "off", },
@@ -1188,7 +1179,7 @@ static void ccw_machine_2_9_class_options(MachineClass *mc)
     ccw_machine_2_10_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-    s390mc->css_migration_enabled = false;
+    css_migration_enabled = false;
 }
 DEFINE_CCW_MACHINE(2_9, "2.9", false);
 
-- 
2.45.0


