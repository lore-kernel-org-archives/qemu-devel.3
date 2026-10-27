Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDECD606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ip6eMoOA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaHH-0008Rd-67; Tue, 27 Oct 2026 02:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3YD7gagoKCrstubomfzkivhpphmf.dpnrfnv-efwfmopohov.psh@flex--stanleyjhu.bounces.google.com>)
 id 1xLaGH-0007sE-4b
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:02:22 -0400
Received: from mail-pg1-x548.google.com ([2607:f8b0:4864:20::548])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3YD7gagoKCrstubomfzkivhpphmf.dpnrfnv-efwfmopohov.psh@flex--stanleyjhu.bounces.google.com>)
 id 1xLaGD-0006A2-M5
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:02:16 -0400
Received: by mail-pg1-x548.google.com with SMTP id
 41be03b00d2f7-cd652c0385bso2338194a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1793080930; x=1793685730; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Yft30FkmJDDTZVwy0Ny6JZHOmjsTdVtf/Cg87eODgCY=;
 b=ip6eMoOApHT5z2/D/ZILFpBHt3agZ7cyiXqBvZN5LMMBlCK9AtzRBlZVy6Q0I3l8ag
 Uwz6Co1My4/IJIMP3+eg9O0C8QG44oi5LWP2D5pYvs+yjn8xLHYGPnw/udzzwl4qikhn
 0TES3QMV7hxeGhHF1/iLGlJhltoCQAjpKjjU+5epnnIwgwp00y6XJVU7dRfTyj9i5od4
 P9k3FRjkpVBPtlqMGhqUOKS0lja4IjpqVjDvkFmn+tXMS5gPfW6ETiDlRKvN36DkmiYV
 C/93z5xVkGSBAU5ulR7ZZXG60E3hDS53xGlkp4tYZCb6+ZPKhlb93/eDQzxjZ/aA53ew
 gzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793080930; x=1793685730;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yft30FkmJDDTZVwy0Ny6JZHOmjsTdVtf/Cg87eODgCY=;
 b=PuFKF62tHMSq2rjZm2jYNbh6viAaaNE0kfvlp3L7A8scXNetHnT+vJ56rt88SpR+2I
 4Vj27Oo+dSdhuiCJHSeLVGMcm71euOfsc4quLTz438MGywHQt6cVILSrai7mLtvDWWmM
 Hn0iQ7xPb3G1fKHxPsRM5D2AJ84c+rkTUD53GEaEkW4X/+h5ule9u68bOY1ymFFrX84Q
 l2QkQ+OmyIhA/V1C0LzCxu5/ilMc03Uaefsvoj7B8EXTmaIM7eHng/fa7QpAs+coU/Kt
 HwVyA8aHeG5oL5WZ/EaJs6bAxSZ3wpmXVo/5p+qw8QvFA9WBPcpZivPjkjbLSWU9gQVm
 gSVA==
X-Gm-Message-State: AFq9FYKKaXhGpB3i9nDkXAS0k3RqFdxGu3PCCXWIFxd2jE4Htwx5uuk4
 7eNj9d/7C8Z2Ee+ENwQH7EPtTdjCbrErK9g/qPRBB96ZSS8heNLzJD1T6Hr72MEMhKwppFmCN9p
 uIwF/i3Fm6BU5VaU46zxwzw==
X-Received: from pgca14-n1.prod.google.com
 ([2002:a05:6a02:638e:10b0:cd8:b4f6:1c8f])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3c8e:b0:3e2:b295:7678 with SMTP id
 adf61e73a8af0-3e7bfe01e08mr7489422637.50.1793080928680; 
 Mon, 26 Oct 2026 23:02:08 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:01:52 +0800
In-Reply-To: <20261027060153.1842910-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027060153.1842910-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027060153.1842910-8-stanleyjhu@google.com>
Subject: [PATCH 7/7] tests/qtest/ufs-test: Add RPMB authenticated data read
 and write test
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::548;
 envelope-from=3YD7gagoKCrstubomfzkivhpphmf.dpnrfnv-efwfmopohov.psh@flex--stanleyjhu.bounces.google.com;
 helo=mail-pg1-x548.google.com
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

