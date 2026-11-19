Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53753606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sb1j1/uk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W7tt6O7/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUB9F-0003Vm-Ro; Thu, 19 Nov 2026 18:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUB9C-0003VR-8Z
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:02:31 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUB9A-0001An-98
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:02:29 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1ICk373622
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ziKX5Nh7dHHbXokqq4Vyei4+RcagCspq6GVX+mTB/iU=; b=Sb1j1/ukKlOTAmE2
 aZ98M8tbdbFNjkDLbgOq5MVrk5xjo85CqwAIzv46zfQYN8pkXeGw+Detb8bJlPGs
 xdMrHNI++0lvz9IUWnjMc3X8lDKYcD8pbOSPyLCXT4j7Rx+joG06wcSenYee8wfH
 tK6i6U8wySjjUAGsKobUPp56i7w4JuLEr6s36yMbgy13r8UIqdd+IuLlDELELtVH
 nXAg93SiYUncpfVp7yRgZk8ZZjYRkitrJ21AXKqXmjND+BF5ODMME6a9JFwE2JSn
 wyQUnsXvQ1/X8xHiQu0y4X4M06OHVWtmorfjs2KbUP/mavay2OVhVzSEiUcJMRvS
 XJnJCQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xymkgpm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:02:26 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-836c416b236so5148607b3.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 15:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795129346; x=1795734146; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ziKX5Nh7dHHbXokqq4Vyei4+RcagCspq6GVX+mTB/iU=;
 b=W7tt6O7/oitsV6o/7Z3jJtAK2PLSCBy9kd7gsG78PVl3Yx7srmCWpBXZdtE3Cm9mHt
 jrL7jmeOh25SAtuqvGDiqVZYVYgJpB1Uh8hiP9awaCHvxWmUAQzJNY5qwp0Gj369lCOl
 DwMc+O+FxF1dzyi1hYroyJwn0w+sPq9ga/udAp1ehczG1e1n9tZpEcQ9tM/wnsv/E+V6
 Vq1mn1E4G55VDKGrHASVSyzarfyLmW2SNDt+iZRRvIbvzmwOy4eVCOqBk1xrzma23s0X
 50M9hnHuovYv0Q6gP2693stWoVA74otaI/iD+fDtLWvmW6QmRENPAE8/98VCLWlI0D/y
 kz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795129346; x=1795734146;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ziKX5Nh7dHHbXokqq4Vyei4+RcagCspq6GVX+mTB/iU=;
 b=uK6iVkRxfkEYX24orYwUhcmhy7FsKEADLXTymr+m8mw2Wr5H7QK4XwlxP6cfilPgg7
 Fh9hE3nbQPr4DSAxK4NfrXWyLz8XG0UVprgMWsp+ut+jq/IUi122fRyCBU3G65L83s6W
 iRRpNR6MnMzrJr1fsJ+WOYcgTGaINJIbAkflJSHsCsiOXkQaxlu1BfBVr131TbnLBO1a
 QGS4ADOAw14R0t85zziXo6d6knMQfXtxa6YIc3SpSnFyR9KZUecahFinPshnATFDXNRs
 HCzqXUATvYKq8rbuTI71QMwfeD7pbUBJ0yoyZ8LKbB2/J6Ovjp/QoGx+Fl59ae8MlEyk
 EqUQ==
X-Gm-Message-State: APuU4Z8UAUPQFeWfba47VgQeNT/Tjk16fdvpXj/+HDCr31QQExQp7tZA
 jiDL1DqqpNI3ao+TwBZUesBB0n6ek8PGx7kjWyqR7TCYyYGN+vY/ZQOjhOPN5t7sOyZRgfMHSZI
 ErcxYHot6/X7dpYu5c35OH1ePfXEuRg55y/S0SVJ3MqeSV5Wjkj/CMOYGsHgAe5CFILE/
