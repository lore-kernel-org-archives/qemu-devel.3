Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E918C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjniT-0003Js-CF; Mon, 11 Mar 2024 18:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjnh5-00018U-D4
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngv-0004IU-MF
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zHO3KVsccLbSO3dagFiDmb3kOgh0ZDKG6oQA10xRTGU=;
 b=fYoK7emhnN8T3qUMioQm4NtAVct1G4B1kUeX3ocANqRkFjnNaJlDrI4CuXMeHdaqrl+GuM
 fVuNzcQMZOFOW62iZXzJtwPGR/klg4LqNnJkDTg1fCbEOX9S+tRzcuk8B9hS6o0OIYqJRw
 ZiRSeFR74IJLyjDuOVHxaD5S7jJqWGE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-exR3nK_aNxGlg-EjRbJc9A-1; Mon, 11 Mar 2024 18:00:15 -0400
X-MC-Unique: exR3nK_aNxGlg-EjRbJc9A-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-690ab2b0de1so15044736d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 15:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194415; x=1710799215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHO3KVsccLbSO3dagFiDmb3kOgh0ZDKG6oQA10xRTGU=;
 b=A0sq5aALxYTKn7t+1Ju9j4FXAvua3QRkPm5vgZTZrotXsvxpdKxqY1YDfYDb9oozNE
 HKajxVDCoak4fWbficde2LpyQfoMMVtAon/1kEquy0FtmrhM0q0qpUJ2lO7chM6wEL5l
 wiF3HegSrY2omrG0Su95hvFYpOylMp4kQ94Z4qWGGMebc71sPe50Va8jEf0zDmtyq64E
 NBFMLe/if6l0GWc03tPYpqVVK5CGUtp6yRx4YfyAv9PhqUaYbr+vID9rXF7ZxBxevZ1R
 Trlv64hAY28QmPPWilkZxgUELsMiyuSQhBmxY2GPDZRQ7tV6gEMbNX+7RZm0fhsaRDDH
 t6FQ==
X-Gm-Message-State: AOJu0Yx//ZYIf6zAD+gbLozbKNFPK/Myy0JQpJPIpzLKdBF0sQaZLBPc
 GtG34tiH7d7ZSFzbpKihgYgvrkW8ksrM82/vyI/9t9BJXFQPTJL9jhq4eGmMNpcFcELtXFoMfvM
 AksDHlv0uiJc+1SKi+2baQ9rhUqKEDNpo6CaG6ICpEL6yuWbR55mVQIBsIHrhdEDCpEh5Vzy71j
 81pJuKCJokF/Xjy+eOnuEhxwITI1fvnIMHig==
X-Received: by 2002:a0c:eb83:0:b0:68f:e779:70f2 with SMTP id
 x3-20020a0ceb83000000b0068fe77970f2mr137655qvo.3.1710194414998; 
 Mon, 11 Mar 2024 15:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6wzTo/bd4W+wKY+C8aSSQK8L0qubfiuss0rzPyDGZfHJxZysmn5RA3h6maKBpHTW/BTazMA==
X-Received: by 2002:a0c:eb83:0:b0:68f:e779:70f2 with SMTP id
 x3-20020a0ceb83000000b0068fe77970f2mr137617qvo.3.1710194414610; 
 Mon, 11 Mar 2024 15:00:14 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.15.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 15:00:14 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: [PULL 32/34] migration/multifd: Implement
 ram_save_target_page_multifd to handle multifd version of
 MigrationOps::ram_save_target_page.
Date: Mon, 11 Mar 2024 17:59:23 -0400
Message-ID: <20240311215925.40618-33-peterx@redhat.com>
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

1. Add a dedicated handler for MigrationOps::ram_save_target_page in
multifd live migration.
2. Refactor ram_save_target_page_legacy so that the legacy and multifd
handlers don't have internal functions calling into each other.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20240226195654.934709-4-hao.xiang@bytedance.com>
Link: https://lore.kernel.org/r/20240311180015.3359271-6-hao.xiang@linux.dev
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index c26435adc7..8deb84984f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2079,7 +2079,6 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
  */
 static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
 {
-    RAMBlock *block = pss->block;
     ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
     int res;
 
@@ -2095,17 +2094,33 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
         return 1;
     }
 
+    return ram_save_page(rs, pss);
+}
+
+/**
+ * ram_save_target_page_multifd: send one target page to multifd workers
+ *
+ * Returns 1 if the page was queued, -1 otherwise.
+ *
+ * @rs: current RAM state
+ * @pss: data about the page we want to send
+ */
+static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus *pss)
+{
+    RAMBlock *block = pss->block;
+    ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
+
     /*
-     * Do not use multifd in postcopy as one whole host page should be
-     * placed.  Meanwhile postcopy requires atomic update of pages, so even
-     * if host page size == guest page size the dest guest during run may
-     * still see partially copied pages which is data corruption.
+     * While using multifd live migration, we still need to handle zero
+     * page checking on the migration main thread.
      */
-    if (migrate_multifd() && !migration_in_postcopy()) {
-        return ram_save_multifd_page(block, offset);
+    if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
+        if (save_zero_page(rs, pss, offset)) {
+            return 1;
+        }
     }
 
-    return ram_save_page(rs, pss);
+    return ram_save_multifd_page(block, offset);
 }
 
 /* Should be called before sending a host page */
@@ -3112,7 +3127,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     }
 
     migration_ops = g_malloc0(sizeof(MigrationOps));
-    migration_ops->ram_save_target_page = ram_save_target_page_legacy;
+
+    if (migrate_multifd()) {
+        migration_ops->ram_save_target_page = ram_save_target_page_multifd;
+    } else {
+        migration_ops->ram_save_target_page = ram_save_target_page_legacy;
+    }
 
     bql_unlock();
     ret = multifd_send_sync_main();
-- 
2.44.0


