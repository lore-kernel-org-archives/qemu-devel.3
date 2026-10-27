Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431CD606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vBdWLRsi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaH9-0008Ez-CH; Tue, 27 Oct 2026 02:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Xj7gagoKCrkrsZmkdxigtfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--stanleyjhu.bounces.google.com>)
 id 1xLaGF-0007s3-O7
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:02:20 -0400
Received: from mail-pf1-x445.google.com ([2607:f8b0:4864:20::445])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Xj7gagoKCrkrsZmkdxigtfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--stanleyjhu.bounces.google.com>)
 id 1xLaGB-00069L-RG
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:02:13 -0400
Received: by mail-pf1-x445.google.com with SMTP id
 d2e1a72fcca58-89e6ddd4554so2905883b3a.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1793080927; x=1793685727; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Jqg0A5WeRaJl7VqkqFHuoxyU+sLfvSzxG/NUgUHv9eQ=;
 b=vBdWLRsiRQSX3J9pbkljMbr0QJhBXVmKqvtZLYh1sO5ZWqQinBme4JRkyv66cmDkDn
 o9Pl3ZjubVOzqfXaZTS4PJk5obj3UjYNaPbfIX9GjS1mwPJVh0ni6RtQZu5d5cEWavII
 vedTVF16vvaSHDxXnPealQ+jJdQPia0Bt9ubx2GWU5Xvyp/i8zgFPPmFuRzwBQzVFTXY
 pFSexWMQEaQPqpl0VySEUM4lkGwx+8ysPYy7mUTrpQ1ECz/0QkZUf7gbRc28ZOGusgIx
 e+nCjhLVng3ZRaUrSZhNg/2Ol/PHs4lIhjX3H2VlIYEbr2wlRaq5y05E5kefC8dxo30R
 8YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793080927; x=1793685727;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jqg0A5WeRaJl7VqkqFHuoxyU+sLfvSzxG/NUgUHv9eQ=;
 b=KnJukkNcRaB7zHf8lS1GjZalONegXYrroFoMHOlj1E3RY5ssnhyYTTLTvPYDHYNRHF
 N8FubKrWfxQxDubZ9MGwgGW8JE/ImMOTaqxFYtExKqnYY/j8ulfvDb7CTFP0+DCR70ol
 xVOYzI7RRYexmSHEUlj1L4rAGq6ZxWqr6wqo/pKatEMospuTaqgHoB9JxXR1B3Tf0Wu/
 rtCESnxeUL7Pc1zXOrpk691xSI9gRp6fIEJpvL+JvEAQ2n8PJHCeoS7w544W6A7P8mHZ
 GYLwz30DsraOzWX8nABc8lAoYuEdmTBbPSz5NROD25BL1oT1PhOrXMtcBLNamsLy2WUA
 7eog==
X-Gm-Message-State: AFq9FYKDtGPpWX8ALqMZ511HSg5rU7PS5WW5WL4jHZHG0MLarbW95CbS
 PnxYNN8MIkIbuYP7XPYPjhEQ4xqlpn7Dc+hEz8SzxkUQf1Ef+dpxWa2bZFNEWQWXLz72k9AR31g
 iP5+POSH5H42XCk7YvHFLDQ==
X-Received: from pfbih13.prod.google.com
 ([2002:a05:6a00:8c0d:b0:89f:2a5b:4e34])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:12cb:b0:8a0:2cae:c805 with SMTP id
 d2e1a72fcca58-8a36486723bmr6959759b3a.2.1793080926495; 
 Mon, 26 Oct 2026 23:02:06 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:01:51 +0800
In-Reply-To: <20261027060153.1842910-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027060153.1842910-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027060153.1842910-7-stanleyjhu@google.com>
Subject: [PATCH 6/7] hw/ufs: Add RPMB authenticated data write and read
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::445;
 envelope-from=3Xj7gagoKCrkrsZmkdxigtfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x445.google.com
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

