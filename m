Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348D606A324
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AsamdWNa;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hWWhXWes
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLKhb-0004Os-7m; Mon, 26 Oct 2026 09:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xLKhW-0004Dg-Ug
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:25:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xLKhS-0005OH-Gy
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:25:22 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAt0LP3631949
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 13:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AKTqIhcapJV
 0QEQn/iZhRxqMtyLdZAtZ5tUHhXlFR7Y=; b=AsamdWNaVQMoGHnO6MmRL2rBPVo
 qHfxwoDiu3gnq6/DlTwaLudkHxV4OkA7g9KtseDJim7gt7l0128ymX+dveP2lZfJ
 cTEzOUAfKMZbs8VHnQba0khj3bDdnkrvENHiCVu7cF3SBNKPmpFOByl46kgCRxv8
 JIELyWH0HGp83Z4SFnKxY8wb1+Zf5T8QGLpkZMglm5p0ThJCVMbE8JK8WjCUesuh
 WoRYxThfgRGt/9Y2imq4QJUKNjc2PTjJostj8rUkPexp1XY7xZYu03nEwkkkQpHq
 CRk6gz2Rq5fpBy1NfJLNDwhb8hbg+iZUkwH8dcPGT5YBMyRHsRPPUosjWXA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4sf0qk0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 13:25:17 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33bf1d17dfeso478344eec.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793021116; x=1793625916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AKTqIhcapJV0QEQn/iZhRxqMtyLdZAtZ5tUHhXlFR7Y=;
 b=hWWhXWes03x6lmGZp8BoElvZrNk7Cjf1rjMiIODKAQqFl7vTUjnhY7M46LICAkucQC
 ap97FohOpRa6r9QnM07pLDTecIxjPfnUaAJEced9Mj8ZlDzwb0rRsWdXIr0RyxhM6oOk
 BR/J0Bj7ch2AMa9pxmYoY3r/yaVpEG1JaIdJtg0dpeSAzHVOhiwY1T9pByNBmP57Zn9J
 /e9ejylHoQWNu8t+Vh4yNDuonFYvZHVMm8HGH/XwLKIykXLsCgLDaDnGxVhtiIjZoLme
 yZ+K0xAetOkvS9hN7quhtr4GlTulTXZTkUbUd+QEspN+K7qiaTpULA0MIOWiBz0LvmTy
 NRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793021116; x=1793625916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AKTqIhcapJV0QEQn/iZhRxqMtyLdZAtZ5tUHhXlFR7Y=;
 b=KvcJx+vxs0dXtAwWGDK6gc33sw8Z+OYjZ4aDZUC+I4InrOpcQjVk/OlrQbmDhIAZdP
 Qi9r8j37J+yREgceEtX27iIDuKoqDlpNCHhZj2a8mYRGQNTkJvwWeJDZ8UXaCK5DUstz
 Ux7KHtOE/qT/vDj83Px5ZT6GCIt3zAIyMi8caejGnpWQ455RKZe44BPQ00ceO1KVQBo6
 Um8jPml2f3BHfazmk7UBNKZeKKmMoFcJJ50+Scq7WTd0MEbgmSN6pohdVlC+6U1jtbG7
 6B0AL6iqXT5hfiJD73Nrg+8DbwkCGS/tB3D/ZRX+goxnRZwdsa/BDfKFEo4ptams2Luz
 YZzg==
X-Gm-Message-State: AFq9FYKnA0YPk2RQSJkNxVEeaLEhK3rVcvZpieCJEthJkadi05uwMRBe
 Dr8IXAkBtIxvjbbJLSZiFG0L/dMm06TADC5jNjvlq6QKhHvM5Oy17fwP8oT5Cz4Sgwuj3mDlcZ0
 a8kwpEF3vrNfis3cjg1HN/xGhvcfxXtbhQ99D0jbZEKfxb5RyzxsYcT8j+PuvOsQVug==
X-Gm-Gg: AYBFou3yHN+7tlGVZWLjwIPnjFxTG61PY/YLCAM5Xhush865RABUDEdk0giRFakDWhH
 4076Ztw0Wf1Zt40g/AUVa4cNUWCuPNXZLi3asfCOCrQIUmY2On60fFQvDawlOSQdezmJWldvGNW
 +t8UgWbviL3H4wLYMxSVXrtSvSI0zfrcRGvh/4tRhPGylBCYjLhJVTjcZCTD3G6jyP/XsWQ68Xg
 C3NubfZcRTPe079xLa3bgLhh8KMscO3M0vHA9yv/VyLZXA1IIhkSmfNzv+HacQPHitmDLSxNoEv
 kh2NCFCIHnI7SG4iIk2f0NcG8CfiEcu4nugWstKqBrO0tu6VvUWOAZCme5pcWLiMWFnVzhj3TN3
 twRCmzXIDSMCefTUTjFcaInivU1ivLgSCM8LYm9bu3MTKcKeJUQa7Yks5uVi9NSHEwHfwK3EgiN
 WvHz/aVK/c6//cIcYzCXMxEYtrGSsjjg==
