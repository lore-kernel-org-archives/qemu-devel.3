Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26F5C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngp-0000kl-4U; Mon, 11 Mar 2024 18:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngb-0000XZ-65
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngZ-00042c-GC
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LdiPgufqKfGIeW6VzqT6zIl2qsu21GpUL7tBaZiFfOE=;
 b=BJKkRQGCdpZkaprjUv6R6t5oObcweoAc56PH9tezIWMaHFxLuVezbjtTZbmjCKDIVKLSaf
 VOMOhJ6w4vJuvBFEMr+o7xo0o/9myMGwqhIUPJOc3ImrOXqLP01PfdmkN3cB95+LGFzMt+
 3XTA73Cijx41yBdGHWJ0e/bZQ6xiFw8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668--flSIQIvPHaymtQ6WrMl9g-1; Mon, 11 Mar 2024 17:59:52 -0400
X-MC-Unique: -flSIQIvPHaymtQ6WrMl9g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-690ab2b0de1so15044076d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194392; x=1710799192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LdiPgufqKfGIeW6VzqT6zIl2qsu21GpUL7tBaZiFfOE=;
 b=LqY5dse8pQ56MXgIdH2GcOfj8ZcoKs+8QbzKWWVSxWCSOOwWt33BJPX7CV5seNR12+
 frdjILeoNBLz2QKur9ZrtdFaDxg5zezP3HrwxfHK2iu7074y41PjAQ4afjSsur+BHtBB
 im/mxNjS5ph6RoylixDgyoLfHMi1+Y4Bm8yWli/7ASBm+iZtaPK8zeLKHAUbASn1ekEB
 5tt+RyXbOeQwbkz8Xib0ENbGMNbUfiqIH88xVuXGO2TJuyCUbjoLeRk3fR/ldjbHDS2N
 c8mV5RfCXeAK8+HJCsgg7u2/5q6GGCldM7FhCgs9WVrxq2XKfBuEESB5F4rW2t8Cs1XG
 Bfuw==
X-Gm-Message-State: AOJu0Yw9QDZwFszSAvByFcUVUAg/tOo9y3Z9dN6DkLgKnhzmbGyDpNxD
 LU5E8f0rfVxlnNLcG+CWEtkeNcmI71+UKJlSDOyKowjqmwOI2hrSvnlE4WyRBPiYIXNPb1BOkcL
 0BCJwhUkTEU+zA8+ef71JC8DxgTPRxOSVO8IpO5JuoSR6+pnqhrAuTCZu5TxZfDTaFmeOJMlmMZ
 I+xiqxydw2mSDe7ltH5fIeLyxR13bLY8vo5w==
X-Received: by 2002:a0c:ea50:0:b0:690:c345:369b with SMTP id
 u16-20020a0cea50000000b00690c345369bmr182983qvp.0.1710194391939; 
 Mon, 11 Mar 2024 14:59:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHFQKS5O5FHgxznSgb3d70/N9RWf8Zv5DqjPVpCRxfdS5XAAlmNU1/g29PL1gzNNmMlrMeiQ==
X-Received: by 2002:a0c:ea50:0:b0:690:c345:369b with SMTP id
 u16-20020a0cea50000000b00690c345369bmr182952qvp.0.1710194391450; 
 Mon, 11 Mar 2024 14:59:51 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:51 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 17/34] migration: remove migration.h references
Date: Mon, 11 Mar 2024 17:59:08 -0400
Message-ID: <20240311215925.40618-18-peterx@redhat.com>
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

Remove migration.h from files that no longer need it due to
previous commits.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/r/1710179338-294359-2-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/container.c        | 1 -
 hw/virtio/vhost-user.c     | 1 -
 hw/virtio/virtio-balloon.c | 1 -
 system/qdev-monitor.c      | 1 -
 target/loongarch/kvm/kvm.c | 1 -
 tests/unit/test-vmstate.c  | 1 -
 6 files changed, 6 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index bd25b9fbad..ff081a12c2 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -32,7 +32,6 @@
 #include "sysemu/reset.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "migration/migration.h"
 #include "pci.h"
 
 VFIOGroupList vfio_group_list =
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index a1eea8547e..1af8621481 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -26,7 +26,6 @@
 #include "qemu/sockets.h"
 #include "sysemu/runstate.h"
 #include "sysemu/cryptodev.h"
-#include "migration/migration.h"
 #include "migration/postcopy-ram.h"
 #include "trace.h"
 #include "exec/ramblock.h"
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a59ff172bd..609e39a821 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -31,7 +31,6 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "migration/misc.h"
-#include "migration/migration.h"
 
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 09e07cab9b..c1243891c3 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -38,7 +38,6 @@
 #include "qemu/option_int.h"
 #include "sysemu/block-backend.h"
 #include "migration/misc.h"
-#include "migration/migration.h"
 #include "qemu/cutils.h"
 #include "hw/qdev-properties.h"
 #include "hw/clock.h"
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index c19978a970..11a69a3b4e 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -22,7 +22,6 @@
 #include "hw/irq.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
-#include "migration/migration.h"
 #include "sysemu/runstate.h"
 #include "cpu-csr.h"
 #include "kvm_loongarch.h"
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index c4f9faa273..63f28f26f4 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -24,7 +24,6 @@
 
 #include "qemu/osdep.h"
 
-#include "../migration/migration.h"
 #include "migration/vmstate.h"
 #include "migration/qemu-file-types.h"
 #include "../migration/qemu-file.h"
-- 
2.44.0


