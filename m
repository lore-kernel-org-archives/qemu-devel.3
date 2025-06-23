Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0EDC77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnRc-0005xy-M5; Mon, 23 Jun 2025 16:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRb-0005xj-9a
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRZ-0003TX-Fh
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750709224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EAQgpEBtNd61PFcFDZwuAl96RIgWN8ZVT+yu/6lUlPg=;
 b=dwVGaYkJ9Y5lYmsJ/+s11R/e+uEV6l1JNOMfQ/bzKmqE6/ePCaHeLpaEukXwUWKCv36yAa
 5rlZQyP1x8ved0kCZjzL3kTExvb80vP8X+QH9VulQhRxHn20SmqQWaGQcIG/vnzW65v2bn
 oSSESyRGrF7Am6BUcvYnnlGwoIxLi9M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-eYv-padIMDqFLYfLqa8pfg-1; Mon, 23 Jun 2025 16:07:02 -0400
X-MC-Unique: eYv-padIMDqFLYfLqa8pfg-1
X-Mimecast-MFC-AGG-ID: eYv-padIMDqFLYfLqa8pfg_1750709222
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6fabb9286f9so101368776d6.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 13:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750709221; x=1751314021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAQgpEBtNd61PFcFDZwuAl96RIgWN8ZVT+yu/6lUlPg=;
 b=I3+44qxXVC91Zg3rQJ/GZUaTA8AbyS4gwtkjV4+Nmz7DcZGdBW/H9A9yFeby2wwgep
 6c9Zv6nZctVxQP/A5sQOF6Bar2+4gfxLY1hvt5wADeXv5rAL3M9F6HWLr+XU7IpmZMTD
 YfvfQSTYtlWMZcsX7Da2mXdR5PVFUUDmgveFAdzoziE/PLjkRKeVbF+mq13zeDf8OUrf
 S9hl9Ji9fj6Bs7SmYTHiK5N3fe/HZUPBI3jD7VCf0KBeKx+ckPaBLuQx4EmZiS5NvHhE
 +9/LPjw4rHph7DkWjTcBRjDhtLeDnl4Tv4zXRTsYDTRHyDkrDWClw8L7V48fkVMO31Nk
 tTuw==
X-Gm-Message-State: AOJu0Yx/hNjRdwA9q4Y47N3wZoghvT8+RRipLjtDmsi7eE6ac+WqClEG
 2FE1UazIEQG+RSkua87xGrEcHGpzItzyxbcTgKB6079OWwI9k1hoB49hNVG+KAB0IStNKEp6Tpr
 FjqMGyoaJsMe8zkMql7l/bqk9JE0tFPbKiY4KoLwWDcYWE66wFzj2hl7vkSaiKY5km6gD6GNfVW
 d8/9oBmlQYTQVde1q8JA9sfDBe7foPVm0kEEvLXQ==
X-Gm-Gg: ASbGncu461A7VmbG5sgrbzvrTQ1sZMnsSl/1jx4vksuL5GMH0Ll2qcZbe1RLe3ZtUtm
 dP1i5IaNWI/K7n7GVIOGzU9M6wiSvEDFgr+G3+EGsQHW4yg+WSmnpaqOouW4UoC9KUFccx07zu/
 yhTKujjNE85dlupuU6Hv230Ud78B/kCwvT85d4AHVHW7hSeyq/UAR05aXMImN4fSNuLnnueh7Uc
 3nnRpWGP3NQ7L5IgvZebrn+t2pjHlpOqps5r35LvHoYur/zjAtv8q/J9AzinR2cOfppTOSacRk6
 tbOUQYOFlCE=
X-Received: by 2002:a05:6214:2427:b0:6fb:43d:65b7 with SMTP id
 6a1803df08f44-6fd0a5c1776mr253069626d6.36.1750709221528; 
 Mon, 23 Jun 2025 13:07:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvtDS3RNGAUkS/Uvi1RMDCbRBsjpqYwzYqvh4v0pkgYN9iN3kzYE4+MlZ/Vnl6oWYqWjkHlA==
X-Received: by 2002:a05:6214:2427:b0:6fb:43d:65b7 with SMTP id
 6a1803df08f44-6fd0a5c1776mr253069156d6.36.1750709221025; 
 Mon, 23 Jun 2025 13:07:01 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd095a775bsm48427976d6.112.2025.06.23.13.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 13:07:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PULL 01/11] migration/ram: avoid to do log clear in the last round
Date: Mon, 23 Jun 2025 16:06:46 -0400
Message-ID: <20250623200656.1882674-2-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623200656.1882674-1-peterx@redhat.com>
References: <20250623200656.1882674-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

From: Yanfei Xu <yanfei.xu@bytedance.com>

There won't be any ram sync after the stage of save_complete, therefore
it's unnecessary to do manually protect for dirty pages being sent. Skip
to do this in last round can reduce noticeable downtime.

Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250514115827.3216082-1-yanfei.xu@bytedance.com
[peterx: add comments]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index d26dbd37c4..fd8d83b63c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -831,14 +831,22 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
     bool ret;
 
     /*
-     * Clear dirty bitmap if needed.  This _must_ be called before we
-     * send any of the page in the chunk because we need to make sure
-     * we can capture further page content changes when we sync dirty
-     * log the next time.  So as long as we are going to send any of
-     * the page in the chunk we clear the remote dirty bitmap for all.
-     * Clearing it earlier won't be a problem, but too late will.
+     * During the last stage (after source VM stopped), resetting the write
+     * protections isn't needed as we know there will be either (1) no
+     * further writes if migration will complete, or (2) migration fails
+     * at last then tracking isn't needed either.
      */
-    migration_clear_memory_region_dirty_bitmap(rb, page);
+    if (!rs->last_stage) {
+        /*
+         * Clear dirty bitmap if needed.  This _must_ be called before we
+         * send any of the page in the chunk because we need to make sure
+         * we can capture further page content changes when we sync dirty
+         * log the next time.  So as long as we are going to send any of
+         * the page in the chunk we clear the remote dirty bitmap for all.
+         * Clearing it earlier won't be a problem, but too late will.
+         */
+        migration_clear_memory_region_dirty_bitmap(rb, page);
+    }
 
     ret = test_and_clear_bit(page, rb->bmap);
     if (ret) {
-- 
2.49.0


