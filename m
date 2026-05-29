Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5B6CD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 01:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSmDT-00080k-El; Thu, 28 May 2026 21:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wSmDQ-0007yv-22
 for qemu-devel@nongnu.org; Thu, 28 May 2026 21:40:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wSmDL-0002YY-0Q
 for qemu-devel@nongnu.org; Thu, 28 May 2026 21:40:46 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SKlLeM3126057
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 01:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CihwX+LEtjb
 Ocy3TH865wxQKkAKDEh/GC3QpvkImCL4=; b=Nh+jGGUb1PEZsseKVzY6MvzGyYw
 dztOul9T1WZW09T6HXYACvptTwB188dLYNeCg3W6vYKtVnhnZOu/pXDU5OxuF32r
 YPGJLCTm6s0v6zmSllLcnPP2nrvbFCpLFX9Lhya25F/yZ5qx9yVBUmFRj1W7Hudr
 FHiSdl7tpSqiFx9ZUDfp8aANlwyIpD5o8BBXX5glQjVIincPoY6k+pD2SEfT48uU
 dNl5+DrQQSSSP4elstGSx3Ew229W+XmarbOrQlmhv5YovpM2E3UNQxu/85un9LAo
 vs5/uQU0BVXqGHk4Lv5AxAujBSUsmTLJbtElOOg7Im1yN6HHRnRpuFGgZmQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y2wsbm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 01:40:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304d8e9563eso465382eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 18:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780018838; x=1780623638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CihwX+LEtjbOcy3TH865wxQKkAKDEh/GC3QpvkImCL4=;
 b=JQEy1vCTrPe4yLzA4GSICs879GXifRp7kg4Ht0dy/x3tSfB6QW8/ooFjiYwLV3J8Z4
 PfermBkCblXx5rn0Pntv7LlPJny7spRGVofEEYhiRT+hm95l4ODB6zJhuaLc1lKzkdAj
 dS/c995qHTFP0Kh85q4G5VWmtkFqlLORgEhyhm8OXO/leRJRuOh37PIUHQOz8EBWl+6p
 5QF6hm8tGq+VpWUs5y2mx/vDYro7iGPFP97r4QAxSJfTBoN1WuJWzNBKM9s3D1cKQ0Uc
 VNAREpiUjLsrHQxBD56P/cbet55pZoq7yNbAXuGg87th0sIKZz0jA+RT6/oxKRyaJwhU
 clsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780018838; x=1780623638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CihwX+LEtjbOcy3TH865wxQKkAKDEh/GC3QpvkImCL4=;
 b=Ub2EWRGQLK4PZsigUuFpFCIsigX96rLuq2Np9E6nkvK9YZJpeJeN46oVhPRywRzrhN
 HjKLnCXjUmRri0Uxo98QhcDJKQMSAwxNM5Zoq10A2QS4Ww91czP6Por/Oifqdqb1Kc/y
 Vz3x9OtqF8VHtL3hNYCLE7NJJCK0ZiGKPMaVOr3d7nDaLKsXWVF1TrUqRKay0cDW8xxQ
 podqv5asUU056Ebi4us6b5+IviBmLg82CNJO8cs3BMqHkR+WJpHt2ndWFoMAmEUIyxnx
 HLwMzstUM6WjdaB8092IYapFtzhaOLzOG7Ujj0pU9d1W6T1v0Gxjgd7HjmpqTrks685u
 mK4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/156kat3zmGpH2OaCpyDEmqFMfsPXREdjQNeIJpmrKIzHqxLQ4kbu1e45781NHZAPMaiMTWfkUDvAC@nongnu.org
X-Gm-Message-State: AOJu0Yxb9BkL8JCb2xNXT7ePw+iU38oXIvSlOOAEY9/GtIIdnF8g+0X6
 nu16/XuGKQUl8dZLMjOySxpSMgGxGVfqN9+69Qxb6lJ+Qq25/4fJtTi4TiKIGR27xPN+L4TBoIo
 2KpVYaMHLThY0NF68iYAewn0SaL0qNhKq3O5xAeL36MzMWWuwpOm3GsSNIA==
