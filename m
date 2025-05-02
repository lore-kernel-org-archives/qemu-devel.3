Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1582C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtSY-0007kc-5J; Fri, 02 May 2025 12:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSV-0007i0-Uk
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSU-0006Rg-AT
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746204113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2w7J9EqC67G+9BHMZMRooN71UtnTrILiK+wTczOjWk=;
 b=DdU+Sa8IuAjv7vu0LbITXv9eayOhLoPCEKByx7P54d22L9nwZh3TuEkULW+K4/REWn7j3H
 sKNEbTc7T3+7TzPanVGnfzbjDCL2d8DV0gpYqEswdBJDWlcn3LxN+rzlY7aJo9lSV4Pfx1
 ANOyDix0IKUgdIfN7kMb7JUn65bk8iU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-zHbJUoh4OvqUp8UbT32vBw-1; Fri, 02 May 2025 12:41:51 -0400
X-MC-Unique: zHbJUoh4OvqUp8UbT32vBw-1
X-Mimecast-MFC-AGG-ID: zHbJUoh4OvqUp8UbT32vBw_1746204110
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c7c30d8986so756448785a.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204110; x=1746808910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2w7J9EqC67G+9BHMZMRooN71UtnTrILiK+wTczOjWk=;
 b=KmaQ5yEt+dy+5UTztUD9XVgW+sdJkUw2PmCFHpK+0mJb5ULq1jX3cR+E2Ez9qa+gxj
 DYTNauseyUCMn9wNA+0vcG9ukco87zZULRlpmayM8nj0nZGsYlCc+vkQBm2+Ezyc/noY
 bqtyJBsIKTm9R3+cJd000z4HphqJNS/v1aIc6ZCQ9deGUM2spxWaJZty8hjVq4Q3a9Yy
 QIYafCy0vLW4TO1WX6HmlKQkNC7K8hyojEOQU3m2+mj31xmAjrgGOPA/40aiVWJ15d2L
 InqbmPXkm5muGP68ERIgyamLZJOQigD25+vGJmlu7e+SgK1gY7y57+huyrn4Ju/tJquf
 Cmhw==
X-Gm-Message-State: AOJu0Yz4Fe2YzUwZF5clRoqnWukHTTBbbR03kRP6S+61GfsFSgWGiy24
 ig7oQypbBzz1Vi3bmWVJCiS2ccabHFBHkDYjWWKmA2EuJvFb28FT3UbqnVlVxrhyU+r9E6UOh28
 AnOiPDPDeoWN02mkNpWpZDsySys5h4TPtVFu3lm8iW6xkWCBWui8HKFzcA3Xd46b7na5weGQZWk
 P6KiynjgE4ugySycUIci4+UHaCp+ttfT66bw==
X-Gm-Gg: ASbGnctagsJLUZsXv5ucAzrpUbvcMuLIZ8eVu5e12krq59aWVZUnyRIF2BDzQ1JKxAt
 Pbn1cjBZJaTlK0ouxEYscG+/VoeFfA3isiXf/IkKy4UpRZmiy6QtLcF/3NOK/q5d1o06CCGUNhB
 DTbeDDUgTwyb37Eu9lKVEb1+P4Aysd9XgI1f3VEa3rD5UCSuO3PQasrl/vsyzRWlYoVLGYX82/O
 FBJGnnosLg+A5uXqi5Yp02OXGs7ruppGTYs1714//lfbUwKrq4lSHwZxZrzW6uINK3WwAipPccM
X-Received: by 2002:a05:620a:29d0:b0:7c5:3e22:616f with SMTP id
 af79cd13be357-7cad5b3aca9mr422485485a.21.1746204109929; 
 Fri, 02 May 2025 09:41:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLG6KOxlhYX4nJwSCFnpwLZE/HGeQlxQfZXsadeTGZCSqzpd/RunT6dYXb73DAqI5itkVVeg==
X-Received: by 2002:a05:620a:29d0:b0:7c5:3e22:616f with SMTP id
 af79cd13be357-7cad5b3aca9mr422482985a.21.1746204109609; 
 Fri, 02 May 2025 09:41:49 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23d1c8dsm203108385a.60.2025.05.02.09.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:41:48 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PULL 03/14] migration/rdma: Remove redundant migration_in_postcopy
 checks
Date: Fri,  2 May 2025 12:41:30 -0400
Message-ID: <20250502164141.747202-4-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502164141.747202-1-peterx@redhat.com>
References: <20250502164141.747202-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

From: Li Zhijian <lizhijian@fujitsu.com>

Since we have disabled RDMA + postcopy, it's safe to remove
the migration_in_postcopy() that follows the migrate_rdma().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Message-ID: <20250305062825.772629-5-lizhijian@fujitsu.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index b31652baac..a3c3b432d1 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3284,7 +3284,7 @@ err:
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
-    if (!migrate_rdma() || migration_in_postcopy()) {
+    if (!migrate_rdma()) {
         return RAM_SAVE_CONTROL_NOT_SUPP;
     }
 
@@ -3829,7 +3829,7 @@ int rdma_block_notification_handle(QEMUFile *f, const char *name)
 
 int rdma_registration_start(QEMUFile *f, uint64_t flags)
 {
-    if (!migrate_rdma() || migration_in_postcopy()) {
+    if (!migrate_rdma()) {
         return 0;
     }
 
@@ -3861,7 +3861,7 @@ int rdma_registration_stop(QEMUFile *f, uint64_t flags)
     RDMAControlHeader head = { .len = 0, .repeat = 1 };
     int ret;
 
-    if (!migrate_rdma() || migration_in_postcopy()) {
+    if (!migrate_rdma()) {
         return 0;
     }
 
-- 
2.48.1


