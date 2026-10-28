Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DA7606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SURVPK12;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=n0cG+qpK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7G0-000826-CE; Wed, 28 Oct 2026 13:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Ff-0007AX-AL
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fc-0003oN-B3
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tw+CVCUsPnLtaPci+OIuURX45h98/jNrsEdIgRJ87Qc=;
 b=SURVPK12R2nQHw/kbDxQ9klMNczNir5j3oRgXfsLmuLvOTSad/EP0yh/AFn45Ei0qOFKqq
 EnuRlV3LxfFZQ1JEu7WHcygNdcpCf7//5L6M6fzK1i/5rPTWLjTknnuCN5j7vVqZcaaSh0
 WYyuwWkbF17UPM44BkUG7pFAOp7K84o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-LKqF6Cd2NCmfyEbqFms6cA-1; Wed, 28 Oct 2026 13:15:45 -0400
X-MC-Unique: LKqF6Cd2NCmfyEbqFms6cA-1
X-Mimecast-MFC-AGG-ID: LKqF6Cd2NCmfyEbqFms6cA_1793207744
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48df02b91f9so1537309f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207744; x=1793812544; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tw+CVCUsPnLtaPci+OIuURX45h98/jNrsEdIgRJ87Qc=;
 b=n0cG+qpK3X62gwKxK6pETYxyxcDf4PaKaay/HTN4MyP/3PYEyb+oP3ViIiwQWi9Qca
 UY0IpPuDqBJElyj/a2Wv8S8Au/EFWnFqwrXeTY5KtgWuYVz7I+0SsByvdarPeAFWA6Sv
 fCxOq98oNydEG1M1ds2g7ZejgQ7FBwtQD6WWVlu8LxHdPoHVL0k5EEjeKoguaYwO4wfl
 1S2e96vi/2I7cuzdKfvNChAcFxSjMMYuK36MMpotYb/f2fgHknh5VB9T5+7A+7VaHzTs
 z/SSp25PF7CFFh93lGxuSkLk9QKErN+vf98xY80R/JKuDTByJh1b4Irp/c2JQ0txwSZU
 rojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207744; x=1793812544;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Tw+CVCUsPnLtaPci+OIuURX45h98/jNrsEdIgRJ87Qc=;
 b=lveXFxbSGsZXlmDQGcxEzmD3PLRBAvzxm3Af1sLApGyY4zCayeIWUM1UhJ4y9NkSQg
 Vic+3dcPIvBwDZA0ju6GxR78PDHvaenlXd5/CuKjfHo0TDA7TUOjuRIZg8mexqgJIh4/
 moyTwTuWFLj9VUL8eu1/kkOXmzJshIfFjI4Q1GG7BvTQqsvNutYMe9cndQH2P/pzwbiP
 1XZFafOFjeCG3V0/kk1EvzOe+FP6VGNd2rlIxYrdGx8VrzE9x5zClIpQr+vvPm7ZRK2y
 nCfNt7sdSDPjDkbXICaf1pwzYWDLxnKux1aYxml8fvLnaKyjOIcZsdYiSVQPXLEVPThs
 I+QQ==
X-Gm-Message-State: AFq9FYKN+tQfsu50S0KfxItX46Dc+CP5GKlFTcAzU+8NNF+bGe2/1497
 yDMoOzQvgo67txC/dyIuua08HQCDcAaSSQJzOe22SVHhtqSOc7qk4daQciwHAfWp0ixJHqpm52Z
 OCecqjDKsemEU9Qwjq4dcwHrfD/EF2HnS5wqYyq1QTvdOd7f+snoaEpHgRvhsog5492g0k15UgD
 U7QpgrIixGW7W64GzKVbsOaYVxl0brUzv4QA==