X-Gm-Gg: Acq92OEW8pRgoraiKGdPan+AT7kFGiHoEIKkCjCojA4fQmi3XUxeRgGGlC6QCxjASb5
 Vkzqk9PV+AAjuU7i0NbRPWN2o5/87xY4P0yrHf2+i1/jz1eUAyzpQoqzcAXAML/skCRBGqizpdl
 mw/Qdl7rxe7ubSVi0Zrm4dbY12fZNpKmLjABL0d7sF3KssqaaXxhP8qy0iNpGh64KFzau+udcoI
 D5Xy62CqP4V9CMsFKkWDIVNBTuRiCUvnK8jsaaOC8zpSsqE1Pc0yvgONOuWShLy5exuQDNTdCpm
 wibmQ10qdjdgdTDU2xE030XnzV81D02JzgRvMtfcNtAPtwlTPKdMp8s9kPxzKiqg6ptSDfPkRPh
 QXqd74Jo7BYsoelkwufoms1ekw8MRAl662XlcouHw3zCl/JdhFYQiyDi4WELeeA9H/RmoN+eY/p
 WO40nE89nbgEs=
X-Received: by 2002:a05:7301:fa0d:b0:2c1:6676:5ebd with SMTP id
 5a478bee46e88-304eb1121f3mr490927eec.10.1780018837925; 
 Thu, 28 May 2026 18:40:37 -0700 (PDT)
X-Received: by 2002:a05:7301:fa0d:b0:2c1:6676:5ebd with SMTP id
 5a478bee46e88-304eb1121f3mr490914eec.10.1780018837431; 
 Thu, 28 May 2026 18:40:37 -0700 (PDT)
Received: from hu-jithjose-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c120csm237263eec.4.2026.05.28.18.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 18:40:36 -0700 (PDT)
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
To: clg@kaod.org, jamin_lin@aspeedtech.com, komlodi@google.com
Cc: nabihestefan@google.com, jithu.joseph@oss.qualcomm.com,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/i3c: rename DW-I3C queue capacity fields from _bytes
 to _words
Date: Thu, 28 May 2026 18:40:34 -0700
Message-ID: <20260529014034.864722-3-jithu.joseph@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
References: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VeXH+lp9 c=1 sm=1 tr=0 ts=6a18ee96 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=kff4k8yNmoXuUS8ddVwA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAxMyBTYWx0ZWRfXyzrXaIcyyWny
 RrkBWtq27uKvbfSIJsAXGptf0IxtEdhW0HD5ZbFJQ/vYf3uVusNCjApOVBptGm0QljkZ09NNZVi
 wxYOxF45JhPnTsbKFYnQJSZ4+gjDKoQOZSHxivyNCLUsSUkXliFfLT8XGN4LkYa35rHEOrznCij
 oX53T4gByfX2OiCp2KDfrAvqxrMJSiqaa1V+zzbOULBSTU+CUzkXuZQ74g09WqSJhiuVJjmAXiI
 KtDyEVJBsSR51jTsKS1egAAHjCYOZgWAilPFLenxpZSyR8Fydm9CqryR4rOqx+8vosm4e/ZP+ZV
 /r4SMXHrCPuo0UA3btsdndQqwwL+3vmBXmVMyJ12lMGb3/DUYZ40r3NhYV6+uUCXfDsnJw8qlO8
 Vf2NLA/luzSMzmbQBMHRtoDVMhGrEA==
X-Proofpoint-GUID: RV5vHrAE27UbdN_r_Ol1iBFlVPVaeMUc
X-Proofpoint-ORIG-GUID: RV5vHrAE27UbdN_r_Ol1iBFlVPVaeMUc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2605290013
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The cmd/resp, tx/rx, and IBI queue capacity values are passed straight
to fifo32_create(), which interprets its capacity argument as a 32-bit
word count.  The fields and device properties were therefore misnamed.

Rename the three struct fields and matching device-property strings:

  cmd_resp_queue_capacity_bytes  -> cmd_resp_queue_capacity_words
  tx_rx_queue_capacity_bytes     -> tx_rx_queue_capacity_words
  ibi_queue_capacity_bytes       -> ibi_queue_capacity_words

Defaults are unchanged (0x10 / 0x40 / 0x10) -- they were being
interpreted correctly by fifo32_create all along, just under a
misleading label.  No behavioral change.

