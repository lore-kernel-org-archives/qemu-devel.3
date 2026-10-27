Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46AF606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Y4XOmMFV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaGy-0007wZ-8G; Tue, 27 Oct 2026 02:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3XD7gagoKCrcpqXkibvgerdlldib.Zljnbjr-absbiklkdkr.lod@flex--stanleyjhu.bounces.google.com>)
 id 1xLaGD-0007rZ-W1
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:02:15 -0400
Received: from mail-pf1-x448.google.com ([2607:f8b0:4864:20::448])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3XD7gagoKCrcpqXkibvgerdlldib.Zljnbjr-absbiklkdkr.lod@flex--stanleyjhu.bounces.google.com>)
 id 1xLaG9-00068x-Uu
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:02:12 -0400
Received: by mail-pf1-x448.google.com with SMTP id
 d2e1a72fcca58-89ff475a0deso3127855b3a.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1793080925; x=1793685725; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6vy9oe1+vFMGFNwMvDWhH9l5IpR7kofBbXkWGlg3dU4=;
 b=Y4XOmMFVt+/ioGZ2rzXSEbTsVz81dhHhi3QGOz4bNbEP5o79ippzJlq3KbO+INojfo
 vamObxfu909CFKwY+Tj4jCUtI47TofoO43amtsOzbz8r8Y/Hd3qhn8JUcLMQSINuVAX8
 aqW2bhKKq1GH0LdLngKRX1oLVKlrW025u9PLhh/8u+2wYANR4HTElx1wRqDXr5zoZM2h
 Fbxe6/b/I8LSGhU5dugPcDBFtx1z6E7VFQ/zqqZUWv8Csm6jLKADW0F1Hn8doX4J22uC
 t5rfnI1yzyxf6mObmXB5Ey4PFWGNZ5Y1kTe/uyxJq7NxiEb+c6YFtseQW5ggz5QOtLhR
 1VTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793080925; x=1793685725;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6vy9oe1+vFMGFNwMvDWhH9l5IpR7kofBbXkWGlg3dU4=;
 b=1sLD/Er/+djY9cHsQx8A9VHi/D4rrFmBrqWoIqg0AKq+A5Qjb0DnCC3d3ygAfR43G7
 P8MRU2ryoGcC5RxtTAadq18j4xAoLkWYPPRw11m6g4HLYjMgMgv4cA0WawF0ZabxGoKT
 Bic/71bnIX7CliBySA+xlFxebzQ7vdfw+td54beo+qVDy8ysB6F6CNB4tiFIbz8lXukf
 DPTIbRFsg1eQ/UCbcW0r2N76+Eq8IL/EhzlH/OMmfGkVjy1TrHQ5ORhXVIpnpQDq+cdq
 dunrRt32No1uIbLyHfSTtMLOe5Ww8MJ01QnhRyNq8mnTtrq4nzZ8wUM6HAAqCbewdcqU
 kbRw==
X-Gm-Message-State: AFq9FYIqLlVhv6mx+hrmcUXLQDWPWQOBKpzDkmuEtuWGQ2B4KVoe0SlX
 I2y2juKKJ4V3ZAxiuDPlG2g3k5qe4xXnhzgbsN+rvDTAx3wIo6Gq8VG+T4SRWSuNT7ZjkJGzuLr
 JXMI8kWwCFjBuDkCDcfIMGg==
X-Received: from pfbih21.prod.google.com ([2002:a05:6a00:8c15:b0:8a1:d11:a833])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9512:b0:874:705d:f64e with SMTP id
 d2e1a72fcca58-8a36689d88amr7171435b3a.28.1793080924447; 
 Mon, 26 Oct 2026 23:02:04 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:01:50 +0800
In-Reply-To: <20261027060153.1842910-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027060153.1842910-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027060153.1842910-6-stanleyjhu@google.com>
Subject: [PATCH 5/7] tests/qtest/ufs-test: Add RPMB key programming and write
 counter test
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::448;
 envelope-from=3XD7gagoKCrcpqXkibvgerdlldib.Zljnbjr-absbiklkdkr.lod@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x448.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Add ufstest_rpmb_key_counter() and shared helper ufs_rpmb_program_key()
to test write counter reads before key programming (0x0007), key
programming (0x0000 with zeroed Key/MAC per JESD220H Figure 12.5),
duplicate key programming rejection (0x0005), and authenticated write
counter reads with HMAC-SHA256 verification.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 tests/qtest/ufs-test.c | 105 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 9b43422d4b..9fce5fff82 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -3985,6 +3985,24 @@ static void ufs_rpmb_build_cdb(uint8_t cdb[UFS_CDB_SIZE], uint8_t opcode,
     stl_be_p(&cdb[6], len);
 }
 
