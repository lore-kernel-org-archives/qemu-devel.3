Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E97606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mLmqXPca;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WWwVKJmE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUCz-0001bw-3h; Thu, 29 Oct 2026 13:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUBu-0000E9-Sh
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUBs-0003wk-Bq
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:30 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDQVK594522
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wOMSjhWVYPXTJ4Vg1kSzF+Z/jevAVj8TgmyiqQR4LQc=; b=mLmqXPcaTOtCZnhx
 PfV2Th7K80KJbLU6EpobYLmKFv2aqQ0Ds02xMj9eDu8q/lcCUJTCKC/JGswMa9Iu
 0X89yPVtVp0EojPLT4jM7DylAjJiCrS2jsoX5q6ioEqF9q0t4rSDFPnJTdvMTux9
 PCwnFzjz1KClEKCU8eGVFCTOOUXX9z93wu7ZQYYQJP4vRzGWC9VoIWbnnX2Qf5/O
 +fffHwYxM4T4WO2lPab7LtjLSlUd/c9QNBYlf43Do0X0/FY3bcIm4TxRSqWFL9cx
 pd4Ih4pg30UAPJUhZNn7DmQjKovzdQCvxT/2cZje5s9WPPM+h2/3zjzPRzRJ7efD
 VRd46Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3ktgc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:45:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cbf2fd504so405447085a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793295926; x=1793900726; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wOMSjhWVYPXTJ4Vg1kSzF+Z/jevAVj8TgmyiqQR4LQc=;
 b=WWwVKJmE7pNw0Zdj8GxTCxvN38rvELC+bNWfzt6lTBJkI5amqaJzrmhnE+MjtMfpeo
 HaJZquQLsXTbfPNG36iafiamPvo8ADlQEwxtddmGrePZ3hr0mPIb/Huf1sz2ov5jfTp3
 Lyp5FhzbS6jFTyeJj86g0bG1scRV3XYw23KaoHOMFykbjhMnT0ANtcDCBBG4CBjMcSl1
 rlRoA0GHprWvPdDRX4IogDJrXUUGAGgRmpvelFR8EgpECCQ70lAtylsBh6ujk6mJSIlS
 5vKD1RnciAvSTq7zABa+o24qL/PKYUL7tH7lfgeb+Hd63nXkbUK3a0d9xZ8Of8/3aVgt
 ypyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295926; x=1793900726;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wOMSjhWVYPXTJ4Vg1kSzF+Z/jevAVj8TgmyiqQR4LQc=;
 b=cdmLqPBq9LYgcfI/IyT3R5+nZLQ0OzkCyHL2CGjB2AOBQyDiY2/EcpPZxpb3srF3uH
 f8HuaKv8Bw3N0alqLBVLhwmXiC0n/qCvcRY0DmFm1+QZ9jPNatak9AQmMW1G+CFIqwbs
 IHzfGRslONXIAgWXQ7qaj1TtOOnTcbbydybjCTEruGmIXdo1EyPeoVNS5l+5LeJpEgTR
 n3joPOhgUzVCnMc90YXpI6BaEtnkoEMxRoC+9beP2ufYY/iGZraPgWnKpW9qCCQFwnCP
 6iiUMiscRmOqj1IJbLSZK389O0z3TyFEA+Kd/qWju0ySpLRPEGAf0oKx3VXA/0eP+YmC
 MOQQ==
X-Gm-Message-State: AFq9FYKW1nHuZargjnBNNxlAECJHEkjxdAwZxRBQVUaXampld7GjNws1
 jKRugOezPSHFmttDiZBKjUOrmEvFZorET8yFtKrz2LM4IgVpmg6kB9GUBxjgFcA4d+I1x2wXxgk
 QziSp2qNNLlM15iP+PfRflnVQxkjrLW3LY81dKjCAmqCWTrtEsBUVdnjQJquoIgaPIg==
X-Gm-Gg: AYBFou0K8/CYV2TSr/HjwrGK72+Ye0NouNGih0maHbLkQFxHc1IAU7Ws0+SScCYvyc/
 orjFPSbHpcONfTYW14KtQpI3C4EQGPJgnGHNHdFkB6bc4KvQjXovb8mtvZo7NC35OPfffSsZ+Jf
 BunGfPXgjlGfxq+0z6yqfSa87zNIKVUxyCdWiiO6dmX/uT03dDGCW7Nf8UCk5Iffd00p1TRN8+M
 0L7CmgoWTCCfT7oN85FNfE+uAE/QXuNrjigus/5cMDoB/GuLqGAUJiEbfeYYMavSujc2EidjsxQ
 52aXekfj9TsoJdU8ALS5s3vONc5MSMEoHDqXFM9oY5zEoC2P4A0XY7tHIoQc8DM/JwVP0x5/AE6
 N3s2vzymqJdher1NP6eu9NQDWJqHu/Rlq88iq8d5AQq5XQ9q3gF5IbXBMnIwbG//4pZQGltpMgv
 Wn7y4ofTKj8I6MaWkO0SS0HSRBH5wzTA==
X-Received: by 2002:a05:620a:298c:b0:93f:38c7:70f4 with SMTP id
 af79cd13be357-94408aa100cmr950002885a.26.1793295920605; 
 Thu, 29 Oct 2026 10:45:20 -0700 (PDT)
X-Received: by 2002:a05:620a:298c:b0:93f:38c7:70f4 with SMTP id
 af79cd13be357-94408aa100cmr949998685a.26.1793295920165; 
 Thu, 29 Oct 2026 10:45:20 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf751c2d2sm714715e9.15.2026.10.29.10.45.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:45:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 06/12] tests/tcg/mipsel: Add MIPS32R6 multiply tests
