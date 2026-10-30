Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6291B606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Slyie1Hu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e7kkE4ce
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoAM-0002Mc-UI; Fri, 30 Oct 2026 11:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo9O-000201-T4
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo9M-0007Ew-7w
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:04:14 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERhUE3207514
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uh7R+WUK65DSoj2eoTgV+wO/P005Serb3BiQpUylYyw=; b=Slyie1Hutuy9J0/G
 hKEqE0Xg7iVdMb9DjZlMASMs93YRBK8yMPJiY47vmQoG0cMR9/z4tIFDIH5a5n3g
 SUW2atCmmTVtKoYhKMwe7G0MBnex+hhqaYGFmdUClaUloQIjboKYSxOveEqe7u5a
 0L0y+baK+YxMW8d9Rocbdsq8b2KrDis7OjlrVeWQVofGB9gpGE4dVE4T8T1wXa6Z
 Ishf/pBkWucqfa+1YOlnLQtpfK//Ms4766Rmhd/2HsdEWYLc/Dy6gRPUGVj0JpcU
 GfLlj4wyFe75IeyTVKg01CTgc/oIo4pHFpN9tG2KqLhTamQ442rqZSJS5DANs7Ow
 deZjiA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkms6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:04:11 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9806756ea40so685322241.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372650; x=1793977450; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uh7R+WUK65DSoj2eoTgV+wO/P005Serb3BiQpUylYyw=;
 b=e7kkE4cesR889fRm2GPL1KBrmZQsazGPBlFmp9isu8DQQqSof3Sh7QLlQDKBy5jiAE
 ED+pedBUhJv99q/lgDccx1NixY3pMFil564sFYD/Vb5v9X6aQBkxH8Enw8+Qo0sAkf4D
 w1TDwcchAQb7xdVJCDYTQTBhmU4jwnT6/71/jLCdr9Pw/91u99t7NzhuVnhraQQyINRm
 Qm1z9bEbsZI9OZNhKaxwE8E6pmgCaBJQwnjxScE423HSbHC2YB8+GBIWBJx86Nv0ZRMa
 ybfWAM1uHNcod6/WDwrcNuaxiIEvFqMcJLfnJsi5nh3EesiTDeNpkwQtp2Om4gYn4fom
 E+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372650; x=1793977450;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uh7R+WUK65DSoj2eoTgV+wO/P005Serb3BiQpUylYyw=;
 b=mXXz3RCZXxWXnkhQ9RKCs/mZR3Y7xIWiz8MFZakzwSi8+t3QRvr2wz95FROotipgJG
 Fr8fGnralSBSN3r98O9+YX06/r56NYLCEOyonUinwKnjRxijBR10RZ7V6T5/8wwHQ/7X
 PFgmDZlbRYrld7EsbCfQfMy+DSidUpVn1ux4aQ6WZB7CdLXHPlf7aD3nZffsaXYo5E6X
 IaD/57ZTrBhkpY1ZXUtZcdu8mOjtXfF0gj7mx5DtL5PcbD5RhL4gQWUc3Sy7nFDivs+N
 eu7WWyKEpHT295Y21E/t3NeDl0uMl0lgSJVyzSpj505zAya7g7VxslSz2ICQJi3QLjvX
 s3JA==
X-Gm-Message-State: AFq9FYK/0A0Z0mL94dqAXv7zC1Uvi/5KPWUEE2rVRxErRfpmLbl0oChB
 0wc64twZ/n6oOF2Lai6skdOX03TFuV0yA7KGJ4aNzlBVgtLIeuACc2UtKQjI7vk+yU4ukH39Wm3
 fFXmFs+poIAj18MXrz2JzSH/MQ4GEWjEdfjh3txVcjT1K8X6RO76GCc7ykDjRZZ3QK5Ng
X-Gm-Gg: AYBFou0XCAEmjWoE8CJx/q972gnfUvFMqgHAAeaz2+uaQ77DziG6jxiyKnAfnBaKlFQ
 BPkMFHLAa/orTCttsTOyt9xEnx54xL/IFbtlZhKO1kylH5ksLgbUMNnWLHgMPMG+7t+K7aPTjqo
 5/DWgrMR2VOMycok35hElqcGt/I8RzzXEaopXipqppSHsXPZyaWXY5/GI+m30ZTnHivpvU/oN5g
 WJBmSNkZ8nVkZfu229S6z4uRTEUJDKkZoTIBgzdSlZiS8TEcqG0ICLjL9HpBITBqgcqdp9PAlRe
 CbQmzkYHpBbziWPJG5WPV+pEo8mnOrFxZPzySkLEG44oK1mLnWA0vjJgSP/HYj24AvpNzVy44mD
 i0kQIhmNjXwEcJuIqLUaH7EU6NYvQsua7kWHUhYhxaf4GZcW950Zbhw+ZP+YEUEd3Mws8PoxW4I
 944BYyPFXrJ7n/XjQ=
