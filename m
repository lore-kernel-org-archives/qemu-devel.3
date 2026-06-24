Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E5ACDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPrU-0004F4-Hu; Wed, 24 Jun 2026 11:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcPrS-0004Ee-HZ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:49:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcPrQ-0008Qv-Qw
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:49:58 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OFnOr73573068
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 15:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=O87hX3N9D5WYEG0xg2g9RI
 1uIKdcSdayvNfR51WGpYw=; b=SUyAPs3E0cV6IwZF/0hSU+NhUiUHOs63Me4xwi
 UpMWOxUeH4tHBjbFW4Yw53ysIfjuV1hAn0/r0Z27O/0u3Tc/hY7v+hkmrNUTn4yK
 dS9T62rypkwDTqd8uhD/kDIVYAPap+YUcwykORlkL5/xLiQQkpH3Ey8SKOCR33/3
 Kl6pMiGeMw1wP56elCOHvp63t67cab96/VFianDePt8fylIoIWpVKPK//xiE3GzA
 eH5503MQp4tEBQJWvcfV1/CykSUVC9A1P7Pi/H8SxYbx0NlmAg/OCCsKTdntVL6n
 +6oxSOmpUcdLG5RBzdHzzrEq76mR3cIX33WJrh4NlbAsxMJA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0j7dr03e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 15:49:54 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-96751a54044so479902241.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782316193; x=1782920993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O87hX3N9D5WYEG0xg2g9RI1uIKdcSdayvNfR51WGpYw=;
 b=W/Fqp2lhgxvJkT4PAv7qtMHltkpHZMWYB8KWrHJoRdXQdRaDMn/UiHFqnLhRtgdm2p
 q4H2ZOv9bHCMWjX/QEh2pX7wxgBwaeYPoijchD64gGGW+yqkG9bhbf2ON6Ja0MpzEhgL
 +BfBk+uY41pjfoIzjA8RcSSe/XSmBtoZ/6LUlGz9up0YroHFG9ZHmoACGs7IyEcvnwNz
 GGoOtkE8uxhmjJwPHXu9jYNXuY3SC9cmP+wYra99d5SONJDZk8v75Lnm8zVyhNDBCYtf
 l8nsx8DBq+ft98izJNbKmWqnB8WjqNf0AfUaKdMA2W6gzOL33znelfIHUUzh8e1HAv29
 nQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782316193; x=1782920993;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O87hX3N9D5WYEG0xg2g9RI1uIKdcSdayvNfR51WGpYw=;
 b=i9+f1qWUzEbjeppFMb1FtQW64Rj20kAvlBTd4KrfxRlqwIENaJPRFIRm9eoXN3v/aV
 3vY9us9f8Lfb12A3Afc9stU7gKXRFrFg9ft1dA1vHt3e+YM/2KAbE8bWpcH3WN/to78o
 hcU6ygQK/L7WSb280h7974YgIt1zW09sMyPzyU8CKGR7ndk6YI9ZxG9OduQFhsQ2weVS
 XGg4x/Yr+L2SYQ0Rt2rQ6nvbr0X92bwRtU6opcQ4/i57ZjoFC+00OzwMGeHuysQsfkjD
 STg7NbD4i6qE424H05ScGhTkk/N3NS4hcz3iDZ0FcmOtNa0xwCMbyjSRvTTTDau6NwmA
 MaWA==
X-Gm-Message-State: AOJu0Yx9I1tLQ49wjHC//srdMaPZ1f4qbRoTArG1eGV/IpQdd8ejLuki
 E0yEkMvQPHsd7SW1InxyFRDD23+cwmTkBEnHhqkAqsfvGrvPPYQXKbwIb+GQYtOtWVfVdRQwQfC
 DCbECQeH8ZF4wFI6qr3hMG7Zgju0rXtFeLazY9E8Tx6POZzHB7pRsNxyUJfCQOpKutb1M
X-Gm-Gg: AfdE7ckXFFwD9vo58GrVwDC3i8BzbCRvelAoUjDZibXus7w0t5MO2LaBWqrzKzS3gYU
 +n1j/7mpH25DYxwIcHWs3kEULhHhzEMD0LwBW4dDm/Q4a06GrUWf2T0gsnvCqsoffMUC62MuZGs
 YaewLc0FYQ5XTwenElrbaf/uh0oZgr3rncpVn9ACT1PXsciU9DEN8jcnyuyvfTx9CrCJVGt6Y8w
 4vtIeo3Nd3rhJPz3LS/lOJHPYG21Gkk0zcuSCXoydmVhrdIIZ/0fUVhg5ahT+HbmrpuoP54Yeqj
 +P52nOjLBvbct9KnoeShIuBNevdcTHm0bXHlw32kwWoJKxSjMTOvIVDS1jIpHBcfofDMQ3wyghh
 VojsfMV9ghZ6q9Gda9gYgKySl7qwMWBRn8HrGAhUvveYKPewJnWf5LI628SR/6oSoU557
X-Received: by 2002:a05:6102:5490:b0:631:4580:6a46 with SMTP id
 ada2fe7eead31-73114d03920mr2128069137.17.1782316193370; 
 Wed, 24 Jun 2026 08:49:53 -0700 (PDT)
X-Received: by 2002:a05:6102:5490:b0:631:4580:6a46 with SMTP id
 ada2fe7eead31-73114d03920mr2128038137.17.1782316192709; 
 Wed, 24 Jun 2026 08:49:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279b83fsm7163778f8f.29.2026.06.24.08.49.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 08:49:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2] accel/tcg: Remove per-vCPU
 ignore_memory_transaction_failures flag
