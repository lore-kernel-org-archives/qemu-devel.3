Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE9B606A329
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TcYxn/QU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDs-0004xw-FL; Mon, 02 Nov 2026 08:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsD8-0003Kl-RV
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:32 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsD6-0002Jc-WE
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:30 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so19850385e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626587; x=1794231387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=prHHVAfIxtxsEvFQKrm0jtY/q4LnNknx7OW9oSCcg68=;
 b=TcYxn/QUbZEl4OUqvWLmZ9Sh1IVvQoXj8Xnkd+o/fsXo1ws04NutxHrkYjGkyQMAtJ
 7HevX9YazD3g/s26sCHIKjDmXsDYrtbJ+RPCqSEP4LnGhBSddkjES95CSY8dynax9xr5
 8spcLLcPydN6xCD/rD7hNCmW9AxtR1kOQDCgONpIx7bXAVjRMZ5bv2yB2j639YD50MoT
 d9mqYWAOvsFMoP8/Ef338E/XSnU8dx8xhwzu8fDhbLeeQkfqIa65LS8e07SOUPLk1FO7
 jcJyAJ5uTKbAdtZn3BUpZcPk0zYGXGAHyG/d4V/azq5rwVEEvNaM54l1BaM/5F4kZO3S
 MmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626587; x=1794231387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=prHHVAfIxtxsEvFQKrm0jtY/q4LnNknx7OW9oSCcg68=;
 b=n4KNuNlug/1cp4aNYfoQhCe3cYiwxSOt21F/yy4AQv+jQAumjqCSopzZajp9sfaavp
 2emEsBFimNYbT0Q2xsr48tc5a7qXpmKYNBWBM7NwBfVMkP84VPc3uipVLp4lQW9XSP2T
 TafOkYOY13G4bhSgRAkJ8bh68E5RDJpYzngIy+9Y20BSde/8yMUKb1mmH6I/FOfLf2Dd
 dM6NNh3dP6LDsdW/JpJN0AR3T7JjhgSP9ksh1x9O/7ANuJB1YwKhOSIBQZuM53vn1sJj
 FoZy2hONaM+0C+r4lmWZbMlOZYL7sVPQ2nziiHBNpFCY80KboomKKbgLpUyrdIKQinaR
 NlXg==
X-Gm-Message-State: AFq9FYKnnSJef76g/sFz2ca6c86zDKWUy9A59sgq0Qd+1MSFnJegeUt0
 qy7vcFKwe1/fADPljGdeeExrwlOnDcx3/Z3jqP0od/qPPhx2oquqqi/dkEFEc60QooAD4R41X5y
 MCcJ/4AA=
X-Gm-Gg: AYBFou086oWDD14vKsr3iIb/6M8JfDjAsb999vwRclThezuDm/vcx4Y0bX4rSfC1nHE
 cE8LPKqPrTxg8zRpunGqy3IPxzt/Ds1f+HLaA7iqUeo8ea/uVwKM+YikBGoUN+t8KsOPR9E89Qt
 F4wjxqqoZ2UJsDIhMN93AtYMsDeq3QEPeU1PNIsUPFX9K5uokno2m2/ExrszdeB2YK26WdmRZ5A
 IAdgVXTbr0QPrwb5REGmH7QLuJNuX/DV+VOyB8uxF/uVQTwL3OXBjVHjfMB5CE5KrOWCUEtHCwv
 9aznXz+D2mqnoInbqJ01jrSnArPDaiI99za16Xab+CRsKhJir4CCWWSOCPnrjTxD64SpUGWwiCP
 svoS4ShuWjpp3g/jD969vpZpJIcljP/bAxZQaDnkW/yfKVBQE2C1QYL4XnbPPymKIvnQ2a+66t0
 jptDcqFqzzo3d+o6pWNE6X/Gsdlrr6yqRbW+Xc69Z2HZI+z2aVly2Oy2By8ejDrSfzWRDXcEm4R
 45v7rsXOuFPjqct6RAkQzHfjklzVIXU//iFNQOZATHaN5Va1xKwXPDVOOc/R+1ugA9q6Km6ur98
 F8BOabyuwBIe8vve0zwU/7lisu3gKTa8NFJtYHlhUa/10+qGR8X/XpXb9VkvRKxNwELwiQQNaa7
 8Qcyjq6fRT+cTswzUyXUOGFPO2IK0Hlg1Hw==
X-Received: by 2002:a05:600c:8b55:b0:4a1:ddca:8b66 with SMTP id
 5b1f17b1804b1-4ac19234a06mr223519985e9.31.1793626586900; 
 Mon, 02 Nov 2026 05:36:26 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/47] hw/arm/virt: Make sure virt_get_caches() keeps on
 reading CLIDR_EL1 as 0
Date: Mon,  2 Nov 2026 13:35:33 +0000
Message-ID: <20261102133547.1375701-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

From: Eric Auger <eric.auger@redhat.com>

In KVM mode, virt_get_caches() currently gets a zero value for the
CLIDR_EL1 register. This is due to the fact CLIDR is never read from
host. This is a bug.

Soon we will initialize all writable isar.idreg[] from host and this
includes CLIDR_EL1. However, we cannot directly fix the initialization,
first because it would change the way caches are exposed to guest in
DT/ACPI descriptions and because some host values would be rejected
by the current QEMU code, especially in the case host has a unified
L1 cache which is currently not supported and triggers the following
error: "Unified type is not implemented at level 1" error.

So this issue will be fixed separately.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Khushit Shah <khushit.shah@nutanix.com>
Reviewed-by: Gustavo Romero <gromero@redhat.com>
Reviewed-by: Mohammadfaiz Bawa <mbawa@redhat.com>
Message-id: 20261030131406.461599-9-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3ab3ad8c3b6..637b44ff334 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -337,6 +337,21 @@ unsigned int virt_get_caches(const VirtMachineState *vms, CPUCoreCaches *caches)
     ARMISARegisters *isar = &armcpu->isar;
     uint32_t clidr = GET_IDREG(isar, CLIDR);
 
+    /*
+     * Commit f669de70011 ("hw/arm/virt: add cache hierarchy to device tree")
+     * read the CLIDR value from the isar array. However, in KVM mode, we failed
+     * to initialize that register value from host and the resulting bug is that
+     * we have always read 0.
+     *
+     * Soon we will initialize all writable isar.idreg[] from host, including
+     * CLIDR_EL1 but we will need to handle compat properly and also extend the
+     * support to unified L1 cache. For now do not pretend we have something
+     * different from 0.
+     */
+    if (kvm_enabled()) {
+        clidr = 0;
+    }
+
     for (int cache_level = 1; cache_level <= CLIDR_CTYPE_MAX_CACHE_LEVEL;
          cache_level++) {
         uint8_t ctype =
-- 
2.43.0


