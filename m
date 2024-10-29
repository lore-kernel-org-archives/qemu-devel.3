Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E835BD74941
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 21:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5ta0-0002RZ-Ro; Tue, 29 Oct 2024 17:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tZm-0002NP-UT
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tZk-0007dC-R8
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730236587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1CHVDDrF1k42GawPCowe3EhPn3LYquuM+4EuRYWzKA=;
 b=AFPt7hWogpKGOOi0YJFkIS17CkMWgZshE2L424Dakde0xyaqyyxaUMfsE+n+2XPBvNgs/Q
 UKh9PDhKE8DswPpA//RVuDBYhoLspQWziY0+LuRc+IQgYn9/yvPYWrgySn/BivEjluOIlt
 WuISAcb9AkgMDbZO/ElO9so5M8O7Xqk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-WVpFe935PlWoiG7csGjArg-1; Tue, 29 Oct 2024 17:16:26 -0400
X-MC-Unique: WVpFe935PlWoiG7csGjArg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6e7f633af02so84445707b3.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 14:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730236585; x=1730841385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1CHVDDrF1k42GawPCowe3EhPn3LYquuM+4EuRYWzKA=;
 b=PKp66erBZh3lONwZnh9NKBkhztfQL08WKieGZfvZdV9y91IsAztCBItPbXOMJmKGSC
 Pd6sDu/ZP13g9cx08MqSYEiwrUkEutsjLUSW8UbafzYgYon1/A2NXIqH0tI08XSM9MMI
 ltOuj75U0pOKJxNMvp5QozduTGK4uj0+1VGp3d7vJUAyOcyFhn4/VqNqQW/aPREqPHVo
 NiOPsNNdO8D8ma9VLoIgdOBj70cDWAAU33NQ8TtbKV9/nTgoYof/An2/Qvq6bVJ1POqz
 VlrzPKuHymrbf6d2ZlXn0qXZ4GF6OGFv0xT2S38ibOs5VMUSFdgaM12ru4gfgp1gXxmM
 XUIA==
X-Gm-Message-State: AOJu0YwUpSoQY1UDC+cbvwP7+4oPlj063lAt03v67Ygi9jWmuuQ1oEJg
 eWX+s3ejhGIOU6vVlA2gy6gDnlGtpa/j5jhwf6ioS2mFyH0KLDlZbqxZ17Tof8LmbtI6LcpfAvG
 0P3eJTMwtvwtwtbuI3khu79gThNEvGF0CxSEjlycyoP5EOixeRYIQZuiPc4qHlYAjbReViDneIU
 GdC95gYtjPA5oIjRBtCmCV5HwROA2cXSq8Zw==
X-Received: by 2002:a05:6902:2e0d:b0:e2b:c7b1:eab8 with SMTP id
 3f1490d57ef6-e3087a5f2bbmr13742788276.21.1730236585013; 
 Tue, 29 Oct 2024 14:16:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG39Zo/f66f4fcqAxZX1cGZ5rwPvnu65EqXydG/X2GLh5J+HCuu3eFX2ObUm4PgdtLeet2FGQ==
X-Received: by 2002:a05:6902:2e0d:b0:e2b:c7b1:eab8 with SMTP id
 3f1490d57ef6-e3087a5f2bbmr13742753276.21.1730236584645; 
 Tue, 29 Oct 2024 14:16:24 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46132292c97sm48481691cf.49.2024.10.29.14.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 14:16:23 -0700 (PDT)
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
Subject: [PATCH RFC v2 6/7] migration: Make migration object a singleton object
Date: Tue, 29 Oct 2024 17:16:06 -0400
Message-ID: <20241029211607.2114845-7-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241029211607.2114845-1-peterx@redhat.com>
References: <20241029211607.2114845-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

This makes the migration object a singleton unit.  After this, we can do
something slightly tricky later on with the guarantee that nobody will be
able to create the object twice.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 021faee2f3..f4456f7142 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -45,6 +45,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qnull.h"
 #include "qemu/rcu.h"
+#include "qom/object_interfaces.h"
 #include "postcopy-ram.h"
 #include "qemu/thread.h"
 #include "trace.h"
@@ -3833,11 +3834,19 @@ fail:
     migrate_fd_cleanup(s);
 }
 
+static Object *migration_get_instance(void)
+{
+    return object_ref(OBJECT(current_migration));
+}
+
 static void migration_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    SingletonClass *singleton = SINGLETON_CLASS(klass);
 
     dc->user_creatable = false;
+    singleton->get_instance = migration_get_instance;
+
     device_class_set_props(dc, migration_properties);
 }
 
@@ -3910,6 +3919,10 @@ static const TypeInfo migration_type = {
     .instance_size = sizeof(MigrationState),
     .instance_init = migration_instance_init,
     .instance_finalize = migration_instance_finalize,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_SINGLETON },
+        { }
+    }
 };
 
 static void register_migration_types(void)
-- 
2.45.0


