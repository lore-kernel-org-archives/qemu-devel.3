Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF99606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RpJjw5Mv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VB6ZOSjg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMo8w-0001R2-49; Fri, 30 Oct 2026 11:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo8u-0001Fl-9L
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:03:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo8s-0007Cy-Fv
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:03:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER9CK346925
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xBo1o/3MTJzD5BhQYt4bn566lViAjeBZIdJjcWyJrBM=; b=RpJjw5MvtKQGjdCb
 8liQGN1M9jctAeyecBpztfkKeFOYN70jXvbqPtde07p+pbR3PvQiBBLHEqoojK+u
 +JV87WmHbQV46GY06N+IVTU+KTkt0W6CtYxP+4j/P3vj/+0ie2qSitki4AJLTA1k
 ymGMqleHuaJVzZAFAn9by4E9V/YM1EuzKbcagaee1q+iUUyc84RCVzdqfcnGRdPi
 wTujMjdtnAEHNwWrdvFzd9SEgTwyCmbQh70BwcA5YkJz6T2COI+lZi/r/EQw6tme
 bcfpWkAvHzBApYkyiNTKssnwYYdSSMA8Gy3ruupq4YIp3/SpM35Gh1RbqrBJOn4C
 jcQ3yg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6rkr1c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:03:41 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-98c70917433so720152241.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372620; x=1793977420; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xBo1o/3MTJzD5BhQYt4bn566lViAjeBZIdJjcWyJrBM=;
 b=VB6ZOSjg0bgEDFGKzQht9Utgww3XNLXNQI4JCNZvEmx4CdqchG7HF6dLGYq2HxWGNA
 bCEQK9DQJHfSLHNbtisayqSbAGrB1my2zRIgz9HWlaev+pEt3lH9oit7Tno3fDnwWmCQ
 r8yCEdGAWqx5mkH8OWr3ezFQR7hiPoC4VOmvu+370ysidloVPmetdwy/JvvJWjmBDPur
 BIxaTN8PyOJynNoPr+arm3cTTjl6vBBSEHZ3KYnjto1uAT5Dt98reGy3quVX2yjumxni
 vKrDs+oNpUm4K8bJrOzucYkIY9JkX++yyUZGqL1s5avBSjWinoOhcgTjtd/TRbq6Z71k
 OiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372620; x=1793977420;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xBo1o/3MTJzD5BhQYt4bn566lViAjeBZIdJjcWyJrBM=;
 b=Et6DZGPdgBuF5+d1a1H/qoxq92MrcgTxNzP1Ts7hQbH1HkPD1QHw1sZsao3t+IDl1o
 Hs81sOogUE09KhwDWM/5FxkpcyHWGAt8ux6kQpVClFaJXrGGrQK2+FKzvM4YxtXK4q4d
 JBt8xu4U49My6yKeMFFHjsfswAoNJTimCurZ4uxNtG/JVLt5TqWm7nK4sziEQYJyKCD7
 ywc3bTgOWa5b/jJjHJd4OR2xYNWJxNjKgQTtVREo6SnU8rN0QNeQYjrpGKMcNqEiV/vR
 QEv8ZYuINPsoqWbrN3wMFJkL3342mcrlCnMXRXOONW+CjW/ZGxsXdPLCSnHFrTFeaCpv
 yoKg==
X-Gm-Message-State: AFq9FYIXSuXqjtFrIBmn2dOVqWawWkQZAXvMfesUWEDDyP/ZUxXlfAUZ
 fsVXOceUpoaDnz9VNMvCdAPCRua0Z6crTHQywe72dIjcCyHsHFhRK91tYnaFVBJCpiCkXYtuIE/
 k0X54yigJTmbHW76tPcqjFAVAWAX8py173vjHiqPH5m+6GBHJk1pCig1qgPnylClJQL61
X-Gm-Gg: AYBFou2HrvSKzyT63Os0eXa5p8WwdqxDx58+Ce+aObVfJm4vcxiy4E0b1T6GZ76bYtt
 DG8NuO34WjV1Kz4K5lNd18w1A2L/6WW8/wxxwmpS416PkJ0Jc3bMwJiqFuXjsSJws81IkdTXn7d
 DP8Gttqa5XtoOs2GeFG8w/I47xVEZcJYgYFRVz/r/vqZixEuV9BVIixSFqyux56kAme20UyG5ky
 P8w6iosm95EiQKfMavbClyGV3ck8GJr/exYCPH7Qy5dLfXfUl2Fyreaj6RJe81NMZc2vRo3s+7b
 gsoxNe42jcAXJtehtnEvi1ux0QWDEK7waNxzFlIYxC9hvU3gCc6/93hC4dPC4WnA/xiCK2fk3IE
 6pWb437iNyNchYZ9uc9d2Z/GyXPwH/i6VFac7Vn1EHtJf4kQ13P+6aZIrxw38gZ6TMxPAnGrI/q
 k9BkmxHYxuFXs+OKcYjhZB9QvuCR35SQ==
