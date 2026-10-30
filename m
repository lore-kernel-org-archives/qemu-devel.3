Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32306606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oYBsTUzI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=idUanCwz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrJB-0005B5-9r; Fri, 30 Oct 2026 14:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrJ6-000522-I9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:26:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrJ4-0002Nd-M3
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:26:28 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu2nw839496
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6knj1FqNDjOOPz6rPUgsAINPofFtFMiUO9a4F7H+3+M=; b=oYBsTUzIxt2f4aIt
 ktodsBKeqEFxMGo1scBGGpgng96LrDfRbLdKo+1MQsHaYuEy0CLCIgMWs80s/19L
 HHcCs4nRnEZuFt1yJToYQ0JEua92OERQaONrY/rLEnUHpJ0YDqQu+eY+U/6782bo
 tB9dhECD0zcWRuwWCEIx0YbhAtN6bcYn4dISXVXxl8a6kN9fMuQtoWnHwWVmaTmm
 U8SJVJdNIGuzRFJYPFbKojF/yPsD+Yv/YOUTHnCO7nQY8wYAP7sxBOyT1Kx6wj2M
 HIgW3nN2YBGbROiEB6twIBzd2fB5r2T9rBZ1Z+OxlsVptcqaEu21bYwDaRy7wUB6
 bPHOMQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme754e47-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:26:24 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91becce058aso21341766d6.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793384784; x=1793989584; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6knj1FqNDjOOPz6rPUgsAINPofFtFMiUO9a4F7H+3+M=;
 b=idUanCwzGLY+IlY5Jg8PDU55bcLeok7EljKaGJZ37hIJ5y9nghjIp+fya7S0L7NGIs
 xBBK2l0fFIu4BEhRgJ11SF5T9ymSkVI7BDYVtm2nUnZeM23Bp5zsU0BAxnykTDAltsiF
 5vmj1QOYNzlpAkikpWVUCnE9AfFtGau/HFLTBdwXkRbDYqCA9kANUWsy6H0C4yf0fVOd
 KUONSIvIL4JZfD7I1IyxLIUtQY//iwGN2Jw1y0cJy6TYjKcvR7+RPMhu+lp6bW11mvjq
 xLWBVwCWueuaX2563pcw+PDMIs4Z6sT3ENTmYLPJ60yKonaMmJq1o5uY7++XXo3mvq/q
 vq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384784; x=1793989584;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6knj1FqNDjOOPz6rPUgsAINPofFtFMiUO9a4F7H+3+M=;
 b=RkBycWvpRbXNsJQdI8FCWJdIxStz7Rs7+gn/V3IWY8DPhXnt+NjIxJ77Yl1ejWvTTw
 CYsZ/lRfAuAKISz9P7wVH50N4gDcsBXqrQbZuo2xpVmFK6r3RFuoWQ18BfjKPAibRMdT
 G4dTKpj2WujwJqCFfXRenj2mm4+LFm9yplxRulYgH/8HjNJZhsWDFDruwuXbnHH1VHpa
 wgFzsSR+ZKdW6RReHsB3uP740EZVKik7L39qz+Vyhe/UP2mN+BMvrB084WMYxtv82P27
 EsjXWIz/Hr53erP4RDFz2je3aE9t19hVpmPIAmYYd7xu8DJbI25wpZUSORMTjpw6l7UL
 M3Lg==
X-Gm-Message-State: AFq9FYLlnODAiQLhDCAtxXWlRpp/FLdZ4Ha2mqFouzEzqsvsnMZjplXw
 wdxdCjip6n5s2aDrJ5zbouGANXnARtk6r0baAJFuNzLEfGtYX0uNlMQCIw82k/bYs2i8ASdfU2J
 iC87h93p3LO7f0Bd4CH+pzft0m78Zai6gEmUJjI6pdY2z4bt/yNhVjL292VXWbYoZ0Di8
X-Gm-Gg: AYBFou2tnDN3ZZgs1axDN+7p+qlslbkC/AMjA0Jaa14YZBS/qG8c4D6SGiyDov3v6S0
 GeEHlyhVo1ltyQ9mLK0on6Yz7vnfCrr+/eIKu5vyR0RexXoZ4eS9NpGkvROy96da9qGfOqBKQ86
 cIYdoAbYt2FE0G8jXTVWG4eP2q2QL5T8T/jaF0yke6N9hbZzUzmjZD8vkI0/U4dP309zRekJStr
 ASLGq1OQosQTdtXYsuBDNWu7CKw4aAuJ0Na1oJ7IwbRUKknpv9gdw1+mSGP0o/HGiEFUZRTw/hn
 ehOmA3KW/0Tr6jQspUXLi74IKOk8M5xhBVsI3zxS6b5s9Aar4G66EgEt3YQWPh0Ybxom/JRsJf9
 hF5a5h9hm23U/x+J8l9X1unt1Dj+imr33o85RoJxc1Pia8JcODMEotjV/0hCB18Dy3X9og4foje
 UtVCKMcfVR+6J/Xkb6i8dbNKpgzzx6Tg==
X-Received: by 2002:a05:620a:29d4:b0:93a:82a:71e5 with SMTP id
 af79cd13be357-944216f062fmr521201285a.19.1793384783659; 
 Fri, 30 Oct 2026 11:26:23 -0700 (PDT)
X-Received: by 2002:a05:620a:29d4:b0:93a:82a:71e5 with SMTP id
 af79cd13be357-944216f062fmr521196285a.19.1793384783207; 
 Fri, 30 Oct 2026 11:26:23 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf5b289f7sm76646045e9.5.2026.10.30.11.26.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 11:26:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 04/12] tests/tcg/mipsel: Add MIPS32R6 shift tests
