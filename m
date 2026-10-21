Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B849606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AcMS8n/o;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PKX2MZfR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfWV-00080Y-MZ; Wed, 21 Oct 2026 19:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfW9-0007iy-LH
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfW7-00052y-Ra
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:45 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKe5X82748308
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xA/2MIE1awN
 saQNlpuYctPhOBgSBq4Bdh4il8/V7pIw=; b=AcMS8n/ours/VRvN+LA3QXRA8Dx
 Wkjc7KGyTsBuDZl8RSvXczCcMGPUKxaDGyl+DDynM0GkGNRa8qamQHvxZBKzLEc8
 HcmR9nNrM15yQJLIUvhFAxt4TT1YMtome+l4MyX7Ou4rjUYMjanN6HNdgDZVtUOg
 Npa5QTWFHC3KjgaOLX4ICTluVaSTVLRUjem74Dhy69Uai4/C3wLEjverrjfTlLDU
 Biz+qcExHP2Hvb8xhsPSoBPQTU8qvmsUxLZHFA3+Rqox8KiNhkSN1oQVE3imNPpR
 h6lD3AI8XHXMF0i2l7O+OkbKIKPA88qmFHDWf8z3KIgmIKUC6bGW5x2A+yw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0ke1h1p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-536720195ebso26542831cf.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624481; x=1793229281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xA/2MIE1awNsaQNlpuYctPhOBgSBq4Bdh4il8/V7pIw=;
 b=PKX2MZfRev9/+DC3O+F6EHaeFAMLaZqB+QaR0LaN5/Zdb+ZXEGM90X7LKCYmorzheL
 FWPkJyzeATVjnfBAiY+z7QxAtBMtuA4bCMZ+6SGwGGPLH2U+vOmJD0JxXImkiYQA9Clv
 Kiu3t93gP9znn/JRLBnCqRI2DB8AYXSJYaZ/EVGSYurt4j9KGHwM41Kjt0BMNJjxzI/R
 Zj8Bya/0IbaS1d+B/z4pdlWmlShlJVyDd5UM68zXTnmCONfH3DhXA4WJrnw/6wQiNSTU
 x1WEMd2bVM4js1/w2x2YaP6kkIf2AynfyXTLxLPcPNaoftYnT5yNTHOVuqaacrjM8jVY
 fdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624481; x=1793229281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xA/2MIE1awNsaQNlpuYctPhOBgSBq4Bdh4il8/V7pIw=;
 b=fyhsuyWF+Y7oq4b9Pz1i37aJ3XYx6ps2oAMpJIWsakWATXLPZbhCgkck6tuC9Epsk9
 Im4Djr3hhpwOHSIbQh7eYBcc/Oj67F0VsWm1kTGz4pDQkcv2kRl0wDljev4j83X7vXhy
 rk6Co0kUF2EeH5r2tKcLTUtgDmYyj27KqtJ4uo/IKvZmYdfRuU1w2BeII8dn1WkzTCFC
 u0KSP4SXaF0pARk01+0RDbgPvBmYPkvGnXOLZCN0e/y1E7ZfyFlhTwbfv9IG6Xp3+DM8
 ZEQUdkzpwiulKpEMslcejBMp/tsJoEm3Hgh0vJyrzKnwYU41NIHcW3uaKwSFCf53lYRX
 PVNg==
X-Gm-Message-State: AFq9FYIcG3dfW2ZfIzvrnWND0w74Y5Vbq6j+Tks1oMs/d+Gh0fQI436t
 //31TnhWOi0E2kABUDyn4DFpGRiqsb3lvEPPRk8DJEClEiEj11kQrfYm+4ThH2gydGas3ZF1YjT
 4/q+XvnTvRguA2KrcrXf7Z/0FWpkSqE18LWiiDPXPEwQ8O8m4++9+T3UV2PcGlLecyg==
X-Gm-Gg: AYBFou3+cJ5T5aPKbkXBwsP4A7FIyKU0Fchj6lFzM5PizU5BBIW7SY9lycMh4s0hRf9
 PwBQ6g7oHVjAe9XVz1HCgVK//A7Spead+0T8YF4qlaOzLY2MWAatzRGql9PvngI1OjzGXm/q6ol
 1YLmOokhgv9bm10EBhYZE2B3XalQ6XcovH+j2eD8OIIR3VAjRQM4Wvstoxbs0xVYeED9E+d3ZQx
 XJI+IM4gdxRo69oqRlpH0AMVrYHnD8rcuSNNac+xOV9qXiqvZqzJfQj3vpHhG9dckpkR2tAbXtl
 J0wORAE0MU/pEVw2PGQ7e1uYQY8AHDfqjKdfoluDQHpiERerfBMGzYZz57FKjJGArWCyDkyspbC
 OOxATqk9ywJanpopxXZS0oClit7mrprU4Q7H3LuKmslR4fMbWtK8Wvie5+8dBOYhldOsLAIBh2Q
 ==