Add ufstest_rpmb_read_write() to test single-frame and multi-frame
(N = 4) authenticated data writes and reads with HMAC-SHA256
verification, Result Read (0x0005) both after a multi-frame read and
while a pending 0x0004 read has had no SECURITY PROTOCOL IN (verifying
zeroed stuff bytes and zero write_counter per JESD220H Figure 12.8),
residual underflow accounting, JESD220H Sections 12.4.7.3.3 and
12.4.7.3.4 check ordering and UFS_RPMB_RES_GENERAL_FAILURE (0x0001)
cases, multi-frame reads past region end, SECURITY PROTOCOL IN block
count mismatch sense reporting, multi-region key and data isolation
across regions 0..3, short-PRDT rejection while read_pending is set,
and HCE 1->0->1 reset clearing volatile state while preserving keys,
write counters, and stored blocks.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 tests/qtest/ufs-test.c | 569 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 569 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 9fce5fff82..c118ee86be 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -4361,6 +4361,573 @@ static void ufstest_rpmb_key_counter(void *obj, void *data,
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_rpmb_read_write(void *obj, void *data,
+                                    QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    UtpUpiuRsp rsp_upiu;
+    enum UtpOcsCodes ocs;
+    UfsRpmbFrame req, resp, zero_frame;
+    UfsRpmbFrame wframes[4], rframes[4];
+    uint8_t mac[UFS_RPMB_KEY_MAC_LEN];
+    uint8_t zero_mac[UFS_RPMB_KEY_MAC_LEN] = { 0 };
+    uint8_t cdb[UFS_CDB_SIZE];
+    const uint8_t *key = ufs_rpmb_test_key;
+    uint8_t region_keys[UFS_RPMB_MAX_REGIONS][UFS_RPMB_KEY_MAC_LEN];
+    int i, j, r;
+
+    ufs_init(ufs, alloc);
+    memset(&zero_frame, 0, sizeof(zero_frame));
+    ufs_rpmb_program_key(ufs, 0, key);
+
+    /* 1. Single-frame authenticated write (block 3, counter 0 -> 1) + read */
+    memset(&req, 0, sizeof(req));
+    for (i = 0; i < UFS_RPMB_DATA_LEN; i++) {
+        req.data[i] = (uint8_t)(0x5a ^ i);
+    }
+    stl_be_p(&req.write_counter, 0);
+    stw_be_p(&req.addr, 3);
+    stw_be_p(&req.block_count, 1);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_WRITE);
+    ufs_rpmb_compute_hmac(key, &req, 1, req.key_mac);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==,
+                     UFS_RPMB_RESP_AUTH_DATA_WRITE);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_OK);
+    g_assert_cmpuint(lduw_be_p(&resp.addr), ==, 3);
+    g_assert_cmpuint(ldl_be_p(&resp.write_counter), ==, 1);
+    ufs_rpmb_compute_hmac(key, &resp, 1, mac);
+    g_assert_cmpmem(resp.key_mac, UFS_RPMB_KEY_MAC_LEN,
+                    mac, UFS_RPMB_KEY_MAC_LEN);
+
+    memset(&req, 0, sizeof(req));
+    memset(req.nonce, 0xc3, sizeof(req.nonce));
+    stw_be_p(&req.addr, 3);
+    stw_be_p(&req.block_count, 1);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_READ);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ufs_rpmb_sec_in_frames(ufs, 0, &resp, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==,
+                     UFS_RPMB_RESP_AUTH_DATA_READ);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_OK);
+    g_assert_cmpuint(lduw_be_p(&resp.addr), ==, 3);
+    g_assert_cmpuint(lduw_be_p(&resp.block_count), ==, 1);
+    g_assert_cmpmem(resp.nonce, UFS_RPMB_NONCE_LEN,
+                    req.nonce, UFS_RPMB_NONCE_LEN);
+    for (i = 0; i < UFS_RPMB_DATA_LEN; i++) {
+        g_assert_cmpuint(resp.data[i], ==, (uint8_t)(0x5a ^ i));
+    }
+    ufs_rpmb_compute_hmac(key, &resp, 1, mac);
+    g_assert_cmpmem(resp.key_mac, UFS_RPMB_KEY_MAC_LEN,
+                    mac, UFS_RPMB_KEY_MAC_LEN);
+
+    /* 2. Multi-frame authenticated write (N = 4, addr 10..13, wc 1 -> 2) */
+    memset(wframes, 0, sizeof(wframes));
+    for (i = 0; i < 4; i++) {
+        for (j = 0; j < UFS_RPMB_DATA_LEN; j++) {
+            wframes[i].data[j] = (uint8_t)((i + 1) * 0x11 + j);
+        }
+        stl_be_p(&wframes[i].write_counter, 1);
+        stw_be_p(&wframes[i].addr, 10);
+        stw_be_p(&wframes[i].block_count, 4);
+        stw_be_p(&wframes[i].req_resp, UFS_RPMB_REQ_AUTH_DATA_WRITE);
+    }
+    ufs_rpmb_compute_hmac(key, wframes, 4, wframes[3].key_mac);
+    ufs_rpmb_sec_out_frames(ufs, 0, wframes, 4, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==,
+                     UFS_RPMB_RESP_AUTH_DATA_WRITE);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_OK);
+    g_assert_cmpuint(lduw_be_p(&resp.addr), ==, 10);
+    g_assert_cmpuint(ldl_be_p(&resp.write_counter), ==, 2);
+    ufs_rpmb_compute_hmac(key, &resp, 1, mac);
+    g_assert_cmpmem(resp.key_mac, UFS_RPMB_KEY_MAC_LEN,
+                    mac, UFS_RPMB_KEY_MAC_LEN);
+
+    /* Multi-frame authenticated read (N = 4, addr 10..13) with MAC check */
+    memset(&req, 0, sizeof(req));
+    memset(req.nonce, 0xd4, sizeof(req.nonce));
+    stw_be_p(&req.addr, 10);
+    stw_be_p(&req.block_count, 4);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_READ);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    memset(rframes, 0, sizeof(rframes));
+    ufs_rpmb_sec_in_frames(ufs, 0, rframes, 4, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    for (i = 0; i < 4; i++) {
+        g_assert_cmpuint(lduw_be_p(&rframes[i].req_resp), ==,
+                         UFS_RPMB_RESP_AUTH_DATA_READ);
+        g_assert_cmpuint(lduw_be_p(&rframes[i].result), ==, UFS_RPMB_RES_OK);
+        g_assert_cmpuint(lduw_be_p(&rframes[i].addr), ==, 10);
+        g_assert_cmpuint(lduw_be_p(&rframes[i].block_count), ==, 4);
+        g_assert_cmpmem(rframes[i].nonce, UFS_RPMB_NONCE_LEN,
+                        req.nonce, UFS_RPMB_NONCE_LEN);
+        g_assert_cmpmem(rframes[i].data, UFS_RPMB_DATA_LEN,
+                        wframes[i].data, UFS_RPMB_DATA_LEN);
+        if (i < 3) {
+            g_assert_cmpmem(rframes[i].key_mac, UFS_RPMB_KEY_MAC_LEN,
+                            zero_mac, UFS_RPMB_KEY_MAC_LEN);
+        }
+    }
+    ufs_rpmb_compute_hmac(key, rframes, 4, mac);
+    g_assert_cmpmem(rframes[3].key_mac, UFS_RPMB_KEY_MAC_LEN,
+                    mac, UFS_RPMB_KEY_MAC_LEN);
+
+    /*
+     * READ_RESULT + 1-frame SECURITY PROTOCOL IN after a multi-frame
+     * AUTH_DATA_READ returns the latched result frame without failing the
+     * multi-frame block count check.
+     */
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpmem(resp.stuff, sizeof(resp.stuff),
+                    zero_frame.stuff, sizeof(resp.stuff));
+    g_assert_cmpuint(ldl_be_p(&resp.write_counter), ==, 0);
+    g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==,
+                     UFS_RPMB_RESP_AUTH_DATA_READ);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_OK);
+    g_assert_cmpuint(lduw_be_p(&resp.addr), ==, 10);
+    g_assert_cmpuint(lduw_be_p(&resp.block_count), ==, 4);
+    g_assert_cmpmem(&resp, sizeof(resp), &rframes[3], sizeof(resp));
+
+    /*
+     * Pending AUTH_DATA_READ (OUT 0x0004) immediately followed by READ_RESULT
+     * (OUT 0x0005) + 1-frame SECURITY PROTOCOL IN (512 bytes, with no prior IN
+     * issued for the read) returns a fully initialized, signed 0x0400 frame
+     * with stuff[0..195] == 0 and write_counter == 0 per JESD220H Figure 12.8.
+     */
+    memset(&req, 0, sizeof(req));
+    memset(req.nonce, 0xd9, sizeof(req.nonce));
+    stw_be_p(&req.addr, 3);
+    stw_be_p(&req.block_count, 1);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_READ);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpmem(resp.stuff, sizeof(resp.stuff),
+                    zero_frame.stuff, sizeof(resp.stuff));
+    g_assert_cmpuint(ldl_be_p(&resp.write_counter), ==, 0);
+    g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==,
+                     UFS_RPMB_RESP_AUTH_DATA_READ);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_OK);
+    g_assert_cmpuint(lduw_be_p(&resp.addr), ==, 3);
+    g_assert_cmpuint(lduw_be_p(&resp.block_count), ==, 1);
+    g_assert_cmpmem(resp.nonce, UFS_RPMB_NONCE_LEN,
+                    req.nonce, UFS_RPMB_NONCE_LEN);
+    for (i = 0; i < UFS_RPMB_DATA_LEN; i++) {
+        g_assert_cmpuint(resp.data[i], ==, (uint8_t)(0x5a ^ i));
+    }
+    ufs_rpmb_compute_hmac(key, &resp, 1, mac);
+    g_assert_cmpmem(resp.key_mac, UFS_RPMB_KEY_MAC_LEN,
+                    mac, UFS_RPMB_KEY_MAC_LEN);
+
+    ufs_rpmb_build_cdb(cdb, SECURITY_PROTOCOL_IN, UFS_RPMB_SEC_PROTOCOL,
+                       UFS_RPMB_SEC_PROTOCOL_ID, sizeof(resp));
+    ocs = ufs_send_scsi_command(ufs, UFS_UPIU_RPMB_WLUN, cdb,
+                                NULL, 0, (uint8_t *)rframes,
+                                2 * sizeof(UfsRpmbFrame), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpuint(rsp_upiu.header.flags & UFS_UPIU_FLAG_UNDERFLOW, ==,
+                     UFS_UPIU_FLAG_UNDERFLOW);
+    g_assert_cmpuint(be32_to_cpu(rsp_upiu.sr.residual_transfer_count), ==,
+                     sizeof(UfsRpmbFrame));
+
+    /*
+     * 3. Write check order per JESD220H Section 12.4.7.3.3: address range
+     *    (0x0004) before block count > max (0x0001), MAC (0x0002), and write
+     *    counter (0x0003), plus N-frame read past region end -> 0x0004 on all
+     *    returned frames without out-of-bounds read.
+     */
+    memset(&req, 0, sizeof(req));
+    stl_be_p(&req.write_counter, 99);
+    stw_be_p(&req.addr, 32 * UFS_RPMB_BLOCKS_PER_UNIT);
+    stw_be_p(&req.block_count, 1);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_WRITE);
+    ufs_rpmb_compute_hmac(key, &req, 1, req.key_mac);
+    req.key_mac[0] ^= 0xff;
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_ADDR_FAILURE);
+    g_assert_cmpuint(ldl_be_p(&resp.write_counter), ==, 2);
+
+    /* Bad address + block_count > bRPMB_ReadWriteSize (64) -> 0x0004 */
+    memset(&req, 0, sizeof(req));
+    stl_be_p(&req.write_counter, 2);
+    stw_be_p(&req.addr, 32 * UFS_RPMB_BLOCKS_PER_UNIT);
+    stw_be_p(&req.block_count, 65);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_WRITE);
+    ufs_rpmb_compute_hmac(key, &req, 1, req.key_mac);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_ADDR_FAILURE);
+    g_assert_cmpuint(ldl_be_p(&resp.write_counter), ==, 2);
+
+    /* Good address + bad MAC (+ bad counter) -> 0x0002 */
+    memset(&req, 0, sizeof(req));
+    stl_be_p(&req.write_counter, 99);
+    stw_be_p(&req.addr, 0);
+    stw_be_p(&req.block_count, 1);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_WRITE);
+    ufs_rpmb_compute_hmac(key, &req, 1, req.key_mac);
+    req.key_mac[0] ^= 0xff;
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_AUTH_FAILURE);
+    g_assert_cmpuint(ldl_be_p(&resp.write_counter), ==, 2);
+
+    /* Good address + good MAC + bad counter -> 0x0003 */
+    ufs_rpmb_compute_hmac(key, &req, 1, req.key_mac);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_COUNT_FAILURE);
+    g_assert_cmpuint(ldl_be_p(&resp.write_counter), ==, 2);
+
+    memset(wframes, 0, sizeof(wframes));
+    for (i = 0; i < 2; i++) {
+        stl_be_p(&wframes[i].write_counter, 2);
+        stw_be_p(&wframes[i].addr, 32 * UFS_RPMB_BLOCKS_PER_UNIT - 1);
+        stw_be_p(&wframes[i].block_count, 2);
+        stw_be_p(&wframes[i].req_resp, UFS_RPMB_REQ_AUTH_DATA_WRITE);
+    }
+    ufs_rpmb_compute_hmac(key, wframes, 2, wframes[1].key_mac);
+    ufs_rpmb_sec_out_frames(ufs, 0, wframes, 2, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_ADDR_FAILURE);
+    g_assert_cmpuint(ldl_be_p(&resp.write_counter), ==, 2);
+
+    /* N-frame read near end of region (block_count=0 in OUT, N=2 in IN) */
+    memset(&req, 0, sizeof(req));
+    memset(req.nonce, 0xe5, sizeof(req.nonce));
+    stw_be_p(&req.addr, 32 * UFS_RPMB_BLOCKS_PER_UNIT - 1);
+    stw_be_p(&req.block_count, 0);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_READ);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    memset(rframes, 0, sizeof(rframes));
+    ufs_rpmb_sec_in_frames(ufs, 0, rframes, 2, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    ufs_rpmb_compute_hmac(key, &rframes[0], 1, mac);
+    for (i = 0; i < 2; i++) {
+        g_assert_cmpuint(lduw_be_p(&rframes[i].req_resp), ==,
+                         UFS_RPMB_RESP_AUTH_DATA_READ);
+        g_assert_cmpuint(lduw_be_p(&rframes[i].result), ==,
+                         UFS_RPMB_RES_ADDR_FAILURE);
+        g_assert_cmpuint(lduw_be_p(&rframes[i].addr), ==,
+                         32 * UFS_RPMB_BLOCKS_PER_UNIT - 1);
+        g_assert_cmpuint(lduw_be_p(&rframes[i].block_count), ==, 2);
+        g_assert_cmpmem(rframes[i].nonce, UFS_RPMB_NONCE_LEN,
+                        req.nonce, UFS_RPMB_NONCE_LEN);
+        g_assert_cmpmem(rframes[i].key_mac, UFS_RPMB_KEY_MAC_LEN,
+                        mac, UFS_RPMB_KEY_MAC_LEN);
+    }
+
+    /* N-frame read near end of region (block_count=4 in OUT, N=4 in IN) */
+    memset(&req, 0, sizeof(req));
+    memset(req.nonce, 0xf6, sizeof(req.nonce));
+    stw_be_p(&req.addr, 32 * UFS_RPMB_BLOCKS_PER_UNIT - 2);
+    stw_be_p(&req.block_count, 4);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_READ);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    memset(rframes, 0, sizeof(rframes));
+    ufs_rpmb_sec_in_frames(ufs, 0, rframes, 4, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    ufs_rpmb_compute_hmac(key, &rframes[0], 1, mac);
+    for (i = 0; i < 4; i++) {
+        g_assert_cmpuint(lduw_be_p(&rframes[i].req_resp), ==,
+                         UFS_RPMB_RESP_AUTH_DATA_READ);
+        g_assert_cmpuint(lduw_be_p(&rframes[i].result), ==,
+                         UFS_RPMB_RES_ADDR_FAILURE);
+        g_assert_cmpuint(lduw_be_p(&rframes[i].addr), ==,
+                         32 * UFS_RPMB_BLOCKS_PER_UNIT - 2);
+        g_assert_cmpuint(lduw_be_p(&rframes[i].block_count), ==, 4);
+        g_assert_cmpmem(rframes[i].nonce, UFS_RPMB_NONCE_LEN,
+                        req.nonce, UFS_RPMB_NONCE_LEN);
+        g_assert_cmpmem(rframes[i].key_mac, UFS_RPMB_KEY_MAC_LEN,
+                        mac, UFS_RPMB_KEY_MAC_LEN);
+    }
+
+    /*
+     * Read check order per JESD220H Section 12.4.7.3.4: bad address +
+     * block_count > bRPMB_ReadWriteSize (64) -> 0x0004 (before 0x0001).
+     */
+    memset(&req, 0, sizeof(req));
+    memset(req.nonce, 0xf7, sizeof(req.nonce));
+    stw_be_p(&req.addr, 32 * UFS_RPMB_BLOCKS_PER_UNIT);
+    stw_be_p(&req.block_count, 65);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_READ);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==,
+                     UFS_RPMB_RESP_AUTH_DATA_READ);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_ADDR_FAILURE);
+
+    /*
+     * UFS_RPMB_RES_GENERAL_FAILURE (0x0001) paths:
+     * (a) 2-frame write with mismatched addr across frames
+     * (b) 1-frame write with block_count != nframes
+     * (c) 0x0004 read with valid addr and block_count > bRPMB_ReadWriteSize
+     * (d) unknown request type 0x0006
+     */
+    memset(wframes, 0, sizeof(wframes));
+    for (i = 0; i < 2; i++) {
+        stl_be_p(&wframes[i].write_counter, 2);
+        stw_be_p(&wframes[i].block_count, 2);
+        stw_be_p(&wframes[i].req_resp, UFS_RPMB_REQ_AUTH_DATA_WRITE);
+    }
+    stw_be_p(&wframes[0].addr, 4);
+    stw_be_p(&wframes[1].addr, 5);
+    ufs_rpmb_compute_hmac(key, wframes, 2, wframes[1].key_mac);
+    ufs_rpmb_sec_out_frames(ufs, 0, wframes, 2, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==,
+                     UFS_RPMB_RESP_AUTH_DATA_WRITE);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==,
+                     UFS_RPMB_RES_GENERAL_FAILURE);
+    g_assert_cmpuint(ldl_be_p(&resp.write_counter), ==, 2);
+
+    memset(&req, 0, sizeof(req));
+    stl_be_p(&req.write_counter, 2);
+    stw_be_p(&req.addr, 4);
+    stw_be_p(&req.block_count, 2);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_WRITE);
+    ufs_rpmb_compute_hmac(key, &req, 1, req.key_mac);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==,
+                     UFS_RPMB_RESP_AUTH_DATA_WRITE);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==,
+                     UFS_RPMB_RES_GENERAL_FAILURE);
+    g_assert_cmpuint(ldl_be_p(&resp.write_counter), ==, 2);
+
+    memset(&req, 0, sizeof(req));
+    memset(req.nonce, 0xf8, sizeof(req.nonce));
+    stw_be_p(&req.addr, 0);
+    stw_be_p(&req.block_count, 65);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_READ);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==,
+                     UFS_RPMB_RESP_AUTH_DATA_READ);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==,
+                     UFS_RPMB_RES_GENERAL_FAILURE);
+
+    memset(&req, 0, sizeof(req));
+    stw_be_p(&req.req_resp, 0x0006);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==, 0x0006);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==,
+                     UFS_RPMB_RES_GENERAL_FAILURE);
+
+    /*
+     * 4. Authenticated data read SECURITY PROTOCOL IN block count mismatch
+     *    sense check.
+     */
+    memset(&req, 0, sizeof(req));
+    stw_be_p(&req.addr, 10);
+    stw_be_p(&req.block_count, 2);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_READ);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ufs_rpmb_sec_in_frames(ufs, 0, &resp, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[2] & 0x0f, ==, ILLEGAL_REQUEST);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[12], ==, 0x24);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[13], ==, 0x00);
+
+    /*
+     * 5. Multi-region (regions 1..3) key programming and cross-region data
+     *    isolation at block 0.
+     */
+    memset(&req, 0, sizeof(req));
+    for (i = 0; i < UFS_RPMB_DATA_LEN; i++) {
+        req.data[i] = (uint8_t)(0xa5 ^ i);
+    }
+    stl_be_p(&req.write_counter, 2);
+    stw_be_p(&req.addr, 0);
+    stw_be_p(&req.block_count, 1);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_WRITE);
+    ufs_rpmb_compute_hmac(key, &req, 1, req.key_mac);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_OK);
+    g_assert_cmpuint(ldl_be_p(&resp.write_counter), ==, 3);
+
+    memcpy(region_keys[0], key, UFS_RPMB_KEY_MAC_LEN);
+    for (r = 1; r < UFS_RPMB_MAX_REGIONS; r++) {
+        for (i = 0; i < UFS_RPMB_KEY_MAC_LEN; i++) {
+            region_keys[r][i] = (uint8_t)(key[i] ^ (r * 0x33));
+        }
+        ufs_rpmb_program_key(ufs, r, region_keys[r]);
+    }
+
+    memset(&req, 0, sizeof(req));
+    for (i = 0; i < UFS_RPMB_DATA_LEN; i++) {
+        req.data[i] = (uint8_t)(0x3c ^ i);
+    }
+    stl_be_p(&req.write_counter, 0);
+    stw_be_p(&req.addr, 0);
+    stw_be_p(&req.block_count, 1);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_WRITE);
+    ufs_rpmb_compute_hmac(region_keys[1], &req, 1, req.key_mac);
+    ufs_rpmb_sec_out_frames(ufs, 1, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ufs_rpmb_read_result(ufs, 1, &resp);
+    g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==,
+                     UFS_RPMB_RESP_AUTH_DATA_WRITE);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_OK);
+    g_assert_cmpuint(ldl_be_p(&resp.write_counter), ==, 1);
+    ufs_rpmb_compute_hmac(region_keys[1], &resp, 1, mac);
+    g_assert_cmpmem(resp.key_mac, UFS_RPMB_KEY_MAC_LEN,
+                    mac, UFS_RPMB_KEY_MAC_LEN);
+
+    for (r = 0; r < UFS_RPMB_MAX_REGIONS; r++) {
+        memset(&req, 0, sizeof(req));
+        memset(req.nonce, (uint8_t)(0x90 + r), sizeof(req.nonce));
+        stw_be_p(&req.addr, 0);
+        stw_be_p(&req.block_count, 1);
+        stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_READ);
+        ufs_rpmb_sec_out_frames(ufs, r, &req, 1, &rsp_upiu);
+        g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+        memset(&resp, 0, sizeof(resp));
+        ufs_rpmb_sec_in_frames(ufs, r, &resp, 1, &rsp_upiu);
+        g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+        g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==,
+                         UFS_RPMB_RESP_AUTH_DATA_READ);
+        g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_OK);
+        for (i = 0; i < UFS_RPMB_DATA_LEN; i++) {
+            uint8_t expected = 0;
+
+            if (r == 0) {
+                expected = (uint8_t)(0xa5 ^ i);
+            } else if (r == 1) {
+                expected = (uint8_t)(0x3c ^ i);
+            }
+            g_assert_cmpuint(resp.data[i], ==, expected);
+        }
+        ufs_rpmb_compute_hmac(region_keys[r], &resp, 1, mac);
+        g_assert_cmpmem(resp.key_mac, UFS_RPMB_KEY_MAC_LEN,
+                        mac, UFS_RPMB_KEY_MAC_LEN);
+    }
+
+    /*
+     * 6. Short-PRDT SECURITY_PROTOCOL_IN (256 bytes) while read_pending is
+     *    set must return UFS_OCS_MISMATCH_DATA_BUF_SIZE without clearing
+     *    read_pending.
+     */
+    memset(&req, 0, sizeof(req));
+    stw_be_p(&req.addr, 0);
+    stw_be_p(&req.block_count, 1);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_READ);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ufs_rpmb_build_cdb(cdb, SECURITY_PROTOCOL_IN, UFS_RPMB_SEC_PROTOCOL,
+                       UFS_RPMB_SEC_PROTOCOL_ID, UFS_RPMB_FRAME_LEN);
+    ocs = ufs_rpmb_send_short_prdt(ufs, cdb, UFS_RPMB_FRAME_LEN, 256, false);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+    /* read_pending stays armed until a valid IN or reset */
+    ufs_rpmb_sec_in_frames(ufs, 0, &resp, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpuint(lduw_be_p(&resp.req_resp), ==,
+                     UFS_RPMB_RESP_AUTH_DATA_READ);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_OK);
+
+    /*
+     * 7. HCE 1->0->1 reset clears volatile read_pending and Result Register
+     *    state while keeping programmed keys, write counters, and stored
+     *    blocks intact.
+     */
+    memset(&req, 0, sizeof(req));
+    stw_be_p(&req.addr, 0);
+    stw_be_p(&req.block_count, 2);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_READ);
+    ufs_rpmb_sec_out_frames(ufs, 0, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    memset(&req, 0, sizeof(req));
+    memset(req.nonce, 0x5a, sizeof(req.nonce));
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_READ_COUNTER);
+    ufs_rpmb_sec_out_frames(ufs, 1, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ufs_wreg(ufs, A_HCE, 0);
+    ufs_exit(ufs, alloc);
+    ufs_init(ufs, alloc);
+
+    /* read_pending was 2 frames on region 0, so 1-frame IN returns zero */
+    memset(&resp, 0xff, sizeof(resp));
+    ufs_rpmb_sec_in_frames(ufs, 0, &resp, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpmem(&resp, sizeof(resp), &zero_frame, sizeof(zero_frame));
+
+    memset(&resp, 0xff, sizeof(resp));
+    ufs_rpmb_sec_in_frames(ufs, 1, &resp, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpmem(&resp, sizeof(resp), &zero_frame, sizeof(zero_frame));
+
+    /* Key, write counter (1), and block 0 data on region 1 still persist */
+    memset(&req, 0, sizeof(req));
+    memset(req.nonce, 0x3c, sizeof(req.nonce));
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_READ_COUNTER);
+    ufs_rpmb_sec_out_frames(ufs, 1, &req, 1, &rsp_upiu);
+    ufs_rpmb_sec_in_frames(ufs, 1, &resp, 1, &rsp_upiu);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_OK);
+    g_assert_cmpuint(ldl_be_p(&resp.write_counter), ==, 1);
+    ufs_rpmb_compute_hmac(region_keys[1], &resp, 1, mac);
+    g_assert_cmpmem(resp.key_mac, UFS_RPMB_KEY_MAC_LEN,
+                    mac, UFS_RPMB_KEY_MAC_LEN);
+
+    memset(&req, 0, sizeof(req));
+    memset(req.nonce, 0x7e, sizeof(req.nonce));
+    stw_be_p(&req.addr, 0);
+    stw_be_p(&req.block_count, 1);
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_AUTH_DATA_READ);
+    ufs_rpmb_sec_out_frames(ufs, 1, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    memset(&resp, 0, sizeof(resp));
+    ufs_rpmb_sec_in_frames(ufs, 1, &resp, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpuint(lduw_be_p(&resp.result), ==, UFS_RPMB_RES_OK);
+    for (i = 0; i < UFS_RPMB_DATA_LEN; i++) {
+        g_assert_cmpuint(resp.data[i], ==, (uint8_t)(0x3c ^ i));
+    }
+    ufs_rpmb_compute_hmac(region_keys[1], &resp, 1, mac);
+    g_assert_cmpmem(resp.key_mac, UFS_RPMB_KEY_MAC_LEN,
+                    mac, UFS_RPMB_KEY_MAC_LEN);
+
+    ufs_exit(ufs, alloc);
+}
+
 static void ufs_register_nodes(void)
 {
     const char *arch;
@@ -4458,6 +5025,8 @@ static void ufs_register_nodes(void)
                  &io_test_opts);
     qos_add_test("rpmb-key-counter", "ufs", ufstest_rpmb_key_counter,
                  &io_test_opts);
+    qos_add_test("rpmb-read-write", "ufs", ufstest_rpmb_read_write,
+                 &io_test_opts);
 }
 
 libqos_init(ufs_register_nodes);
-- 
2.56.0.307.g5fe7bd680c-goog