+static void ufs_rpmb_compute_hmac(const uint8_t key[UFS_RPMB_KEY_MAC_LEN],
+                                  const UfsRpmbFrame *frames, size_t nframes,
+                                  uint8_t mac[UFS_RPMB_KEY_MAC_LEN])
+{
+    GHmac *hmac = g_hmac_new(G_CHECKSUM_SHA256, key, UFS_RPMB_KEY_MAC_LEN);
+    size_t mac_len = UFS_RPMB_KEY_MAC_LEN;
+    size_t i;
+
+    for (i = 0; i < nframes; i++) {
+        g_hmac_update(hmac,
+                      (const guchar *)&frames[i] + UFS_RPMB_HASH_OFFSET,
+                      UFS_RPMB_HASH_LEN);
+    }
+    g_hmac_get_digest(hmac, mac, &mac_len);
+    g_assert_cmpuint(mac_len, ==, UFS_RPMB_KEY_MAC_LEN);
+    g_hmac_unref(hmac);
+}
+
 static void ufs_rpmb_sec_out_frames(QUfs *ufs, uint8_t region,
                                     const UfsRpmbFrame *frames, size_t nframes,
                                     UtpUpiuRsp *rsp)
@@ -4258,6 +4276,91 @@ static void ufstest_rpmb_descriptor_cdb(void *obj, void *data,
     ufs_exit(ufs, alloc);
 }
 
+static const uint8_t ufs_rpmb_test_key[UFS_RPMB_KEY_MAC_LEN] = {
+    0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+    0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
+    0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
+    0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
+};
+
+static void ufs_rpmb_program_key(QUfs *ufs, uint8_t region,
+                                 const uint8_t *key)
+{
+    UfsRpmbFrame req = { 0 }, resp;
+    UtpUpiuRsp rsp_upiu;
+    uint8_t zero_mac[UFS_RPMB_KEY_MAC_LEN] = { 0 };
+
+    memcpy(req.key_mac, key, UFS_RPMB_KEY_MAC_LEN);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_PROGRAM_KEY);
+    ufs_rpmb_sec_out_frames(ufs, region, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ufs_rpmb_read_result(ufs, region, &resp);
+    g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==, UFS_RPMB_RESP_PROGRAM_KEY);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_OK);
+    g_assert_cmpmem(resp.key_mac, UFS_RPMB_KEY_MAC_LEN,
+                    zero_mac, UFS_RPMB_KEY_MAC_LEN);
+}
+
+static void ufstest_rpmb_key_counter(void *obj, void *data,
+                                     QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    UtpUpiuRsp rsp_upiu;
+    UfsRpmbFrame req, resp;
+    uint8_t mac[UFS_RPMB_KEY_MAC_LEN];
+
+    ufs_init(ufs, alloc);
+
+    /* 1. Read write counter before key is programmed -> 0x0007 (NO_AUTH_KEY) */
+    memset(&req, 0, sizeof(req));
+    memset(req.nonce, 0xa1, sizeof(req.nonce));
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_READ_COUNTER);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ufs_rpmb_sec_in_frames(ufs, 0, &resp, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==, UFS_RPMB_RESP_READ_COUNTER);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_NO_AUTH_KEY);
+    g_assert_cmpmem(resp.nonce, UFS_RPMB_NONCE_LEN,
+                    req.nonce, UFS_RPMB_NONCE_LEN);
+
+    /* 2. Program key -> 0x0000 (OK) with zeroed Key/MAC (JESD220H Fig 12.5) */
+    ufs_rpmb_program_key(ufs, 0, ufs_rpmb_test_key);
+
+    /* 3. Re-program key -> 0x0005 (WRITE_FAILURE) */
+    memset(&req, 0, sizeof(req));
+    memcpy(req.key_mac, ufs_rpmb_test_key, UFS_RPMB_KEY_MAC_LEN);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_PROGRAM_KEY);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==, UFS_RPMB_RESP_PROGRAM_KEY);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_WRITE_FAILURE);
+
+    /* 4. Read write counter -> 0x0000, counter == 0, valid MAC */
+    memset(&req, 0, sizeof(req));
+    memset(req.nonce, 0xb2, sizeof(req.nonce));
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_READ_COUNTER);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ufs_rpmb_sec_in_frames(ufs, 0, &resp, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==, UFS_RPMB_RESP_READ_COUNTER);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_OK);
+    g_assert_cmpuint(ldl_be_p(&resp.write_counter), ==, 0);
+    g_assert_cmpmem(resp.nonce, UFS_RPMB_NONCE_LEN,
+                    req.nonce, UFS_RPMB_NONCE_LEN);
+    ufs_rpmb_compute_hmac(ufs_rpmb_test_key, &resp, 1, mac);
+    g_assert_cmpmem(resp.key_mac, UFS_RPMB_KEY_MAC_LEN,
+                    mac, UFS_RPMB_KEY_MAC_LEN);
+
+    ufs_exit(ufs, alloc);
+}
+
 static void ufs_register_nodes(void)
 {
     const char *arch;
@@ -4353,6 +4456,8 @@ static void ufs_register_nodes(void)
                  &zufs_test_opts);
     qos_add_test("rpmb-descriptor-cdb", "ufs", ufstest_rpmb_descriptor_cdb,
                  &io_test_opts);
+    qos_add_test("rpmb-key-counter", "ufs", ufstest_rpmb_key_counter,
+                 &io_test_opts);
 }
 
 libqos_init(ufs_register_nodes);
-- 
2.56.0.307.g5fe7bd680c-goog


