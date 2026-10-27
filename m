Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E9606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MEG05x8N;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kEr6cbo8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlaQ-000554-51; Tue, 27 Oct 2026 14:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLlaM-000541-TS
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:07:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLlaK-0002n2-LA
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:07:46 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RH04Kq3861779
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aanXSZ4ZWlw6/SJLjxWp0fl/adfElI0z2o4nUFLDfno=; b=MEG05x8NgVNpUf/e
 fqBiJ0c9Dolo8M74If7S4KPQ/ZqblOXL20G/eH8WC1/j/y0xZVbX+iT85isOqj57
 wtEBFDiSxRv4kRx3lYqPqiGKxxrNMGVV8HPp0QhCwyEofZen0X7awQE5QKxxPsJ5
 LtF/XfTUMisFfSJlLRFmi6cgou7CCj0nYdN+McMrAPW0VdPrhFi7Uy4v0rA0NKjl
 eCQ4IU39oQqfTzWHRTfZls8CRaklNXMXYNLpZujtrcnIF1RfXaLh2blawFuQaVTx
 rQglnV172aGq+aFa+8ocOXDdjeOY8le0D86j18mChxfSUfGC5ybK+WYaUcvSkwtH
 6XVTZw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjyjpre1c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:07:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb98809caso9057285a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793124451; x=1793729251; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aanXSZ4ZWlw6/SJLjxWp0fl/adfElI0z2o4nUFLDfno=;
 b=kEr6cbo84mZB9e7sXJJfjMWQ9kNj3b0ie/AgjjUIj8fjQwW3igxdpFd+UV6iWXe2CD
 rn04YvWSvxytooBrgofnHPfmtaQ1ZqyOTyutkEC2nrdxiErb4gbw+40VpW1QUG1+p7LE
 1gKJosDpsyD3LK3c3RX2cYrNV7C1ntx+2QqPwP2P9HDP44w40W3hoWNKOw0SyRLlnHfp
 FBfUzHUgFKtd2WDGf3xYInTT9letfIKS/6YYGLznbNxu7JuSZYbHxaaDO0/rCtnmL84f
 LO3bhFZ5DDW5Eoimol8EA3JSz0L4wbbybpvOYee9+DsQjgFNkxPSwdWzh8/QIwtksGJu
 cBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793124451; x=1793729251;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aanXSZ4ZWlw6/SJLjxWp0fl/adfElI0z2o4nUFLDfno=;
 b=vZxgEVlmTrH082wrwPbYW0ElXvLmecXS1ogTQHIvP61O8z62hECDs/P4qNFCZiPrT+
 QAAgzMDx70EGgz7eFcjdV0+fSNLaRuKRD9lrpN2FY1wPZs2O/in0DrqPJ52L1ScyxSoi
 A6vhmNmqHfe8H0LHkOxoFwOVGS1iAcXekVGFSIE2aXnfL/fVPHnCzPbka2UxKC0qUF7R
 eE30skPnt1NZjI5ISG4ow9cRb6dY3ttaPRRHfHXifL66z3qoi5P49PGm1ymeNlP2Zgd1
 LdjUcD+MthLaFMRDvx96SdUCzS9/iEE6DW/66OF4PEKRu68nxe+3dnGEY8p34/0SLYRd
 Lvjw==
X-Gm-Message-State: AFq9FYK8A6t3jQunULWDJ278tti5Uvge1loCtp2mK1ZHDwkHB8WJnrUC
 OTbAafEBxog+4oIla6emmCgOKZFk4L8xkkM/ic5rpZBvhLSxKp++feH1slF78j4jUUQFE9mr93j
 qoe/S09Js3bmmMBH8njLyl1gURx/svVHrXImrCw1rMoztg/1RcWKXbvjnzrEFuUeM1w==
X-Gm-Gg: AYBFou1JcWUAJTu7lE0iK1no9E9ZevaP8+69gdpJWaQnY+bYdTEbhqKU2LAPzSUiA+R
 fmY5tlM88+k1vQ3yxu7yVHXl1NHiseYoqFMlCQW65kXM/ogUap6rED8VxzVdXNlZ+Tu6cCsMVs1
 HG2MAQWByVbbtgz8wUWr5ZXEMoWbFZutX9OATMwJVue0lyxm9HgL/gjRQiWPoTIYEueT9luLChy
 L1DvEizXqLb/0Yw2AVO8gfM14IoNAEfjnPZVsk1y7rqoSABYURFphGFqZbpilmg4nsmdpLGR6NO
 B8RE4fskOEAsiHhEyYUUV50kqzBv4sKn6F6IAixW0Upo95c2GlwvO7NGuC/WeVDx0lXV5kAnQWY
 s/A6FdYS5Rxp1BD3mPNOj6eq8tiWv8YuYawoIENaRBS8iww4ZLsNk1V+Y
X-Received: by 2002:a05:620a:440d:b0:93f:362a:a893 with SMTP id
 af79cd13be357-940ef90a714mr1587395885a.50.1793124451400; 
 Tue, 27 Oct 2026 11:07:31 -0700 (PDT)
