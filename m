Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A38606A331
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OOU5FLRV;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Cx8p9aML
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmE1-0006MX-Nx; Fri, 13 Nov 2026 03:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xRmDi-0005w0-AJ
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:01:20 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xRmDf-0000ZD-1i
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:01:14 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD57FD31973367
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AHV4vYsXjFO
 W2ZBAI8aGhqhQdaObOzr07sPQSd+lZ58=; b=OOU5FLRVeyL0p+wpkZAMEwzHgmH
 q0SRn2VyqtJfwxNvTRTeQ1HBouyL6EL6i5DqNjtA4kRp3N3x8WQPKH4BHGcGY3Xq
 1hCxcn9gAyj2apA/msLgYWM4JaDHIUCAbKugO5WrauuTr0RdsKtBYKizWN9GcUZS
 GeYt5fkcmS/OLaOOP61DpDrRsGEhAB2LXGK9wvyO1yVPn5NRjQGh0HNSRbs1WTtp
 qNIB+2bvX2UyJx5P9YFyVlPSaamCgEQ4rHdtbHh2XJ998UXx1d+pe/a+pIzxzYKh
 j9+cIh1yclIZndukd/Ea/uG85VmiHBSey9ruhHvEfKdazgngc+OehXev6mQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwg1bb487-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:01:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36db182e57dso64103eec.2
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 00:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794556865; x=1795161665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AHV4vYsXjFOW2ZBAI8aGhqhQdaObOzr07sPQSd+lZ58=;
 b=Cx8p9aMLNlEiQ+g2o/2UhlHQIc0PoSv1yt0b0p3zUK45xOjSb7KlwIFMb7pLe1YWtR
 aZ6e7W/ozIqWxtrXX6IGKfz8CcHYoHgQxdgzzILVPjeCOpNim6iNiGj8n2Qu/mnxY6Q7
 d3hme6+ywmMtdwEKm+MkBDSlY1D1ei/pm9osQ8GG5R6HSQyPOchz9cB+bhTzQj3WjDU5
 JpE5+0NLgf17g6GwNfNnZpKZoFlBQQ2vM+g3l5UpZ9jcdNM5ww3gXl6QO0eZSzw7eU59
 0auH9vIBjT6UTzlY+Q6Uuq6S8QuZYQEvML2v9Ec+XPpAgy11DKoLwlpKxeVqZsH4qPXQ
 llTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794556865; x=1795161665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AHV4vYsXjFOW2ZBAI8aGhqhQdaObOzr07sPQSd+lZ58=;
 b=GH0ERp6Gd0bX6AUd2Z4wtBtourrNBGXy25Veuge5v4Nn4uR4bRc/e7MSpiH3CXJb1N
 oYclOUm/or8WsDhjyaE+P/Ci40v9PnFc6JzSlWHFvQk7ot4tTQPywITFoozAoZsgiGtH
 F3Sli7QcmMaAh1OumCjkDccVK5fVna82kW+bVTTlfmqgz0EWTO69pg1SpfknkhNRf2Cn
 6V/2fWPBQfj+yGS275PpVzvq7qqpenu1CYAjeIZYfW/hPYbXFBtMFnHn92lN3sQ6gaCt
 OhV206Yfbwh9K2pilAzw3i9KOqRYQ0njrP1OaBBC4iJMAvNnIpHgH+8ewX6W2riideYN
 4h2w==
X-Gm-Message-State: APuU4Z9PpY7msLbDjLCYB9hbgwW0D0spKE6LRXMawERUWLm9aBsvk58/
 8N6sKjIf4HIEHnzuP/tflS1pLuiLc5f57ZCFHnfYTbV6a0enkAtZI9Siz6qlhqdF7EGl7tAfdFy
 tJyErZP1CGWnloL9dH0D0ds5ckY260asGnj1zxoRs38W1zew/ga9wrERNP43nOOxhMg==
X-Gm-Gg: AYBFou1t1DMlWIVnfNkmtg+l5cF+JUVT9fBv5ltOzbksKBVEXF8fMFI4qOxHVor2CtU
 +pwTtLi6GF3yS4jZw+l4TGllvK/gIlRejZ4SgZGLfEeW5bSOgXy9P3uAr0Vbr0jfvV473Hl4wSo
 zgPlZMMrMZO/h+t72k25Ihc2ZhMTGMUxjc440XIvChw/2tj3WcGZAwqowZ+yjn/GlXhpa84C70P
 TawnoTi4o34NC4RmlWJUUJbdobjgDVwzYFmkrd/SCDFU/CqYl2bQmXuwMUJk9XC8C998byMqdzU
 FDuCyf1iA/R549B0hGjdLMLFRWMbytP3423yNryanqnurZJBWTLa6BPSHiRUefuDDMReBiWlsII
 0JYVK+/N3KIKQGOcdKzhJvIbICm7dZ90/cCpRTLDn4M7+LxNdBO43n+nPIIeaLViRAAycO2BH0S
 wu/PgMXAQHLXwgfteq+s2d7P79j+j0vGYJtlmCW/ZiGXXl5n2YbhBP7el6Vys4lR640ZknS4sJR
 fbjybk=