Complete RPMB well-known logical unit emulation in hw/ufs/rpmb.c and
update docs/system/devices/ufs.rst:

- Support single- and multi-frame authenticated data writes (0x0003),
  checking write counter expiration, address bounds, block count and
  multi-frame header consistency, MAC, and write counter in the order
  specified by JESD220H Section 12.4.7.3.3, and incrementing the write
  counter once per command.
- Support single- and multi-frame authenticated data reads (0x0004),
  validating PRDT buffer capacity before clearing read_pending, checking
  address bounds before block count, and building the response via
  ufs_rpmb_do_read() with Stuff bytes [0:195] and Write counter
  [500:503] zeroed per JESD220H Section 12.4.7.3.4 and Figure 12.8.
- Materialize the signed 1-frame 0x0400 response into the Result
  Register when Result Read (0x0005) arrives while a 0x0004 read is
  pending without a prior SECURITY PROTOCOL IN.
- Free allocated region storage buffers in ufs_unrealize().

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 docs/system/devices/ufs.rst |   6 +-
 hw/ufs/rpmb.c               | 214 ++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.c                |   5 +
 3 files changed, 223 insertions(+), 2 deletions(-)

diff --git a/docs/system/devices/ufs.rst b/docs/system/devices/ufs.rst
index 36f5b958cf..7bf7352c4c 100644
--- a/docs/system/devices/ufs.rst
+++ b/docs/system/devices/ufs.rst
@@ -139,6 +139,8 @@ Limitations
   requests are supported; other task management functions such as
   ``LOGICAL UNIT RESET`` return ``TASK MANAGEMENT FUNCTION NOT
   SUPPORTED``.
-* The Boot and RPMB well-known logical units only answer basic SCSI
-  commands such as INQUIRY; boot and RPMB data access are not emulated.
+* The Boot well-known logical unit only answers basic SCSI commands
+  such as INQUIRY; boot data access is not emulated. The RPMB
+  well-known logical unit emulates four 4 MiB regions in host memory
+  (volatile across QEMU restarts).
 * The device cannot be migrated.
diff --git a/hw/ufs/rpmb.c b/hw/ufs/rpmb.c
index edd4b91fd8..344f0708ad 100644
--- a/hw/ufs/rpmb.c
+++ b/hw/ufs/rpmb.c
@@ -10,6 +10,13 @@
 #include "trace.h"
 #include "ufs.h"
 
