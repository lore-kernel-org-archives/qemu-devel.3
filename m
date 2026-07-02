Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64786C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHpX-0001dP-Q1; Thu, 02 Jul 2026 09:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpW-0001cB-IP
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:51:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpU-0007zU-SU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:51:50 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0hSs406697
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 07Mr/F77VBKYNNIOnmRloxxT0PvC5uRaB/9P7jBmWyg=; b=SGXgxYx73YVOfyTY
 5jPhctl+kOLXqVkXennA+n9oKOrMuOaYj3rtmJNkV3Du66t2ewnKCW2BtTo8Qxh3
 bUlnjw/NjRSTKmOKPY5I9yMUsGWpIm2CKJNL8JmDcsWMazYMSG20VC5Vgh8Ee4dy
 dUtHON2z2ErlBO1VEEa8VpXmfiHI4X/VWQYZeqL41T71aijtzPpZL0cbGRUoibnr
 20KdV33C0pZidJIPXgebEdtprF6NxjSn2TNzG3mgewGacxxFGcLbWTRI10aWPeBA
 k3Cx3aKPPEP+52GW2TzBbJC8KY903J9q37B+StBbP7BXmH4NjiQqojtLoJJzW8Eh
 i0xsRQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h98j0ya-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:51:47 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-736e9030d93so1870088137.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000307; x=1783605107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07Mr/F77VBKYNNIOnmRloxxT0PvC5uRaB/9P7jBmWyg=;
 b=kXzn7K1ggla+iXfSLzxR10Mm/SISYxJFHZrWBx1yfaR/6biJD+lpkuihMO06kqEVwB
 qDzuvhhMeQyrwdzCxvC3WIqUeJM0FWjv1+QnHUX/3VfwF0d84kXpOIpS9hwXS79yMMaR
 bZbBzy+DRTcbJX4nGt6s/pSIySy4xsVVu3/uXqvW4opvPoSPC6VulaYAJ3HGpxJqIs/x
 3MZIjG9sbq+xuc32LysMb/+ocH6agiQeNV2b4LqU/wVbciSWQKED3FAjXdd7DI3LMWrE
 efmBv9GvTs9pOh0tptsnadmsDtQvGYd/ZjMLncpGhC/1ZW7hI3Xd7vU/xI52Oj4vD8lb
 vw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000307; x=1783605107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=07Mr/F77VBKYNNIOnmRloxxT0PvC5uRaB/9P7jBmWyg=;
 b=qZRTQYHfExvKbKe7H5m5AjGb5QHkdwhd+Xa8ToMoD34mI6FT+ROzZSL3LyF3XKvZ+Q
 d9R5VSXnlxuOQxJRyh8Tkp+WxLnQxeqhe3jiQ0g9XgEi/7jvoktYjJC0no3h0grqE1I2
 TUeW/WA/1Ssc0j5SpqPeyI7CnANazGxrKj5TdDRQi9Rz8Nq04lbSQG4XANsLChgoeAXA
 ETzQVXTe4OAZ8EfqdgPG8l6MdPNTLYoqI48Ab+QQkRWw9RkTDtzypF//jAoAj1h299Kn
 gliIGA0l7jS7JiNRy36cqsbHXfdCFOGv9WmjfWI2SuLpylPOOkXBKuBaCWuroeypbraT
 cYqg==
X-Gm-Message-State: AOJu0YwDPJdEaOAzuPqUwNG0iH6UY8NMGdlcPqvS08Boc3qQ3Hao3Mhp
 FrYY8KtUXmvfh7RhzcZ7/lODWAJV67DMFK0VJeVTln71HmhYr3lAqRuIGIwoT0o7FXeLcmjHp/9
 Fc5a1zNDgsLwUvJpxyRqW0BtYzR3OrSLui5VAWHTLraxa3Mlk4Dqzx8kYFTdmsbrE+g==
X-Gm-Gg: AfdE7ckJrG04JujEHMW/3OjM1PGXi3dGQ0ENrLHdIeV1EPy7mOBwjLVRw2umcL3NSv6
 afqYZqBz3OJY1ywUjz+A2obYmF1CP0G2sZLW2uPGZ809zQEAhHgeJ75APkecL+ACt0CuLEfYAKK
 SmjWiaeflms00GJxEMePX78SviKN7DUWsB+wv5lLjbiasKqyobJi18QsHIhOYCzA2g1NKips6K5
 XNgmkSXux9idtqjW1/jwZElwFNQzWzgon/GX365r5feE7lZRDpAFNRiXF69EvMxl0ise5I8fhRg
 4HagRYBCrKl/blSHDEmlkvSsSfnJtGezdo89JVXcyoYGjkop3DQw+euAjQyG42GyLDmPWcVrsFK
 fUGLyVMm5jyRkUjGUU8WIpsVazyYpFWxIcGwqg6O91DIhCw==
X-Received: by 2002:a05:6102:4c03:b0:73e:9fae:583c with SMTP id
 ada2fe7eead31-73e9fae59f7mr643485137.18.1783000307180; 
 Thu, 02 Jul 2026 06:51:47 -0700 (PDT)
