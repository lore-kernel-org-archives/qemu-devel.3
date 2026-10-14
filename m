Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB8DCC6B33
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8g3-0006y3-Ok; Wed, 14 Oct 2026 19:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8fy-0006w7-LW
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8fv-0006QD-5s
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:25 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ELrKfN301282
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QEJsJNpBp2x
 y5PjCPdc7tKyPZeSy1OMZSFx4UQcAYTU=; b=fTsVHOqp++zfkyEXWsi78+gLum6
 qskAkPUktfVr2eU45VgRkFg6Uj5WdkpufMKIoqfx/FEokiwAgMmrhWKkNIbyyX5t
 xmr9Eonzl7uMA0/DqjYaF5fI7HOmB+FYg9VfmGjTEquxOWi5suLaD34xX6LErIvr
 kDmGY6svgyLVEqn7AQqPEspExYx6lTAgG52PcCN+x0rIE8HVM/RCq6D0g3JdvM75
 2kpDU6ctQjJ+VCyeEaScMQ9AewK9yivgLlEuttCpeccPUQn9hSqQKkF4TjeSQu1W
 Srmm+ixSfhbcUI8jHLqutKaAoLGWGeOqmpzBrKHDqpbPOUzhcpK+0sOqCRw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4623y24-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c902e0da2so1902148eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021581; x=1792626381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QEJsJNpBp2xy5PjCPdc7tKyPZeSy1OMZSFx4UQcAYTU=;
 b=XSsFqWMtJl5j8no3iD1a/k2+x4OUEwoy5abRdPN9x3lzlQFOrDh10tHnjJqkq0Jj5d
 xV71JTmKYx9b1QrJuRfR6nGOrz8A2y/TQvQAeVhWglCiCwb5ti3K9afuxDu1NFxvAAyK
 29iz4XIs68iSqY+FUR1L8UQ+w1MVeUMvkBr5RD5schq41h3vE0/KIO4t29qjpjdPZdQ6
 W/3xxfuurkpezlnTQxofwg2zpQCxmEpX0Wdr8KWjy7ZqCT4k5rmpq6YxThWD0OOGoJFz
 he4Val6gTzFR7Yb8S/SbNuJFEcxfX9Na6YfuYdT+OAhMqxvbRH0LJ+tcrkW5Xm65LqJW
 1KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021581; x=1792626381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QEJsJNpBp2xy5PjCPdc7tKyPZeSy1OMZSFx4UQcAYTU=;
 b=x23OQUNJZwHOtJsLzxhOcNRSjerfYEm5um5rUef3o0kPi6KZ93OURlJqe92MNhMNbQ
 NZ7bTtMK4Klwc0JUya9aiMi/3jySEDdUurzDCz6QkhBNoxAZzuXUiuvuBugDLkNB7cHh
 QuYPwnXzcdydYFZCT5+Qq0LC4Mb5AnOpIZq1V4X4b2rasFLa8fTym/w2xbxee7R7kOR1
 g6lbrsXT4qa/jnKs9DP5Jv8S3NuSCALpyDGpP8V1ZeLVRQZTnkuMU1uWpVHHlWNW5fng
 n4jwCTQFYq8gon94VwAQZIKxnhGjdvZFA/vKnz4vh+KOMyGTnmol1eYyTvd107+ApnO/
 d+oQ==
X-Gm-Message-State: AFq9FYJeg10LBIGTFiXf9Egm9YTq7vGlAWY3DBymDXOi0nS0luIMfqKa
 qS71sc1LPZUiwEA+TtjBSy4/DbyKZQbM5IdrpH5NHuRzPiWf1NHXlkjKs1OMHDVaJBTIb9KN6Ou
 QVGJ46bKzVMBs7hRMFhqT2ecFheF06dDy+xs6wxV61DYIPkibBhewFaFAky2mxVmyaA==
X-Gm-Gg: AYBFou1bvc7ldivAh5z56O1Jy4ZMFyKCa3xfEjZPXoC7GTYeTuCLkPc8DiCT6Puycsl
 PgGjyhM+/EdssqcqPgNjGHkqjZfSC9TSzeJdzioT1mdVF2GTkcw8TF9IF8llsN+w4WW5E71Cl8U
 XzCxo7zUUNok3gvAIPzpWv7CZFQilUEazFN4BulYmOZSLEcJP/GuPZRDupF/6nDQEpfUaE2uNzQ
 yv2gnC5YBd2BanDBNgF2tHISLixiT3aceAECBW6FoLtsOct/TZXmn5+/fapvz3HPMNC+xvAF/y0
 J7hrT0Jxw2obwiOB5EdYFhtab4yhBYOL/vEM7q/v7EEzDEsdwm3dAsxgZMoOEMsmMmHjAPupbGA
 Y8eznByhG4Ry+K7RYKkCFE9VHsyAn+/3MUslHBfyyRBAo93XwY2N6kXY2qyK3
