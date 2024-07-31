Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE7CC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 11:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ7Ls-00063K-Nr; Wed, 31 Jul 2024 07:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7Lp-0005qn-7z
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7Ln-0006n6-FN
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722424714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D3GWXk89dFoCnN0qZrsb3fQ2QxGZwcvcR/+7hFQmEt0=;
 b=R8MN1KnpJu51lprFVhmlyyR3c3qgPHiwwdUmhGhKZuqxerfTWKrmmuXrLT4Av8O/v8DjGS
 26jIXASiU0pjVXlanHMEkHdm0dJLBWw6/nd/kWJztxdPVALIYgcgb1a3h4IuUfGQoj/b/X
 +Dmqd2I/MGQhxyyF2Vj22DFKWGGFKtA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-7KxeTYmOMqqjzgSRFg7Ccg-1; Wed, 31 Jul 2024 07:18:28 -0400
X-MC-Unique: 7KxeTYmOMqqjzgSRFg7Ccg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5a7b5bd019cso5549982a12.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 04:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722424705; x=1723029505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3GWXk89dFoCnN0qZrsb3fQ2QxGZwcvcR/+7hFQmEt0=;
 b=BVZwBScqx5iEo9N1p/9T76fHVZ3rIXsni8kFcMAQBhbE1wBiFEotlODOm3oHaFudF/
 DZoFNfpnoVCVz+hQp9LH8AHxFpMnJkPNTu8Dywh7MH/yu2qsUrZ14jfJips3Oz1omo0f
 Sais+JcEkdHtGtsyq2Bs0+reMqGzmW4sUD+4KnnuUcIaxhdYrZ75HKARb/gMx5mHsD0T
 t0NHRiTf3mDHe2GaYL7VFbqjxrsxi8H4CuIDfSEbwcAKJiZkH2xU5LM75A6KOTgLY3Ww
 9MC2QY1tNocK3UwZz7H3x+gWgc1MMxclK54Q0AZ7ogHBIwVogI3XOJu51AjRX6jVlz7w
 S3PA==
X-Gm-Message-State: AOJu0YxixkrhalqkIPZK1dM87TE6LLz0DNQl8jjFvWajGrHq6xPbgOXr
 ODm9Hx8/2I6nysWSENM9//ZE0q9FZtTvoXCTgy05b9RsbjRBmdM92rOXk1AJrQi0nNkkIBzeyva
 XTjGC4U8w3Ndsxls3IaMGRareZ3VPbjyklAU7vGdw2rP1I2/Be43HYSFUq+hLKnLthaCdvlteH4
 d2JRKGkxC8iye19nWsZFofb0N8lNUEmp0g0gIX
X-Received: by 2002:a50:9504:0:b0:57d:4f47:d9ee with SMTP id
 4fb4d7f45d1cf-5b0221f0afcmr9571326a12.31.1722424705606; 
 Wed, 31 Jul 2024 04:18:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcF+AFAG7W2hYI8niZxggMhrLUEleNnv0O4IkDAX34xFe9ShitPIMxEIT5xLTQJuNUC3AWGg==
X-Received: by 2002:a50:9504:0:b0:57d:4f47:d9ee with SMTP id
 4fb4d7f45d1cf-5b0221f0afcmr9571305a12.31.1722424704991; 
 Wed, 31 Jul 2024 04:18:24 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac65481320sm8494703a12.81.2024.07.31.04.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 04:18:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/10] target/i386/cpu: Mask off SGX/SGX_LC feature words for
 non-PC machine
Date: Wed, 31 Jul 2024 13:18:02 +0200
Message-ID: <20240731111806.167225-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731111806.167225-1-pbonzini@redhat.com>
References: <20240731111806.167225-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Only PC machine supports SGX, so mask off SGX related feature words for
non-PC machine (microvm).

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20240730045544.2516284-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/sgx-epc.h |  1 +
 hw/i386/sgx-stub.c        |  5 +++++
 hw/i386/sgx.c             |  8 ++++++++
 target/i386/cpu.c         | 15 +++++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/include/hw/i386/sgx-epc.h b/include/hw/i386/sgx-epc.h
index 3e00efd870c..41d55da4799 100644
--- a/include/hw/i386/sgx-epc.h
+++ b/include/hw/i386/sgx-epc.h
@@ -58,6 +58,7 @@ typedef struct SGXEPCState {
     int nr_sections;
 } SGXEPCState;
 
+bool check_sgx_support(void);
 bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size);
 void sgx_epc_build_srat(GArray *table_data);
 
diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index 16b1dfd90bb..38ff75e9f37 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -32,6 +32,11 @@ void pc_machine_init_sgx_epc(PCMachineState *pcms)
     memset(&pcms->sgx_epc, 0, sizeof(SGXEPCState));
 }
 
+bool check_sgx_support(void)
+{
+    return false;
+}
+
 bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size)
 {
     return true;
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 849472a1286..4900dd414a1 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -266,6 +266,14 @@ void hmp_info_sgx(Monitor *mon, const QDict *qdict)
                    size);
 }
 
+bool check_sgx_support(void)
+{
+    if (!object_dynamic_cast(qdev_get_machine(), TYPE_PC_MACHINE)) {
+        return false;
+    }
+    return true;
+}
+
 bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size)
 {
     PCMachineState *pcms =
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 28b46ef536f..85ef7452c04 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6103,6 +6103,21 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
         }
         break;
 
+    case FEAT_7_0_EBX:
+#ifndef CONFIG_USER_ONLY
+        if (!check_sgx_support()) {
+            unavail = CPUID_7_0_EBX_SGX;
+        }
+#endif
+        break;
+    case FEAT_7_0_ECX:
+#ifndef CONFIG_USER_ONLY
+        if (!check_sgx_support()) {
+            unavail = CPUID_7_0_ECX_SGX_LC;
+        }
+#endif
+        break;
+
     default:
         break;
     }
-- 
2.45.2