X-Gm-Gg: AYBFou2Jan6CHJA9UVu0b0/rIPPQp20PrT4Pq1vL1D98ErqQo5bEgJ/bDarNIIaLT8q
 iBq5VKFFNK7vCPy1rG8erR2c19L6I6NRwJxTK6yujioaYfYINmRgw3KVG//Bmg4lvuG8grVGDJZ
 aEeBzgrDCdN/GUNngrweVixSlx1H7sh09tCfK59uEOc5wiqIomWtKR1lz4z7aa52pTfysurP/AH
 j6+E/kU6REQLzpkZmFm6oKoyZtnrPn3LtAJ+BpEseDJtF7u72lHjMvDwhvLczAUz9NPfSOhhyRg
 Nk0bB3/+HJKXNko1/i2NwVX401L5kP/JrSCXI2g/bgNLu/ij9tCKwRTNLsbq0hBAymoHRP63vyE
 dxZZ/yCZTqQ4GYV4mOOpFSalLG33HeAVi4F5MWziq
X-Received: by 2002:a05:6000:98b:b0:48c:6756:dab3 with SMTP id
 ffacd0b85a97d-48e64945b11mr627116f8f.3.1793207744279; 
 Wed, 28 Oct 2026 10:15:44 -0700 (PDT)
X-Received: by 2002:a05:6000:98b:b0:48c:6756:dab3 with SMTP id
 ffacd0b85a97d-48e64945b11mr627004f8f.3.1793207743665; 
 Wed, 28 Oct 2026 10:15:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd354asm28340850f8f.43.2026.10.28.10.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:43 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Junjie Cao <junjie.cao@linux.dev>, Anisa Su <anisa.su@samsung.com>,
 linux-cxl@vger.kernel.org
Subject: [PULL 39/78] hw/cxl: clear poison lists and feature transfer state
 on reset
Message-ID: <4ec0aba480960b90cd0acf2ff08ebbcb71b1973e.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junjie Cao <junjie.cao@intel.com>

The poison lists (active, backup, and scan-media results), their
associated overflow tracking, and the Set Feature partial-transfer
state are all device-internal dynamic state that accumulates during
the device's lifetime.

Per CXL r4.0 Table 8-309 (Identify Memory Device), the "Injects
Persistent Poison" capability bit (offset 41h, Bit[0]) controls poison
retention across reset.  When cleared — the QEMU default — "a
Conventional Reset or CXL Reset shall automatically clear the injected
poison."  Clear all poison lists accordingly, reusing the existing
cxl_clear_poison_list_overflowed() helper for the overflow tracking.

For the Set Feature transfer state, CXL r4.0 Section 8.2.10.6.3 (Set
Feature) requires: "If the Feature data transfer is interrupted by a
Conventional Reset or a CXL Reset, the Feature data transfer shall be
aborted by the device [...] the device shall require the Feature data
transfer to be started from the beginning."  Zero set_feat_info on
reset so any partially transferred Set Feature is abandoned and must
restart from the beginning.

Both clears run after the RESET_TYPE_WAKEUP early-return added in the
previous patch, so this state is preserved across a suspend-to-RAM
wakeup.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260729144645.1552511-8-junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 26c3773dc0..1ff01121f8 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1327,6 +1327,16 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
+static void ct3d_clear_poison_list(CXLPoisonList *list)
+{
+    CXLPoison *ent, *next;
+
+    QLIST_FOREACH_SAFE(ent, list, node, next) {
+        QLIST_REMOVE(ent, node);
+        g_free(ent);
+    }
+}
+
 static void ct3d_reset_hold(Object *obj, ResetType type)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(obj);
@@ -1377,6 +1387,14 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
         ct3d->cxl_dstate.event_logs[i].irq_enabled = false;
     }
     ct3d->scan_media_hasrun = false;
+
+    ct3d_clear_poison_list(&ct3d->poison_list);
+    ct3d_clear_poison_list(&ct3d->poison_list_bkp);
+    ct3d_clear_poison_list(&ct3d->scan_media_results);
+    ct3d->poison_list_cnt = 0;
+    cxl_clear_poison_list_overflowed(ct3d);
+
+    memset(&ct3d->set_feat_info, 0, sizeof(ct3d->set_feat_info));
 }
 
 static const Property ct3_props[] = {
-- 
MST