+static void ufs_rpmb_ensure_storage(UfsRpmbRegion *r)
+{
+    if (!r->storage) {
+        r->storage = g_malloc0(UFS_RPMB_REGION_BYTES);
+    }
+}
+
 /*
  * JESD220H Section 12.4.4.2: the HMAC-SHA256 input message is the
  * concatenation of bytes [228:511] (UFS_RPMB_HASH_OFFSET..511, 284 bytes)
@@ -34,6 +41,142 @@ static void ufs_rpmb_calc_hmac(const UfsRpmbRegion *r,
     qcrypto_hmac_bytesv(hmac, iov, count, &mac, &mac_len, &error_abort);
 }
 
+static uint16_t ufs_rpmb_do_write(UfsHc *u, UfsRpmbRegion *r,
+                                  const UfsRpmbFrame *frames,
+                                  uint32_t nframes)
+{
+    uint8_t mac[UFS_RPMB_KEY_MAC_LEN];
+    uint16_t addr = lduw_be_p(&frames[0].addr);
+    uint16_t blk_cnt = lduw_be_p(&frames[0].block_count);
+    uint32_t req_wc = ldl_be_p(&frames[0].write_counter);
+    uint8_t max_rw = u->geometry_desc.rpmb_read_write_size;
+    uint32_t i;
+
+    /*
+     * JESD220H Section 12.4.7.3.3: check write counter expiration (0x0085),
+     * target address and address + block count bounds (0x0004), block count
+     * and frame fields (0x0001), MAC (0x0002), and write counter (0x0003) in
+     * order.
+     */
+    if (!r->key_set) {
+        return UFS_RPMB_RES_NO_AUTH_KEY;
+    }
+    if (r->write_counter == 0xffffffff) {
+        return UFS_RPMB_RES_WRITE_FAILURE;
+    }
+    if (addr >= UFS_RPMB_REGION_BLOCKS ||
+        (uint32_t)addr + blk_cnt > UFS_RPMB_REGION_BLOCKS) {
+        return UFS_RPMB_RES_ADDR_FAILURE;
+    }
+    if (blk_cnt == 0 || blk_cnt > max_rw || blk_cnt != nframes) {
+        return UFS_RPMB_RES_GENERAL_FAILURE;
+    }
+    /*
+     * JESD220H Section 12.4.7.3.3: every frame of a multi-block Authenticated
+     * Data Write carries identical req_resp, block_count, addr, and
+     * write_counter values, or fails with General failure (0x0001).
+     */
+    for (i = 0; i < nframes; i++) {
+        if (lduw_be_p(&frames[i].req_resp) != UFS_RPMB_REQ_AUTH_DATA_WRITE ||
+            lduw_be_p(&frames[i].block_count) != blk_cnt ||
+            lduw_be_p(&frames[i].addr) != addr ||
+            ldl_be_p(&frames[i].write_counter) != req_wc) {
+            return UFS_RPMB_RES_GENERAL_FAILURE;
+        }
+    }
+    ufs_rpmb_calc_hmac(r, frames, nframes, mac);
+    if (memcmp(mac, frames[nframes - 1].key_mac, UFS_RPMB_KEY_MAC_LEN) != 0) {
+        return UFS_RPMB_RES_AUTH_FAILURE;
+    }
+    if (req_wc != r->write_counter) {
+        return UFS_RPMB_RES_COUNT_FAILURE;
+    }
+
+    ufs_rpmb_ensure_storage(r);
+    for (i = 0; i < nframes; i++) {
+        memcpy(r->storage + ((uint32_t)addr + i) * UFS_RPMB_DATA_LEN,
+               frames[i].data, UFS_RPMB_DATA_LEN);
+    }
+    /*
+     * JESD220H Section 12.4.3.1 & Section 12.4.7.3.3: the write counter is
+     * incremented by one per successful authenticated data write command.
+     */
+    r->write_counter++;
+    return UFS_RPMB_RES_OK;
+}
+
+/*
+ * JESD220H Section 12.4.7.3.4 (Figure 12.8): build the Authenticated Data
+ * Read response (0x0400) for in_frames blocks (with bytes [0:195] Stuff bytes
+ * and [500:503] Write counter set to 0...00h) and update the region's latched
+ * Result Register (r->resp). On error, sign a single error frame (when
+ * key_set) and replicate it across all returned frames, matching the eMMC
+ * RPMB read model in emmc_rpmb_blk_read() (hw/sd/sd.c).
+ */
+static void ufs_rpmb_do_read(UfsHc *u, UfsRpmbRegion *r, uint32_t in_frames,
+                             UfsRpmbFrame *out_frames)
+{
+    uint16_t addr = lduw_be_p(&r->resp.addr);
+    uint16_t req_blk_cnt = lduw_be_p(&r->resp.block_count);
+    uint8_t max_rw = u->geometry_desc.rpmb_read_write_size;
+    uint16_t result;
+    bool ok = false;
+    uint32_t i;
+
+    /*
+     * JESD220H Section 12.4.7.3.4: check address and address + block count
+     * bounds (0x0004) before block count > bRPMB_ReadWriteSize (0x0001).
+     */
+    if (!r->key_set) {
+        result = UFS_RPMB_RES_NO_AUTH_KEY;
+    } else if (addr >= UFS_RPMB_REGION_BLOCKS ||
+               (uint32_t)addr + in_frames > UFS_RPMB_REGION_BLOCKS ||
+               (uint32_t)addr + req_blk_cnt > UFS_RPMB_REGION_BLOCKS) {
+        result = UFS_RPMB_RES_ADDR_FAILURE;
+    } else if (req_blk_cnt > max_rw) {
+        result = UFS_RPMB_RES_GENERAL_FAILURE;
+    } else {
+        result = UFS_RPMB_RES_OK;
+        ok = true;
+    }
+    if (r->write_counter == 0xffffffff) {
+        result |= UFS_RPMB_RES_COUNT_EXPIRED;
+    }
+
+    if (!ok) {
+        memset(&out_frames[0], 0, sizeof(out_frames[0]));
+        memcpy(out_frames[0].nonce, r->resp.nonce, UFS_RPMB_NONCE_LEN);
+        out_frames[0].addr = r->resp.addr;
+        out_frames[0].block_count = cpu_to_be16(in_frames);
+        out_frames[0].result = cpu_to_be16(result);
+        out_frames[0].req_resp = cpu_to_be16(UFS_RPMB_RESP_AUTH_DATA_READ);
+        if (r->key_set) {
+            ufs_rpmb_calc_hmac(r, &out_frames[0], 1, out_frames[0].key_mac);
+        }
+        for (i = 1; i < in_frames; i++) {
+            out_frames[i] = out_frames[0];
+        }
+        r->resp = out_frames[0];
+        return;
+    }
+
+    ufs_rpmb_ensure_storage(r);
+    for (i = 0; i < in_frames; i++) {
+        memset(&out_frames[i], 0, sizeof(out_frames[i]));
+        memcpy(out_frames[i].nonce, r->resp.nonce, UFS_RPMB_NONCE_LEN);
+        out_frames[i].addr = r->resp.addr;
+        out_frames[i].block_count = cpu_to_be16(in_frames);
+        out_frames[i].result = cpu_to_be16(result);
+        out_frames[i].req_resp = cpu_to_be16(UFS_RPMB_RESP_AUTH_DATA_READ);
+        memcpy(out_frames[i].data,
+               r->storage + ((uint32_t)addr + i) * UFS_RPMB_DATA_LEN,
+               UFS_RPMB_DATA_LEN);
+    }
+    ufs_rpmb_calc_hmac(r, out_frames, in_frames,
+                       out_frames[in_frames - 1].key_mac);
+    r->resp = out_frames[in_frames - 1];
+}
+
 static void ufs_rpmb_handle_req(UfsHc *u, UfsRpmbRegion *r,
                                 const UfsRpmbFrame *frames,
                                 uint32_t nframes)
