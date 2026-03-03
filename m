Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C48EDEBF7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWiq-0001AE-N3; Tue, 03 Mar 2026 15:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWik-0000QJ-Ti
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:51:58 -0500
Received: from p-east2-cluster3-host12-snip4-10.eps.apple.com ([57.103.77.191]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWij-0001Yt-7e
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:51:58 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 A90291800145; Tue,  3 Mar 2026 20:51:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772571116; x=1775163116;
 bh=xfi6rjeDQo4vpSHmbqs0x+tY5PCeD7vMjLpTj63mmJI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LHeISDF5t80r2L7PR1D20T8FqS79BO8W2Bvk9QIiwkj7KLKBzcYe8LFglI7JHR1e3cyzqtZ5SSB19fmvMqZJuspxlQWnSPdZ8VTbubxAR0ByAOs6LFyxxsY+z4X8hlVUpdxw7KdbDhq2Ko00n1B66B7pszT0TICJi6Kr9UG5261BFUeo7jrgvADwLmbaunptDWBjtPXiHxrl7lLFjhCEG9qEO1V2y9kvSbRn0CRC99C6uM8l/2dq/ZEtr7MlH55Zvt66G2Ym6AxV5QficeaaDVGe9zrbiRKnlhw6fTaRm3nsVvSL5oUK+gkZMkGu2bbnFwax19thvZPj5qI0lEx//g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 E5A491800140; Tue,  3 Mar 2026 20:51:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v4 7/7] whpx: i386: remove SIPI trapping
Date: Tue,  3 Mar 2026 21:51:38 +0100
Message-ID: <20260303205138.32450-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303205138.32450-1-mohamed@unpredictable.fr>
References: <20260303205138.32450-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MSBTYWx0ZWRfXxxtB4S0g5bBh
 nEY/z32AOwQzrWnqaze5ig39Xbx9HYM5meNb+wylfGnZh+zZq+s4iStTc6aw7THO2MgtVugZyD4
 IahX5w0VZY3/5+dkdp+c4cgmTUnaBRgXLMR3kMeDI5ebWlTVx9L8RS9JWgCgngoYIbcOQOm8Tek
 OcA62nmZJgi6UBaPM7copeRk5m8M3sKaGuGuU2sKuT8w6+n2BjeEhUOyGuw3JDOiH2Fu1OsDpxb
 5TdTCBUY1r9e4BubEgXbHm0Zlo1WJ1u/JtY4rgPa476YZrlIUki3SngGeOsw/IPkQt28PxqG7/W
 1l8SJ8c0vjlcZUdgnOiLaNyZ5BKDtSokBjplFEtFshFavpRAhMEoS7ftXE6Gqc=
X-Authority-Info-Out: v=2.4 cv=O5M0fR9W c=1 sm=1 tr=0 ts=69a749eb
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Xl7PRCIL3n5FuX7mVuoA:9
X-Proofpoint-GUID: nQr99yVM2CSiZzKeQSQ96gK0C00SdciK
X-Proofpoint-ORIG-GUID: nQr99yVM2CSiZzKeQSQ96gK0C00SdciK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 mlxlogscore=997 clxscore=1030 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030171
X-JNJ: AAAAAAABNRwAgybmiFV8Bc0ICbK5hLfau9bm5dOb5NgIby64Ax5bWi2RW+gJp5vgD8o11eVVrjCMw9ZMU+GoK4DRY5vdHjPT5tI8lnhPgkO/5bys51eCZa5le6fkqK3fHY4V0pviLq08EKwnMQfmiIyoH9fb2LaQb6yR+NwqPIyxqbrfPnX0HM0bOoxUmUHkQkvSfeiw19nZn50tMz2G3UC6aLbdZljJsOw4QXRQnqWFQarzh9UX0oE+1GwsqnRDNkoXe3abwuYh5ThuLvVfPF8XDaood5oNTYIKUcvrL42gXMcc522I8bS8vTu0aipXIKFUmTFt5CIUpNG+vejpWeEOUlNOdgd9Vo1Qvx62KQk1Xi66ylPcP+tSNv2VyJDMD4V8afwDfZWmZxnc+S47YJVH96a0RckT2+QySIjNmgReFkT7Xay5u8EibutDM8V0SP6kZBUzRlGhMO2wTx8Y3SpzzkozOkVM7NlS3lLqt5wn72zsw0M30rhMYNGA1FVcPEoH+KxTumNoqw8LiGofZXySI3JF3Kf29PhhNbSxjDOfol62QtA+0qorJktGCI5NGPgQ8JWIuaQYGzVqa2kXoFROQYHYHZ4rwUCNiHeoP+sAG5Gi5okAWbpa+Pip7YGhOs+lHZh3l8H783utn7t8QZtKL5pVPsyLvQrmO5X29eAJXEfHgn2VEUfGjJLyxDKkG8uxhpDV1VMn44H19QykKLZFHEQl4+xo4tYsA5dOZTu+TQOSvb+i+7tdcKAng6+MIlagW64Em6TSK9JF
Received-SPF: pass client-ip=57.103.77.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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


