Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE080C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfDb-0000Yq-5l; Mon, 09 Jun 2025 12:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDZ-0000Xr-5E
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDS-0004Vt-2K
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749485957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0gBjc7m16rQwKWYyV/3t//9MlDB/n3QsWgc67i1f8wg=;
 b=DS4hoQDR7zFbYdxigv5w/qKLDKLf/ki5p0elC284IKi+87iGjIYo5Bl8QRrP2asACfMHLq
 ZWcru46bhowzUwSvHTllusSx7bOn699BXzaElB6RLy5lVLuZqPnxY1WURE2atzhlMS5CEi
 ayN/MRHVSzlZwHO5sGCztfXVkGEmc1s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-SZkohqQKPgy8BwyZrae3Ng-1; Mon, 09 Jun 2025 12:19:11 -0400
X-MC-Unique: SZkohqQKPgy8BwyZrae3Ng-1
X-Mimecast-MFC-AGG-ID: SZkohqQKPgy8BwyZrae3Ng_1749485950
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6fafb2f0a33so68835986d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749485950; x=1750090750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gBjc7m16rQwKWYyV/3t//9MlDB/n3QsWgc67i1f8wg=;
 b=ARtEdp6uTAQZdo43CsnOcBUo/PumWy/u34IkT03nN6KlE7vsam8loIZlZH1WvCtdEh
 JFc/5DBqZSdXeBPQ6f88nYrfPP54jNTIf/Ib4Vl3Eq5TfwJ43uSA212esI5z+BN80YVY
 wq4wFSNjXY/VudRSfvDeymzk/mX9Ap9y0XH2quC4FAgOzE7W1nO1nU9XDxt3zkdt44xn
 51MgFGQbeG09R3tbNjhSopDCabsXUkIZ5J+cuF/Ai2CNIB+YclDJvDWppejxJ5rpHavq
 OM71VV5C0NNZgUKRuqYMoUE9N2DJYnBTRVZVdh//mceAul1Q2wqZ96oaccKYzUjeuMmN
 Yjzg==
X-Gm-Message-State: AOJu0Yzc2xId8nd6ld6puIaZxFVw2n1MgoWm4MS+iYOcQqJLbzxcEGOh
 SPBFULh4iLFgyo6RymRmZyZVVRjYHURK6Vh7221No2AxyFsAsgYr/eVntL+wik+j5FQ/eskxD5C
 x2tEuR+qHQnFTNrTCPUZ4L3fi7Uf/2mh+JbMxzph76eHnt23uUaTanHSt/Egt/gTTZsTJyyHAAf
 UCb7ATu3HrQ8wUtu+I7pbYFu1n1j3fPHWIEM8GLg==
X-Gm-Gg: ASbGncv2vHK/KphOQeDifQAu5lC0wh4v7ciHCNdo4f1DJhTgy6H6Xoy/s6JERMsZL0g
 A7I/b47vau/FXaWHdL7YPhvQtQKzBINqNYXixkeUWf+VIDpoqIy/R+hzkHbeFr3ubohd5HrX0sM
 tADMNAHnj6Du1CKDrZHwdWBosTRzA1OArdvMREO55889VWNVogrI4LACD4Nq/x+SB+DiYXJz6iq
 40LwgN1Do9Soc97T0ucvTMtmbxCPgoO0YxsZSOy9LcFdlOl0xgK3lhl2/aW65t9Z2AfBXQwsh/B
 HtU+NTMz0IC08g==
X-Received: by 2002:a05:6214:518f:b0:6f8:b4aa:2a4b with SMTP id
 6a1803df08f44-6fb08fbb540mr235601096d6.28.1749485950156; 
 Mon, 09 Jun 2025 09:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+JhK2D+zRr0c/sToY/ET/YTchuQuXkch4HwDCvB3BqTZlY0Ak2NSVjJqvEf+pZscQeAF6OA==
X-Received: by 2002:a05:6214:518f:b0:6f8:b4aa:2a4b with SMTP id
 6a1803df08f44-6fb08fbb540mr235600506d6.28.1749485949666; 
 Mon, 09 Jun 2025 09:19:09 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab95c1sm53420546d6.15.2025.06.09.09.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:19:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 08/11] migration/ram: One less indent for
 ram_find_and_save_block()
Date: Mon,  9 Jun 2025 12:18:52 -0400
Message-ID: <20250609161855.6603-9-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609161855.6603-1-peterx@redhat.com>
References: <20250609161855.6603-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


