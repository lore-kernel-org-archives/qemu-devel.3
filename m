Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48275CD6E79
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV8xs-00077U-LJ; Thu, 04 Jun 2026 10:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wV8xd-00073y-Vy
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 10:22:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wV8xa-0005RM-Ru
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 10:22:17 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654BRQcv994536
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 14:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=w1SrLefpxXw
 /Wm8HE57Tu43sQMGDtkCYW8TVg5vJM/Y=; b=VdNQH+8ZdBCbzYivXuNVs/805eC
 6OFcxDQTKErNCNbDAiNo97XCaHqGqlbEqxK3qwSPZprDpNP6OdmB1prsD+INFXxp
 hsMTcjZZcVw3RCuxwgWf73XWvYmUfHuTGyNRxYa8hmQFey4xAHs+wTiXuqrJDA+e
 tLsJEyH1XfNVOANo3vJ13UQqDIH8UVjK6T7YlueKF7MpDunsLV74P3NbM6O9GeGO
 yGbGQNJhQne2TPE5fyke51fi4ktZaVszUnrrbcjbFMdlvHPLksQFE0A17a8lAQd4
 KLZGGhWPYB9QY7uTyAY2l6sxoUOAhLdXodcqtNZh1v0oECWxwosB/DtERNA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek374t0bx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 14:22:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304df51ff3eso585363eec.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780582932; x=1781187732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1SrLefpxXw/Wm8HE57Tu43sQMGDtkCYW8TVg5vJM/Y=;
 b=chHIg+x5IihSCraV17XkgjqVrAGPvNeA6S6jb5yAxnZaeqpNI0beIljBlPB2ftGIKk
 ePSxJQVCSArv/Ehcz7ZJJhdhqhk0BIpTM21WoPXQqidr7ySQ3Clw6KRs+7pfHD1KBWRr
 VG2D0i2sFCDr3Yn93YmxCl5ebtwj+tGdzAtCMQ6C136ZA1PbW6uJLOMM5qU9P5Yxlb2A
 CYP61Vc8qTDevDZnW0SHVFUHW3QM/lZKSJndOeXJF0kq6PSav6GpSbaei9RYn8c05UDs
 dgS7doBeANZHgOQPxnQY1unXx2cKUHjHC455mQ7ioPWVSwm78gjIx1u4y8FQtyeGQZc7
 NvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780582932; x=1781187732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w1SrLefpxXw/Wm8HE57Tu43sQMGDtkCYW8TVg5vJM/Y=;
 b=lQAZu9jKKIvrtCWjG1riIEI5Er4MNkLwbdhc80kkIo1ug5nyMmzvaU3YVbUJ41KBQt
 M8rzLOe7TnFJWyigNrm6m7McU98aaOKcaipn8sjxusqzAMHFWY/CFq65VgBMRbOoiR2t
 AC3XUWm6ay9P0cYsi3JUHw4EPNTnExpEVumg42uPdpWgXcWrBNLpmh0G0XpGUYH34LsD
 Ff2cc4v5rOWvwaDOx1wnmZRDRvPImUwoTuD4wOFfkvDWqgbK7pKaqU9kCSE6MdH9tpzM
 liaIVPL9c9M2rYXSLuA+uxLVyjapItYyuHsDm2lS/t0RLFODWUcgdKqZZlpVH4WuvVnl
 xHVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WiOmHlNTQhb7o37dsVf1+TznYDz0NOWbLd7HiV/c6Tm1Vq1jdXs/WnKEhIEAEHA6jyM/Cy4JN69FU@nongnu.org
X-Gm-Message-State: AOJu0YygMRoI7mkDmjPqUhVytUuuYTmMUktWp89CmqQo1csbB9UADJZ6
 JwEXR/3pUufOyDyudLoIVUquZadVKz1bg468KlNQvG9mOIchX4FJI2z+Surbi9exxbHZVQtHf8k
 Jc4i7edNvGCRkzXNhcQ0LDaJD1c4f9BE3TIQIu6vJmrk/KKvuGFg1UreazA==
X-Gm-Gg: Acq92OFRZbEbeGoih/pp+ymme1dODxzBDlr1Geh5V5EBMCn9VOYUpWA4erSLkVaigdt
 BA/ff65TFMptOpS7jCumehrlbmn7zVJOABS0g+v2axshOFs5HyaSPFSdNGrORCpvpp9og3Qz1sG
 HIJoaN796sM4hVIusfm9rE+83nMNWxaMMgm3ae6BW/W5SNok02MS3Iml4TVfmD/zK0ThHaDf5K6
 mB5wZgDqt/9L8D+I2bf3qreTInOaUixH9OmoPy67AjcZJznB5D8DTowp35AhAQYmxL+bNlZ7nay
 AZFrGWksjp9vpC4VOFNV3BPzS5OKRbobaCwdaK/bE6YGODFgdtJokCMhH6cz1I3Xc5KfhzCrJrx
 cFknUZLEaY2Rfw8pWhNIuxW2IxKEDf56SYnq7QMfgLBjLXgmi0ycK+OtJBPPlVCr9t3hUFE7fZU
 NMGqh/9HjzHts=
