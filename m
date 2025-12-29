Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FF9E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIJ1-000574-NN; Mon, 29 Dec 2025 13:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaII4-0003oN-BD
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:28 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHt-0008IN-79
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:23 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BT9xi9G211639
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KWutLemSumC
 GaG76d6tajCvKjv69ATtigQPvk/IKg7o=; b=HlBYvyN5WHO1Oz2ShT2Q7vc8JGv
 Xe6noph6tI4xejAwy68thF/PNzw2Si960Ci9N4SEpJZRgvbQfd2VPXwOsNeiAbDx
 j/kcieC7U2CVsXlUJb3jVD9uh1u7w1y2z1IzDVGKBXJpBJebxPuXWBFej1KPcS7j
 OM8h1bmiiw3gaq3yKIba00qJhRmoUoEbX02fBo+XFkZcIJT1wsnn4kNCM4rA5A/9
 9472pAWh0vH75Yn485X2wh0gQ9EY/QzdxHHE1c83NS258IKqbLOj3LJVHC4d3I4i
 FyYOnPrObsBj6F2g/pwPHUxY6ieGGIU6LmnO1Tn48in/8FGhVeOfBdZLqJQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bbc9v2d8f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-29f25a008dbso84098355ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034077; x=1767638877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWutLemSumCGaG76d6tajCvKjv69ATtigQPvk/IKg7o=;
 b=JrdJyCqgXKxcaWA7dVCN75YV4cTO6SQnrOIdlERJgZZQP9wwPuPN8CqrnIyh+cofN/
 QwTkgMFRwbxhEsOnRDGw+Pe0knH0nao95nY05VP+qRzu6tqh2lP752KyW3X5ZJDYSGtq
 rElmRUgXaosCNKBLyGy3ZL1zBHxWlzPvznCXbZ4Xzy8/6QkntPwGQ21i/ftOW7fj/0kY
 95g0GuqHlkwTPpQ8XE3UkKAiNKoZHYVVR+wU8Hx+SNLj3BOnSf7RhWxFdaj41s087loQ
 HzNUjZoevh/mbausB+Qh5t3lMmtwXImxwa0QRshozyo6asd/18Rj3SsAg7BbXBTCcIDH
 znxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034077; x=1767638877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KWutLemSumCGaG76d6tajCvKjv69ATtigQPvk/IKg7o=;
 b=lSzkK/3T11rD/gzjNwVUvvzfEqOJasjJKeNMf4M+6xngOaRlf8Bv/7vOs2JT11nWJO
 yBt6V8A26ygfYEK9INa+8DMX8grkz8rzqIhbE6q0a/feKHoinNggoFGA0K5oTOLJmI56
 XgqxcKiWJpJjqFx6bZQSd66+0utQ1fqcpPbJ3Im2o35IX0Ql8qIpDutoJAbTVN/5mBZN
 TE2C5cx/izTZ8S1D91x3d+GAoOFQAAt23IW8CbJ/J2o7aVy06Chz3wYHud8gEbegBpAO
 BTWbU3GiAM0QUJuwwx/c6Wx7V1yY+W+I8h7sGXUAd3HA49gOxF/QTFvSS2+SYMt3zwDq
 AXLw==
X-Gm-Message-State: AOJu0YwRk2WEv8KiC9ghh/5rCDutlwAjGddisrFTDjjF31OeaphDbTDX
 9IeXiR4lDnhlQyhkuZviLlMPhKUIRUYxv4NJNibah2loZDeSJ5P3ZgFqC6+ymXTAZS84eS0j8JX
 Jiq8KHwkkAH9RUebbQKtqP6lQbWsP8uPWNz5FCU2//vzZWueoQTU5M+JGkdiG+GoRVA==
X-Gm-Gg: AY/fxX7h+5cGgS3HPt7Y+nw+cgLfWYVGoKqV/O2+Pfnx0gGrxO3xZICh/DnDKyBTrCE
 YlevEw+D3mkTcirgyExczJCE5k+iNeqtZjtj6umXr+F/L9IOyTkP3pQs+UqB/frGq5YwfPHi4+3
 db+0GVV7Cl+SeAiGSt+94A4WrzcdAGbce074XjMEYY+Q9z97vD5+pUAve+psNsK2TAazIE4V0oT
 BIDM4jbMV56oh18EPOZ2ljCMI13vmFXZUnHrCLlyHNt3wbNkhZtXZusOmlbFZWt2Wh/6kXwtzY5
 GXxOWsKT9PBNs5eCF5ZnUvUxKddH6dFuGBhmDBD4dhLSj0NknwEODrCiXvQrcD/msyUhSbjELVH
 G06GQI2CrmGC13srxnvPQZDVdL3PoALEROHjrS5UZfwQ8d+c=
X-Received: by 2002:a17:903:228b:b0:2a0:f0e2:94b7 with SMTP id
 d9443c01a7336-2a2f2735298mr284167485ad.30.1767034077312; 
 Mon, 29 Dec 2025 10:47:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxqZqGsbgodfEiMsFIf9fqy+72fBxsXBTi9z1FvKXiXpPk/dx9V+UNtHcLhGVNHHi84/mCKg==
