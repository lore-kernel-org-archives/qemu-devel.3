Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D0A606A33A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zoLY3OHU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPE7m-0002tU-GK; Fri, 06 Nov 2026 02:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xPE7P-0002jh-Dw
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 02:12:16 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xPE7M-0005zH-DK
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 02:12:11 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so2444345e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 23:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793949127; x=1794553927; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gJmyz6DjtNLprHs1YyidXkr9eyMRwX95i2Jfmpx+GYo=;
 b=zoLY3OHUyy/P+5Dm0Z2WWAuHasjUSaCnxmi1AB7Qlh4HoLq3RTVkDb76ckzGxkeKhe
 AXOJp+nfOr2I/j70RuTFxtpSoJva/9RprSLz9zEFn9fjXZZ1yIWGA176wz3vp6wmuor/
 rJ1/wXBi6ix50+gYJPvirtxALY9+cnHZU03VCt7CxpEQCJ3J8uJdfO4aPbqnea5PTIKD
 T24jqbQTj6U6VOrRZeY3ezQaJYh222ZyfNO1rpfaegR7CNJn9i9Mr8E8ySe90UnH5wbM
 qFaX8EnrUJOvMJjoQBQHc3mB5L4p+Z7gTsW5bMfD799XIuQRyGw6RzDKrfew6bZzY8vM
 cOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793949127; x=1794553927;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gJmyz6DjtNLprHs1YyidXkr9eyMRwX95i2Jfmpx+GYo=;
 b=Fe61LufEY9nSP/6SuarcCBBvnddtSFjkoh+3p+EP9vpa4lOHBhCyOXy2zUfgydvfTF
 AKmynbk3BhKIPWN2r3kMjiC2SRkbA6odnUVPe3igsA1cyWmTd77QK+BLKr0c5HeZrS0z
 9cW0g0Lf7i5lWprq3FkOiiosdFQoYI95Sta2edt8ZLicg7Xs+u+oui39BscCyqAemvEH
 sSycRUV+EpR+lOKdEJ9CcC7L69ov9IbdM7kSqai6SWcoViP8R33DMUpE0aLMrElIpyia
 jjtBvdZAMKALE2NHutvri1U4hr061u4rmi9NXUF+23jUMDFhaVFn9s+Eb/GmgXbZHcoO
 wVfg==
X-Gm-Message-State: APuU4Z8hgZ9NYIK0o4T2qB3UyBPR6i0TPRpfzxUQe30zPBKqVuSEbt2O
 LQYl/0wycvytqMrAsnjfiwJoLUOuvBFOXyf2m5Koe++nBUEihHFg66MtUlf8ktCIIN0=
X-Gm-Gg: AYBFou2vxKB8rKen61xVYJ17Knh8tsazQfK3v8N4w6jwzM+fIgtjDMWYJ0NimPnkZMO
 C0tpXyAsplfG/al8LJ/WvJx51rt5eOlZichSD0Uibife1uANT60iqzpnxzMDVsKXr3oUzn+Alut
 JLgii8bNawEA1AgB0jEdXU57Z4HQWcF+/QzACrPBfxAlbe1J2PRli0emUmgaa02ykck3U+t4NZz
 tc7oGucmiD/OLrDnt4AwTjqJMk4QIX0tJ0CldSLZ2bbwtyCSNjx0TrjxU2kj/V1HgH4QjMIFlHD
 gr+Quhdnm6mGQQom+nH/JN3WzrxqIUn/NMf0SHNefKLW3VeTMUu+qorHkQ+MH5Q2NH5eBf9NCE0
 BEw1GJHUk5ovdwyAGyVdy7lcjxXPbs6Abjp1nI+SOwGrWlDaL0v5ELbAgcnAZT4J6pzsosMtzGI
 9rnw22mt9qOope1SpVlj5cFeVCZtpMpsaAIVrnfnVX10MpP1NJXQ8lM4niLhYkrIXlK1WBkLwjn
 cXKQ032oBRU6EKyu/8dSzIFUSAZD89Tcx4i7ACZfBuNRhvDz38s5rdnFrNyWMvUOGe00KG1Nu42
 ytV/TIAIJNrTzv3uJTNkmkz/qN4NHigPAe8GiJ6A6/jq9qD6z7/RfPhEl+KHYknoixTU8fmMBmx
 cxQmT6NjhrYQlmLOAEHWcCa8MEaz0zJELrfT9AhikXqb0LUpzxH2/3+YzyCArQR0SW/zHpaRK4K
 5N52/rRl0U5N+p
