Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE1FD60CE7
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 22:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDA0D-0002bG-AX; Mon, 18 Nov 2024 17:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDA07-0002aR-1X
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 17:13:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDA04-0006Zu-HU
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 17:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731968019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rvaYzkABwcc7kfqRLG0tZ3qOOcMfe82+xegtXdgd9GA=;
 b=LQ65HS64dYDvC/K3CBweRONatUMOrV4xqAs4Tj6AMRK+tMp43OBftljRzE6ILQsCcrvsjG
 XQ6RMg9cmVC4H6Ug0lPciY6dQjIJWqoOdb9QkoZ/QSSkewfNekjwDkE5EZLuHBtOjH/kVS
 6Io3BJ7QHRj+P/zRgT+/OmK+RLyoQ3g=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-SBzsKQXNOriDZyaTqKXsbA-1; Mon, 18 Nov 2024 17:13:36 -0500
X-MC-Unique: SBzsKQXNOriDZyaTqKXsbA-1
X-Mimecast-MFC-AGG-ID: SBzsKQXNOriDZyaTqKXsbA
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-83abf68e7ffso33578939f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 14:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731968015; x=1732572815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvaYzkABwcc7kfqRLG0tZ3qOOcMfe82+xegtXdgd9GA=;
 b=OWRmDt9cRgX/bd6rdJxAoSW0g10Ci6I82jw95kChgEtUL+GbmMyCDZH/7X7H5hTbk0
 8q3fJV3sj/YGCCYh+w3ss/2SMXG2JY7lMU+KdAYv9zWhUKrlAy2Hm4LaAWceYebYZ+oi
 05/XVFzCUKTI9zq6ddbQ2mL4Om7SOMm+vC79oJmmRjWZKnLwGP2acdytVd+wYyvHULFI
 waUbfliaTOjrf4P1baqJAu6JXEH/8dEi43PP6dcd6xBKYqLRWm4RtyVzIlEPs4mYvZzT
 ppJFW0mK3xDpcPSmcaYGotgVZ+XK7AbgJpsU22tzoQJGq8co86w1rOgYHlJ2cUS6d6Q+
 2C2w==
X-Gm-Message-State: AOJu0YxtprWVKxuq79DMq0t495LsK+837Y6LQknHLqiHcPdZ4SrQesSZ
 xlVaYoV92ZqOB5vRASHwYyFhcbp9DewKJlSDO1AcdJ7oJk2ax5YNhHIYnRM7qX4IN4H5igxqSnd
 KUnqmbspH4xneb1nP1sEjXT8vPKDy+ZscfvgvgEiw5Ttaub0H7tbYsfXcRGi9qVzC8N5aumc5Xn
 cam60Ka1eGNnbTS4Z5fd6HhaOU1VJSkV3vlQ==
X-Received: by 2002:a05:6602:6b84:b0:83b:a47c:dbfd with SMTP id
 ca18e2360f4ac-83e6c2980a3mr1516864839f.6.1731968015049; 
 Mon, 18 Nov 2024 14:13:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqBG1Wj4QVUd51AGP/xmfJV0eeVvMnq3sJYsZlQaJkNjbTwuJA1MT0Tlsux0NYQcKKct4q2g==
X-Received: by 2002:a05:6602:6b84:b0:83b:a47c:dbfd with SMTP id
 ca18e2360f4ac-83e6c2980a3mr1516861639f.6.1731968014741; 
 Mon, 18 Nov 2024 14:13:34 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e06d6e7fd9sm2298599173.9.2024.11.18.14.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 14:13:34 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/5] qom: Add TYPE_CONTAINER macro
Date: Mon, 18 Nov 2024 17:13:26 -0500
Message-ID: <20241118221330.3480246-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241118221330.3480246-1-peterx@redhat.com>
References: <20241118221330.3480246-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Provide a macro for the container type across QEMU source tree, rather than
hard code it every time.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qom/object.h | 3 ++-
 hw/arm/stellaris.c   | 2 +-
 qom/container.c      | 4 ++--
 qom/object.c         | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 43c135984a..8162a1ef17 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -25,7 +25,8 @@ typedef struct TypeInfo TypeInfo;
 typedef struct InterfaceClass InterfaceClass;
 typedef struct InterfaceInfo InterfaceInfo;
 
-#define TYPE_OBJECT "object"
+#define  TYPE_OBJECT                 "object"
+#define  TYPE_CONTAINER              "container"
 
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


