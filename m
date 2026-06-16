Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97123CD98E6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQk2-0000ay-Mi; Tue, 16 Jun 2026 06:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQk0-0000CW-8o
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:56 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjx-00049d-Uh
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:55 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-37c64d34032so72747a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604592; x=1782209392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JWKe4G97S2HY13cere3BvmAT0JMJSJuujZjHesFoJwk=;
 b=BWzotMcxGT+vtqFDfNXXVXnauuhfYosRf+dZLHT/rYS4FahK1HxejMrXxiV7EzEet/
 Gc6BA8VWVGHFv6feZBe2paQyCZxSoT1490F8J2v0eV6hjx7XJy6sz7PFyRfsSXIs1XmE
 VvWnMoHUKo9xgwtyNV04bZfaPSMg4+/BWjhExFRq6iLJKhO1IU9cpfxxCNI2gnQxMlpM
 9/hY+82oX4/nYW5PU2lJq+dVW5tlMzZOwXvyi/dgp7ELYYN8W0099l0Ad1lsOtFlXv9b
 EdHOqpXOo3K012B+UW29L0hr59mjLQ4jP5Pofir8JSarN9f9xlPTxDoHNQvreReHfIzu
 PmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604592; x=1782209392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JWKe4G97S2HY13cere3BvmAT0JMJSJuujZjHesFoJwk=;
 b=hJJb02W+92pUc23JN1fKsCdaJvS2FkWziDHgSkuAhhc6DP3CV5YoXbDVYPGdF4gIZ+
 tnUG6CMyFB9KGQMxvMO0pioBfaOW7pxPpz3JYQpk7bAxibn7QjmIn5ReaEuUGwSFzHxd
 HrXsOeYc/5vfUCXOnKXXCV9d6Hz1353zxzQ8TM3bQnQ7pU4AJgxq9h/TcrIYvFb7Jz2w
 FpypQewc2T0gEngf7hrRH8sxGwdezFjE08slkaq1n8IK6kLKBXzlbJsBIN5N9AEiwd2k
 FpnqP2OlAYDkmApD1Q4cdxH9zoFtMvCd+2nhaA/gv3XCd1Hq3T+qHVfK/TO9fCN99bLl
 d/gQ==
X-Gm-Message-State: AOJu0YwDENzFkzdZw9O25oRSjwBWNDfXg6UQKP4DDXBR36mLtFqHhtBU
 VsAT7SHFkieovlewTtiF4MYnU/jP9moG/3yxbkoPMzrOgPkKH+2QymrDRn6x5iAW
X-Gm-Gg: Acq92OHhqFGEQjegxSHEDTBa+9WXbhGdfQrnsno0JZEihjfNZim3jTng1j+moMdtyTJ
 wDarALZgLEZoSVX/5Ebrk/m0E5SIN6/5qDXi8FClNHNvaP6K59QcCm4jgyUpFaGnJBghyYMmFo0
 0Be9QR40UbJED2cPzrvIyzo/qZMrtZKqjp8GWZ7VS+yHDtFVpWz3noaQBQ0UGZ026K5VBEiBrOg
 eT+Gh50P8UCIcJltNAWSbe9qqllxmcrMaPAyH3xI5vz5SWybklcOekRlYPGSF0ioa2Fg6GuTmZd
 ItYWy9/9NtJhhfVjFQTSdSOkTtDjt3kLwWsmwJ1FYxxx9xCRZhciXeOaUy+/SnaSu26OUaeP9eZ
 GuIDKGD+47jNpufcrFPUlmdavSiVoRvzROC40VJa5/PJKi4JxonpbGrPva2tCrqijLy/OEIXvC4
 peJP0IIjAjouKAI8yr0XEnQT8yWRQEFM3mdYMe10d38yFt1uas+TA=
X-Received: by 2002:a17:90b:3d86:b0:35f:c493:cac5 with SMTP id
 98e67ed59e1d1-37c52433cb1mr2590575a91.16.1781604591707; 
 Tue, 16 Jun 2026 03:09:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 73/83] hw/riscv/numa: make numa_enabled() public
Date: Tue, 16 Jun 2026 20:05:16 +1000
Message-ID: <20260616100527.1939565-74-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

There's FDT logic gated around 'numa_enabled()' in virt.c and spike.c.
We want to move the FDT code to a common helper without having to call
hw/riscv/numa.c functions from it, but at the same time being aware of
the FDT changes if numa is enabled.

