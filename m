Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E1ED6AB10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 23:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8RlL-0004Ih-JB; Thu, 02 Apr 2026 19:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8RlL-0004IJ-0K
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 19:47:47 -0400
Received: from p-west2-cluster6-host7-snip4-3.eps.apple.com ([57.103.70.46]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8RlJ-000445-Fv
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 19:47:46 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPS id
 C91FD180015B; Thu, 02 Apr 2026 23:47:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775173664; x=1777765664;
 bh=c5D9ZkT8JYejwpSreaiXIWK6zThn9vhXnnKzmMKMQA8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=a9cu3H8ir8YZrH4GRrVEPaTfdTUzCIaMBHXflqpE7Xh0F0r69qMLZunGlkmw1rM2rhjxF4/OiPFpkLy04FpPX3HYo6yRE1cDYS60X8MSwpk9+3o6Sjx1L6m0afMyWT8iusT0QQ2mOney0VavodvUZnra4Uo71k7Gvt6pLts07bmvm/6q8cknqx33uI8rRNDnHz4B7E6VJZ38tBcROxDMhXO/jJIbVVhAGeSH3HzZKGj/ixJ9xnq6stWwzg31Qvm+cK9HovfP+KUrKItE6HvexSVrXADsDt0npcsLU42ZX/Z/xxJ3kV3XOx2WPS2RJJYhLbVT/kORKPaYp07iDkmSnA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPSA id
 D4A641800156; Thu, 02 Apr 2026 23:47:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v3 7/7] whpx: i386: introduce proper cpuid support
Date: Fri,  3 Apr 2026 01:47:24 +0200
Message-ID: <20260402234724.88276-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402234724.88276-1-mohamed@unpredictable.fr>
References: <20260402234724.88276-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: E4_OygPwFSxY6QwKw45HzQ0rh4__zHNn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDIxMyBTYWx0ZWRfX6DNTH7dthynF
 4iO5E7J1Fqy9VKFNijndCr+CatOrMyVqEZslnpoH1vdbk0QAXm2u9lRXSNLjrYK5Zwmtr5wb2qL
 nxdVcw/f32GIjm4L4M2FbI++FPxm1L99ueP0aA2gV0nUgTvAHa5Okx2DfibwSmuNZMYJCUR3JYl
 XcLqWRt160ebU7SXAgyCL8hmWN/ymz/63h5EXVNY8s2oghC7kl+9vsRydjh4UslkN8dk5qXJv/2
 b65rtbVWcT2ggcV3NtGhXZrO5ycOsqYIjuPzCxFmnsvGk3LOZQqJ3/UhDUuEaXEiObk+48OKb4Y
 iGanheFsJZjFp3VXSQ34TJzFXJ23Fd5wnkSbEm6SRB5JCXaMlh/nAGA2cC6TlA=
X-Proofpoint-GUID: E4_OygPwFSxY6QwKw45HzQ0rh4__zHNn
X-Authority-Info-Out: v=2.4 cv=KuBAGGWN c=1 sm=1 tr=0 ts=69cf001f
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8S12nBvZezfavlJVhXoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1030 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=841
 suspectscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020213
Received-SPF: pass client-ip=57.103.70.46;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Unlike the implementation in QEMU 10.2, this one works.

It's not optimal though as it doesn't use the Hyper-V support for this.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 39 ++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 483a15ffdc..536657e43a 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2127,6 +2127,35 @@ int whpx_vcpu_run(CPUState *cpu)
                     }
                     break;
                 }
+            } else {
+                switch (vcpu->exit_ctx.CpuidAccess.Rax) {
+                case 0x40000000:
+                case 0x40000001:
+                case 0x40000010:
+                    reg_values[1].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
+                    reg_values[2].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
+                    reg_values[3].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
+                    reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+                    break;
+                }
+            }
+
+            /* Dynamic depending on XCR0 and XSS, so query DefaultResult */
+            if (vcpu->exit_ctx.CpuidAccess.Rax == 0x07
+                && vcpu->exit_ctx.CpuidAccess.Rcx == 0) {
+                if (vcpu->exit_ctx.CpuidAccess.DefaultResultRdx
+                    & CPUID_7_0_EDX_CET_IBT) {
+                    reg_values[3].Reg32 |= CPUID_7_0_EDX_CET_IBT;
+                } else {
+                    reg_values[3].Reg32 &= ~CPUID_7_0_EDX_CET_IBT;
+                }
+
+                if (vcpu->exit_ctx.CpuidAccess.DefaultResultRcx
+                    & CPUID_7_0_ECX_CET_SHSTK) {
+                    reg_values[2].Reg32 |= CPUID_7_0_ECX_CET_SHSTK;
+                } else {
+                    reg_values[2].Reg32 &= ~CPUID_7_0_ECX_CET_SHSTK;
+                }
             }
 
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
@@ -2345,8 +2374,12 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_CAPABILITY_FEATURES features = {0};
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
-    UINT32 cpuidExitList[] = {1};
-    UINT32 cpuidExitList_nohyperv[] = {1, 0x40000000, 0x40000001, 0x40000010};
+
+    UINT32 cpuidExitList[] = {0x0, 0x1, 0x6, 0x7, 0x14, 0x24, 0x29, 0x1E,
+        0x40000000, 0x40000001, 0x40000010, 0x80000000, 0x80000001,
+        0x80000002, 0x80000003, 0x80000004, 0x80000007, 0x80000008,
+        0x8000000A, 0x80000021, 0x80000022, 0xC0000000, 0xC0000001};
+    UINT32 cpuidExitList_legacy_os[] = {1, 0x40000000, 0x40000001, 0x40000010};
 
     whpx = &whpx_global;
 
@@ -2602,7 +2635,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     hr = whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
         WHvPartitionPropertyCodeCpuidExitList,
-        whpx->hyperv_enlightenments_enabled ? cpuidExitList : cpuidExitList_nohyperv,
+        !whpx_is_legacy_os() ? cpuidExitList : cpuidExitList_legacy_os,
         RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
 
     if (FAILED(hr)) {
-- 
2.50.1 (Apple Git-155)


