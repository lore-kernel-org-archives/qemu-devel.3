Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BB4D743E5
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 21:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDshg-00005o-Jv; Wed, 20 Nov 2024 16:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshX-0008S8-KE
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshW-0006U7-5E
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732139849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpJER/wYd4T6D0J0YdjUL6DwWyjfFMtJPuGjw2kdAM8=;
 b=ibTOfJXerwfMUrSzcm1Dy3YilehpKesAmz/+7R+prpMK3eT2LfG9Gg+x6GBEfLlf2U9FrV
 q2B/rfcL4U+GaQf1az40zhqtI+K9DXqlNKRMsRXY+VpqwxtK9kn51kwNNnYuJiuMReBuzj
 FHJ5RpRQ7ySFT7WStmdo10C5gXnv5qc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-NYDU3bSZPxConvnsTgXwKg-1; Wed, 20 Nov 2024 16:57:28 -0500
X-MC-Unique: NYDU3bSZPxConvnsTgXwKg-1
X-Mimecast-MFC-AGG-ID: NYDU3bSZPxConvnsTgXwKg
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4608d303ebeso2903581cf.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 13:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732139847; x=1732744647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpJER/wYd4T6D0J0YdjUL6DwWyjfFMtJPuGjw2kdAM8=;
 b=l2F1Q3B0vToOzGmcqdJHUZS+ZZPEc+udYgtm8wesNbbba7opI+EABnl7RNv0W09eV7
 jcaePaHy/hCubvqErrNsgvh5BOSr7uOXcxJ44E03T4zGd4/l9SoPbkzb6L8eUge5Wcbv
 ez9bPZKphLA0CxKI8EFDMx8qkZVxrH4AgYVZW00X3Ndx7ur70E1B8XK11IGKfd7/wyji
 RQHjyJuPV6vOnAIb6mr0riilatTP1MgGnUV1GHxD2om7POjp/PEshYxp665xjXE7C/Zb
 YQQzYRjmjICa26NdcBHjL8lnSZa2eXN6w4UzKvHksUXqDVHivGt0BKeVdG/okXdn2ruz
 fe2w==
X-Gm-Message-State: AOJu0Yy/WFvXYo1jtMwTcvDKqzPYC4lpTYx1aagiMit7rXJnFWEegFNB
 IL3Q9ykZVFgc6xbbH2LT+0gPn/pZPdxe5xGgOfEeXE4hlh7M5eFqGLb4tkq+gTmQn4AVKtsx4xk
 vQGaYjlrKMQCZl1H6ADe+NfAwg3zuhGC+VU6RTOEMCJ+sBziREIX/WhKtGkRwHIZzsb5Xn+Mhbs
 wCt8G5j7SH4cXxwj91ezB6cnd4uqEjBWJq7w==
X-Received: by 2002:a05:622a:1929:b0:461:22f1:dd17 with SMTP id
 d75a77b69052e-46479b3f8famr51132001cf.41.1732139847288; 
 Wed, 20 Nov 2024 13:57:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEixnMe5QzRr4geZePKFKIi+MNm54MALeM743Sq2Y7/tNWRPgLBq0p7RifvgnSyJKoYDuraEA==
X-Received: by 2002:a05:622a:1929:b0:461:22f1:dd17 with SMTP id
 d75a77b69052e-46479b3f8famr51131671cf.41.1732139846879; 
 Wed, 20 Nov 2024 13:57:26 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-464680d6826sm14632881cf.15.2024.11.20.13.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 13:57:26 -0800 (PST)
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
Subject: [PATCH 10/12] qom: Create system containers explicitly
Date: Wed, 20 Nov 2024 16:57:01 -0500
Message-ID: <20241120215703.3918445-11-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241120215703.3918445-1-peterx@redhat.com>
References: <20241120215703.3918445-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Always explicitly create QEMU system containers upfront.

Root containers will be created when trying to fetch the root object the
1st time.  Machine sub-containers will be created only until machine is
being initialized.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/machine.c | 19 ++++++++++++++++---
 qom/object.c      | 16 +++++++++++++++-
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index a35c4a8fae..a184dbf8f0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1193,14 +1193,27 @@ static void machine_class_base_init(ObjectClass *oc, void *data)
     }
 }
 
+const char *machine_containers[] = {
+    "unattached",
+    "peripheral",
+    "peripheral-anon"
+};
+
+static void qemu_create_machine_containers(Object *machine)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(machine_containers); i++) {
+        container_create(machine, machine_containers[i]);
+    }
+}
+
 static void machine_initfn(Object *obj)
 {
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
 
-    container_get(obj, "/peripheral");
-    container_get(obj, "/peripheral-anon");
-
+    qemu_create_machine_containers(obj);
     ms->dump_guest_core = true;
     ms->mem_merge = (QEMU_MADV_MERGEABLE != QEMU_MADV_INVALID);
     ms->enable_graphics = true;
diff --git a/qom/object.c b/qom/object.c
index 214d6eb4c1..810e6f2bd9 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1734,12 +1734,26 @@ const char *object_property_get_type(Object *obj, const char *name, Error **errp
     return prop->type;
 }
 
+static Object *object_root_initialize(void)
+{
+    Object *root = object_new(TYPE_CONTAINER);
+
+    /*
+     * Create all QEMU system containers.  "machine" and its sub-containers
+     * are only created when machine initializes (qemu_create_machine()).
+     */
+    container_create(root, "chardevs");
+    container_create(root, "objects");
+
+    return root;
+}
+
 Object *object_get_root(void)
 {
     static Object *root;
 
     if (!root) {
-        root = object_new(TYPE_CONTAINER);
+        root = object_root_initialize();
     }
 
     return root;
-- 
2.45.0


