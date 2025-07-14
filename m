Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF071C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHV2-0007Qb-7B; Mon, 14 Jul 2025 07:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1l-00028R-9T
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1i-0002HL-Hz
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3poyEKrP2QccOsBnw3+qFZ7NtXzgmSIMZDOuRbq9Mjs=;
 b=T2TXf5Hy2vxse2dZyOdlmw4gexylmaK2aRH/8JvnFAFcy0lvBcmXIvPLEFJxMWPkA0F919
 bvtPAP+O+jiXMeUMCvEBv8fUd7yiJiC5S0YY2AekoK6IuA/RKnTmGrwyKM+gt3j+Lm8e7F
 s+A2QtPyO18ZZ2gQUV88QFjfCjNbexo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-catAXm3aPIWWivKIydfJew-1; Mon, 14 Jul 2025 07:07:16 -0400
X-MC-Unique: catAXm3aPIWWivKIydfJew-1
X-Mimecast-MFC-AGG-ID: catAXm3aPIWWivKIydfJew_1752491235
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4eec544c6so1839235f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491234; x=1753096034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3poyEKrP2QccOsBnw3+qFZ7NtXzgmSIMZDOuRbq9Mjs=;
 b=LV9YT1bGxT7Syeery1N5TcU/hftci68cPW+2u6TIZEnqLlP/B92M4VTvjVjWWIdZZ7
 APAGu/lfouHIaMbO2PJb6FG36foTKdS6fZ+PBjDn6cOJCWVE7wBQHvbVT/tGu+j7et2S
 LuEV/cATwI4oOiipjNmYRp7hJLMZRwrNQqU7xqpJ1tmCOT+mdZ6xnSITr+Rwu9BG1jdT
 LdZQ5f/lBjY+D8tWzL/JLx9VAI+4rI1y3ALNmkkuCe4zeWH7xVmZcGlHm2YpslZOyYnX
 4l7heN+YKhhG+kXDr5U9mXshgGo/4aDU9ea/3icbIeE5x8C8iejnk3ux3JSmDcerG8qO
 BXrg==
X-Gm-Message-State: AOJu0Yy8Vhe+cYlEotx1lvFzCMMs0CobXfkRq1yrWpqOS6SO/+8ii/9R
 YR4E5YdHFqN3dknTmz24EyA3cy1YOi1JZxHhPgKbNBZlFeSPcvF/Hjrt8mxLwioHkGWYPYEB+4W
 hkQ+lKFVvmQg9GDI19IB74tDEPK9Fq2i5v/vhBA3hlzlAQfIN8duC/tnuakBIa2BCDLOoKDb2in
 EJlXrv/8IWL8V3aovEHfkBojVzQ6dTwXRoXkST555L
X-Gm-Gg: ASbGncuWe5GMQmNZppLZK2U1iMizfCmS6ITMYZ6nXbgUdwxzT11QZ3hBiouUFvPTjhk
 7cmRBulcTltHrkhMX/x7b4hPSCZb47o84UrF+spe435ZuYCYlEnly104Ts24JCnGZ4nrb9ElWSJ
 RHnkZOvcQwoX9n/Hcv7MdzfMXu6eO26t49sRBvQiVgCBFyxRxuiGu9nYBKlz8RhMzJKOaIUkh/v
 GskAcj8TUjB9Dvm4p3sa0obiz4Yx5A931kuyQr/ycuR8qW3VpzalthXd2Bf8vKbB0BhHSs3v0Qz
 wmRnp7yEgMPQI+bOQljaBvYqPaEmA9UFw5MRxyYAg2o=
X-Received: by 2002:a5d:4104:0:b0:3b3:9cc4:6830 with SMTP id
 ffacd0b85a97d-3b5f18d32ecmr9487307f8f.48.1752491234555; 
 Mon, 14 Jul 2025 04:07:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqyOkV3uJ/cxXCSI6reKUeZK7KTQXaYb1TKAO9xCddGqX4pP6A5xN0IgUN4YttGEcr1jbqYg==
