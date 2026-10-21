Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077F0606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DYXpREhF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FKzwnbVk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfW3-0007dd-Tw; Wed, 21 Oct 2026 19:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVw-0007Z7-7Q
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVu-00050h-Ek
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:31 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKe2Pt1721754
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zs3SY315D8a
 /Zw/QdtK2fiSbIXP7gnfs6y7WyCjT/qc=; b=DYXpREhFrUJJ36hplIj1k2+hbIq
 4OO18kAXGCBYv8ejguwEcsStCHGFvD/VP0vT+ikfNQtywnL6drvja9RGNpo1tt98
 86z9++NZpgL7oX3TPOk0V+R1FknRGWOYXAO39Z7UsN6+aAUPperzli6KWgkvWeFh
 aCXR4EZCcgeLPQZ2tJL4uW2ar3Ek+j9QxPWdYKD1/BH/LrJVJHjMWhbL9B7yWdMh
 lIU26ebPhkTIXhqbA9L+8KIZ2M27RbAJlhTkCM2ub6y5X5GTPPCCOCSewzFWS2rf
 7HTz7VRffzRt5O/BWVwH9rAr7goTIizqwaEwN9u1B7nS9MuR4zcEBpvcj7w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj4b5dd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-536466909b7so28721311cf.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624468; x=1793229268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zs3SY315D8a/Zw/QdtK2fiSbIXP7gnfs6y7WyCjT/qc=;
 b=FKzwnbVks+S8W8hz0Dophb9BCy516wvsMwER8g1M5iUCUN+21OHnTrAPi2EEqwXlLH
 1sp9LgI/U3+BULl9ZJlzOFHpEQSo0BVk9lkGUgypqFNLloE3whzFmLvaqbHHSOx71nW5
 hdmd7f9pMd9+weDfvQpQPJPA2wQdJwP+o8IS4mHyXNk2D20fpfkFYBXRh7gZDQIGvV1h
 AAfJXalIGt6WremEtb08wVIF8gDDxuIlEqECfOg6VVLh+7bh/b9xArePpJqjPAz9Ggyk
 73rvahpXmkVYO/72zZ7/qXjy1UAZH5j3wnO0OpyKXfgg+5GsdrajeXV9V+RsQVOOihsv
 2Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624468; x=1793229268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zs3SY315D8a/Zw/QdtK2fiSbIXP7gnfs6y7WyCjT/qc=;
 b=IlZi0NJJph96WU5Lr5H8C9MJhbX0wr9FxlmkL+gWXof5BH8jJKo+ICQ3tK1Z3T6dYR
 Hx/Bw1uePnDQ4rvj/DmOXPO2Y4/oPwFDgCqAv1buG81lVD9cGBYyvPcOZeTFtQb1n6lL
 HNjAZhB0VV7acYfMIxuJBmyQYpwvqteqBckR623lE4hktCiAMw3fCG8P8wtNeStj/F46
 EKf9vk8RdIkwXczs1xFpz6rXsLl0qrooHFi1ij/jeTIYZyYfluKplV/MwGZx4G8Gdd1r
 TrHLUEx0MGNVcsZRwdC/fqV/sFaCXwvZ5bxvc13QGR8zv2MR/D35EPaZfqD7LUJRwSQX
 kWlw==
X-Gm-Message-State: AFq9FYJZMguukIcLEwLY2D45L8UFoJ630tNcHGqr0xu7yQq4tv2muQjD
 F8ngYiSZF2N9+pDXKcm1hY0iR+L94w/qp2LBdkNHfciE3rGFGgKzRuO9LVTeM0C/+gWcqpNrN1p
 tVkyEq40qSL96L2MgCfPfn5vu6zBpow0jWhN2g4qyyUYhJzl9O8MtnJmkuPD1X70T8w==
X-Gm-Gg: AYBFou2YRx1JfxRGgbD4xSWbM5Nmv4Dm3qLAUj9xBVthUEF2HZBqr39TssluAMemTMa
 RKwb3IJtXprPFC4Mp6Rs9isBxBzltdhP1WK16wsgQkXxjmT8dE/FDlm4wQre2zSVxwxZ5U6kZlw
 NgCtuLkGm2G+KJkXSzPSZAuDvjDhqxa7BU1r4IjNR5Yk+4YC6oifya53tFQ7NMTz0Bg3QmVwQep
 RF9plZeMPq9Z0yXzza7Gdzme+RUpsU7ILao0aCnxp9+zcrYtTI9vq89rosudYLPoEaFBJ8jtpNJ
 Zgsmkmt+EfM1TqlP+9mp4SPGrj6c65KiY1t6R81lcjvNxs+YEZPqb9v+kCoarNpYt/IRVrk4Ci/
 qsL/pncGMUQirAiOrSliAj77FWhJISNXACp8+hnhgbbuLAeqmjacyqNTkAsjLUWhutvH2BkLjsA
 ==
X-Received: by 2002:a05:622a:544c:b0:535:a5fc:3b5f with SMTP id
 d75a77b69052e-5369bb2e57dmr55251471cf.75.1792624467811; 
 Wed, 21 Oct 2026 16:14:27 -0700 (PDT)
