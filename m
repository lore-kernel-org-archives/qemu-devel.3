Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D62C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ556-0004Ak-IO; Fri, 13 Jun 2025 10:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54v-00048j-PR
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54u-0001Ve-Ar
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0gBjc7m16rQwKWYyV/3t//9MlDB/n3QsWgc67i1f8wg=;
 b=ZyizkMP9PIDgmfKsqOkHdg2XQCDoVUrMy+5uyXVoO2Dlu8LqeSP+O8moOEetYoitj21ha9
 YoOd5JyBaQ7YlRrYzQbwrYerjEzMY32av6FURDfx1pviYRiCQtf2Z7hLEvA7gbyn7zkoqB
 lnF11RjniFoLUAbsrreIRyDapO75/pM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-tUZ-Gya1PZO9DxiDMVntPw-1; Fri, 13 Jun 2025 10:08:18 -0400
X-MC-Unique: tUZ-Gya1PZO9DxiDMVntPw-1
X-Mimecast-MFC-AGG-ID: tUZ-Gya1PZO9DxiDMVntPw_1749823698
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4a582e95cf0so22006571cf.1
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823697; x=1750428497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gBjc7m16rQwKWYyV/3t//9MlDB/n3QsWgc67i1f8wg=;
 b=vntyZgLANSRrVy0wvllnQ0e+cGrk5LJPI+1lmgi2hkD6b5jDte1J6foKyiuZuu0io+
 yMCkD1/4cDGSqm/WeU9dBtkbcaxdNLg5oBge209Q40IsVrWXjMQQxBoIXkv9v7SA2CDJ
 bJW1fP4Urya8YkmAS+QLMWLKyNSJ5um4LEor76YLsiYuuo1vxDgXZDIuZXP1+nXeEHIe
 p7mRHNmvQxUev6mL/yPYdlpworGIbqQVBFeFMv0wwS7Rq7QloeE4t3njh0EczyFl9scv
 gCHZiQRpQciRYjmCG0ipl5djsQ6CooIj2LOLmWYYB6J6NA7Lj+ie+1Im0XSpl9baB2Ge
 if5A==
X-Gm-Message-State: AOJu0YxpulTHF1AO/UiD9lpv9wydf4kzsVRKETPo1RWYDPTW5avkDh8n
 rDc8Jzk4LKLfUPeuYS8XQBeZec2oqnZORThk7CfHl0oXV8LIrWnsfq9yrSooOEV9I4BzsucYW+D
 CszKkDLLQxLdZLUbXjMMQ+lkto2NMbrfTw/FCGV63YFPd2B7jQeCJ1Wj4r3WPirCp3CRi8R+CFY
 LbDLOyQAEImhmpbohDhlydNDihlFO3lXFWO7bXAQ==
X-Gm-Gg: ASbGncuRDjrlfs+YLVyLZVyzMFa2jHco6n1LwK7ba9zCDDWjMoW1fWRYQQP/dyYtq2p
 OGFJVFSgqirHqgye4S+WUKO08iP9TGWgeg2MuFTbpFaWMLoT85tKPPe7oOFg9SBr81ZCJTShlkQ
 QqP5jh0l6hfJ8wOMiE7jrHGC2Ex/wBf3VKT9l7ULe8NOSkS+q36giViAZT3sfCdHmk46/4vsnuw
 QG2mEHM451tDRjhAYNr13+r9+NduSSTAN0qAH4EGYfXS+BFlZuywM17hNLORagZ2DJKFoyixFCj
 Dyzec/CJO6A=
X-Received: by 2002:a05:622a:1cc3:b0:4a5:afa8:b3f with SMTP id
 d75a77b69052e-4a72fe63213mr63321961cf.3.1749823697318; 
 Fri, 13 Jun 2025 07:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMze8gQLP+ETf96zPRed/03GEJ0mRcGiPcVxsEkwkhx6e2YJbc4H9YcCqHAvGgTST73iKQ8w==
X-Received: by 2002:a05:622a:1cc3:b0:4a5:afa8:b3f with SMTP id
 d75a77b69052e-4a72fe63213mr63320001cf.3.1749823695771; 
 Fri, 13 Jun 2025 07:08:15 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a52a1ddsm17384111cf.81.2025.06.13.07.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:08:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3 08/11] migration/ram: One less indent for
 ram_find_and_save_block()
Date: Fri, 13 Jun 2025 10:07:58 -0400
Message-ID: <20250613140801.474264-9-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613140801.474264-1-peterx@redhat.com>
References: <20250613140801.474264-1-peterx@redhat.com>
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

The check over PAGE_DIRTY_FOUND isn't necessary. We could indent one less
and assert that instead.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ed380ac86f..c66ad3cf8b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2285,16 +2285,18 @@ static int ram_find_and_save_block(RAMState *rs)
         if (!get_queued_page(rs, pss)) {
             /* priority queue empty, so just search for something dirty */
             int res = find_dirty_block(rs, pss);
-            if (res != PAGE_DIRTY_FOUND) {
-                if (res == PAGE_ALL_CLEAN) {
-                    break;
-                } else if (res == PAGE_TRY_AGAIN) {
-                    continue;
-                } else if (res < 0) {
-                    pages = res;
-                    break;
-                }
+
+            if (res == PAGE_ALL_CLEAN) {
+                break;
+            } else if (res == PAGE_TRY_AGAIN) {
+                continue;
+            } else if (res < 0) {
+                pages = res;
+                break;
             }
+
+            /* Otherwise we must have a dirty page to move */
+            assert(res == PAGE_DIRTY_FOUND);
         }
         pages = ram_save_host_page(rs, pss);
         if (pages) {
-- 
2.49.0