X-Received: by 2002:a05:701b:4516:10b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-1b50308b4d3mr2831421c88.1.1794556864300; 
 Fri, 13 Nov 2026 00:01:04 -0800 (PST)
X-Received: by 2002:a05:701b:4516:10b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-1b50308b4d3mr2831349c88.1.1794556863444; 
 Fri, 13 Nov 2026 00:01:03 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b2519sm4642645c88.13.2026.11.13.00.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 00:01:03 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 2/2] tests/qtest: cover server reference platform RPMI
Date: Fri, 13 Nov 2026 13:30:38 +0530
Message-ID: <20261113080038.720571-3-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113080038.720571-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261113080038.720571-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6Q+0h9l c=1 sm=1 tr=0 ts=6af6c3c1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=_oFLYzT9Zv2iLU5R4CcA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: anEBPxjiVCI1XDaJXjYyhy0Ij6QFP8hn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfXzyxyqOnmE6xc
 Kxq3YKjUcWw4FD3Qi2pkSNUhArp6cnTR/cn4VNjfbiGVImKxQ/twg28wjyAhnFZAMO3rVwnZs15
 w7h33LkjW+U+NX3fPqhOfYEmzlOUdwAQnkHMVn9QupegGhYtNc+Wg33zuAld+2Xcdde4NHBrtm6
 19EzT6KvixvVHE1CSW6mInE+llzJMuDjlx+PqDKSoy3dPyVQ1eRHMFEcb/Q4MsJWO7R1Zx9lreQ
 vgm5fZS8DcNS/GCH25D+qcFvo55zeVuVQaA7+AuUkOxwzXATtFgYgNyDEinafE3kp5suxbwCwHe
 LQwXu3FDtIgmnNLCoTNgQTeuwjqnXwz+XhIWeO5NPuL6MTEB4EwdisJ7CMbAXlMkw9BOdD5R5WB
 yBnrYkf5Qo7GXSKQke6N1yNLbq3IoOXCUKjsJW+uQvKt6kivKXLaRWshY7RswPChQW6D0h7txnE
 5BshgownXR+cehVRAZQ==
X-Proofpoint-ORIG-GUID: anEBPxjiVCI1XDaJXjYyhy0Ij6QFP8hn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfXze5hDQLWyOrq
 IYV0HcIVHtx0vRuf+09nPR/L+yGTraUsw7H5CSLqLK68w48Jp1puqoCEuY2O++ZmBG9VL4URCs2
 XY9bzAbfGKxPwvvjiBGjc2151Rb7N+0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130031
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Exercise the server-reference RPMI policy alongside the shared
protocol tests. Cover explicit and default RPMI-off realization,
RPMI-on service discovery, FDT layouts, and migration behavior for
both property states.

The FDT checks verify mailbox phandles, service IDs, sibling
placement, and preservation of the legacy syscon nodes when RPMI is
disabled.

The RPMI-off migration check is a policy smoke test that verifies
command acceptance only; it does not restore a destination VM.

Use per-machine queue sizes in the shared protocol harness so
the enlarged virt queues and existing server queues both retain
correct acknowledgement offsets and ring wraparound.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 tests/qtest/riscv-rpmi-test.c | 430 ++++++++++++++++++++++++++--------
 1 file changed, 334 insertions(+), 96 deletions(-)

diff --git a/tests/qtest/riscv-rpmi-test.c b/tests/qtest/riscv-rpmi-test.c
index 0831322e24..d8c59078bf 100644
--- a/tests/qtest/riscv-rpmi-test.c
+++ b/tests/qtest/riscv-rpmi-test.c
@@ -16,13 +16,16 @@
 
 #define RPMI_SHMEM_BASE 0x10200000ULL
 #define RPMI_DOORBELL_BASE 0x10230000ULL
+#define RVSERVER_RPMI_SHMEM_BASE 0x110000ULL
+#define RVSERVER_RPMI_DOORBELL_BASE 0x140000ULL
 #define RPMI_SLOT_SIZE 64
-#define RPMI_QUEUE_SIZE 0x7800
-#define RPMI_QUEUE_DATA_SLOTS (RPMI_QUEUE_SIZE / RPMI_SLOT_SIZE - 2)
+#define RPMI_VIRT_QUEUE_SIZE 0x7800
+#define RPMI_RVSERVER_QUEUE_SIZE 0x400
+#define RPMI_QUEUE_DATA_SLOTS (rpmi_queue_size / RPMI_SLOT_SIZE - 2)
 
