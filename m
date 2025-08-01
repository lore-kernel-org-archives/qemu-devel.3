Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE43CC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvMv-0006LE-EW; Fri, 01 Aug 2025 15:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhtjw-00073t-5b
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:40:20 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhtjt-0005mK-HN
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:40:19 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b34c068faf8so2566896a12.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754070016; x=1754674816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxMOfao7mm3NljQf8heTfDhWODLVv1lGmwcvHpnTOOc=;
 b=GJmmGFV9omwVzpyRiMRTPGzOok9V952IXTxQnnhyICcIEjLBQvxVIli7sx8IAX1pMm
 GF6KmDaUlKBg7xwd6nNAQXbcO48HsiQg4b7JM4yliX+o657A24PO0RXHCe4/GWlaYKfk
 u9UuJ95FSrJr9srqF918VRJSX+UD2ZBjXih7zTzxQ/G27yJvkWnhforAcidoPKJwEh2r
 Cl70AiiWC1zSZ9Bo9sxEOViSIZ70bjpE6AzdLEdzTyTanVfLzs/auNE7KXRQeZK6O7vR
 hb/KU9RxvEyc435yVFXsVKEpx6sn/3B63Xe6xgDJkUzeFynwJIwRd8LP3RIn6dhWDNzb
 VD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070016; x=1754674816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DxMOfao7mm3NljQf8heTfDhWODLVv1lGmwcvHpnTOOc=;
 b=Wfklmg3YM2r+jfaR3UI73O0cd6+XMN/dZPhOqUhRhfeJuMFO0iI1C01Ho+cyfY6wXp
 MKTEtOiQ2/y/RWkmwaLv9myHsNl/AnCU5dQhOktw7L1/hLjI3Q81MEfbccts5Jk3iS6y
 50MikoQLFG78DUT51qaS1ka3j/PFyXDvDgcWZ99mxfgGlhg5kt2ykGshgNxuedbk+y2H
 XoRXbGn7d19a0DJyVE7jDK7DZBy7MnLVKNBDQcKmYzTtK1xV+IoLQkPAVS6Cv/67pCt1
 Qfb9ofXzeIHtjkhpIsaGO4OEBMajQ/8h6OX4pN3NWTP/TYM7poMTNpblMC64KvJ983Fd
 Y0Rw==
X-Gm-Message-State: AOJu0Ywvn/vVUhQRu4qc80+rxJU+jyxWzEIgt3ZC6VRqBxTrUa6UG6X4
 Kz4WRcm98XZImITNGWjDEzddzgzq2FVvC98odiWichPB1QVBu+4olyrJ1VqtvkiCYQr9yvsJGJX
 43KHffE4=
X-Gm-Gg: ASbGncsKVMfMmaX7ue53eVSJgY8aGq4LuXnlgZvz1FvrmXaOr4lJkszuz8B519Nxhfp
 //IrApJ/SK8zd/CZvkAVoV9e6EoDpDU2yFc4N0WQW3hynCg5lnsH68pOFvAwmXClh02lxV6xGgB
 px8stFPDOTYdUAfUuKGmU7ofBQELUfrfljoEMI/abotBMTYJV/NUEFia50JJdrasJPx+ZG49Iyt
 S6mNLUtaat0ri7FnIMy7PaUBcDet3bkZtdIkzJYlqzIK88Tq5tRoypeWRRfEEudk+GWNVAbRbMW
 RLKgFtzgwvSoOo7AtElcnn6+SMYPiPXbntLYzvWYHBypMAWeSgV7bMSHZfeV2BoNt2HypjiraYD
 LtDBOu1CyMNrzCibBnjmVVg==
X-Google-Smtp-Source: AGHT+IHORpm6jJZdj1/15GdG01HdW4tMJNjFyK1NnbF+R95CKiSAGWIKZFyOPdM6NHZZyV0peHOl9w==
X-Received: by 2002:a17:90b:4c08:b0:31e:c630:ec93 with SMTP id
 98e67ed59e1d1-321162c733dmr795055a91.16.1754070015940; 
 Fri, 01 Aug 2025 10:40:15 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63da6141sm7972925a91.1.2025.08.01.10.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 10:40:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 2/2] hw/intc: compile some arm related source once
Date: Fri,  1 Aug 2025 10:40:06 -0700
Message-ID: <20250801174006.2466508-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250801174006.2466508-1-pierrick.bouvier@linaro.org>
References: <20250801174006.2466508-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

Let kvm related gic file out for now, as they are compiled only on
aarch64 hosts.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/intc/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 3137521a4ad..3efb276b6e6 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -38,11 +38,11 @@ if config_all_devices.has_key('CONFIG_APIC') or \
 endif
 
 specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
-specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
-specific_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
+arm_common_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
+arm_common_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
 specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
-specific_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
+arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
 specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
 specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_LIOINTC', if_true: files('loongson_liointc.c'))
-- 
2.47.2


