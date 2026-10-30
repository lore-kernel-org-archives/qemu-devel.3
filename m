Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D5A606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pbIPBgok
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMhli-0006Mj-Qn; Fri, 30 Oct 2026 04:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlT-0006D0-0h
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:07 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlQ-0001NO-8I
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:06 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-14fc585291cso328345c88.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793348103; x=1793952903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lrpLvY4y/DVxVCVbGZK+Hu379grYqQp9XaOoVPBLZtY=;
 b=pbIPBgokcwsgvtW4bIhrc73ODJ9lFCIeBe6W1B9a4Kynb/5dXR5NZy1y+gzwG4+jE0
 j2Y/o4ggjzU7DBpK4klXMLUHNkV1LpTqIqm4hxmLWVX8hFdPG3vKDkeJXWBVlL7oBsBv
 FwXJYalryc3JH47YMmsyUBAZJMbANSt+pNtjPIU0pxI2KPtGke+uU9/oEsklr+XlUs+P
 mbTI3xJ0XLY2FUtzm5+MQTEw/dYJhGBWOxMsM8i1OX9SGenGyL2Dl+vmjW8/syWuIMLi
 9nX9rXdBU9nww+ThnfpPALPNEttLUR/wFUACrBhivd9cYOwFFnV9kDnYbgYPM2urwur3
 FAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793348103; x=1793952903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lrpLvY4y/DVxVCVbGZK+Hu379grYqQp9XaOoVPBLZtY=;
 b=HHI50DkCT0zAAi2AZ/F5dn8vdxoBAbSvsI+LdunzuklIqexKV2y/vIFuEsA3zM3TT3
 nVwmfjQDrzn7cM0DbL8oCW3cwk4XjVl7Eqad48cXdQGbydUoh+nqGM5mbfHix+ZwwyXq
 Rd+VgWjJUVQcyrvma33Ugbq7fOPj0cTP5GxDAOKTVKejZzeIeY5kVfSv1ad59dRecYae
 GQWGsqNqLIpua7Y3fMEYpkfmgpBGZCN+3XphlVM0R5O+Wb3C9QmwFK9U2RHlt+gIgpF7
 HacYGF61GR5+ngr6wcRf0MNMe/2hJvkRhjcxspyZiAL67J9Z1JYG+XP17eDDF/+pYQmk
 /qUQ==
X-Gm-Message-State: AFq9FYK/woyh2u/J8Bq1pzPDc7Lp1qpsaPvryJZAAeQ8gEQNTfq1H0+u
 GrpD5LW3elEt6LBACANADPl5XjVZsL/oyYqCM2byaAQHE55Dn1otnNP7sx6coQ==
X-Gm-Gg: AYBFou3WXCIPOhWgEKb7iDNUM5+oN2nYpYrWMDeZ7pOswiS+uezlS45KkuURRbrn9do
 wrl/EvmPgeoQzuN75Vx+XU1AbSGaoesBUO28iXozvEcNs8KodDEkqEMR56F/xhvd2IYkpUK7F7h
 3RrUsUFBeMH6Ry5TKvh88clSFFSAhSxz2E4/Si9I7kXISPGiB1CawAgyfChsGuOXoIXGnP0PDuS
 b8F5D0e/e1dEPMEa2BlvFm1SzicsAzZpzghNyx/HfLy5IYNuLcHzZfrEfs1GPOGQhsQkx934/9f
 23zkcvXLl86S+a+g8Aes2t8JOheXjmbz01y8IK7Kz02WShZ7manmBcodCNqTAGAhDqc/HiXTjWo
 BwpSQvWuT1pRqitEnzpgaLQ1hF5XWdhFuyNHW/IZxCvkYJNIbhnS6Irl7+o6Czo/61k3RrJx/JW
 nXa/W9OeuoWtAuODfDWFcMrB2vqp+8XYwW3nv6ow5Qzhna6Llkiwn2S98ev3pgN0PpWlYUODIaG
 Y+01Ya/Ju0DeRsUglAO0jGufdc+1xFzVlP82EtObqkJzIj2J9FdeiD05EftpCLExDjCgB+ublZh
 XasxQWIPc6uzhZ+YOuTwLoVIQAhzxe2gA3bf/O51Z6Guw+m2S3L77G5iYL77PKrTkw==
