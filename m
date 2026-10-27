Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C8F606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MxjchDOz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ib2epcS5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmrP-00058E-Ui; Tue, 27 Oct 2026 15:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmqf-0003Pd-Pa
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:28:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmqb-0002Ow-Vs
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:28:41 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHRl62639301
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hYSbwvuhi2bW/x5mAC8EcmP9hHCJt2X/qMX0ldYPw/o=; b=MxjchDOznba8GSj2
 yHhoSehuWMFUnw9sKNOh1Dv7d46jX6O8Pa8XfdRj0uEKFpOm3/kOXIJNXsYgbF7m
 /kweqLsejz49QikcIGs6bPM0UU8nKifaRYwNSa/3R5vs5swnzC7O9PyAC0ZO1Oe2
 /1x/FdyIlDXTcwL9Rr19pOQgQd7iG8A+wDTGrJd/drZGRe4J2S+mw5O2HbitqC7c
 NwPgvrrBbV6cPx32ixT7mhWrKbH0QUFCthqhrVQpRoecfgJTY3u737HHCaNPKN9z
 Sf0XnAKaLXVz6EB1gaj6FhwhqExgcwbcwHO7WE6BHGuKr+AHuIo8oOR2WQWzDvXG
 M4o2IA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqf5u20w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:36 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c7c7e8becso2549116d6.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129316; x=1793734116; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hYSbwvuhi2bW/x5mAC8EcmP9hHCJt2X/qMX0ldYPw/o=;
 b=ib2epcS5DYjiM7wzbGv9JAi1hbyaeL6SUClUFh1iJDUPFOlBjqewMmNe0gXrJ6Q7xh
 D17pmrR/5fKw/T067LKdODk4qzR946MN7/Py2u0eJwR+t/w3qFGrf2KIcxK+PWIeAY9e
 VqyOESbL8v0w6mVEvk8wz+h5PncOUBArtalAXNC2dEehxbginkMbbnw2YwscK1xo3WI6
 ma0jRh+SrPTNJElFRDEFQqEX82FVu84yxFy2hWLGdeLDJXM07auPCO28qN14MeXRoVtM
 1phzJaN/UgHYi4hhh+HIEazCq0hETq6qa9fzboybPyrVoWxFBL0QxUmiJd9QfM/8ya4k
 NxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129316; x=1793734116;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hYSbwvuhi2bW/x5mAC8EcmP9hHCJt2X/qMX0ldYPw/o=;
 b=sMnohZ8ccmEFmocd1pTi+LVBCUtp30VGb7YEg1qGNxAS6KMdOjuqvbTnNzdzLllAss
 KULxws3GRfL95noOew0q0gWtkcTHsdW9JClcD924hVR4Wnyq747LlIGCrwu0JgSYzca+
 bL0LBgnstLGZm2pycJuuydP14/yt2bCfmMSvqpZBcjyTs9Yw3Yh+UX9yd+ubCit6LHKO
 Gcq8QGuBy4OPlo/BpIKQB4belsoflIz2TU87ngQYiZtkSzTgx2Gv766h8Cep1aXnx2R3
 QMsoFaxbGG7kD/ilH4FQc+HmFJgXpm8172PcoNGFs6bpRx+9LvQrcycOtjlKzlKVy8d/
 M3Cw==
X-Gm-Message-State: AFq9FYL0kZxlEpAmmYJ5ly/44uBXpx2d0VUF74rFIa9zjhGoKtoAbCev
 KHd8Gdvt0qH2Ge3XfVZlguT9y9jWmG2i2TkpxtKtHjZkZb+IgCdeO+ic01SXWwlUolx8eZMYGn9
 e/oQk6Wq9OQqZWUQW+zB5xX1QRfIyuAFVLSX7aN6DLjbFUkGLPFvz133XuMGc1EX6dw==
