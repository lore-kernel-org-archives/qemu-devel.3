Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE413F4BB89
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 20:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuz0B-0004wJ-5o; Tue, 24 Feb 2026 15:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuz07-0004w6-Bh
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 15:27:23 -0500
Received: from p-west1-cluster2-host1-snip4-10.eps.apple.com ([57.103.64.181]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuz05-0001ia-6y
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 15:27:23 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-3 (Postfix) with ESMTPS id
 6A0541800136; Tue, 24 Feb 2026 20:27:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771964839; x=1774556839;
 bh=c6qJ7DQXPShPjf8MFVN5j9t59Q1gBGP4ELIE+5IJfMw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=DwBRN278ceFsbr8ghhyWeqdkM2+8atLvD+mq+tvDKyRmEkKXjDR4Sck0g9vxsECimt9sbpAm1tdpqs0B8KVWmM9od7apErC08teMw/KSCCKyZkoG4PtD1WH/s4wkqmjTUHzoBpbhDybo84yC4vA/DZKyU/UqnMr1xwcrFZWkpCMbc5iAGC4DIJCBmnG7wNCkOWUelIKAyHExcS7JyaPSCMJVt80Fql8rPRCCBZWTcdrxRcaZm32quRYxuPzdzpOMG2CIbglVGVRV5EfZtBB8q5zVkRQ6prXDbrPJTiQVUyLlaCCx31hsoTbo9ECWzZTK63VYqVDHGbMF2baVRXIN/Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-3 (Postfix) with ESMTPSA id
 4918718000BA; Tue, 24 Feb 2026 20:27:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH] hw: i386: vapic: enable on WHPX with user-mode irqchip
Date: Tue, 24 Feb 2026 21:27:12 +0100
Message-ID: <20260224202712.71511-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dyYzfzMcLoukxfXti5HgW1KQ3QdBmVcy
X-Proofpoint-GUID: dyYzfzMcLoukxfXti5HgW1KQ3QdBmVcy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE3NSBTYWx0ZWRfX24NC+d/3EU4B
 +HIycNjYuZZyo5Wd2dCL+kkYLPRcSe766lhQGEtrHCKSPOKbwtLs6qL27NjpN+vPo+2VJujVl6n
 T6b4CTEaD+NpHzVuf5YW18qeXGE07eMC2pALHqtJNIWmmBZqEO1vVPxy9qJO9/IeYO/loTAeuei
 JKl5HRRoZrNnvHAOHNxTGF5eCeRBg06ZRNHVCsmG3eFDhPQhXcCL3xBkZQa7ELOPl/GGLz5vP92
 4/dGCXJAi5Flt7RRuWUuYtY98ClgN0KrBj3gCUXVx9JPYAJ73GwRhA9c9QxdYYF7fEkCRL441sM
 /oiaq9PORM2rSQVLq82JTcGlvhBqJuB+Q5pdd3QgTnfkkac4xva79320LGPob0=
X-Authority-Info-Out: v=2.4 cv=HeEZjyE8 c=1 sm=1 tr=0 ts=699e09a5
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=SuDxGJzo5uN7fQlDX74A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0
 spamscore=0 clxscore=1030 bulkscore=0 mlxlogscore=892 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602240175