X-Gm-Gg: AZFdTZfXywK/wE0jFn+AA0amHJqR8Yc8fGbMkCmf+vEWo6ovvXZqlafcecchgszCLEL
 GrhCXiERX+Eg3cwDagiTzcH1TSh7GvniHtCRm2pFgGAJPLMrIwHNYtjNlQxdyDouxlKQNSx7gzm
 Bowys2JN/QFRTS3j5WGJ+zVnuOH89pWB1LyC8r0+35pVY1NGwACRoMGQKhz3imw4Wh/41g2Wro9
 dnj+j/kRoyROEAs+1u3+krffC3D/1KzdBV8wma9vCrUudEw4I+s3UqIwtQImQxGBW3RRhwrAexN
 pw6j/ZnwEz6hIrQQudZPSGjVTVsDaoYDsofZ2exGSMAVPSUSJwNHj5K9K7PDLpG/Me4OaHbRI4+
 5VKg2t0iuez+rNrT3+Ln00xJB1zlDcCJ/bvn82OWySpxAmEYKH9MLdlLwaS/m7CfmP9oOdk9kLx
 BjYGFdGh6gFhX/Fg==
X-Received: by 2002:a05:690c:a:b0:8b1:2db3:b845 with SMTP id
 00721157ae682-8b520435b3emr5101687b3.14.1795129345769; 
 Thu, 19 Nov 2026 15:02:25 -0800 (PST)
X-Received: by 2002:a05:690c:a:b0:8b1:2db3:b845 with SMTP id
 00721157ae682-8b520435b3emr5101417b3.14.1795129345247; 
 Thu, 19 Nov 2026 15:02:25 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf629dsm1923576f8f.9.2026.11.19.15.02.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 15:02:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 2/2] tests/qtest: Execute Xtensa external register instructions
Date: Fri, 20 Nov 2026 00:02:05 +0100
Message-ID: <20261119230205.4744-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119230205.4744-1-philmd@oss.qualcomm.com>
References: <20261119230205.4744-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5MiBTYWx0ZWRfX8Cons3Wcid89
 kv/LrnbpBb0Lp+ccbSAI+fyRb5HUrKxfVOLw4S4n2DeuV7obFNr7tgKX2aRJO1FWK1f2LbusPy+
 tGkSKKCTdwOV0FsmdcDjjNLzNYC0qBw=
X-Proofpoint-GUID: e8tnOk0XsxA-XxszPBgG9Ga_Ie8T951t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5MiBTYWx0ZWRfX0RHqe6cYv1Q2
 MYl7o5Me5jMqA5GjOLPc/NfF6F6Eyorue8zRfaZN0Qx9iZUVm2to4h81Q2X7yEtw94WhpUCq3p2
 hVRTl9u5oImYx5Jvxu1T3XyeuE1Gg9jGXRacImXTn87iG4r+qoGlY/Kyo8eXYb3xOU6cBn8QHqe
 +EgTSFKpe6KUjd8jKnJhf9BHSuFwxpE6em0dyGVtTFPagAQpcDy7+RxPVExblmBj/sYFJqTnbFe
 ly3w4vIG8E1xCfGC6Gtjig7aA28kevU0SBi8dUS7NdNFlyrd/AFP+/SV5ip5o1+iHPs5mXEhi16
 hS/+Efi32Thzy6ktd8rxnmDK2AWkKgsX6HxWYaiwkVkJK6sJ2w1S1996Z52JQavlgraUKRGOf5e
 jhnd+MMUlC7xtR3iEAlKmaf+ZehqQu4vZ7Ai76kMyoyR/1ETogEyjIe5fa4Sv1f417t+/Uh6tLo
 PC++TNe+WnVJz7q5IYg==
X-Proofpoint-ORIG-GUID: e8tnOk0XsxA-XxszPBgG9Ga_Ie8T951t
X-Authority-Analysis: v=2.4 cv=WKPqzXsR c=1 sm=1 tr=0 ts=6aff8002 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=DbhnK5fyqX9BP6mFjmkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190092
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

Run a minimal dc233c ELF that executes RER and WER on an unmapped
external register and then writes a RAM marker. Require the marker
while checking that QEMU stays alive.

