Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB6606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dch7OB0w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaHH-0008Re-65; Tue, 27 Oct 2026 02:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Wj7gagoKCrUnoVigZtecpbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--stanleyjhu.bounces.google.com>)
 id 1xLaGA-0007qZ-9y
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:02:12 -0400
Received: from mail-pg1-x546.google.com ([2607:f8b0:4864:20::546])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Wj7gagoKCrUnoVigZtecpbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--stanleyjhu.bounces.google.com>)
 id 1xLaG6-00068f-QV
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:02:08 -0400
Received: by mail-pg1-x546.google.com with SMTP id
 41be03b00d2f7-ccacc75a997so1581529a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1793080923; x=1793685723; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GNPLe2N/OPKmVpGx/oLc6OH7h+zcVBsEsqwKPANF6lo=;
 b=dch7OB0wmBufIhhdRLeE7duAacmOKUJrDhjyBTEenfT34etW7QOdn944ghnlBXQgxp
 bE9N2aFSIsDrS2js5jU0nIRMyBmYqohrklkvinSZLJSP3QVFZf+eN507Dos1cQBa8dIO
 HJsQfN7A4g9kVAAiqZXguULA5/0dK6wvAjJxdSmgnB4XoPPx8ZTkBg1ZMxx5n/+G+cRS
 Z5gXgXdRZwWzMGO/xvAQ6TFkQOwOoss80i9NJQPjSugmQ3Gp0cq4fScAehSbM/TfLWwl
 bEh8FWsMd5/TsL3RvuaqN60n9nai8UDxzifzbae+MnpCfig5wstsVF47nTu0pJAOuk60
 /bkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793080923; x=1793685723;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GNPLe2N/OPKmVpGx/oLc6OH7h+zcVBsEsqwKPANF6lo=;
 b=mzK9f8m21xdF6fh7lboY0ptZpY9MH4kLrDq9dqRDCQdvnqVKgyHVwzATnwgMAbR9Oe
 dDdeK4uKA2W392MuzOx3oD3OfKyqb7WufOeuRstoTYy9/Qx+IlqnLUVOAagdwXchLWjG
 6LiWSIfy9P51/OJPb3CsJcfEZd7BZOfTze4Z4cq6WeQUN9azAp/ZpK5mf4wVIGIPsBVj
 /JofoBKaTn+USqNvLrE8TfSauPtW3Kx3B0BwmAv/jsHJDhz7tIjSrvOCIb9Y9BIz7y4a
 5L5cSrvlx2Cp253oVFni0ezU9dX21JdcvBA8AdWK5htSvufFGVVbjXpzqJVxG4tFRieC
 ERZA==
X-Gm-Message-State: AFq9FYJntdwdRW9S7JhFXii5FFhlo60UNaKM0UpxAs8J8zQkEM421S29
 t/S83Eb7PIXNcfEy7V9eICBohrHUKqozIeUHtfCk2d1KdfcFN3rXLSX02v94k7bwmANSTF1lMYC
 CUBN2FIX2/XU+JIbxiRkFHw==
X-Received: from pgbda2-n1.prod.google.com
 ([2002:a05:6a02:2382:10b0:cd8:c484:3c40])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:398:b0:3dd:f9ff:f5a with SMTP id
 adf61e73a8af0-3e7af7e9a36mr6453727637.9.1793080922559; 
 Mon, 26 Oct 2026 23:02:02 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:01:49 +0800
In-Reply-To: <20261027060153.1842910-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027060153.1842910-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027060153.1842910-5-stanleyjhu@google.com>
Subject: [PATCH 4/7] hw/ufs: Add RPMB key programming and write counter read
 handling
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::546;
 envelope-from=3Wj7gagoKCrUnoVigZtecpbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--stanleyjhu.bounces.google.com;
 helo=mail-pg1-x546.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add HMAC-SHA256 calculation (ufs_rpmb_calc_hmac() over frame bytes
[228:511] per JESD220H Section 12.4.4.2) using QCryptoHmac, and handle
authentication key programming (0x0001 -> 0x0100 with zeroed Key/MAC
per JESD220H Section 12.4.7.3.1 Figure 12.5, rejecting duplicate key
writes with UFS_RPMB_RES_WRITE_FAILURE per Section 12.4.3.1) and write
counter read requests (0x0002 -> 0x0200, returning
UFS_RPMB_RES_NO_AUTH_KEY before a key is programmed and a signed
response frame thereafter).

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 hw/ufs/rpmb.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/hw/ufs/rpmb.c b/hw/ufs/rpmb.c
index 3032e0e098..edd4b91fd8 100644
--- a/hw/ufs/rpmb.c
+++ b/hw/ufs/rpmb.c
@@ -6,9 +6,34 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "crypto/hmac.h"
 #include "trace.h"
 #include "ufs.h"
 
