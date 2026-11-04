Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C60A606A32C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VOYqeE5o;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YM8gh2QT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTDp-0007S4-2I; Wed, 04 Nov 2026 00:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTDd-0007EB-N7
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:07:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTDY-0002Oi-P1
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:07:29 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A442KaQ3300602
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 05:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SGycZXPNcBS
 IGWZ+hW/wn9bQMgEs/bok5AsCj9Myge4=; b=VOYqeE5oKHJmOGHc+OUSrgqMG2e
 mzuSMiVM0A5YKOnJVQ796a7pUGaAKpYj8TPOV+EFt4jEjIat9wWnbXCz3xxv1BJM
 jSq1Z86x2v3KrPlDXIhPT1aUDEBiXY8cWSgzTGaeCq6naOWv7ZTHsaH/w+3gzFl4
 BALZZHmWGysnRKUPLlUrNrDfDQUGWrBZNE0nVV58XTXecFs0IsQ0acD9Bu2pKrfO
 Ey/Bg5ruAld+cMSKSWfrf/WdXrZakwytEmH+kPNrHEnk+Axe9Q6elM2NZZN76Zj2
 ZW2zzAWUbKjayjTi37t8EpdNkdSwky6/WqQosDmUOg8NSt91KJZB3eQagZw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqwb087sh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 05:07:13 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-18b5ee75404so9754c88.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 21:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793768833; x=1794373633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SGycZXPNcBSIGWZ+hW/wn9bQMgEs/bok5AsCj9Myge4=;
 b=YM8gh2QTMynfarEyLyV56gdJw4kXWS2tWGGa/BNR4fb4mhFdIyk6Ax5/S+KsMsC5vq
 Pm8hiMUZ803w/K2225IT3/oV2peQ2hLx8cBu81bkVbhX6TRXNVXhQidrm5HFOb4lRCyz
 YN/VhGCwwMzQbQmzAqa3L/ySFrh2KTOonNwFEvuUGXvFxFPS+ElhZmO1aqTu6QQGtWjY
 hZJmwZltYKoz6f/k81UxalkJd5Rz3QYD0Xko/Lh0a/s1043lj4jANCBgdWzOlhH7Mgbt
 UYYRduUUExb74cF4xgnXmW0cegWCuYYMqypv/6RCX1R1dviTwbDOXnKn+mllc+MW3c7+
 zWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793768833; x=1794373633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SGycZXPNcBSIGWZ+hW/wn9bQMgEs/bok5AsCj9Myge4=;
 b=oKrtj2ByDl/Zcl7B6ShHzHUd9jMM0eY33GYs+ClZXgZwt2kbxsLwqVux2SgWOnlXBa
 yrV19ajiOTswGBtZTytQx8ttDj/Tye1XeQzygZFX1pI/xoYYP9J436ZHEb9f+BjEZpSd
 HNgkKYVz6jFOalDYiSL9JZEpXXhRmWNufHTsllD3qTuWA21ZRBxVgt3jOobFd8hjFCHn
 AsNtY3mGDoOlVJL2QUn/R0/a4iULLIN4BnidP/edyTiymZcn4usrf3WuXP+4HpKe5xQn
 /B/H+DKSBennSFIi4sdChUqiYS656f8Xb82JF+R4BIvrB/ZxU4vIEtG6ixLaQgzDYK74
 diwA==
X-Gm-Message-State: APuU4Z9FKxXy9pTGtyL5to/hvic9UVFMaWAgCGK7euyEXdaauHQlIiyA
 GhMFvTX4S1DhPxapEbztiJ2eURHFn0hk0i0lTb1F0Op+u0SdPbKQEWX6243mF4y/l1USIREBXKr
 V0b5hREhvXNkKzzV3mLn3P7tWtj0Xj+dJbc2WOMtcmaTKlgqrBlJVaLHcZuNJMm0GsA==