X-Received: by 2002:a05:6102:4c03:b0:73e:9fae:583c with SMTP id
 ada2fe7eead31-73e9fae59f7mr643466137.18.1783000306619; 
 Thu, 02 Jul 2026 06:51:46 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:51:46 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 05/24] target/riscv: tidy up riscv_sysemu_ops
Date: Thu,  2 Jul 2026 10:51:07 -0300
Message-ID: <20260702135128.1188021-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5YtVM2pQjlMd3RF_roqouSlR07K8g8V2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX+pmG6UYsebHx
 NAvd+Xb14WnU3PNiC4yTc17Q/jBOMiVzny/MHgjQPCJ44nbqciqhmp4h5dCTGDjXxsgJAIrTDQG
 yjbpeanrqhQ3kKhMAISatAPOHu0WJw6NlIF//9TkPjTjV1r28zCjtbVhMHtXT5Lw0vSO5DMYvmF
 xgqoOq5iGcKc/gtD/bLxtcsaVhhSIN5hhE0MZPZZFRg9+z77EfldNRBVBtMzGrlTzYQjhAxqGYe
 uiGS1CZO5ejkCEUr0J3wAxr0e5ePM7YOw+B2n96k14NOPoxuLxyHnE5pRz9gXP3uWKxoq2Ir2/p
 n0sM+kcFsMegJ7dFPHv7hXHhUJPuqlG6jBrODBV9h6EaiFCacwv0NiQ85I8TrvYZ6i151Pwjq09
 C079xGrPbOgjWBYA/ksOeTfKXPnrUnVk86BOMnhmI2lMfXJz41E3J3rj1LwT5UFf51rLui8V8dN
 oLkAehCs3AChHTFYQvA==
X-Proofpoint-GUID: 5YtVM2pQjlMd3RF_roqouSlR07K8g8V2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfXxVawWjqUxjQ7
 tlMNb+uwuhgHhixI6pIcJUJMnvj3sYgLZYltl+iepl7Rl1cQB12kIc3nZjjMyZTpzJkuSFhHcH5
 jfsWC/2k8gF5fgEVwjkoA9XYoeC1X4A=
X-Authority-Analysis: v=2.4 cv=bdFbluPB c=1 sm=1 tr=0 ts=6a466cf3 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=t0TUB-rRe_9fwXOx4ZEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

monitor_get_register at this moment has a TCG exclusive implementation
for RISC-V, even though the callback is supposed to be arch independent.
Until we address how KVM is going to implement it we need to filter it out
in cpu.c.v

Same goes for get_phys_addr_debug - it has a TCG only implementation and
KVM can't use it for now.  It would also need to be filtered out, but
since we're at it, let's convert it to the newer 'translate_for_debug'
API too.  Same restrictions apply.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c            |  6 ++++--
 target/riscv/cpu.h            |  3 ++-
 target/riscv/monitor.c        |  2 ++
 target/riscv/tcg/cpu_helper.c | 14 ++++++++++----
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7664e686fa..65c6556c9f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2680,11 +2680,13 @@ static int64_t riscv_get_arch_id(CPUState *cs)
 
 static const struct SysemuCPUOps riscv_sysemu_ops = {
     .has_work = riscv_cpu_has_work,
-    .get_phys_addr_debug = riscv_cpu_get_phys_addr_debug,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
-    .monitor_get_register = riscv_monitor_get_register_legacy,
     .legacy_vmsd = &vmstate_riscv_cpu,
+#ifdef CONFIG_TCG
+    .translate_for_debug = riscv_cpu_translate_for_debug,
+    .monitor_get_register = riscv_monitor_get_register_legacy,
+#endif
 };
 #endif
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f0c78c1474..70b8729bd7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -665,7 +665,8 @@ void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      MMUAccessType access_type,
                                      int mmu_idx, MemTxAttrs attrs,
                                      MemTxResult response, uintptr_t retaddr);
-hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool riscv_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                   TranslateForDebugResult *result);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 3e89dcaf7c..7aacd1d89c 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -245,6 +245,7 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
     mem_info_svxx(mon, env);
 }
 
+#ifdef CONFIG_TCG
 static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
                                  target_ulong *val, bool is_gprh)
 {
@@ -379,3 +380,4 @@ int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
 
     return -EINVAL;
 }
+#endif
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 2db07f5dfb..885b4172c0 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -1779,7 +1779,8 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
     env->two_stage_indirect_lookup = two_stage_indirect;
 }
 
-hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool riscv_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                   TranslateForDebugResult *result)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
@@ -1789,17 +1790,22 @@ hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 
     if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_idx,
                              true, env->virt_enabled, true, false)) {
-        return -1;
+        return false;
     }
 
     if (env->virt_enabled) {
         if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL,
                                  0, MMUIdx_U, false, true, true, false)) {
-            return -1;
+            return false;
         }
     }
 
-    return phys_addr;
+    *result = (TranslateForDebugResult) {
+        .physaddr = phys_addr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
 
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
-- 
2.43.0