X-Received: by 2002:a05:693c:68ce:b0:369:f945:e213 with SMTP id
 5a478bee46e88-369f945ed2amr9529621eec.2.1793021115612; 
 Mon, 26 Oct 2026 06:25:15 -0700 (PDT)
X-Received: by 2002:a05:693c:68ce:b0:369:f945:e213 with SMTP id
 5a478bee46e88-369f945ed2amr9529555eec.2.1793021114652; 
 Mon, 26 Oct 2026 06:25:14 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db450bsm24312725eec.17.2026.10.26.06.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:25:14 -0700 (PDT)
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
Subject: [PATCH v2 2/2] tests/qtest: cover server reference platform RPMI
Date: Mon, 26 Oct 2026 18:54:49 +0530
Message-ID: <20261026132450.2697115-3-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026132450.2697115-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261026132450.2697115-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MyBTYWx0ZWRfX1qcMS3UM+1Qc
 BEV5FJsQSD5XXmxPaLL3ziVFn/6kcZdu0e+VQGUG44TVjaApzVz1yvk14C68OernRTZs1h8vKYb
 n4sGOFmnjtox1oetEQdpgVce4Ot6IF4=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6adf54bd cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=0dOL59NmqaDkYTHqKFUA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 4AdNyJY1cEeGPLQ8ZqJT1aBcj-CsbZ-t
X-Proofpoint-ORIG-GUID: 4AdNyJY1cEeGPLQ8ZqJT1aBcj-CsbZ-t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MyBTYWx0ZWRfXyVVAYZGsrOnq
 bqUzXEMQQ+ppPS1P61zDTarA2WvAIaKGLJ+8tdYPBpRksVNkbXnvo1PIWqyPYAHYn0xwyxPgnGc
 h9RP4KUX9HYda9hxBJgzjgK24SWjkvXtWnFg8GcuGDaIHU96GWeJZGaHBqx3aEgSbl4s2L5CUBr
 5E0SKXzFtIA3R82OAXRcRfoP3nznfKw3lUsHq0P+5xzjbQsEpJvT0f0HevmjUcD0gBMGpmyvHad
 0misjFovhnJvbh6uYUShyKxKWlLVHk6WI2N/cux+uen1LR1jj8OqW6g9X8SIInNn2j6Ft7/87Os
 bM55s76Spi9ZBJ1Srq7ggYD/fIiUqoH1mYsbO170xUAAnbhTlg/QHTGOhy58IPThhfJu0j8n8A2
 pWAURiYeCiRzANkrQdhtbu8kcOhPNajctYdqVn5gUcAmkhVAHv2mwDIo8NaIkSqiXV7hfoTmhFc
 wnAQip3ne0O/snhdQLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260053
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend the RISC-V RPMI qtest coverage so the same transport and service
helpers can exercise both virt and riscv-server-ref.  This keeps the existing
virt coverage while adding server-ref checks for the board policy introduced
with RPMI support.

Cover the server-ref-specific behavior that RPMI is enabled by default when
compiled in and that the board rejects the virt-only rpmi=on|off machine
property.  Also verify the server-ref platform information, base service group
discovery, and HSM hart list handling.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 tests/qtest/riscv-rpmi-test.c | 319 +++++++++++++++++++++++-----------
 1 file changed, 213 insertions(+), 106 deletions(-)

diff --git a/tests/qtest/riscv-rpmi-test.c b/tests/qtest/riscv-rpmi-test.c
index fe9bb3e919..5d141eb780 100644
--- a/tests/qtest/riscv-rpmi-test.c
+++ b/tests/qtest/riscv-rpmi-test.c
@@ -16,11 +16,13 @@
 
 #define RPMI_SHMEM_BASE 0x10200000ULL
 #define RPMI_DOORBELL_BASE 0x10230000ULL
+#define RVSERVER_RPMI_SHMEM_BASE 0x110000ULL
+#define RVSERVER_RPMI_DOORBELL_BASE 0x140000ULL
 #define RPMI_SLOT_SIZE 64
 
