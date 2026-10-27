Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8033606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=pNIBymJc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaH9-0008G8-NW; Tue, 27 Oct 2026 02:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3WD7gagoKCrMlmTgeXrcanZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--stanleyjhu.bounces.google.com>)
 id 1xLaG7-0007qC-MI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:02:09 -0400
Received: from mail-pg1-x548.google.com ([2607:f8b0:4864:20::548])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3WD7gagoKCrMlmTgeXrcanZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--stanleyjhu.bounces.google.com>)
 id 1xLaG4-00068K-Ux
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:02:07 -0400
Received: by mail-pg1-x548.google.com with SMTP id
 41be03b00d2f7-cd0b795aa8cso420550a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1793080921; x=1793685721; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+N8SJHFjywkKiUNGdjZGN9m+mrASByhvUTgzA59edFs=;
 b=pNIBymJcG2yjWnezhVaouVsJT2asbD2XIjU+AQOnv4hJPudUhdWlsm4oSx2Rwnax9b
 N6I1mdeQ9YWtVzUC2bGwdiNMWeBuYCuIjktTIV4gWMo98KVLinsoX4TdrE3oyYHsLnKs
 /giUf+bI0dxhWHQ+/ij85t7c45IAw/hHzDypCrSUgDCWI/o4QVSN0f8fFq07OF7X0BMi
 z2NFWq9F2XFZq8Y35QPgI71HCvtEIn5nb/mPf2qVTbfdndhPxnsVgU+WJxzzUlan2X5l
 CnzCqFGRt0+ch2UKP6j/KL2XDJZD9nTlr/SFWlXrdXJybxB6caxtvamY2SSeCTrj3Lxf
 6/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793080921; x=1793685721;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+N8SJHFjywkKiUNGdjZGN9m+mrASByhvUTgzA59edFs=;
 b=27HbJ/4NxHsz9yuNjF3xnvQpVhruYiueDRwwpB6/QiuAZ10nlaCrLY/+8WqpFddD99
 0lMwRB2M85inC0ShM/tHDzx9/XMp+pa1WZzzzA5PQc0yB1aFvOD0dElyoCqCRfn+04K1
 qJGbZGkBGF/6r0I9EWFaxS/7majyegUKWvK4SsXHiAS86wBKLB6wte1ASWiean/8hkbz
 yosER3a62SDuM/3gOp97C/YKr8KYS6Uro+Gvt8MHPMxMhTFBkshRkMb8muUlKqxvyOH9
 GJfsSeXml26w2BkZC3L4wsWdquEmNyFnQTC7aidEilGZ1Ng5lQfoE7br9t5Vnir4Tta6
 sSAA==
X-Gm-Message-State: AFq9FYLyGn0BMU3MhG55LI838oypAYMzKuhCU4cfLbdbpYeX2ZODa52x
 BOUovxPN3XXPkoe14g/jP9IIhVG4lV2VAZf/hvgqmsQ2c/mQGoLi1sH7h8OtwLr7ywH3bURQJcm
 1lqFkASdhbekawM5XOWh/5Q==
X-Received: from pfay35.prod.google.com ([2002:a05:6a00:1823:b0:896:c545:14b])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:489:b0:3de:3f4d:f2bd with SMTP id
 adf61e73a8af0-3e8eaa5c3f6mr961661637.6.1793080920628; 
 Mon, 26 Oct 2026 23:02:00 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:01:48 +0800
In-Reply-To: <20261027060153.1842910-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027060153.1842910-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027060153.1842910-4-stanleyjhu@google.com>
Subject: [PATCH 3/7] tests/qtest/ufs-test: Add RPMB descriptor and CDB
 validation test
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
 envelope-from=3WD7gagoKCrMlmTgeXrcanZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--stanleyjhu.bounces.google.com;
 helo=mail-pg1-x548.google.com
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