X-Gm-Gg: AYBFou1KWDclKu7TeO3lZ7nH2HBQGjs/AxlMu8Sded9Ta0Qp/O2uF2Pjju6JJks+1jd
 PYuT+3oQGtb2TFYHII190CYksEhbhJhyud6/dsMeToAn2OoKuHVo2rG4+WfwvHq3/Q7fW8uhV7x
 kOn8H/uLAc1fxLa+hEAYdEIHO/s5ZfZep5nqSvG2YwTyEvFGsXkxAKFqge6CCU0MxGl5bHEkYGw
 D2J0voai/aYVTTQWuXWm+qKRYU4rQpHhSy9UhDQHH/DZ3tdJVHI24X9/xy2IhH1NdDRXVXk3K2z
 0E8eUc+HExnKMribnS1LaXLZgLl8DvJylZ6D+PQl169lGUZT66o7zKLJpKnRHSlxlD+lmGa4s67
 gJCtKcr+KDOKzshAD6mDRPFvhddVo25yh7/FUw97UOODlLBYm+3p9nr3P5Nn3yPu+nnYX0Th4li
 aiKGgCMQJMBlYUYcZIRZW7SInpA0dmY3JT2oFYZ5qLKDrKwD7vgPrgJX6GPNX69dgxEkzpYluWV
 aOAgsE=
X-Received: by 2002:a05:7300:d090:b0:36a:e7a:e89 with SMTP id
 5a478bee46e88-36a4239cc86mr33463905eec.2.1793768831799; 
 Tue, 03 Nov 2026 21:07:11 -0800 (PST)
X-Received: by 2002:a05:7300:d090:b0:36a:e7a:e89 with SMTP id
 5a478bee46e88-36a4239cc86mr33463838eec.2.1793768831080; 
 Tue, 03 Nov 2026 21:07:11 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d3580sm3639698eec.10.2026.11.03.21.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 21:07:10 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 2/2] tests/qtest: cover server reference platform RPMI
Date: Wed,  4 Nov 2026 10:36:50 +0530
Message-ID: <20261104050650.776580-3-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104050650.776580-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261104050650.776580-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX3Hh7B9V8v9/Y
 dGHyqPTeeJMMv7hc2cbsxVrvc0gDr+481l4AOeFDTVo1MOU+PD2Awh7rTJT4WQJFTN0s0504LVi
 I/e9CyfbnlLUSwXkKxczBB5wUgSzlmc=
X-Authority-Analysis: v=2.4 cv=OfINnRTY c=1 sm=1 tr=0 ts=6aeabd81 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=dDrmHaMEVB_NiFHh1N0A:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: 5j9jMovgnzqLWCSZ2l-tUZ6MtVQvvE7Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfXyizoEzNxrSAR
 abtAw5WDf117hkhNZ9iwPqbZJztZeLAyvrVGUfH55+FrUh79xj2l89HiavSJHPQJCL/4i/iXpMR
 +Ipfj6fUYC6guIBoQ5PnVFVmz1ZaViAtSk+ME378T/6i9RVWkUzEYEFRSVdyTq9USYn8jHS2W/h
 etCc5HOfTB1q7BAhkjV50O7fPGk6tusFg1k2Sq7CA6VuMrEc1iX4l2SHTpyMOInU4CMtPlDqoYx
 fGeRK+SeVHPx4JOZ/cS+b7WoLRfJSkxvd7Jf3nlBNXLWiOdlOzMqNo7B9Dba8dFLy5d1vvegpbj
 0ppxYh37E5bgUq3SRx9PzrEzWiTzi8Zynq276YxSbrr/CwvusR1VR5lhyWT3shZgTuZIlCaYGkZ
 /EU7riP+rc96aAVYkMbUSaJnCS01Nvnc0ySaTVrraWo3MZgg3vavnrAE55R9Ja0ttY66goZdW6S
 eIQeQSiIqc6cs/xCpxQ==
X-Proofpoint-ORIG-GUID: 5j9jMovgnzqLWCSZ2l-tUZ6MtVQvvE7Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040020
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
---
 tests/qtest/riscv-rpmi-test.c | 434 ++++++++++++++++++++++++++--------
 1 file changed, 336 insertions(+), 98 deletions(-)

diff --git a/tests/qtest/riscv-rpmi-test.c b/tests/qtest/riscv-rpmi-test.c
index 318c66b426..9cece1e939 100644
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
@@ -61,53 +64,65 @@
 #define RPMI_HSM_TEST_START_ADDR 0x80000000ULL
 #define RPMI_HSM_TEST_RESUME_ADDR 0x80001000ULL
 
-#define RPMI_P2A_ACK_BASE (RPMI_SHMEM_BASE + RPMI_QUEUE_SIZE)
+#define RPMI_P2A_ACK_BASE (rpmi_shmem_base + rpmi_queue_size)
 #define RPMI_P2A_ACK_HEAD RPMI_P2A_ACK_BASE
 #define RPMI_P2A_ACK_TAIL (RPMI_P2A_ACK_BASE + RPMI_SLOT_SIZE)
 
