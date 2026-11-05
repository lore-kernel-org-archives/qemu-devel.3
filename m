Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AED606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=muTrMRbQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOwYN-0005t0-Ck; Thu, 05 Nov 2026 07:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xOwYK-0005sS-RL
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:26:48 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xOwYI-0002nD-OE
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:26:48 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so6483385e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793881605; x=1794486405; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xswJ7hiLDj169UhibfP965Sph8AslAZxMY/7J102bac=;
 b=muTrMRbQb+EKk3mGPK8NPLs+12NKp0LhnAYywJ2PvPnWEIkcCufQhV6AgBApzznV9b
 pxD/N+Kfk59UcVY4KTWEZsrVPZLAtj+QCn8WfYBFYKQyMysEYs7JpexvZwqeAY6YXma+
 JVftU8y76H8vkzsLGky3+fKelsGP0sVfkaTZkL3cyU44aqLQntjnodhDRyL18IAZBh5v
 KSIgyAgfr1IwZm8+iTd3HSewl14YhawbtXflQqjdhRtXKxFp2wGtWBULUjacpJmX0kLX
 fF94SsoBfnAP9OWOjLMzQL4TxaahRHmZdVMY+xHX/evjXhYz0MomFxYVEr99sTZP3w59
 /hxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793881605; x=1794486405;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xswJ7hiLDj169UhibfP965Sph8AslAZxMY/7J102bac=;
 b=WiOealX3JhpEhPbo9qJrihFTPnxz48JXcTVO/aE5tXcKNoGk8WjPEAT0SxLat8qo1Q
 JjqFhYS5g0ji9Ex4qK6wnKH4uPSq21eWB3YqONX7kWXPszccaO0/cr2pwBfmmUUyoJQg
 C6j0arrH7bEfrvUBZCgnMY26ofmXwRrq2oJK2W/FeRPhz6Ya7A+X3XdRA/exfHy8hqQR
 CvZVMZ066Nq0M9soPiVouWVJtUF1BjqaDuj3TZUSTlUNl0Q99aXHtahEAg60XM1RMxVh
 LdEJ0y4S1aZJI4t51NGxjpGjl/vyYuK0JB9GXz3nMIfVFSisFMlsmMG87f/eStqB/ghm
 38KQ==
X-Gm-Message-State: APuU4Z8Fe4+H6eLnxTvcUfjl9uObC6B4V/6G1Tt6oY40DOh0c1Oi79FW
 QYhPLBA84Zb3Bhlr2b6236txyvIACg34+Rhe88TPRvXJbzn8acVKa0M2TRZBEH8T7rg=
X-Gm-Gg: AYBFou099sw3dmL/ZzcDpNgtqiqLzbUhq2/qbwJXgf0icLsIs2gQdQ9XsK1+7wakMGQ
 0zfvSCil1pTI3XNszUeovVtTwCgjbtAvrcmisbWrSE592MUrimSmj8TzwQKjWehPEw5EAnpfFaH
 OsJnryYX7/v521c3FnQGZehVYUZz7MjPr0cjH/DDOx3u6b3thYJyTz2rACE59CLUU+TZEwaeRD8
 SiXAtDdTlkyBpVEFU15w2joJmnrKc8zRd1xqKR6LMCbSSw4qyA8xJ0Ol/e61UwEDngfnSZWjhmx
 bMBRwD6kutA3TKJHNDkPP/dlVHYSQb0fjDy7LYAtWZJ1lUcq6OKJw9I+dnddZ9/gMJTsDH4uUNC
 CWqEj3Qb9R//WAyIUFw/TNCVUkt7HN3Kkh7EJkkme0mzehMEPa60vxxFe4ekJzmA/wO3f33SyZf
 MbVSdp9OCc98CZJ+Nm9IzdLEfGwswDhVN9gFb1mKMbOstHmckyMD8kO8vld1RsG9ujGNrliNGHh
 tnYSPFysDINyS0gfUKxR7e8aBDsRwg1xRy2r205+VQy8/8OgymnHBFhB7U5evDv0ZWcKYL1b0FC
 CV94ewJwEiUi9JvZoGyGf3gL+vxC2r8Brc77x/7Ob/j9VU6KY1/yfhOOn9BThmAg7Yn4p+DkKTc
 Dy+m/qc2WwqQ9/VZFr5JM2RSKZENKIpzQDeSDmngIFk+0GzrE9oYJzoxKAMIdCT6kV/n6r5fCfD
 cVYnqMvcb0Yo0WYqnzNdk8WEWkgG8=
X-Received: by 2002:a05:600c:1989:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4b55dbb09dfmr45001955e9.13.1793881604714; 
 Thu, 05 Nov 2026 04:26:44 -0800 (PST)
