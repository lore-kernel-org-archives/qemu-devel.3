Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CF1CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhb3-0008Jb-C8; Fri, 16 Oct 2026 09:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXu-000620-Fq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:14 -0400
Received: from out162-62-57-252.mail.qq.com ([162.62.57.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXm-0007jy-U5
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792144076; bh=jxFmuw7ivdvhgW6hJ11m67aKoxUKRDFGQG6HwYXj4b4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H/M3EwzAKqBCYjFzo3mDLXOHbliYBe8Qq+PS5rstbjzHxPvhIVSCv6zSqvm9C4bus
 CQMpk5UI2RSOo9hoOruJ1RZ9jZQnGQHpr0SkTarGvby+4wD9+zmHumP/Il6V1ih6/S
 5iibeR4blOy78BozWO4xd+eEOyXg5XvTqaWqFzzo=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id BF4A1837; Fri, 16 Oct 2026 17:47:52 +0800
X-QQ-mid: xmsmtpt1792144074txrbgu8qu
Message-ID: <tencent_0D8D61C20611EC56598A6F86E7B869052E05@qq.com>
X-QQ-XMAILINFO: N7NMbzIEsXzd/zChzTMPP+C7crTZSEuCflnYJLgEtulAsqcIWhW2WdBhCY5hHI
 M3YTgNwS7+yaeUysWepSTySytVFjW4OVdI+3afi7eZA4pK7mwBn+I/LkVojkmTHsR0Ms2J8LIYPF
 qtNv7PbN9zXYLm6bmz/IWd4pQ9kuwPjUgRSW6w6Glac3ycHo6skHLnMfC5tzKWVp6b5wirqWdlX7
 4P72O9wbbxbsaoVx0bnfXhQrz/PDzzS929y7JS2yyqrVtT4T/ibniXbjs0pXtoANRiREmgof4aOe
 xQXROQftlq+vSJZDBCbjmPxl/HnrQFCydWiz+dPX+KfELITtNvuu3HfOKXbiwhqsRe3Qg0uaMh6i
 JfWDfkqmluwpJcy3uX8++7bEnJ/RgH0S42PcSjsD/VvbDG0jyfmfq6oFyaX6atj4asZ2nRdXay1g
 uj4Rx77yHMfO+BRa+wjhmdbMBTYtU7TcKW964bz0x04cfxcih5BFmT9ptxKFw/WiDWQAmB+wp7i3
 iimXcCGcOFZeF24X505v6M6w/VoDhhObxqmig9BoNy0YbYmGMXH8OF0guBF84SFFXc+CfDLi08ef
 FXyO2YiN/iJjAK8FGpFDNkHCq8aGk32RUYxsvmQwZl1jvOcWQzFnkTbzir2kCjsy1+cQ+72FMMJj
 LtBuGqztGnm8KC3K//ZXOBEeaoYMjG6iv3RvjaaJiZp+tpgxVBrwg5EwO6zzD8/QPZM9DUXZ/ha/
 jxe/cPlf4ej82EdswmUKDXlH9wKaWbU1GFchZUOyGXDrk+yQgIhukOpjjIGbiCJBg/V90C+UqdCr
 Wp5/2DLb10vfwqhZ/4QrtS7Ooe0phjH7mRA8uBDvf6Sb1N39ESmiTmkj2qxJ5k842AryYco2EXHo
 y1MD9AOa2U3hbjTc51cRhzGKxhGwsTIsOZmHuSmRMzczMkEDgZFAb/i1nD9rZkLzrIzhbOseBJ/K
 YeSeuq7cnYksipJxRStiQT+iIHj9JVJLP7p8bviLYNvAqFSIciIAwa01/GcnPET7QfG9Wei5tpU3
 W4XL47dkshO/bTCMB6oC9VX02WmD69stNup7uNXaFih2yIXHMEr2mwfzenDCvTh3FUHRkuzMnr/1
 wjZScZ
X-QQ-XMRINFO: NV153Ut7BKVGEBPxNGBppa2DJCr1urzIPw==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 01/37] target/arm: Add support for MPAM CPU registers
Date: Fri, 16 Oct 2026 17:46:55 +0800
X-OQ-MSGID: <20261016094733.1898485-2-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016094733.1898485-1-2118537295@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.252; envelope-from=2118537295@qq.com;
 helo=out162-62-57-252.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:28 -0400
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add the MPAM system registers for TCG: MPAMIDR_EL1 (RO) reporting 64
PARTIDs and 4 PMGs, and MPAM0_EL1/MPAM1_EL1 (RW, of which only
MPAM1_EL1.MPAMEN is architecturally reset). Advertise FEAT_MPAM via
ID_AA64PFR0.MPAM for TCG CPUs.

It is common to support MPAM on CPU cores, but not in the rest of the
system, so there is little disadvantage in always enabling these.

Based on an RFC series by Jonathan Cameron, adapted to the current
idregs[] storage and access_tid3() naming.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 target/arm/cpu-features.h | 11 +++++++++++
 target/arm/cpu.c          | 10 +++++++++-
 target/arm/cpu.h          |  3 +++
 target/arm/helper.c       | 17 +++++++++++++++++
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a9eebb4..4b7d47b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -459,6 +459,17 @@ FIELD(DBGDEVID, DOUBLELOCK, 20, 4)
 FIELD(DBGDEVID, AUXREGS, 24, 4)
 FIELD(DBGDEVID, CIDMASK, 28, 4)
 
+FIELD(MPAMIDR, PARTID_MAX, 0, 16)
+FIELD(MPAMIDR, HAS_HCR, 17, 1)
+FIELD(MPAMIDR, VMR_MAX, 18, 3)
+FIELD(MPAMIDR, PMG_MAX, 32, 8)
+FIELD(MPAMIDR, HAS_ALTSP, 57, 1)
+FIELD(MPAMIDR, HAS_TIDR, 58, 1)
+FIELD(MPAMIDR, SP4, 59, 1)
+FIELD(MPAMIDR, HAS_FORCE_NS, 60, 1)
+FIELD(MPAMIDR, HAS_SDEFLT, 61, 1)
+FIELD(MPAM1_EL1, MPAMEN, 63, 1)
+
 FIELD(DBGDEVID1, PCSROFFSET, 0, 4)
 
 FIELD(MVFR0, SIMDREG, 0, 4)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 10ac6c9..e7529d5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -439,6 +439,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
         /* Sample rvbar at reset.  */
         env->cp15.rvbar = cpu->rvbar_prop;
         env->pc = env->cp15.rvbar;
+
+        env->mpam1_el1 = R_MPAM1_EL1_MPAMEN_MASK;
 #endif
     } else {
 #if defined(CONFIG_USER_ONLY)
@@ -452,6 +454,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
             env->cp15.rvbar = cpu->rvbar_prop;
             env->regs[15] = cpu->rvbar_prop;
         }
