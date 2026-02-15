Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956A9EF5878
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 11:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vraGQ-0005Fr-LY; Sun, 15 Feb 2026 06:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGJ-0005EW-SJ
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:03 -0500
Received: from p-west2-cluster1-host2-snip4-10.eps.apple.com ([57.103.68.23]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGG-0007w6-5H
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:03 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 CB77518002AA; Sun, 15 Feb 2026 11:25:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771154752; x=1773746752;
 bh=LNAPTfF7M/Fywq5jfntu3irQBz3B7IN3ccj1ShQyhHU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=YaVb8fVn01LoZYI+JFLxM4sIbkKydYXzXW+DbZoCvXhHfWH6MlM8sVCXW5wme9IqrTwRtqxivizmxipfR46aCfAKD803i/fbSesFcc6dz/aco3DYOBLl0HZNmUAA/4jxld4cBEqwMWUy2vSk6jTDbfIXgOf/guLT5V2/ebUMTLhYDn/zOgNFLBvd6Enx++PvdyEJNsRH543o3htGM4vAqcL5u977GCpW7w+CbmrD3I7v58YHuZItArXFIt22HHadphbt3gtWop3/+tH6NirSM+c0CVaUtK2jv08pEPzHQz5qKt2joDeGo4LCXL9z6eGhDlDZSTNIQefG9RoGmrLw4w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 4DDCD1800182; Sun, 15 Feb 2026 11:25:48 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v10 01/14] Revert "target/arm/hvf: Sync CNTV_CTL_EL0 &
 CNTV_CVAL_EL0"
Date: Sun, 15 Feb 2026 12:25:30 +0100
Message-ID: <20260215112543.4817-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215112543.4817-1-mohamed@unpredictable.fr>
References: <20260215112543.4817-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8GTDjZoNPHYXUzvNmaSEmQBfNEMPaIks
X-Authority-Info-Out: v=2.4 cv=d/H4CBjE c=1 sm=1 tr=0 ts=6991ad3f
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=BQ3R4gsLSxvXhAEoYIEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDA5MiBTYWx0ZWRfX4kv3HkZ8V3Cr
 raIZ49EVQdIQ8uhFWTOH8PlWg290ubH70/H6326JpEgn2AngxhX8bdtBojAmV05RO/Dql+vUYIy
 kpaZggBpyQs0Xflibi9r24z2Abtv03+PfaEdIJhwTEkqfWJ/9/gvzQxh06IIuUchCcNritoAgx4
 IW/btspuPLUlYrRyA+AViqRFM5mPXjNWi5RhSzc1gFEllQCLsqBCHyFu9TXsnBloOPYFZiWwdm8
 6vP90ydhAtOCktgvgjBqzHBlgAv54cIEGS/Ke3HIeB2Ic+pIcrLS4XRCBsmZee4Ity8g/N6DQ+D
 h5lsKKGIBQVrV2pcxdeH6Q1FYCRyxQsCyysEqTfhhb3YeGVYf63oMzxutdE3nY=