X-Gm-Gg: AYBFou2KCt/gRUSkWqIDS6FnGSoMY3PROkx6eZbSpfEhU09O0vgvny4LJXrwsYLSuGm
 3uKcyG+t1i1hDkvUj5oS9rWkKfzFcdNYgx3xADKhIrRW9cA494H244o3eJ3FI19mOR73NSwg8DG
 /eyAL6b1xfBFSDTi8NmUwMQBxEje/eNacAtdAiHSAMedwOmgUY/b1d/mjPyH8WBawEjeiqweJXJ
 kNcje8FQCC3lPO0VqHLXyABcOfAL9OXq0p3ieHpqaWLk2QUFm4sCsWernOiWir3MXnlTK6IRpQn
 5E2r4ZNfN97gFnyCCgr24TSu8IN3P2tpv4vu4E7x/kQduGEEseuVQpEcF2D+UGaRK1tiHyHMODJ
 8Bu8zNQsFUsrqMzHBGerhYUWUXiOXHEhlKCyoh/knvt/5GJJj9h+DcYyT
X-Received: by 2002:a05:620a:1712:b0:93c:80d8:57ec with SMTP id
 af79cd13be357-940ef927616mr1702470785a.64.1793129316277; 
 Tue, 27 Oct 2026 12:28:36 -0700 (PDT)
X-Received: by 2002:a05:620a:1712:b0:93c:80d8:57ec with SMTP id
 af79cd13be357-940ef927616mr1702465985a.64.1793129315581; 
 Tue, 27 Oct 2026 12:28:35 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94f5311bdsm2985205e9.5.2026.10.27.12.28.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:28:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 43/59] hw/net/imx_fec: Trace with QOM path where easily possible
Date: Tue, 27 Oct 2026 20:23:24 +0100
Message-ID: <20261027192341.9197-44-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXyWCPjaoAAvCx
 OhLhM28puRjfmBR3bBBOAsshj1lVQbz/xy0Nr2p2e910pkQmxwQ4IeENE7tK7WxWwXou8Tioime
 2F7SVpJO+UssdvCtvCLCaiz+pwBGIx8=
X-Proofpoint-ORIG-GUID: K_3MbQLDEBpbCqn8J3AXBf3I9uKClzhb
X-Proofpoint-GUID: K_3MbQLDEBpbCqn8J3AXBf3I9uKClzhb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXzz1HoDKdEoCV
 EYPvjxZg3IsfKq939gXHPU88fL8xHKr2A5Vyz+fN1jszN/6ZkEpIC6y42Vl1pJE4+wxM6jash+V
 dsCSxUegj9SYLLJYcnBx/c0yKCjIP/Tq4jEP+Dy5K7JqRIHBtxrrxwy1Nl7efg0bQdXdoXoQKBH
 daqFqqMKrw/cMugWqgwWf2uaIApQM9J2EDIgDKDzOL8w6ZNbos9mGmxuaVWKCs587sRjnFAPRSQ
 FEvw07Wsb0wwb+/9ztK8tglvxfO2cPqucvwN+svz2TRoDCL0YTdiABJOelUIo6WQVmY62NnHol2
 O2k30bRQlvfSkqC3UnyoXLNDErOzy5mP7zWp1FzBB/NqgIQ0uOctEEDArNijTKGy7rfofmq71l5
 MayEefThFiZUeaQNYErUpLXbHnCrPcRLy0OOC/CBU9JZHJ2v1NCh6KMXbjBoPXgAvwTOz1U6JtL
 6Q5abEXA2MK1T6UOKcw==
X-Authority-Analysis: v=2.4 cv=UOFIjyfy c=1 sm=1 tr=0 ts=6ae0fb64 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=DJJ0lQ6uop2uk4lV2pUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bernhard Beschow <shentey@gmail.com>

Some i.MX SoCs have multiple i.MX network IP blocks. Allow to
distinguish them via their QOM path when tracing.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921214710.29422-41-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/net/imx_fec.c    | 28 +++++++++++++++-------------
 hw/net/trace-events | 24 ++++++++++++------------
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index c177b7ff2b7b..fb8bcd52d203 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -248,7 +248,7 @@ static uint32_t imx_phy_read(IMXFECState *s, int reg)
         if (s->phy_consumer && phy == s->phy_consumer->phy_num) {
             s = s->phy_consumer;
         } else {
-            trace_imx_phy_read_num(phy, s->phy_num);
+            trace_imx_phy_read_num(DEVICE(s)->canonical_path, phy, s->phy_num);
             return 0xffff;
         }
     }