X-Received: by 2002:a5d:4104:0:b0:3b3:9cc4:6830 with SMTP id
 ffacd0b85a97d-3b5f18d32ecmr9487274f8f.48.1752491234080; 
 Mon, 14 Jul 2025 04:07:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d872sm12279345f8f.60.2025.07.14.04.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:07:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Tao Su <tao1.su@linux.intel.com>
Subject: [PULL 73/77] i386/cpu: Reorder CPUID leaves in cpu_x86_cpuid()
Date: Mon, 14 Jul 2025 13:04:02 +0200
Message-ID: <20250714110406.117772-74-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Sort the CPUID leaves strictly by index to facilitate checking and
changing.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20250627035129.2755537-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 60 +++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1a2cae6ea1f..3b7c22e5d38 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8052,21 +8052,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         assert(!(*eax & ~0x1f));
         *ebx &= 0xffff; /* The count doesn't need to be reliable. */
         break;
-    case 0x1C:
-        if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
-            x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
-            *edx = 0;
-        }
-        break;
-    case 0x1F:
-        /* V2 Extended Topology Enumeration Leaf */
-        if (!x86_has_cpuid_0x1f(cpu)) {
-            *eax = *ebx = *ecx = *edx = 0;
-            break;
-        }
-
-        encode_topo_cpuid1f(env, count, topo_info, eax, ebx, ecx, edx);
-        break;
     case 0xD: {
         /* Processor Extended State */
         *eax = 0;
@@ -8207,6 +8192,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     }
+    case 0x1C:
+        if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
+            x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
+            *edx = 0;
+        }
+        break;
     case 0x1D: {
         /* AMX TILE, for now hardcoded for Sapphire Rapids*/
         *eax = 0;
@@ -8244,6 +8235,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     }
+    case 0x1F:
+        /* V2 Extended Topology Enumeration Leaf */
+        if (!x86_has_cpuid_0x1f(cpu)) {
+            *eax = *ebx = *ecx = *edx = 0;
+            break;
+        }
+
+        encode_topo_cpuid1f(env, count, topo_info, eax, ebx, ecx, edx);
+        break;
     case 0x24: {
         *eax = 0;
         *ebx = 0;
@@ -8472,6 +8472,21 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
+    case 0x8000001F:
+        *eax = *ebx = *ecx = *edx = 0;
+        if (sev_enabled()) {
+            *eax = 0x2;
+            *eax |= sev_es_enabled() ? 0x8 : 0;
+            *eax |= sev_snp_enabled() ? 0x10 : 0;
+            *ebx = sev_get_cbit_position() & 0x3f; /* EBX[5:0] */
+            *ebx |= (sev_get_reduced_phys_bits() & 0x3f) << 6; /* EBX[11:6] */
+        }
+        break;
+    case 0x80000021:
+        *eax = *ebx = *ecx = *edx = 0;
+        *eax = env->features[FEAT_8000_0021_EAX];
+        *ebx = env->features[FEAT_8000_0021_EBX];
+        break;
     case 0x80000022:
         *eax = *ebx = *ecx = *edx = 0;
         /* AMD Extended Performance Monitoring and Debug */
@@ -8504,21 +8519,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ecx = 0;
         *edx = 0;
         break;
-    case 0x8000001F:
-        *eax = *ebx = *ecx = *edx = 0;
-        if (sev_enabled()) {
-            *eax = 0x2;
-            *eax |= sev_es_enabled() ? 0x8 : 0;
-            *eax |= sev_snp_enabled() ? 0x10 : 0;
-            *ebx = sev_get_cbit_position() & 0x3f; /* EBX[5:0] */
-            *ebx |= (sev_get_reduced_phys_bits() & 0x3f) << 6; /* EBX[11:6] */
-        }
-        break;
-    case 0x80000021:
-        *eax = *ebx = *ecx = *edx = 0;
-        *eax = env->features[FEAT_8000_0021_EAX];
-        *ebx = env->features[FEAT_8000_0021_EBX];
-        break;
     default:
         /* reserved values: zero */
         *eax = 0;
-- 
2.50.0