-#define RPMI_A2P_HEAD RPMI_SHMEM_BASE
-#define RPMI_A2P_TAIL (RPMI_SHMEM_BASE + RPMI_SLOT_SIZE)
-#define RPMI_A2P_SLOT0 (RPMI_SHMEM_BASE + 2 * RPMI_SLOT_SIZE)
+#define RPMI_A2P_HEAD rpmi_shmem_base
+#define RPMI_A2P_TAIL (rpmi_shmem_base + RPMI_SLOT_SIZE)
+#define RPMI_A2P_SLOT0 (rpmi_shmem_base + 2 * RPMI_SLOT_SIZE)
 
 #define RPMI_SRVGRP_BASE 0x0001
 #define RPMI_SRVGRP_SYSTEM_RESET 0x0003
@@ -61,53 +64,70 @@
 #define RPMI_HSM_TEST_START_ADDR 0x80000000ULL
 #define RPMI_HSM_TEST_RESUME_ADDR 0x80001000ULL
 
-#define RPMI_P2A_ACK_BASE (RPMI_SHMEM_BASE + RPMI_QUEUE_SIZE)
+#define RPMI_P2A_ACK_BASE (rpmi_shmem_base + rpmi_queue_size)
 #define RPMI_P2A_ACK_HEAD RPMI_P2A_ACK_BASE
 #define RPMI_P2A_ACK_TAIL (RPMI_P2A_ACK_BASE + RPMI_SLOT_SIZE)
 
+typedef struct RiscvRpmiQTestMachine {
+    const char *machine_opts;
+    uint64_t shmem_base;
+    uint64_t doorbell_base;
+    uint32_t queue_size;
+    const char *platform_info;
+    const char *reset_node;
+    const char *poweroff_node;
+} RiscvRpmiQTestMachine;
+
+static const RiscvRpmiQTestMachine virt_rpmi_machine = {
+    .machine_opts = "virt,rpmi=on",
+    .shmem_base = RPMI_SHMEM_BASE,
+    .doorbell_base = RPMI_DOORBELL_BASE,
+    .queue_size = RPMI_VIRT_QUEUE_SIZE,
+    .platform_info = "QEMU RISC-V virt RPMI",
+    .reset_node = "/reboot",
+    .poweroff_node = "/poweroff",
+};
+
+static const RiscvRpmiQTestMachine rvserver_ref_rpmi_machine = {
+    .machine_opts = "riscv-server-ref,rpmi=on",
+    .shmem_base = RVSERVER_RPMI_SHMEM_BASE,
+    .doorbell_base = RVSERVER_RPMI_DOORBELL_BASE,
+    .queue_size = RPMI_RVSERVER_QUEUE_SIZE,
+    .platform_info = "QEMU RISC-V server-ref RPMI",
+    .reset_node = "/reboot",
+    .poweroff_node = "/poweroff",
+};
+
+static const RiscvRpmiQTestMachine rvserver_ref_legacy_machine = {
+    .machine_opts = "riscv-server-ref,rpmi=off",
+    .shmem_base = RVSERVER_RPMI_SHMEM_BASE,
+    .doorbell_base = RVSERVER_RPMI_DOORBELL_BASE,
+    .queue_size = RPMI_RVSERVER_QUEUE_SIZE,
+    .platform_info = "QEMU RISC-V server-ref RPMI",
+    .reset_node = "/reboot",
+    .poweroff_node = "/poweroff",
+};
+
+static const RiscvRpmiQTestMachine rvserver_ref_default_machine = {
+    .machine_opts = "riscv-server-ref",
+    .shmem_base = RVSERVER_RPMI_SHMEM_BASE,
+    .doorbell_base = RVSERVER_RPMI_DOORBELL_BASE,
+    .queue_size = RPMI_RVSERVER_QUEUE_SIZE,
+    .platform_info = "QEMU RISC-V server-ref RPMI",
+    .reset_node = "/reboot",
+    .poweroff_node = "/poweroff",
+};
+
+static uint64_t rpmi_shmem_base = RPMI_SHMEM_BASE;
+static uint64_t rpmi_doorbell_base = RPMI_DOORBELL_BASE;
+static uint32_t rpmi_queue_size = RPMI_VIRT_QUEUE_SIZE;
 static uint64_t rpmi_response_base;
 
-static uint64_t rpmi_queue_slot(uint64_t queue_base, uint32_t index)
-{
-    return queue_base + (index + 2) * RPMI_SLOT_SIZE;
-}
-
-static void rpmi_send_request(QTestState *qts, uint16_t service_group,
-                              uint8_t service_id, uint8_t request_type,
-                              const uint32_t *data, size_t data_words)
-{
-    uint32_t tail = qtest_readl(qts, RPMI_A2P_TAIL);
-    uint64_t slot = rpmi_queue_slot(RPMI_SHMEM_BASE, tail);
-    size_t i;
-
-    qtest_writew(qts, slot, service_group);
-    qtest_writeb(qts, slot + 2, service_id);
-    qtest_writeb(qts, slot + 3, request_type);
-    qtest_writew(qts, slot + 4, data_words * sizeof(*data));
-    qtest_writew(qts, slot + 6, RPMI_TOKEN);
-
-    for (i = 0; i < data_words; i++) {
-        qtest_writel(qts, slot + 8 + i * sizeof(*data), data[i]);
-    }
-
-    g_test_message(
-        "RPMI_A2P_REQ shmem=0x%016" PRIx64 " doorbell=0x%016" PRIx64
-        " group=0x%04x service=0x%02x type=0x%02x data_len=%zu"
-        " token=0x%04x a2p_tail=%u slot=0x%016" PRIx64,
-        (uint64_t)RPMI_SHMEM_BASE, (uint64_t)RPMI_DOORBELL_BASE,
-        service_group, service_id, request_type, data_words * sizeof(*data),
-        RPMI_TOKEN, tail, slot);
-
-    qtest_writel(qts, RPMI_A2P_TAIL, (tail + 1) % RPMI_QUEUE_DATA_SLOTS);
-    qtest_writel(qts, RPMI_DOORBELL_BASE, 1);
-}
+static QTestState *rpmi_qtest_init(const RiscvRpmiQTestMachine *machine,
+                                   const char *extra_args);
 