Date: Fri, 30 Oct 2026 19:25:37 +0100
Message-ID: <20261030182546.2508-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030182546.2508-1-philmd@oss.qualcomm.com>
References: <20261030182546.2508-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ys2dUs85ayLiojGZYZNiflKmagJzTtHI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX8QoAFsAz8fdV
 npd48OhBpJuewFQ8KPDM3ovL9p3X/woAeCTPBQ5GMoTHnwJlwei0iSpoxUzlqbjDcuyiR3VM7/s
 /MvN6igNEnm/CTd0OmOfHlS9fLc7CztUeKbde+RioG19/RM6ESPID438Q2rd1llUpfFmnoBp1oL
 o5CE71+Xiz82TKY8oCDz6rxkGVy1Ld5WO16LuAgbs3yJYd6Kq0r6dsvs9p+p6E9xamFarP9BVMC
 ik/oGPPN/3QY1JXQ+iTVHRIPdkldphx2orcwGDOE+a36G6tYglIOvCVCoX/Q0GXD8yP7rU0fUoA
 W9LhWofgGXFyLTq7fAOWvdiIb95zllsnSJCdjw4+WlF90sqIxpbH2F4FhMgHDpPyHkcofDSY9xV
 7Tj2iwQa3Mdh4kWv+7o4kk369TZiXKcQEo/mhfsaVtXlnOiW/nLEZcIhmhbV81/hOXYxS7P4o1i
 O2Rito6toLAuIo2fQ4Q==
X-Proofpoint-ORIG-GUID: ys2dUs85ayLiojGZYZNiflKmagJzTtHI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX5gX3FMOqwxP2
 LWL20x4j8vTfGk0j8HtekA8d4GfuUYzqUyedySXNhRIB2bQtKNYUsKRzq+9NMy2c4qP704j1K3p
 XxedAxHrEoLi4O3FKxq0Wh5yatXAGnw=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae4e150 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=uLWhfN5tPcu-BnL75HQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Test SLLV, SRLV and SRAV.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_mips32r6_shift.c | 73 ++++++++++++++++++++++++++
 tests/tcg/mipsel/meson.build           |  1 +
 2 files changed, 74 insertions(+)
 create mode 100644 tests/tcg/mipsel/test_mips32r6_shift.c

diff --git a/tests/tcg/mipsel/test_mips32r6_shift.c b/tests/tcg/mipsel/test_mips32r6_shift.c
new file mode 100644
index 000000000000..0594796709f3
--- /dev/null
+++ b/tests/tcg/mipsel/test_mips32r6_shift.c
@@ -0,0 +1,73 @@
+/*
+ * MIPS32R6 tests: shift instructions
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
+/* Only the low 5 bits of the shift amount (rs) are used. */
+static uint32_t ref_sllv(uint32_t a, uint32_t b) { return a << (b & 31); }
+static uint32_t ref_srlv(uint32_t a, uint32_t b) { return a >> (b & 31); }
+static uint32_t ref_srav(uint32_t a, uint32_t b)
+{
+    return (uint32_t)((int32_t)a >> (b & 31));
+}
+
+static int check_one(const char *name, binary_op_32 op, ref_op_32 ref,
+                     uint32_t a, uint32_t b)
+{
+    uint32_t res = 0;
+
+    op(&a, &b, &res);
+    if (res != ref(a, b)) {
+        TAP_INFO("%s: %08x, %08x: got %08x expected %08x",
+                 name, a, b, res, ref(a, b));
+        return 1;
+    }
+    return 0;
+}
+
+static int run(const char *name, binary_op_32 op, ref_op_32 ref)
+{
+    int ret = 0;
+
+    /* Value/amount pairs from the input tables. */
+    for (size_t i = 0; i < PATTERN_INPUTS_32_SHORT_COUNT; i++) {
+        for (size_t j = 0; j < PATTERN_INPUTS_32_SHORT_COUNT; j++) {
+            ret |= check_one(name, op, ref, b32_pattern[i], b32_pattern[j]);
+        }
+    }
+    for (size_t i = 0; i < RANDOM_INPUTS_32_SHORT_COUNT; i++) {
+        for (size_t j = 0; j < RANDOM_INPUTS_32_SHORT_COUNT; j++) {
+            ret |= check_one(name, op, ref, b32_random[i], b32_random[j]);
+        }
+    }
+    /* Every shift amount (including ones with ignored high bits). */
+    for (size_t i = 0; i < PATTERN_INPUTS_32_SHORT_COUNT; i++) {
+        for (uint32_t sa = 0; sa < 64; sa++) {
+            ret |= check_one(name, op, ref, b32_pattern[i], sa);
+        }
+    }
+    tap_report(!ret, "MIPS32R6 shift %s", name);
+    return ret;
+}
+
+int main(void)
+{
+    int ret = 0;
+
+    TAP_START();
+    ret |= run("SLLV", do_mips32r6_SLLV, ref_sllv);
+    ret |= run("SRLV", do_mips32r6_SRLV, ref_srlv);
+    ret |= run("SRAV", do_mips32r6_SRAV, ref_srav);
+
+    return tap_done();
+}
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index d64cf50f5a05..3c40a556ad46 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -68,6 +68,7 @@ tests = []
 
 tests_mips32r6 = [
   'test_mips32r6_logic.c',
+  'test_mips32r6_shift.c',
 ]
 
 foreach src: tests_mips32r6
-- 
2.55.0