X-Received: by 2002:a05:6123:86:b0:5ea:d0b0:e6f1 with SMTP id
 71dfb90a1353d-5ec6871d3ddmr1289947e0c.6.1793372650095; 
 Fri, 30 Oct 2026 08:04:10 -0700 (PDT)
X-Received: by 2002:a05:6123:86:b0:5ea:d0b0:e6f1 with SMTP id
 71dfb90a1353d-5ec6871d3ddmr1289887e0c.6.1793372649419; 
 Fri, 30 Oct 2026 08:04:09 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b723bfsm3583392f8f.15.2026.10.30.08.04.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:04:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/31] tests/tcg/mips: Group MSA bit-count tests
Date: Fri, 30 Oct 2026 16:01:44 +0100
Message-ID: <20261030150202.61556-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae4b1eb cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=MrkvrxfUm_GaFPyPbecA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: -4tYtETqHQOl-PSd57wYf0SyKDIqxwdS
X-Proofpoint-GUID: -4tYtETqHQOl-PSd57wYf0SyKDIqxwdS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX6i3fr0HTnGkY
 Szi5ka77SKvnE5Q0fhlf8f00m2lkn7m8iRH57w/zHpS+SlCD+FaZAeJT9yMvCKKB4Kp40e3RBTj
 YALuT71i4FZ6uAATFz1sZDje13SjJJyt4cU6JSiFJpqqEKv4Tvu8Tup1m7aWDjXsRogBNK3Yx4Z
 O2HOobVVGL9eQmY7JQz+sc3ehITGDKFCH5NdisV85ZWktIg6NJIlIR43m83WYSwR+LgFctYLbij
 /pnZVn+i0NKFPYpYM7XfPHq1dWnat4qHEX0QUwPxTWsg+eeERqBWxAtUQKQIw3z+rzYn9CMYpVy
 dtUyYNKPHgnReR66iQsz1x+LgB6hNTlD02L3FzUNfWh0mAThJ+1PAqx8E0RK/IPwr1rPPbKQEJ6
 71UomtyIyvHRleQUIYibHJZnjSubvcpqze62hsGG59hlE8zQH+w0z/cksZ9mwSM630HPh7vOedH
 uA8i3ub8tbBfKmFOCOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfXxixTF+bCyHW0
 zTthYSeyX+tVpP8YRoTPUUF21GGyHWVK7324jvsXFkkU28WmD3JXLyJrz5S/UoT0aQ2twVaGZ2E
 BLSHO1QX0aLQRbK3s7d+FwIKi0IGZz0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300059
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

Build the 12 per-opcode bit-count tests as a single executable,
test_msa_bit_count.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Prefix the per-instruction summary of test_utils_128.h with '# '
so TAP parsers treat it as a comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/include/test_utils_128.h |  2 +-
 tests/tcg/mips/test_msa_bit_count.c     | 99 +++++++++++++++++++++++++
 tests/tcg/mips/meson.build              | 17 ++---
 tests/tcg/mips64/meson.build            |  2 +-
 tests/tcg/mipsel/meson.build            |  2 +-
 5 files changed, 107 insertions(+), 15 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_bit_count.c