+
+        env->mpam1_el1 = R_MPAM1_EL1_MPAMEN_MASK;
     }
 
 #if defined(CONFIG_USER_ONLY)
@@ -2333,7 +2337,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         FIELD_DP64_IDREG(isar, ID_AA64PFR0, AMU, 0);
         FIELD_DP32_IDREG(isar, ID_PFR0, AMU, 0);
         /* FEAT_MPAM (Memory Partitioning and Monitoring Extension) */
-        FIELD_DP64_IDREG(isar, ID_AA64PFR0, MPAM, 0);
+        FIELD_DP64_IDREG(isar, ID_AA64PFR0, MPAM, 1);
+        cpu->isar.mpamidr_el1 =
+            FIELD_DP64(cpu->isar.mpamidr_el1, MPAMIDR, PARTID_MAX, 63);
+        cpu->isar.mpamidr_el1 =
+            FIELD_DP64(cpu->isar.mpamidr_el1, MPAMIDR, PMG_MAX, 3);
     }
 
     /* MPU can be configured out of a PMSA CPU either by setting has-mpu
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 06ebed4..51a36fa 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -757,6 +757,8 @@ typedef struct CPUArchState {
     struct CPUBreakpoint *cpu_breakpoint[16];
     struct CPUWatchpoint *cpu_watchpoint[16];
 
+    uint64_t mpam0_el1;
+    uint64_t mpam1_el1;
     /* Optional fault info across tlb lookup. */
     ARMMMUFaultInfo *tlb_fi;
 
@@ -1121,6 +1123,7 @@ struct ArchCPU {
         uint32_t dbgdevid;
         uint32_t dbgdevid1;
         uint64_t reset_pmcr_el0;
+        uint64_t mpamidr_el1;
         uint64_t idregs[NUM_ID_IDX];
     } isar;
     uint64_t midr;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ff0b766..896ac0e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6907,6 +6907,23 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_tid3,
               .resetvalue = cpu->isar.mvfr0 },
+            { .name = "MPAMIDR_EL1", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 4, .opc2 = 4,
+              .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_tid3,
+              .resetvalue = cpu->isar.mpamidr_el1 },
+            { .name = "MPAM0_EL1", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 5, .opc2 = 1,
+              .access = PL1_RW, .type = ARM_CP_ALIAS,
+              .accessfn = access_tid3,
+              .fieldoffset = offsetof(CPUARMState, mpam0_el1),
+            },
+            { .name = "MPAM1_EL1", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 5, .opc2 = 0,
+              .access = PL1_RW, .type = ARM_CP_ALIAS,
+              .accessfn = access_tid3,
+              .fieldoffset = offsetof(CPUARMState, mpam1_el1),
+            },
             { .name = "MVFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.43.0


