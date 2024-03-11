Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7FAC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngj-0000aM-8q; Mon, 11 Mar 2024 18:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjnga-0000XR-2y
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngY-00042S-2C
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WhLf5HZmmN9ikX3euKyXfeHxTjLkTSEYvxHa358xsjk=;
 b=Ywbn0TsKFnUBidh6lKaN+DjLO9ReSFwPXsDcrReXOf05/tZrLMd8x1QlCxg8C+Pb3eRFXf
 8KNJtXn3+e5T5YBd5NZ50quhymazs1nvRgh0a2nzJaFJwrOjYWYc9tewz+Jxblx8pygoSO
 +4ewmMtrSCEXUjdWzUWF07KJjibevb8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-A6ys1P3aN6W3rsEBNjPrdA-1; Mon, 11 Mar 2024 17:59:52 -0400
X-MC-Unique: A6ys1P3aN6W3rsEBNjPrdA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-690d3f5af86so4505686d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194391; x=1710799191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WhLf5HZmmN9ikX3euKyXfeHxTjLkTSEYvxHa358xsjk=;
 b=eOhAl6k7lYoN3ShhM+RfOkTnfKLl9TFAYtDQW8ATFcj9GLGovfzjg8k6oDrWooxCJ1
 60M1tL92tL9PuOuVWSR/TI9vAP/EbgTtF7o6LGcLlX09KIpPYhxQcdsnrDxJQm7tM4Yg
 uHOygOfNjVQnYLy09FP1JMYkcpg7Ctw6iso99y/9VRSmRKBKOka1j9g2se4fTKFr/v4T
 JfRqF8vnsTxZwp+jbWfbOGu5ffX9tQjvvaULuvWYLxuFI4878wqTBLFbH5oL6P8CCS3X
 HXvIVOZx4KtkgyH49k1yJPqHBDOsvztCspm6KCnKeBxhF8obzc5dE1lW+DYUnf2s9REB
 KsIw==
X-Gm-Message-State: AOJu0YzPd1zq2SaASiOlpW/xD+2pW81ym2ypvXPrQ2N0g0E8Xroc6A7t
 fHRb4BO9oABqHHdSiXy3K586oeaM6Br5kHYZCcHn+0C7ld+Fw1UYz8c53aAT59DXGPxsau6NBsP
 K9dvv3TR0818r6wquQT5D1eGTeTkOiN9f0MbsjAQy40/p3iIEZR0B0tNNiiCaqbmUkO1Di3F61X
 sno/E9jRzdShT99xUq2h2zDELVcHL5e4uwig==
X-Received: by 2002:a0c:f04a:0:b0:68f:dc8d:8ad3 with SMTP id
 b10-20020a0cf04a000000b0068fdc8d8ad3mr7986269qvl.0.1710194391071; 
 Mon, 11 Mar 2024 14:59:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJxKbmjh2sRX/zSB5/FmIRrIWBuL9JriqraGQcSeX+ou3L0u6BZg3VwVy/kBVQrXtpWumOBw==
X-Received: by 2002:a0c:f04a:0:b0:68f:dc8d:8ad3 with SMTP id
 b10-20020a0cf04a000000b0068fdc8d8ad3mr7986231qvl.0.1710194390151; 
 Mon, 11 Mar 2024 14:59:50 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:49 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 16/34] migration: export fewer options
Date: Mon, 11 Mar 2024 17:59:07 -0400
Message-ID: <20240311215925.40618-17-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

A small number of migration options are accessed by migration clients,
but to see them clients must include all of options.h, which is mostly
for migration core code.  migrate_mode() in particular will be needed by
multiple clients.

