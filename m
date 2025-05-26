Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF35C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 08:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJSqS-0004fN-0b; Mon, 26 May 2025 04:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJSq8-0004J3-K5
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:05:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJSq6-0002FI-Fa
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748246740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u7+6f7dyvEmP+3WDhn4ylFPfKNj5QgABGkT3bv7W0G0=;
 b=ej5VFp+mNjKZ19jxh2MSWJqPwd2dQmKl6xaMXwDehYry7pP2SY5YLfzIBW6Gr8aV7ZpQFJ
 Gd/mgFZ7U4PaGWaQMSaOUujIuZ3SIQ/k/xJ95yolLLxzd0msuOFxTJoRUFlBX7ngZzywNL
 z8o2jcRzfRXJju9sC/7t6k4siJsNwHQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-hjswua4oO9aVRBbUiDX3hw-1; Mon,
 26 May 2025 04:05:36 -0400
X-MC-Unique: hjswua4oO9aVRBbUiDX3hw-1
X-Mimecast-MFC-AGG-ID: hjswua4oO9aVRBbUiDX3hw_1748246735
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D991195608A; Mon, 26 May 2025 08:05:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B96A18003FD; Mon, 26 May 2025 08:05:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/39] hw/misc/aspeed_hace: Improve readability and consistency
 in variable naming