X-Received: by 2002:a05:701b:2051:20b0:151:8280:2c1a with SMTP id
 a92af1059eb24-1ac5e8e1dfemr2146900c88.42.1793348102504; 
 Fri, 30 Oct 2026 01:15:02 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm5905766c88.11.2026.10.30.01.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 01:15:02 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, fam@euphon.net, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, daejun7.park@samsung.com,
 stanleyjhu@google.com, dridiha98@gmail.com, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, qemu-stable@nongnu.org
Subject: [PULL 02/12] hw/ufs: Fail SCSI commands that move data without a PRDT
Date: Fri, 30 Oct 2026 17:14:28 +0900
Message-ID: <4992210c844592663e8f3265cd4ff47c0bf03d6f.1793347487.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793347487.git.jeuk20.kim@samsung.com>
References: <cover.1793347487.git.jeuk20.kim@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-dl1-x1233.google.com
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

A command whose CDB transfers data, sent with a PRDT length of 0,
reaches scsi-hd without an SG list. The SCSI layer then calls the
transfer_data callback of the bus, which ufs_scsi_info does not set, and
QEMU dies with SIGSEGV. A guest triggers this with, for example, an
INQUIRY whose PRDT is empty; the new no-prdt qtest crashed QEMU before
this change.

Check the transfer direction that scsi_req_new() parsed, and fail such a
command with OCS MISMATCH DATA BUFFER SIZE before it reaches scsi-hd:
the PRDT describes less data than the command moves. virtio-scsi
likewise fails a command that has no matching buffer
(VIRTIO_SCSI_S_OVERRUN). A request that only reports a pending unit
attention moves no data and goes through, so that the guest still sees
the unit attention.

Handing scsi-hd an empty SG list instead is not enough: READ and WRITE
then complete synchronously in dma_blk_io() and trip the assertion in
scsi_dma_complete().

