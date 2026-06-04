Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC48CD6E60
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 00:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUvch-0001rL-1t; Wed, 03 Jun 2026 20:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wUvcf-0001qN-K1
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 20:07:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wUvcb-0006YQ-Qg
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 20:07:45 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653L1b9H1947093
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 00:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jcweNIUM6t+
 6hjcfD8RzLfViWzwnEXy7lBw9Fk6zniI=; b=azVHYlWWTXKH+fNEQVRC+82Gmqs
 DbESNnFZkxRVL538QUBqKSQ6MGA5YPQv97W1VJ1YXW0ag9Vn0qb8AkTv589UO2ZB
 XLXe6IQv4bc9iEj+Oq8C8OxQKdn39llXA1toYuqIKD8ldYd27cindm6+4bsEUNml
 Q0XKvFpyJ2c+4gy4QNt4FX8xMUP3bY3vSx5bZ7foa0Naz18/F+OoIN8BjrhTBv7E
 yLdD9oDUgZXu3pnS9X/g6EdU9bc4FO7u7YpWplKglvzUcVKoXctVV5LT27ScZpn0
 hHya4LW1rvg2pKmPlZZWc+Cszb/5SEJfDfFIU2iluC7OaYP3k5o36jekxPg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejabgn3rv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 00:07:39 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304ec73b015so173351eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 17:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780531659; x=1781136459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jcweNIUM6t+6hjcfD8RzLfViWzwnEXy7lBw9Fk6zniI=;
 b=Nsas7arOxH8CbUVh77yx/5xkTHwgdsxm1VJyyrzYIDVkbX6rB9jtyokFqxrSo4C6Lm
 /NpmbnYCnHU3ex8QR/jgB/v0JDxX61QUTbhUSTWxRGSh4V4llYIDzJE26OFEX8yZHwYc
 k9OWyg+vVIvBkkkO6xpTuMq3y2/yfagfDYpnVmy8PZjUC+NGhHJ2OCBg2do7SYg6BFBn
 jVSpO1Yq+2LsBVd6KR+f0NqY6eBAwhZG1afj2zy0MXE24cJgue1aMMqOHOhLyaCXxk5j
 TqD049kWt0oWBSYTbRCP3N5Ix5sQSamP11mK6zWUzr1Ir2PibjfQSvjdgAyLoIVyxtJc
 8H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780531659; x=1781136459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jcweNIUM6t+6hjcfD8RzLfViWzwnEXy7lBw9Fk6zniI=;
 b=lQsSUyRe1v/9hbv6BZtp994Qoxv6jtKZl15GHzyGYye9407VXOODiXQq3u9U6UGCA7
 BWLSHq8dUcpbIX9CX1PJpamS1O7+LYvomXFWSvKchUFzU3IxabUZp2LAG9JBIE9JddGq
 eH5BAIYTLCb1yNPaQI5Ds1NKxV1CHht3mie9hL9NLgh2EF+5Mf17UW0gELe5vuzkLGws
 pykZmgL50KGSj5lhEJSZk7jveH+G2zUy/vl/D1z+pS2DEZYwx47chglaj4a2gy+VjcRg
 AVg/6uSay46+ttbJVJi+955AE4tqEfTh+HYD3thYS405rr+27teWO6yYJKK7xGwOkhoq
 x3cQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sDGOeEdQwJyin7q+3ts7cCp5YW3jLLYtSqT6ndHHhqgrxleiBcCH125HkK08dSxQpKt5aFN/JDL68@nongnu.org
X-Gm-Message-State: AOJu0YyyvlFjBFCOnm/6X/NZMvjCeGZhwqWlZ+MS3qpdwuCafI6iUTd1
 KvcwCGEc77LSy4/5xunwMIqP6OCFBZR2I/JC+VRegSbfiXl67l+ln8/Of3zr0s7nkfov4rkmYFY
 bFyYofAqZkh8+CLSiBxL+cQbNkZzPEEcUaCbTX4tPBaPLn07QUw8JoepP4w==