+/*
+ * JESD220H Section 12.4.4.2: the HMAC-SHA256 input message is the
+ * concatenation of bytes [228:511] (UFS_RPMB_HASH_OFFSET..511, 284 bytes)
+ * of each RPMB Message Data Frame in the order in which the frames are sent.
+ */
+static void ufs_rpmb_calc_hmac(const UfsRpmbRegion *r,
+                               const UfsRpmbFrame *frames,
+                               uint16_t count, uint8_t *mac)
+{
+    g_autoptr(QCryptoHmac) hmac = NULL;
+    size_t mac_len = UFS_RPMB_KEY_MAC_LEN;
+    g_autofree struct iovec *iov = g_new(struct iovec, count);
+    uint16_t i;
+
+    hmac = qcrypto_hmac_new(QCRYPTO_HASH_ALGO_SHA256, r->key,
+                            UFS_RPMB_KEY_MAC_LEN, &error_abort);
+    for (i = 0; i < count; i++) {
+        iov[i].iov_base = (uint8_t *)&frames[i] + UFS_RPMB_HASH_OFFSET;
+        iov[i].iov_len = UFS_RPMB_HASH_LEN;
+    }
+
+    qcrypto_hmac_bytesv(hmac, iov, count, &mac, &mac_len, &error_abort);
+}
+
 static void ufs_rpmb_handle_req(UfsHc *u, UfsRpmbRegion *r,
                                 const UfsRpmbFrame *frames,
                                 uint32_t nframes)
@@ -16,6 +41,7 @@ static void ufs_rpmb_handle_req(UfsHc *u, UfsRpmbRegion *r,
     const UfsRpmbFrame *req = &frames[0];
     uint16_t req_type = lduw_be_p(&req->req_resp);
     uint16_t result = UFS_RPMB_RES_GENERAL_FAILURE;
+    bool sign_resp = false;
 
     if (req_type == UFS_RPMB_REQ_READ_RESULT) {
         trace_ufs_rpmb_request(req_type, lduw_be_p(&r->resp.result));
@@ -26,6 +52,39 @@ static void ufs_rpmb_handle_req(UfsHc *u, UfsRpmbRegion *r,
     memset(&r->resp, 0, sizeof(r->resp));
 
     switch (req_type) {
+    case UFS_RPMB_REQ_PROGRAM_KEY:
+        /*
+         * JESD220H Section 12.4.7.3.1 Figure 12.5: the Authentication Key
+         * Programming Result Read response (0x0100) has bytes [196:227]
+         * (Key/MAC) and [484:499] (Nonce) set to 0...00h.
+         */
+        r->resp.req_resp = cpu_to_be16(UFS_RPMB_RESP_PROGRAM_KEY);
+        /*
+         * JESD220H Section 12.4.7.3.1 (Figure 12.5) and Section 12.4.3.1:
+         * programming an Authentication Key after one is already programmed
+         * fails with Write failure (0x0005).
+         */
+        if (r->key_set) {
+            result = UFS_RPMB_RES_WRITE_FAILURE;
+            break;
+        }
+        memcpy(r->key, req->key_mac, UFS_RPMB_KEY_MAC_LEN);
+        r->key_set = true;
+        result = UFS_RPMB_RES_OK;
+        break;
+
+    case UFS_RPMB_REQ_READ_COUNTER:
+        memcpy(r->resp.nonce, req->nonce, UFS_RPMB_NONCE_LEN);
+        r->resp.req_resp = cpu_to_be16(UFS_RPMB_RESP_READ_COUNTER);
+        if (!r->key_set) {
+            result = UFS_RPMB_RES_NO_AUTH_KEY;
+            break;
+        }
+        r->resp.write_counter = cpu_to_be32(r->write_counter);
+        result = UFS_RPMB_RES_OK;
+        sign_resp = true;
+        break;
+
     default:
         r->resp.req_resp = cpu_to_be16(req_type);
         result = UFS_RPMB_RES_GENERAL_FAILURE;
@@ -37,6 +96,10 @@ static void ufs_rpmb_handle_req(UfsHc *u, UfsRpmbRegion *r,
     }
     r->resp.result = cpu_to_be16(result);
 
+    if (sign_resp) {
+        ufs_rpmb_calc_hmac(r, &r->resp, 1, r->resp.key_mac);
+    }
+
     trace_ufs_rpmb_request(req_type, result);
 }
 
-- 
2.56.0.307.g5fe7bd680c-goog