X-Proofpoint-ORIG-GUID: 8GTDjZoNPHYXUzvNmaSEmQBfNEMPaIks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 clxscore=1030 spamscore=0 lowpriorityscore=0 mlxlogscore=416 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150092
X-JNJ: AAAAAAABcyDLpFQAyUAAguJ38bveLFASLzHpaN7lKyeFXBkU7EijmxIowVVXxMJXod2kN67pplW7FnL75NAbYE7lGR575h0ayNhC3sTyroZNHWzTuwtveYMkUwHfSr29wR9aUcyfm2hpisBaPTxQ1jlb3y/L44aOAhp2oRn58+/vHlOJeDszD62ebGeumXSCpPfbEPBKFLjyUMQLVA9ywiCAZgY3wccQf6RIDMq4v2IADaGdOl2vRAiNMT9QbfjRLt9VRJQrucrs1it4T1khH7QBzqKimIwv9fmv0e0Zzr2LpUeVS6bW5MGqr5hDbRzSR1YlGNkIprtx/53UJw2QgSAqxYfbdTj0swnVMmwWkKxVq9D6hjwNecOhzBZo6uRBo8i1M5Ofw8AzfZiVzw0TRhsuNiS4yIrE7khYblgni8znS1mFpIBHi97hgwouky8zuRi/zAnnS7i4Yhn2Ymjse8a8W+620nH3Nx+xc6Zf7h38945Lm2q7BFGYuByZH76+vrD6dmNI9OT881KqLnwVp0THnqeQAhm9pjG/fBmsZyX9dShS+652n6soFp7TVaHNgoUtWtJ4enqyZBX/CMDvxBbtAJTXXwsUgZtJd5bUMXtblF41bXGkM2hKZhACHES0FnpLr4uSzHVWXJh3hcK9vNzd58tcwjdA4JiH+87sy97koRXDGKeF4V7/vnSIVxrDILhndYtQkOzlMRLC3dL+evINyYkHsjo1YlU7KNw2
Received-SPF: pass client-ip=57.103.68.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This reverts commit bfbea371ef2cabc47effac5a286e2644d727a8d6.

This commit breaks VM save/restore:

Assertion failed: (b), function hvf_arch_get_registers, file hvf.c, line 667.
zsh: abort      ./qemu-system-aarch64 -m 8192 -M virt,accel=hvf -cdrom  -device virtio-gpu

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 1b19d9713e..d79469ca27 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -200,9 +200,6 @@ void hvf_arm_init_debug(void)
 #define SYSREG_PMCEID0_EL0    SYSREG(3, 3, 9, 12, 6)
 #define SYSREG_PMCEID1_EL0    SYSREG(3, 3, 9, 12, 7)
 #define SYSREG_PMCCNTR_EL0    SYSREG(3, 3, 9, 13, 0)
-
-#define SYSREG_CNTV_CTL_EL0   SYSREG(3, 3, 14, 3, 1)
-#define SYSREG_CNTV_CVAL_EL0  SYSREG(3, 3, 14, 3, 2)
 #define SYSREG_PMCCFILTR_EL0  SYSREG(3, 3, 14, 15, 7)
 
 #define SYSREG_ICC_AP0R0_EL1     SYSREG(3, 0, 12, 8, 4)
@@ -505,7 +502,6 @@ int hvf_arch_get_registers(CPUState *cpu)
     uint64_t val;
     hv_simd_fp_uchar16_t fpval;
     int i, n;
-    bool b;
 
     for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
         ret = hv_vcpu_get_reg(cpu->accel->fd, hvf_reg_match[i].reg, &val);
@@ -635,16 +631,6 @@ int hvf_arch_get_registers(CPUState *cpu)
 
     aarch64_restore_sp(env, arm_current_el(env));
 
-    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, &val);
-    assert_hvf_ok(ret);
-    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, val);
-    assert(b);
-
-    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, &val);
-    assert_hvf_ok(ret);
-    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, val);
-    assert(b);
-
     return 0;
 }
 
@@ -656,7 +642,6 @@ int hvf_arch_put_registers(CPUState *cpu)
     uint64_t val;
     hv_simd_fp_uchar16_t fpval;
     int i, n;
-    bool b;
 
     for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
         val = *(uint64_t *)((void *)env + hvf_reg_match[i].offset);
@@ -771,16 +756,6 @@ int hvf_arch_put_registers(CPUState *cpu)
     ret = hv_vcpu_set_vtimer_offset(cpu->accel->fd, hvf_state->vtimer_offset);
     assert_hvf_ok(ret);
 
-    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, &val);
-    assert(b);
-    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, val);
-    assert_hvf_ok(ret);
-
-    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, &val);
-    assert(b);
-    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, val);
-    assert_hvf_ok(ret);
-
     return 0;
 }
 
-- 
2.50.1 (Apple Git-155)


