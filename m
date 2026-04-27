Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424FBFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLPv-00019e-Uw; Mon, 27 Apr 2026 08:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNw-00087E-QS
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:31 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNp-0005ga-24
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso109080595e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294091; x=1777898891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0v/Sp1N38U1xnn6NTkNVlcM8HldzbtGaI2x8xgpzJPE=;
 b=q58AQbzBUCJff8HgLzSujIxRSMNwLrnxauYuYbeY1R9Uj/dKz1wgnvj3Bjd9cuDO8X
 OtG8Gtfmdd1IvyvG9DvOd/Bp+INziMtcZJZuR4dgZvzgg8/wuhggDz6wayq65qcRSmis
 lnV8O76/F1UG5KxYTzKj8gMgz0GJsuqOTAP4tTxC+2jM8ndt1kNMznmE79HOcow98fLz
 KkOkmMJb25RIv2RDcK+9cK+4fPU2Yw5fDomeeLe5MmLz3V+NR/64OPre0SlHNrJfYcUZ
 8oboE/GqQgo7Sb0GRKVx0PgtOQ0kZbTyOE5ctsQy/+8CIE6jHbZFtdsspsMLKcUYOD4Z
 168g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294091; x=1777898891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0v/Sp1N38U1xnn6NTkNVlcM8HldzbtGaI2x8xgpzJPE=;
 b=nOTHl9RIkPQVFQRk2x1mtVeDRgXUM7G+zSnKtbE5X+ToNteZx+I/10fGS0NNcGfHu2
 fMbzJF29MHn9wkRAsToBZOnTREE0LtUzGFDNQi2g5ME4UHPZ7+RMZ7Vm9qFPm1o7jmI6
 ECGA2OgJ3BMncBCrXrrihl7id0qRQbCaNo45iB6X5GW52YM8Ec/XrjA6gK9eGGA5ijck
 G7iJbQfwlnDkUIK8UZ4WnjSAsNnaD1VrHlLeCtAmZXln1mXH7nrTq1cWLPPkqPn5cOdh
 7Nd6BgRCMftpgPPIrAtpKOlhR+JZO7TgAkIDzBAxgewHEueDBac/RdawkMn0Z0ifLsFk
 DY/Q==
X-Gm-Message-State: AOJu0YzwtUJFInI6Md0poZEZ9Nk3UB2kdF3uzGEtOy0zzijTlK5crT1t
 h6FqSz0+syEIgV9duRE6lydNDUHa6rkTnnt1fpY9kHjL0fmOMsiQCW2BLrhOn7KrcNQrQLhhszz
 OqZ4N
X-Gm-Gg: AeBDieufoDs+Gcikl9jQBMR3a5yoNzTHxOAx4vf1hx/J/+jUQufGOADEdV9MJSMt8bC
 R8lL781NGPJ2Kwvl0it64tm3reI9fCG9e0sWbOXy4/Gz+ErhjoNXKszDNggl0aidlyQrh8uRtVI
 WQ6L4trrPvAj7pQYjeoIxLKXL3fOSVDD6ThGVCjQhus0a+GDVqdezjclBub+GQSBM+EaWYedyAz
 fAlUiTRkkI4URxqeoiqSFES5OAXDIlPoYgxTrpPe7o51dtABcJLefU2LIpthGJJvRgl45nqRsnP
 KuvnHmqrwemgHzGFr8X+quDxwRpoSe53TFEZ/iSlENPSfUdQMni10qWttg3cEORkNH3aiwwIl24
 stxN5du/+AzZzbW4bG6Gp2LBbF5zrSuJZn2sw0HAe/ZzFZjvBGnZC8GnIn3wotr2KT5MrD+RFVB
 eAZkIaXVPBivT+uxFBY+QKK9LpUr/GznKItUJGZJesDBJEsv1iDMKC4w5Oo4IPv1E9x/u7Jrqk/
 lci7cyKpXqmWWnpRO7yt5TJzzT6xTpvyhplQz6wKg==
X-Received: by 2002:a05:600c:4f49:b0:489:1ff1:74df with SMTP id
 5b1f17b1804b1-4891ff176bamr504250925e9.1.1777294091145; 
 Mon, 27 Apr 2026 05:48:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/63] target/arm/cpu64: Mitigate migration failures due to
 spurious TCR_EL1, PIRE0_EL1 and PIR_EL1
Date: Mon, 27 Apr 2026 13:47:08 +0100
Message-ID: <20260427124738.966578-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Before linux v6.13 those registers were erroneously unconditionally
exposed and this was fixed by commits:
- 0fcb4eea5345 ("KVM: arm64: Hide TCR2_EL1 from userspace when
                 disabled for guests")
- a68cddbe47ef ("KVM: arm64: Hide S1PIE registers from userspace
                 when disabled for guests")
in v6.13.

This means if we migrate from an old kernel host to a >= 6.13 kernel
host, migration currently fails.

Declare cpreg migration tolerance for those registers.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260420140552.104369-5-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index d6feba220e..e7014022df 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -810,6 +810,33 @@ static void aarch64_a53_initfn(Object *obj)
     define_cortex_a72_a57_a53_cp_reginfo(cpu);
 }
 
+#if defined(CONFIG_KVM)
+static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
+{
+    /*
+     * Registers that may be in the incoming stream and not exposed
+     * on the destination
+     */
+
+    /*
+     * TCR_EL1 was erroneously unconditionnally exposed before linux v6.13.
+     * See commit 0fcb4eea5345 ("KVM: arm64: Hide TCR2_EL1 from userspace
+     * when disabled for guests")
+     */
+    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 2, 0, 3),
+                                     0, 0, ToleranceNotOnBothEnds);
+    /*
+     * PIRE0_EL1 and PIR_EL1 were erroneously unconditionnally exposed
+     * before linux v6.13. See commit a68cddbe47ef ("KVM: arm64: Hide
+     * S1PIE registers from userspace when disabled for guests")
+     */
+    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 2),
+                                     0, 0, ToleranceNotOnBothEnds);
+    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 3),
+                                     0, 0, ToleranceNotOnBothEnds);
+}
+#endif
+
 static void aarch64_host_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -822,6 +849,7 @@ static void aarch64_host_initfn(Object *obj)
 #endif
 
 #if defined(CONFIG_KVM)
+    kvm_arm_set_cpreg_mig_tolerances(cpu);
     kvm_arm_set_cpu_features_from_host(cpu);
     aarch64_add_sve_properties(obj);
 #elif defined(CONFIG_HVF)
-- 
2.43.0