-static uint64_t rpmi_response_base;
-
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
-
-static uint32_t rpmi_response_word(QTestState *qts, unsigned int word)
-{
-    return qtest_readl(qts, rpmi_response_base + 8 + word * sizeof(uint32_t));
-}
-
-static void test_rpmi_virt_fdt_service_nodes(void)
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
+static QTestState *rpmi_qtest_init(const RiscvRpmiQTestMachine *machine,
+                                   const char *extra_args);
+
+static void rpmi_test_fdt_service_nodes(
+    const RiscvRpmiQTestMachine *machine)
 {
     static const struct {
         const char *name;
@@ -118,6 +133,7 @@ static void test_rpmi_virt_fdt_service_nodes(void)
         { "suspend", RPMI_SRVGRP_SYSTEM_SUSPEND },
     };
     g_autofree char *dtb_path = NULL;
+    g_autofree char *mailbox_path = NULL;
     g_autofree char *dtb = NULL;
     gsize dtb_size;
     const fdt32_t *prop;
@@ -128,7 +144,7 @@ static void test_rpmi_virt_fdt_service_nodes(void)
 
     dtb_path = g_strdup_printf("%s/riscv-rpmi-fdt-%u.dtb",
                                g_get_tmp_dir(), (unsigned)getpid());
-    qts = qtest_init("-machine virt,rpmi=on -display none -S");
+    qts = rpmi_qtest_init(machine, " -display none -S");
     qtest_qmp_assert_success(qts,
                              "{ 'execute': 'dumpdtb', 'arguments': "
                              "{ 'filename': %s } }", dtb_path);
@@ -137,15 +153,17 @@ static void test_rpmi_virt_fdt_service_nodes(void)
     g_assert_true(g_file_get_contents(dtb_path, &dtb, &dtb_size, NULL));
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
+        g_assert_cmphex(fdt32_to_cpu(prop[4 * queue + 3]), ==, machine->queue_size);
     }
     prop = fdt_getprop(dtb, mailbox_offset, "phandle", &phandle_len);
     g_assert_nonnull(prop);
@@ -170,9 +188,111 @@ static void test_rpmi_virt_fdt_service_nodes(void)
                         services[i].service_group);
     }
 
+    g_assert_cmpint(fdt_path_offset(dtb, machine->reset_node), ==,
+                    -FDT_ERR_NOTFOUND);
+    g_assert_cmpint(fdt_path_offset(dtb, machine->poweroff_node), ==,
+                    -FDT_ERR_NOTFOUND);
+
     g_assert_cmpint(g_remove(dtb_path), ==, 0);
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
+static uint64_t rpmi_shmem_base = RPMI_SHMEM_BASE;
+static uint64_t rpmi_doorbell_base = RPMI_DOORBELL_BASE;
+static uint32_t rpmi_queue_size = RPMI_VIRT_QUEUE_SIZE;
+static uint64_t rpmi_response_base;
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
@@ -194,7 +314,7 @@ static void rpmi_expect_ack(QTestState *qts, uint16_t service_group,
         " group=0x%04x service=0x%02x type=0x%02x data_len=%u"
         " token=0x%04x p2a_head=%u slot=0x%016" PRIx64
         " status=0x%08x",
-        (uint64_t)RPMI_SHMEM_BASE, service_group, service_id,
+        (uint64_t)rpmi_shmem_base, service_group, service_id,
         RPMI_MSG_ACKNOWLEDGEMENT, data_len, RPMI_TOKEN, head,
         rpmi_response_base,
         data_len >= sizeof(uint32_t) ? rpmi_response_word(qts, 0) : 0);
@@ -255,30 +375,41 @@ static void test_rpmi_machine_rejects_too_many_harts(void)
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
@@ -297,11 +428,8 @@ static void rpmi_probe_group(QTestState *qts, uint32_t service_group,
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
@@ -309,10 +437,88 @@ static void test_rpmi_base_probe_service_groups(void)
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
@@ -325,7 +531,7 @@ static void test_rpmi_sysreset_attrs(void)
     };
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
         if (i) {
             qtest_system_reset(qts);
@@ -348,7 +554,7 @@ static void test_rpmi_sysreset_shutdown(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_SHUTDOWN,
                        RPMI_MSG_POSTED_REQUEST);
     qtest_qmp_eventwait(qts, "SHUTDOWN");
@@ -359,7 +565,7 @@ static void test_rpmi_sysreset_cold_reboot(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on -no-reboot");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -no-reboot");
     rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_COLD_REBOOT,
                        RPMI_MSG_POSTED_REQUEST);
     qtest_qmp_eventwait(qts, "SHUTDOWN");
