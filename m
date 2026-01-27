Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E77CD2FED7
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vko52-00018D-SO; Tue, 27 Jan 2026 13:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4j-0000WX-O2
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:46:08 -0500
Received: from p-east2-cluster6-host3-snip4-10.eps.apple.com ([57.103.76.141]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4e-0007dv-W4
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:46:05 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 874D8180012E; Tue, 27 Jan 2026 18:45:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769539547; x=1772131547;
 bh=rpSFCI+QqGb3ohC4QQ6TECC81hIdPFiycu6b4PZtmG4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XQb9CVZA3RmkxkIlJ1nsPdvQ651FdepLaJKI0vntPBkW8APOjjr/tdvCxRsjRTUDZhk6K8BCmpDWS6eB9MiHLIhnOWajhzLcn53x0OzB51MsemIslOmPozn95KqwDsi1TxVRci+FkPN1K3ICKLObQzTXtWfQKNIAugk5O4PpOJCl7Og7xYHQKJq2svzxZ+AgVfH4KD7zPlTgvRGMbvII9kUwrUJTCzCC/JcLWrwW647yJE6v1XVCCNChC6dl+rA2GERRiPAF67IQAEePmAMiAjHQZkb4UAK7fJrDM8LUFD78N+bb6l5sK30/3b9x3n9Kx2AE/mvoxI7HdtNdEL0rZg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 6068518021D5; Tue, 27 Jan 2026 18:45:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v9 10/12] hvf: sync registers used at EL2
Date: Tue, 27 Jan 2026 19:45:21 +0100
Message-ID: <20260127184523.5357-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127184523.5357-1-mohamed@unpredictable.fr>
References: <20260127184523.5357-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MyBTYWx0ZWRfX+Svg/7iuHIsw
 /Bg00bdUGOCGCf5T8Nre3Qky96sbtt0QajYK+M5e9lz/x77XHGxQbZx/9Wh+nK7B1m58vmW8f7r
 YytxskKSO0Jz7dhn36iLUjljs/uM0Gx0NChIJbFbTIo0rarmGWxapOcdbYiz2mI1MXBYEgwmB9J
 TE4N1Td9up0U/2ja6Lkq2vt8H+hzwmvEPCZTYmprKN9R3lIV+Kk2gYQO1cxHZvTM/fUBjJ/NAyt
 8E3mFVkkbHpVJF5YVopcjEO3LP8TSXdvFtyJNYf1Z77m5je9rSS+8c9uQn4zzkyfdy8eCBOC8TP
 PikID1+kmVqOxMu6gmxB+dUYyyiub9j/Zx8IpTqYcMzUGUX6LqVuUEFL3ACJYI=
X-Proofpoint-ORIG-GUID: oW307sW_2BDCkgXGabMADBVQCOwWu52Y
X-Authority-Info-Out: v=2.4 cv=a+I9NESF c=1 sm=1 tr=0 ts=697907d9
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7gx8ALrZTGDtSAp3wEYA:9
X-Proofpoint-GUID: oW307sW_2BDCkgXGabMADBVQCOwWu52Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=893
 clxscore=1030 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270153
X-JNJ: AAAAAAABJ9rUaE9a/3mh4Bs0+y9NjBSrUMyRoQ43dL2A78AMTMpy6/BkNtMFqXf8dkj6BDeoW2zO3jXtN/F8XaMlP4PuiyOFlc3+pkHUuknU+iQ5TbXeuE1Q3ErWT+JpC/P3h0+wZx8/mTr+MU54XkcRadIKWJPxQSt30aPupdghs8ZBeIkTEUYS+OfgGxWLbItrtJRoLzS/EjZYjjfOFsHT62wR3QOVEQtd13B5Vp6oaaA3zo4HFjAmoK6HnmxRJIT8LNBqUGdkTpsxkP8Ssh/k4Bk8UtQm819BhWKU/sCr4tdvy15BeTf/HqXdp4Av5x5OZiCbeC9pFN2fPsX2QfT4xzjoQezon6jZPUiIP1oLFND9o+q94eTAZbCHS3urUzOtxSLcDAhH6s31oP5JqpwqglBDwXLwcI8rYE5a5Hy5XJe2QsyVQTRBHNIYJ3Kc/pkg7ZmlZFbVRidEnO9WN8cTErGXFTapXKLZD3w8zYQYYIYG7EpJYULttJv+zDT+ePRhFIqyKiSro64F6M6cIpo7GyPD4dQLFAZeSjgxRJh0vCvFSzPH3ubvCGfcJUSnQmih9ndxJZxOMeT+Kptdkotu+Rw3nR/ZUlVDv7y88z+QIqhZ+l31Tw+XE6843Gk48AP7JJVwzjNHeDRgYUQrIJ2VY15gV98o7Lkwz/W8Dtfhv+GOXnC3OljXZnN0jIODZTZTvkjdDGXwN/uY
Received-SPF: pass client-ip=57.103.76.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When starting up the VM at EL2, more sysregs are available. Sync the state of those.

In addition, sync the state of the EL1 physical timer when the vGIC is used, even
if running at EL1. However, no OS running at EL1 is expected to use those registers.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c        | 37 +++++++++++++++++++++++++++++++++----
 target/arm/hvf/sysreg.c.inc | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 4ecd8907df..39a8b08c9e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -412,13 +412,34 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
 #define DEF_SYSREG(HVF_ID, ...) \
   QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
 