X-Received: by 2002:a05:6102:809e:b0:7d0:6cf3:d8f0 with SMTP id
 ada2fe7eead31-7d07269b132mr1496031137.18.1793372620075; 
 Fri, 30 Oct 2026 08:03:40 -0700 (PDT)
X-Received: by 2002:a05:6102:809e:b0:7d0:6cf3:d8f0 with SMTP id
 ada2fe7eead31-7d07269b132mr1495839137.18.1793372618054; 
 Fri, 30 Oct 2026 08:03:38 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0b4df257sm35922485e9.4.2026.10.30.08.03.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:03:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/31] tests/tcg/mips: Group Release 6 logic tests
Date: Fri, 30 Oct 2026 16:01:41 +0100
Message-ID: <20261030150202.61556-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p_Xcq3tFsYLfTiL3hc2ipgB-kKXz7u3c
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX3uutEgnK0sgX
 +dro1tgqZGzlJP2VJW+yUPSgYROgJZa4HBE1fzzuYG8vzynppWrS4Ksx8WMlFSE7RpJH1z9GlWP
 JfWojYhz5sN9kYWb6jrKgAgp+EhKYdE=
X-Authority-Analysis: v=2.4 cv=PIqaavqC c=1 sm=1 tr=0 ts=6ae4b1cd cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KuQ5aknWMmF4MApjBakA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX4VOYjIMPPVeo
 6BP199h0ACjObuh9vvjSVkFdsE/0LDsU3GOCzabyWQgU5sockBABUDQ2PwRkgf5uwXZ1m1wdVLC
 EC0jA6hWUE407+7VLGfH59k8PNNQIGM5l464zSVJP8G+TxSeyDTG2K8QzJbCmS5uu3pJnbejiK6
 44Ipz6cAFI8Rq13nTfMBmB/RoTkXtWvHgHGszxgWmATLIOqP6rrruFqlyYj2IhqqAaqe3uwtBFH
 lKRJDIholq0CuFhvDntBqsrdTzSgSYhvNEQksJjrg+ZvKd1PZAGVQxH8Lv1buxyX6UZhPAth9QN
 Uc10RjududM71K14m+7VScKwmbMUBl4I2MWXn1CUPr10hKPFIcdIYp1G4vseD0ESknoGvxJM23/
 NScw223miyLVOBV51IuKfcZ3Jh3Hpnq8uVDOsmWlebU8SqBDFFvDfXInqGdi5IOhJv16/cFtwEF
 5mMc87Dr4ZjABuUuskg==
X-Proofpoint-GUID: p_Xcq3tFsYLfTiL3hc2ipgB-kKXz7u3c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300059
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

Build the 4 per-opcode logic tests as a single executable,
test_mips64r6_logic.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_logic.c | 48 ++++++++++++++++++++++++++
 tests/tcg/mips64/meson.build           |  5 +--
 2 files changed, 49 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/mips64/test_mips64r6_logic.c

diff --git a/tests/tcg/mips64/test_mips64r6_logic.c b/tests/tcg/mips64/test_mips64r6_logic.c
new file mode 100644
index 000000000000..063f2c254d78
--- /dev/null
+++ b/tests/tcg/mips64/test_mips64r6_logic.c
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* MIPS64R6 tests: logical */
+
+#include "../include/tap.h"
+
+#define main test_mips64r6_and
+#include "test_mips64r6_and.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_nor
+#include "test_mips64r6_nor.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_or
+#include "test_mips64r6_or.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_mips64r6_xor
+#include "test_mips64r6_xor.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} r6_tests[] = {
+    { "and", test_mips64r6_and },
+    { "nor", test_mips64r6_nor },
+    { "or", test_mips64r6_or },
+    { "xor", test_mips64r6_xor },
+};
+
+int main(void)
+{
+    unsigned count = sizeof(r6_tests) / sizeof(r6_tests[0]);
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < count; i++) {
+        tap_report(!r6_tests[i].fn(), "MIPS64R6 logical %s",
+                   r6_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 0601ed52ab21..657a1c4d5cc9 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -30,7 +30,7 @@ tests = []
 tests_mips64r6 = [
   '../mips64/test_mips64r6_bitops.c',
   '../mips64/test_mips64r6_crc.c',
-  '../mips64/test_mips64r6_and.c',
+  '../mips64/test_mips64r6_logic.c',
   '../mips64/test_mips64r6_dmuh.c',
   '../mips64/test_mips64r6_dmuhu.c',
   '../mips64/test_mips64r6_dmul.c',
@@ -42,12 +42,9 @@ tests_mips64r6 = [
   '../mips64/test_mips64r6_muhu.c',
   '../mips64/test_mips64r6_mul.c',
   '../mips64/test_mips64r6_mulu.c',
-  '../mips64/test_mips64r6_nor.c',
-  '../mips64/test_mips64r6_or.c',
   '../mips64/test_mips64r6_sllv.c',
   '../mips64/test_mips64r6_srav.c',
   '../mips64/test_mips64r6_srlv.c',
-  '../mips64/test_mips64r6_xor.c',
 ]
 
 foreach src: tests_mips64r6
-- 
2.55.0