@@ -43,7 +186,27 @@ static void ufs_rpmb_handle_req(UfsHc *u, UfsRpmbRegion *r,
     uint16_t result = UFS_RPMB_RES_GENERAL_FAILURE;
     bool sign_resp = false;
 
+    /*
+     * JESD220H Sections 12.4.7.3.1 & 12.4.7.3.3 state that any request other
+     * than Result read request (0x0005) overwrites the Result Register of the
+     * RPMB region, and Section 12.4.7.3.4 (Figure 12.8) specifies that when an
+     * Authenticated Data Read request (0x0004) is received, the device checks
+     * the address and block count, fetches the data, sets Result, and computes
+     * the MAC for the 0x0400 response (with Stuff bytes [0:195] and Write
+     * counter [500:503] set to 0...00h). Because normal multi-frame reads
+     * defer ufs_rpmb_do_read() until SECURITY PROTOCOL IN supplies the
+     * allocation frame count, if a Result read request (0x0005) arrives while
+     * read_pending is still set (no IN was issued), materialize the 1-frame
+     * 0x0400 response into r->resp and clear read_pending so the following
+     * 1-frame SECURITY PROTOCOL IN returns a complete, signed 0x0400 frame.
+     */
     if (req_type == UFS_RPMB_REQ_READ_RESULT) {
+        if (r->read_pending) {
+            UfsRpmbFrame tmp = { 0 };
+
+            ufs_rpmb_do_read(u, r, 1, &tmp);
+            r->read_pending = false;
+        }
         trace_ufs_rpmb_request(req_type, lduw_be_p(&r->resp.result));
         return;
     }
@@ -85,6 +248,23 @@ static void ufs_rpmb_handle_req(UfsHc *u, UfsRpmbRegion *r,
         sign_resp = true;
         break;
 
+    case UFS_RPMB_REQ_AUTH_DATA_WRITE:
+        r->resp.addr = req->addr;
+        r->resp.req_resp = cpu_to_be16(UFS_RPMB_RESP_AUTH_DATA_WRITE);
+        result = ufs_rpmb_do_write(u, r, frames, nframes);
+        r->resp.write_counter = cpu_to_be32(r->write_counter);
+        sign_resp = r->key_set;
+        break;
+
+    case UFS_RPMB_REQ_AUTH_DATA_READ:
+        r->read_pending = true;
+        memcpy(r->resp.nonce, req->nonce, UFS_RPMB_NONCE_LEN);
+        r->resp.addr = req->addr;
+        r->resp.block_count = req->block_count;
+        r->resp.req_resp = cpu_to_be16(UFS_RPMB_RESP_AUTH_DATA_READ);
+        trace_ufs_rpmb_request(req_type, 0);
+        return;
+
     default:
         r->resp.req_resp = cpu_to_be16(req_type);
         result = UFS_RPMB_RES_GENERAL_FAILURE;
@@ -213,6 +393,40 @@ UfsReqResult ufs_rpmb_sec_in(UfsHc *u, UfsRequest *req, uint8_t *scsi_status,
     r = &u->rpmb[region];
     in_frames = alloc_len / UFS_RPMB_FRAME_LEN;
 
+    if (r->read_pending) {
+        g_autofree UfsRpmbFrame *out_frames = NULL;
+        uint16_t req_blk_cnt = lduw_be_p(&r->resp.block_count);
+
+        /*
+         * JESD220H Section 12.4.7.2 (Table 12.17; JESD220F Table 12.22)
+         * specifies an expected data transfer length of 512 * Block Count
+         * for Authenticated Data Read responses. When the request frame
+         * left block_count as 0 (as allowed by the Linux RPMB subsystem
+         * and hw/sd/sd.c), use the transfer frame count from SECURITY
+         * PROTOCOL IN.
+         */
+        if (req_blk_cnt > 0 && in_frames != req_blk_cnt) {
+            scsi_build_sense(sense_buf, SENSE_CODE(INVALID_FIELD));
+            *scsi_status = CHECK_CONDITION;
+            return UFS_REQUEST_SUCCESS;
+        }
+        if (!ufs_fit_data_buffer(req, alloc_len)) {
+            return UFS_REQUEST_MISMATCH_DATA_BUF;
+        }
+
+        r->read_pending = false;
+        out_frames = g_new0(UfsRpmbFrame, in_frames);
+        ufs_rpmb_do_read(u, r, in_frames, out_frames);
+
+        if (dma_buf_read(out_frames, alloc_len, &residual, req->sg,
+                         MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
+            return UFS_REQUEST_FAIL;
+        }
+        *transferred_len = alloc_len - residual;
+        *scsi_status = GOOD;
+        return UFS_REQUEST_SUCCESS;
+    }
+
     if (in_frames != 1) {
         scsi_build_sense(sense_buf, SENSE_CODE(INVALID_FIELD));
         *scsi_status = CHECK_CONDITION;
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index bc0f2ce4eb..42fa374fca 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -3382,6 +3382,11 @@ void ufs_unrealize(UfsHc *u)
             u->cq[i] = NULL;
         }
     }
+
+    for (int i = 0; i < UFS_RPMB_MAX_REGIONS; i++) {
+        g_free(u->rpmb[i].storage);
+        u->rpmb[i].storage = NULL;
+    }
 }
 
 static bool ufs_bus_check_address(BusState *qbus, DeviceState *qdev,
-- 
2.56.0.307.g5fe7bd680c-goog


