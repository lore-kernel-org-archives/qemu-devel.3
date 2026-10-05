Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0CECA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDqBL-0006wo-EH; Mon, 05 Oct 2026 17:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDqBI-0006w9-NK
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:25:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDqBG-0001Dl-LX
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:25:08 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695KNDIg2955183
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 21:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FkgsZdWbkm7aLsdM/IoMQPbXDn/aoXwohan6nzbxcXg=; b=Y8EM7MedoVKxG35H
 5SPVW4zi77/m6Y3quhik1hzbKXooEFxmGNnK/qfKqLckM6JkT1EZUAmGsZYLjkqv
 znUamj+nEKe0u0j5ONM9l8Oh80FUfgzNbNTOm0x7V5lO/mT2/wsRSL9gUHO9eLpC
 iHAT6iejP8N5wiVEJ2Dv9P9HhYB2YCe4tK1NgVra5Lm5ya85y+9u6G1ieHQUuiIu
 xvAmrsOMGRRdl/HjhdZ7Gg52K7FrChH8h2nKn3Sqt5T4pEj89JhOKLc04n5pr3RQ
 TiOgxorqGY18Dh3QUtU77wrvabSQc3N1nCLR2gsOf45+i6kYDD93KDppbqIsN1Ha
 S5Z3rw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cj61wk7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 21:25:05 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1438719cc1eso3184614c88.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 14:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791235504; x=1791840304; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FkgsZdWbkm7aLsdM/IoMQPbXDn/aoXwohan6nzbxcXg=;
 b=aixjs2kqw6SSEVpJ5cYNADFpfVwtcRE6VQIyJHQbL6cl9Z9POf5BOxN+UqqY0ONHs9
 OtFfYFdWbfh+Tvhbzkdy8+GOTzyTD/WDC439c9nFPhTCO4cqEgWaYwLTLh05Do+lSWov
 1gu7EX6YBsbIGldxrixC2+WJhD+ksiDnpX7PPE6y2736MmyXOKWbodc6ebuoaSiR/YO0
 NG9xXbRuOEFep5Lrvqlvrrg7jmNDvF9pqYjmfMOBGqv+McZht8qpPEVwgEOMyDiYdUqv
 4gET7nCvScKGTyYFxSqdgNNYUOoOzV9meLEkoi2KE+rLjaLOU9urGI1hUS8fmr3HmDhb
 dryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791235504; x=1791840304;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FkgsZdWbkm7aLsdM/IoMQPbXDn/aoXwohan6nzbxcXg=;
 b=m0381flY/IL95xGjWkSU29Zv8fPUiFIaPtS5ldSMDAHb9r+kpzsIaxyd313VKgjF+3
 iycMoUVKK929KlZlVOLQnoHvUPlPZOXmIBM2x+hApScIRiIi72x651Q3AiSLcinxhiAA
 wtQVI4JbIg3jmt++eiydTgsrB1J5oofdgl3aNeq2hD2U1lXm15LbQ+c7HvwAUJL38rwh
 p+dDBa3yDUPXamvelSwZJyQ5X5n0ZLCThAsp0Td1NL3o0N+EGZtU4+PFADxMoBCGS8VU
 uS7v4KnUlrS2kyLkU5djM7NBlgGzqfrdjhVQ5EgAAOsaGi/meE7CYQxkGqFEjAZwfFvR
 +rEA==
X-Gm-Message-State: AFuF++nsTDi+QvQgBRMg1ofjPKQ8/OhDRA69YAj9TliIqHg7xxSMnrO+
 ptxc1WO9607d/gjZSJGcNvJMwWJNHJeuawC2/6PYuWCWWP22l8ahkUo/1zoxb31R/7usw1UuZER
 MB6JCyZlCAbWQJayRvxDL4+m2WwA8OoyyD26jezwt52kqog6ETmANbe7UFRfJ8OTgUw==
X-Gm-Gg: AYBFou2VV/hzmWhrkhVHRJOuLxDAYguQCormN3Z/85Mo8d3QaeqviONU9616exk49kr
 YGtM8Drc7aiRJDNUKSViCgxcQ/eybVcrBLCfiVFeaXnIiUuaM5RuutqdrYTIhQNhQ5Kc4Aaw0d5
 5ZrPgFUkpfd7bhuTQ7QxLA8hjWuPLCXgHPA+3lRS7pSQdZGP+bUdCD6SL4nBcI1lkT5LpQprprO
 sIVqpge12kiICjq4cZw38U/hU6NS5Ev2uE2zgirUHMtbyAgnw9D7uYrzOiCUdtwI6UQWLpBTmL7
 6pPTZ8Ds03VDgoEmUuybPT7UUwWsPQSm9m9SfGrzzWrzlMBjxU97UTb8/+srPObXaoq8LlE0VNg
 asIP79TRth6/K+t9VkbUWsgms+2mcoawim4UrmZ59M1ujm7oAGtQaH61F7TrQ
