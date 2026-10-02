Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8E1CA5FE9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCjkS-0007GN-2v; Fri, 02 Oct 2026 16:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkE-00079D-KS
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:39 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkD-0005kk-3Q
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:38 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2dd58e1e2c7so2095ad.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 13:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790972436; x=1791577236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pv8AjqpFedPnz/9wNooZL8HFQWI5U3Sd/PQnYUOcCFQ=;
 b=aCHjAnOaD7fFkprcZUx4i09eCcLXYL4s59euhOxJUlfpnn5ojb6WCQXyRamUGotpF6
 DyP9ROBNJdrWqA4qsAYShMBh/wrLgUSfbYFQDBTpLBqMJ/m/SDMMc9m22vvc0awzRINg
 IoLFTnGlRxy7gZO/2t9je3/rMI9vBYomdRpIR10kMNMb7ra/9O8wK7NFdrnad6ykgAUt
 3h/yHGTZ75YEMRjJeiw+6k33Gj7KA0LeGTS4GxaL2x9SbkfkSDPMW6VOkeRtntt3URPT
 35a8HSnCq2iXDQSkQll5169HVxnETY6jplLvASCBBXhZ7M17ecFYpt8GEtx+XGOVG4n+
 hhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790972436; x=1791577236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pv8AjqpFedPnz/9wNooZL8HFQWI5U3Sd/PQnYUOcCFQ=;
 b=RD+x65ReFWaOzZpOUIvOjVVeOmvQPnIxLAI9dvHfLJJ7+uuDI+NtFE3GuVuumwbPNA
 dhXEEhpFr+MSH+6JL8VwGWLOZKJ4fztjRqgzfT3QBlAMEwGGTGobymifgdF6ufovTBZT
 Rj5YrKPdLphj9Yts4AOWWUjdON1hWDgkMcR0T9LGGeaGdyrupB2NuOHKmFNTDns1QKDQ
 Oz23jDTzp9F6Zh2fgOB5UVlz+iw/ktMDceUaKTGot/4zLCn/Md8n0t11Z75jCnCO4ycF
 oL8IyR4bKipoOmS81hRuQgeq1xeHCOJcWTmaOCrgFB69b6I5xxlEA//pNv5l04EFk0SQ
 hE+A==
X-Gm-Message-State: AFq9FYKHR3QoWJkcOZ4d8/9sPUfVlZcwsmufsNA1UvCiN+uk4rAb6hV/
 Fi9SXS9cA7qPjj/LTP5wnrbg8caJnxLfgLA1VLo9YpvtgPWqkGJY1aCQarvBS1VXfHY=
X-Gm-Gg: AYBFou3jrDQRBRBcHAj5/+E5PSPsIr3aXP5EW1+fN4CVbbYx/d149GAA1SBfvcFStSV
 Poh287NvQkhC5aCZ9pQBSN5/iSDmY7Ahbn6YgRoVt3wHvHJ3b7+RNq5Phyv/juYWhzcpGp9jaXI
 G9Sgad8JDdzncC+VxuQlllrZs95rnYfEXNJ6Dn32uK8YERQl9mTYnYh7gbFz4aU4zGGuUpL2Rad
 WaXxwbo2VH/J3Gu5E4T1I2vvmoKahFIUn31egkqIPSgzp0yDKubG7lNLBs49wJ6cFdgnvlZb3lF
 9X0MQbfIi7czdC1Npx2M88ybr4vLtPTRLkXu2mlqa1haaTRcLDhzwseWyjXF2aByU26BLQ6gLo7
 u+cF5Q+PvyslbAeP0tZ2TXzdh7v360jQmQyOc3RuW+2V6g2KaMJz5bFhXxQMOoqnyDYw6Aadf/i
 mg/jIT76fCgr7RLkz5QBj58vqL/R4OYhZQiwAXUEkJrtH7pi5bV3Untu1XmHwveGIrBWWU+xN5v
 F4T/oU8XTuYeBCzei6U+RXg
X-Received: by 2002:a17:902:d4c6:b0:2df:5836:d1d0 with SMTP id
 d9443c01a7336-2e49b6add0cmr30968845ad.30.1790972435635; 
 Fri, 02 Oct 2026 13:20:35 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:61ac:e744:6559:a357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:20:35 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 04/22] target/arm/kvm: Split kvm_arch_get/put_registers
Date: Fri,  2 Oct 2026 14:20:08 -0600
Message-ID: <20261002202026.1204110-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

For a Realm, KVM is much more restrictive on the registers a VMM can
initialize.  To prepare for Realm VM initialization, split the get/put
register functions for a non-secure VM in their own function.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8b6f602ebe77..60272b8c040d 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2212,7 +2212,7 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     uint32_t fpr;
@@ -2315,6 +2315,19 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
         return ret;
     }
 
+    return 0;
+}
+
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+{
+    int ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    ret = kvm_arm_put_core_regs(cs, errp);
+    if (ret) {
+        return ret;
+    }
+
     write_cpustate_to_list(cpu, true);
 
     if (!write_list_to_kvmstate(cpu, level)) {
@@ -2397,7 +2410,7 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     unsigned int el;
@@ -2500,6 +2513,19 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     }
     vfp_set_fpcr(env, fpr);
 
+    return 0;
+}
+
+int kvm_arch_get_registers(CPUState *cs, Error **errp)
+{
+    int ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    ret = kvm_arm_get_core_regs(cs, errp);
+    if (ret) {
+        return ret;
+    }
+
     ret = kvm_get_vcpu_events(cpu);
     if (ret) {
         return ret;
-- 
2.43.0