-static uint32_t rpmi_response_word(QTestState *qts, unsigned int word)
-{
-    return qtest_readl(qts, rpmi_response_base + 8 + word * sizeof(uint32_t));
-}
-
-static void test_rpmi_virt_fdt_service_nodes(void)
+static void rpmi_test_fdt_service_nodes(
+    const RiscvRpmiQTestMachine *machine)
 {
     static const struct {
         const char *name;
@@ -118,6 +138,7 @@ static void test_rpmi_virt_fdt_service_nodes(void)
         { "suspend", RPMI_SRVGRP_SYSTEM_SUSPEND },
     };
     g_autofree char *dtb_path = NULL;
+    g_autofree char *mailbox_path = NULL;
     g_autofree char *dtb = NULL;
     gsize dtb_size;
     const fdt32_t *prop;
@@ -131,7 +152,7 @@ static void test_rpmi_virt_fdt_service_nodes(void)
 
     dtb_path = g_strdup_printf("%s/riscv-rpmi-fdt-%u.dtb",
                                g_get_tmp_dir(), (unsigned)getpid());
-    qts = qtest_init("-machine virt,rpmi=on -display none -S");
+    qts = rpmi_qtest_init(machine, " -display none -S");
     response = qtest_qmp(qts, "{ 'execute': 'dumpdtb', 'arguments': "
                               "{ 'filename': %s } }", dtb_path);
 
@@ -144,15 +165,18 @@ static void test_rpmi_virt_fdt_service_nodes(void)
     g_assert_cmpint(remove_result, ==, 0);
     g_assert_cmpint(fdt_check_header(dtb), ==, 0);
 
-    mailbox_offset = fdt_path_offset(dtb, "/soc/mailbox@10200000");
+    mailbox_path = g_strdup_printf("/soc/mailbox@%" PRIx64,
+                                   machine->shmem_base);
+    mailbox_offset = fdt_path_offset(dtb, mailbox_path);
     g_assert_cmpint(mailbox_offset, >=, 0);
     prop = fdt_getprop(dtb, mailbox_offset, "reg", &phandle_len);
     g_assert_nonnull(prop);
     g_assert_cmpint(phandle_len, >=, 8 * sizeof(*prop));
     for (unsigned int queue = 0; queue < 2; queue++) {
         g_assert_cmphex(fdt32_to_cpu(prop[4 * queue + 1]), ==,
-                        RPMI_SHMEM_BASE + queue * RPMI_QUEUE_SIZE);
-        g_assert_cmphex(fdt32_to_cpu(prop[4 * queue + 3]), ==, RPMI_QUEUE_SIZE);
+                        machine->shmem_base + queue * machine->queue_size);
+        g_assert_cmphex(fdt32_to_cpu(prop[4 * queue + 3]), ==,
+                        machine->queue_size);
     }
     prop = fdt_getprop(dtb, mailbox_offset, "phandle", &phandle_len);
     g_assert_nonnull(prop);
@@ -177,12 +201,16 @@ static void test_rpmi_virt_fdt_service_nodes(void)
                         services[i].service_group);
     }
 
+    g_assert_cmpint(fdt_path_offset(dtb, machine->reset_node), ==,
+                    -FDT_ERR_NOTFOUND);
+    g_assert_cmpint(fdt_path_offset(dtb, machine->poweroff_node), ==,
+                    -FDT_ERR_NOTFOUND);
 }
 
 static void test_rpmi_doorbell_unsupported_values(void)
 {
     const uint32_t values[] = { 0, 2, UINT32_MAX };
-    QTestState *qts = qtest_init("-machine virt,rpmi=on");
+    QTestState *qts = rpmi_qtest_init(&virt_rpmi_machine, "");
 
     qtest_writew(qts, RPMI_A2P_SLOT0, RPMI_SRVGRP_BASE);
     qtest_writeb(qts, RPMI_A2P_SLOT0 + 2, RPMI_BASE_SRV_GET_PLATFORM_INFO);
@@ -202,6 +230,98 @@ static void test_rpmi_doorbell_unsupported_values(void)
     qtest_quit(qts);
 }
 