@@ -370,7 +576,7 @@ static void test_rpmi_sysreset_invalid_type(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_INVALID,
                        RPMI_MSG_NORMAL_REQUEST);
 
@@ -387,7 +593,7 @@ static void test_rpmi_repeated_reset_after_traffic(void)
     QTestState *qts;
     uint32_t reset_type = RPMI_SYSRST_TYPE_SHUTDOWN;
 
-    qts = qtest_init("-machine virt,rpmi=on,aia=aplic-imsic");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, ",aia=aplic-imsic");
     for (uint32_t i = 0; i < 5; i++) {
         rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_RESET,
                           RPMI_SYSRST_SRV_GET_ATTRIBUTES,
@@ -406,7 +612,7 @@ static void test_rpmi_reset_clears_transport(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_INVALID,
                        RPMI_MSG_NORMAL_REQUEST);
     rpmi_expect_ack(qts, RPMI_SRVGRP_SYSTEM_RESET,
@@ -425,7 +631,7 @@ static void test_rpmi_doorbell_invalid_access(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     qtest_writeb(qts, RPMI_DOORBELL_BASE, 1);
     qtest_writel(qts, RPMI_DOORBELL_BASE + 4, 1);
     g_assert_cmphex(qtest_readl(qts, RPMI_DOORBELL_BASE), ==, 0);
@@ -437,7 +643,7 @@ static void test_rpmi_queue_bounds(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     qtest_writel(qts, RPMI_A2P_TAIL, RPMI_QUEUE_DATA_SLOTS);
     qtest_writel(qts, RPMI_DOORBELL_BASE, 1);
     g_assert_cmphex(qtest_readl(qts, RPMI_A2P_HEAD), ==, 0);
@@ -463,7 +669,7 @@ static void test_rpmi_migration_blocked(void)
     QDict *error;
     const char *desc;
 
-    qts = qtest_init("-machine virt,rpmi=on -S");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -S");
     error = qtest_qmp_assert_failure_ref(qts,
         "{ 'execute': 'migrate',"
         "  'arguments': { 'uri': 'exec:cat > /dev/null' } }");
@@ -477,41 +683,50 @@ static void test_rpmi_migration_blocked(void)
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
@@ -521,7 +736,7 @@ static void test_rpmi_hsm_hart_status(void)
     QTestState *qts;
     uint32_t hart_id = 3;
 
-    qts = qtest_init("-machine virt,rpmi=on -smp 4");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -smp 4");
     rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_STATUS,
                       RPMI_MSG_NORMAL_REQUEST, &hart_id, 1);
 
@@ -555,7 +770,7 @@ static void test_rpmi_hsm_hart_control(void)
     uint32_t start_index = 0;
     uint32_t suspend_type = 0;
 
-    qts = qtest_init("-machine virt,rpmi=on -smp 2");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -smp 2");
     rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_SUSPEND_TYPES,
                       RPMI_MSG_NORMAL_REQUEST, &start_index, 1);
     rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_SUSPEND_TYPES,
@@ -601,7 +816,7 @@ static void test_rpmi_hsm_hart_control(void)
 
     qtest_quit(qts);
 
-    qts = qtest_init("-machine virt,rpmi=on -smp 2");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -smp 2");
     rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_HART_SUSPEND,
                       RPMI_MSG_NORMAL_REQUEST, suspend_request,
                       ARRAY_SIZE(suspend_request));
@@ -632,7 +847,7 @@ static void test_rpmi_syssusp_attrs_and_suspend(void)
     uint32_t suspend_type = 0;
     uint32_t suspend_request[] = { 0, 0, 0x80000000, 0 };
 
-    qts = qtest_init("-machine virt,rpmi=on -smp 1");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -smp 1");
     rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_SUSPEND,
                       RPMI_SYSSUSP_SRV_GET_ATTRIBUTES,
                       RPMI_MSG_NORMAL_REQUEST, &suspend_type, 1);
@@ -755,5 +970,28 @@ int main(int argc, char **argv)
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