Refactor the option declarations so clients can see the necessary few via
misc.h, which already exports a portion of the client API.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/r/1710179319-294320-1-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/client-options.h | 24 ++++++++++++++++++++++++
 include/migration/misc.h           |  1 +
 migration/options.h                |  6 +-----
 hw/vfio/migration.c                |  1 -
 hw/virtio/virtio-balloon.c         |  1 -
 system/dirtylimit.c                |  1 -
 6 files changed, 26 insertions(+), 8 deletions(-)
 create mode 100644 include/migration/client-options.h

diff --git a/include/migration/client-options.h b/include/migration/client-options.h
new file mode 100644
index 0000000000..887fea1565
--- /dev/null
+++ b/include/migration/client-options.h
@@ -0,0 +1,24 @@
+/*
+ * QEMU public migration capabilities
+ *
+ * Copyright (c) 2012-2023 Red Hat Inc
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_MIGRATION_CLIENT_OPTIONS_H
+#define QEMU_MIGRATION_CLIENT_OPTIONS_H
+
+/* capabilities */
+
+bool migrate_background_snapshot(void);
+bool migrate_dirty_limit(void);
+bool migrate_postcopy_ram(void);
+bool migrate_switchover_ack(void);
+
+/* parameters */
+
+MigMode migrate_mode(void);
+
+#endif
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 5d1aa593ed..4c226a40bb 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -17,6 +17,7 @@
 #include "qemu/notify.h"
 #include "qapi/qapi-types-migration.h"
 #include "qapi/qapi-types-net.h"
+#include "migration/client-options.h"
 
 /* migration/ram.c */
 
diff --git a/migration/options.h b/migration/options.h
index 6ddd8dad9b..b6b69c2bb7 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -16,6 +16,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "migration/client-options.h"
 
 /* migration properties */
 
@@ -24,12 +25,10 @@ extern Property migration_properties[];
 /* capabilities */
 
 bool migrate_auto_converge(void);
-bool migrate_background_snapshot(void);
 bool migrate_block(void);
 bool migrate_colo(void);
 bool migrate_compress(void);
 bool migrate_dirty_bitmaps(void);
-bool migrate_dirty_limit(void);
 bool migrate_events(void);
 bool migrate_mapped_ram(void);
 bool migrate_ignore_shared(void);
@@ -38,11 +37,9 @@ bool migrate_multifd(void);
 bool migrate_pause_before_switchover(void);
 bool migrate_postcopy_blocktime(void);
 bool migrate_postcopy_preempt(void);
-bool migrate_postcopy_ram(void);
 bool migrate_rdma_pin_all(void);
 bool migrate_release_ram(void);
 bool migrate_return_path(void);
-bool migrate_switchover_ack(void);
 bool migrate_validate_uuid(void);
 bool migrate_xbzrle(void);
 bool migrate_zero_blocks(void);
@@ -84,7 +81,6 @@ uint8_t migrate_max_cpu_throttle(void);
 uint64_t migrate_max_bandwidth(void);
 uint64_t migrate_avail_switchover_bandwidth(void);
 uint64_t migrate_max_postcopy_bandwidth(void);
-MigMode migrate_mode(void);
 int migrate_multifd_channels(void);
 MultiFDCompression migrate_multifd_compression(void);
 int migrate_multifd_zlib_level(void);
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index f82dcabc49..49c0016add 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -18,7 +18,6 @@
 #include "sysemu/runstate.h"
 #include "hw/vfio/vfio-common.h"
 #include "migration/migration.h"
-#include "migration/options.h"
 #include "migration/savevm.h"
 #include "migration/vmstate.h"
 #include "migration/qemu-file.h"
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 89f853fa9e..a59ff172bd 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -32,7 +32,6 @@
 #include "qemu/error-report.h"
 #include "migration/misc.h"
 #include "migration/migration.h"
-#include "migration/options.h"
 
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index b5607eb8c2..774ff44f79 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -26,7 +26,6 @@
 #include "trace.h"
 #include "migration/misc.h"
 #include "migration/migration.h"
-#include "migration/options.h"
 
 /*
  * Dirtylimit stop working if dirty page rate error
-- 
2.44.0