X-Received: by 2002:a05:701b:2056:b0:143:1bb1:3305 with SMTP id
 a92af1059eb24-16a14bc11e3mr21708777c88.22.1792021581155; 
 Wed, 14 Oct 2026 16:46:21 -0700 (PDT)
X-Received: by 2002:a05:701b:2056:b0:143:1bb1:3305 with SMTP id
 a92af1059eb24-16a14bc11e3mr21708748c88.22.1792021580533; 
 Wed, 14 Oct 2026 16:46:20 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 02/19] target/arm: implement get_dump_info dump op
Date: Wed, 14 Oct 2026 23:45:48 +0000
Message-ID: <20261014234605.209084-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Sh3eaAJH89rfRZpmXiQKg0sGraD0ynaQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX6vTpKP/lENGh
 ILD9FaVP1kAedrsACf618YflVDfxCSlKk+mXCLRDLUFuj9gYmmO8lU8QclvTY/BTWN9QHncFt79
 MZIzxxYRpko3mw+IbDkkPranBQzY9JufNo5Az6oEAc6HVTEmFhuDilfO1rJNtWWhGPzSbl2zGci
 hIz2VahPkLoCQ2mZPVPSLsTxXav8N7eFfKL4JeyYj74THAlw7WcLRTSe4FYJSMybEXYhSrEsv5Q
 qvqPFrRH8E687Y7B6SK2iZySDR4nRQovag7Y4nZ9fO8MnvinOi14qrzy4XQHotaCLrX2wffEeQd
 3if76gdHMpahlMFmdjDIAtazeQAbT6LHw2S00r7gs2rPobHjrTBJEWn4JQAOmsDzGHyjUfPT9Ou
 GFGFw4V/eZ9c0/361fUB27BTHzwCSsOdEbGT5Zden15GRt/X4BZpp03TXQ9glud01bPoTPu0AcE
 ByHwedVqkaUNW/5Aavg==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6ad0144e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=GlaRKuLKSeBc1ljDWskA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX5nlUCrm3UoME
 acpUluDQ8wDLXStr6lcPnTpJvKQsxaQFO+xX2UKc0Fg7gAjnJXiLVzoxryBR14Mzp9GLLgo/gKe
 tyK4nZMu1S7MGNpjJ+cM2oBLq44+ZhQ=
X-Proofpoint-GUID: Sh3eaAJH89rfRZpmXiQKg0sGraD0ynaQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140094
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

For now, we keep the global cpu_get_dump_info symbol defined.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/arch_dump.c | 30 +++++++++++++++++++-----------
 target/arm/cpu.c       |  1 +
 target/arm/internals.h |  1 +
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 1dd79849c13..dcb0ccc6cc6 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -24,6 +24,7 @@
 #include "system/dump.h"
 #include "cpu-features.h"
 #include "internals.h"
+#include "hw/core/dump-cpu-ops.h"
 
 /* struct user_pt_regs from arch/arm64/include/uapi/asm/ptrace.h */
 struct aarch64_user_regs {
@@ -385,21 +386,14 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
+static int arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                             const GuestPhysBlockList *guest_phys_blocks)
 {
-    ARMCPU *cpu;
-    CPUARMState *env;
+    const ARMCPU *cpu = ARM_CPU(cs);
+    const CPUARMState *env = &cpu->env;
     GuestPhysBlock *block;
     hwaddr lowest_addr = ULLONG_MAX;
 
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    cpu = ARM_CPU(first_cpu);
-    env = &cpu->env;
-
     /* Take a best guess at the phys_base. If we get it wrong then crash
      * will need '--machdep phys_offset=<phys-offset>' added to its command
      * line, which isn't any worse than assuming we can use zero, but being
@@ -439,6 +433,20 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
+const DumpCPUOps arm_dump_ops = {
+    .get_dump_info = arm_get_dump_info,
+};
+
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    return arm_get_dump_info(first_cpu, info, guest_phys_blocks);
+}
+
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     ARMCPU *cpu = ARM_CPU(first_cpu);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 81ec1ce21c6..9b84691c475 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2655,6 +2655,7 @@ static void arm_cpu_class_init(ObjectClass *oc, const void *data)
 #ifndef CONFIG_USER_ONLY
     cc->max_as = ARMASIdx_MAX;
     cc->sysemu_ops = &arm_sysemu_ops;
+    cc->dump_ops = &arm_dump_ops;
 #endif
     cc->gdb_arch_name = arm_gdb_arch_name;
     cc->gdb_get_core_xml_file = arm_gdb_get_core_xml_file;
diff --git a/target/arm/internals.h b/target/arm/internals.h
index e849e357cfe..02375704937 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -438,6 +438,7 @@ int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 #endif /* CONFIG_TCG */
 
 extern const struct SemihostingCPUOps arm_semihosting_ops;
+extern const struct DumpCPUOps arm_dump_ops;
 
 typedef enum ARMFPRounding {
     FPROUNDING_TIEEVEN,
-- 
2.43.0