Received: from satan.lan ([94.66.192.55]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4532916f2sm140636435e9.5.2026.11.05.04.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 04:26:44 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 05 Nov 2026 14:26:40 +0200
Subject: [PATCH] gicv2: do not hardcode minimum binary point
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-gic_read_bpr_from_property-v1-1-7e7392bfd321@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAB27GoC/x3MQQqAIBAAwK/EnhPUKKKvRIjlWnsoZY0opL8nH
 ecyGRIyYYKhysB4UaJwFKi6gmWzx4qCXDFoqTulZCtWWgyjdWaObDyH3UQOEfl8hOx7bb2bO+k
 bKEFk9HT/+Ti97wfL1HpUbAAAAA==
X-Change-ID: 20261105-gic_read_bpr_from_property-0882afdb60f3
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7011;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=p/lVaAyK4vxognNhSMF5UmN/5lgKqSrWqKx1ydWd3yM=;
 b=owEBbQKS/ZANAwAKAXcpx3B/fgnQAcsmYgBq7HYD8z9TZC7Ae8xkGlS9NC1qSjKEo3L6iGs72
 KPuXK3oGJOJAjMEAAEKAB0WIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCaux2AwAKCRB3Kcdwf34J
 0MCgD/9mgeiCfVcqhgqOiUsADnA6/UzSY3Gs1LTd5gVqydhUy3mcInDjVCDXO2vqA7wge8Ikz8L
 C6A+bN+5mwXVKRvOftU/IYmn9q3ggnZruibVTRMiCMvu6tALDfzW51TA5mohsjIHDf5IxGSj/NS
 wVgyPJ0NeCp9wgMRQIw/u5sfluDkLDd9b5nFrSfa8GWTGzPrV1vdc0Oso6Agb+DCoPbMUuR+VbK
 2T+NZZtqm1tfTn9QWhGKnadxkGFB0AC9RWy4d0j2rGiM/E5qqp7kPMokADhRWJVecwW733PfG/q
 0wf4hK3tFMMuDbqNCHhGXfDeEtDW3QwI1/uiLUh81P30WoWSn+ogqJ/ek7/G5BDS25w3TBWd9k5
 OkxKVzUzVvjIOE1mOu7WyjJlm/kJoS7WqOwabR8RUIPgSTsps960wAnhEtOCP6jomBJjN3PgwBo
 evyDyTq+WSWvB4li60NTvtbgYahDaKt7TJO+gUzJn8lid6IlnQ2C/RrcxhLIviyoQykepBXmV7e
 lZKi9hohX2dfZeq53/RwjOzOaWsjL7Udda4xXNTfgHtRSDuxo5GkdiUNyGm07qOhccBxHz50/pZ
 JNGR4b7NuES1/8jPRXT83dzbD8XH7l58UUJm3ury8m+SHi2FqnXrZ2ulkZZbjfabFZhn8Nnb7qq
 7ftzDHUFUBD9H/A==
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The number of priority bits is implementation defined, and indeed
machines such as a9mpcore and arm11mpcore define it in the
num-priority-bits property. However we still hardcoded GIC_MIN_BPR.

This commit replaces the GIC_MIN_BPR and GIC_MIN_ABPR defs with macros
that read the property.

The calculation is based on "Table 4-47 Active Priorities register
implementation" in the GICv2 spec (page 4-150 of ARM IHI 0048B.b
ID072613):

+---------------+---------------+---------------+
|               |               |    Maximum    |
| Minimum value | Minimum value |    number of  |
|   of Secure   | of Non-secure |     group     |
|   GICC_BPR    |   GICC_BPR    | priority bits |
+===============+===============+===============+
|             3 |             4 |             4 |
|             2 |             3 |             5 |
|             1 |             2 |             6 |
|             0 |             1 |             7 |
+---------------+---------------+---------------+

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4375
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/intc/arm_gic.c                | 14 +++++++-------
 hw/intc/arm_gic_common.c         |  4 ++--
 include/hw/intc/arm_gic.h        |  5 -----
 include/hw/intc/arm_gic_common.h | 20 ++++++++++++++++++--
 4 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 4d4b79e6f3408c43eae19c222edc75e41987b7ea..79a68a8648467c1f18dab69cf691f8e44ec2f011 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -479,7 +479,7 @@ static void gic_activate_irq(GICState *s, int cpu, int irq)
      * and update the running priority.
      */
     int prio = gic_get_group_priority(s, cpu, irq);
-    int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
+    int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : gic_min_bpr(s);
     int preemption_level = prio >> (min_bpr + 1);
     int regno = preemption_level / 32;
     int bitno = preemption_level % 32;
@@ -521,7 +521,7 @@ static int gic_get_prio_from_apr_bits(GICState *s, int cpu)
         if (!apr) {
             continue;
         }
-        return (i * 32 + ctz32(apr)) << (GIC_MIN_BPR + 1);
+        return (i * 32 + ctz32(apr)) << (gic_min_bpr(s) + 1);
     }
     return 0x100;
 }
@@ -1561,7 +1561,7 @@ static inline uint32_t gic_apr_ns_view(GICState *s, int cpu, int regno)
     /* Return the Nonsecure view of GICC_APR<regno>. This is the
      * second half of GICC_NSAPR.
      */