X-Received: by 2002:a05:701b:4552:10b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-151be1472c2mr11383990c88.0.1791235503913; 
 Mon, 05 Oct 2026 14:25:03 -0700 (PDT)
X-Received: by 2002:a05:701b:4552:10b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-151be1472c2mr11383950c88.0.1791235503190; 
 Mon, 05 Oct 2026 14:25:03 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d819cbe53sm869166c88.3.2026.10.05.14.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 14:25:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/2] contrib/plugins/uftrace: add support for Hexagon
Date: Mon,  5 Oct 2026 21:24:57 +0000
Message-ID: <20261005212458.970-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005212458.970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005212458.970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NCBTYWx0ZWRfX1gY0t0iwTR/R
 bV6IYpDhPPCLwv0KiQ4PXKN2ITqdBVUUIdnON5YLxI+Qw4XLobWWznHiacCYNYh11FIqbZZmLNd
 4zSe7aG3hYnmZfQ32/wVHbTorsEWydgwA61Wv4LjEf+FIjo02a4G5K9eJqlx2n6T41j0xX0lUYt
 ntTMswQE7yoMOiazwFjSyX83cA31jFsEZjYzA0MHVL+WS8mI6D7T+IIa+LoswhlgGZtQ6o8vW4r
 hLhDzvy9TcfGEteP4a/puSdix2iHC1xskP6fUiWrzNXjd0GdvRCl9XHVjgceEb2RwalzJQJv7zv
 Xdy2YRshrZlsK1zKARQYlYd1+r/4kL5IKB1KkIubIhUgbTo+WHJJOv2VWh6+o+wWBscDK6tEPM5
 ldEZ41m85Hoi+A+Pi5wRi7aRzTkC8S4qL6g3fhxO6ZqBcYz6mhEM5T42HvfmVrzW2QH9snP7rqt
 efbXegan5w4Wcgws1jA==
X-Proofpoint-GUID: LMAkopP502ABwB4RjiwKLGFrKdDBsqMz
X-Proofpoint-ORIG-GUID: LMAkopP502ABwB4RjiwKLGFrKdDBsqMz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NCBTYWx0ZWRfX0DvB6/xNXZgr
 Qf4+GORJ+LkkVbcIEg9Ga351M1gGmZaEbt3EfuyOcXgEKNNgBzh03jkjNIZuOMet1HadONF277Y
 yv8M/cSw2eP/v+AmvfFYlRST4oQ5eFE=
X-Authority-Analysis: v=2.4 cv=bpTZl0ai c=1 sm=1 tr=0 ts=6ac415b1 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8
 a=MhDYaDWG1lcBpJ2ZbOkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050084
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260930175519.3601312-1-brian.cain@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/uftrace.c | 130 ++++++++++++++++++++++++++++++++++++++
 docs/about/emulation.rst  |   2 +-
 2 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 063e32220b1..bf4ca7c6894 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -99,6 +99,19 @@ typedef struct {
     struct qemu_plugin_register *reg_cr0;
 } X64Cpu;
 
+typedef enum {
+    HEX_MONITOR,
+    HEX_GUEST,
+    HEX_USER,
+    HEX_PRIVILEGE_LEVEL_MAX,
+} HexagonPrivilegeLevel;
+
+typedef struct {
+    struct qemu_plugin_register *reg_fp;
+    struct qemu_plugin_register *reg_ssr;
+    struct qemu_plugin_register *reg_framekey;
+} HexagonCPU;
+
 typedef struct {
     struct qemu_plugin_register *reg_fp;
     struct qemu_plugin_register *reg_priv;
@@ -453,6 +466,21 @@ static uint64_t cpu_read_memory64(Cpu *cpu, uint64_t addr)
     return *((uint64_t *) buf->data);
 }
 