-#define RPMI_A2P_HEAD RPMI_SHMEM_BASE
-#define RPMI_A2P_TAIL (RPMI_SHMEM_BASE + RPMI_SLOT_SIZE)
-#define RPMI_A2P_SLOT0 (RPMI_SHMEM_BASE + 2 * RPMI_SLOT_SIZE)
+#define RPMI_A2P_HEAD rpmi_shmem_base
+#define RPMI_A2P_TAIL (rpmi_shmem_base + RPMI_SLOT_SIZE)
+#define RPMI_A2P_SLOT0 (rpmi_shmem_base + 2 * RPMI_SLOT_SIZE)
 
 #define RPMI_SRVGRP_BASE 0x0001
 #define RPMI_SRVGRP_SYSTEM_RESET 0x0003
@@ -57,54 +59,37 @@
 #define RPMI_HSM_TEST_START_ADDR 0x80000000ULL
 #define RPMI_HSM_TEST_RESUME_ADDR 0x80001000ULL
 
-#define RPMI_P2A_ACK_BASE (RPMI_SHMEM_BASE + 16 * RPMI_SLOT_SIZE)
+#define RPMI_P2A_ACK_BASE (rpmi_shmem_base + 16 * RPMI_SLOT_SIZE)
 #define RPMI_P2A_ACK_HEAD RPMI_P2A_ACK_BASE
 #define RPMI_P2A_ACK_TAIL (RPMI_P2A_ACK_BASE + RPMI_SLOT_SIZE)
 #define RPMI_P2A_ACK_SLOT0 (RPMI_P2A_ACK_BASE + 2 * RPMI_SLOT_SIZE)
 
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
-    qtest_writel(qts, RPMI_A2P_TAIL, (tail + 1) % 16);
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
+    const char *platform_info;
+} RiscvRpmiQTestMachine;
+
+static const RiscvRpmiQTestMachine virt_rpmi_machine = {
+    .machine_opts = "virt,rpmi=on",
+    .shmem_base = RPMI_SHMEM_BASE,
+    .doorbell_base = RPMI_DOORBELL_BASE,
+    .platform_info = "QEMU RISC-V virt RPMI",
+};
+
+static const RiscvRpmiQTestMachine rvserver_ref_rpmi_machine = {
+    .machine_opts = "riscv-server-ref",
+    .shmem_base = RVSERVER_RPMI_SHMEM_BASE,
+    .doorbell_base = RVSERVER_RPMI_DOORBELL_BASE,
+    .platform_info = "QEMU RISC-V server-ref RPMI",
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
@@ -115,6 +100,7 @@ static void test_rpmi_virt_fdt_service_nodes(void)
         { "suspend", RPMI_SRVGRP_SYSTEM_SUSPEND },
     };
     g_autofree char *dtb_path = NULL;
+    g_autofree char *mailbox_path = NULL;
     g_autofree char *dtb = NULL;
     gsize dtb_size;
     const fdt32_t *prop;
@@ -125,7 +111,7 @@ static void test_rpmi_virt_fdt_service_nodes(void)
 
     dtb_path = g_strdup_printf("%s/riscv-rpmi-fdt-%u.dtb",
                                g_get_tmp_dir(), (unsigned)getpid());
-    qts = qtest_init("-machine virt,rpmi=on -display none -S");
+    qts = rpmi_qtest_init(machine, " -display none -S");
     qtest_qmp_assert_success(qts,
                              "{ 'execute': 'dumpdtb', 'arguments': "
                              "{ 'filename': %s } }", dtb_path);
@@ -134,7 +120,9 @@ static void test_rpmi_virt_fdt_service_nodes(void)
     g_assert_true(g_file_get_contents(dtb_path, &dtb, &dtb_size, NULL));
     g_assert_cmpint(fdt_check_header(dtb), ==, 0);
 
-    mailbox_offset = fdt_path_offset(dtb, "/soc/mailbox@10200000");
+    mailbox_path = g_strdup_printf("/soc/mailbox@%" PRIx64,
+                                   machine->shmem_base);
+    mailbox_offset = fdt_path_offset(dtb, mailbox_path);
     g_assert_cmpint(mailbox_offset, >=, 0);
     prop = fdt_getprop(dtb, mailbox_offset, "phandle", &phandle_len);
     g_assert_nonnull(prop);
