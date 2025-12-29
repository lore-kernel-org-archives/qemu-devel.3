Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D29E92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIIr-0004Nd-5V; Mon, 29 Dec 2025 13:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHj-0003kk-2X
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHR-0008HC-VF
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:47 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BTADLpr3528353
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tp0xAKCIsiO
 yuDIYPNhKM0ElkMTXFmF7zzzBe8OdL2w=; b=WGCV1IDa3OLOZZunzrHGAWwrJIR
 /eRKC6FjFV/7R++KutAwMLDMyIWKWt9dWtLFki55MOvxNkstxov0kVWz3Nw1DVqJ
 CKZm4pnHz9N/7rXhoIZRv6/Ik/iw7Zm+kuIQC7zfKNgPZN0OY6vquRb1oNOEKO13
 FHkmw/GIsKRadpgr44Pef4i4T+LxWHytzez1Pm3oUrdVKJazSaVPpjfKwxLutLrM
 9MKRt7Symgg3DEChfwD+3ZAS80qYcI3bQKj3h/v97Kkyk1hQL+eGg8RIVjEyA5YI
 Lu9nqeQ9ZxlQWXW5ZaBFNt4UJGYOzr8xYSR7F/Em7662XT00E1EIOpqhCcQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bbc8ytdq4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:44 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-29f2b45ecffso152678015ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034064; x=1767638864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tp0xAKCIsiOyuDIYPNhKM0ElkMTXFmF7zzzBe8OdL2w=;
 b=AMkjPWJvVzDpeFbDEFpfxCqEtpABSpROIZLfjhBVxVDV/3HfOV+HMY4xS6Ym2IzmrH
 fn4tpWZ22vzvkWLj8vxdkYGvem45r9iHDQ7abXU1jaBo6o2UJQbEVDaygKQAvkwu64Qv
 1XgTKaHpguqhbgAYDVdXkezP1rcp1ChYd7QWI1zUkY6ryDJ/IW+zb+3DkZz/kOH4Vi0+
 Ouqvrm/f9OpxdsQ9S7uCz2E8bM0IXhsVxBuuNm2wqp7I3y/oaSG+0b/hmCoKv9Z5uQQ9
 QuiNgN6DfkPH0cClceH9FypFsTVAnyGppqBHrTtDs2McXBlMa+HRX6FKhbczntz9R5/N
 ZI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034064; x=1767638864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tp0xAKCIsiOyuDIYPNhKM0ElkMTXFmF7zzzBe8OdL2w=;
 b=oRfkmhIqy4yWwUPzK0pU9H8D1m6iXoITs5bMCTxomuLxWb2He3mHzwh0Wg9hC4ZCd+
 7ILBywaNIr7l7su2hNeqUqjjI14CxgLUtu9bCUDP7Xkbw8//NGM1bEMCG6O22XmNIECg
 cxH26wUbzhskSTy+YlZXq40kBPraCGJ/AGYNz6xUEMIjgao+V0YMhHMXN54oEIQZ2n9c
 wKrHsAZfhSOJq1rDAXhjkYr2cTNxtw4MaEoSMo1SADUR6saWYtdXeVvJG02ySdhtfpSj
 V1IDcvNEKoAJNieOkYN+Y4W6V+RZHAF2Gg9YNsZ9KTsFMnvdXDfIQqsdGJG/8AQ3D/uF
 6MaA==
X-Gm-Message-State: AOJu0Yxb35k5xp6mzaSP/p8RvoloP9mJsMPbS0P52wcDGbmfsI8k3V/5
 GwlTqw8130ODbS3Y+Tw64XOOZPPxn0NXVzqBC8pfTaNXTWzOdtCDoqTaHRZZlWYYLDIUl7khHmF
 PZeNNlAesl80pXvu12wfstcNijcjz8gM7WLATYnwTQ1pf9SCVUZD6IX2LEvFoyWZ2xQ==
