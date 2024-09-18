Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BDECDD54F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 18:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqzTG-00021G-Pi; Wed, 18 Sep 2024 14:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqzTE-0001pX-PT
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:32:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqzTB-00020S-5l
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726684324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TdTM1Vy8cJBfZl/IClQA3wFNSuuJkD9Zb5WcgYw2HVw=;
 b=il/YVGS+DhfhvIfqtzwGEiuMwTV8A+O98woWg9/JlPREIg8Hcq74Lq12S7cO7iab5FflnD
 p7iNI/KZOWH+ZYP9hBjve4478Q+8o9EQM9tTgv2B0gF89FOd973bb0bsIASJt1FaAt07Eq
 fEzkRBXCgYEP1qw9cPHirKaFUGPPlKk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-OF9vlQI8M3ORIEFMblEuPQ-1; Wed, 18 Sep 2024 14:32:03 -0400
X-MC-Unique: OF9vlQI8M3ORIEFMblEuPQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a99d13efafso5762985a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 11:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726684321; x=1727289121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TdTM1Vy8cJBfZl/IClQA3wFNSuuJkD9Zb5WcgYw2HVw=;
 b=iOYKn/Gz/OXd0JmLQxKC67o+jBrLSO6DhOFg53PV8eEUL6hHbbZgRmXZoQkLcTKTzG
 TF/I7Eulea+uzTP0TEejkUXxSJ37QXTFMJiJaDnsKFr9pmjt+xZzhZnq+fMXqVXbLujq
 mytepUIx0+5OFU4UroeowylpZTLVCGFYLJCma1LBX2jC+J3iCDqa1ejriyaPghNPxa2P
 mnJCAONc40aq3Z5qS4V/0OXUoBAKyXQHYGe5g0jEZSrca6oF3avbGABMVmLtBwUPO37t
 0Flcm746uxEGIpEx2lDUi9ifXRq7Tbz+QLs8cCv66mzaHX55FdIAJ8Ig7mtD7U0BLyfH
 1kCQ==
X-Gm-Message-State: AOJu0YzKNx7N1X/a0Kc04UYJPGHOkP205wjrGj0Sg1GqQqpFV94F3kgR
 A+uaC9DOVM5tyNTCepsAgTjfWWNEHAXgDbBsm6bxhD9Blw5cD1ftjrkfeXELnw9FK/lmCGkbKrf
 tu0lYC5bckzfTvrsDWsqyk7/LFvKJGjBUGRIMCkaelEtdTYKMHff0ww+3mo03AdnWwRVkloLgfR
 pXHYEMKGiwa+MUxhmefyyOUY2PGBbTdcbu2w==
X-Received: by 2002:a05:6214:4403:b0:6c1:6e39:b697 with SMTP id
 6a1803df08f44-6c57350bdc6mr303518496d6.9.1726684321349; 
 Wed, 18 Sep 2024 11:32:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSvAOiyU95D6ePIobMsNvblxyYYrzW1cd/ZhPg1X5WZtSsh5oHTwQ7sqzJsL5wVzkYLrcqPw==
X-Received: by 2002:a05:6214:4403:b0:6c1:6e39:b697 with SMTP id
 6a1803df08f44-6c57350bdc6mr303516866d6.9.1726684317717; 
 Wed, 18 Sep 2024 11:31:57 -0700 (PDT)
Received: from x1n.. (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e494a28sm30486d6.68.2024.09.18.11.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 11:31:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Yichen Wang <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>, Hao Xiang <hao.xiang@linux.dev>,
 Yuan Liu <yuan1.liu@intel.com>
Subject: [PULL v2 2/6] migration/multifd: Fix build for qatzip
Date: Wed, 18 Sep 2024 14:31:47 -0400
Message-ID: <20240918183151.6413-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240918183151.6413-1-peterx@redhat.com>
References: <20240918183151.6413-1-peterx@redhat.com>
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


