Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1512C606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aCidrase;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q3rDvu10
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrJV-0005ae-D6; Fri, 30 Oct 2026 14:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrJO-0005LF-W5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:26:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrJK-0002OV-VA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:26:44 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHuRAW411176
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vNVWGdOVkLyuYQuMwSc51RTwjflq/O6HmabTzbjht1w=; b=aCidrasexKOOoaHd
 lXbG+FMJlyeY20Ashs0qqBhxvp6MCes87jWU55OTRcixNcd+Dew2DgVI+qHC/FgF
 u1WUcs+ru5JQi6FKpQT8JR/kPiFXW2X7bGwCVsOrw39c+6W956bNV7m83NLghgGW
 BUJm2BAdMF8KJxpBHHxxdWjfkJRsH3qTJD2zjx0m1Xtm57RbI2zfhNghmRo9TJBl
 sU4PaIhaEmJLK6VZBQIeABDpjM1GN7SshIvkNoa5XaoRCf0qN3d443G1rayByXb4
 0eGdPMrYyADht9ndhX4qeMvsNVFzuewZO2/mouWdy6vXrCP/P/biG/WQyNxVfW5/
 wy++EA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qvd6s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:26:41 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-99082f450bfso764208241.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793384801; x=1793989601; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vNVWGdOVkLyuYQuMwSc51RTwjflq/O6HmabTzbjht1w=;
 b=Q3rDvu106asEDkWAXCi6EX5tpXOs3lNky6wk8s7MdYy7XLgpH5vF9XW+FJafVd+UKe
 qhi+cqra53ZbdalI36ZgZLeZm5FkdA97E82fZG7zCjLblZNEUj835nBkqKE/9+sOgcT2
 uLz5p2vSv7RDkJU5er3XWKmTsFoKFHO0yAT4HBdhyx5OJqYO8k2/QYK6qRBqFHT1aDu1
 kPH9m0esiJjQ0UG3vH6WdjJLuAcanIcpS3Nke4MtT/a4a/X+PiWfYmbuohGOZ2wEavQ3
 gCNqlbFK6kWiVirth1phlX4tmm2mfdi5KhIR/lbjdZw13iVhth8dCaVwqLKBsFp/v5HL
 xlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384801; x=1793989601;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vNVWGdOVkLyuYQuMwSc51RTwjflq/O6HmabTzbjht1w=;
 b=VLVxjHmRGsu3ptfH3k3Jw2BWatSv5YfsNOq9P8tCGVP8BMdWbW4O98pH7lnGfN2a4b
 +R1UczpLW9Sa3D32yI60a/PdAS1q5Fe0zDbdPnug+8MyoHdJstG9fwDkmwIfYVd6vdVW
 wI8ACJREC9vcvIBitGIg1ZYTg3lCcWDtFkLfo8QjgPQ0JzrT3izYsb0DVw8Q7sxEkECC
 N2TMX5rA0/r8kyhYrjo4nDILD+kPVkik7hEXMIjwQh/HmsU5fICVLjjzIo2m7NH22I7I
 GeAFH8D1Bsf+YpHGFXTahf88C/+qpyFJeHj/oLTK8RlAdvzb9NoZ072G4GWoo31ZY87L
 S2mg==
X-Gm-Message-State: AFq9FYJgN4t9vgPdLOX4F+UX+Po7vGAJAf5p4bcAWLTlxoEmi7swKHF7
 3vO9T6br52C6oYK/3wzl672oD1jpgOExmNP+6W3T0ksGqXjpOSw7EkdQIn7qKMPWzOBYR7FoCH7
 5TfwUluDX2XcxZ1dw1Tg4ydUElpzEa2+F97j28t+uWwTvnkkIgurbvuXmrn5opcINA4NQ
X-Gm-Gg: AYBFou39d1oEFbXzrDxZ0npfU6NhK2Cr1Ypo82YxQfUwVvKrBvXfD8TnquhLtsPN2zC
 T3+jDWGQ9fRMinHATTqjTg70ijsX627YT51yUx/SRUVGT1yWMpsmtXLpMiLT26bY382hWh4k+eD
 czvFYYmf+Sn3KtcIUA/w70cF1A+52snqr6LUwSTCS8Ldtt4kY/xDeYclCO6HjGcBjPj+vJTs9F+
 MhJCNk2mlUb9nrQFBusV21oI/JqeGPOnIUDsAJVMn8NHM1Wi0S1lo0/dR9f7OKBjh02p07+Y3cJ
 lUbVNDh0OtaktcrVkHMLgf5qGjySw0kzREdNRkJWwAlMaaJVu5yy1dAJe67/XR9aQQktIDwo5DC
 QDnkX7hBlL5p06nIg/61Hjv0qgi9AtBn8WeUlO4paUOQfKt89RA0uQkcfDFAPvYfUcnU55oAOwe
 BGzt3/JfuEtsqgKWTt2LFKvG+LM+TY7g==
