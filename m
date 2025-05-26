Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8800DC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 08:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJSqQ-0004ZT-0g; Mon, 26 May 2025 04:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJSq5-0004IA-EU
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJSq3-0002Ex-A1
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748246738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I33FgAryYV9+ja2H+TVACWnyShhaN7ocIfpahTBYz2o=;
 b=dYRIzEn9Nie7AJ8YhdpgekpUAVhLSyaj2DvATm89Qwnwmk77dOY90/dPRAdfz6MZ7OkKHm
 IDY0/wSydaJtjrvDj1vak5fehYQtv2TFD91veGqiJ6fCJ+YrweEs2GGusBirOxTFiR8hcQ
 oxVS3X8/QBvsR9xNX0JzyfYxmTBCwtM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-oa37XNNGM229Ho_02BczZg-1; Mon,
 26 May 2025 04:05:34 -0400
X-MC-Unique: oa37XNNGM229Ho_02BczZg-1
X-Mimecast-MFC-AGG-ID: oa37XNNGM229Ho_02BczZg_1748246733
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0D5A1800877; Mon, 26 May 2025 08:05:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 15DA71800DB9; Mon, 26 May 2025 08:05:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/39] hw/misc/aspeed_hace: Remove unused code for better
 readability
Date: Mon, 26 May 2025 10:04:36 +0200
Message-ID: <20250526080512.1697528-4-clg@redhat.com>
In-Reply-To: <20250526080512.1697528-1-clg@redhat.com>
References: <20250526080512.1697528-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

In the previous design of the hash framework, accumulative hashing was not
supported. To work around this limitation, commit 5cd7d85 introduced an
iov_cache array to store all the hash data from firmware.
Once the ASPEED HACE model collected all the data, it passed the iov_cache to
the hash API to calculate the final digest.

However, with commit e3c0752, the hash framework now supports accumulative
hashing. This allows us to refactor the ASPEED HACE model, removing redundant
logic and simplifying the implementation for better readability and
maintainability.

As a result, the iov_count variable is no longer needed—it was previously used
to track how many cached entries were used for hashing.
To maintain VMSTATE compatibility after removing this field, the VMSTATE_VERSION
is bumped to 2

This cleanup follows significant changes in commit 4c1d0af4a28d, making the
model more readable.

- Deleted "iov_cache" and "iov_count" from "AspeedHACEState".
- Removed "reconstruct_iov" function and related logic.
- Simplified "do_hash_operation" by eliminating redundant checks.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250515081008.583578-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/misc/aspeed_hace.h |  2 --
 hw/misc/aspeed_hace.c         | 39 ++---------------------------------
 2 files changed, 2 insertions(+), 39 deletions(-)

diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h
index 5d4aa19cfecb..b69a038d3540 100644
--- a/include/hw/misc/aspeed_hace.h
+++ b/include/hw/misc/aspeed_hace.h
@@ -31,10 +31,8 @@ struct AspeedHACEState {
     MemoryRegion iomem;
     qemu_irq irq;
 
-    struct iovec iov_cache[ASPEED_HACE_MAX_SG];
     uint32_t regs[ASPEED_HACE_NR_REGS];
     uint32_t total_req_len;
-    uint32_t iov_count;
 
     MemoryRegion *dram_mr;
     AddressSpace dram_as;
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index f4bff32a0041..9263739ea634 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -142,25 +142,6 @@ static bool has_padding(AspeedHACEState *s, struct iovec *iov,
     return false;
 }
 
-static int reconstruct_iov(AspeedHACEState *s, struct iovec *iov, int id,
-                           uint32_t *pad_offset)
-{
-    int i, iov_count;
-    if (*pad_offset != 0) {
-        s->iov_cache[s->iov_count].iov_base = iov[id].iov_base;
-        s->iov_cache[s->iov_count].iov_len = *pad_offset;
-        ++s->iov_count;
-    }
-    for (i = 0; i < s->iov_count; i++) {
-        iov[i].iov_base = s->iov_cache[i].iov_base;
-        iov[i].iov_len = s->iov_cache[i].iov_len;
-    }
-    iov_count = s->iov_count;
-    s->iov_count = 0;
-    s->total_req_len = 0;
-    return iov_count;
-}
-
 static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
                               bool acc_mode)
 {
@@ -242,19 +223,6 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
         iov[0].iov_base = haddr;
         iov[0].iov_len = len;
         i = 1;
-
-        if (s->iov_count) {
-            /*
-             * In aspeed sdk kernel driver, sg_mode is disabled in hash_final().
-             * Thus if we received a request with sg_mode disabled, it is
-             * required to check whether cache is empty. If no, we should
-             * combine cached iov and the current iov.
-             */
-            s->total_req_len += len;
-            if (has_padding(s, iov, len, &total_msg_len, &pad_offset)) {
-                i = reconstruct_iov(s, iov, 0, &pad_offset);
-            }
-        }
     }
 
     if (acc_mode) {
@@ -278,7 +246,6 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
             qcrypto_hash_free(s->hash_ctx);
 
             s->hash_ctx = NULL;
-            s->iov_count = 0;
             s->total_req_len = 0;
         }
     } else if (qcrypto_hash_bytesv(algo, iov, i, &digest_buf,
@@ -437,7 +404,6 @@ static void aspeed_hace_reset(DeviceState *dev)
     }
 
     memset(s->regs, 0, sizeof(s->regs));
-    s->iov_count = 0;
     s->total_req_len = 0;
 }
 
@@ -469,12 +435,11 @@ static const Property aspeed_hace_properties[] = {
 
 static const VMStateDescription vmstate_aspeed_hace = {
     .name = TYPE_ASPEED_HACE,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedHACEState, ASPEED_HACE_NR_REGS),
         VMSTATE_UINT32(total_req_len, AspeedHACEState),
-        VMSTATE_UINT32(iov_count, AspeedHACEState),
         VMSTATE_END_OF_LIST(),
     }
 };
-- 
2.49.0


