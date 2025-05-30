Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E3AC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu0K-0000Cx-Ej; Fri, 30 May 2025 03:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxi-00044o-8u
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxg-0007F6-Lg
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w20J/APZ9uCYTjnYTehJfQrWen6tMGIAHaXA/VAF3xA=;
 b=eIWliQypSMAF5WaxxQipxCUWcJ5NQBJ/lYkRCRdUr1TQcFy1Qw+Tdn+cmin71ZCzV1bc6j
 7fwGH1p7106VZN+4dA9Q1Z7APDbOuPXkhX+HQoXNUAPb8c/fZaFPrP9nPiPFGdtPb3vqUf
 E2kJRQt1fXCfKHzmMdWlOpd7HTOhojU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-wrvFcK0hPDm7jhS5qHvdOQ-1; Fri, 30 May 2025 03:15:26 -0400
X-MC-Unique: wrvFcK0hPDm7jhS5qHvdOQ-1
X-Mimecast-MFC-AGG-ID: wrvFcK0hPDm7jhS5qHvdOQ_1748589326
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac79e4764e5so176803066b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589325; x=1749194125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w20J/APZ9uCYTjnYTehJfQrWen6tMGIAHaXA/VAF3xA=;
 b=eN9MzgVphGF4PikPdJt3wmc2kFzReqVKa23oOPNyK6Ft5PDgZK8yOiFHkQag4P0xeF
 rltKFl9r+vj/yxiC1vMITfF79jcC20XHGFzBgqMhXRRyKwJr6SH3MPCc8wKAoc1EuWok
 jOo6ny8ljLUhWetql1KW+dVGhVOjMZv5eZIE0VefSrL7h6voKp+X6Plbp2DM7C49oIh1
 7v5C30ahGp+bM/ewlzZ0aqM7b0z7InQMtHBnWaH5clUU9/LEkl7129OHftY+nBWZ8V+i
 DTuJ8Aitxtn85syjEbCLkDG9Krl8JPEI/6GjtgCmA+AjICCy/x/8wkuQgdjdwaXc5Rmt
 08eg==
X-Gm-Message-State: AOJu0YyAb6ADCvcZf0O/q6nDzuVQBbEcO9CEzlCb2O72iD60B0y4gWxN
 1dFsahUH0htDDo6sAILop2tgw2wzac9r7XWtcrVQtPXzldl6OmxkokNpMpmaLiCwIHFM2WwKvUj
 FFXU3772vBBGrXg2A4INnRXPFXYb96yDlM6Xj5gDbtHkMyUkYmG12TrRui+4c8yvl8/iQ0+xzdN
 u9QBLqKSe1YpyVP5knSdEhbGJEOZ3D8rVQU1F0zgdZ
X-Gm-Gg: ASbGnctWwXS5Bfs0t5yeQUXuAbgMvQOAVCtlwTV0ADiep65qs4odohVqFdU0A0PB5rP
 3xQNvULnSVk2aENz/QTUhs/5u8T5ODx5zhZG1cQucbCFUYNm+jYVVz7ug0GO8KjdhMGwtKoqbwD
 IMx7HMpS/qWfFgMyWYOcASB5Yub0L7y/A3uX5sLimXLAQVCOwTs6AzUjIXl2quacqlK+yYGHrKW
 YlPGdWroCyT1swyFdVyBiStqRrAtpTWsS5CVrF/Q6eVnJoX9HzJAS4zqmicknLSMaUpriiebKI2
 zxtYAeDsZNO95g==
X-Received: by 2002:a17:907:6d0a:b0:ad8:914b:7d14 with SMTP id
 a640c23a62f3a-adb36b323f6mr103096866b.15.1748589325351; 
 Fri, 30 May 2025 00:15:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDc1bb9qgz7xZdrXcnd0YNtiAghfRFMl/2F7tLtDPWwlOzd945lpNdjzt6KTycFFWPS+9Dng==
X-Received: by 2002:a17:907:6d0a:b0:ad8:914b:7d14 with SMTP id
 a640c23a62f3a-adb36b323f6mr103094766b.15.1748589324953; 
 Fri, 30 May 2025 00:15:24 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82ddfcsm278206666b.55.2025.05.30.00.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 61/77] i386/tdx: Define supported KVM features for TDX
Date: Fri, 30 May 2025 09:12:31 +0200
Message-ID: <20250530071250.2050910-62-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

For TDX, only limited KVM PV features are supported.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-50-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 0f7f47c6da8..e35983ad9bd 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -32,6 +32,8 @@
 #include "kvm_i386.h"
 #include "tdx.h"
 
+#include "standard-headers/asm-x86/kvm_para.h"
+
 #define TDX_MIN_TSC_FREQUENCY_KHZ   (100 * 1000)
 #define TDX_MAX_TSC_FREQUENCY_KHZ   (10 * 1000 * 1000)
 
@@ -44,6 +46,14 @@
                                  TDX_TD_ATTRIBUTES_PKS | \
                                  TDX_TD_ATTRIBUTES_PERFMON)
 
+#define TDX_SUPPORTED_KVM_FEATURES  ((1U << KVM_FEATURE_NOP_IO_DELAY) | \
+                                     (1U << KVM_FEATURE_PV_UNHALT) | \
+                                     (1U << KVM_FEATURE_PV_TLB_FLUSH) | \
+                                     (1U << KVM_FEATURE_PV_SEND_IPI) | \
+                                     (1U << KVM_FEATURE_POLL_CONTROL) | \
+                                     (1U << KVM_FEATURE_PV_SCHED_YIELD) | \
+                                     (1U << KVM_FEATURE_MSI_EXT_DEST_ID))
+
 static TdxGuest *tdx_guest;
 
 static struct kvm_tdx_capabilities *tdx_caps;
@@ -631,6 +641,14 @@ static void tdx_add_supported_cpuid_by_xfam(void)
     e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK) >> 32;
 }
 
+static void tdx_add_supported_kvm_features(void)
+{
+    struct kvm_cpuid_entry2 *e;
+
+    e = find_in_supported_entry(0x40000001, 0);
+    e->eax = TDX_SUPPORTED_KVM_FEATURES;
+}
+
 static void tdx_setup_supported_cpuid(void)
 {
     if (tdx_supported_cpuid) {
@@ -647,6 +665,8 @@ static void tdx_setup_supported_cpuid(void)
     tdx_add_supported_cpuid_by_fixed1_bits();
     tdx_add_supported_cpuid_by_attrs();
     tdx_add_supported_cpuid_by_xfam();
+
+    tdx_add_supported_kvm_features();
 }
 
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
-- 
2.49.0