X-Received: by 2002:a05:7300:dc03:b0:2ea:b85c:153d with SMTP id
 5a478bee46e88-3074fbc7c7fmr3839131eec.27.1780582932433; 
 Thu, 04 Jun 2026 07:22:12 -0700 (PDT)
X-Received: by 2002:a05:7300:dc03:b0:2ea:b85c:153d with SMTP id
 5a478bee46e88-3074fbc7c7fmr3839116eec.27.1780582931918; 
 Thu, 04 Jun 2026 07:22:11 -0700 (PDT)
Received: from hu-jithjose-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db528dcsm6179560eec.3.2026.06.04.07.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 07:22:11 -0700 (PDT)
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
To: clg@kaod.org, jamin_lin@aspeedtech.com, komlodi@google.com
Cc: nabihestefan@google.com, philmd@mailo.com, jithu.joseph@oss.qualcomm.com, 
 qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] hw/i3c: rename DW-I3C queue capacity fields from
 _bytes to _words
Date: Thu,  4 Jun 2026 07:22:05 -0700
Message-ID: <20260604142207.2118098-3-jithu.joseph@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604142207.2118098-1-jithu.joseph@oss.qualcomm.com>
References: <20260604142207.2118098-1-jithu.joseph@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE0MCBTYWx0ZWRfXx7wbeTbya/7N
 NbVDHeOpyG+saLGNprYc0wsLVvL0k+/mMLITzpNf8cKmTC9xBDm/F6xJ3G1PCLV8ibQzDCI1Xz4
 lkqIznEFxqDDA+3KelrjZVNmwzidtz3IY1KWIt6e/Zu0x7DQPW+LFOL0itNX6hY/DPOYeDLkIS4
 uhohrjIrKsH2sYtrLngH0pGAlqAhj2tdf8wYo+VPG3vfMta+1149K15ra+HtUDy74jSfp7CGPn5
 ijsqUJGtnfNJK3ww01Cx0ufmJzuyvSTYssu5Hjqt/B6zzziX5AlNoBq6Od4aCdcxGhQga82Gg15
 KHO8QbNDbaC1JwwOViHB1OTizqRtFWdHd9kn7LPco8csVNTrvYMiisDAiUTvj0UvR2LfguX6fXs
 eWq8JIdQWeidkz4hoq13/a6O174NIIivv/CSUYaCRYP70C2O+Gi2SrZH3ocuv0dhNeAVQ3BCd8X
 L/H2ELQGmKLAExMLX4g==
X-Proofpoint-GUID: 8NvkdZu9psh37j7PicUPoTQK9OH2L88Y
X-Proofpoint-ORIG-GUID: 8NvkdZu9psh37j7PicUPoTQK9OH2L88Y
X-Authority-Analysis: v=2.4 cv=eJsjSnp1 c=1 sm=1 tr=0 ts=6a218a15 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=V2NxCb60AAAA:8 a=Au2XYW2znXaePupJvy4A:9 a=scEy_gLbYbu1JhEsrz4S:22
 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040140
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
word count.  The fields and device properties were therefore misnamed:
setting e.g. tx-rx-queue-capacity-bytes=N sized the backing FIFO to N
words, not N bytes.

Rename the three struct fields and matching device-property strings:

  cmd_resp_queue_capacity_bytes  -> cmd_resp_queue_capacity_words
  tx_rx_queue_capacity_bytes     -> tx_rx_queue_capacity_words
  ibi_queue_capacity_bytes       -> ibi_queue_capacity_words

Defaults are unchanged (0x10 / 0x40 / 0x10) -- they were being
interpreted as word counts by fifo32_create() all along, just under a
misleading label.  No behavioral change.

Signed-off-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/i3c/dw-i3c.h |  6 +++---
 hw/i3c/dw-i3c.c         | 32 ++++++++++++++++----------------
 2 files changed, 19 insertions(+), 19 deletions(-)

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
index 06c2d55f5958..0d32d9ce78a0 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -948,9 +948,9 @@ static void dw_i3c_reset(DeviceState *dev)
     ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH,
                      s->cfg.dev_char_table_depth);
     ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,
-                     s->cfg.cmd_resp_queue_capacity_bytes);
+                     s->cfg.cmd_resp_queue_capacity_words);
     ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,
-                     s->cfg.tx_rx_queue_capacity_bytes);
+                     s->cfg.tx_rx_queue_capacity_words);
 
     dw_i3c_cmd_queue_reset(s);
     dw_i3c_resp_queue_reset(s);
@@ -1798,9 +1798,9 @@ static void dw_i3c_reset_enter(Object *obj, ResetType type)
     ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH,
                      s->cfg.dev_char_table_depth);
     ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,
-                     s->cfg.cmd_resp_queue_capacity_bytes);
+                     s->cfg.cmd_resp_queue_capacity_words);
     ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,
-                     s->cfg.tx_rx_queue_capacity_bytes);
+                     s->cfg.tx_rx_queue_capacity_words);
 }
 
 static void dw_i3c_realize(DeviceState *dev, Error **errp)
@@ -1814,14 +1814,14 @@ static void dw_i3c_realize(DeviceState *dev, Error **errp)
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
@@ -1832,12 +1832,12 @@ static void dw_i3c_realize(DeviceState *dev, Error **errp)
 
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