+static void test_rpmi_virt_fdt_service_nodes(void)
+{
+    rpmi_test_fdt_service_nodes(&virt_rpmi_machine);
+}
+
+static void test_rpmi_rvserver_ref_fdt_service_nodes(void)
+{
+    rpmi_test_fdt_service_nodes(&rvserver_ref_rpmi_machine);
+}
+
+static void rpmi_test_fdt_legacy_nodes(
+    const RiscvRpmiQTestMachine *machine)
+{
+    g_autofree char *dtb_path = NULL;
+    g_autofree char *dtb = NULL;
+    gsize dtb_size;
+    QTestState *qts;
+
+    dtb_path = g_strdup_printf("%s/riscv-rpmi-fdt-legacy-%u.dtb",
+                               g_get_tmp_dir(), (unsigned)getpid());
+    qts = rpmi_qtest_init(machine, " -display none -S");
+    qtest_qmp_assert_success(qts,
+                             "{ 'execute': 'dumpdtb', 'arguments': "
+                             "{ 'filename': %s } }", dtb_path);
+    qtest_quit(qts);
+
+    g_assert_true(g_file_get_contents(dtb_path, &dtb, &dtb_size, NULL));
+    g_assert_cmpint(fdt_check_header(dtb), ==, 0);
+    g_assert_cmpint(fdt_path_offset(dtb, machine->reset_node), >=, 0);
+    g_assert_cmpint(fdt_path_offset(dtb, machine->poweroff_node), >=, 0);
+    g_assert_cmpint(fdt_path_offset(dtb, "/soc/mailbox@110000"), ==,
+                    -FDT_ERR_NOTFOUND);
+    g_assert_cmpint(fdt_path_offset(dtb, "/soc/sysreset"), ==,
+                    -FDT_ERR_NOTFOUND);
+    g_assert_cmpint(g_remove(dtb_path), ==, 0);
+}
+
+static void test_rpmi_rvserver_ref_fdt_legacy_nodes(void)
+{
+    rpmi_test_fdt_legacy_nodes(&rvserver_ref_legacy_machine);
+}
+
+static QTestState *rpmi_qtest_init(const RiscvRpmiQTestMachine *machine,
+                                   const char *extra_args)
+{
+    rpmi_shmem_base = machine->shmem_base;
+    rpmi_doorbell_base = machine->doorbell_base;
+    rpmi_queue_size = machine->queue_size;
+
+    return qtest_initf("-machine %s%s", machine->machine_opts, extra_args);
+}
+
+static uint64_t rpmi_queue_slot(uint64_t queue_base, uint32_t index)
+{
+    return queue_base + (index + 2) * RPMI_SLOT_SIZE;
+}
+
+static void rpmi_send_request(QTestState *qts, uint16_t service_group,
+                              uint8_t service_id, uint8_t request_type,
+                              const uint32_t *data, size_t data_words)
+{
+    uint32_t tail = qtest_readl(qts, RPMI_A2P_TAIL);
+    uint64_t slot = rpmi_queue_slot(rpmi_shmem_base, tail);
+    size_t i;
+
+    qtest_writew(qts, slot, service_group);
+    qtest_writeb(qts, slot + 2, service_id);
+    qtest_writeb(qts, slot + 3, request_type);
+    qtest_writew(qts, slot + 4, data_words * sizeof(*data));
+    qtest_writew(qts, slot + 6, RPMI_TOKEN);
+
+    for (i = 0; i < data_words; i++) {
+        qtest_writel(qts, slot + 8 + i * sizeof(*data), data[i]);
+    }
+
+    g_test_message(
+        "RPMI_A2P_REQ shmem=0x%016" PRIx64 " doorbell=0x%016" PRIx64
+        " group=0x%04x service=0x%02x type=0x%02x data_len=%zu"
+        " token=0x%04x a2p_tail=%u slot=0x%016" PRIx64,
+        (uint64_t)rpmi_shmem_base, (uint64_t)rpmi_doorbell_base,
+        service_group, service_id, request_type, data_words * sizeof(*data),
+        RPMI_TOKEN, tail, slot);
+
+    qtest_writel(qts, RPMI_A2P_TAIL, (tail + 1) % RPMI_QUEUE_DATA_SLOTS);
+    qtest_writel(qts, rpmi_doorbell_base, 1);
+}
+
+static uint32_t rpmi_response_word(QTestState *qts, unsigned int word)
+{
+    return qtest_readl(qts, rpmi_response_base + 8 + word * sizeof(uint32_t));
+}
+
 static void rpmi_expect_ack(QTestState *qts, uint16_t service_group,
                             uint8_t service_id, uint16_t data_len)
 {
@@ -223,7 +343,7 @@ static void rpmi_expect_ack(QTestState *qts, uint16_t service_group,
         " group=0x%04x service=0x%02x type=0x%02x data_len=%u"
         " token=0x%04x p2a_head=%u slot=0x%016" PRIx64
         " status=0x%08x",
-        (uint64_t)RPMI_SHMEM_BASE, service_group, service_id,
+        (uint64_t)rpmi_shmem_base, service_group, service_id,
         RPMI_MSG_ACKNOWLEDGEMENT, data_len, RPMI_TOKEN, head,
         rpmi_response_base,
         data_len >= sizeof(uint32_t) ? rpmi_response_word(qts, 0) : 0);
@@ -284,30 +404,41 @@ static void test_rpmi_machine_rejects_too_many_harts(void)
         "max CPUs supported by machine 'virt' is 512");
 }
 
