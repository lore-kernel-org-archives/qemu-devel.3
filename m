Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D8DC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSU-0005Zy-5e; Tue, 01 Jul 2025 13:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSP-0005UV-Pb
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:46 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSI-0003S4-UG
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:42 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso2787627f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389657; x=1751994457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f4e7g+zAPhyn2jXoPUb8Dn9jnEqXYry2op4lCwZB1eQ=;
 b=FvVg4Zwh792cN6s6XS5ADBsx8Wq1a0nJcmi8cL1NO2VOr0oNWSCtRkpb2AzFQLIBFt
 UELFsWXPDSJ9Q+mn2fd6zDqtUtigwLtDBJo7hGbfzk80OnQR40G/9lh9q52fCMcLQpGG
 4YczN3W9+8T/D4YOUkbluRyJxg3hoOTCGXKXl+kC1FDFPFQ6tkFFpgp7QP6d44J7Jw60
 W/uYYXc27ygWkrg52Nlu2KQ2h4lmC+veAy+1te6pirZHd5DBL4g0jY+zQN29F7SITYGs
 YQafOZX9jweadwfLBPrurwIpgIRya0x7S+PH2mdzi3DTgvhTX6LhuGzFFxo/KGeA80Hy
 PiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389657; x=1751994457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f4e7g+zAPhyn2jXoPUb8Dn9jnEqXYry2op4lCwZB1eQ=;
 b=RR6pGEtecdMCreon04MrELwGjnMOQGImYuJ8jKj3TJVM7uWejl4gzM+kyPXaqhV6FM
 oGeF3mrvrHk3PSuhJAHRbOrlxe2dATIXh6NdGiDReMww5GBvvCJKedkuo1B3Fc5YsO2c
 B7YKm0LONM1L2hndHNwA8V0aGVL+PCWcI6GCRf3Iegk1cntsnItAp9sEv/HVN9WqjHlj
 uN8Wo73AK6ma9e7mjjIlf1cXALhB9cgYQwLHHzMjvWGrxdJoM+7eZkqxSnpvkkO68k+B
 2unOLd1CVdUgyckqdqYtQDiTe5rVrvfWwIRPSu2QTof/3/mGeaM2Gk5se2Ase41A38G8
 9pNw==
X-Gm-Message-State: AOJu0Yxv1mtWKpPYOPxJDwne2XHv6cAsEH6r1Mv3eaz/bfGNwQfoPMuZ
 QIeX+G7SY/qbG6bToXmnGj9TcPbPISnEqcRkhlWR+NeJeAfF3rbkaesq1Nc4kOnSewuqZd7K7A3
 2ovGr
X-Gm-Gg: ASbGncvNnXlGae4Md3NdIG54n4nJpjaXU6dicQWw4qAcnvYfzCBolSWfadmW8fUTNv3
 UhJgUBrhwEeQwSuA+nJEutkodgiX2N0zyJuaPaKwENiAUyOQU1Ns4q5RjIQ8prAkERLH2QQWSCw
 vOYSbkCdg8JbBZcEZDkJKcGQknYBfF4WCs/wGnGJ9vTGBnuAo/Lu08t5b2R46mixpOdao3EMWh2
 CyRVpMt4gh9cfRQvwvnjUyROSqXxeoUbR4rZSSKf+MNK1bGoFz5Ijdy8PpoQdmU0Sgn9vIVQ/7u
 XIM2WZDBfhNL4rN+Rmz7LaRvw6QG1s41R7l3kZpQUpW4M5JPkNTrJqQ6OhNDC7hdsD78
X-Google-Smtp-Source: AGHT+IHrCpzrPWhUMtSBEgV/mw60dVjx8EbN6UG34749A0+1UbALx2+9VdR64kRoonW+8dNkXOHyQA==
X-Received: by 2002:a05:6000:2d09:b0:3a5:52b2:fa65 with SMTP id
 ffacd0b85a97d-3a8fdb2a75dmr12916075f8f.5.1751389657157; 
 Tue, 01 Jul 2025 10:07:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/43] arm/kvm: use fd instead of fdarray[2]
Date: Tue,  1 Jul 2025 18:06:50 +0100
Message-ID: <20250701170720.4072660-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Cornelia Huck <cohuck@redhat.com>

We have fd, so might as well neaten things up.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-id: 20250617153931.1330449-15-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3df046b2b91..70919aedd0a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -348,11 +348,11 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= get_host_cpu_reg(fd, ahcf, ID_ISAR6_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_MMFR4_EL1_IDX);
 
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr0,
+        err |= read_sys_reg32(fd, &ahcf->isar.mvfr0,
                               ARM64_SYS_REG(3, 0, 0, 3, 0));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr1,
+        err |= read_sys_reg32(fd, &ahcf->isar.mvfr1,
                               ARM64_SYS_REG(3, 0, 0, 3, 1));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr2,
+        err |= read_sys_reg32(fd, &ahcf->isar.mvfr2,
                               ARM64_SYS_REG(3, 0, 0, 3, 2));
         err |= get_host_cpu_reg(fd, ahcf, ID_PFR2_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_DFR1_EL1_IDX);
@@ -390,7 +390,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
         if (pmu_supported) {
             /* PMCR_EL0 is only accessible if the vCPU has feature PMU_V3 */
-            err |= read_sys_reg64(fdarray[2], &ahcf->isar.reset_pmcr_el0,
+            err |= read_sys_reg64(fd, &ahcf->isar.reset_pmcr_el0,
                                   ARM64_SYS_REG(3, 3, 9, 12, 0));
         }
 
-- 
2.43.0


