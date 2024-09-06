Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D77CE7B00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 10:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWfc-0002xP-UQ; Fri, 06 Sep 2024 06:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1smWfW-0002r5-1k; Fri, 06 Sep 2024 06:58:22 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1smWfP-00063n-Aa; Fri, 06 Sep 2024 06:58:17 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2053525bd90so17837395ad.0; 
 Fri, 06 Sep 2024 03:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725620289; x=1726225089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32vLb3pFC8hJhhQnTePrsA7xvbQT3ggqHWo0df9no6E=;
 b=YvNRL29KvYMJujKPI31Hlo3kZXUQN3W77wwBWvkw7pr7idcd03aJZk21tOfFxMaeFn
 G0Rde2u/EjGwZJaAams9fZME5PUTn5cgBt7SUMQGz5WR5AMBGT0b++fjwufvoqTC1OLf
 24dL2eTYnrBOUw4Vznrqq/n5iDYakSip+AucGN8njjkGa+IC+LXHkoTk0PGnbMLGnDRy
 MEiaKrrP7sk0cAdLAKZ99KbsNgDRtAFu+BIfeThW+FDh0eeqeBp0PaHPtDmAybNONqQu
 hF+byrTXLzjzQCj71oT9JUB25SHiCWuDujU05auZhm0MrMStqaoqVb3GOi/l1pGJnDla
 hagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725620289; x=1726225089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=32vLb3pFC8hJhhQnTePrsA7xvbQT3ggqHWo0df9no6E=;
 b=bsky/INySOrOPDcHM/lvgFukKAc5Ej+Gg2Y50A+38R/9OJzILYfjJfwBBlZfNol8sY
 pMv6mxbsEK+rEw8kJGy2RfbGT8ccVX9YTi8TcIMQVvgTMKGJjL71F3wyfPvg4eFVcLaG
 bmTpqaza0Dy5M8Z33JMgMqIf/Ve0ykcl6VxfYyV9lfTJQWAGdvifKdPsYIXksA0q9XoE
 /D1AZE0Ys9FUHDK5kt/YpRGiU8JaOGFTjj3Nli7Aukoi6vYdWVJP9JHLSMunpFJyhl7i
 KCflxrZNOU8IKs+n7diDxwWrBM31cbho/CkEkOZDGBvGijJOcpNDJCKPcUneIVtgImSu
 0Buw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqHaoU+ue8B0ns7ohnmJtNk7Hk/+UFMONdTX+/0isIuG6RTdjYLZtlPEi4InkzLGfJUS8dk0cn6hKI@nongnu.org
X-Gm-Message-State: AOJu0YxVOGi7RaMiL/SYrOrbaF4l1J3hUq9xM7/r+tvEqgjIWE4zSk7h
 iRxDCXBb2bUGdPk9I4ZW91NiSmlaMVp8btDDQU6cPWGGFBTG2nYiSYN+xQ==
X-Google-Smtp-Source: AGHT+IH+qgvmAElL1ET/qxqddtEdKHBQrazP3qmvfC1UD6Nmm0egPPfxZc5Fw0opHNG3DnhL+bzFDg==
X-Received: by 2002:a17:902:ce8c:b0:206:ca91:1dd6 with SMTP id
 d9443c01a7336-206f049d06fmr22151305ad.9.1725620288597; 
 Fri, 06 Sep 2024 03:58:08 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea67bc6sm41134575ad.258.2024.09.06.03.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 03:58:08 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com,
 jeongyuchan0629@gmail.com, Yoochan Jeong <yc01.jeong@samsung.com>
Subject: [PULL 2/5] hw/ufs: minor bug fixes related to ufs-test
Date: Fri,  6 Sep 2024 19:57:39 +0900
Message-Id: <7c85332a2b3e8d58db209f29afca740d2f0cd6e7.1725619134.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725619134.git.jeuk20.kim@samsung.com>
References: <cover.1725619134.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Yoochan Jeong <yc01.jeong@samsung.com>

Minor bugs and errors related to ufs-test are resolved. Some
permissions and code implementations that are not synchronized
with the ufs spec are edited.

Signed-off-by: Yoochan Jeong <yc01.jeong@samsung.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c           | 19 +++++++++++++------
 include/block/ufs.h    |  6 ++++++
 tests/qtest/ufs-test.c | 11 ++++++++---
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index ce2c96aeea..79f786ed4e 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1111,10 +1111,13 @@ static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
     return 0;
 }
 