-static void test_rpmi_base_platform_info(void)
+static void rpmi_check_platform_info(QTestState *qts, const char *expected)
 {
-    static const char expected[] = "QEMU RISC-V virt RPMI";
-    QTestState *qts;
+    size_t expected_len = strlen(expected) + 1;
     size_t i;
 
-    qts = qtest_init("-machine virt,rpmi=on");
     rpmi_send_request(qts, RPMI_SRVGRP_BASE,
                       RPMI_BASE_SRV_GET_PLATFORM_INFO,
                       RPMI_MSG_NORMAL_REQUEST, NULL, 0);
 
     rpmi_expect_ack(qts, RPMI_SRVGRP_BASE,
                     RPMI_BASE_SRV_GET_PLATFORM_INFO,
-                    2 * sizeof(uint32_t) + sizeof(expected));
+                    2 * sizeof(uint32_t) + expected_len);
     g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 1), ==, sizeof(expected));
-    for (i = 0; i < sizeof(expected); i++) {
+    g_assert_cmphex(rpmi_response_word(qts, 1), ==, expected_len);
+    for (i = 0; i < expected_len; i++) {
         g_assert_cmphex(qtest_readb(qts, rpmi_response_base + 16 + i), ==,
                         expected[i]);
     }
+}
+
+static void rpmi_test_platform_info(const RiscvRpmiQTestMachine *machine)
+{
+    QTestState *qts;
+
+    qts = rpmi_qtest_init(machine, "");
+    rpmi_check_platform_info(qts, machine->platform_info);
 
     qtest_quit(qts);
 }
 
+static void test_rpmi_base_platform_info(void)
+{
+    rpmi_test_platform_info(&virt_rpmi_machine);
+}
+
 static void rpmi_probe_group(QTestState *qts, uint32_t service_group,
                              bool present)
 {
@@ -326,11 +457,8 @@ static void rpmi_probe_group(QTestState *qts, uint32_t service_group,
     }
 }
 
-static void test_rpmi_base_probe_service_groups(void)
+static void rpmi_check_service_groups(QTestState *qts)
 {
-    QTestState *qts;
-
-    qts = qtest_init("-machine virt,rpmi=on,aia=aplic-imsic");
     rpmi_probe_group(qts, RPMI_SRVGRP_BASE, true);
     qtest_system_reset(qts);
     rpmi_probe_group(qts, RPMI_SRVGRP_SYSTEM_RESET, true);
@@ -338,10 +466,88 @@ static void test_rpmi_base_probe_service_groups(void)
     rpmi_probe_group(qts, RPMI_SRVGRP_HSM, true);
     qtest_system_reset(qts);
     rpmi_probe_group(qts, RPMI_SRVGRP_SYSTEM_SUSPEND, true);
+}
+
+static void rpmi_test_service_groups(const RiscvRpmiQTestMachine *machine,
+                                     const char *extra_args)
+{
+    QTestState *qts;
+
+    qts = rpmi_qtest_init(machine, extra_args);
+    rpmi_check_service_groups(qts);
+
+    qtest_quit(qts);
+}
+
+static void test_rpmi_base_probe_service_groups(void)
+{
+    rpmi_test_service_groups(&virt_rpmi_machine, ",aia=aplic-imsic");
+}
+
+static void test_rpmi_rvserver_ref_machine_realize_off(void)
+{
+    QTestState *qts;
+
+    qts = rpmi_qtest_init(&rvserver_ref_legacy_machine, "");
+    qtest_quit(qts);
+}
+
+static void test_rpmi_rvserver_ref_machine_realize_default(void)
+{
+    QTestState *qts;
+
+    qts = rpmi_qtest_init(&rvserver_ref_default_machine, "");
+    qtest_quit(qts);
+}
+
+static void test_rpmi_rvserver_ref_fdt_default_nodes(void)
+{
+    rpmi_test_fdt_legacy_nodes(&rvserver_ref_default_machine);
+}
+
+static void test_rpmi_rvserver_ref_platform_info(void)
+{
+    rpmi_test_platform_info(&rvserver_ref_rpmi_machine);
+}
+
+static void test_rpmi_rvserver_ref_probe_service_groups(void)
+{
+    rpmi_test_service_groups(&rvserver_ref_rpmi_machine, "");
+}
+
+static void rpmi_check_hsm_hart_list(QTestState *qts, uint32_t hart_count)
+{
+    uint32_t start_index = 0;
+
+    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_LIST,
+                      RPMI_MSG_NORMAL_REQUEST, &start_index, 1);
+
+    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_LIST,
+                    (3 + hart_count) * sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 1), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 2), ==, hart_count);
+    for (uint32_t i = 0; i < hart_count; i++) {
+        g_assert_cmphex(rpmi_response_word(qts, i + 3), ==, i);
+    }
+}
+
+static void rpmi_test_hsm_hart_list(const RiscvRpmiQTestMachine *machine,
+                                    const char *extra_args)
+{
+    QTestState *qts;
+
+    qts = rpmi_qtest_init(machine, extra_args);
+    rpmi_check_hsm_hart_list(qts, 4);
 
     qtest_quit(qts);
 }
 
