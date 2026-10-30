Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F65D606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w3PE5XgN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMhly-0006UV-IM; Fri, 30 Oct 2026 04:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlV-0006Hj-EU
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:09 -0400
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlT-0001OC-8C
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:08 -0400
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-1a2af4c8d00so833437c88.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793348106; x=1793952906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wb0nK65gnGUWWtL+z/a/RxvOUUh5TBKwqMiX4tDJvI8=;
 b=w3PE5XgN8ay08mIk2fCmaLbrkRq3xCvLwU8YDjtDaC6z5f6JBr8KVfWnmnhd/hmNBR
 LawKnYKN87J04KdDxWBrrdMJdPMiMavT1V/4M4Zabc6OGMO95voCBmapf5MqIpC+95Eu
 G8U/iHn/asyfFTst7NT3pNfwcTLoTIJxAXJqPEsAl7OT4mcYFX2AmLZitAoG4wRrvvyX
 e5dJ/+KDFbdrWFIktpa0PkHDsCy7AEO0uZ3GxCxXbP9gtYK5iC5DoDRb2M92RS2l44sD
 Z3WDFLlHTWcTlU57QdpHPRrtTxMs0HMdkCh/G1+aYzsQzSR0lF3/Tn52JmWQh/MGEfLa
 0X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793348106; x=1793952906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wb0nK65gnGUWWtL+z/a/RxvOUUh5TBKwqMiX4tDJvI8=;
 b=fwkkvM2FefP/ALTutUDvdJZol9Bzo+tAfTGRox9z0u+M/WINY+GzgcDKr+qq9p64hy
 RpTTJEO2f14zYZA1qr0n23hZjTMJWsOu5v6WBxB6LxuvmgstWK0RDuaHd6eSv/acgSOu
 TUhQx9EsoViRfO+aQmqMlA1Qv+cWAssMD+SamPoxBGCu2Js1KhhAKGHmTHvV4Nf/u1TZ
 oziNV1iLEsNg22QUSeS8tOtUJTGDtLHoT/qxScH92vutmHXGqy3zd6ZpOzhWAINHwREH
 MAmksRIFwkHmGZ2kGfVju3AOUc8QEra1+KSOv/a0BjPDz8gSDjq+d8T5kv6ikA6LxrEN
 31WQ==
X-Gm-Message-State: AFq9FYIMZyEdL/13RH/rPBxb4RPuoJ2cfLyBt84S4OewA4Y9Ge1oCqeW
 PiMbuIqwU2+r/en85J8d1lif6fF0lrqPbZTGedeQcSkmkgb1nuAlA3lmBXXhqQ==
X-Gm-Gg: AYBFou2HsHITDiVjR2m6BSMFL4W1GfEplNw+vX207I/4ecdUaI+deFg5BDP+Honp5tP
 I24tdeweNDVWRRfxpIGN0CPOzcHo6o4trq0q7GP4oDIAMBi9oFmTvM6w4R53+VdHXk1R1csLhgG
 MiPzitt0OLCAGu0EpuqJ4TFrRHs1DJRHGA9vuXoAVdth4/TI39jUWbswBhOSGJyaB4YPVSQh+y2
 LeM0hgb9+cxeyyq47Z4GMt9+MpT6+qPdV4Nw8PqUPokJzRaPEWW4r2vh/IvhhdKD6R2nnAImu/J
 seatpos6Rh6GdFvPt+FtdFWofKP/rYkSPmkO1ceCr+8JrYvG3hh06DnxHZmKZXcFJ/LYllGbVOq
 sFuY1lVosPFb4Urug0EBSn4MZYZdeG5pwxyBUvlzPHXU2Yhc2jxLwAhn3/oaoJa4TkUKtGB6Ovs
 UeauVFeBRaQ0n25synNxofG9c12Osd3aIkwP4jnmURisVBybpuidVXmbFE1ym3RJ3fJTdkAV0ZR
 VvFwOOji0RLgfwL9ZGiyZuD0aOm77qaxxFX+s7uYl47CmWTmRIxmzlrkuyAzxb4NNFZNkp+Fgas
 3yJhJ8BknhFjggum9659pcB1glSuToI3QiMoRWKxmxe0xz/D1JZ9aY4ldEhWFKZHag==
X-Received: by 2002:a05:701b:428a:20b0:17b:fed6:7449 with SMTP id
 a92af1059eb24-1ac5da7725fmr2385733c88.47.1793348105465; 
 Fri, 30 Oct 2026 01:15:05 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm5905766c88.11.2026.10.30.01.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 01:15:05 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, fam@euphon.net, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, daejun7.park@samsung.com,
 stanleyjhu@google.com, dridiha98@gmail.com, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com
Subject: [PULL 03/12] hw/ufs: Pass SYNCHRONIZE CACHE(16) to scsi-hd as
 SYNCHRONIZE CACHE(10)
Date: Fri, 30 Oct 2026 17:14:29 +0900
Message-ID: <ad2f77a00b4ab8ef98863048a842a459c031dce8.1793347487.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793347487.git.jeuk20.kim@samsung.com>
References: <cover.1793347487.git.jeuk20.kim@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-dl1-x122b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daejun Park <daejun7.park@samsung.com>