X-Gm-Gg: AY/fxX7PbzElrpKcRZAy4XuenR/t2ilgevE5SkG2old0PUF6H+jFhK4dD2onZtu3xGa
 Nh7CkD7WVG7jsssDrORj9lZyEtOBjWUPKGwYSYrgEu22Jy1fV5RicOnbUXQjg0gPDhGUURnoNfv
 DoPkos1mRdIDeSrrQ5oyvWvhhoXAkYWwb6oXcruhjpjOHck+kq2aIk01XL0lPDM7oT7Mgve9LIa
 2KrWuDVjgPn0yIswidxC4P2N3xAqq8ntU/517xVjZvN0nUiECgM4Lpj0T+7ePihW+oct5PhJ05a
 PITX8uCjuH9EPK2zRhNNyTFKZsf/WWeDiVPRwAgp8AtBajy0b+/xIlJQvqikCUhGDK/PF4UWfwR
 6L3LewL+I//kaZglPSBJtMyH59Bxhe1zsxvgMtPmDvRZfJt4=
X-Received: by 2002:a17:903:190d:b0:2a0:a09b:7b0 with SMTP id
 d9443c01a7336-2a2f2c5f2d3mr319451835ad.61.1767034063575; 
 Mon, 29 Dec 2025 10:47:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoapqbFrJEBYDko95Ed7uWx+m1yoswfpfA3czAhhpo1bSxP34F1GgSYblWmf7sA00sjYYJrA==
X-Received: by 2002:a17:903:190d:b0:2a0:a09b:7b0 with SMTP id
 d9443c01a7336-2a2f2c5f2d3mr319451635ad.61.1767034063029; 
 Mon, 29 Dec 2025 10:47:43 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:47:42 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 10/17] hw/riscv/rv-trace-messages.c: add encoded trap
 message
Date: Mon, 29 Dec 2025 15:46:49 -0300
Message-ID: <20251229184656.2224369-11-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
References: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfX9a2vBc5O1TBy
 D3Adn04UesNP6Jo+rZhylEL65/2tWrm/50V06vA67JnII8+9WOZjAd3/OJjIR3uZxAvgnkRjcwB
 EeOvudnMzhUiXMkFxW5UiGNR611x/9V6OECNy/KmR/KAzzzVws7rsbKoTjbYfmN4nSR4tKj5/NN
 fl7cT3MhJiNM73lp10tD76BKOwNFT/sWe88iqPpNJHqzsqnu3QsmvJG9Fo+6EuBp2f90h7R5ahx
 +lwo0nxsK4KiSxmZRAuyl6LeZwgkqXjs+2YQIki33t2IZndUuWi4ORkp2aMJpWgNC4pKHiXjzi6
 uSeGB0qt24iYDbeRY0Y50zR8f7LKq2ScxcULt4B5bCLgjDziUvAudXQuRfQAt2KRfMxxGjDytGk
 qkaDfAW4LhVGBE4PXcFvODeV9F7P0kari/mgC0FBou5sXvtH5eJVekY9njX7SY6v5z4J8V19leK
 dVNX9gaIs8Aeg5qDtxQ==
X-Authority-Analysis: v=2.4 cv=cP7tc1eN c=1 sm=1 tr=0 ts=6952ccd0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=3vbdxVTLcZzJT87cJXQA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: ggsiEi9DaR5SzWtkx9Thmc_V9_0LDXww
X-Proofpoint-GUID: ggsiEi9DaR5SzWtkx9Thmc_V9_0LDXww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512290172
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The trap message consists of a Format 3 Subformat 1 e-trace message.

According to the Efficient Trace for RISC-V spec, section "Format 3
thaddr, address and privilege fields", the 'thaddr' will be zero if:

- we can't infer the EPC after an uninferable PC discontinuity (like traps).
  This doesn't happen in our current TCG backend - we'll always know the
  trap EPC in riscv_cpu_do_interrupt();

- a second interrupt/exception happens while the handler of the first
  trap hasn't exited. This also doesn't happen in TCG given that we do
  not emulate a multi-insn pipeline model, i.e. we'll only retire one
  insns at a time.

