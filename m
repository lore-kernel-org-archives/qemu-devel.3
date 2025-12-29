Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB4CE92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIJ0-0004zm-3o; Mon, 29 Dec 2025 13:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHp-0003lX-9U
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:11 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHj-0008Hs-0S
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:06 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BTAPw0S3328630
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=clGoi7Z2TK6
 idM7ZzPi9LsVrS6OQOKiMecxLbKuFC7Q=; b=pZFIXXpbNQJk6sIRoW6+nzZNR16
 krBE4E2jqmQhaVi9DNsb7W4irQe1eKLloL292JgsE2/uNmIvA9ip68bK/IYyMp1S
 AX51bGSJVZ6Q8IgHkHVOpPFN9Uy4uRf+EWcpoO4JNUDHl7iXS5VKyLUg4sky549V
 XtgtYtFqeZlBK743heDQtEBfcThjFC+WudNeK1og2KQreguSkgVLq8pdgIgpCHuP
 IAkafcLKbc8d4C7FbEHJf60jvOQnrQALABQYmTvvStrXPkuBtvfwakiomO9LBJoG
 RGfYDkjYOWHgIRBtmPX3LxoOIgg2cCZmpA1DgdQJWLDLSX9I/Dn4en4gK8Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba8r6d395-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a08cbeb87eso155591105ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034072; x=1767638872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clGoi7Z2TK6idM7ZzPi9LsVrS6OQOKiMecxLbKuFC7Q=;
 b=j4MlrY2zYIS2hSyC2697CuLdyVEZIiGsKJJ+POre0N9xA/O8Jw1PmjX7NsqTBHA3GD
 f538GKqzA4w09j3VxjJms0n5vR1rxXXPUWSo8DP7qroL6lrEMN9b1H+T4q4PwmaOrLTj
 S7Tv5oo4/bAFWtyJcEaUWIz1FSs0bLfD0fUYEyqrWt1hdNI1gup77GJcYOdE2nbpVDy5
 hjOK1vzXmQrQ4RDjIXUkD6BMq1oQQz7kXk7ecIMUEcGnNFYsXOfLVgEzL39ozMcIPnS1
 44c4ePysHrLWsTWDdUXkfuyXY/jgvd+o1CAohLqmQOyIWTqEpDkRcEfmMid9ZEP1hu3w
 e7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034072; x=1767638872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=clGoi7Z2TK6idM7ZzPi9LsVrS6OQOKiMecxLbKuFC7Q=;
 b=k3pz30oQv3J52vjV54RoLS8dK/URG9Q7diKG/A61n2cRU1mMJnNQm7Ez/lol7TSbqD
 6G+aKcq9W0ZZTyLjdign3cOw1URPziJ+a7+w5l9bcEwmf5dBS8tsbsxYxcSLkgBzgZTb
 pp3H2+AxKKAG7FOvfd0DQrtJevC87+QHNcZmsziDFQvcaesKshpiel82GZjp9WamaHyY
 DN6x2u/ZJgl4LYTc9YmmeqA4ZeFYw9tJFVUy2c35BME9GM0d+w1q+XUBdJP8sQJ0Kuvf
 DpHfZ4AHpJmiB+x5z3s1rX3OwzqhZREEe15ugCbcmeWOzcXXSdBvQk4E8pwcnBWoG+Zc
 ku5w==
X-Gm-Message-State: AOJu0YzXgfpp5/XNo9eeoQEbDPMuDiRKjwVbihkctKNLT2sf30xKpepx
 cFf7RPmqZ11fj6BLmViKsIOnQrsq/26O6MkMEw1/Xq96Op+c8OGQ0+CrfxyWv8Vy/tvtnE+Krt8
 RCrbll2vE3SbkC7yXMW8P7SyHKZcVu/D3pNiq2Nc8a1QS8EkFAIZxOViojUcw63ydcg==
X-Gm-Gg: AY/fxX6TjN7Nh9geLIAIy+rxz8SrCGbaTWifJDoj/fq/szLM6QGRNOx0C8HklqQuLtr
 FtX5Id1P7t84DKbxJuQgRIRFYOAe10EvvQaKWp65AuAyM6ZPRwtQujk3dlxZhtjFXHc1EiDWTSM
 yW2bqM4zfOvDofQEtdxZfjVkP9ET707nfWEYuPVvZJ7JbcpBXXTED2QA2cbJfmiadV2X/+ZkBrq
 Ald9Lo5VQTp/zeg+ZaYw8bCer4GfzOpCDmhs6rDXb5+BQ1v6eexGfB0paWsPqtCg4DqJijejl0/
 aTaGhh9blQjhJr47LTcHYiULktHbvtoc4yVlqcoA1a5+HpMIXaRiCDMUWffdGE2ZAGF46HsSXt6
 CiMktEKzJwmYJqeVELC4JkaFt/wpUgay9X7/vp6/l1CXCQyA=
X-Received: by 2002:a17:902:e950:b0:298:2879:fdf5 with SMTP id
 d9443c01a7336-2a2f2a52b73mr342808875ad.61.1767034071727; 
 Mon, 29 Dec 2025 10:47:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOBgg3mR2zybWUaqOnjQ82VzBr/okLpfzYlPN1Dm8axUq6cFYwtbiu1a+6mLW8jQZBjtIeZg==
X-Received: by 2002:a17:902:e950:b0:298:2879:fdf5 with SMTP id
 d9443c01a7336-2a2f2a52b73mr342808675ad.61.1767034071286; 
 Mon, 29 Dec 2025 10:47:51 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:47:50 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 13/17] hw/riscv/trace: add format2 msg helper