Add ufstest_rpmb_descriptor_cdb() to verify bSecurityLU in
DeviceDescriptor (JESD220H Table 14.4) and RpmbUnitDescriptor fields
(bLUEnable, bRPMBRegionEnable, bLogicalBlockSize, qLogicalBlockCount,
bRPMBRegion0Size..3Size, and qPhyMemResourceCount per JESD220H Table
14.15), initial zeroed Result Register frame reads, ILLEGAL REQUEST /
INVALID FIELD IN CDB sense responses on invalid security protocol,
INC_512=1, unaligned transfer length, and out-of-range region 4,
INVALID_OPCODE rejection of START_STOP on W-LUN 0xc4 and SECURITY
PROTOCOL IN/OUT on W-LUN 0xd0, and UFS_OCS_MISMATCH_DATA_BUF_SIZE on
short or empty PRDT buffers.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 tests/qtest/ufs-test.c | 285 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 285 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index d8f7f502d6..9b43422d4b 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -3975,6 +3975,289 @@ static void *ufs_zufs_test_setup(GString *cmd_line, void *arg)
     return arg;
 }
 
+static void ufs_rpmb_build_cdb(uint8_t cdb[UFS_CDB_SIZE], uint8_t opcode,
+                               uint8_t protocol, uint16_t spsp, uint32_t len)
+{
+    memset(cdb, 0, UFS_CDB_SIZE);
+    cdb[0] = opcode;
+    cdb[1] = protocol;
+    stw_be_p(&cdb[2], spsp);
+    stl_be_p(&cdb[6], len);
+}
+
+static void ufs_rpmb_sec_out_frames(QUfs *ufs, uint8_t region,
+                                    const UfsRpmbFrame *frames, size_t nframes,
+                                    UtpUpiuRsp *rsp)
+{
+    uint8_t cdb[UFS_CDB_SIZE];
+    uint16_t spsp = ((uint16_t)region << 8) | UFS_RPMB_SEC_PROTOCOL_ID;
+    uint32_t len = nframes * sizeof(UfsRpmbFrame);
+    enum UtpOcsCodes ocs;
+
+    ufs_rpmb_build_cdb(cdb, SECURITY_PROTOCOL_OUT, UFS_RPMB_SEC_PROTOCOL,
+                       spsp, len);
+    ocs = ufs_send_scsi_command(ufs, UFS_UPIU_RPMB_WLUN, cdb,
+                                (const uint8_t *)frames, len, NULL, 0, rsp);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+}
+
+static void ufs_rpmb_sec_in_frames(QUfs *ufs, uint8_t region,
+                                   UfsRpmbFrame *frames, size_t nframes,
+                                   UtpUpiuRsp *rsp)
+{
+    uint8_t cdb[UFS_CDB_SIZE];
+    uint16_t spsp = ((uint16_t)region << 8) | UFS_RPMB_SEC_PROTOCOL_ID;
+    uint32_t len = nframes * sizeof(UfsRpmbFrame);
+    enum UtpOcsCodes ocs;
+
+    ufs_rpmb_build_cdb(cdb, SECURITY_PROTOCOL_IN, UFS_RPMB_SEC_PROTOCOL,
+                       spsp, len);
+    ocs = ufs_send_scsi_command(ufs, UFS_UPIU_RPMB_WLUN, cdb,
+                                NULL, 0, (uint8_t *)frames, len, rsp);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+}
+
+static void ufs_rpmb_read_result(QUfs *ufs, uint8_t region, UfsRpmbFrame *resp)
+{
+    UfsRpmbFrame req = { 0 };
+    UtpUpiuRsp rsp_upiu;
+
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_READ_RESULT);
+    ufs_rpmb_sec_out_frames(ufs, region, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    memset(resp, 0xff, sizeof(*resp));
+    ufs_rpmb_sec_in_frames(ufs, region, resp, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+}
+
+static enum UtpOcsCodes
+ufs_rpmb_send_short_prdt(QUfs *ufs, const uint8_t cdb[UFS_CDB_SIZE],
+                         uint32_t exp_len, uint32_t prdt_bytes, bool is_write)
+{
+    int cmd_desc_slot = alloc_cmd_desc_slot(ufs);
+    uint64_t req_upiu_addr =
+        ufs->cmd_desc_addr + cmd_desc_slot * UTP_COMMAND_DESCRIPTOR_SIZE;
+    uint64_t prdt_addr = req_upiu_addr + UTP_PRDT_UPIU_OFFSET;
+    UtpUpiuReq req_upiu = { 0 };
+    uint16_t prd_table_length = 0;
+    UtpTransferReqDesc utrd;
+    enum UtpOcsCodes ocs;
+
+    req_upiu.header.trans_type = UFS_UPIU_TRANSACTION_COMMAND;
+    req_upiu.header.flags =
+        is_write ? UFS_UPIU_CMD_FLAGS_WRITE : UFS_UPIU_CMD_FLAGS_READ;
+    req_upiu.header.lun = UFS_UPIU_RPMB_WLUN;
+    req_upiu.header.task_tag = cmd_desc_slot;
+    req_upiu.sc.exp_data_transfer_len = cpu_to_be32(exp_len);
+    memcpy(req_upiu.sc.cdb, cdb, UFS_CDB_SIZE);
+    qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
+                   sizeof(req_upiu));
+
+    if (prdt_bytes > 0) {
+        UfshcdSgEntry entry = {
+            .addr = cpu_to_le64(ufs->data_buffer_addr),
+            .size = cpu_to_le32(prdt_bytes - 1),
+        };
+        qtest_memwrite(ufs->dev.bus->qts, prdt_addr, &entry, sizeof(entry));
+        prd_table_length = 1;
+    }
+
+    utrd = ufs_build_req_utrd(
+        req_upiu_addr,
+        is_write ? UFS_UTP_HOST_TO_DEVICE : UFS_UTP_DEVICE_TO_HOST,
+        prd_table_length);
+    ocs = ufs_send_transfer_request_sync(ufs, UFS_UPIU_RPMB_WLUN, &utrd);
+    release_cmd_desc_slot(ufs, cmd_desc_slot);
+    return ocs;
+}
+
+static void ufstest_rpmb_descriptor_cdb(void *obj, void *data,
+                                        QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    UtpUpiuRsp rsp_upiu;
+    enum UtpOcsCodes ocs;
+    DeviceDescriptor dev_desc;
+    const RpmbUnitDescriptor *rpmb_desc;
+    UfsRpmbFrame req = { 0 }, resp, zero_frame;
+    uint8_t cdb[UFS_CDB_SIZE];
+    int i;
+
+    ufs_init(ufs, alloc);
+
+    /*
+     * 1. Verify Device Descriptor bSecurityLU (JESD220H Table 14.4) and RPMB
+     *    Unit Descriptor fields (JESD220H Table 14.15).
+     */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_DEVICE, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    memcpy(&dev_desc, &rsp_upiu.qr.data[0], sizeof(dev_desc));
+    g_assert_cmpuint(dev_desc.length, ==, sizeof(DeviceDescriptor));
+    g_assert_cmpuint(dev_desc.descriptor_idn, ==, UFS_QUERY_DESC_IDN_DEVICE);
+    g_assert_cmpuint(dev_desc.security_lu, ==, 0x01);
+
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_UNIT, UFS_UPIU_RPMB_WLUN, 0, 0,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    rpmb_desc = (const RpmbUnitDescriptor *)&rsp_upiu.qr.data[0];
+    g_assert_cmpuint(rpmb_desc->length, ==, sizeof(RpmbUnitDescriptor));
+    g_assert_cmpuint(rpmb_desc->descriptor_idn, ==, UFS_QUERY_DESC_IDN_UNIT);
+    g_assert_cmpuint(rpmb_desc->unit_index, ==, UFS_UPIU_RPMB_WLUN);
+    g_assert_cmpuint(rpmb_desc->lu_enable, ==, 0x01);
+    g_assert_cmpuint(rpmb_desc->rpmb_region_enable, ==, 0x0f);
+    g_assert_cmpuint(rpmb_desc->logical_block_size, ==,
+                     UFS_RPMB_LOGICAL_BLOCK_SIZE);
+    g_assert_cmpuint(be64_to_cpu(rpmb_desc->logical_block_count), ==,
+                     UFS_RPMB_MAX_REGIONS * 32 * UFS_RPMB_BLOCKS_PER_UNIT);
+    for (i = 0; i < UFS_RPMB_MAX_REGIONS; i++) {
+        g_assert_cmpuint(rpmb_desc->rpmb_region_size[i], ==, 32);
+    }
+    g_assert_cmpuint(be64_to_cpu(rpmb_desc->phy_mem_resource_count), ==,
+                     UFS_RPMB_MAX_REGIONS * 32 * UFS_RPMB_BLOCKS_PER_UNIT);
+
+    /* 2. Result read before any request returns a zeroed frame */
+    memset(&zero_frame, 0, sizeof(zero_frame));
+    memset(&resp, 0xff, sizeof(resp));
+    ufs_rpmb_sec_in_frames(ufs, 0, &resp, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpmem(&resp, sizeof(resp), &zero_frame, sizeof(zero_frame));
+
+    ufs_rpmb_read_result(ufs, 0, &resp);
+    g_assert_cmpmem(&resp, sizeof(resp), &zero_frame, sizeof(zero_frame));
+
+    /*
+     * 3. Invalid protocol, INC_512=1, and unaligned length CDB sense checks.
+     */
+    ufs_rpmb_build_cdb(cdb, SECURITY_PROTOCOL_OUT, 0xee,
+                       UFS_RPMB_SEC_PROTOCOL_ID, sizeof(req));
+    ocs = ufs_send_scsi_command(ufs, UFS_UPIU_RPMB_WLUN, cdb,
+                                (const uint8_t *)&req, sizeof(req), NULL, 0,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[2] & 0x0f, ==, ILLEGAL_REQUEST);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[12], ==, 0x24);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[13], ==, 0x00);
+
+    ufs_rpmb_build_cdb(cdb, SECURITY_PROTOCOL_OUT, UFS_RPMB_SEC_PROTOCOL,
+                       UFS_RPMB_SEC_PROTOCOL_ID, sizeof(req));
+    cdb[4] = 0x80; /* INC_512 = 1 */
+    ocs = ufs_send_scsi_command(ufs, UFS_UPIU_RPMB_WLUN, cdb,
+                                (const uint8_t *)&req, sizeof(req), NULL, 0,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[2] & 0x0f, ==, ILLEGAL_REQUEST);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[12], ==, 0x24);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[13], ==, 0x00);
+
+    ufs_rpmb_build_cdb(cdb, SECURITY_PROTOCOL_IN, UFS_RPMB_SEC_PROTOCOL,
+                       UFS_RPMB_SEC_PROTOCOL_ID, sizeof(resp));
+    cdb[4] = 0x80; /* INC_512 = 1 */
+    ocs = ufs_send_scsi_command(ufs, UFS_UPIU_RPMB_WLUN, cdb,
+                                NULL, 0, (uint8_t *)&resp, sizeof(resp),
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[2] & 0x0f, ==, ILLEGAL_REQUEST);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[12], ==, 0x24);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[13], ==, 0x00);
+
+    ufs_rpmb_build_cdb(cdb, SECURITY_PROTOCOL_OUT, UFS_RPMB_SEC_PROTOCOL,
+                       UFS_RPMB_SEC_PROTOCOL_ID, 256);
+    ocs = ufs_send_scsi_command(ufs, UFS_UPIU_RPMB_WLUN, cdb,
+                                (const uint8_t *)&req, 256, NULL, 0,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[2] & 0x0f, ==, ILLEGAL_REQUEST);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[12], ==, 0x24);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[13], ==, 0x00);
+
+    /*
+     * 4. START_STOP on RPMB W-LUN (0xc4) and SECURITY PROTOCOL IN/OUT on
+     *    UFS Device W-LUN (0xd0) must fail with INVALID_OPCODE
+     *    (ILLEGAL_REQUEST, ASC 0x20, ASCQ 0x00).
+     */
+    memset(cdb, 0, UFS_CDB_SIZE);
+    cdb[0] = START_STOP;
+    ocs = ufs_send_scsi_command(ufs, UFS_UPIU_RPMB_WLUN, cdb,
+                                NULL, 0, NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[2] & 0x0f, ==, ILLEGAL_REQUEST);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[12], ==, 0x20);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[13], ==, 0x00);
+
+    ufs_rpmb_build_cdb(cdb, SECURITY_PROTOCOL_IN, UFS_RPMB_SEC_PROTOCOL,
+                       UFS_RPMB_SEC_PROTOCOL_ID, sizeof(resp));
+    ocs = ufs_send_scsi_command(ufs, UFS_UPIU_UFS_DEVICE_WLUN, cdb,
+                                NULL, 0, (uint8_t *)&resp, sizeof(resp),
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[2] & 0x0f, ==, ILLEGAL_REQUEST);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[12], ==, 0x20);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[13], ==, 0x00);
+
+    ufs_rpmb_build_cdb(cdb, SECURITY_PROTOCOL_OUT, UFS_RPMB_SEC_PROTOCOL,
+                       UFS_RPMB_SEC_PROTOCOL_ID, sizeof(req));
+    ocs = ufs_send_scsi_command(ufs, UFS_UPIU_UFS_DEVICE_WLUN, cdb,
+                                (const uint8_t *)&req, sizeof(req), NULL, 0,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[2] & 0x0f, ==, ILLEGAL_REQUEST);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[12], ==, 0x20);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[13], ==, 0x00);
+
+    /* 5. Region 4 (out of range 0..3) rejected with INVALID_FIELD */
+    memset(&req, 0, sizeof(req));
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_READ_COUNTER);
+    ufs_rpmb_sec_out_frames(ufs, 4, &req, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[2] & 0x0f, ==, ILLEGAL_REQUEST);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[12], ==, 0x24);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[13], ==, 0x00);
+
+    ufs_rpmb_sec_in_frames(ufs, 4, &resp, 1, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[2] & 0x0f, ==, ILLEGAL_REQUEST);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[12], ==, 0x24);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[13], ==, 0x00);
+
+    /*
+     * 6. Short PRDT (256 bytes and empty 0-entry PRDT) for SECURITY PROTOCOL
+     *    OUT and IN must return UFS_OCS_MISMATCH_DATA_BUF_SIZE before any DMA
+     *    or volatile state mutation.
+     */
+    ufs_rpmb_build_cdb(cdb, SECURITY_PROTOCOL_OUT, UFS_RPMB_SEC_PROTOCOL,
+                       UFS_RPMB_SEC_PROTOCOL_ID, UFS_RPMB_FRAME_LEN);
+    memset(&req, 0, sizeof(req));
+    stw_be_p(&req.req_resp, UFS_RPMB_REQ_READ_COUNTER);
+    qtest_memwrite(ufs->dev.bus->qts, ufs->data_buffer_addr, &req, 256);
+    ocs = ufs_rpmb_send_short_prdt(ufs, cdb, UFS_RPMB_FRAME_LEN, 256, true);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+    ocs = ufs_rpmb_send_short_prdt(ufs, cdb, UFS_RPMB_FRAME_LEN, 0, true);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+
+    ufs_rpmb_build_cdb(cdb, SECURITY_PROTOCOL_IN, UFS_RPMB_SEC_PROTOCOL,
+                       UFS_RPMB_SEC_PROTOCOL_ID, UFS_RPMB_FRAME_LEN);
+    ocs = ufs_rpmb_send_short_prdt(ufs, cdb, UFS_RPMB_FRAME_LEN, 256, false);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+    ocs = ufs_rpmb_send_short_prdt(ufs, cdb, UFS_RPMB_FRAME_LEN, 0, false);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+
+    ufs_exit(ufs, alloc);
+}
+
 static void ufs_register_nodes(void)
 {
     const char *arch;
@@ -4068,6 +4351,8 @@ static void ufs_register_nodes(void)
                  &zufs_test_opts);
     qos_add_test("zufs-more-cmds", "ufs", ufstest_zufs_more_cmds,
                  &zufs_test_opts);
+    qos_add_test("rpmb-descriptor-cdb", "ufs", ufstest_rpmb_descriptor_cdb,
+                 &io_test_opts);
 }
 
 libqos_init(ufs_register_nodes);
-- 
2.56.0.307.g5fe7bd680c-goog