scsi-hd implements SYNCHRONIZE CACHE(10) only and fails the 16-byte
variant with INVALID COMMAND OPERATION CODE. Linux sends SYNCHRONIZE
CACHE(16) to zoned disks (sd_zbc sets use_16_for_sync), so once a
logical unit can be zoned, every flush from such a guest fails. With
the zoned logical units and without this change, a Linux 7.3-rc7
guest logged

  sd 2:0:0:1: [sdb] tag#9 Add. Sense: Invalid command operation code
  critical target error, dev sdb, sector 0 op 0x1:(WRITE) flags 0x800

and fsync() on the disk failed with EREMOTEIO.

scsi-hd flushes the whole medium for SYNCHRONIZE CACHE(10) and does not
look at its LBA range. Hand the 16-byte command to scsi-hd as the
10-byte one and keep the IMMED bit. This keeps the UFS change inside
hw/ufs; if scsi-disk learns SYNCHRONIZE CACHE(16), the translation can
go.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/lu.c            | 17 ++++++++++++++--
 tests/qtest/ufs-test.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 1101e368734..a7b6d778f9b 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -406,6 +406,8 @@ static UfsReqResult ufs_emulate_scsi_cmd(UfsLu *lu, UfsRequest *req)
 static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
 {
     uint8_t task_tag = req->req_upiu.header.task_tag;
+    uint8_t *cdb = req->req_upiu.sc.cdb;
+    uint8_t sync_cache_10[UFS_CDB_SIZE] = { SYNCHRONIZE_CACHE };
     SCSIRequest *scsi_req;
     uint32_t len;
 
@@ -419,8 +421,19 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
         return ufs_emulate_scsi_cmd(lu, req);
     }
 
-    scsi_req = scsi_req_new(lu->scsi_dev, task_tag, lu->lun,
-                            req->req_upiu.sc.cdb, UFS_CDB_SIZE, req);
+    /*
+     * scsi-hd implements SYNCHRONIZE CACHE(10) only, while Linux sends the
+     * 16-byte variant to zoned disks. scsi-hd flushes the whole medium for
+     * SYNCHRONIZE CACHE(10) whatever its LBA range, so pass the 16-byte
+     * command on as the 10-byte one, keeping IMMED.
+     */
+    if (cdb[0] == SYNCHRONIZE_CACHE_16) {
+        sync_cache_10[1] = cdb[1] & 0x02;
+        cdb = sync_cache_10;
+    }
+
+    scsi_req = scsi_req_new(lu->scsi_dev, task_tag, lu->lun, cdb, UFS_CDB_SIZE,
+                            req);
 
     /*
      * A command that moves data needs a PRDT. Without one there is no SG
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index ea7b9aa62a7..3c9e9e4032c 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -814,6 +814,51 @@ static void ufstest_no_prdt(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_sync_cache(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint8_t buf[4096];
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
+        REQUEST_SENSE,
+    };
+    const uint8_t sync_cache_10_cdb[UFS_CDB_SIZE] = {
+        SYNCHRONIZE_CACHE,
+    };
+    const uint8_t sync_cache_16_cdb[UFS_CDB_SIZE] = {
+        SYNCHRONIZE_CACHE_16,
+    };
+    const uint8_t sync_cache_16_immed_cdb[UFS_CDB_SIZE] = {
+        SYNCHRONIZE_CACHE_16, 0x02 /* IMMED */
+    };
+    enum UtpOcsCodes ocs;
+    UtpUpiuRsp rsp_upiu;
+    const int test_lun = 1;
+
+    ufs_init(ufs, alloc);
+
+    /* Clear Unit Attention */
+    ocs = ufs_send_scsi_command(ufs, test_lun, request_sense_cdb, NULL, 0,
+                                buf, sizeof(buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+
+    ocs = ufs_send_scsi_command(ufs, test_lun, sync_cache_10_cdb, NULL, 0,
+                                NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ocs = ufs_send_scsi_command(ufs, test_lun, sync_cache_16_cdb, NULL, 0,
+                                NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ocs = ufs_send_scsi_command(ufs, test_lun, sync_cache_16_immed_cdb, NULL,
+                                0, NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ufs_exit(ufs, alloc);
+}
+
 static void ufstest_mcq_cq_wraparound(void *obj, void *data,
                                       QGuestAllocator *alloc)
 {
@@ -1766,6 +1811,7 @@ static void ufs_register_nodes(void)
     qos_add_test("legacy-read-write", "ufs", ufstest_read_write, &io_test_opts);
     qos_add_test("mcq-read-write", "ufs", ufstest_read_write, &mcq_test_opts);
     qos_add_test("no-prdt", "ufs", ufstest_no_prdt, &io_test_opts);
+    qos_add_test("sync-cache", "ufs", ufstest_sync_cache, &io_test_opts);
     qos_add_test("mcq-cq-wraparound", "ufs", ufstest_mcq_cq_wraparound,
                  &mcq_test_opts);
     qos_add_test("query-flag", "ufs", ufstest_query_flag_request,
-- 
2.43.0


