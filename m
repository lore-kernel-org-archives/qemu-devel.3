Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E125606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pManGaQ+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T0ui4gmH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfW7-0007gR-AF; Wed, 21 Oct 2026 19:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfW4-0007e8-Cz
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfW2-00052H-D7
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:40 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKe3GB2748241
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GtCiobWCtFK
 9wCms6GkKM6L2wC39nyV6NvheYNJNBUY=; b=pManGaQ+FSQu9xUhx7TjxbIXWGl
 Fod6N2ma1ngskoeq30vcv0NQ/lP1D6jIwWgAbAkC8wStusZ01IkeX3W422br7w3S
 3+Vyh1AQSH54GPCLrd7JuCjYN4+RhyPE6ldBPmOmude6Nj/PD3+yqargHmZSSkAF
 kPucPlmtVoVp0/d94N/7rBH8AY3QZNFJgy6a53ovGKQdQY3CqJeI227BqXwO769g
 cxbfCAOADc2R1qjvtZspiDEteIDxpBIZBV6pwVdfaCawymos5I0Ves2oJ4fPfzYp
 Hm+7TsJpCa3MsBknTs05BDWKH6WSXei923faWyaElGXUiLAIdnjC1XDf8aQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0ke1h1g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:37 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5364605e74bso32901391cf.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624476; x=1793229276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GtCiobWCtFK9wCms6GkKM6L2wC39nyV6NvheYNJNBUY=;
 b=T0ui4gmHIsXbi7dWJKQaa8OvDpVrcFsrVATjJ1XgIhdwH57BG/FFcLB+xyIZR5Cz3U
 TMB61S/3+s0eUICyxbtCtXqnpxzKizP8fI1V8DwM9S/BTxQMdF+1/at3lGfJfqJ0FFiU
 mpoGh92ZvMORNr1PL7qRINNUUPaSRFP+iGe5SMpX8FoD/IfHhIrabe3ZA9Nd3rVjjOd4
 m1r+skvOItOI/hnDHASt8clH2mtoOQhqDdyw7SFuZoBkIoa7xNCmMGvC16PMk32UI9D6
 MrLsUYFF4tXpnAfgYXnPy/+3neqzWtVT0+j12viO2h9JfY6s3nDKFZNihGICVl7G/Uxi
 JfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624476; x=1793229276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GtCiobWCtFK9wCms6GkKM6L2wC39nyV6NvheYNJNBUY=;
 b=fam2dUxOSEjUWbz5R0ywM8uwb7m0EqZk1ZDin4atdImee19ueIMFuQNoavyqaJcFt/
 U3S2UlEDf6jnK7p8wA8qy1bse6hJG/sSQ+LQ7jV2qP4HQPFfKk4lcetfvrXTDtf6iHCJ
 mdThnu0THAMuvRN/qGk1bC47AlVizgH9D9KpmoVwiW89KOQHWtJozvWot9W4V2K1vAa9
 9b2NdRTOIuAAyNwrOr+gtznpsPtfEmC+/VYkMZw7GQpbh4dJqtCLKjzFxbVPLqB5yphL
 XSjGWWdlmR0hwOPlVPtNYzrimBZ9gEFTU9akRVLIAJ5J/5wxVLYt+pHY2y773+r/qW39
 tGfQ==
X-Gm-Message-State: AFq9FYLQN4LyD17K5T1KdKRoDPIdM/w/Nx8FLUUMGFyE0OTy1IdDa3cM
 /b5raEiBNI4LFxVbM6IYoBv+rHF5nWbjZQR7H0301DpGyS1GiS/7geaDKpvd2/XeykS2ZpIgIIg
 osKj+uWBtSc2J/h7RdxK+4NNznMG1m1EbsGAzKNe8JLWXOjtzE3z6mFWxpMNd9ezewQ==
X-Gm-Gg: AYBFou1D57fMP6vrceApJ8Er2T8Jthegq1KsFeZ5IeS7r3GJWXDjxjzxBsc/ZX5quFs
 oI3XlQIwi/6P7rQR9Dnae6v+uQpcXTqRNxjkBZ9G5N0d5zC7I2s09X6jdadUZrcQiwCpD02DI0y
 p1UTCsuOGrM9Mhp6p41H9Q9lYdxkXNw0P59FNywZNuvDIfy8I7fg5er5MjNwWfs6PQl7cn6Dxt4
 9V8ETIEBri6EhxnCKV1trqrTevFSSI1GSqScny9zC/y9ZhGkcF0k9zXkMZXuVx1ND+vJqJTiuw7
 +xnsM0NIH/n7ENDTbSa6tlQyppdqaZwzr1B4RKNhOKz2xDHvqmDcBgjG5Ktlt8QOxuv1zSoMYDx
 yzNPWHjdwwejjAxReb7gonqbwSXQMsIFhhKtgfxHdNIfwPmlQ84PtTnboLx46f7w1QHP9a9/StQ
 ==