X-Received: by 2002:a05:620a:440d:b0:93f:362a:a893 with SMTP id
 af79cd13be357-940ef90a714mr1587387885a.50.1793124450721; 
 Tue, 27 Oct 2026 11:07:30 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd48eesm24174993f8f.30.2026.10.27.11.07.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 11:07:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/2] accel/tcg: Fix icount accounting on CPU reset
Date: Tue, 27 Oct 2026 19:07:13 +0100
Message-ID: <20261027180713.2386-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027180713.2386-1-philmd@oss.qualcomm.com>
References: <20261027180713.2386-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX7Q8CHP/itgRP
 myg2X2LfwO/roIQBvPco22+Zo8kSgqvBoDR+wOSteGFANlN/HkHP/VGDAidpg9B0t5XqbdgUuHr
 U+Nx2gbfdHM/5jGV0FWr0SNDg82KoaWK38340OoiHlXpd5h4D9KSsw+DuQaIeO8meWNh36IGbXF
 ChSAowDIlFEBEcv0ppGtzct1DYKp+SxqCfX+tdpl1YlfBQMrMRIuhk/1Y60+6H4jXIEIgKHFfmf
 Q1g5aNN3Q8QxoFYSHRYQ9CMy070r3HQ7EnLcCBD5IW5uEhJx8A8mfwIfCl9b76Lp3eeNkPv3mlF
 CbHp5pqkPLh7/v3NV0b20J8FUtsdFoS9lkBz6CCZ0x5pLwlevcySyfKvDCsXemSMOS2BsGRtmk4
 dZIAtoX7dsB/L+nD1hkFRWukwj7JZtPfXrl47F1i48mD8WXHaonJN3U0Y0MxWdow7TkqaHOD8Ow
 wXHFjEuRkkSrInJ6dRA==
X-Proofpoint-ORIG-GUID: KWzRepRkJ48e0bHCwxNZ5ETNI2iuqxYY
X-Proofpoint-GUID: KWzRepRkJ48e0bHCwxNZ5ETNI2iuqxYY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX5Dezq/XPJhNx
 QudMsjSf6rOhKmSxi5DRjq90SKF4frG3/DoGqKYOHUVTx9HuMV8DXkSyn4jIJPQ2sklgNFlbLPf
 KFEPuvba9uveB5QPAj9YmkWNLgLxWNc=
X-Authority-Analysis: v=2.4 cv=JodkP84C c=1 sm=1 tr=0 ts=6ae0e864 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=YNFDnrtNBzGGhpLi9QgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270072
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

A CPU reset from cpu_exec() clears the remaining icount budget,
causing it to be counted as executed and advancing virtual time.

x86 INIT exposes this as a large TSC jump during AP startup.

Account executed instructions before reset and discard the unused
budget. Add an x86 qtest covering INIT/SIPI through x2APIC.

AI-used-for: qtest reproducer
Fixes: e4cd96571f00 ("cpus: don't credit executed instructions before they have run")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/tcg/icount-common.c     |  10 +++
 tests/qtest/icount-x86-test.c | 119 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   2 +
 3 files changed, 131 insertions(+)
 create mode 100644 tests/qtest/icount-x86-test.c

diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index 4c8ceafc112b..45aadf1416d9 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -106,6 +106,16 @@ void icount_update(CPUState *cpu)
 
 void icount_cpu_reset(CPUState *cpu)
 {
+    if (qemu_cpu_is_self(cpu)
+            && qatomic_read(&cpu->running)
+            && cpu->icount_budget) {
+        /*
+         * Account the instructions executed so far and discard the
+         * unused part of the current budget before the counters are cleared.
+         */
+        icount_update(cpu);
+        cpu->icount_budget = 0;
+    }
     cpu->icount_extra = 0;
     qatomic_set(&cpu->neg.icount_decr.u32, 0);
 }