X-Received: by 2002:a05:6102:c4f:b0:7cc:3eb0:6ece with SMTP id
 ada2fe7eead31-7d072d53fa3mr1813921137.33.1793384801143; 
 Fri, 30 Oct 2026 11:26:41 -0700 (PDT)
X-Received: by 2002:a05:6102:c4f:b0:7cc:3eb0:6ece with SMTP id
 ada2fe7eead31-7d072d53fa3mr1813909137.33.1793384800718; 
 Fri, 30 Oct 2026 11:26:40 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm4803702f8f.30.2026.10.30.11.26.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 11:26:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 06/12] tests/tcg/mipsel: Add MIPS32R6 multiply tests
Date: Fri, 30 Oct 2026 19:25:39 +0100
Message-ID: <20261030182546.2508-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030182546.2508-1-philmd@oss.qualcomm.com>
References: <20261030182546.2508-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9-jOojpZTS1EkAAwE1UbEIBn0hI_vMXS
X-Proofpoint-ORIG-GUID: 9-jOojpZTS1EkAAwE1UbEIBn0hI_vMXS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX/uQVRaAdY/MF
 Td14nN1TUkiMqXXnhCDV8USiozlqJuhOpfPvCkODmiG8mQmjCsVUJOEpO3s+E3oC+zhCGhy0VGN
 Z4OnPJaMTJ4EmBAwIM5GJeIi3kMX6Yk67L61itUvaEzY4OWb9tTFNcPR7lP7l2cpz9GC3+4pckz
 ZjuZeqVMqePo1LGoUxANBJKGcbMd1tmgfoTu2sAgPb0HX+VM/G0uItpMmUMbo1iJ7jqi4t2ppok
 ZXl5eh9pmNlBL6JLK5SN0kXj0XM0WAiO1Oq17+DjMih5/pePnXcqgEQbgaRLC3UUDTteUKWLZXp
 zO1TELpDgNkyiFqXs1zWW6JDcxccU/94tn9cyOJCpGUqLANtv5IAsr4WwHjGEqzENF3oZIY7+dD
 PLpaczE+U7MMRq8OGxFzGQQ3cHbsbgUgBAQwIOlDx81NVeFZnIrtq7uK4uLTOJBbnRxch3+LB1M
 4kVd5Vnr1z8HxXpPYcw==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae4e161 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ZA5ZHMX5kH83y_G8ek8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX1p8ui6/VIuvL
 HXkYYdjqhxMNqjrGuQdi3suV5z682k5rvZzu4JaP1+0Sjr4cgBeFO965tuR3pptQh9YlPQAXDgN
 q159yyZpzNO6VmBSi12oTdGmbRN2TlQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Test MUL[U] and MUH[U].

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_mips32r6_multiply.c | 75 +++++++++++++++++++++++
 tests/tcg/mipsel/meson.build              |  1 +
 2 files changed, 76 insertions(+)
 create mode 100644 tests/tcg/mipsel/test_mips32r6_multiply.c

diff --git a/tests/tcg/mipsel/test_mips32r6_multiply.c b/tests/tcg/mipsel/test_mips32r6_multiply.c
new file mode 100644
index 000000000000..17106391107a
--- /dev/null
+++ b/tests/tcg/mipsel/test_mips32r6_multiply.c
@@ -0,0 +1,75 @@
+/*
+ * MIPS32R6 tests: multiply instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+
+#include "../include/tap.h"
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
+                TAP_INFO("%s: %08x, %08x: got %08x expected %08x",
+                         name, a, b, res, ref(a, b));
+                fail = 1;
+            }
+        }
+    }
+    return fail;
+}
+
+static int run(const char *name, binary_op_32 op, ref_op_32 ref)
+{
+    int ret = 0;
+
+    ret |= check_op(name, op, ref, b32_pattern, PATTERN_INPUTS_32_COUNT);
+    ret |= check_op(name, op, ref, b32_random, RANDOM_INPUTS_32_COUNT);
+    tap_report(!ret, "MIPS32R6 multiply %s", name);
+    return ret;
+}
+
+int main(void)
+{
+    TAP_START();
+    run("MUL", do_mips32r6_MUL, ref_mul);
+    run("MUH", do_mips32r6_MUH, ref_muh);
+    run("MULU", do_mips32r6_MULU, ref_mulu);
+    run("MUHU", do_mips32r6_MUHU, ref_muhu);
+
+    return tap_done();
+}
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 0c43c31e7355..f540d18b3bd2 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -69,6 +69,7 @@ tests = []
 tests_mips32r6 = [
   'test_mips32r6_bitops.c',
   'test_mips32r6_logic.c',
+  'test_mips32r6_multiply.c',
   'test_mips32r6_shift.c',
 ]
 
-- 
2.55.0


