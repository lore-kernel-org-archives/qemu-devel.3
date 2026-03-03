Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF6DEC1430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxO8l-0005F6-Hf; Tue, 03 Mar 2026 06:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxO8b-000580-E8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:42:07 -0500
Received: from p-west1-cluster3-host6-snip4-2.eps.apple.com ([57.103.66.15]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxO8X-0001cJ-V1
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:42:04 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-3 (Postfix) with ESMTPS id
 8CB0A18000AC; Tue,  3 Mar 2026 11:41:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772538118; x=1775130118;
 bh=xfi6rjeDQo4vpSHmbqs0x+tY5PCeD7vMjLpTj63mmJI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ANz5olkz3ovdVCBtXguNYEpQYBgJazELBa7yZzMKVaTXepSkd2QfjOrP42evyvsQe293F8JKz0+IaKux/KEarJSmib+KiY1U1FKtV2aLsWfACVcd/JjP5oMpY55IanQ0hFvTIhmYQ/o9PvrQ1Lpjl60JZqwfbNVP3ay+x8k0HBCrbm0zvtcmEqvgMB16XNBbVJ5a+FQj8ieW5c/It/pKns4QFE+9PK2YGzE/zPWb3atdshGALeZtWfGWa4l087Al4OOwzwzt0URuM6q3v2obXd8LQTkOjhaj5IeVtgiSn5/m9ay3DAvRhNunFM+g6Nkx8Lo064nVGhHRsl2UnDw4Rg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-3 (Postfix) with ESMTPSA id
 C19761800194; Tue,  3 Mar 2026 11:41:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 6/6] whpx: i386: remove SIPI trapping
Date: Tue,  3 Mar 2026 12:41:35 +0100
Message-ID: <20260303114135.15390-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303114135.15390-1-mohamed@unpredictable.fr>
References: <20260303114135.15390-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA5MSBTYWx0ZWRfX7oY5yHbtbqyW
 AZrbUjrSNXzKDcyzn+00kemUTX48LXQ8QE2S+ffL13F7JNCPFkuhwnJRDCy6vqC1p6t+23uZmHL
 LijrM/Yfd7lKO3oZD6isY+7gqpdX8iuWuNCYyet2rmnITNpemnXenwgGjqyO62IrK9n9Xk3ViZC
 nq9I7tWem572OmakiFsJD/xYBOdNaEYhihTNul9BgUv76+P1Gs3k/Spbx8Mxm1MZzxXSSseNTXQ
 sJDgGhGUxyHL0B8qX6FfsB8YCjyuYIDkzM2uz95uBhuP2/mF0Nkh7ZXyqwBJHAkMVuBdck8Eq9s
 jISy2/L/Dq5SmAS/3fxss3xGCAejc5NCXuwS+/ufEQt4A4kB0OcgsKABx967e4=
X-Proofpoint-GUID: m1Y-2qdMY6rixghNl_IltWIcxdKTo8SL
X-Authority-Info-Out: v=2.4 cv=EJcLElZC c=1 sm=1 tr=0 ts=69a6c903
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Xl7PRCIL3n5FuX7mVuoA:9
X-Proofpoint-ORIG-GUID: m1Y-2qdMY6rixghNl_IltWIcxdKTo8SL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 clxscore=1030 mlxlogscore=882 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030091
X-JNJ: AAAAAAAB9xpHP4qgpueVBMhQC/CSK1uCW5wop07nzXt21aDVTfhuhSasWJryzCrI7cRQ2rzYCEf6Ko8jaKOc1c9TKuXZ4b0rGF+/4GcwAiLjz7UuVpaaFvrtSAisAyjSVwP1AQdBRP8PCt09374xhWhjQNP8D97V6ODWr9g1SG/ULRL/I9ti0qiL6d0UCwubJrfbWwKwVhJRiPa85FAlisKlQSF+MRuTKmmP6h+LDCZxQZ8NpediygB7hlh+ae4dNzmazowJ4vJbcJbd5tcJjKmFkRGlaQd++KXTucurU834agkwDo/l2vrOUPJdb5YQbke8TnBVIY7AVHSDUqFTSi+uC6sc1X98e0w1caInSgunzzfsFj7MlALkLQ923dgYPmBifzAQly1t/84GgVviw7M8D/5zrhkBQTvYLvebed/K5LgQd4oYqt/WobLgeXUMmVFZux9lRADpu6LuTXKxin2e/z3kn8PqH3RQlZ2Dm7hr8FRwbbesqJggduDYcvexSpC3d9ilXghy/Go+n6gxMUGY6y4IvVtJx4GuB++y4VYybAW8wajljauMtdoFqQRM9MGWBZVU0mEiMVT6dKgj/XEAX3ZysRW1WUynRN2TrLJxpYbnxYo5+LTXhREVvmMH8tvDNO6et6+a5yG8lQ716waeBVbfoNo3VBVFGQGPzmw1gi+iO+rKidm24LcTKqTTyTXztFtdTVqTEZDpUmpAOsS+uGpDJJt+76bH
Received-SPF: pass client-ip=57.103.66.15;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The implementation in Hyper-V works fine and the code
currently present doesn't handle x2APIC correctly anyway, so
remove it and use the implementation in Hyper-V.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 97 -------------------------------------
 1 file changed, 97 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4968a5a3e4..fa78218f80 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1679,100 +1679,6 @@ int whpx_vcpu_run(CPUState *cpu)
             ret = whpx_handle_halt(cpu);
             break;
 