X-Received: by 2002:a17:903:228b:b0:2a0:f0e2:94b7 with SMTP id
 d9443c01a7336-2a2f2735298mr284167305ad.30.1767034076821; 
 Mon, 29 Dec 2025 10:47:56 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:47:56 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 15/17] hw/riscv/rv-trace-messages: add format 1 msgs with
 branch info
Date: Mon, 29 Dec 2025 15:46:54 -0300
Message-ID: <20251229184656.2224369-16-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
References: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZGdaNzzUQpJ5it_KRK0wGJvhEZzttzRV
X-Authority-Analysis: v=2.4 cv=R/sO2NRX c=1 sm=1 tr=0 ts=6952ccde cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=3vbdxVTLcZzJT87cJXQA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfX/Wt4PyQ5F+9n
 wUQ3GDPs852G7ig7HhZBZ3FwTaZsgYo/zE+nKK1KDTggkVUKjFYDd8uGB/ghVnqbKwQDgmXTvHG
 w4H8pRnHPJs1bJHVdzg+sEr7ZPRNzERa3Xypfuwpwy6/qJtbqpqdLrrWawGWQgjCVPdyWGysxo8
 oshmIFMGO77Pakwl595kzm0WYOy4n6zZ2jiqNbJfCa2myAB/f+8A6z9DGbyPMdNb7OUTujouZqW
 IbMnpfTGwK4SHTFOU6YWdGgpPU973AAVbAIUoVJoZClOepbRpZjnJ0Se0bRzt6YLTCur2bsbYXh
 WySRZZ+iroCesqJayqjCdCZMvPw1gDaAzc2zU2r1qBGElOhogBSpEt614iMjIwRepL6ROPHolR7
 ppwiB27pk1LkoAPjVqcMALUMUgtmQkp4zCiTs0TVkSAU0kH+yo/syMHuB7yXd3G02jNnjohes2g
 8VlRQJuGfPP3h9hPVuw==
X-Proofpoint-ORIG-GUID: ZGdaNzzUQpJ5it_KRK0wGJvhEZzttzRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290172
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add encoded message helpers to send branch information trace packets.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/rv-trace-messages.c | 110 +++++++++++++++++++++++++++++++++++
 hw/riscv/rv-trace-messages.h |   7 +++
 2 files changed, 117 insertions(+)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index 2f041aa639..7deaf25060 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -20,6 +20,8 @@ typedef enum {
     SYNC_PAYLOAD_SIZE_64BITS = 9,
     TRAP_PAYLOAD_SIZE_64BITS = 18,
     FORMAT2_PAYLOAD_SIZE_64BITS = 9,
+    FORMAT1_BASE_PAYLOAD_SIZE_64BITS = 5,
+    FORMAT1_PAYLOAD_MIN_SIZE_64BITS  = 10,
 } RVTraceMessagePayloadSize;
 
 typedef struct RVTraceMessageHeader {
@@ -67,6 +69,28 @@ typedef struct RVTraceFormat2Payload {
     uint8_t irdepth:3;
 } RVTraceFormat2Payload;
 
+typedef struct RVTraceFormat1BasePayload {
+    uint8_t format:2;
+    uint8_t branches:5;
+    uint32_t branch_map:31;
+} RVTraceFormat1BasePayload;
+
+/*
+ * FORMAT2_PAYLOAD_SIZE_64BITS = 9 plus 5 bits of 'branches',
+ * plus minimal 3 bits of 'branch_map' = 10 bytes.
+ */
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
 static uint8_t rv_etrace_write_bits(uint8_t *bytes, uint32_t bit_pos,
                                     uint32_t num_bits, uint32_t val)
 {
@@ -228,3 +252,89 @@ size_t rv_etrace_gen_encoded_format2_msg(uint8_t *buf, uint64_t addr,
 
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
+    uint8_t bit_pos = 0;
+
+    bit_pos += rv_etrace_write_header(buf, header);
+
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 2, payload.format);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 5, payload.branches);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 31, payload.branch_map);
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
+                                     .updiscon = updiscon,
+                                     .addressLow = extract64(addr, 0, 32),
+                                     .addressHigh = extract64(addr, 32, 32)};
+    uint8_t payload_size = FORMAT1_PAYLOAD_MIN_SIZE_64BITS;
+    uint8_t branch_map_size = 0;
+    uint8_t bit_pos = 0;
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
+    bit_pos += rv_etrace_write_header(buf, header);
+
+    payload.irreport = updiscon;
+    if (updiscon) {
+        payload.irdepth = 0b111;
+    } else {
+        payload.irdepth = 0;
+    }
+
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 2, payload.format);
+
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 5, payload.branches);
+
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, branch_map_size, payload.branch_map);
+
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 32, payload.addressLow);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 32, payload.addressHigh);
+
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 1, payload.notify);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 1, payload.updiscon);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 1, payload.irreport);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 3, payload.irdepth);
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
2.51.1


