Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E92C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qgo-0007HW-CE; Tue, 30 Apr 2024 12:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgi-0006Zy-KW
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:41 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgf-00064t-6E
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:40 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2de2f5ca076so67933021fa.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714495831; x=1715100631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yU40+YVWxkJADy+Z4l2CwzlxvDSuLGvZgzgju3wrOiw=;
 b=Rbu1zNCaQsUcFY+ry1YphfcA+1qLkxp/QcIOcEBLJbgyVQN21mTFE1m4jSuRrtO4as
 krRX/zwRamD+EKQP8OE9w9A7A02f0OuKvtKZ3IYjpFN5oiRLLptILiKTcCUqGWYoqyIh
 rB6lpqB3F7/gogmnlh054SVms3w2G7tPIcS/Rq5At5ur052D5oMvjKlERSK79DzRBFIK
 sN/0dP4D5lp82GniqGy9ML65o0E77PpqzDOMYOOLgPGSsSeKKdltaVMBCyyOmDQ0NYmg
 SZVDlb/zkm8/zNINrpl8Bfd3PQOjLYzWqVyDgL9Rob4AXhSeZATfSaX/JPMu9ZC32i3f
 RpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495831; x=1715100631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yU40+YVWxkJADy+Z4l2CwzlxvDSuLGvZgzgju3wrOiw=;
 b=pzHRrxDSGT/lVi8W+haJh3cqYUiNv3metZNxgoCawwJenSn3RWu8EZPxAIjfzRDS0G
 s9Nry7yxdzBxVo/r/+QABpBytHLxix5RTmzlQoHB1laAZevhK4YdG+S3VTZY+G0WCo7J
 0qXTJqFVXTaKtyp4TsWMn8i2dKuvCCr8hzG6ZJwCi0Rt6D9sbwP5+c19Xs/ZVsD5ENxU
 yY/uwKR+TpmMS979x9MikTaOtqAhpZfP7tpRZiwDxJnyo+zEcJgyXo2XJf3p+/ajhBgF
 o0VkiB4yJPmH9129ZOtKvXbTw0gzaoqNcIz3dudTsr6sNN1cpQUsR8GtZqLFKF9Jtc7h
 KcyQ==
X-Gm-Message-State: AOJu0YyLYhcrqjEwwkPrhKnPZ9KolK5/PRlL60tau4R97o/lX2wa84xO
 5C6PRbDpNWBX6t9R1qMzO1W9D+x9rVm1AtYckkdW6cb1/eD6ayIBWXxOCJDL
X-Google-Smtp-Source: AGHT+IF7NEHMVH11qhcbPGrROL4h9vPrTZ7L+HcLgKWakMJjuqsmWO3glx5CsV2GXCvTV6HEwqtzvg==
X-Received: by 2002:ac2:4984:0:b0:51c:c1a3:a4f9 with SMTP id
 f4-20020ac24984000000b0051cc1a3a4f9mr13762lfl.64.1714495831228; 
 Tue, 30 Apr 2024 09:50:31 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a056512360d00b0051ad4552454sm3943178lfs.148.2024.04.30.09.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:50:30 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 12/17] xen: mapcache: Unmap first entries in buckets
Date: Tue, 30 Apr 2024 18:49:34 +0200
Message-Id: <20240430164939.925307-13-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430164939.925307-1-edgar.iglesias@gmail.com>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

When invalidating memory ranges, if we happen to hit the first
entry in a bucket we were never unmapping it. This was harmless
for foreign mappings but now that we're looking to reuse the
mapcache for transient grant mappings, we must unmap entries
when invalidated.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 4f98d284dd..0365311788 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -486,18 +486,22 @@ static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
         return;
     }
     entry->lock--;
-    if (entry->lock > 0 || pentry == NULL) {
+    if (entry->lock > 0) {
         return;
     }
 
-    pentry->next = entry->next;
     ram_block_notify_remove(entry->vaddr_base, entry->size, entry->size);
     if (munmap(entry->vaddr_base, entry->size) != 0) {
         perror("unmap fails");
         exit(-1);
     }
-    g_free(entry->valid_mapping);
-    g_free(entry);
+    if (pentry) {
+        pentry->next = entry->next;
+        g_free(entry->valid_mapping);
+        g_free(entry);
+    } else {
+        memset(entry, 0, sizeof *entry);
+    }
 }
 
 typedef struct XenMapCacheData {
-- 
2.40.1