Date: Mon, 29 Dec 2025 15:46:52 -0300
Message-ID: <20251229184656.2224369-14-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
References: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Raidyltv c=1 sm=1 tr=0 ts=6952ccd8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=7Y-KOW0DsKw0bwanU4kA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: YAh3a-9f9qs0qWYmGUTWkI6g38x_zHOb
X-Proofpoint-GUID: YAh3a-9f9qs0qWYmGUTWkI6g38x_zHOb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfXxXV/7edVncmN
 z9zWKdkIEptADJcbQQ3O7AgeZbP+0DLeVuPMDGVz+7ZssNcqFjrTpZ3g2G/4YuX7kQ+KG5sqBV4
 SdNT+CpFOY9VNnSFyKQNz7zT42Z2mARXx22z4/SNZGKqvYuE67emqZh7DHxYImAgOCx0yi7HjXH
 qKBj8itUeN74WUWiZBlPjpUvKUuUae/h7Cs4VL+VY54ptQGpUekULYA+35/KJXLlrz3LGKXT8VN
 UIlQXgkVcC939QAWd9TD6IBesMnteRZijF4uYLeNlVYOX3ol2LczDl2m3hDrbAHKZLMSSEynBM2
 DKIJVlpF/jkEXqs/5dn4VXwvk9/XJW65EOjZ6qUy94yJD09rTnTemeNdqZFbpUV1vF/qq8w3Lbs
 8Yth+0UIjsjM3cLHc3iy87UxzYPQUwkhe470CmM3JWqvtLmcDCyeUx1oBZ2bzxgPMhBYaSjjLjt
 aw4lQ0FbhckIiAhzIBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290172
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Before handling updiscon (uninferable PC discontinuity) cases add the
encoded message we're going to use, format 2. Format 1 will be added
when we add the branch map.

There are design decisions worth documenting in this patch. For irreport,
the e-trace-encap spec [1] in section 7.6. "Format 2 packets",  says that
we should make this bit !updiscon if we're either:

"following a return because its address differs from the predicted return
address at the top of the implicit_return return address stack, or the
last retired before an exception, interrupt, privilege change or resync
because it is necessary to report the current address stack depth or
nested call count."

We do not implement any form of call/return prediction in the encoder,
and TCG will always retire a single insn per cycle. This means that
we'll never set irreport, i.e. irreport will always be equal to
updiscon. If this interpretation turns out to be wrong we'll revisit
this helper.

Likewise, irdepth is also not implemented since we'll always return a
package where irreport == updiscon. The size of the field is arbitrarily
set to '3' to avoid adding padding in the end of the msg to complete an
extra byte.

[1] https://github.com/riscv-non-isa/e-trace-encap/releases/tag/v1.0

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/rv-trace-messages.c | 51 ++++++++++++++++++++++++++++++++++++
 hw/riscv/rv-trace-messages.h |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index db5f7c2d26..2f041aa639 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -19,6 +19,7 @@ typedef enum {
     HEADER_SIZE = 1,
     SYNC_PAYLOAD_SIZE_64BITS = 9,
     TRAP_PAYLOAD_SIZE_64BITS = 18,
+    FORMAT2_PAYLOAD_SIZE_64BITS = 9,
 } RVTraceMessagePayloadSize;
 
 typedef struct RVTraceMessageHeader {
@@ -56,6 +57,16 @@ typedef struct RVTraceTrapPayload {
     uint32_t tvalHigh;
 } RVTraceTrapPayload;
 
+typedef struct RVTraceFormat2Payload {
+    uint8_t format:2;
+    uint32_t addressLow;
+    uint32_t addressHigh;
+    uint8_t notify:1;
+    uint8_t updiscon:1;
+    uint8_t irreport:1;
+    uint8_t irdepth:3;
+} RVTraceFormat2Payload;
+
 static uint8_t rv_etrace_write_bits(uint8_t *bytes, uint32_t bit_pos,
                                     uint32_t num_bits, uint32_t val)
 {
@@ -177,3 +188,43 @@ size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
 out:
     return HEADER_SIZE + header.length;
 }
+
+/*
+ * Note: irreport and irdepth is always == updiscon.
+ *
+ * return_stack_size_p + call_counter_size_p is hardcoded
+ * to 3 since we don't implement neither ATM.
+ */
+size_t rv_etrace_gen_encoded_format2_msg(uint8_t *buf, uint64_t addr,
+                                         bool notify, bool updiscon)
+{
+    RVTraceFormat2Payload payload = {.format = 0b11,
+                                     .notify = notify,
+                                     .updiscon = updiscon,
+                                     .addressLow = extract64(addr, 0, 32),
+                                     .addressHigh = extract64(addr, 32, 32)};
+    RVTraceMessageHeader header = {.flow = 0, .extend = 0,
+                                   .length = FORMAT2_PAYLOAD_SIZE_64BITS};
+    uint8_t bit_pos = 0;
+
+    payload.irreport = updiscon;
+    if (updiscon) {
+        payload.irdepth = 0b111;
+    } else {
+        payload.irdepth = 0;
+    }
+
+    bit_pos += rv_etrace_write_header(buf, header);
+
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 2, payload.format);
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
index f210e048dd..89f30e7d36 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -26,5 +26,7 @@ size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
                                       uint8_t ecause,
                                       bool is_interrupt,
                                       uint64_t tval);
+size_t rv_etrace_gen_encoded_format2_msg(uint8_t *buf, uint64_t addr,
+                                         bool notify, bool updiscon);
 
 #endif
-- 
2.51.1