The embedded guest covers the missing-operand translation crash
without requiring a cross assembler at test runtime.

AI-used-for: Regression tests
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/qtest/xtensa-extreg-test.c | 81 ++++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |  2 +
 2 files changed, 83 insertions(+)
 create mode 100644 tests/qtest/xtensa-extreg-test.c

diff --git a/tests/qtest/xtensa-extreg-test.c b/tests/qtest/xtensa-extreg-test.c
new file mode 100644
index 000000000000..10fde7461384
--- /dev/null
+++ b/tests/qtest/xtensa-extreg-test.c
@@ -0,0 +1,81 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QTest for the RER/WER (external register) instructions of the dc233c core.
+ *
+ * The core's ISA tables used to describe RER and WER without operands, so
+ * translating them read uninitialised operands and crashed QEMU.  The guest
+ * executes RER then WER on an unmapped external register address, then
+ * writes a marker to RAM, which the test polls.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define MARKER_ADDR 0x100
+#define MARKER_VAL  0x123
+
+/*
+ * Guest ELF, assembled with xtensa-dc233c-elf-gcc (whose assembler has the
+ * same operand-less RER/WER, hence the raw bytes) at the reset vector
+ * 0xfe000000, then reduced to one PT_LOAD segment:
+ *
+ *   _start:
+ *     movi.n a2, 0x40
+ *     .byte 0x30, 0x62, 0x40      # rer a3, a2
+ *     .byte 0x30, 0x72, 0x40      # wer a3, a2
+ *     movi   a4, 0x100
+ *     movi   a5, 0x123
+ *     s32i.n a5, a4, 0
+ *   1: j 1b
+ */
+static const uint8_t xtensa_guest[] = {
+    0x7f, 0x45, 0x4c, 0x46, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x5e, 0x00, 0x01, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0xfe, 0x34, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x34, 0x00, 0x20, 0x00, 0x01, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x54, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0xfe, 0x00, 0x00, 0x00, 0xfe, 0x14, 0x00, 0x00, 0x00,
+    0x14, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00,
+    0x4c, 0x02, 0x30, 0x62, 0x40, 0x30, 0x72, 0x40, 0x42, 0xa1, 0x00, 0x52,
+    0xa1, 0x23, 0x59, 0x04, 0x06, 0xff, 0xff, 0x00,
+};
+
+static void test_extreg(void)
+{
+    g_autofree char *elf = NULL;
+    QTestState *qts;
+    int fd;
+
+    fd = g_file_open_tmp("qtest-xtensa-extreg-XXXXXX", &elf, NULL);
+    g_assert(fd != -1);
+    g_assert_cmpint(write(fd, xtensa_guest, sizeof(xtensa_guest)), ==,
+                    sizeof(xtensa_guest));
+    close(fd);
+
+    qts = qtest_initf("-M sim -cpu dc233c -accel tcg -no-shutdown "
+                      "-kernel %s", elf);
+    unlink(elf);
+
+    /* The harness enforces a timeout; stop if QEMU died */
+    while (qtest_readl(qts, MARKER_ADDR) != MARKER_VAL
+           && qtest_probe_child(qts)) {
+        g_usleep(10000);
+    }
+    g_assert_cmpint(qtest_readl(qts, MARKER_ADDR), ==, MARKER_VAL);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    if (!qtest_has_accel("tcg")) {
+        g_test_skip("TCG not available");
+        return g_test_run();
+    }
+    qtest_add_func("xtensa/extreg", test_extreg);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6e2938d913ef..c0de1df2530f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -328,6 +328,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
    ['k230-ddr-test', 'k230-wdt-test', 'k230-gsdma-test', 'k230-decomp-gzip-test'] : []) + \
    ['milkv-duo-test']
 
+qtests_xtensa = ['xtensa-extreg-test']
+
 qtests_hexagon = ['boot-serial-test', 'hexagon-config-test', 'l2vic-test',
                   'qcom-dsp-test',
                   'qct-qtimer-test']
-- 
2.55.0


