Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621BDCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeTu-0002vQ-GD; Wed, 22 Oct 2025 15:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTd-0002se-94
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTZ-0001SM-HM
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761161183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o0Y12EUm6tzSrzap8kCRMoEI4B4aZdSYBje8g8u1lmQ=;
 b=a5gfZ0nC3C2J1hukHP553Mv3ExwzTQZROr9rcsfR5Lxy3kwMDNeyYYuvCHwTX5lw6McL6H
 Rux7gtOxLhqj9WVO3/t3X/J5OzTgDhOlaCmH8wr3ZqS3klaBR2Scy9B8O1P2D0cJQfKS6Q
 vuwkqUcfEOO7vLqbSzMBW9NLJcOPQAo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-qDXt4KGaOy-CnY70OB4oiQ-1; Wed, 22 Oct 2025 15:26:21 -0400
X-MC-Unique: qDXt4KGaOy-CnY70OB4oiQ-1
X-Mimecast-MFC-AGG-ID: qDXt4KGaOy-CnY70OB4oiQ_1761161181
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4e89265668fso42312741cf.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761161181; x=1761765981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0Y12EUm6tzSrzap8kCRMoEI4B4aZdSYBje8g8u1lmQ=;
 b=kTzBYodJrx1Tu6MP7rEoKdiv8TKywcRcQ3mglulqUAd61Ywu5l/EeLTBg1Bu0nj1S8
 1fvYlWlQKaQ2v3Ty834shBfFhMDLG9v5dsuzT7TK2XLq2cLGd1sEypukQZglW12m00RS
 U3k5snFyk1E46iSAt7XkXGlFh25B1lSecxPTm0CiDFE1XA9WzfHoSwm6geQPK4bquWcP
 Cean8DO9UOcozf881w7Y7wvWWv0JkRNa6GAA2b8OW9pStEaOcGATNiua4GxL4yahlBZQ
 iFF7PcoYo1JGf0n7z2p+Hn+oTDC6WGoh9BNBcsRLtyVkOin91dCGRIGVT/aNJdMruX9K
 DCoA==
X-Gm-Message-State: AOJu0YylDud3IJTSQw6O0zOlk5tLMohD+1cey2EmveA/hdRRKIdRsD0t
 /74lC9BI+os7qZnJEJnbxMlb05RTA2/2juuCfEDxzN8sh6srk1nC2wVw/uiSrNDCW0q7Yssvht2
 crukSNDLLAMhPf/mFxXI3L3frm+ht1/n4qFWuSiNqND4Fl68k5JKWMucgKpuXQfk4cQMqQVbgQ9
 X6E1bTSBkwEWBhzZ8bC0OMu5fsiKQRQW2mQN325A==
X-Gm-Gg: ASbGncutxePVDDqKeT1pWKwpASEiDF7uqcInCdDvb5hiiIQjEmYRGfdczQuKwaSi7PD
 QgLVkD5QI1mjjh3HiOtfLA4u+ZuAfOJvdF1M01RHlYgmIRkQR/Foe+b26lL78inbYoq+kcdxrOw
 a16KP82b6Q78tlKxppuOCUPsSANwyCYWg5OZLwMzlH9KBbHHszSCS+/MsGVxURaAF9w9hc7irG+
 U76jCec9CABfgA0QxfWqtaHplV3epY1wfYnA+/VsHsATTnCOulxYKMPc5IrpWKSliA2Wb8BX8fV
 y7QN96aEpWTUiVTkVIfuYD2hrlYogqm/P8qlPO5RO1wGoh17ZLorKsZmLiqptoyJ
X-Received: by 2002:ac8:5d87:0:b0:4d8:372b:e16a with SMTP id
 d75a77b69052e-4e89d1f48d9mr304194551cf.4.1761161180725; 
 Wed, 22 Oct 2025 12:26:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDVD5J3AIWUWrtFeF5As8P8/yQlMPmUx0PwmtfSfmkYfW5IVIE/Erd4RPNFMqFTNJdGsvTew==
X-Received: by 2002:ac8:5d87:0:b0:4d8:372b:e16a with SMTP id
 d75a77b69052e-4e89d1f48d9mr304194051cf.4.1761161180209; 
 Wed, 22 Oct 2025 12:26:20 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34307sm99748561cf.1.2025.10.22.12.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 12:26:19 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>,
 Lidong Chen <jemmy858585@gmail.com>
Subject: [PATCH 03/13] migration/rdma: Fix wrong context in
 qio_channel_rdma_shutdown()
Date: Wed, 22 Oct 2025 15:26:02 -0400
Message-ID: <20251022192612.2737648-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251022192612.2737648-1-peterx@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The rdmaout should be a cache of rioc->rdmaout, not rioc->rdmain.

Cc: Lidong Chen <jemmy858585@gmail.com>
Fixes: 54db882f07 ("migration: implement the shutdown for RDMA QIOChannel")
Reviewed-by: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 2d839fce6c..e6837184c8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2986,7 +2986,7 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
     RCU_READ_LOCK_GUARD();
 
     rdmain = qatomic_rcu_read(&rioc->rdmain);
-    rdmaout = qatomic_rcu_read(&rioc->rdmain);
+    rdmaout = qatomic_rcu_read(&rioc->rdmaout);
 
     switch (how) {
     case QIO_CHANNEL_SHUTDOWN_READ:
-- 
2.50.1


