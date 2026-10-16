Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDE2CCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeDe-0007iM-0Z; Fri, 16 Oct 2026 05:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xHeDc-0007hj-C9
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:27:16 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xHeDa-0004uj-1V
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:27:16 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20261016092711epoutp0247cf1ede1a7187f720515eef6509f19f~e_GjeJpr71366213662epoutp020
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:27:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20261016092711epoutp0247cf1ede1a7187f720515eef6509f19f~e_GjeJpr71366213662epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792142831;
 bh=KHAs9mQ56a6x4fJ6V3V8u5xtPz/AKCTs3XHUdV+JN7M=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=Fm5LgqiG3oox+LWB6yceoZ9akcZgntuEECCtKJXQmgVhjjN4YrdYP+xQ7D534ro+u
 7cxefpwpreHN/Pg0Uvx+QXZ/hYkrMKs0fXbCLfPO2L9/+qWAKDfj3GUp/8pBumzeCj
 mWykWcPfevCD2q6DeAv8YSvQAzvO9bXaUT5fQO9A=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
 20261016092710epcas2p392b81a918fd2ffd47e1ee9cbd9d60bbb~e_Gi5KdXd1657416574epcas2p3i;
 Fri, 16 Oct 2026 09:27:10 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.201]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4j5fjB0Qbnz3hhT4; Fri, 16 Oct
 2026 09:27:10 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH v2 2/6] hw/ufs: Pass SYNCHRONIZE CACHE(16) to scsi-hd as
 SYNCHRONIZE CACHE(10)
From: Daejun Park <daejun7.park@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p8>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261016092709epcms2p63a2477a684b07157efc8cc8daaa2d5cb@epcms2p6>
Date: Fri, 16 Oct 2026 18:27:09 +0900
X-CMS-MailID: 20261016092709epcms2p63a2477a684b07157efc8cc8daaa2d5cb
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306
References: <20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p8>
 <CGME20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p6>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=daejun7.park@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: daejun7.park@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

scsi-hd implements SYNCHRONIZE CACHE(10) only and fails the 16-byte
variant with INVALID COMMAND OPERATION CODE. Linux sends SYNCHRONIZE
CACHE(16) to zoned disks (sd_zbc sets use_16_for_sync), so once a
logical unit can be zoned, every flush from such a guest fails. With
the zoned logical units that a later commit adds and without this
change, a Linux 7.3-rc7 guest logged

  sd 2:0:0:1: [sdb] tag#9 Add. Sense: Invalid command operation code
  critical target error, dev sdb, sector 0 op 0x1:(WRITE) flags 0x800

and fsync() on the disk failed with EREMOTEIO.

scsi-hd flushes the whole medium for SYNCHRONIZE CACHE(10) and does not
look at its LBA range. Hand the 16-byte command to scsi-hd as the
10-byte one and keep the IMMED bit. This keeps the UFS change inside
hw/ufs; if scsi-disk learns SYNCHRONIZE CACHE(16), the translation can
go.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 hw/ufs/lu.c            | 17 +++++++++++++++--
 tests/qtest/ufs-test.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 1853284acf..b812e1bef8 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -382,6 +382,8 @@ static UfsReqResult ufs_emulate_scsi_cmd(UfsLu *lu, UfsRequest *req)
 static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
 {
     uint8_t task_tag = req->req_upiu.header.task_tag;
+    uint8_t *cdb = req->req_upiu.sc.cdb;
+    uint8_t sync_cache_10[UFS_CDB_SIZE] = { SYNCHRONIZE_CACHE };
     SCSIRequest *scsi_req;
     uint32_t len;
 
@@ -395,8 +397,19 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
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
index 63f805419e..594b91706b 100644
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