X-JNJ: AAAAAAABrs0i9Gnu2PRNvksBovgiDXZKnNBv8x73CrqIvHYY+X0ZzfknEjpTf8ImbX03MaLQy3rSIsQDlIcJ7wJU3MqnFQW4yosx+u2biiV8S2dh40Lnl0SRaQ99+AMQyAzRMSfm/EROjmLR+6K/pMYNVFgK/qhsBH98yf+QgfgOID4OQOF4Bnc4avgkeF4eeRgLTj0e2MNIIrJmA5DL2Qbr9LYZkpd1rywuH7R2gttSIj0mgQ4CzOkcRsFLmwJ4vP66Ym9+4aRRsADwOUAabti4OZC4FjMh8VcwIowCfNkXgK+BQa0ITMnPJgAukvFgRdyz9a3r0FIoGCy9oqNX1aDgHVoDBEeZUTC1y1IjtYgwQEWftc5N4HGd9JErwhWeJHrY/F1/HghzDQ760VKhqAoOVlXhKgGFETsvbt8VP899MoJm+pyyWUiKOb37wyex6gl0Qa+7mwm7XvS/Zk3mRSRfL1Bpg2buMFRNaqpyJ4V69wWlXuOsVqnAXb5jlxZaw0H30wdwJVwtF31XDjgIx7wcdOLDf6VMeDyDRc2ejkO1G3Q08X0G7Ry6wLA2o10DGP4LAImzFVJl1/lNCkBz8+JqlOfoYJM/n/qwXw3SXnpuC1JwsongTfQuQypUDZ+hjc1+pgurwdoK7fkyFZa4YrJvSNTA6l35nzk2DBykP8UdPkorPs02zkaRu3GkWYBPam1nvhb6HQO5EQHcIMWx
Received-SPF: pass client-ip=57.103.64.181;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

Alleviate a performance bottleneck on legacy Windows guests.

In my test setup, this makes Windows XP boot times be 20x faster
than they're otherwise.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/i386/vapic.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 670a50524d..699f91fb56 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -16,6 +16,7 @@
 #include "system/cpus.h"
 #include "system/hw_accel.h"
 #include "system/kvm.h"
+#include "system/whpx.h"
 #include "system/runstate.h"
 #include "system/address-spaces.h"
 #include "hw/i386/apic_internal.h"
@@ -229,7 +230,8 @@ static int evaluate_tpr_instruction(VAPICROMState *s, X86CPU *cpu,
         return -1;
     }
 
-    if (kvm_enabled() && !kvm_irqchip_in_kernel()) {
+    if ((kvm_enabled() && !kvm_irqchip_in_kernel()) 
+        || (whpx_enabled() && !whpx_irqchip_in_kernel())) {
         /*
          * KVM without kernel-based TPR access reporting will pass an IP that
          * points after the accessing instruction. So we need to look backward
@@ -549,7 +551,7 @@ static int patch_hypercalls(VAPICROMState *s)
     cpu_physical_memory_read(rom_paddr, rom, s->rom_size);
 
     for (pos = 0; pos < s->rom_size - sizeof(vmcall_pattern); pos++) {
-        if (kvm_irqchip_in_kernel()) {
+        if (kvm_enabled() && kvm_irqchip_in_kernel()) {
             pattern = outl_pattern;
             alternates[0] = outl_pattern[7];
             alternates[1] = outl_pattern[7];
@@ -679,16 +681,26 @@ static void vapic_write(void *opaque, hwaddr addr, uint64_t data,
         }
         break;
     case 1:
-        if (kvm_enabled()) {
+        if (kvm_enabled() || (whpx_enabled() && !whpx_irqchip_in_kernel())) {
             /*
              * Disable triggering instruction in ROM by writing a NOP.
              *
              * We cannot do this in TCG mode as the reported IP is not
              * accurate.
+             *
+             * Oddly enough, KVM increments EIP _before_ the execution
+             * of the instruction is finished.
              */
             pause_all_vcpus();
-            patch_byte(cpu, env->eip - 2, 0x66);
-            patch_byte(cpu, env->eip - 1, 0x90);
+            if (!kvm_enabled()) {
+                patch_byte(cpu, env->eip, 0x66);
+                patch_byte(cpu, env->eip + 1, 0x90);
+            }
+            else {
+                patch_byte(cpu, env->eip - 2, 0x66);
+                patch_byte(cpu, env->eip - 1, 0x90);
+
+            }
             resume_all_vcpus();
         }
 
@@ -705,7 +717,8 @@ static void vapic_write(void *opaque, hwaddr addr, uint64_t data,
         break;
     default:
     case 4:
-        if (!kvm_irqchip_in_kernel()) {
+        if ((kvm_enabled() && !kvm_irqchip_in_kernel()) 
+          || (whpx_enabled() && !whpx_irqchip_in_kernel())) {
             apic_poll_irq(cpu->apic_state);
         }
         break;
-- 
2.50.1 (Apple Git-155)