diff --git a/tests/qtest/icount-x86-test.c b/tests/qtest/icount-x86-test.c
new file mode 100644
index 000000000000..1138a7535e7c
--- /dev/null
+++ b/tests/qtest/icount-x86-test.c
@@ -0,0 +1,119 @@
+/*
+ * QTest testcase for TCG instruction counting.
+ *
+ * Copyright Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define AP_VECTOR       0x01
+#define DONE_ADDR       0x50c
+#define TSC0_ADDR       0x504
+#define TSC1_ADDR       0x508
+#define ITER_ADDR       0x510
+#define AP_FLAG_ADDR    0x600
+
+/*
+ * The BSP reads the TSC, sends INIT and SIPI to the AP and spins until
+ * the AP sets a flag, counting iterations.  The AP then halts.
+ */
+static const uint8_t x86_init_sector[] = {
+    /* mov $0, %ax; mov %ax, %ds */
+    0xb8, 0x00, 0x00, 0x8e, 0xd8,
+    /* AP code at AP_VECTOR << 12: movb $1, flag; cli; 1: hlt; jmp 1b */
+    0xc7, 0x06, 0x00, 0x10, 0xc6, 0x06,
+    0xc7, 0x06, 0x02, 0x10, AP_FLAG_ADDR & 0xff, AP_FLAG_ADDR >> 8,
+    0xc7, 0x06, 0x04, 0x10, 0x01, 0xfa,
+    0xc7, 0x06, 0x06, 0x10, 0xf4, 0xeb,
+    0xc6, 0x06, 0x08, 0x10, 0xfd,
+    /* mov $MSR_IA32_APICBASE, %ecx; rdmsr; or $EXTD, %eax; wrmsr */
+    0x66, 0xb9, 0x1b, 0x00, 0x00, 0x00, 0x0f, 0x32,
+    0x66, 0x0d, 0x00, 0x04, 0x00, 0x00, 0x0f, 0x30,
+    /* xor %esi, %esi; rdtsc; mov %eax, tsc0 */
+    0x66, 0x31, 0xf6,
+    0x0f, 0x31, 0x66, 0xa3, TSC0_ADDR & 0xff, TSC0_ADDR >> 8,
+    /* mov $ICR, %ecx; mov $1, %edx; INIT, then SIPI */
+    0x66, 0xb9, 0x30, 0x08, 0x00, 0x00,
+    0x66, 0xba, 0x01, 0x00, 0x00, 0x00,
+    0x66, 0xb8, 0x00, 0x45, 0x00, 0x00, 0x0f, 0x30,
+    0x66, 0xb8, AP_VECTOR, 0x46, 0x00, 0x00, 0x0f, 0x30,
+    /* 1: inc %esi; cmpb $0, flag; je 1b: three instructions */
+    0x66, 0x46,
+    0x80, 0x3e, AP_FLAG_ADDR & 0xff, AP_FLAG_ADDR >> 8, 0x00,
+    0x74, 0xf7,
+    /* rdtsc; mov %eax, tsc1; mov %esi, iterations; done = 1 */
+    0x0f, 0x31, 0x66, 0xa3, TSC1_ADDR & 0xff, TSC1_ADDR >> 8,
+    0x66, 0x89, 0x36, ITER_ADDR & 0xff, ITER_ADDR >> 8,
+    0xc6, 0x06, DONE_ADDR & 0xff, DONE_ADDR >> 8, 0x01,
+    /* cli; 1: hlt; jmp 1b */
+    0xfa, 0xf4, 0xeb, 0xfd,
+};
+
+static char *write_boot_disk(void)
+{
+    size_t image_size = 0x7e000;
+    g_autofree uint8_t *image = g_malloc0(image_size);
+    char *path = g_strdup("/tmp/qemu-icount-XXXXXX");
+    ssize_t written;
+    int fd;
+
+    memcpy(image, x86_init_sector, sizeof(x86_init_sector));
+    image[0x1fe] = 0x55;
+    image[0x1ff] = 0xaa;
+
+    fd = mkstemp(path);
+    g_assert_cmpint(fd, >=, 0);
+    written = write(fd, image, image_size);
+    close(fd);
+    g_assert_cmpint(written, ==, image_size);
+    return path;
+}
+
+static void wait_for_done(QTestState *qts)
+{
+    for (unsigned i = 0; i < 5000; i++) {
+        if (qtest_readb(qts, DONE_ADDR)) {
+            return;
+        }
+        g_usleep(1000);
+    }
+    g_assert_not_reached();
+}
+
+static void test_x86_pc_x2apic_fdc(void)
+{
+    g_autofree char *disk = write_boot_disk();
+    QTestState *qts;
+    uint32_t iterations;
+    uint32_t delta;
+
+    qts = qtest_initf("-M pc -m 16M -smp 2 -accel tcg -icount shift=0 "
+                      "-cpu max,x2apic=on,tsc-frequency=1000000000 "
+                      "-drive if=floppy,format=raw,file=%s", disk);
+    wait_for_done(qts);
+
+    delta = qtest_readl(qts, TSC1_ADDR) - qtest_readl(qts, TSC0_ADDR);
+    iterations = qtest_readl(qts, ITER_ADDR);
+    g_test_message("TSC delta %u, %u iterations", delta, iterations);
+    g_assert_cmpuint(iterations, >, 0);
+    g_assert_cmpuint(delta, >=, 3 * iterations);
+    g_assert_cmpuint(delta, <=, 3 * iterations + 32);
+
+    qtest_quit(qts);
+    unlink(disk);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    if (qtest_has_accel("tcg") && qtest_has_machine("pc")) {
+        qtest_add_func("/icount/x86-pc-x2apic-fdc",
+                       test_x86_pc_x2apic_fdc);
+    }
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 46685d6d46fd..d7ae09313e32 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -57,6 +57,8 @@ qtests_filter = \
   (get_option('default_devices') and host_os != 'windows' ? ['test-filter-redirector'] : [])
 
 qtests_i386 = \
+  (config_all_devices.has_key('CONFIG_I440FX') and
+   config_all_devices.has_key('CONFIG_FDC_ISA') ? ['icount-x86-test'] : []) +                  \
   (slirp.found() ? ['pxe-test'] : []) + \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_ACPI_VMGENID') ? ['vmgenid-test'] : []) +             \
-- 
2.55.0


