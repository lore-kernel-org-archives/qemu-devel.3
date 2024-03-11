Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC45C54E66
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjniX-0003ZG-Iz; Mon, 11 Mar 2024 18:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjnh7-00018Y-9L
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngy-0004Ic-FA
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W5D9hPe7YI8HTKjr9lPVCdDiZ9GlallD+BW1Y4cBBB8=;
 b=K2ZfXuiZE1lhCAog60PgBCgQ27/Vy0kJ/SDUt7fuF8HSz8SGmCt3Sqg0JcoSNtDvouFlZa
 +/+eXq+6HRmZUaMtS00IPGqO2Ihi2hyueEdBBPDG8y5t+CvGbIqAeudFhvz3Ezv4SpFENF
 zr2dQBrRRkQ8pOPAZyD9RFEt9cwOAOw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-OgqGKICIP0KCmXAq9CS5Jg-1; Mon, 11 Mar 2024 18:00:17 -0400
X-MC-Unique: OgqGKICIP0KCmXAq9CS5Jg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-68fba33cae0so6801206d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 15:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194416; x=1710799216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5D9hPe7YI8HTKjr9lPVCdDiZ9GlallD+BW1Y4cBBB8=;
 b=RY1ZkPFmANNMqlkOuc1/nvRRBEMO43WcrcHHAJ9y4XvdJt9IrfybpV2TdpmRQ0czS7
 R31Kpv9WrzFhV80EYt6ueyCZpsQS17eRjx9vNBwpD/IPDAyfREHd7FCdutX9MvLWAuKu
 NXmGiBcYjm4DF/PKmxwRNbUCih8pph6L77JXWn8HK6B3RSDzU8PhpoKkAtga0Q0N2iUQ
 jKFLZaelQjTt/tz/8dC5mBM/SMViVnorqplv/GIy3+CPaTwqBNknP0N7d1aHHuOLGORe
 Zj8PdEdropiY1tg5nfgizIXK76rfQ1K38TxagyEt5Zrn/Lz8tr3TN0uLvWP+5UCQ9Ygq
 0AcQ==
X-Gm-Message-State: AOJu0YzKEO+4+jAnOvYPABM6jXBX+gd+q6U6sJ3ia1uAl8rx1KnbZFAy
 Z9NngqdlBy7WAU84oAlWrLlAP+uxktfQGq4vESAvJHh7PamR9uld8MR6g1cvWNF6nWsx2HYH7zz
 3P9R0noNHYaPB42EIA1SVJmDZArLzhcTJziffQiiXNSbc82XLflIfx6WuZ/B4YOkc4MFD/Xj5Xo
 QJ4FSkOh68uDD0Bkecij3d0gG4a/gdzn5muA==
X-Received: by 2002:a05:6214:2dc7:b0:690:e44b:d739 with SMTP id
 nc7-20020a0562142dc700b00690e44bd739mr413654qvb.1.1710194416258; 
 Mon, 11 Mar 2024 15:00:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXoiC4BlHAsGMjWzzkFWN55R4QoVKd6jom1q838J8px5fzau2GybR2f78afPLw+3NymwX9NA==
X-Received: by 2002:a05:6214:2dc7:b0:690:e44b:d739 with SMTP id
 nc7-20020a0562142dc700b00690e44bd739mr413608qvb.1.1710194415717; 
 Mon, 11 Mar 2024 15:00:15 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.15.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 15:00:15 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: [PULL 33/34] migration/multifd: Enable multifd zero page checking by
 default.
Date: Mon, 11 Mar 2024 17:59:24 -0400
Message-ID: <20240311215925.40618-34-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Hao Xiang <hao.xiang@bytedance.com>

1. Set default "zero-page-detection" option to "multifd". Now
zero page checking can be done in the multifd threads and this
becomes the default configuration.
2. Handle migration QEMU9.0 -> QEMU8.2 compatibility. We provide
backward compatibility where zero page checking is done from the
migration main thread.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240311180015.3359271-7-hao.xiang@linux.dev
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json | 6 +++---
 hw/core/machine.c   | 4 +++-
 migration/options.c | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 2684e4e9ac..aa1b39bce1 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -909,7 +909,7 @@
 #        (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages.
-#     See description in @ZeroPageDetection.  Default is 'legacy'.
+#     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
 # Features:
@@ -1106,7 +1106,7 @@
 #        (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages.
-#     See description in @ZeroPageDetection.  Default is 'legacy'.
+#     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
 # Features:
@@ -1339,7 +1339,7 @@
 #        (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages.
-#     See description in @ZeroPageDetection.  Default is 'legacy'.
+#     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
 # Features:
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9ac5d5389a..0e9d646b61 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -32,7 +32,9 @@
 #include "hw/virtio/virtio-net.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_8_2[] = {};
+GlobalProperty hw_compat_8_2[] = {
+    { "migration", "zero-page-detection", "legacy"},
+};
 const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
 
 GlobalProperty hw_compat_8_1[] = {
diff --git a/migration/options.c b/migration/options.c
index 8f2a3a2fa5..9ed2fe4bee 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -181,7 +181,7 @@ Property migration_properties[] = {
                       MIG_MODE_NORMAL),
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        parameters.zero_page_detection,
-                       ZERO_PAGE_DETECTION_LEGACY),
+                       ZERO_PAGE_DETECTION_MULTIFD),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
-- 
2.44.0