X-Received: by 2002:a05:622a:544c:b0:535:a5fc:3b5f with SMTP id
 d75a77b69052e-5369bb2e57dmr55250931cf.75.1792624467124; 
 Wed, 21 Oct 2026 16:14:27 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:26 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 10/18] hw/riscv/rv-trace-messages.c: add encoded trap
 message
Date: Wed, 21 Oct 2026 20:13:37 -0300
Message-ID: <20261021231346.2452179-11-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: C-HpWuXn6xha0YlmHWH44vDxerEtIS0M
X-Proofpoint-GUID: C-HpWuXn6xha0YlmHWH44vDxerEtIS0M
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad94754 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=wHbgKFqcilCShCF3WtgA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfXyzPrZFIono+G
 HTR8zWvb3/QjoA9kR72baBS6/vVsZElZCy6XwJLIcXNl/KVrz6VTUA0DWDCVgWYNWJXYfS3lK92
 DSWNpgc6vjNTGT90qsGhUsZ47T7MJIoWZfzYBNeOGku4miPzQX20aKrWEX7V4aAN0Eh/shVb6PY
 ijmGtVYovJdl+7DY8NYxuIWGIscobzU3t3aE0HifxJuLCmBZu7X+warNWqWvUCdVN1yvopuPWt9
 tIX3VYksdq6kBP6uHg8Hr3aXw6Gyj2O4b6rSZCZ5fShLtCPTEE0sn+c1I2DXfPKiaOAgt68ZmkL
 1FCscM1JT0VZt9dXOUcSqDM9Hoc5WR36KtfmxjxH26G3mAJCuquPI9f5LuqHIFQfSGFlmRM2nZf
 qto4oI72zsMZv47QosX4nHaxmvAgGpbaEgknAVsrREgfUkoef5/+8tUFxWaq7SDeAG4l/HC3Uei
 JhWlZAB3HSz1jiKQOPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX4Gj+akZ1KJTm
 1uVxPl+kQYrpxlIqbXwGQB/LRJpyMsmpxBzc0F35llRc7HbfzpOhpkVm+rf5UsjxrpcViCrSoWF
 3lrn6twR0HnxwXFkcxVx7ZnGACXXvJs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 hw/riscv/rv-trace-messages.c | 94 ++++++++++++++++++++++++++++++++++++
 hw/riscv/rv-trace-messages.h |  5 ++
 2 files changed, 99 insertions(+)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index 01ff51c715..7ea1c87fff 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -35,6 +35,24 @@ typedef struct RVTraceSyncPayload {
 } RVTraceSyncPayload;
 #define SYNC_PAYLOAD_SIZE_64BITS 9
 
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
+#define TRAP_PAYLOAD_SIZE_64BITS 18
+
 static void rv_etrace_write_bits(uint8_t *bytes, uint32_t bit_pos,
                                  uint32_t num_bits, uint32_t val)
 {
@@ -92,3 +110,79 @@ size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
 
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
+                                  .ecause = ecause};
+    RVTraceMessageHeader header = {.flow = 0, .extend = 0,
+                                   .length = TRAP_PAYLOAD_SIZE_64BITS};
+    uint8_t bit_pos;
+
+    payload.addressLow = extract64(trap_addr, 0, 32);
+    payload.addressHigh = extract64(trap_addr, 32, 32);
+
+    /*
+     * When interrupt = 1 'tval' is ommited. Take 8 bytes
+     * from the final size.
+     */
+    if (is_interrupt) {
+        header.length = TRAP_PAYLOAD_SIZE_64BITS - 8;
+    }
+
+    rv_etrace_write_header(buf, header);
+    bit_pos = 8;
+
+    rv_etrace_write_bits(buf, bit_pos, 2, payload.format);
+    bit_pos += 2;
+    rv_etrace_write_bits(buf, bit_pos, 2, payload.subformat);
+    bit_pos += 2;
+    rv_etrace_write_bits(buf, bit_pos, 1, payload.branch);
+    bit_pos += 1;
+    rv_etrace_write_bits(buf, bit_pos, 3, payload.privilege);
+    bit_pos += 3;
+
+    rv_etrace_write_bits(buf, bit_pos, 6, payload.ecause);
+    bit_pos += 6;
+
+    if (is_interrupt) {
+        rv_etrace_write_bits(buf, bit_pos, 1, 1);
+    } else {
+        rv_etrace_write_bits(buf, bit_pos, 1, 0);
+    }
+    bit_pos += 1;
+
+    /* thaddr is hardcoded to 1 for now */
+    rv_etrace_write_bits(buf, bit_pos, 1, 1);
+    bit_pos += 1;
+
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.addressLow);
+    bit_pos += 32;
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.addressHigh);
+    bit_pos += 32;
+
+    /* Skip trap_addr if is_interrupt  */
+    if (is_interrupt) {
+        goto out;
+    }
+
+    payload.tvalLow = extract64(trap_addr, 0, 32);
+    payload.tvalHigh = extract64(trap_addr, 32, 32);
+
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.tvalLow);
+    bit_pos += 32;
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.tvalHigh);
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
2.43.0