-    switch (GIC_MIN_BPR) {
+    switch (gic_min_bpr(s)) {
     case 0:
         if (regno < 2) {
             return s->nsapr[regno + 2][cpu];
@@ -1592,7 +1592,7 @@ static inline void gic_apr_write_ns_view(GICState *s, int cpu, int regno,
                                          uint32_t value)
 {
     /* Write the Nonsecure view of GICC_APR<regno>. */
-    switch (GIC_MIN_BPR) {
+    switch (gic_min_bpr(s)) {
     case 0:
         if (regno < 2) {
             s->nsapr[regno + 2][cpu] = value;
@@ -1731,10 +1731,10 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
                 /* WI when CBPR is 1 */
                 return MEMTX_OK;
             } else {
-                s->abpr[cpu] = MAX(value & 0x7, GIC_MIN_ABPR);
+                s->abpr[cpu] = MAX(value & 0x7, gic_min_abpr(s));
             }
         } else {
-            int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
+            int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : gic_min_bpr(s);
             s->bpr[cpu] = MAX(value & 0x7, min_bpr);
         }
         break;
@@ -1746,7 +1746,7 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
             /* unimplemented, or NS access: RAZ/WI */
             return MEMTX_OK;
         } else {
-            s->abpr[cpu] = MAX(value & 0x7, GIC_MIN_ABPR);
+            s->abpr[cpu] = MAX(value & 0x7, gic_min_abpr(s));
         }
         break;
     case 0xd0: case 0xd4: case 0xd8: case 0xdc:
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 304d89cf56219bf76eeeb24e55dbfe60be23ba43..7ffd94561202f49d767315893085df57a4f984d8 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -249,8 +249,8 @@ static inline void arm_gic_common_reset_irq_state(GICState *s, int cidx,
         s->current_pending[i] = 1023;
         s->running_priority[i] = 0x100;
         s->cpu_ctlr[i] = 0;
-        s->bpr[i] = gic_is_vcpu(i) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
-        s->abpr[i] = gic_is_vcpu(i) ? GIC_VIRT_MIN_ABPR : GIC_MIN_ABPR;
+        s->bpr[i] = gic_is_vcpu(i) ? GIC_VIRT_MIN_BPR : gic_min_bpr(s);
+        s->abpr[i] = gic_is_vcpu(i) ? GIC_VIRT_MIN_ABPR : gic_min_abpr(s);
 
         if (!gic_is_vcpu(i)) {
             for (j = 0; j < GIC_INTERNAL; j++) {
diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
index be923f7ed8861620d17fbf3d8569c42ae7c95487..e090bd0b283297d0863e13ef07e5738a549ea59d 100644
--- a/include/hw/intc/arm_gic.h
+++ b/include/hw/intc/arm_gic.h
@@ -70,11 +70,6 @@
 #include "arm_gic_common.h"
 #include "qom/object.h"
 
-/* Number of SGI target-list bits */
-#define GIC_TARGETLIST_BITS 8
-#define GIC_MAX_PRIORITY_BITS 8
-#define GIC_MIN_PRIORITY_BITS 4
-
 #define TYPE_ARM_GIC "arm_gic"
 typedef struct ARMGICClass ARMGICClass;
 /* This is reusing the GICState typedef from TYPE_ARM_GIC_COMMON */
diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_common.h
index b169394e6ca28d787d70e9c103ebbe5b12202ecc..c89f8a3292dff5460e2baa49c9a55de6866fc33a 100644
--- a/include/hw/intc/arm_gic_common.h
+++ b/include/hw/intc/arm_gic_common.h
@@ -37,8 +37,10 @@
 #define MAX_NR_GROUP_PRIO 128
 #define GIC_NR_APRS (MAX_NR_GROUP_PRIO / 32)
 
-#define GIC_MIN_BPR 0
-#define GIC_MIN_ABPR (GIC_MIN_BPR + 1)
+/* Number of SGI target-list bits */
+#define GIC_TARGETLIST_BITS 8
+#define GIC_MAX_PRIORITY_BITS 8
+#define GIC_MIN_PRIORITY_BITS 4
 
 /* Architectural maximum number of list registers in the virtual interface */
 #define GIC_MAX_LR 64
@@ -151,6 +153,20 @@ struct GICState {
 };
 typedef struct GICState GICState;
 
+
+static inline uint32_t gic_min_bpr(GICState *s)
+{
+    uint32_t num_preemption_bits = s->n_prio_bits == 8 ? 7 : s->n_prio_bits;
+    assert(!(s->n_prio_bits > GIC_MAX_PRIORITY_BITS
+             || s->n_prio_bits < GIC_MIN_PRIORITY_BITS));
+    return 7 - num_preemption_bits;
+}
+
+static inline uint32_t gic_min_abpr(GICState *s)
+{
+    return gic_min_bpr(s) + 1;
+}
+
 #define TYPE_ARM_GIC_COMMON "arm_gic_common"
 typedef struct ARMGICCommonClass ARMGICCommonClass;
 DECLARE_OBJ_CHECKERS(GICState, ARMGICCommonClass,

---
base-commit: f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5
change-id: 20261105-gic_read_bpr_from_property-0882afdb60f3

Best regards,
-- 
Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