diff --git a/tests/tcg/mips/include/test_utils_128.h b/tests/tcg/mips/include/test_utils_128.h
index 0dd38684cf33..9ba877d84b5c 100644
--- a/tests/tcg/mips/include/test_utils_128.h
+++ b/tests/tcg/mips/include/test_utils_128.h
@@ -59,7 +59,7 @@ static inline int32_t check_results_128(const char *isa_ase_name,
     uint32_t pass_count = 0;
     uint32_t fail_count = 0;
 
-    printf("| %-10s \t| %-20s\t| %-16s \t|",
+    printf("# %-10s \t| %-20s\t| %-16s \t|",
            isa_ase_name, group_name, instruction_name);
     for (i = 0; i < test_count; i++) {
         if ((b128_result[2 * i] == b128_expect[2 * i]) &&
diff --git a/tests/tcg/mips/test_msa_bit_count.c b/tests/tcg/mips/test_msa_bit_count.c
new file mode 100644
index 000000000000..7f965bc9ec4d
--- /dev/null
+++ b/tests/tcg/mips/test_msa_bit_count.c
@@ -0,0 +1,99 @@
+/*
+ * MIPS MSA tests: Bit Count instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_nloc_b
+#include "user/ase/msa/bit-count/test_msa_nloc_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nloc_d
+#include "user/ase/msa/bit-count/test_msa_nloc_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nloc_h
+#include "user/ase/msa/bit-count/test_msa_nloc_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nloc_w
+#include "user/ase/msa/bit-count/test_msa_nloc_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nlzc_b
+#include "user/ase/msa/bit-count/test_msa_nlzc_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nlzc_d
+#include "user/ase/msa/bit-count/test_msa_nlzc_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nlzc_h
+#include "user/ase/msa/bit-count/test_msa_nlzc_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_nlzc_w
+#include "user/ase/msa/bit-count/test_msa_nlzc_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pcnt_b
+#include "user/ase/msa/bit-count/test_msa_pcnt_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pcnt_d
+#include "user/ase/msa/bit-count/test_msa_pcnt_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pcnt_h
+#include "user/ase/msa/bit-count/test_msa_pcnt_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_pcnt_w
+#include "user/ase/msa/bit-count/test_msa_pcnt_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "nloc.b", test_msa_nloc_b },
+    { "nloc.d", test_msa_nloc_d },
+    { "nloc.h", test_msa_nloc_h },
+    { "nloc.w", test_msa_nloc_w },
+    { "nlzc.b", test_msa_nlzc_b },
+    { "nlzc.d", test_msa_nlzc_d },
+    { "nlzc.h", test_msa_nlzc_h },
+    { "nlzc.w", test_msa_nlzc_w },
+    { "pcnt.b", test_msa_pcnt_b },
+    { "pcnt.d", test_msa_pcnt_d },
+    { "pcnt.h", test_msa_pcnt_h },
+    { "pcnt.w", test_msa_pcnt_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Bit Count", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 88d598a4f89b..88ec44520377 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -1,5 +1,10 @@
 tests = []
 
+# MSA tests shared by the mipsel and mips64 targets
+tests_mips_msa_groups = [
+  '../mips/test_msa_bit_count.c',
+]
+
 tests += tcg_tests['multiarch-linux-user']['tests']
 
 tests += {
@@ -93,18 +98,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-divide/test_msa_div_u_w.c',
   '../mips/user/ase/msa/int-divide/test_msa_div_u_h.c',
   '../mips/user/ase/msa/int-divide/test_msa_div_u_d.c',
-  '../mips/user/ase/msa/bit-count/test_msa_pcnt_h.c',
-  '../mips/user/ase/msa/bit-count/test_msa_pcnt_b.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nloc_h.c',
-  '../mips/user/ase/msa/bit-count/test_msa_pcnt_w.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nlzc_h.c',
-  '../mips/user/ase/msa/bit-count/test_msa_pcnt_d.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nloc_d.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nloc_w.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nloc_b.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nlzc_d.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nlzc_w.c',
-  '../mips/user/ase/msa/bit-count/test_msa_nlzc_b.c',
   '../mips/user/ase/msa/int-add/test_msa_addv_d.c',
   '../mips/user/ase/msa/int-add/test_msa_adds_a_h.c',
   '../mips/user/ase/msa/int-add/test_msa_add_a_h.c',
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 894f8e9e23e1..ebb4006e7eb5 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -39,7 +39,7 @@ foreach src: tests_mips64r6
   tests += {src: {'cflags': '-march=mips64r6', 'protocol': 'tap'}}
 endforeach
 
-foreach src: tests_mips_msa
+foreach src: tests_mips_msa + tests_mips_msa_groups
   tests += {
     src: {
       'cflags': ['-march=mips64r6', '-mmsa'],
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 9e446eed0f6e..edb59a25454b 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -40,7 +40,7 @@ endif
 
 tests = []
 
-foreach src: tests_mips_msa
+foreach src: tests_mips_msa + tests_mips_msa_groups
   tests += {
     src: {
       'cflags': ['-mabi=32', '-march=mips32r5', '-mmsa', '-mno-odd-spreg',
-- 
2.55.0