+static void test_rpmi_rvserver_ref_hsm_hart_list(void)
+{
+    rpmi_test_hsm_hart_list(&rvserver_ref_rpmi_machine, " -smp 4");
+}
+
 static void test_rpmi_sysreset_attrs(void)
 {
     static const struct {
@@ -354,7 +560,7 @@ static void test_rpmi_sysreset_attrs(void)
     };
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
         if (i) {
             qtest_system_reset(qts);
@@ -377,7 +583,7 @@ static void test_rpmi_sysreset_shutdown(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_SHUTDOWN,
                        RPMI_MSG_POSTED_REQUEST);
     qtest_qmp_eventwait(qts, "SHUTDOWN");
@@ -388,7 +594,7 @@ static void test_rpmi_sysreset_cold_reboot(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on -no-reboot");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -no-reboot");
     rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_COLD_REBOOT,
                        RPMI_MSG_POSTED_REQUEST);
     qtest_qmp_eventwait(qts, "SHUTDOWN");
@@ -399,7 +605,7 @@ static void test_rpmi_sysreset_invalid_type(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_INVALID,
                        RPMI_MSG_NORMAL_REQUEST);
 
@@ -416,7 +622,7 @@ static void test_rpmi_repeated_reset_after_traffic(void)
     QTestState *qts;
     uint32_t reset_type = RPMI_SYSRST_TYPE_SHUTDOWN;
 
-    qts = qtest_init("-machine virt,rpmi=on,aia=aplic-imsic");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, ",aia=aplic-imsic");
     for (uint32_t i = 0; i < 5; i++) {
         rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_RESET,
                           RPMI_SYSRST_SRV_GET_ATTRIBUTES,
@@ -435,7 +641,7 @@ static void test_rpmi_reset_clears_transport(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_INVALID,
                        RPMI_MSG_NORMAL_REQUEST);
     rpmi_expect_ack(qts, RPMI_SRVGRP_SYSTEM_RESET,
@@ -454,7 +660,7 @@ static void test_rpmi_doorbell_invalid_access(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     qtest_writeb(qts, RPMI_DOORBELL_BASE, 1);
     qtest_writel(qts, RPMI_DOORBELL_BASE + 4, 1);
     g_assert_cmphex(qtest_readl(qts, RPMI_DOORBELL_BASE), ==, 0);
@@ -466,7 +672,7 @@ static void test_rpmi_queue_bounds(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     qtest_writel(qts, RPMI_A2P_TAIL, RPMI_QUEUE_DATA_SLOTS);
     qtest_writel(qts, RPMI_DOORBELL_BASE, 1);
     g_assert_cmphex(qtest_readl(qts, RPMI_A2P_HEAD), ==, 0);
@@ -492,7 +698,7 @@ static void test_rpmi_migration_blocked(void)
     QDict *error;
     const char *desc;
 
-    qts = qtest_init("-machine virt,rpmi=on -S");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -S");
     error = qtest_qmp_assert_failure_ref(qts,
         "{ 'execute': 'migrate',"
         "  'arguments': { 'uri': 'exec:cat > /dev/null' } }");
@@ -506,41 +712,50 @@ static void test_rpmi_migration_blocked(void)
     qtest_quit(qts);
 }
 
-static void rpmi_expect_hsm_hart_list(QTestState *qts)
+static void test_rpmi_rvserver_ref_migration_blocked(void)
 {
-    uint32_t start_index = 0;
+    QTestState *qts;
+    QDict *error;
+    const char *desc;
 
-    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_LIST,
-                      RPMI_MSG_NORMAL_REQUEST, &start_index, 1);
+    qts = rpmi_qtest_init(&rvserver_ref_rpmi_machine, " -S");
+    error = qtest_qmp_assert_failure_ref(qts,
+        "{ 'execute': 'migrate',"
+        "  'arguments': { 'uri': 'exec:cat > /dev/null' } }");
+    desc = qdict_get_try_str(error, "desc");
 
-    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_LIST,
-                    7 * sizeof(uint32_t));
-    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 1), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 2), ==, 4);
-    g_assert_cmphex(rpmi_response_word(qts, 3), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 4), ==, 1);
-    g_assert_cmphex(rpmi_response_word(qts, 5), ==, 2);
-    g_assert_cmphex(rpmi_response_word(qts, 6), ==, 3);
+    g_assert_nonnull(desc);
+    g_assert_nonnull(strstr(desc, "non-migratable device"));
+    g_assert_nonnull(strstr(desc, "riscv-rpmi"));
+
+    qobject_unref(error);
+    qtest_quit(qts);
 }
 