X-Received: by 2002:a05:622a:164d:b0:536:65fc:1e with SMTP id
 d75a77b69052e-5369bb41760mr55646491cf.62.1792624481246; 
 Wed, 21 Oct 2026 16:14:41 -0700 (PDT)
X-Received: by 2002:a05:622a:164d:b0:536:65fc:1e with SMTP id
 d75a77b69052e-5369bb41760mr55646021cf.62.1792624480633; 
 Wed, 21 Oct 2026 16:14:40 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:40 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 15/18] hw/riscv/rv-trace-messages: add format 1 msgs with
 branch info
Date: Wed, 21 Oct 2026 20:13:42 -0300
Message-ID: <20261021231346.2452179-16-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eWXxmJrQZTgsN1GWCb91-Q89V_qzWud0
X-Proofpoint-ORIG-GUID: eWXxmJrQZTgsN1GWCb91-Q89V_qzWud0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX6rgR+1RA+8UL
 qRtpTbQbztPe4WS1CHcUZT7pFzurN23Rv3AVyOzmA9iWt+pihtGKh36/ifibdLfSws86X//bsZc
 2RPAoMzf0vylYC+nts/O5Lc6MqBW9bU=
X-Authority-Analysis: v=2.4 cv=KOzPn1Fo c=1 sm=1 tr=0 ts=6ad94762 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=26Pa0hPBu1MJQ4wyLl0A:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX9uACJVADxXSx
 hf91tk4IerJSNM9II/AR762ZsvZO4MghRky4B+ZauF/hhLwiLP6TclRjw7BQjigQHqcWhRoj6aY
 f9mLbWRmGNtEAGVo1Hp9B5vsGjMYzGG+iQhGMugMPfw6DDYRE9G/YYJjGlyfg57rgLgiMO0okQe
 kBEizXDdSXlLcZFw/EhEDY4a75I6XlATE6j22uxoWMf3dpgIKV8YPUK4n0iiDcqbAX95bqmlhjW
 d3S2MfBrWIb4iDywyYJx1/u9L8hcFSMvAOTRsjVoahXV3fbOqrVakAlZewDQHGv+O4oEcss72RM
 w5Nnyiw3CXjtMUG2Il00rwLedtTQ6fhAjO9uL00pk7jmPkyJVt9tL79tNlXziqXkcnZvRxDYlx0
 pTu9GQJ18EGDGbjStXliADgHux/OnCA/lbunWVQWcHQa6b1Vzq7TtqBWaJQuqn46Xsl4lYKP1ij
 2YYqmIHCBnA5b2HKASA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Add encoded message helpers to send branch information trace packets.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/rv-trace-messages.c | 126 +++++++++++++++++++++++++++++++++++
 hw/riscv/rv-trace-messages.h |   7 ++
 2 files changed, 133 insertions(+)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index 83d3436e2e..46445a47da 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -64,6 +64,31 @@ typedef struct RVTraceFormat2Payload {
 } RVTraceFormat2Payload;
 #define FORMAT2_PAYLOAD_SIZE_64BITS 9
 