X-Gm-Gg: Acq92OHGwZniev7X4GiPfbtM+b3OnyrYzdYms0/g6zVuDKFr7hhaahbjpnw7JHpOd9L
 h2p+liY/SVBaY4CPkNhak0VdoQ/hB4L8O0X9djHYUA9EplAM22pli3PpUgXNyf9mfwT3EYn6p1a
 IeTi7Lhw93DJirMCH4tPuQ3ZypQInDc2MqWn4zL2C7YJXVzdKuFexfx+OwsTbhivUoXYWVkbAZZ
 FxBCjUMgpKkDe3DGsrHSgZuTP7Aj4pSUJxu7I3aAWb/SYrOx3Z2MXXMSe0oGTTMMnT211foLGq4
 w2z81cuw6bDT1LR2tn+NcHzY/VUOtervVdleBMhrDkVcn6pQ9sL0FeIaLHIN85YchZrjlw5RdHM
 UbevqWsLrwT17CuMxNGKCgv2ImNcMI1CYJ3u7REuDFyv3zQkEgLPdmVyHXLXbY5nrZjY/bx48lq
 Uh4L95hJRCAsI=
X-Received: by 2002:a05:7300:3254:b0:304:e6f8:7ccf with SMTP id
 5a478bee46e88-3074fbebfdfmr3027592eec.27.1780531659098; 
 Wed, 03 Jun 2026 17:07:39 -0700 (PDT)
X-Received: by 2002:a05:7300:3254:b0:304:e6f8:7ccf with SMTP id
 5a478bee46e88-3074fbebfdfmr3027571eec.27.1780531658509; 
 Wed, 03 Jun 2026 17:07:38 -0700 (PDT)
Received: from hu-jithjose-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dfa3a2asm5374960eec.31.2026.06.03.17.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 17:07:37 -0700 (PDT)
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
To: clg@kaod.org, jamin_lin@aspeedtech.com, komlodi@google.com
Cc: nabihestefan@google.com, philmd@linaro.org, jithu.joseph@oss.qualcomm.com, 
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] hw/i3c: rename DW-I3C queue capacity fields from
 _bytes to _words
Date: Wed,  3 Jun 2026 17:07:33 -0700
Message-ID: <20260604000734.1094382-3-jithu.joseph@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604000734.1094382-1-jithu.joseph@oss.qualcomm.com>
References: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
 <20260604000734.1094382-1-jithu.joseph@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R6sz39RX c=1 sm=1 tr=0 ts=6a20c1cb cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Au2XYW2znXaePupJvy4A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 3s_8yvqSn4Md_6uhvEvaXvIr89Ex99If
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIzNSBTYWx0ZWRfX4kjrYhQWDvR+
 0LnSgi53r3OlgwlWhjWv3rmnJNyK3cvmEDVW3cZ8mUtNlO+H4qZFNzrfVLoxFVpGHXm/wqurHTQ
 P31PUxeP3wmk8EPXydcEmFhRzisyqsUA16Gl0mM+z4E+B5gWlnC2/akpSxRax23Bvgx6yqbFiR9
 wdIhDk/KDnLTYkdeggvYu9DO2mJ0Dw5IlPWCjtdMsBnhs2HmP7r7PNKi19J9FBQIsxIM+Dhw6g4
 3kBaWZCoTv/8G2ZpDvcMtGR2QL5o+JPAzNGWywLvD945Fhq51BN0qww47o8Y43SHz/ksOwwklfW
 7pzhyBlyQwDc2J2EcVNPSdVyk6KuVpsvnQoqS+ddXX4El83XG6tYpn+rmPio6cNNeX+Iaq/45X5
 D61hs6F02L0B5WQ8BLw4G+ZTwXjnrADrxVJ/gAULChd7pny3LtoJE9aKL6du/KhS9MDLUzDZZPO
 JGL3fh/9olP3T6rPzXQ==
X-Proofpoint-ORIG-GUID: 3s_8yvqSn4Md_6uhvEvaXvIr89Ex99If
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030235
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