X-Received: by 2002:ac8:5ac4:0:b0:536:1f7a:610e with SMTP id
 d75a77b69052e-5369b5a5426mr60648461cf.6.1792624476014; 
 Wed, 21 Oct 2026 16:14:36 -0700 (PDT)
X-Received: by 2002:ac8:5ac4:0:b0:536:1f7a:610e with SMTP id
 d75a77b69052e-5369b5a5426mr60648121cf.6.1792624475563; 
 Wed, 21 Oct 2026 16:14:35 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:35 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 13/18] hw/riscv/trace: add format2 msg helper
Date: Wed, 21 Oct 2026 20:13:40 -0300
Message-ID: <20261021231346.2452179-14-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cAXzrb2nd37x6IXHM9xgo-jOXRu5t0Gg
X-Proofpoint-ORIG-GUID: cAXzrb2nd37x6IXHM9xgo-jOXRu5t0Gg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX0WKFBNXb3apC
 diAtOfdaz2Uos6jLPN5DARZrdXOxZIdOUGLkcEYP/x1n99WRMOyE2eEOAm5eQ7dKS30u8PCq1W2
 pOM6g1Idz9VlQhTQGLU8+edfbJnOads=
X-Authority-Analysis: v=2.4 cv=KOzPn1Fo c=1 sm=1 tr=0 ts=6ad9475d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=V1jnuoLLAAAA:20
 a=EUspDBNiAAAA:8 a=7Y-KOW0DsKw0bwanU4kA:9 a=dawVfQjAaf238kedN5IG:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX8GDAbTkTGg03
 PN52mqnwN5N0EpeWkfRipTV61c/1+13Yg+LCLsxP5AqHMJZDt6b8L6gY8f7WFLXUY+cZ6rWfwgL
 Ntel2bW7zgdTFojXQQOvHThnZk3FXIbc9Ps8tRCKynjbAo7k2MO2szGe1rvRApSYNxkRwupylUt
 SA2KzemEAfhZnjsi4V5g7tk/BkmWrIqdRRaTX9o/9hJ7Y5PyJEmjzpjay/1vB+4b35Kwb0wx/rd
 2fZI2AZ0nt6x/EZZHH/zIgxSvPic+WpJCRvNRUTUYi3N3npUb3r3Iz7F3DXQEadQUKVUasfUikc
 E9oYQZLY0BphquLlN2QHiM/E/ko1AtdPOX1PpR+9eS2nN6EMmfPF8RQX/Vm2kJWcMGMe0CtX/q3
 BrjLXRAsEQtLsLyTN6WLg/PJyNIwXHCmoPPboolia5wsDmlb8pVwBMrctQqSoTju7z9uxdYRTnP
 xouUoo9L+0BGsuvmx6Q==
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 hw/riscv/rv-trace-messages.c | 59 ++++++++++++++++++++++++++++++++++++
 hw/riscv/rv-trace-messages.h |  2 ++
 2 files changed, 61 insertions(+)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index 7ea1c87fff..83d3436e2e 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -53,6 +53,17 @@ typedef struct RVTraceTrapPayload {
 } RVTraceTrapPayload;
 #define TRAP_PAYLOAD_SIZE_64BITS 18
 
+typedef struct RVTraceFormat2Payload {
+    uint8_t format:2;
+    uint32_t addressLow;
+    uint32_t addressHigh;
+    uint8_t notify:1;
+    uint8_t updiscon:1;
+    uint8_t irreport:1;
+    uint8_t irdepth:3;
+} RVTraceFormat2Payload;
+#define FORMAT2_PAYLOAD_SIZE_64BITS 9
+
 static void rv_etrace_write_bits(uint8_t *bytes, uint32_t bit_pos,
                                  uint32_t num_bits, uint32_t val)
 {
@@ -186,3 +197,51 @@ size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
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
+                                     .updiscon = updiscon};
+    RVTraceMessageHeader header = {.flow = 0, .extend = 0,
+                                   .length = FORMAT2_PAYLOAD_SIZE_64BITS};
+    uint8_t bit_pos;
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
+    rv_etrace_write_header(buf, header);
+    bit_pos = 8;
+
+    rv_etrace_write_bits(buf, bit_pos, 2, payload.format);
+    bit_pos += 2;
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
2.43.0