+#define DEF_SYSREG_EL2(HVF_ID, ...) \
+  QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
+
+#define DEF_SYSREG_VGIC(HVF_ID, ...) \
+  QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
+
+#define DEF_SYSREG_VGIC_EL2(HVF_ID, ...) \
+  QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
+
 #include "sysreg.c.inc"
 
 #undef DEF_SYSREG
+#undef DEF_SYSREG_EL2
+#undef DEF_SYSREG_VGIC
+#undef DEF_SYSREG_VGIC_EL2
+
+#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID},
+#define DEF_SYSREG_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .el2 = true},
+#define DEF_SYSREG_VGIC(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .vgic = true},
+#define DEF_SYSREG_VGIC_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, true, true},
+
+struct hvf_sreg {
+    hv_sys_reg_t sreg;
+    bool vgic;
+    bool el2;
+};
 
-#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  HVF_ID,
-
-static const hv_sys_reg_t hvf_sreg_list[] = {
+static struct hvf_sreg hvf_sreg_list[] = {
 #include "sysreg.c.inc"
 };
 
@@ -981,11 +1002,19 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
     /* Populate cp list for all known sysregs */
     for (i = 0; i < sregs_match_len; i++) {
-        hv_sys_reg_t hvf_id = hvf_sreg_list[i];
+        hv_sys_reg_t hvf_id = hvf_sreg_list[i].sreg;
         uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
         uint32_t key = kvm_to_cpreg_id(kvm_id);
         const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
 
+        if (hvf_sreg_list[i].vgic && !hvf_irqchip_in_kernel()) {
+            continue;
+        }
+
+        if (hvf_sreg_list[i].el2 && !hvf_nested_virt_enabled()) {
+            continue;
+        }
+
         if (ri) {
             assert(!(ri->type & ARM_CP_NO_RAW));
             arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
index 067a8603fa..ce4a4fdc68 100644
--- a/target/arm/hvf/sysreg.c.inc
+++ b/target/arm/hvf/sysreg.c.inc
@@ -145,3 +145,38 @@ DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 3, 3, 13, 0, 3)
 DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 3, 3, 14, 3, 1)
 DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 3, 3, 14, 3, 2)
 DEF_SYSREG(HV_SYS_REG_SP_EL1, 3, 4, 4, 1, 0)
+
+DEF_SYSREG_VGIC(HV_SYS_REG_CNTP_CTL_EL0, 3, 3, 14, 2, 1)
+DEF_SYSREG_VGIC(HV_SYS_REG_CNTP_CVAL_EL0, 3, 3, 14, 2, 2)
+#ifdef SYNC_NO_RAW_REGS
+DEF_SYSREG_VGIC(HV_SYS_REG_CNTP_TVAL_EL0, 3, 3, 14, 2, 0)
+#endif
+
+DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHCTL_EL2, 3, 4, 14, 1, 0)
+DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHP_CVAL_EL2, 3, 4, 14, 2, 2)
+DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHP_CTL_EL2, 3, 4, 14, 2, 1)
+#ifdef SYNC_NO_RAW_REGS
+DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHP_TVAL_EL2, 3, 4, 14, 2, 0)
+#endif
+DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTVOFF_EL2, 3, 4, 14, 0, 3)
+
+DEF_SYSREG_EL2(HV_SYS_REG_CPTR_EL2, 3, 4, 1, 1, 2)
+DEF_SYSREG_EL2(HV_SYS_REG_ELR_EL2, 3, 4, 4, 0, 1)
+DEF_SYSREG_EL2(HV_SYS_REG_ESR_EL2, 3, 4, 5, 2, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_FAR_EL2, 3, 4, 6, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_HCR_EL2, 3, 4, 1, 1, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_HPFAR_EL2, 3, 4, 6, 0, 4)
+DEF_SYSREG_EL2(HV_SYS_REG_MAIR_EL2, 3, 4, 10, 2, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_MDCR_EL2, 3, 4, 1, 1, 1)
+DEF_SYSREG_EL2(HV_SYS_REG_SCTLR_EL2, 3, 4, 1, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_SPSR_EL2, 3, 4, 4, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_SP_EL2, 3, 6, 4, 1, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_TCR_EL2, 3, 4, 2, 0, 2)
+DEF_SYSREG_EL2(HV_SYS_REG_TPIDR_EL2, 3, 4, 13, 0, 2)
+DEF_SYSREG_EL2(HV_SYS_REG_TTBR0_EL2, 3, 4, 2, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_TTBR1_EL2, 3, 4, 2, 0, 1)
+DEF_SYSREG_EL2(HV_SYS_REG_VBAR_EL2, 3, 4, 12, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_VMPIDR_EL2, 3, 4, 0, 0, 5)
+DEF_SYSREG_EL2(HV_SYS_REG_VPIDR_EL2, 3, 4, 0, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_VTCR_EL2, 3, 4, 2, 1, 2)
+DEF_SYSREG_EL2(HV_SYS_REG_VTTBR_EL2, 3, 4, 2, 1, 0)
-- 
2.50.1 (Apple Git-155)


