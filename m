Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EEAC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzEF-0006Ba-9R; Tue, 25 Aug 2026 18:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzDF-0003wC-Oj
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:46 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzDC-0001tq-N7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:45 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2d6d28aa26cso2944635ad.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787695301; x=1788300101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gAVb9PuAUV6dKtPBz+8ymqKUXnXtU+Fo4PlEUvBAFS4=;
 b=NufytiY8pigvbrvMH8K9FBt1cNdG/oQIXnIEuOrQe/gTZ/AM5y5euifKk1D/mWN+ID
 F3hZX0frKsaBuBp6CHoAfoxyYpeOW5NiqAobht/Lgm8RLK9F0xZe66urqj7xXnWY2CRD
 Qbu4aYBnGBKCcvVAFStUGiGEvLpAvYVXphpq4CAGdEnFwnbJO/6Ru8YDaYhrAMEg4nTj
 JCzgj7biTM7BvqGh75LhkBD4XTjDx4hq81KZRwxY4Us5CGCvsx5HwUplykEzLqgeIqWa
 SnkB3dazT9zYnmcq/DoWdcgusUMsMACkWuM/z2nPb9i9ZWl9ZMLNgMu1MmPXCxDelLlf
 aiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695301; x=1788300101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gAVb9PuAUV6dKtPBz+8ymqKUXnXtU+Fo4PlEUvBAFS4=;
 b=CqvVCeu63tpopq0FE4U2ldC0gkmF7fsAzOuUFHOz85hTL0a7r1FGbGL3cL/uU2nv4S
 tTyN5uc8ydRXyjtOXZXWzeVsEeTLOpvFCENCMVCiX3O8UfQfiu41Kz8Hg1IhkXoXJLuo
 KlQ/uncfIRswIVCgELqk2sp3h9qNAA+AdK8U4feG2Wm1MUdv2k5XOv/7eIdK3YFA02eL
 v1CMqOr4DPV+cwYSC208DxqM0MsRJuK+7kepOkoy2qzMnkGqNR4IRIJ7lnc+JhvE23CF
 KJ7WavE9guyRhbDPnnkEOupyatUMIlSR+z3h3kOTaXxZ2/WNgpdB9PKXuFKfyeB4hPv+
 dPwQ==
X-Gm-Message-State: AFuF++mVZWAbo9KwrgUTxZXVAjK6thiuxhHm8926f1dUH+RZYvOE+4ZG
 8ETOkHKhSAGogmlz+sbvx3F/Zyy1tInPO9l8nSS61k3FBCSG76kwaH0LXZbcqlw60NQ=
X-Gm-Gg: AR+sD125zdDo+keBK+ZG1YKss+IcHmINB8V7q/zjuksTpVbe+0IJvr/yvUbgwAc5QMC
 M44tNwWIivwNiYe/2oG1HOdpu8cNpv+i6Zwrcqk35AipoOqU3Vnh3NIYOivipt1vb1a4hmw+rAa
 d1AKeQE1AoqmyHPZv2rvAesqtsZSu40M/AM9SDMaFf+/OzOT/X2xKA77K0Sem7ydJyg5Aas7A/l
 PDxFaIxu9dLEk1jxdpQ/hgFcNdZweYLuKjZlJVzsraRAW80ctSfBnHce+jh374XtUcidw4G8VCZ
 l7OW/8b8Vd2fuquxm2PILKFyDoIC/OocqkzFgG6sDPPRp7OZsKGGtVvZeCo5LVI12qKlo1Zp0Kd
 bVub4SVAd5xd4NkH7BjQzngUnS88ATC8KkJjD1WSZzCGeXblhT6HUT3SG2stQbZomL2NEbp2Z7I
 A++/lOFCuSBozWirUXgHSquWErGoq4Q5xjccbN+S2Z8ZdqHZ4uqSe8cil28dl0+av5aQbcuXCia
 4MrYbylY0/2dh4=
X-Received: by 2002:a17:90b:4a8d:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-3966d412ab2mr4045321a91.9.1787695300878; 
 Tue, 25 Aug 2026 15:01:40 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:01:40 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v3 17/24] hw/arm/virt: Reserve one bit of guest physical address
 for RME
Date: Tue, 25 Aug 2026 16:00:54 -0600
Message-ID: <20260825220101.3443954-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When RME is enabled, the upper GPA bit is used to distinguish protected
from unprotected addresses. Reserve it when setting up the guest memory
map.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index fe195d145676..2132e6595baf 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3972,17 +3972,27 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int max_vm_pa_size, requested_pa_size;
+    int rme_reserve_bit = 0;
     bool fixed_ipa;
     int vm_type;
 
-    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
-
     vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
 
+    if (vm_type) {
+        /*
+         * With RME, the upper GPA bit differentiates Realm from NS memory.
+         * Reserve the upper bit to ensure that highmem devices will fit.
+         */
+        rme_reserve_bit = 1;
+    }
+
+    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
+                     rme_reserve_bit;
+
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
-    requested_pa_size = 64 - clz64(vms->highest_gpa);
+    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
 
     /*
      * KVM requires the IPA size to be at least 32 bits.
@@ -3991,11 +4001,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
         requested_pa_size = 32;
     }
 
-    if (requested_pa_size > max_vm_pa_size) {
+    if (requested_pa_size > max_vm_pa_size + rme_reserve_bit) {
         error_report("-m and ,maxmem option values "
                      "require an IPA range (%d bits) larger than "
                      "the one supported by the host (%d bits)",
-                     requested_pa_size, max_vm_pa_size);
+                     requested_pa_size, max_vm_pa_size + rme_reserve_bit);
         return -1;
     }
     /*
-- 
2.43.0