Date: Mon, 26 May 2025 10:04:37 +0200
Message-ID: <20250526080512.1697528-5-clg@redhat.com>
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Currently, users define multiple local variables within different if-statements.
To improve readability and maintain consistency in variable naming, rename the
variables accordingly.
Introduced "sg_addr" to clearly indicate the scatter-gather mode buffer address.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250515081008.583578-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_hace.c | 67 +++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 9263739ea634..6be94963bce7 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -145,15 +145,19 @@ static bool has_padding(AspeedHACEState *s, struct iovec *iov,
 static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
                               bool acc_mode)
 {
+    g_autofree uint8_t *digest_buf = NULL;
     struct iovec iov[ASPEED_HACE_MAX_SG];
+    bool acc_final_request = false;
+    Error *local_err = NULL;
     uint32_t total_msg_len;
-    uint32_t pad_offset;
-    g_autofree uint8_t *digest_buf = NULL;
     size_t digest_len = 0;
-    bool sg_acc_mode_final_request = false;
-    int i;
+    uint32_t sg_addr = 0;
+    uint32_t pad_offset;
+    int iov_idx = 0;
+    uint32_t len = 0;
+    uint32_t src = 0;
     void *haddr;
-    Error *local_err = NULL;
+    hwaddr plen;
 
     if (acc_mode && s->hash_ctx == NULL) {
         s->hash_ctx = qcrypto_hash_new(algo, &local_err);
@@ -166,74 +170,69 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
     }
 
     if (sg_mode) {
-        uint32_t len = 0;
-
-        for (i = 0; !(len & SG_LIST_LEN_LAST); i++) {
-            uint32_t addr, src;
-            hwaddr plen;
-
-            if (i == ASPEED_HACE_MAX_SG) {
+        for (iov_idx = 0; !(len & SG_LIST_LEN_LAST); iov_idx++) {
+            if (iov_idx == ASPEED_HACE_MAX_SG) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                         "aspeed_hace: guest failed to set end of sg list marker\n");
                 break;
             }
 
-            src = s->regs[R_HASH_SRC] + (i * SG_LIST_ENTRY_SIZE);
+            src = s->regs[R_HASH_SRC] + (iov_idx * SG_LIST_ENTRY_SIZE);
 
             len = address_space_ldl_le(&s->dram_as, src,
                                        MEMTXATTRS_UNSPECIFIED, NULL);
 
-            addr = address_space_ldl_le(&s->dram_as, src + SG_LIST_LEN_SIZE,
-                                        MEMTXATTRS_UNSPECIFIED, NULL);
-            addr &= SG_LIST_ADDR_MASK;
+            sg_addr = address_space_ldl_le(&s->dram_as, src + SG_LIST_LEN_SIZE,
+                                           MEMTXATTRS_UNSPECIFIED, NULL);
+            sg_addr &= SG_LIST_ADDR_MASK;
 
             plen = len & SG_LIST_LEN_MASK;
-            haddr = address_space_map(&s->dram_as, addr, &plen, false,
+            haddr = address_space_map(&s->dram_as, sg_addr, &plen, false,
                                       MEMTXATTRS_UNSPECIFIED);
             if (haddr == NULL) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "%s: qcrypto failed\n", __func__);
                 return;
             }
-            iov[i].iov_base = haddr;
+            iov[iov_idx].iov_base = haddr;
             if (acc_mode) {
                 s->total_req_len += plen;
 
-                if (has_padding(s, &iov[i], plen, &total_msg_len,
+                if (has_padding(s, &iov[iov_idx], plen, &total_msg_len,
                                 &pad_offset)) {
                     /* Padding being present indicates the final request */
-                    sg_acc_mode_final_request = true;
-                    iov[i].iov_len = pad_offset;
+                    acc_final_request = true;
+                    iov[iov_idx].iov_len = pad_offset;
                 } else {
-                    iov[i].iov_len = plen;
+                    iov[iov_idx].iov_len = plen;
                 }
             } else {
-                iov[i].iov_len = plen;
+                iov[iov_idx].iov_len = plen;
             }
         }
     } else {
-        hwaddr len = s->regs[R_HASH_SRC_LEN];
+        plen = s->regs[R_HASH_SRC_LEN];
 
         haddr = address_space_map(&s->dram_as, s->regs[R_HASH_SRC],
-                                  &len, false, MEMTXATTRS_UNSPECIFIED);
+                                  &plen, false, MEMTXATTRS_UNSPECIFIED);
         if (haddr == NULL) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto failed\n", __func__);
             return;
         }
         iov[0].iov_base = haddr;
-        iov[0].iov_len = len;
-        i = 1;
+        iov[0].iov_len = plen;
+        iov_idx = 1;
     }
 
     if (acc_mode) {
-        if (qcrypto_hash_updatev(s->hash_ctx, iov, i, &local_err) < 0) {
+        if (qcrypto_hash_updatev(s->hash_ctx, iov, iov_idx, &local_err) < 0) {
             qemu_log_mask(LOG_GUEST_ERROR, "qcrypto hash update failed : %s",
                           error_get_pretty(local_err));
             error_free(local_err);
             return;
         }
 
-        if (sg_acc_mode_final_request) {
+        if (acc_final_request) {
             if (qcrypto_hash_finalize_bytes(s->hash_ctx, &digest_buf,
                                             &digest_len, &local_err)) {
                 qemu_log_mask(LOG_GUEST_ERROR,
@@ -248,7 +247,7 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
             s->hash_ctx = NULL;
             s->total_req_len = 0;
         }
-    } else if (qcrypto_hash_bytesv(algo, iov, i, &digest_buf,
+    } else if (qcrypto_hash_bytesv(algo, iov, iov_idx, &digest_buf,
                                    &digest_len, &local_err) < 0) {
         qemu_log_mask(LOG_GUEST_ERROR, "qcrypto hash bytesv failed : %s",
                       error_get_pretty(local_err));
@@ -263,10 +262,10 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
                       "aspeed_hace: address space write failed\n");
     }
 
-    for (; i > 0; i--) {
-        address_space_unmap(&s->dram_as, iov[i - 1].iov_base,
-                            iov[i - 1].iov_len, false,
-                            iov[i - 1].iov_len);
+    for (; iov_idx > 0; iov_idx--) {
+        address_space_unmap(&s->dram_as, iov[iov_idx - 1].iov_base,
+                            iov[iov_idx - 1].iov_len, false,
+                            iov[iov_idx - 1].iov_len);
     }
 
     /*
-- 
2.49.0