+static uint32_t cpu_read_memory32(Cpu *cpu, uint64_t addr)
+{
+    if (!addr) {
+        return 0;
+    }
+    GByteArray *buf = cpu->buf;
+    g_byte_array_set_size(buf, 0);
+    bool read = qemu_plugin_read_memory_vaddr(addr, buf, 4);
+    if (!read) {
+        return 0;
+    }
+    g_assert(buf->len == 4);
+    return *((uint32_t *) buf->data);
+}
+
 static void cpu_unwind_stack(Cpu *cpu, uint64_t frame_pointer, uint64_t pc)
 {
     g_assert(callstack_empty(cpu->cs));
@@ -698,6 +726,106 @@ static CpuOps x64_ops = {
     .does_insn_modify_frame_pointer = x64_does_insn_modify_frame_pointer,
 };
 
+static uint8_t hexagon_num_privilege_levels(void)
+{
+    return HEX_PRIVILEGE_LEVEL_MAX;
+}
+
+static const char *hexagon_get_privilege_level_name(uint8_t pl)
+{
+    switch (pl) {
+    case HEX_MONITOR: return "monitor";
+    case HEX_GUEST: return "guest";
+    case HEX_USER: return "user";
+    default:
+        g_assert_not_reached();
+    }
+}
+
+#define HEX_SSR_FIELD_UM 16
+#define HEX_SSR_FIELD_EX 17
+#define HEX_SSR_FIELD_GM 19
+
+static uint8_t hexagon_get_privilege_level(Cpu *cpu_)
+{
+    HexagonCPU *cpu = cpu_->arch;
+    uint32_t ssr = cpu_read_register32(cpu_, cpu->reg_ssr);
+    bool ex = (ssr >> HEX_SSR_FIELD_EX) & 1;
+    bool um = (ssr >> HEX_SSR_FIELD_UM) & 1;
+    bool gm = (ssr >> HEX_SSR_FIELD_GM) & 1;
+
+    if (ex || !um) {
+        return HEX_MONITOR;
+    } else if (!ex && um) {
+        return gm ? HEX_GUEST : HEX_USER;
+    }
+    g_assert_not_reached();
+}
+
+static uint64_t hexagon_get_frame_pointer(Cpu *cpu_)
+{
+    HexagonCPU *cpu = cpu_->arch;
+    return cpu_read_register32(cpu_, cpu->reg_fp);
+}
+
+static uint64_t hexagon_get_next_frame_pointer(Cpu *cpu_, uint64_t fp)
+{
+    return cpu_read_memory32(cpu_, fp);
+}
+
+static uint64_t hexagon_get_next_return_address(Cpu *cpu_,
+                                                uint64_t frame_pointer)
+{
+    HexagonCPU *cpu = cpu_->arch;
+    uint64_t framekey = cpu_read_register32(cpu_, cpu->reg_framekey);
+    uint64_t scrambled_lr = cpu_read_memory32(cpu_, frame_pointer + 4);
+    uint64_t lr = scrambled_lr ^ framekey;
+    return lr;
+}
+
+static void hexagon_init(Cpu *cpu_)
+{
+    HexagonCPU *cpu = g_new0(HexagonCPU, 1);
+    cpu_->arch = cpu;
+    cpu->reg_fp = plugin_find_register("r30");
+    if (!cpu->reg_fp) {
+        fprintf(stderr, "uftrace plugin: frame pointer register (R30) is not "
+                        "available.\n");
+        g_abort();
+    }
+    cpu->reg_ssr = plugin_find_register("ssr");
+    if (trace_privilege_level && !cpu->reg_ssr) {
+        fprintf(stderr, "uftrace plugin: trace-privilege-level is not "
+                        "supported for hexagon-linux-user.\n");
+        g_abort();
+    }
+    cpu->reg_framekey = plugin_find_register("framekey");
+    g_assert(cpu->reg_framekey);
+}
+
+static void hexagon_end(Cpu *cpu)
+{
+    g_free(cpu->arch);
+}
+
+static bool hexagon_does_insn_modify_frame_pointer(const char *disas)
+{
+    return strstr(disas, "alloc") ||
+           strstr(disas, "R30") || strstr(disas, "R31:30");
+}
+
+static CpuOps hexagon_ops = {
+    .init = hexagon_init,
+    .end = hexagon_end,
+    .get_frame_pointer = hexagon_get_frame_pointer,
+    .get_next_frame_pointer = hexagon_get_next_frame_pointer,
+    .get_next_return_address = hexagon_get_next_return_address,
+    .get_privilege_level = hexagon_get_privilege_level,
+    .num_privilege_levels = hexagon_num_privilege_levels,
+    .get_privilege_level_name = hexagon_get_privilege_level_name,
+    .does_insn_modify_frame_pointer = hexagon_does_insn_modify_frame_pointer,
+};
+
 static uint8_t riscv64_num_privilege_levels(void)
 {
     return RISCV64_PRIVILEGE_LEVEL_MAX;
@@ -984,6 +1112,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         arch_ops = x64_ops;
     } else if (!strcmp(info->target_name, "riscv64")) {
         arch_ops = riscv64_ops;
+    } else if (!strcmp(info->target_name, "hexagon")) {
+        arch_ops = hexagon_ops;
     } else {
         fprintf(stderr, "plugin uftrace: %s target is not supported\n",
                 info->target_name);
diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index c58149086cd..b404c5c5e8e 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -836,7 +836,7 @@ Uftrace
 This plugin generates a binary trace compatible with
 `uftrace <https://github.com/namhyung/uftrace>`_.
 
-Plugin supports aarch64, x64 and riscv64, and works in user and system mode,
+Plugin supports aarch64, x64, riscv64, and Hexagon, and works in user and system mode,
 allowing to trace a system boot, which is not something possible usually.
 
 In user mode, the memory mapping is directly copied from ``/proc/self/maps`` at
-- 
2.43.0


