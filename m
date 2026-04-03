Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8AFE8536F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 14:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8fSe-0005Nl-2N; Fri, 03 Apr 2026 10:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8fSY-0005LL-7h
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 10:25:19 -0400
Received: from p-east2-cluster2-host11-snip4-10.eps.apple.com ([57.103.78.93]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8fSW-0000Nm-6Q
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 10:25:17 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id
 029C11801164; Fri, 03 Apr 2026 14:25:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775226315; x=1777818315;
 bh=d6aYMezS4K50QhpFbiouZemcvwz2NgiZB6lHAEg2j7I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XJ0YNV5m1mh0r6BTNW3xPR5kYvFmHimeTxVbfxd5won6n6RknHmqJZEuEAj/8J1/gvdfxOhIVphKNtKYnK72Jh6FccH4ffMRnKpkd2iRg3wAOoJUQGiOZW0kJLKprvBHQFxSxiV0t2MclTSXW/IquiOtdhQnwpz1y6E+1bQ6zA+tNr+V/Y6/ZgOv75D7Gpr7DeJe/9WBzOzHPJt/54DrRhHGX+4JE67zTFVFktzx0aacIRYI77gHY5dWdljq/bYmPdchiS3UWgmEpcZXWH7O1CCgnk6AQoQc7nTv6D/Cisu3GKC3TqDc/R/ygtrANmCgOlyIqSaVrHOdVc+JqQw95Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id
 358EB18002F9; Fri, 03 Apr 2026 14:24:59 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v5 7/9] whpx: i386: introduce proper cpuid support
Date: Fri,  3 Apr 2026 16:24:44 +0200
Message-ID: <20260403142446.36964-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403142446.36964-1-mohamed@unpredictable.fr>
References: <20260403142446.36964-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rR6JmN2Ki_IGOSY6eeVQBuIDWcwdXcZp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEyOCBTYWx0ZWRfX4VFbWmEB7nkI
 WMT/WLyT3CH4gWFflfOM5oQLGMniqFGalNOvcswwhQBFl4hJgWpW5NWb2TsGvfH9L7OOFXq4329
 MC9MQpkn6247fkI27MoX52jkBRBKQClhKmHkFZBtQV3LeO1yPA9c5EMNI9Gy3b6gVLCxmT2n5oX
 dTbF5Jg7nn9kRndeqlNMnitSch9MT3qLw2dcTUJEIp9KmAsBcNg/7V2QJUSBlYYwaFJ9POxng0d
 kCPCSxO1pdSz05FN26G4EVat1/iqE4T3nj6TSsXscrzJ/NdifmqU21yDJ8+An4R2xOP6Rtsl1T/
 WvOFu+yVwldXYfJI0Ta3xgpZAmLeW3lEkYEbQLTsNv9e/hKabiKi/NttyjKF5w=
X-Authority-Info-Out: v=2.4 cv=G5UR0tk5 c=1 sm=1 tr=0 ts=69cfcdc8
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8S12nBvZezfavlJVhXoA:9
X-Proofpoint-GUID: rR6JmN2Ki_IGOSY6eeVQBuIDWcwdXcZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1030 phishscore=0 spamscore=0 mlxlogscore=840 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604030128
Received-SPF: pass client-ip=57.103.78.93;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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
index 03233d1b94..3e006496be 100644
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