To do that the boards will inform the FDT helpers if we have
numa_enabled in the env or not.  And for the boards to be able to do
that we need the static 'numa_enabled' function to be public.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260615203734.954428-4-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/numa.h |  8 ++++++++
 hw/riscv/numa.c         | 20 ++++++++++----------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/hw/riscv/numa.h b/include/hw/riscv/numa.h
index e68ce8e8af..ac07786555 100644
--- a/include/hw/riscv/numa.h
+++ b/include/hw/riscv/numa.h
@@ -23,6 +23,14 @@
 #include "hw/core/sysbus.h"
 #include "system/numa.h"
 
+/**
+ * riscv_numa_enabled:
+ * @ms: pointer to machine state
+ *
+ * Returns: true if NUMA is enabled in the machine state.
+ */
+bool riscv_numa_enabled(const MachineState *ms);
+
 /**
  * riscv_socket_count:
  * @ms: pointer to machine state
diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
index 8a144925c1..8933d9d81f 100644
--- a/hw/riscv/numa.c
+++ b/hw/riscv/numa.c
@@ -25,21 +25,21 @@
 #include "hw/riscv/numa.h"
 #include "system/device_tree.h"
 
-static bool numa_enabled(const MachineState *ms)
+bool riscv_numa_enabled(const MachineState *ms)
 {
     return (ms->numa_state && ms->numa_state->num_nodes) ? true : false;
 }
 
 int riscv_socket_count(const MachineState *ms)
 {
-    return (numa_enabled(ms)) ? ms->numa_state->num_nodes : 1;
+    return (riscv_numa_enabled(ms)) ? ms->numa_state->num_nodes : 1;
 }
 
 int riscv_socket_first_hartid(const MachineState *ms, int socket_id)
 {
     int i, first_hartid = ms->smp.cpus;
 
-    if (!numa_enabled(ms)) {
+    if (!riscv_numa_enabled(ms)) {
         return (!socket_id) ? 0 : -1;
     }
 
@@ -59,7 +59,7 @@ int riscv_socket_last_hartid(const MachineState *ms, int socket_id)
 {
     int i, last_hartid = -1;
 
-    if (!numa_enabled(ms)) {
+    if (!riscv_numa_enabled(ms)) {
         return (!socket_id) ? ms->smp.cpus - 1 : -1;
     }
 
@@ -79,7 +79,7 @@ int riscv_socket_hart_count(const MachineState *ms, int socket_id)
 {
     int first_hartid, last_hartid;
 
-    if (!numa_enabled(ms)) {
+    if (!riscv_numa_enabled(ms)) {
         return (!socket_id) ? ms->smp.cpus : -1;
     }
 
@@ -104,7 +104,7 @@ bool riscv_socket_check_hartids(const MachineState *ms, int socket_id)
 {
     int i, first_hartid, last_hartid;
 
-    if (!numa_enabled(ms)) {
+    if (!riscv_numa_enabled(ms)) {
         return (!socket_id) ? true : false;
     }
 
@@ -132,7 +132,7 @@ uint64_t riscv_socket_mem_offset(const MachineState *ms, int socket_id)
     int i;
     uint64_t mem_offset = 0;
 
-    if (!numa_enabled(ms)) {
+    if (!riscv_numa_enabled(ms)) {
         return 0;
     }
 
@@ -148,7 +148,7 @@ uint64_t riscv_socket_mem_offset(const MachineState *ms, int socket_id)
 
 uint64_t riscv_socket_mem_size(const MachineState *ms, int socket_id)
 {
-    if (!numa_enabled(ms)) {
+    if (!riscv_numa_enabled(ms)) {
         return (!socket_id) ? ms->ram_size : 0;
     }
 
@@ -159,7 +159,7 @@ uint64_t riscv_socket_mem_size(const MachineState *ms, int socket_id)
 void riscv_socket_fdt_write_id(const MachineState *ms, const char *node_name,
                                int socket_id)
 {
-    if (numa_enabled(ms)) {
+    if (riscv_numa_enabled(ms)) {
         qemu_fdt_setprop_cell(ms->fdt, node_name, "numa-node-id", socket_id);
     }
 }
@@ -170,7 +170,7 @@ void riscv_socket_fdt_write_distance_matrix(const MachineState *ms)
     g_autofree uint32_t *dist_matrix = NULL;
     uint32_t dist_matrix_size;
 
-    if (numa_enabled(ms) && ms->numa_state->have_numa_distance) {
+    if (riscv_numa_enabled(ms) && ms->numa_state->have_numa_distance) {
         dist_matrix_size = riscv_socket_count(ms) * riscv_socket_count(ms);
         dist_matrix_size *= (3 * sizeof(uint32_t));
         dist_matrix = g_malloc0(dist_matrix_size);
-- 
2.54.0


