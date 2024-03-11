Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26909C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjni4-0002Hl-HP; Mon, 11 Mar 2024 18:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngs-0000t9-Nx
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngr-0004Hv-0t
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cOcK8yDXWw/GICYwFOPKzQtDbOuwzT4S8Ube17pNJRY=;
 b=NwonFKupMjfCNAeuVXE1H14p5Dvf5cH7BQiSQw5Y02YsgMiijPQJ6onH8WzJaprEx7DkCX
 22lFgzx/FNUa2YQPU2LItsdapx7oAiq2GhSjgqTAhlSSjkcf1BIWT2SqGmn/t2nW3qhND3
 v9T8JGbH91/VWs7YKOIPe4li+WCHUcU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-XhK9LIcHPmSJAafnghKSgQ-1; Mon, 11 Mar 2024 18:00:11 -0400
X-MC-Unique: XhK9LIcHPmSJAafnghKSgQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-690c19ee50bso1969276d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 15:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194410; x=1710799210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOcK8yDXWw/GICYwFOPKzQtDbOuwzT4S8Ube17pNJRY=;
 b=mRZ7PTySL0WcDGDzlUj5gfwtCOLNVSoNCprai99FlDFn9+JN32xJ79QKfmJRV+7exN
 uH6AeMQYgzr5a6yutbYrs2le8wHcdeUodve6gJed95ioKeJvdXAweLrL+ibhKLLdQZgr
 zMpKhE/IdRA0IrVpe9VClhz1RPzxomk+D1dYQTQoNChQ8cHRkrO7azKRruGh567nL64Q
 ZetrV3fu3g66u32YY+SUL3TEllJAQ5hQ3TnrAHeZHkSGpFVcooFDHMslqbUEDQZ9JnHM
 c6peuGidmQuWK7NYxGXG97lRjessdAYHsVAs6xJUfcrHomqbzkAB2T0zM3CsLCD7gq3Q
 HNCg==
X-Gm-Message-State: AOJu0YxDu64JOuicv7HSHPn4xxUhna6//55+/Tad/KhgYKk9G9h8rW6d
 Yl614lrppwkyS8EKOmGvAknKBTtExbL3owzMNDNtl1j9pby80J2sBJEzUKH8e4yt5gwpv1mla41
 Zg8Coo5WGloEQoT8XPGJ+i07gfzyx1KcJm+665r8DDAuYUaB3MvADMI88cVWcz5/fkoEliSKkf0
 3E2qqHkELj8GJP48s+SyaVuKcjj/1gUfx3ew==
X-Received: by 2002:a05:6214:b0d:b0:690:b47e:6254 with SMTP id
 u13-20020a0562140b0d00b00690b47e6254mr7031146qvj.2.1710194410288; 
 Mon, 11 Mar 2024 15:00:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1XAER6DsN8oow9CZ82i3jzaz+b8yjGED9gMcZS8Y0QgluQFZ8aEtW630Sl/FkYbr9alBYFA==
X-Received: by 2002:a05:6214:b0d:b0:690:b47e:6254 with SMTP id
 u13-20020a0562140b0d00b00690b47e6254mr7031108qvj.2.1710194409789; 
 Mon, 11 Mar 2024 15:00:09 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.15.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 15:00:09 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: [PULL 29/34] migration/multifd: Allow clearing of the file_bmap from
 multifd
Date: Mon, 11 Mar 2024 17:59:20 -0400
Message-ID: <20240311215925.40618-30-peterx@redhat.com>
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

From: Fabiano Rosas <farosas@suse.de>

We currently only need to clear the mapped-ram file bitmap from the
migration thread during save_zero_page.

We're about to add support for zero page detection on the multifd
thread, so allow ramblock_set_file_bmap_atomic() to also clear the
bits.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240311180015.3359271-3-hao.xiang@linux.dev
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.h     | 3 ++-
 migration/multifd.c | 2 +-
 migration/ram.c     | 8 ++++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/migration/ram.h b/migration/ram.h
index b9ac0da587..08feecaf51 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -75,7 +75,8 @@ bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
 bool ramblock_page_is_discarded(RAMBlock *rb, ram_addr_t start);
 void postcopy_preempt_shutdown_file(MigrationState *s);
 void *postcopy_preempt_thread(void *opaque);
-void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset);
+void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset,
+                                   bool set);
 
 /* ram cache */
 int colo_init_ram_cache(void);
diff --git a/migration/multifd.c b/migration/multifd.c
index bf9d483f7a..3ba922694e 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -115,7 +115,7 @@ static void multifd_set_file_bitmap(MultiFDSendParams *p)
     assert(pages->block);
 
     for (int i = 0; i < p->pages->num; i++) {
-        ramblock_set_file_bmap_atomic(pages->block, pages->offset[i]);
+        ramblock_set_file_bmap_atomic(pages->block, pages->offset[i], true);
     }
 }
 
diff --git a/migration/ram.c b/migration/ram.c
index 3ee8cb47d3..dec2e73f8e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3149,9 +3149,13 @@ static void ram_save_file_bmap(QEMUFile *f)
     }
 }
 
-void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset)
+void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset, bool set)
 {
-    set_bit_atomic(offset >> TARGET_PAGE_BITS, block->file_bmap);
+    if (set) {
+        set_bit_atomic(offset >> TARGET_PAGE_BITS, block->file_bmap);
+    } else {
+        clear_bit_atomic(offset >> TARGET_PAGE_BITS, block->file_bmap);
+    }
 }
 
 /**
-- 
2.44.0