X-Received: by 2002:a05:600c:a013:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4b6e091ed5amr20610965e9.16.1793949126796; 
 Thu, 05 Nov 2026 23:12:06 -0800 (PST)
Received: from satan.lan ([94.66.192.55]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b571f46489sm113916495e9.3.2026.11.05.23.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 23:12:06 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 06 Nov 2026 09:12:00 +0200
Subject: [PATCH v2 1/2] gicv2: do not hardcode minimum binary point
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-gic_read_bpr_from_property-v2-1-9f096cce4814@linaro.org>
References: <20261106-gic_read_bpr_from_property-v2-0-9f096cce4814@linaro.org>
In-Reply-To: <20261106-gic_read_bpr_from_property-v2-0-9f096cce4814@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6623;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=7F9/b/GIJggRESZ15qqnA8p3iz15P+V5oTVFjL1s/dE=;
 b=owEBbQKS/ZANAwAKAXcpx3B/fgnQAcsmYgBq7X3ENJ47XidzqU8nNpy8EJ60IB8oap99xt8X6
 DfvVB+D3nuJAjMEAAEKAB0WIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCau19xAAKCRB3Kcdwf34J
 0L0/D/9aqi4fbWWkxorPRhkQQy2gtvbHkRaVQBFetPryROykjiqH7debkuP2FgP723vD77v34od
 WnGQQnovObWCaqx5Mn91ukQDtrF8qCLxZkxTG1DwQF9YsDbgM5xSo3M4ZChnRwZwe9TAIF9ZreX
 JPZ3QMGiJmFi18aqqX+0z7lxiaS4R4nR2hnb6Gm/uUQkQD6XXx1QGIRlN0J40KJW7lY8uVPyXxc
 /ke5VSe3KYr/jT+WEnbEJAe5hCs96zXaNcGLYD+dH9XDod1g93rluDCXgRzhyd0l3otaFkjPpcz
 8q3qrfzjK52IdBXMNoSjwlqkQp55f3cQKBZ9WlbOPiEHAvu+nRWai3UWQo9Wisl/xLtPP2uHjyx
 NIz3tnS8QI2v5DE3JAq9neQJfAUmgQowBhfMjCnk6a1B7Huz8WFa7ErUKCXwIzA3JEI0g2Fd7k4
 4ZQGNSdEtrRDGm2hfjoxOGM1jwkVw6ZHmyCppPG1fdVuiMcsVjE4Ue6SFbs9LxkIhY4wUikbSyy
 kgri6wFxjw1nSdigkyip7cSuk1OqroBvRzz6XvrowGtr+vMrNfcBdUpLmlYCiGqUj4+ijvkcsMM
 n55fO+Qv2k1Yn/vVgrDStv1Jofedt/q78+0lL34w0HuFuA6Cxou1hJLn77yfp6n8p9ZmjeYHhyg
 VAb/a7E5uPvtApA==
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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
 include/hw/intc/arm_gic.h        |  2 --
 include/hw/intc/arm_gic_common.h | 18 ++++++++++++++++--
 4 files changed, 25 insertions(+), 13 deletions(-)

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
index be923f7ed8861620d17fbf3d8569c42ae7c95487..a1f4a2eebab5fd0fde6dd4b73464f3df3d32313f 100644
--- a/include/hw/intc/arm_gic.h
+++ b/include/hw/intc/arm_gic.h
@@ -72,8 +72,6 @@
 
 /* Number of SGI target-list bits */
 #define GIC_TARGETLIST_BITS 8
-#define GIC_MAX_PRIORITY_BITS 8
-#define GIC_MIN_PRIORITY_BITS 4
 
 #define TYPE_ARM_GIC "arm_gic"
 typedef struct ARMGICClass ARMGICClass;
diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_common.h
index b169394e6ca28d787d70e9c103ebbe5b12202ecc..db7370a80ab4011f33dff30fdffb0ba953a80fea 100644
--- a/include/hw/intc/arm_gic_common.h
+++ b/include/hw/intc/arm_gic_common.h
@@ -37,8 +37,8 @@
 #define MAX_NR_GROUP_PRIO 128
 #define GIC_NR_APRS (MAX_NR_GROUP_PRIO / 32)
 
-#define GIC_MIN_BPR 0
-#define GIC_MIN_ABPR (GIC_MIN_BPR + 1)
+#define GIC_MAX_PRIORITY_BITS 8
+#define GIC_MIN_PRIORITY_BITS 4
 
 /* Architectural maximum number of list registers in the virtual interface */
 #define GIC_MAX_LR 64
@@ -151,6 +151,20 @@ struct GICState {
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

-- 
2.43.0


