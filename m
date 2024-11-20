Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7E1D743E7
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 21:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDshS-0008HS-HD; Wed, 20 Nov 2024 16:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshP-0008Cl-0U
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshM-0006Mz-19
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732139832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=payjPLYurKI+5/EKzyakmMM06dc3GEHFTxopaOn1dX4=;
 b=KCID8AoISrVxcJBLjeFUqmtEj/m31m5WWG73J58bLfZRgDEaildhG4cTBcVtFnaEBVw9FF
 5CcsazBRYgFXO5MYaNtBiYTHtrGT5fNGnl+iDn18Nvs7hqXLuMSrbEYlb+mEp0szFtF7Vf
 fc4pk2UpESEvlHFZx30TgD80Sgn5xlk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-S0lWEthfPmOCvB4Ne_cZNQ-1; Wed, 20 Nov 2024 16:57:10 -0500
X-MC-Unique: S0lWEthfPmOCvB4Ne_cZNQ-1
X-Mimecast-MFC-AGG-ID: S0lWEthfPmOCvB4Ne_cZNQ
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-461011bd338so2674271cf.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 13:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732139829; x=1732744629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=payjPLYurKI+5/EKzyakmMM06dc3GEHFTxopaOn1dX4=;
 b=T9+IIBEwjOs18DaPop0IIu9Qccm4K8C9/Sl/odk/8XQvr07YB38OSLazf3g5l31ccb
 m31vI5r59jR8VwDRjHkJSym2C+u1i8K0SRN9z69Wxici1szqb813rGwVx4DDiiclvkRS
 /buSOSmpc4ZYByl+DbS0FNZyGUR5jXpI1blT90HhmwUM+CD8KRpcaJ3lDw07wcgL0PDa
 aUFc8uzYsuNUskU92Rx1zU3CDzyYIvIW02793ynbtPaMWw0uJjvzEijf7+8wMFPgzz7Y
 6yN/H+ODYr6xtXNN8lcWSDO9KIrxBGOxbPkC+cQ9jQalRmicG/mjVmADZJnO4fZLORXy
 xT2w==
X-Gm-Message-State: AOJu0YwSTl9CgZ0/Rj3/I9QOTVDTpMYz5kd9hf2nXsFbZ5GA5vk5y8Vb
 kMqZhSQrzaxg+aBOjFAgRV5DX8OnzkgUOo/PvhV37dSx3Vl7OtBPhz041jTSNp7iHCd1SMCoEEO
 iuI4RNhzXLb1kSJ0UhLw+yD7KEvVRv5hE3q7PAqQYtyZcm0+ggv68PP0igMsstEEtZ7k1dfW4MO
 GonWVRWQgHXkVVtv3lKFAYWWxB8NHG44iP2w==
X-Received: by 2002:a05:622a:19a9:b0:460:9318:e4bb with SMTP id
 d75a77b69052e-464782a73f5mr50726211cf.9.1732139829412; 
 Wed, 20 Nov 2024 13:57:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqYI4EbGa+pBwIBfzwW5MC23IJ6t+sM9r88rOhppSXbuA/5zJfuC7qcJOrRWZH7UTWZJDZqg==
X-Received: by 2002:a05:622a:19a9:b0:460:9318:e4bb with SMTP id
 d75a77b69052e-464782a73f5mr50725931cf.9.1732139829066; 
 Wed, 20 Nov 2024 13:57:09 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-464680d6826sm14632881cf.15.2024.11.20.13.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 13:57:08 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 01/12] qom: Add TYPE_CONTAINER macro
Date: Wed, 20 Nov 2024 16:56:52 -0500
Message-ID: <20241120215703.3918445-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241120215703.3918445-1-peterx@redhat.com>
References: <20241120215703.3918445-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Provide a macro for the container type across QEMU source tree, rather than
hard code it every time.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qom/object.h | 1 +
 hw/arm/stellaris.c   | 2 +-
 qom/container.c      | 4 ++--
 qom/object.c         | 4 ++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 43c135984a..3ba370ce9b 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -26,6 +26,7 @@ typedef struct InterfaceClass InterfaceClass;
 typedef struct InterfaceInfo InterfaceInfo;
 
 #define TYPE_OBJECT "object"
+#define TYPE_CONTAINER "container"
 
 typedef struct ObjectProperty ObjectProperty;
 
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 376746251e..6d518b9cde 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1053,7 +1053,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     flash_size = (((board->dc0 & 0xffff) + 1) << 1) * 1024;
     sram_size = ((board->dc0 >> 18) + 1) * 1024;
 
-    soc_container = object_new("container");
+    soc_container = object_new(TYPE_CONTAINER);
     object_property_add_child(OBJECT(ms), "soc", soc_container);
 
     /* Flash programming is done via the SCU, so pretend it is ROM.  */
diff --git a/qom/container.c b/qom/container.c
index 455e8410c6..cfec92a944 100644
--- a/qom/container.c
+++ b/qom/container.c
@@ -15,7 +15,7 @@
 #include "qemu/module.h"
 
 static const TypeInfo container_info = {
-    .name          = "container",
+    .name          = TYPE_CONTAINER,
     .parent        = TYPE_OBJECT,
 };
 
@@ -37,7 +37,7 @@ Object *container_get(Object *root, const char *path)
     for (i = 1; parts[i] != NULL; i++, obj = child) {
         child = object_resolve_path_component(obj, parts[i]);
         if (!child) {
-            child = object_new("container");
+            child = object_new(TYPE_CONTAINER);
             object_property_add_child(obj, parts[i], child);
             object_unref(child);
         }
diff --git a/qom/object.c b/qom/object.c
index 9edc06d391..214d6eb4c1 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1739,7 +1739,7 @@ Object *object_get_root(void)
     static Object *root;
 
     if (!root) {
-        root = object_new("container");
+        root = object_new(TYPE_CONTAINER);
     }
 
     return root;
@@ -1755,7 +1755,7 @@ Object *object_get_internal_root(void)
     static Object *internal_root;
 
     if (!internal_root) {
-        internal_root = object_new("container");
+        internal_root = object_new(TYPE_CONTAINER);
     }
 
     return internal_root;
-- 
2.45.0