-        case WHvRunVpExitReasonX64ApicInitSipiTrap: {
-            WHV_INTERRUPT_CONTROL ipi = {0};
-            uint64_t icr = vcpu->exit_ctx.ApicInitSipi.ApicIcr;
-            uint32_t delivery_mode =
-                (icr & APIC_ICR_DELIV_MOD) >> APIC_ICR_DELIV_MOD_SHIFT;
-            int dest_shorthand =
-                (icr & APIC_ICR_DEST_SHORT) >> APIC_ICR_DEST_SHORT_SHIFT;
-            bool broadcast = false;
-            bool include_self = false;
-            uint32_t i;
-
-            /* We only registered for INIT and SIPI exits. */
-            if ((delivery_mode != APIC_DM_INIT) &&
-                (delivery_mode != APIC_DM_SIPI)) {
-                error_report(
-                    "WHPX: Unexpected APIC exit that is not a INIT or SIPI");
-                break;
-            }
-
-            if (delivery_mode == APIC_DM_INIT) {
-                ipi.Type = WHvX64InterruptTypeInit;
-            } else {
-                ipi.Type = WHvX64InterruptTypeSipi;
-            }
-
-            ipi.DestinationMode =
-                ((icr & APIC_ICR_DEST_MOD) >> APIC_ICR_DEST_MOD_SHIFT) ?
-                    WHvX64InterruptDestinationModeLogical :
-                    WHvX64InterruptDestinationModePhysical;
-
-            ipi.TriggerMode =
-                ((icr & APIC_ICR_TRIGGER_MOD) >> APIC_ICR_TRIGGER_MOD_SHIFT) ?
-                    WHvX64InterruptTriggerModeLevel :
-                    WHvX64InterruptTriggerModeEdge;
-
-            ipi.Vector = icr & APIC_VECTOR_MASK;
-            switch (dest_shorthand) {
-            /* no shorthand. Bits 56-63 contain the destination. */
-            case 0:
-                ipi.Destination = (icr >> 56) & APIC_VECTOR_MASK;
-                hr = whp_dispatch.WHvRequestInterrupt(whpx->partition,
-                        &ipi, sizeof(ipi));
-                if (FAILED(hr)) {
-                    error_report("WHPX: Failed to request interrupt  hr=%08lx",
-                        hr);
-                }
-
-                break;
-
-            /* self */
-            case 1:
-                include_self = true;
-                break;
-
-            /* broadcast, including self */
-            case 2:
-                broadcast = true;
-                include_self = true;
-                break;
-
-            /* broadcast, excluding self */
-            case 3:
-                broadcast = true;
-                break;
-            }
-
-            if (!broadcast && !include_self) {
-                break;
-            }
-
-            for (i = 0; i <= max_vcpu_index; i++) {
-                if (i == cpu->cpu_index && !include_self) {
-                    continue;
-                }
-
-                /*
-                 * Assuming that APIC Ids are identity mapped since
-                 * WHvX64RegisterApicId & WHvX64RegisterInitialApicId registers
-                 * are not handled yet and the hypervisor doesn't allow the
-                 * guest to modify the APIC ID.
-                 */
-                ipi.Destination = i;
-                hr = whp_dispatch.WHvRequestInterrupt(whpx->partition,
-                        &ipi, sizeof(ipi));
-                if (FAILED(hr)) {
-                    error_report(
-                        "WHPX: Failed to request SIPI for %d,  hr=%08lx",
-                        i, hr);
-                }
-            }
-
-            break;
-        }
-
         case WHvRunVpExitReasonCanceled:
             if (exclusive_step_mode != WHPX_STEP_NONE) {
                 /*
@@ -2236,9 +2142,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
     prop.ExtendedVmExits.ExceptionExit = 1;
-    if (whpx_irqchip_in_kernel()) {
-        prop.ExtendedVmExits.X64ApicInitSipiExitTrap = 1;
-    }
 
     hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
-- 
2.50.1 (Apple Git-155)


