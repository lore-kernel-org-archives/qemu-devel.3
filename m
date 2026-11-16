Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3BD606A79B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GQlO4zHn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSuef-0003vz-0b; Mon, 16 Nov 2026 06:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueE-0003ov-Kw
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:19 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueB-00027w-Kq
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:18 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso1957880f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827591; x=1795432391; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wq8OK6FeZj9sXMcKYgkOQQCcjCveIvDl0grNK9jCDt4=;
 b=GQlO4zHnnzvpYFTUd3uQwmDNnzROUGQSNr3SCMd1qjyqlLdmGNpGNBvLZ6WOb72O3a
 dXQTrAfx7qmDZ6nr/0Dg2Zj+6kw5L/gYoBBgFDn87rDsvxWB/gF07ec6u5ur16eiW96w
 Nsd/Fit4jZmUcpullEISnbyPVrVfZEc9T6bR+HGupXkKZRJN84l2d5FAy5GezjitzzyO
 Q6oaItae1z1YgjDm5nnhsM072vrKxQnD+pGOlKa2IEJ2ESnxEvArAcyLvcO1ZSeHHFlv
 dGAoiYlatXCnzK26HAE93Ce3b9D6eS7K9gJzOXHo5es5U6K67xf5aUOmsXVp2NyWk6Tk
 A8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827591; x=1795432391;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wq8OK6FeZj9sXMcKYgkOQQCcjCveIvDl0grNK9jCDt4=;
 b=YNTiXyj4LB1dPTWEAyK5XCCHzmjKE+ERRALsdDrdl8ymzHp9Gpo/TWHNNnKr7xgXql
 TcP0IlwsTiSJDRacDAwbWm8WkHwuAEFbUkDgbQHEc48gbSLce45wcMqTLbRQdT2dFNQ/
 rH6a97rHQq6zGS0UmOQfXZSB2uU0R/2OuN7MNF1MKlfpACB6wrsUcAKTVGBG20tP7pPm
 Dp2HOeW+Dtx/98WSskplraDj07UK/Pkv3D+eW2BPb/nx6V4FFhdk0ouflsPaRjUQogTx
 e1evWFHjjzN0fN69GNIlGu5SSlx1pOgDieUFikPeoX1yimsGLgkx5TgTST1xZFevj0CG
 g1zQ==
X-Gm-Message-State: APuU4Z9hogxDmyiIj94Sqec+3CY32IZSkd6WkUmW7qzhmZcDLvV5DLHW
 EvtnYlBgr2ve4f4NnFzru6RWYs79CEIMbVVuPkU77g+xiZJzX4xuhB0+TMwnirUDllhHkM0/L7S
 36MUgqh4=
X-Gm-Gg: AZFdTZcNH2Y9ruRR18JIr37aYbuFGn5Bi0ZQehlwWZyOTjdMYoa2JOQKW+TsnZpR1Hn
 frPU2yMW3CwpLkKYUd2e4YmdHkgTdDU9Si1uqyabYtGjXs1IwL3ZpT2AH7O0RdZJlUOBjk90Fwc
 qUfralbIXRYOw6zQWlAGIXCZV/sq6atxwacYdbYY0JyQqN1MI1Fn4NZzgfDZLWYXCZuWHqaakef
 61DoVd+HcNeFv1+VAq4T4Mwh11KngOZftNaUNORa/2pzggr/PjR1FAmCReOHzn0hjG7lrSL0Yv5
 HT9Z8wK4a3GvnpnS8W6wQkz2MjPg23bBm5Za9HXWDILQ/yEueszTBVbkR2QvNUJzegYIGd9nuLi
 xwtaHci9FZ7KgHozpBKjHn/JT3O8hekrJvqsVRIu+rlFo0Jv028f3OMDKk7QofH0Vg6UbwTy44P
 Rj99oSoizxILwOIJ+03LVar0bi86wPM6ZcPunaztgqs6p4aMFJ45cpF5aG5pcLibVkUyipfs4tZ
 63MMyV/pnq9/LXFGjp/cKz9z7lKV6sfV8Db0oqkMmFQUxGMKAF+TSBxbSh8tSKezWWxLa6foZBi
 9RxxzBl7Ot35cny+AAdNBRQcTdz+XPKE9swxx5wkqaYiXwzciqpcipAoERNXniSb0Z4VyXwD1w+
 h+6jSgbdRGKkx1f0aTkOnzztwgdWSQgxXGQ==
