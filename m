Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5D0CAC5AB
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 21:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqgAa-00072k-LG; Tue, 17 Sep 2024 17:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqgAG-0006Nc-RA
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 17:55:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqgAF-0004sI-5B
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 17:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726610114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TdTM1Vy8cJBfZl/IClQA3wFNSuuJkD9Zb5WcgYw2HVw=;
 b=PRpLUnn9wN8CFl7qVgxI0s3hOX+9fzNkH35pLoXNXb+dy7cHcpOrcaZMgLobdQDSwh53vR
 a7Q+wR5uB+NS3uQCASKBPbhq/HrcLVhTNYTxJg/oGvATE7RJjYFjsdvor2Ku7pmAlkXoYn
 t4MBwWL9xNjgfr01fNM0vbl0gU9nUUQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-TrVbBpfTPYS-faY4JXWMZA-1; Tue, 17 Sep 2024 17:55:13 -0400
X-MC-Unique: TrVbBpfTPYS-faY4JXWMZA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7ac9dff8072so148657885a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 14:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726610113; x=1727214913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TdTM1Vy8cJBfZl/IClQA3wFNSuuJkD9Zb5WcgYw2HVw=;
 b=bbYY0+HT/yV7VywxPt00CUMsBypVwD/FFf3tdX488k9W1FmbGKQCN0mbpLv7q799CX
 eCK3wyLaXAWRE5DDQd+6GR6H7TgC1yF7QKx5SlGIpXGL3A68eqArhIds3EvC7z4nHAmP
 DumlH7l8WXX3kH9tSRG9hJ748CFrO60TWQv9CwwzpdXehToAMENPNFIJHteymxUqaRNx
 P6i2RbsDqcn+MiFLUTHsyEwiI0fAsGzSS+I1HKAZucPdNXT+NpneWfvzwQPKw7NCxM0d
 egVCKla1aHkiHxiKeUeBWzAAbYcnaXhLwzB7WSf/+see/UwFL5hVRtQbDDZnaUuic5fZ
 D2Ag==
X-Gm-Message-State: AOJu0YzwIGaGFG79dGh6648GCVn6fnc4F1AEcRnWcoBANVBtYCOHk/PR
 KdLNVxMnQAmND86gVZ3Xb6WX0ZBr59MWVczk24FJ4IIME0b68c81npfkQY+GN1aM3cjcX0uveIO
 d8X/ozFw5/rSNDrs/7iz1ppEE7q5UfaGJ9S3iL+mVM/jowF1hGqfWsKVRhYekwRGkGJsWpd65N9
 wQ4Z4VZNg9XwWSXAiLX+E7pu6+oG/TqebKgA==
X-Received: by 2002:a05:620a:394a:b0:7a9:b8dd:eb96 with SMTP id
 af79cd13be357-7a9e5f1a291mr3266823285a.30.1726610112697; 
 Tue, 17 Sep 2024 14:55:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIG+Nnc9cadN1R8kmSGtINYvLscAIObq1RAgDiFuqi9WkYUR7d/pMubeUZdIbGr01Lbvd1gQ==
X-Received: by 2002:a05:620a:394a:b0:7a9:b8dd:eb96 with SMTP id
 af79cd13be357-7a9e5f1a291mr3266818885a.30.1726610112232; 
 Tue, 17 Sep 2024 14:55:12 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ab3e97c9fasm402869685a.28.2024.09.17.14.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 14:55:11 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Yichen Wang <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>, Hao Xiang <hao.xiang@linux.dev>,
 Yuan Liu <yuan1.liu@intel.com>
Subject: [PULL 2/6] migration/multifd: Fix build for qatzip
Date: Tue, 17 Sep 2024 17:55:02 -0400
Message-ID: <20240917215506.472181-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240917215506.472181-1-peterx@redhat.com>
References: <20240917215506.472181-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The qatzip series was based on an older commit, it applied cleanly even
though it has conflicts.  Neither CI nor myself found the build will break
as it's skipped by default when qatzip library was missing.

Fix the build issues.  No need to copy stable as it just landed 9.2.

Cc: Yichen Wang <yichen.wang@bytedance.com>
Cc: Bryan Zhang <bryan.zhang@bytedance.com>
Cc: Hao Xiang <hao.xiang@linux.dev>
Cc: Yuan Liu <yuan1.liu@intel.com>
Fixes: 80484f9459 ("migration: Introduce 'qatzip' compression method")
Link: https://lore.kernel.org/r/20240910210450.3835123-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd-qatzip.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
index 3c787ed879..7b68397625 100644
--- a/migration/multifd-qatzip.c
+++ b/migration/multifd-qatzip.c
@@ -160,7 +160,8 @@ static void qatzip_send_cleanup(MultiFDSendParams *p, Error **errp)
  */
 static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
 {
-    MultiFDPages_t *pages = p->pages;
+    uint32_t page_size = multifd_ram_page_size();
+    MultiFDPages_t *pages = &p->data->u.ram;
     QatzipData *q = p->compress_data;
     int ret;
     unsigned int in_len, out_len;
@@ -179,12 +180,12 @@ static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
      * implementation.
      */
     for (int i = 0; i < pages->normal_num; i++) {
-        memcpy(q->in_buf + (i * p->page_size),
+        memcpy(q->in_buf + (i * page_size),
                pages->block->host + pages->offset[i],
-               p->page_size);
+               page_size);
     }
 
-    in_len = pages->normal_num * p->page_size;
+    in_len = pages->normal_num * page_size;
     if (in_len > q->in_len) {
         error_setg(errp, "multifd %u: unexpectedly large input", p->id);
         return -1;
@@ -197,7 +198,7 @@ static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
                    p->id, ret);
         return -1;
     }
-    if (in_len != pages->normal_num * p->page_size) {
+    if (in_len != pages->normal_num * page_size) {
         error_setg(errp, "multifd %u: QATzip failed to compress all input",
                    p->id);
         return -1;
@@ -329,7 +330,8 @@ static int qatzip_recv(MultiFDRecvParams *p, Error **errp)
     int ret;
     unsigned int in_len, out_len;
     uint32_t in_size = p->next_packet_size;
-    uint32_t expected_size = p->normal_num * p->page_size;
+    uint32_t page_size = multifd_ram_page_size();
+    uint32_t expected_size = p->normal_num * page_size;
     uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
 
     if (in_size > q->in_len) {
@@ -370,9 +372,7 @@ static int qatzip_recv(MultiFDRecvParams *p, Error **errp)
 
     /* Copy each page to its appropriate location. */
     for (int i = 0; i < p->normal_num; i++) {
-        memcpy(p->host + p->normal[i],
-               q->out_buf + p->page_size * i,
-               p->page_size);
+        memcpy(p->host + p->normal[i], q->out_buf + page_size * i, page_size);
     }
     return 0;
 }
-- 
2.45.0