+typedef struct RVTraceFormat1BasePayload {
+    uint8_t format:2;
+    uint8_t branches:5;
+    uint32_t branch_map:31;
+} RVTraceFormat1BasePayload;
+#define FORMAT1_BASE_PAYLOAD_SIZE_64BITS 5
+
+typedef struct RVTraceFormat1Payload {
+    uint8_t format:2;
+    uint8_t branches:5;
+    uint32_t branch_map;
+    uint32_t addressLow;
+    uint32_t addressHigh;
+    uint8_t notify:1;
+    uint8_t updiscon:1;
+    uint8_t irreport:1;
+    uint8_t irdepth:3;
+} RVTraceFormat1Payload;
+
+/*
+ * FORMAT2_PAYLOAD_SIZE_64BITS = 9 plus 5 bits of 'branches',
+ * plus minimal 3 bits of 'branch_map' = 10 bytes.
+ */
+#define FORMAT1_PAYLOAD_MIN_SIZE_64BITS 10
+
 static void rv_etrace_write_bits(uint8_t *bytes, uint32_t bit_pos,
                                  uint32_t num_bits, uint32_t val)
 {
@@ -245,3 +270,104 @@ size_t rv_etrace_gen_encoded_format2_msg(uint8_t *buf, uint64_t addr,
 
     return HEADER_SIZE + header.length;
 }
+
+size_t rv_etrace_gen_encoded_format1_noaddr(uint8_t *buf,
+                                            uint8_t branches,
+                                            uint32_t branch_map)
+{
+    RVTraceMessageHeader header = {.flow = 0, .extend = 0,
+        .length = FORMAT1_BASE_PAYLOAD_SIZE_64BITS};
+    RVTraceFormat1BasePayload payload = {.format = 0b01,
+        .branches = branches, .branch_map = branch_map};
+    uint8_t bit_pos;
+
+    rv_etrace_write_header(buf, header);
+    bit_pos = 8;
+
+    rv_etrace_write_bits(buf, bit_pos, 2, payload.format);
+    bit_pos += 2;
+
+    rv_etrace_write_bits(buf, bit_pos, 5, payload.branches);
+    bit_pos += 5;
+
+    rv_etrace_write_bits(buf, bit_pos, 31, payload.branch_map);
+
+    return HEADER_SIZE + header.length;
+}
+
+/*
+ * Same reservations made in the format 2 helper:
+ *
+ * - irreport and irdepth is always == updiscon;
+ *
+ * - return_stack_size_p + call_counter_size_p is hardcoded
+ * to 3 since we don't implement neither ATM.
+ */
+size_t rv_etrace_gen_encoded_format1(uint8_t *buf,
+                                     uint8_t branches, uint32_t branch_map,
+                                     uint64_t addr,
+                                     bool notify, bool updiscon)
+{
+    RVTraceMessageHeader header = {.flow = 0, .extend = 0};
+    RVTraceFormat1Payload payload = {.format = 0b01,
+                                     .branches = branches,
+                                     .notify = notify,
+                                     .updiscon = updiscon};
+    uint8_t payload_size = FORMAT1_PAYLOAD_MIN_SIZE_64BITS;
+    uint8_t branch_map_size = 0;
+    uint8_t bit_pos;
+
+    g_assert(branches < 32);
+
+    if (branches <= 3) {
+        branch_map_size = 3;
+    } else if (branches <= 7) {
+        branch_map_size = 7;
+        payload_size++;
+    } else if (branches <= 15) {
+        branch_map_size = 15;
+        payload_size += 2;
+    } else {
+        branch_map_size = 31;
+        payload_size += 4;
+    }
+
+    header.length = payload_size;
+
+    rv_etrace_write_header(buf, header);
+    bit_pos = 8;
+
+    payload.addressLow = extract64(addr, 0, 32);
+    payload.addressHigh = extract64(addr, 32, 32);
+
+    payload.irreport = updiscon;
+    if (updiscon) {
+        payload.irdepth = 0b111;
+    } else {
+        payload.irdepth = 0;
+    }
+
+    rv_etrace_write_bits(buf, bit_pos, 2, payload.format);
+    bit_pos += 2;
+
+    rv_etrace_write_bits(buf, bit_pos, 5, payload.branches);
+    bit_pos += 5;
+
+    rv_etrace_write_bits(buf, bit_pos, branch_map_size, payload.branch_map);
+    bit_pos += branch_map_size;
+
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.addressLow);
+    bit_pos += 32;
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.addressHigh);
+    bit_pos += 32;
+
+    rv_etrace_write_bits(buf, bit_pos, 1, payload.notify);
+    bit_pos += 1;
+    rv_etrace_write_bits(buf, bit_pos, 1, payload.updiscon);
+    bit_pos += 1;
+    rv_etrace_write_bits(buf, bit_pos, 1, payload.irreport);
+    bit_pos += 1;
+    rv_etrace_write_bits(buf, bit_pos, 3, payload.irdepth);
+
+    return HEADER_SIZE + header.length;
+}
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
index 89f30e7d36..f8f1830852 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -28,5 +28,12 @@ size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
                                       uint64_t tval);
 size_t rv_etrace_gen_encoded_format2_msg(uint8_t *buf, uint64_t addr,
                                          bool notify, bool updiscon);
+size_t rv_etrace_gen_encoded_format1_noaddr(uint8_t *buf,
+                                            uint8_t branches,
+                                            uint32_t branch_map);
+size_t rv_etrace_gen_encoded_format1(uint8_t *buf,
+                                     uint8_t branches, uint32_t branch_map,
+                                     uint64_t addr,
+                                     bool notify, bool updiscon);
 
 #endif
-- 
2.43.0


