Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9365CE8E97
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 16:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t419O-0003zg-Sv; Thu, 24 Oct 2024 12:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t418b-0003u0-FS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 12:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t418Z-0002x3-Il
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 12:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729788998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FhBOPpVeD7iY6TuhvhvNePic6DBQmZNqw1nKL+DgVvE=;
 b=Cu6C4CJk7qZoW/Fq+eQYjMlul75DwdFq/nIgmqftx1RTnoVsckdsXjUPmhSCO77kTKWOi5
 fil6DxuzxJzIegySpTSumdTFqvsonR3GHH+M5f9g+pwess8Jcy2E/ilTqLB8XqKWhAlQl+
 X1qha0yH1OZ6eLsUnWpvaztTM6vk75Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-ZnWsICb5NdCLim05iF6yNQ-1; Thu, 24 Oct 2024 12:56:37 -0400
X-MC-Unique: ZnWsICb5NdCLim05iF6yNQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cbd12b8b60so48383456d6.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 09:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729788996; x=1730393796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FhBOPpVeD7iY6TuhvhvNePic6DBQmZNqw1nKL+DgVvE=;
 b=Cj8PxsuCgkDvN7pQQipFW19BzIa1PdEI/9g4DoQOQxB/UIJyDKmVBWomnrsmrmnwoK
 vYi28HVx6gE1kEh8injgF/vWUnj3Vd/4mD4dz//9cHrt8i5aZlZ9yk1sfCfCAhWE7Sl6
 xxaElUOklXUDH0YXFQbbU6WVR8b/tnJhG9GIlo+1o0q1I+ESpLBWZC67QZRg31DzgkcA
 kB6rQ3sGXzHf/RWm5Ywq3bxDTZlhEVXm3b8GxHJe1mw3TK5Az9ZA4WxG4/KQPOu/Rji7
 F5cJPMpFYxKb20kte4dojqDNb+KThSk5zVt4Je8ClceB8mm3U9zYp/RX6G+xM8WRhl/2
 B4Cw==
X-Gm-Message-State: AOJu0YwKSRuccNE+DuC9Uea+RraQKCBGhMAyfvhi0D0blzc6TPrYOqSm
 lhoUzANYKzB6sRo5Bu7yDjfv7Ad1CeTMA5tPV7fS6YQ2jHERJadriB1rag7FTdv6qo1/qnm4DsX
 NhgZymY1HhYw0oNMZ9QhqfoS48OemIFFpsb4ozYbpODkry7pE2nIaYMjpd4TO1huC284Zx7yukz
 0wVdjXBiKthZliAxZGdHod9djA0H2a1Et6lw==
X-Received: by 2002:a05:6214:449c:b0:6cb:f077:f2f7 with SMTP id
 6a1803df08f44-6d090405805mr38226036d6.25.1729788996255; 
 Thu, 24 Oct 2024 09:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEILwM8gPQuuRVNIvfejpUixJwOf0AOTdAVbVgV+KVZO5jm/Vc3z51bcXVSlC8K0c8vKLYi5w==
X-Received: by 2002:a05:6214:449c:b0:6cb:f077:f2f7 with SMTP id
 6a1803df08f44-6d090405805mr38225646d6.25.1729788995902; 
 Thu, 24 Oct 2024 09:56:35 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008aff31sm51871076d6.12.2024.10.24.09.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 09:56:34 -0700 (PDT)
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
Subject: [PATCH 3/4] migration: Make migration object a singleton object
Date: Thu, 24 Oct 2024 12:56:26 -0400
Message-ID: <20241024165627.1372621-4-peterx@redhat.com>
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

This makes the migration object a singleton unit.  After this, we can do
something slightly tricky later on with the guarantee that nobody will be
able to create the object twice.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index bcb735869b..1b5285af95 100644
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
@@ -3855,11 +3856,19 @@ fail:
     migrate_fd_cleanup(s);
 }
 
+static Object* migration_get_instance(Error **errp)
+{
+    return OBJECT(current_migration);
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
 
@@ -3932,6 +3941,10 @@ static const TypeInfo migration_type = {
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