This means that we'll always send trap packets with 'thaddr' set to 1,
thus we're hardcoding it in the message helper.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/rv-trace-messages.c | 82 ++++++++++++++++++++++++++++++++++++
 hw/riscv/rv-trace-messages.h |  5 +++
 2 files changed, 87 insertions(+)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index 668db0c772..db5f7c2d26 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -18,6 +18,7 @@
 typedef enum {
     HEADER_SIZE = 1,
     SYNC_PAYLOAD_SIZE_64BITS = 9,
+    TRAP_PAYLOAD_SIZE_64BITS = 18,
 } RVTraceMessagePayloadSize;
 
 typedef struct RVTraceMessageHeader {
@@ -38,6 +39,23 @@ typedef struct RVTraceSyncPayload {
     uint32_t addressHigh;
 } RVTraceSyncPayload;
 
+/*
+ * Format 3 subformat 1 without 'time' and 'context' fields
+ */
+typedef struct RVTraceTrapPayload {
+    uint8_t format:2;
+    uint8_t subformat:2;
+    uint8_t branch:1;
+    uint8_t privilege:3;
+    uint8_t ecause:6;
+    uint8_t interrupt:1;
+    uint8_t thaddr:1;
+    uint32_t addressLow;
+    uint32_t addressHigh;
+    uint32_t tvalLow;
+    uint32_t tvalHigh;
+} RVTraceTrapPayload;
+
 static uint8_t rv_etrace_write_bits(uint8_t *bytes, uint32_t bit_pos,
                                     uint32_t num_bits, uint32_t val)
 {
@@ -95,3 +113,67 @@ size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
 
     return HEADER_SIZE + SYNC_PAYLOAD_SIZE_64BITS;
 }
+
+/*
+ * Note: this function assumes thaddr = 1.
+ */
+size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
+                                      TracePrivLevel priv_level,
+                                      uint8_t ecause,
+                                      bool is_interrupt,
+                                      uint64_t tval)
+{
+    RVTraceTrapPayload payload = {.format = 0b11,
+                                  .subformat = 0b01,
+                                  .branch = 1,
+                                  .privilege = priv_level,
+                                  .ecause = ecause,
+                                  .addressLow = extract64(trap_addr, 0, 32),
+                                  .addressHigh = extract64(trap_addr, 32, 32)};
+    RVTraceMessageHeader header = {.flow = 0, .extend = 0,
+                                   .length = TRAP_PAYLOAD_SIZE_64BITS};
+    uint8_t bit_pos = 0;
+
+    /*
+     * When interrupt = 1 'tval' is ommited. Take 8 bytes
+     * from the final size.
+     */
+    if (is_interrupt) {
+        header.length = TRAP_PAYLOAD_SIZE_64BITS - 8;
+    }
+
+    bit_pos += rv_etrace_write_header(buf, header);
+
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 2, payload.format);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 2, payload.subformat);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 1, payload.branch);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 3, payload.privilege);
+
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 6, payload.ecause);
+
+    if (is_interrupt) {
+        bit_pos += rv_etrace_write_bits(buf, bit_pos, 1, 1);
+    } else {
+        bit_pos += rv_etrace_write_bits(buf, bit_pos, 1, 0);
+    }
+
+    /* thaddr is hardcoded to 1 for now */
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 1, 1);
+
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 32, payload.addressLow);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 32, payload.addressHigh);
+
+    /* Skip trap_addr if is_interrupt  */
+    if (is_interrupt) {
+        goto out;
+    }
+
+    payload.tvalLow = extract64(trap_addr, 0, 32);
+    payload.tvalHigh = extract64(trap_addr, 32, 32);
+
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 32, payload.tvalLow);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 32, payload.tvalHigh);
+
+out:
+    return HEADER_SIZE + header.length;
+}
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
index c7226b50a9..f210e048dd 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -21,5 +21,10 @@ typedef enum {
 
 size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
                                       TracePrivLevel priv_level);
+size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
+                                      TracePrivLevel priv_level,
+                                      uint8_t ecause,
+                                      bool is_interrupt,
+                                      uint64_t tval);
 
 #endif
-- 
2.51.1