aspeed_i3c.c only sets "device-id" on its child DWI3C objects and
nothing else references these properties in the tree, so no external
callers need updating.  vmstate_dw_i3c migrates only the regs[] array,
not cfg.*, so there are no migration-compat concerns either.

Signed-off-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
---
 include/hw/i3c/dw-i3c.h |  6 +++---
 hw/i3c/dw-i3c.c         | 24 ++++++++++++------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h
index d26f60580f02..391470207c43 100644
--- a/include/hw/i3c/dw-i3c.h
+++ b/include/hw/i3c/dw-i3c.h
@@ -181,9 +181,9 @@ struct DWI3C {
 
     struct {
         uint8_t id;
-        uint8_t cmd_resp_queue_capacity_bytes;
-        uint16_t tx_rx_queue_capacity_bytes;
-        uint8_t ibi_queue_capacity_bytes;
+        uint8_t cmd_resp_queue_capacity_words;
+        uint16_t tx_rx_queue_capacity_words;
+        uint8_t ibi_queue_capacity_words;
         uint8_t num_addressable_devices;
         uint16_t dev_addr_table_pointer;
         uint16_t dev_addr_table_depth;
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index e1bcf083210b..4ea80e8352c6 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -1806,14 +1806,14 @@ static void dw_i3c_realize(DeviceState *dev, Error **errp)
                           DW_I3C_NR_REGS << 2);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
 
-    fifo32_create(&s->cmd_queue, s->cfg.cmd_resp_queue_capacity_bytes);
-    fifo32_create(&s->resp_queue, s->cfg.cmd_resp_queue_capacity_bytes);
-    fifo32_create(&s->tx_queue, s->cfg.tx_rx_queue_capacity_bytes);
-    fifo32_create(&s->rx_queue, s->cfg.tx_rx_queue_capacity_bytes);
-    fifo32_create(&s->ibi_queue, s->cfg.ibi_queue_capacity_bytes);
+    fifo32_create(&s->cmd_queue, s->cfg.cmd_resp_queue_capacity_words);
+    fifo32_create(&s->resp_queue, s->cfg.cmd_resp_queue_capacity_words);
+    fifo32_create(&s->tx_queue, s->cfg.tx_rx_queue_capacity_words);
+    fifo32_create(&s->rx_queue, s->cfg.tx_rx_queue_capacity_words);
+    fifo32_create(&s->ibi_queue, s->cfg.ibi_queue_capacity_words);
     /* Arbitrarily large enough to not be an issue. */
     fifo8_create(&s->ibi_data.ibi_intermediate_queue,
-                 s->cfg.ibi_queue_capacity_bytes * 8);
+                 s->cfg.ibi_queue_capacity_words * 8);
 
     s->bus = i3c_init_bus(DEVICE(s), name);
     I3CBusClass *bc = I3C_BUS_GET_CLASS(s->bus);
@@ -1824,12 +1824,12 @@ static void dw_i3c_realize(DeviceState *dev, Error **errp)
 
 static const Property dw_i3c_properties[] = {
     DEFINE_PROP_UINT8("device-id", DWI3C, cfg.id, 0),
-    DEFINE_PROP_UINT8("command-response-queue-capacity-bytes", DWI3C,
-                      cfg.cmd_resp_queue_capacity_bytes, 0x10),
-    DEFINE_PROP_UINT16("tx-rx-queue-capacity-bytes", DWI3C,
-                      cfg.tx_rx_queue_capacity_bytes, 0x40),
-    DEFINE_PROP_UINT8("ibi-queue-capacity-bytes", DWI3C,
-                      cfg.ibi_queue_capacity_bytes, 0x10),
+    DEFINE_PROP_UINT8("command-response-queue-capacity-words", DWI3C,
+                      cfg.cmd_resp_queue_capacity_words, 0x10),
+    DEFINE_PROP_UINT16("tx-rx-queue-capacity-words", DWI3C,
+                      cfg.tx_rx_queue_capacity_words, 0x40),
+    DEFINE_PROP_UINT8("ibi-queue-capacity-words", DWI3C,
+                      cfg.ibi_queue_capacity_words, 0x10),
     DEFINE_PROP_UINT8("num-addressable-devices", DWI3C,
                       cfg.num_addressable_devices, 8),
     DEFINE_PROP_UINT16("dev-addr-table-pointer", DWI3C,
-- 
2.43.0


