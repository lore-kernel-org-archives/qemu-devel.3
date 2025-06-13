Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274CEC71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ59I-0003z5-Aj; Fri, 13 Jun 2025 10:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ59E-0003vm-Nn
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ595-0002Jl-N5
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aVKgBQMfxhddBxPyaKNixg5DSYmgqFw6jW8hSbO1LhE=;
 b=KbjTiELoB6FyyYFf9dnAcktVHnT041mpD/1dBB0LG2HEijAzOr75pg2JDTZI1fBvjrnWto
 41bkf3CzK71J5cYwFBvliIh/BURHJ6xYXVBIeBXw7NvKgygHVEc9Avj7ftrwF5T8/cHx/Y
 vhmD4kT+vg8cBG3mRkqcnY9fFn+LNjI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-dp2ERQOSP5eVjdoFi6QIhw-1; Fri, 13 Jun 2025 10:12:32 -0400
X-MC-Unique: dp2ERQOSP5eVjdoFi6QIhw-1
X-Mimecast-MFC-AGG-ID: dp2ERQOSP5eVjdoFi6QIhw_1749823952
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4a6e9182fbaso57370361cf.1
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823951; x=1750428751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aVKgBQMfxhddBxPyaKNixg5DSYmgqFw6jW8hSbO1LhE=;
 b=QR6wO8IoMhRwaBjxnPCKGIqLFdhfOKZ9EzB2kyf5TbUnQis9c7AA8tp3ykqfEzA5EV
 sb9aULfQQpiHNF3WtC/uCfz7ye3fsXpqNxLt/It2XRAkna0WE2RK7vaJeXerlXq9bTLv
 cINhKmC8cbUwJMbp3TSc/YIXagOuTX0B3kGeZ6ys1Y8AKyaKZ2ggGXBUMAkadrCcffAy
 +v9vHl62oWuw5zXtDNSyPuRKGgg7sJeWcv8FoQJWJUqE47be6JlsclGX6piLIaUVfn1x
 BK/bqEynt9Ttefgzw5exIiZpiy5RVABOwOt6X3R/yJUmjxh/yt5Ci3u3BvYhQEA9ogG1
 D/6A==
X-Gm-Message-State: AOJu0YwoYyBEKo0keQvhea846m+5x28iUhkHylFXGK5R8CpUUNtlTOT7
 cIoIdYSDQLkBbiCVFfkoc9fsboNkAuKcpIbpKWXeDUxpSiReanO9LEoiW2BR+MiV/Uz40AV9Zsl
 F11zAUcSOtk8LbMiu08ZgnAEp0YTOaJax1hW06nCBlZHCRIHLRe/ETacQ7ik7ozIJyDP+zH1th8
 99VojzNeVf/nXrIeS1cvj56BjJzJ0QOsNI5KLi7A==
X-Gm-Gg: ASbGncujRhfPE1dolI/GRyz63MshLVC+Amt20lDseoi5PWR/bRYSMx16MKCv1OwaV0n
 Kn3RJqn8/v+KEIjmIYH/uva0s+l+/cDH0BjXO64nXjbbgenPtH8662rZqj1PW7Zbacy5fBG+w39
 WZYZguPuSXkFxH9TOJ7zOzM+5EMZGtbkWe//F1YWhfO+ZD4blD+pSBU3hbQpTPAfvVkFF4w3ZyK
 yTpGJKb9CwVpWR5O7vLCtjwPSxRCEr5nsoiLGvasUN239CjiKn5OE9mj8otqKfXSupK8hSJuqRs
 /MMqtXluK50=
X-Received: by 2002:ac8:5a84:0:b0:49a:4fc0:56ff with SMTP id
 d75a77b69052e-4a73910fe61mr14844021cf.12.1749823951297; 
 Fri, 13 Jun 2025 07:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQnsKlqpqOyfpH7oDmt/WafmFK07fx6niGHh2XSU7PI6ivB8SSWmqVMV1huPyddAucUMBteQ==
X-Received: by 2002:ac8:5a84:0:b0:49a:4fc0:56ff with SMTP id
 d75a77b69052e-4a73910fe61mr14843181cf.12.1749823950584; 
 Fri, 13 Jun 2025 07:12:30 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a526cc6sm17141641cf.79.2025.06.13.07.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:12:29 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 09/14] migration/postcopy: Initialize blocktime context
 only until listen
Date: Fri, 13 Jun 2025 10:12:12 -0400
Message-ID: <20250613141217.474825-10-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613141217.474825-1-peterx@redhat.com>
References: <20250613141217.474825-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Before this patch, the blocktime context can be created very early, because
postcopy_ram_supported_by_host() <- migrate_caps_check() can happen during
migration object init.

The trick here is the blocktime context needs system vCPU information,
which seems to be possible to change after that point.  I didn't verify it,
but it doesn't sound right.

Now move it out and initialize the context only when postcopy listen
starts.  That is already during a migration so it should be guaranteed the
vCPU topology can never change on both sides.

While at it, assert that the ctx isn't created instead this time; the old
"if" trick isn't needed when we're sure it will only happen once now.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index fe940f89b9..dd3615663f 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -325,13 +325,13 @@ static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis,
     }
 
 #ifdef UFFD_FEATURE_THREAD_ID
+    /*
+     * Postcopy blocktime conditionally needs THREAD_ID feature (introduced
+     * to Linux in 2017). Always try to enable it when QEMU is compiled
+     * with such environment.
+     */
     if (UFFD_FEATURE_THREAD_ID & supported_features) {
         asked_features |= UFFD_FEATURE_THREAD_ID;
-        if (migrate_postcopy_blocktime()) {
-            if (!mis->blocktime_ctx) {
-                mis->blocktime_ctx = blocktime_context_new();
-            }
-        }
     }
 #endif
 
@@ -1239,6 +1239,11 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
         return -1;
     }
 
+    if (migrate_postcopy_blocktime()) {
+        assert(mis->blocktime_ctx == NULL);
+        mis->blocktime_ctx = blocktime_context_new();
+    }
+
     /* Now an eventfd we use to tell the fault-thread to quit */
     mis->userfault_event_fd = eventfd(0, EFD_CLOEXEC);
     if (mis->userfault_event_fd == -1) {
-- 
2.49.0