@@ -162,6 +150,69 @@ static void test_rpmi_virt_fdt_service_nodes(void)
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
+static uint64_t rpmi_shmem_base = RPMI_SHMEM_BASE;
+static uint64_t rpmi_doorbell_base = RPMI_DOORBELL_BASE;
+static uint64_t rpmi_response_base;
+
+static QTestState *rpmi_qtest_init(const RiscvRpmiQTestMachine *machine,
+                                   const char *extra_args)
+{
+    rpmi_shmem_base = machine->shmem_base;
+    rpmi_doorbell_base = machine->doorbell_base;
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
+    qtest_writel(qts, RPMI_A2P_TAIL, (tail + 1) % 16);
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
@@ -183,7 +234,7 @@ static void rpmi_expect_ack(QTestState *qts, uint16_t service_group,
         " group=0x%04x service=0x%02x type=0x%02x data_len=%u"
         " token=0x%04x p2a_head=%u slot=0x%016" PRIx64
         " status=0x%08x",
-        (uint64_t)RPMI_SHMEM_BASE, service_group, service_id,
+        (uint64_t)rpmi_shmem_base, service_group, service_id,
         RPMI_MSG_ACKNOWLEDGEMENT, data_len, RPMI_TOKEN, head,
         rpmi_response_base,
         data_len >= sizeof(uint32_t) ? rpmi_response_word(qts, 0) : 0);
@@ -243,30 +294,41 @@ static void test_rpmi_machine_rejects_too_many_harts(void)
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
         g_assert_cmphex(qtest_readb(qts, RPMI_P2A_ACK_SLOT0 + 16 + i), ==,
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
@@ -285,11 +347,8 @@ static void rpmi_probe_group(QTestState *qts, uint32_t service_group,
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
@@ -297,16 +356,80 @@ static void test_rpmi_base_probe_service_groups(void)
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
+static void test_rpmi_rvserver_ref_rejects_rpmi_property(void)
+{
+    rpmi_expect_qemu_failure(
+        "-machine riscv-server-ref,rpmi=off -display none -S",
+        "Property 'riscv-server-ref-machine.rpmi' not found");
+}
+
+static void test_rpmi_rvserver_ref_default_platform_info(void)
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
     QTestState *qts;
     uint32_t reset_type = RPMI_SYSRST_TYPE_SHUTDOWN;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_RESET,
                       RPMI_SYSRST_SRV_GET_ATTRIBUTES,
                       RPMI_MSG_NORMAL_REQUEST, &reset_type, 1);
@@ -344,7 +467,7 @@ static void test_rpmi_sysreset_shutdown(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_SHUTDOWN,
                        RPMI_MSG_POSTED_REQUEST);
     qtest_qmp_eventwait(qts, "SHUTDOWN");
@@ -355,7 +478,7 @@ static void test_rpmi_sysreset_cold_reboot(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on -no-reboot");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -no-reboot");
     rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_COLD_REBOOT,
                        RPMI_MSG_POSTED_REQUEST);
     qtest_qmp_eventwait(qts, "SHUTDOWN");
@@ -366,7 +489,7 @@ static void test_rpmi_sysreset_invalid_type(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_INVALID,
                        RPMI_MSG_NORMAL_REQUEST);
 
@@ -383,7 +506,7 @@ static void test_rpmi_repeated_reset_after_traffic(void)
     QTestState *qts;
     uint32_t reset_type = RPMI_SYSRST_TYPE_SHUTDOWN;
 
-    qts = qtest_init("-machine virt,rpmi=on,aia=aplic-imsic");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, ",aia=aplic-imsic");
     for (uint32_t i = 0; i < 5; i++) {
         rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_RESET,
                           RPMI_SYSRST_SRV_GET_ATTRIBUTES,
@@ -402,7 +525,7 @@ static void test_rpmi_reset_clears_transport(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_INVALID,
                        RPMI_MSG_NORMAL_REQUEST);
     rpmi_expect_ack(qts, RPMI_SRVGRP_SYSTEM_RESET,
@@ -421,7 +544,7 @@ static void test_rpmi_doorbell_invalid_access(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     qtest_writeb(qts, RPMI_DOORBELL_BASE, 1);
     qtest_writel(qts, RPMI_DOORBELL_BASE + 4, 1);
     g_assert_cmphex(qtest_readl(qts, RPMI_DOORBELL_BASE), ==, 0);
@@ -433,7 +556,7 @@ static void test_rpmi_queue_bounds(void)
 {
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, "");
     qtest_writel(qts, RPMI_A2P_TAIL, 0x1000);
     qtest_writel(qts, RPMI_DOORBELL_BASE, 1);
     g_assert_cmphex(qtest_readl(qts, RPMI_A2P_HEAD), ==, 0);
@@ -448,7 +571,7 @@ static void test_rpmi_migration_blocked(void)
     QDict *error;
     const char *desc;
 
-    qts = qtest_init("-machine virt,rpmi=on -S");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -S");
     error = qtest_qmp_assert_failure_ref(qts,
         "{ 'execute': 'migrate',"
         "  'arguments': { 'uri': 'exec:cat > /dev/null' } }");
@@ -464,45 +587,16 @@ static void test_rpmi_migration_blocked(void)
 
 static void test_rpmi_hsm_hart_list(void)
 {
-    QTestState *qts;
-    uint32_t start_index = 0;
-
-    qts = qtest_init("-machine virt,rpmi=on -smp 4");
-    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_LIST,
-                      RPMI_MSG_NORMAL_REQUEST, &start_index, 1);
-
-    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_LIST,
-                    7 * sizeof(uint32_t));
-    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 1), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 2), ==, 4);
-    g_assert_cmphex(rpmi_response_word(qts, 3), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 4), ==, 1);
-    g_assert_cmphex(rpmi_response_word(qts, 5), ==, 2);
-    g_assert_cmphex(rpmi_response_word(qts, 6), ==, 3);
-
-    qtest_quit(qts);
+    rpmi_test_hsm_hart_list(&virt_rpmi_machine, " -smp 4");
 }
 
 static void test_rpmi_hsm_multi_socket_hart_list(void)
 {
     QTestState *qts;
-    uint32_t start_index = 0;
 
-    qts = qtest_init("-machine virt,rpmi=on "
-                     "-smp 4,sockets=2,cores=2,threads=1");
-    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_LIST,
-                      RPMI_MSG_NORMAL_REQUEST, &start_index, 1);
-
-    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_LIST,
-                    7 * sizeof(uint32_t));
-    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 1), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 2), ==, 4);
-    g_assert_cmphex(rpmi_response_word(qts, 3), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 4), ==, 1);
-    g_assert_cmphex(rpmi_response_word(qts, 5), ==, 2);
-    g_assert_cmphex(rpmi_response_word(qts, 6), ==, 3);
+    qts = rpmi_qtest_init(&virt_rpmi_machine,
+                          " -smp 4,sockets=2,cores=2,threads=1");
+    rpmi_check_hsm_hart_list(qts, 4);
 
     qtest_quit(qts);
 }