-static void ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
+static QueryRespCode ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
 {
     switch (idn) {
     case UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL:
+        if (value > UFS_QUERY_ATTR_ACTIVE_ICC_MAXVALUE) {
+            return UFS_QUERY_RESULT_INVALID_VALUE;
+        }
         u->attributes.active_icc_level = value;
         break;
     case UFS_QUERY_ATTR_IDN_MAX_DATA_IN:
@@ -1142,6 +1145,7 @@ static void ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
         u->attributes.psa_data_size = cpu_to_be32(value);
         break;
     }
+    return UFS_QUERY_RESULT_SUCCESS;
 }
 
 static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
@@ -1158,13 +1162,13 @@ static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
 
     if (op == UFS_QUERY_ATTR_READ) {
         value = ufs_read_attr_value(u, idn);
+        ret = UFS_QUERY_RESULT_SUCCESS;
     } else {
-        value = be32_to_cpu(req->req_upiu.qr.value);
-        ufs_write_attr_value(u, idn, value);
+        value = req->req_upiu.qr.value;
+        ret = ufs_write_attr_value(u, idn, value);
     }
-
     req->rsp_upiu.qr.value = cpu_to_be32(value);
-    return UFS_QUERY_RESULT_SUCCESS;
+    return ret;
 }
 
 static const RpmbUnitDescriptor rpmb_unit_desc = {
@@ -1287,9 +1291,12 @@ static QueryRespCode ufs_read_desc(UfsRequest *req)
     UfsHc *u = req->hc;
     QueryRespCode status;
     uint8_t idn = req->req_upiu.qr.idn;
+    uint8_t selector = req->req_upiu.qr.selector;
     uint16_t length = be16_to_cpu(req->req_upiu.qr.length);
     InterconnectDescriptor desc;
-
+    if (selector != 0) {
+        return UFS_QUERY_RESULT_INVALID_SELECTOR;
+    }
     switch (idn) {
     case UFS_QUERY_DESC_IDN_DEVICE:
         memcpy(&req->rsp_upiu.qr.data, &u->device_desc, sizeof(u->device_desc));
diff --git a/include/block/ufs.h b/include/block/ufs.h
index 92da7a89b9..57f5ea3500 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -763,6 +763,12 @@ typedef struct QEMU_PACKED UtpTaskReqDesc {
  */
 #define UFS_WB_EXCEED_LIFETIME 0x0B
 
+/*
+ * The range of valid value of Active ICC attritbute
+ * is from 0x00 to 0x0F.
+ */
+#define UFS_QUERY_ATTR_ACTIVE_ICC_MAXVALUE 0x0F
+
 /*
  * In UFS Spec, the Extra Header Segment (EHS) starts from byte 32 in UPIU
  * request/response packet
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 82ec3f0671..9cc9e578ff 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -119,6 +119,7 @@ static void ufs_send_nop_out(QUfs *ufs, uint8_t slot,
 
 static void ufs_send_query(QUfs *ufs, uint8_t slot, uint8_t query_function,
                            uint8_t query_opcode, uint8_t idn, uint8_t index,
+                           uint8_t selector, uint32_t attr_value,
                            UtpTransferReqDesc *utrd_out, UtpUpiuRsp *rsp_out)
 {
     /* Build up utp transfer request descriptor */
@@ -136,13 +137,16 @@ static void ufs_send_query(QUfs *ufs, uint8_t slot, uint8_t query_function,
     req_upiu.header.query_func = query_function;
     req_upiu.header.task_tag = slot;
     /*
-     * QEMU UFS does not currently support Write descriptor and Write attribute,
+     * QEMU UFS does not currently support Write descriptor,
      * so the value of data_segment_length is always 0.
      */
     req_upiu.header.data_segment_length = 0;
     req_upiu.qr.opcode = query_opcode;
     req_upiu.qr.idn = idn;
     req_upiu.qr.index = index;
+    req_upiu.qr.selector = selector;
+    req_upiu.qr.value = attr_value;
+    req_upiu.qr.length = UFS_QUERY_DESC_MAX_SIZE;
     qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
                    sizeof(req_upiu));
 
@@ -344,7 +348,7 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
     /* Set fDeviceInit flag via query request */
     ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
                    UFS_UPIU_QUERY_OPCODE_SET_FLAG,
-                   UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, &utrd, &rsp_upiu);
+                   UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, 0, 0, &utrd, &rsp_upiu);
     g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
 
     /* Wait for device to reset */
@@ -353,7 +357,8 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
         qtest_clock_step(ufs->dev.bus->qts, 100);
         ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
                        UFS_UPIU_QUERY_OPCODE_READ_FLAG,
-                       UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, &utrd, &rsp_upiu);
+                       UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, 0, 0, &utrd,
+                       &rsp_upiu);
     } while (be32_to_cpu(rsp_upiu.qr.value) != 0 &&
              g_get_monotonic_time() < end_time);
     g_assert_cmpuint(be32_to_cpu(rsp_upiu.qr.value), ==, 0);
-- 
2.34.1