Fixes: 2a8b36a4967d ("hw/ufs: Support for UFS logical unit")
Cc: qemu-stable@nongnu.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/lu.c            | 24 ++++++++++++++++++----
 hw/ufs/ufs.c           | 10 ++++++++--
 hw/ufs/ufs.h           |  2 ++
 tests/qtest/ufs-test.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index ee4bb75361c..1101e368734 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -406,6 +406,8 @@ static UfsReqResult ufs_emulate_scsi_cmd(UfsLu *lu, UfsRequest *req)
 static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
 {
     uint8_t task_tag = req->req_upiu.header.task_tag;
+    SCSIRequest *scsi_req;
+    uint32_t len;
 
     /*
      * Each ufs-lu has its own independent virtual SCSI bus. Therefore, we can't
@@ -417,12 +419,26 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
         return ufs_emulate_scsi_cmd(lu, req);
     }
 
-    SCSIRequest *scsi_req =
-        scsi_req_new(lu->scsi_dev, task_tag, lu->lun, req->req_upiu.sc.cdb,
-                     UFS_CDB_SIZE, req);
+    scsi_req = scsi_req_new(lu->scsi_dev, task_tag, lu->lun,
+                            req->req_upiu.sc.cdb, UFS_CDB_SIZE, req);
+
+    /*
+     * A command that moves data needs a PRDT. Without one there is no SG
+     * list, and the SCSI layer would call the transfer_data callback, which
+     * ufs-lu does not set. Fail the request with OCS MISMATCH DATA BUFFER
+     * SIZE, as virtio-scsi fails a buffer that does not match the command.
+     * A request that reports a pending unit attention instead moves no data;
+     * its sense is already set, so let it through and the guest sees the UA.
+     */
+    if (scsi_req->cmd.mode != SCSI_XFER_NONE && !req->sg &&
+        !scsi_req->sense_len) {
+        scsi_req_unref(scsi_req);
+        return UFS_REQUEST_MISMATCH_DATA_BUF;
+    }
+
     req->sreq = scsi_req;
 
-    uint32_t len = scsi_req_enqueue(scsi_req);
+    len = scsi_req_enqueue(scsi_req);
     if (len) {
         scsi_req_continue(scsi_req);
     }
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index f008af7467e..dda615da7ce 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -2451,10 +2451,16 @@ void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
     UfsHc *u = req->hc;
     assert(req->state == UFS_REQUEST_RUNNING);
 
-    if (req_result == UFS_REQUEST_SUCCESS) {
+    switch (req_result) {
+    case UFS_REQUEST_SUCCESS:
         req->utrd.header.dword_2 = cpu_to_le32(UFS_OCS_SUCCESS);
-    } else {
+        break;
+    case UFS_REQUEST_MISMATCH_DATA_BUF:
+        req->utrd.header.dword_2 = cpu_to_le32(UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+        break;
+    default:
         req->utrd.header.dword_2 = cpu_to_le32(UFS_OCS_INVALID_CMD_TABLE_ATTR);
+        break;
     }
 
     req->state = UFS_REQUEST_COMPLETE;
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 265a43faaa6..adf74b6833d 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -47,6 +47,8 @@ typedef enum UfsReqResult {
     UFS_REQUEST_SUCCESS = 0,
     UFS_REQUEST_FAIL = 1,
     UFS_REQUEST_NO_COMPLETE = 2,
+    /* The PRDT describes less data than the command moves */
+    UFS_REQUEST_MISMATCH_DATA_BUF = 3,
 } UfsReqResult;
 
 #define UFS_INVALID_SLOT (-1)
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 9a9c5ca8346..ea7b9aa62a7 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -770,6 +770,50 @@ static void ufstest_read_write(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_no_prdt(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint8_t buf[4096];
+    const uint8_t inquiry_cdb[UFS_CDB_SIZE] = {
+        /* INQUIRY, allocation length 36 */
+        INQUIRY, 0x00, 0x00, 0x00, 0x24
+    };
+    const uint8_t write_cdb[UFS_CDB_SIZE] = {
+        /* WRITE(10) to LBA 0, transfer length 1 */
+        WRITE_10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
+    };
+    enum UtpOcsCodes ocs;
+    UtpUpiuRsp rsp_upiu;
+    const int test_lun = 1;
+
+    ufs_init(ufs, alloc);
+
+    /* A pending unit attention is reported even without a PRDT */
+    ocs = ufs_send_scsi_command(ufs, test_lun, write_cdb, NULL, 0, NULL, 0,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[2] & 0xf, ==, UNIT_ATTENTION);
+
+    /* Commands that move data but come without a PRDT fail */
+    ocs = ufs_send_scsi_command(ufs, test_lun, inquiry_cdb, NULL, 0, NULL, 0,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+
+    ocs = ufs_send_scsi_command(ufs, test_lun, write_cdb, NULL, 0, NULL, 0,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+
+    /* The logical unit keeps working */
+    ocs = ufs_send_scsi_command(ufs, test_lun, inquiry_cdb, NULL, 0, buf, 0x24,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpuint(buf[0] & 0x1f, ==, TYPE_DISK);
+
+    ufs_exit(ufs, alloc);
+}
+
 static void ufstest_mcq_cq_wraparound(void *obj, void *data,
                                       QGuestAllocator *alloc)
 {
@@ -1721,6 +1765,7 @@ static void ufs_register_nodes(void)
     qos_add_test("init", "ufs", ufstest_init, NULL);
     qos_add_test("legacy-read-write", "ufs", ufstest_read_write, &io_test_opts);
     qos_add_test("mcq-read-write", "ufs", ufstest_read_write, &mcq_test_opts);
+    qos_add_test("no-prdt", "ufs", ufstest_no_prdt, &io_test_opts);
     qos_add_test("mcq-cq-wraparound", "ufs", ufstest_mcq_cq_wraparound,
                  &mcq_test_opts);
     qos_add_test("query-flag", "ufs", ufstest_query_flag_request,
-- 
2.43.0