@@ -512,7 +606,7 @@ static void test_rpmi_hsm_hart_status(void)
     QTestState *qts;
     uint32_t hart_id = 3;
 
-    qts = qtest_init("-machine virt,rpmi=on -smp 4");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -smp 4");
     rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_STATUS,
                       RPMI_MSG_NORMAL_REQUEST, &hart_id, 1);
 
@@ -560,7 +654,7 @@ static void test_rpmi_hsm_hart_control(void)
     uint32_t start_index = 0;
     uint32_t suspend_type = 0;
 
-    qts = qtest_init("-machine virt,rpmi=on -smp 2");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -smp 2");
     rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_SUSPEND_TYPES,
                       RPMI_MSG_NORMAL_REQUEST, &start_index, 1);
     rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_SUSPEND_TYPES,
@@ -612,7 +706,7 @@ static void test_rpmi_syssusp_attrs_and_suspend(void)
     uint32_t suspend_type = 0;
     uint32_t suspend_request[] = { 0, 0, 0x80000000, 0 };
 
-    qts = qtest_init("-machine virt,rpmi=on -smp 1");
+    qts = rpmi_qtest_init(&virt_rpmi_machine, " -smp 1");
     rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_SUSPEND,
                       RPMI_SYSSUSP_SRV_GET_ATTRIBUTES,
                       RPMI_MSG_NORMAL_REQUEST, &suspend_type, 1);
@@ -682,5 +776,18 @@ int main(int argc, char **argv)
                        test_rpmi_syssusp_attrs_and_suspend);
     }
 
+    if (qtest_has_machine("riscv-server-ref")) {
+        qtest_add_func("/riscv/rpmi/rvserver-ref/machine/rejects-rpmi-property",
+                       test_rpmi_rvserver_ref_rejects_rpmi_property);
+        qtest_add_func("/riscv/rpmi/rvserver-ref/fdt/service-nodes",
+                       test_rpmi_rvserver_ref_fdt_service_nodes);
+        qtest_add_func("/riscv/rpmi/rvserver-ref/default/platform-info",
+                       test_rpmi_rvserver_ref_default_platform_info);
+        qtest_add_func("/riscv/rpmi/rvserver-ref/base/probe-service-groups",
+                       test_rpmi_rvserver_ref_probe_service_groups);
+        qtest_add_func("/riscv/rpmi/rvserver-ref/hsm/hart-list",
+                       test_rpmi_rvserver_ref_hsm_hart_list);
+    }
+
     return g_test_run();
 }
-- 
2.43.0