Date: Wed, 24 Jun 2026 17:49:50 +0200
Message-ID: <20260624154950.47345-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1evs87nwsejsT2o5gaozx4FtiMXs5QX0
X-Authority-Analysis: v=2.4 cv=NvHhtcdJ c=1 sm=1 tr=0 ts=6a3bfca2 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=aNrQXTL019bI_g3bOXgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEzMyBTYWx0ZWRfX8Rc4ZffFAqSR
 /F0zr7IJkXShuNUJvware0CtBliL4guErjtixpwXTiYU+6PfklFLBsOxHnHJiqCQgjE/Dkm3N73
 ZeeDpxMUnfYPDG0DQFVK809y7OE6vYo=
X-Proofpoint-ORIG-GUID: 1evs87nwsejsT2o5gaozx4FtiMXs5QX0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEzMyBTYWx0ZWRfX+nVlimZhpkW7
 5KPPUeUkH2uRcEkYwAmq0ofQmVskbgdEPcx0VvAhhWtiY16Ckl0oewzLM+V02ZTShup5CPFnbhy
 kHqxOtJ2nYAVpazGHMDQT+rPWbq9tjSDWlBpIuyBDdR0EvCMq1dljkrk5R69KR/AEb6Gzmm3Lxr
 2D0F7PYaJQSYun4bWLS43zMUgiHshWONjsab0rSopqBeM55bIdCWAM8ntH3Ehr1sRf1nV7oQEz7
 LEulq6S3pxQpaSUwuj+le3BJef9I3e6teUW0yb/I/2oD/IxfHaIn6w8Wp8PRL77DzGL+mxrLxsH
 UsM/jrAZVTBwWDsesFr9jZY8xEja0+IKbacq5sjUVc1QgxBgysOyur8laJ8Yq1EeNn2V+Qlexfe
 Gl4NOHgdEb+5hsX5qa0H4xNcDvfDjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240133
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The %ignore_memory_transaction_failures flag is meant for legacy
machines, and is defined once per machine. It is applied to all
vCPUs such machine creates, to be eventually only used by the TCG
SoftMMU layer.
We can decouple it of the vCPU layer by making it a TCG-specific
global, setting it once when the machine is initialized (via the
per-accelerator init_machine callback), allowing to remove machine
code in the common vCPU layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/tcg/internal-common.h |  2 ++
 include/hw/core/cpu.h       |  2 --
 accel/tcg/cputlb.c          |  8 ++++++--
 accel/tcg/tcg-all.c         |  3 +++
 hw/core/cpu-common.c        | 15 ---------------
 5 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 9e7be2d78df..cd8896bafd5 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -21,6 +21,8 @@ extern bool one_insn_per_tb;
 
 extern bool icount_align_option;
 
+extern bool tlb_ignore_memory_transaction_failures;
+
 /*
  * Return true if CS is not running in parallel with other cpus, either
  * because there are no other cpus or we are within an exclusive context.
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 59d601465b4..72666189774 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -575,8 +575,6 @@ struct CPUState {
      */
     int64_t throttle_us_per_full;
 
-    bool ignore_memory_transaction_failures;
-
     /* Used for user-only emulation of prctl(PR_SET_UNALIGN). */
     bool prctl_unalign_sigbus;
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6e66f3c6e93..9028f386965 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -90,6 +90,8 @@
  */
 QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
 
+bool tlb_ignore_memory_transaction_failures;
+
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
 static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
@@ -1291,8 +1293,10 @@ static void io_failed(CPUState *cpu, CPUTLBEntryFull *full, vaddr addr,
                       unsigned size, MMUAccessType access_type, int mmu_idx,
                       MemTxResult response, uintptr_t retaddr)
 {
-    if (!cpu->ignore_memory_transaction_failures
-        && cpu->cc->tcg_ops->do_transaction_failed) {
+    if (unlikely(tlb_ignore_memory_transaction_failures)) {
+        return;
+    }
+    if (cpu->cc->tcg_ops->do_transaction_failed) {
         hwaddr physaddr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
 
         cpu->cc->tcg_ops->do_transaction_failed(cpu, physaddr, addr, size,
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 8eb4a6b89e8..1b1ac0dbab6 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -107,9 +107,12 @@ static int tcg_init_machine(AccelState *as, MachineState *ms)
     unsigned max_threads = 1;
 
 #ifndef CONFIG_USER_ONLY
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     CPUClass *cc = CPU_CLASS(object_class_by_name(target_cpu_type()));
     bool mttcg_supported = cc->tcg_ops->mttcg_supported;
 
+    tlb_ignore_memory_transaction_failures = mc->ignore_memory_transaction_failures;
+
     switch (s->mttcg_enabled) {
     case ON_OFF_AUTO_AUTO:
         /*
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index e314f916f84..b74a39c96ac 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -32,7 +32,6 @@
 #include "exec/log.h"
 #include "exec/gdbstub.h"
 #include "system/tcg.h"
-#include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "trace.h"
 #ifdef CONFIG_PLUGIN
@@ -247,20 +246,6 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
 static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
-    Object *machine = qdev_get_machine();
-
-    /* qdev_get_machine() can return something that's not TYPE_MACHINE
-     * if this is one of the user-only emulators; in that case there's
-     * no need to check the ignore_memory_transaction_failures board flag.
-     */
-    if (object_dynamic_cast(machine, TYPE_MACHINE)) {
-        MachineClass *mc = MACHINE_GET_CLASS(machine);
-
-        if (mc) {
-            cpu->ignore_memory_transaction_failures =
-                mc->ignore_memory_transaction_failures;
-        }
-    }
 
     if (dev->hotplugged) {
         cpu_synchronize_post_init(cpu);
-- 
2.53.0