X-Received: by 2002:a05:6000:24c5:b0:49a:94e6:378d with SMTP id
 ffacd0b85a97d-49b03217a27mr34168762f8f.30.1794827590511; 
 Mon, 16 Nov 2026 03:13:10 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/33] target/arm: Only allow GICv5 on CPUs without AArch32 at
 EL1..3
Date: Mon, 16 Nov 2026 11:12:35 +0000
Message-ID: <20261116111303.1692832-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We previously allowed the GICv5 on any 64-bit CPU, with a hack where
enabling the GICv5 silently disabled AArch32 for EL1..3.

Now that we have a separate 'max-v8' and 'max-v9' where max-v9
correctly doesn't implement AArch32 at EL1..3, we can fix the "when
do we expose the has_gcie property" condition so that we only allow
the GICv5 when AArch32 doesn't exist above EL0, and remove the hack
disabling AArch32.

We could instead have defined a new ARM_FEATURE_V9, but "allow the
feature to be present on CPUs where it doesn't actively break
anything" fits the way we've generally handled things in QEMU, and it
avoids having a new V9 feature bit that we only use for this one
thing and where it's not clear when we should be setting it for KVM,
hvf, etc accelerators.

In practice the only CPUs which will allow GICv5 now are max, max-v9
and a64fx.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20261103172616.2400758-4-peter.maydell@linaro.org
---
 target/arm/cpu-features.h |  8 ++++++++
 target/arm/cpu.c          | 37 +++++++------------------------------
 2 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 96ec12f64f4..b0edec28378 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1130,6 +1130,14 @@ static inline bool isar_feature_aa64_aa32_el3(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, EL3) >= 2;
 }
 
+static inline bool isar_feature_aa64_aa32_above_el0(const ARMISARegisters *id)
+{
+    /* True if any EL above EL0 has AArch32 support */
+    return isar_feature_aa64_aa32_el1(id) ||
+        isar_feature_aa64_aa32_el2(id) ||
+        isar_feature_aa64_aa32_el3(id);
+}
+
 static inline bool isar_feature_aa64_ras(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, RAS) != 0;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 71681447b21..dde03ffdd6f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1596,8 +1596,13 @@ static void arm_cpu_post_init(Object *obj)
                                        &cpu->rvbar_prop,
                                        OBJ_PROP_FLAG_READWRITE);
 
-        /* We only allow GICv5 on a 64-bit v8 CPU */
-        if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        /*
+         * We only allow GICv5 on a CPU with no AArch32 support above EL0
+         * (which is typically a v9 CPU), because GICv5 defines no AArch32
+         * system registers to control it.
+         */
+        if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) &&
+            !cpu_isar_feature(aa64_aa32_above_el0, cpu)) {
             qdev_property_add_static(DEVICE(obj), &arm_cpu_has_gcie_property);
         }
     }
@@ -2274,34 +2279,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
     /* Report FEAT_GCIE in our ID registers if property was set */
     FIELD_DP64_IDREG(isar, ID_AA64PFR2, GCIE, cpu->has_gcie);
-    if (cpu_isar_feature(aa64_gcie, cpu)) {
-        if (!arm_feature(env, ARM_FEATURE_AARCH64)) {
-            /*
-             * We only create the have_gcie property for AArch64 CPUs,
-             * but the user might have tried aarch64=off with has_gcie=on.
-             */
-            error_setg(errp, "Cannot both enable has_gcie and disable aarch64");
-            return;
-        }
-
-        /*
-         * FEAT_GCIE implies Armv9, which implies no AArch32 above EL0.
-         * Usually we don't strictly insist on this kind of feature
-         * dependency, but in this case we enforce it, because the
-         * GICv5 CPU interface has no AArch32 versions of its system
-         * registers, so interrupts wouldn't work if we allowed AArch32
-         * in EL1 or above. Downgrade "AArch32 and AArch64" to "AArch64".
-         */
-        if (cpu_isar_feature(aa64_aa32_el3, cpu)) {
-            FIELD_DP64_IDREG(isar, ID_AA64PFR0, EL3, 1);
-        }
-        if (cpu_isar_feature(aa64_aa32_el2, cpu)) {
-            FIELD_DP64_IDREG(isar, ID_AA64PFR0, EL2, 1);
-        }
-        if (cpu_isar_feature(aa64_aa32_el1, cpu)) {
-            FIELD_DP64_IDREG(isar, ID_AA64PFR0, EL1, 1);
-        }
-    }
 
     if (cpu_isar_feature(aa64_mte, cpu)) {
         /*
-- 
2.43.0