-static void test_rpmi_hsm_hart_list(void)
+static void test_rpmi_rvserver_ref_migration_command_accepted(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on -smp 4");
-    rpmi_expect_hsm_hart_list(qts);
-
+    qts = rpmi_qtest_init(&rvserver_ref_legacy_machine, " -S");
+    /* This is a policy smoke test; no migration destination is restored. */
+    qtest_qmp_assert_success(qts,
+        "{ 'execute': 'migrate',"
+        "  'arguments': { 'uri': 'exec:cat > /dev/null' } }");
     qtest_quit(qts);
 }
 
+static void test_rpmi_hsm_hart_list(void)
+{
+    rpmi_test_hsm_hart_list(&virt_rpmi_machine, " -smp 4");
+}
+
 static void test_rpmi_hsm_multi_socket_hart_list(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on "
-                     "-smp 4,sockets=2,cores=2,threads=1");
-    rpmi_expect_hsm_hart_list(qts);
+    qts = rpmi_qtest_init(&virt_rpmi_machine,
+                          " -smp 4,sockets=2,cores=2,threads=1");
+    rpmi_check_hsm_hart_list(qts, 4);
 
     qtest_quit(qts);
 }
@@ -550,7 +765,7 @@ static void test_rpmi_hsm_hart_status(void)
     QTestState *qts;
     uint32_t hart_id = 3;
 
-    qts = qtest_init("-machine virt,rpmi=on -smp 4");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -smp 4");
     rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_STATUS,
                       RPMI_MSG_NORMAL_REQUEST, &hart_id, 1);
 
@@ -584,7 +799,7 @@ static void test_rpmi_hsm_hart_control(void)
     uint32_t start_index = 0;
     uint32_t suspend_type = 0;
 
-    qts = qtest_init("-machine virt,rpmi=on -smp 2");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -smp 2");
     rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_SUSPEND_TYPES,
                       RPMI_MSG_NORMAL_REQUEST, &start_index, 1);
     rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_SUSPEND_TYPES,
@@ -630,7 +845,7 @@ static void test_rpmi_hsm_hart_control(void)
 
     qtest_quit(qts);
 
-    qts = qtest_init("-machine virt,rpmi=on -smp 2");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -smp 2");
     rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_HART_SUSPEND,
                       RPMI_MSG_NORMAL_REQUEST, suspend_request,
                       ARRAY_SIZE(suspend_request));
@@ -661,7 +876,7 @@ static void test_rpmi_syssusp_attrs_and_suspend(void)
     uint32_t suspend_type = 0;
     uint32_t suspend_request[] = { 0, 0, 0x80000000, 0 };
 
-    qts = qtest_init("-machine virt,rpmi=on -smp 1");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -smp 1");
     rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_SUSPEND,
                       RPMI_SYSSUSP_SRV_GET_ATTRIBUTES,
                       RPMI_MSG_NORMAL_REQUEST, &suspend_type, 1);
@@ -812,5 +1027,28 @@ int main(int argc, char **argv)
                        test_rpmi_syssusp_attrs_and_suspend);
     }
 
+    if (qtest_has_machine("riscv-server-ref")) {
+        qtest_add_func("/riscv/rpmi/rvserver-ref/machine/realize-off",
+                       test_rpmi_rvserver_ref_machine_realize_off);
+        qtest_add_func("/riscv/rpmi/rvserver-ref/machine/realize-default",
+                       test_rpmi_rvserver_ref_machine_realize_default);
+        qtest_add_func("/riscv/rpmi/rvserver-ref/fdt/service-nodes",
+                       test_rpmi_rvserver_ref_fdt_service_nodes);
+        qtest_add_func("/riscv/rpmi/rvserver-ref/fdt/legacy-nodes",
+                       test_rpmi_rvserver_ref_fdt_legacy_nodes);
+        qtest_add_func("/riscv/rpmi/rvserver-ref/fdt/default-nodes",
+                       test_rpmi_rvserver_ref_fdt_default_nodes);
+        qtest_add_func("/riscv/rpmi/rvserver-ref/rpmi/platform-info",
+                       test_rpmi_rvserver_ref_platform_info);
+        qtest_add_func("/riscv/rpmi/rvserver-ref/base/probe-service-groups",
+                       test_rpmi_rvserver_ref_probe_service_groups);
+        qtest_add_func("/riscv/rpmi/rvserver-ref/hsm/hart-list",
+                       test_rpmi_rvserver_ref_hsm_hart_list);
+        qtest_add_func("/riscv/rpmi/rvserver-ref/migration/blocked",
+                       test_rpmi_rvserver_ref_migration_blocked);
+        qtest_add_func("/riscv/rpmi/rvserver-ref/migration/command-accepted",
+                       test_rpmi_rvserver_ref_migration_command_accepted);
+    }
+
     return g_test_run();
 }