@@ -270,7 +270,7 @@ static void imx_phy_write(IMXFECState *s, int reg, uint32_t val)
         if (s->phy_consumer && phy == s->phy_consumer->phy_num) {
             s = s->phy_consumer;
         } else {
-            trace_imx_phy_write_num(phy, s->phy_num);
+            trace_imx_phy_write_num(DEVICE(s)->canonical_path, phy, s->phy_num);
             return;
         }
     }
@@ -364,7 +364,7 @@ static void imx_fec_do_tx(IMXFECState *s)
         if ((bd.flags & ENET_BD_R) == 0) {
 
             /* Run out of descriptors to transmit.  */
-            trace_imx_eth_tx_bd_busy();
+            trace_imx_eth_tx_bd_busy(DEVICE(s)->canonical_path);
 
             break;
         }
@@ -446,7 +446,7 @@ static void imx_enet_do_tx(IMXFECState *s, uint32_t index)
         if ((bd.flags & ENET_BD_R) == 0) {
             /* Run out of descriptors to transmit.  */
 
-            trace_imx_eth_tx_bd_busy();
+            trace_imx_eth_tx_bd_busy(DEVICE(s)->canonical_path);
 
             break;
         }
@@ -521,7 +521,7 @@ static void imx_eth_enable_rx(IMXFECState *s, bool flush)
     s->regs[ENET_RDAR] = (bd.flags & ENET_BD_E) ? ENET_RDAR_RDAR : 0;
 
     if (!s->regs[ENET_RDAR]) {
-        trace_imx_eth_rx_bd_full();
+        trace_imx_eth_rx_bd_full(DEVICE(s)->canonical_path);
     } else if (flush) {
         qemu_flush_queued_packets(qemu_get_queue(s->nic));
     }
@@ -659,7 +659,8 @@ static uint64_t imx_eth_read(void *opaque, hwaddr offset, unsigned size)
         break;
     }
 
-    trace_imx_eth_read(index, imx_eth_reg_name(s, index), value);
+    trace_imx_eth_read(DEVICE(s)->canonical_path, index,
+                       imx_eth_reg_name(s, index), value);
 
     return value;
 }
@@ -767,7 +768,8 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
     const bool single_tx_ring = !imx_eth_is_multi_tx_ring(s);
     uint32_t index = offset >> 2;
 
