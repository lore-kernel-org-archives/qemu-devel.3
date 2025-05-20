Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D90C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQRs-00009s-5r; Tue, 20 May 2025 13:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRn-0008V4-6k
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRl-00018H-AB
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747760888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHv2iNqYhFqYDicLPQgm1PbA3RDnzLiIMmKr4H3KBKo=;
 b=hnogXX8DqxiNu1VO6KLyTp8ruyyjCFo8WbOeeqq9ybBg9SiVyOopWTCdKRT1U2Z9b9c2nv
 Fmv5H87VtnfQVxHqYoOuIUH9D53X/lVzdbDH0hB8rhaLe6FyaVmJrdiAquI7RetPV2r/6x
 BM3XJUzXUWUQx14NRZ4dHZBAYsq7fww=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-DnwKobpGNNeq1O7MCufvZQ-1; Tue, 20 May 2025 13:08:07 -0400
X-MC-Unique: DnwKobpGNNeq1O7MCufvZQ-1
X-Mimecast-MFC-AGG-ID: DnwKobpGNNeq1O7MCufvZQ_1747760886
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c5b9333642so679847785a.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760886; x=1748365686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHv2iNqYhFqYDicLPQgm1PbA3RDnzLiIMmKr4H3KBKo=;
 b=ErUvaiwT75JRdc+ohmPXj/VrLRTte15nfMWifHw11Q1gl616UAJYoNUeyj8VqAzGif
 gadsNfQv37hCZPGu4BvK6B0TKab9dsgTDcx4B6W2KHz+FEbX28tNseXLH2wAm2vI0ZY3
 IJN9XzmtCl2Bv5MNDNL/Yhc6PmH0ndk5tPuhroPK2ZzzEkjjTRO4AMGRlqORjlgW+ZZn
 QFj0Zw4c8lcFpmVp+ryuV6+2QXYs/1hrPcIMwHA6XS+f/SRVbZ9JP8wTz9sWsHJ+ZFsJ
 PBVVa2p7hTjNmDx3+nQCxfDJYbvxmi9JaKKQbyoBDeXL1rk+Gl8QRpwkVCIOgr9JpTTo
 up8w==
X-Gm-Message-State: AOJu0Ywubt2Snwq285Vn3JRDZF4l/lNL+GV/fgJ0JHOttnzosqBfyHbF
 zcyVguoq1HmKstX7OvVNZgQTI0k+5/0fyLse2HHHPEzEbuknqIwhoAQwUhMuBjgjp8UHJ5Nds8k
 lrYFpDYrgL4thfhwenjQiy9sKWGGq9+Qv+XRAyx2AaXvS1Hxya5mFeIN80Jl9LP6k/PRiAA2S49
 d0hq3KM5UESJX9/Dwb5h9IKvDcgO02QGHsMNGpug==
X-Gm-Gg: ASbGncsDwOjVAYyhAHyk0E/s0TIUd9/uXiXuwRY+3p8eMoLvox6oIdZuF34rFloIjSC
 hDUL8wrd7jN3aNK3DObr0NqBwsUJN6t1vPVbCVmW3q6S3wc32iOwBe0A+sZ+KzhmdriTcS5J2MV
 Ev2l4+VxLFR39lSV/K7IsCg8/QDQOLdiwwYSO6A2fAdtGlkhMhamPdvVH2Krr8kQqG3uv9580wu
 Zst3DtilMgF36QQixzu5rBvQW3T5ObrowSlc91FgATUQ2mPsfFllGNDa0IoSOYhNSx3JMcLTdHv
X-Received: by 2002:a05:620a:44d0:b0:7ca:ea9a:828c with SMTP id
 af79cd13be357-7cd467ac210mr3193005985a.48.1747760885489; 
 Tue, 20 May 2025 10:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBlxk36UFSySyte3/zNACB19fveue/7EgR84iRSn/HU5Kh9J4V1pvsnmO/I6KPRjIwhhYzwg==
X-Received: by 2002:a05:620a:44d0:b0:7ca:ea9a:828c with SMTP id
 af79cd13be357-7cd467ac210mr3192998085a.48.1747760884810; 
 Tue, 20 May 2025 10:08:04 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467be47bsm763846585a.16.2025.05.20.10.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:08:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 07/12] migration: write zero pages when postcopy enabled
Date: Tue, 20 May 2025 13:07:46 -0400
Message-ID: <20250520170751.786787-8-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520170751.786787-1-peterx@redhat.com>
References: <20250520170751.786787-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

During multifd migration, zero pages are written if
they are migrated more than once.

This may result in a migration thread hang issue when
multifd and postcopy are enabled together.

When postcopy is enabled, always write zero pages as and
when they are migrated.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250512125124.147064-2-ppandit@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd-zero-page.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index dbc1184921..4cde868159 100644
--- a/migration/multifd-zero-page.c
+++ b/migration/multifd-zero-page.c
@@ -85,9 +85,27 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
 {
     for (int i = 0; i < p->zero_num; i++) {
         void *page = p->host + p->zero[i];
-        if (ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
+        bool received =
+                ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i]);
+
+        /*
+         * During multifd migration zero page is written to the memory
+         * only if it is migrated more than once.
+         *
+         * It becomes a problem when both multifd & postcopy options are
+         * enabled. If the zero page which was skipped during multifd phase,
+         * is accessed during the postcopy phase of the migration, a page
+         * fault occurs. But this page fault is not served because the
+         * 'receivedmap' says the zero page is already received. Thus the
+         * thread accessing that page may hang.
+         *
+         * When postcopy is enabled, always write the zero page as and when
+         * it is migrated.
+         */
+        if (migrate_postcopy_ram() || received) {
             memset(page, 0, multifd_ram_page_size());
-        } else {
+        }
+        if (!received) {
             ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
         }
     }
-- 
2.49.0