Date: Thu, 29 Oct 2026 18:44:27 +0100
Message-ID: <20261029174434.27985-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029174434.27985-1-philmd@oss.qualcomm.com>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX1pwbgO1SdckJ
 zJ+unjaEQuhjLtsz2Ezw03OSqlRBXlX0nkbCeLA0PoDppD6TMnbSuZR0rNrDlS7LRCp5V3e+O0V
 diinCMmgnoNrlH4O7m+ldq0q7U6VGTI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXxubbZE8+I1KX
 yJ840vZWeDUKevA4s1Z6knwcjoc2JraAIXpjtQOLEuZFspv/ngBNrZi4r6o1yfTcBCGmZS53FWS
 hPBLMFeAX2iLS+C+7bSuSzh7fgEiZc678doz60XdHpQz63oPkJWVTHQKtQctDQavjX+7OEprQ6H
 CSkj3GsPHoNUsQqVFRJSe9In3xSPPqr8DICso1fpNLfIA3dwuR8D/7L+e+yBmT8nEm79t7i24cp
 ZSfv6uuGO13X894LraHlkeftQXKrQzI/D881hr69nuWG1IMq73RieMcfpA9AyJPv96vRsWP4zAG
 s+hWQAgRh5Gik2pLwGBWW+EgfAe11VyLSV8iOwpHpVAF+bK7P6LnolqqkSr3t7h8NLsuSCGF7rq
 D7KW6wsWIkPAKcGJjJFXSrl1cfeXhJfq/QkH39wD54K8uEmlwKgTb2GJoQPPx9Bm7wwXfE/CGPf
 +6+n5dfPpM9uk7hoIYA==
X-Proofpoint-ORIG-GUID: yxYAiHI1DnEDGBtC7ffo0yaG1ZZDD7Nc
X-Proofpoint-GUID: yxYAiHI1DnEDGBtC7ffo0yaG1ZZDD7Nc
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae38636 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ZA5ZHMX5kH83y_G8ek8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Test MUL[U] and MUH[U].

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_mips32r6_multiply.c | 79 +++++++++++++++++++++++
 tests/tcg/mipsel/meson.build              |  1 +
 2 files changed, 80 insertions(+)
 create mode 100644 tests/tcg/mipsel/test_mips32r6_multiply.c

diff --git a/tests/tcg/mipsel/test_mips32r6_multiply.c b/tests/tcg/mipsel/test_mips32r6_multiply.c
new file mode 100644
index 000000000000..94c4a3426ba2
--- /dev/null
+++ b/tests/tcg/mipsel/test_mips32r6_multiply.c
@@ -0,0 +1,79 @@
+/*
+ * MIPS32R6 tests: multiply instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+
+#include "../mips/include/wrappers_mips32r6.h"
+#include "../mips/include/test_inputs_32.h"
+
+typedef void (*binary_op_32)(const uint32_t *, const uint32_t *, uint32_t *);
+typedef uint32_t (*ref_op_32)(uint32_t, uint32_t);
+
+static uint32_t ref_mul(uint32_t a, uint32_t b)
+{
+    return (uint32_t)((int64_t)(int32_t)a * (int32_t)b);
+}
+
+static uint32_t ref_muh(uint32_t a, uint32_t b)
+{
+    return (uint32_t)(((int64_t)(int32_t)a * (int32_t)b) >> 32);
+}
+
+static uint32_t ref_mulu(uint32_t a, uint32_t b)
+{
+    return (uint32_t)((uint64_t)a * b);
+}
+
+static uint32_t ref_muhu(uint32_t a, uint32_t b)
+{
+    return (uint32_t)(((uint64_t)a * b) >> 32);
+}
+
+static int check_op(const char *name, binary_op_32 op, ref_op_32 ref,
+                    const uint32_t *input, size_t count)
+{
+    int fail = 0;
+
+    for (size_t i = 0; i < count; i++) {
+        for (size_t j = 0; j < count; j++) {
+            uint32_t a = input[i], b = input[j], res = 0;
+
+            op(&a, &b, &res);
+            if (res != ref(a, b)) {
+                printf("# %s: %08x, %08x: got %08x expected %08x\n",
+                       name, a, b, res, ref(a, b));
+                fail = 1;
+            }
+        }
+    }
+    return fail;
+}
+
+static int run(const char *name, binary_op_32 op, ref_op_32 ref)
+{
+    static int count;
+    int ret = 0;
+
+    ret |= check_op(name, op, ref, b32_pattern, PATTERN_INPUTS_32_COUNT);
+    ret |= check_op(name, op, ref, b32_random, RANDOM_INPUTS_32_COUNT);
+    printf("%s %d - MIPS32R6 multiply %s\n", ret ? "not ok" : "ok", ++count,
+           name);
+    return ret;
+}
+
+int main(void)
+{
+    int ret = 0;
+
+    printf("TAP version 14\n1..4\n");
+    ret |= run("MUL", do_mips32r6_MUL, ref_mul);
+    ret |= run("MUH", do_mips32r6_MUH, ref_muh);
+    ret |= run("MULU", do_mips32r6_MULU, ref_mulu);
+    ret |= run("MUHU", do_mips32r6_MUHU, ref_muhu);
+
+    return ret ? 1 : 0;
+}
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 837b26698e06..9d7cfcf1c6a0 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -90,6 +90,7 @@ tests = []
 tests_mips32r6 = [
   'test_mips32r6_bitops.c',
   'test_mips32r6_logic.c',
+  'test_mips32r6_multiply.c',
   'test_mips32r6_shift.c',
 ]
 
-- 
2.55.0