-    trace_imx_eth_write(index, imx_eth_reg_name(s, index), value);
+    trace_imx_eth_write(DEVICE(s)->canonical_path, index,
+                        imx_eth_reg_name(s, index), value);
 
     switch (index) {
     case ENET_EIR:
@@ -951,7 +953,7 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
     unsigned int buf_len;
     size_t size = len;
 
-    trace_imx_fec_receive(size);
+    trace_imx_fec_receive(DEVICE(s)->canonical_path, size);
 
     if (!s->regs[ENET_RDAR]) {
         qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Unexpected packet\n",
@@ -993,7 +995,7 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
         bd.length = buf_len;
         size -= buf_len;
 
-        trace_imx_fec_receive_len(addr, bd.length);
+        trace_imx_fec_receive_len(DEVICE(s)->canonical_path, addr, bd.length);
 
         /* The last 4 bytes are the CRC.  */
         if (size < 4) {
@@ -1013,7 +1015,7 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
             /* Last buffer in frame.  */
             bd.flags |= flags | ENET_BD_L;
 
-            trace_imx_fec_receive_last(bd.flags);
+            trace_imx_fec_receive_last(DEVICE(s)->canonical_path, bd.flags);
 
             s->regs[ENET_EIR] |= ENET_INT_RXF;
         } else {
@@ -1047,7 +1049,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
     size_t size = len;
     bool shift16 = s->regs[ENET_RACC] & ENET_RACC_SHIFT16;
 
-    trace_imx_enet_receive(size);
+    trace_imx_enet_receive(DEVICE(s)->canonical_path, size);
 
     if (!s->regs[ENET_RDAR]) {
         qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Unexpected packet\n",
@@ -1093,7 +1095,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
         bd.length = buf_len;
         size -= buf_len;
 
-        trace_imx_enet_receive_len(addr, bd.length);
+        trace_imx_enet_receive_len(DEVICE(s)->canonical_path, addr, bd.length);
 
         /* The last 4 bytes are the CRC.  */
         if (size < 4) {
@@ -1131,7 +1133,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
             /* Last buffer in frame.  */
             bd.flags |= flags | ENET_BD_L;
 
-            trace_imx_enet_receive_last(bd.flags);
+            trace_imx_enet_receive_last(DEVICE(s)->canonical_path, bd.flags);
 
             /* Indicate that we've updated the last buffer descriptor. */
             bd.last_buffer = ENET_BD_BDU;
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 001a20b0e2ac..81af808044e1 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -444,20 +444,20 @@ i82596_ca_init(uint32_t scb, uint8_t mode, uint32_t base) "CA: Init - SCB=0x%08x
 i82596_ioport_write(uint32_t addr, uint32_t val) "IO write addr=0x%08x val=0x%08x"
 
 # imx_fec.c
-imx_phy_read_num(int phy, int configured) "read request from unconfigured phy %d (configured %d)"
-imx_phy_write_num(int phy, int configured) "write request to unconfigured phy %d (configured %d)"
+imx_phy_read_num(const char *path, int phy, int configured) "%s: read request from unconfigured phy %d (configured %d)"
+imx_phy_write_num(const char *path, int phy, int configured) "%s: write request to unconfigured phy %d (configured %d)"
 imx_fec_read_bd(uint64_t addr, int flags, int len, int data) "tx_bd 0x%"PRIx64" flags 0x%04x len %d data 0x%08x"
 imx_enet_read_bd(uint64_t addr, int flags, int len, int data, int options, int status) "tx_bd 0x%"PRIx64" flags 0x%04x len %d data 0x%08x option 0x%04x status 0x%04x"
-imx_eth_tx_bd_busy(void) "tx_bd ran out of descriptors to transmit"
-imx_eth_rx_bd_full(void) "RX buffer is full"
-imx_eth_read(int reg, const char *reg_name, uint32_t value) "reg[%d:%s] => 0x%08"PRIx32
-imx_eth_write(int reg, const char *reg_name, uint64_t value) "reg[%d:%s] <= 0x%08"PRIx64
-imx_fec_receive(size_t size) "len %zu"
-imx_fec_receive_len(uint64_t addr, int len) "rx_bd 0x%"PRIx64" length %d"
-imx_fec_receive_last(int last) "rx frame flags 0x%04x"
-imx_enet_receive(size_t size) "len %zu"
-imx_enet_receive_len(uint64_t addr, int len) "rx_bd 0x%"PRIx64" length %d"
-imx_enet_receive_last(int last) "rx frame flags 0x%04x"
+imx_eth_tx_bd_busy(const char *path) "%s: tx_bd ran out of descriptors to transmit"
+imx_eth_rx_bd_full(const char *path) "%s: RX buffer is full"
+imx_eth_read(const char *path, int reg, const char *reg_name, uint32_t value) "%s: reg[%d:%s] => 0x%08"PRIx32
+imx_eth_write(const char *path, int reg, const char *reg_name, uint64_t value) "%s: reg[%d:%s] <= 0x%08"PRIx64
+imx_fec_receive(const char *path, size_t size) "%s: len %zu"
+imx_fec_receive_len(const char *path, uint64_t addr, int len) "%s: rx_bd 0x%"PRIx64" length %d"
+imx_fec_receive_last(const char *path, int last) "%s: rx frame flags 0x%04x"
+imx_enet_receive(const char *path, size_t size) "%s: len %zu"
+imx_enet_receive_len(const char *path, uint64_t addr, int len) "%s, rx_bd 0x%"PRIx64" length %d"
+imx_enet_receive_last(const char *path, int last) "%s: rx frame flags 0x%04x"
 
 # npcm7xx_emc.c
 npcm7xx_emc_reset(int emc_num) "Resetting emc%d"
-- 
2.55.0


