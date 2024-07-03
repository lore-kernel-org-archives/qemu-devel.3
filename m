Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCB4C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 10:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOxSr-0008QU-1I; Wed, 03 Jul 2024 06:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOxSp-0008QB-1Q
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOxSn-0002hm-6j
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720003426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WERYu8GkU5bDVarw5oZeuSjN15G3SYu/gk9IyB/vR6M=;
 b=NRzxIq3b1Su7RJZN+Kr38Z8t3w9JUXQ6zGg8gwKPfa+qIpl+B3kv+RW1E1ybRW0T7nPXqE
 TPcE3c34a6HpZCj4Uotj8TfJx2ZXgrkXo9bbxTMC10u5cNk2ZH6y9kyv72KqOrsJODd67A
 ub2ze9lBypIQBturlmSHGPAc7ocoOsQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-sZjKalw7PBywh7CZjg2pAQ-1; Wed, 03 Jul 2024 06:43:45 -0400
X-MC-Unique: sZjKalw7PBywh7CZjg2pAQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ee87069f27so3851311fa.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 03:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720003423; x=1720608223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WERYu8GkU5bDVarw5oZeuSjN15G3SYu/gk9IyB/vR6M=;
 b=wORZwghIGk82ccUcFLWp2+WBUWQTGjoLdX2n0jiNzALspUarIWl/n+tw9zXa9pRkb6
 Q/yCKntot8EWHFJtDFYRZaLRZw0TNLNYX0AHM5pSLNtCWkwtBbg9UO8Zti686FOV4VlB
 GbltLgVGFe454Jx9l6z/jKURcNEolRshsc0D+MnBlV7L8LgVHb7/sMvZ7Axno/4YeQvo
 +RkHcZd79jcW3d8LSuGszto5vhPbv0EHd82GPiMDeRaT44ctujqic/0QV67riJmYanBF
 0dgUQf18ntlLjtxaAyvvkA86eoPWOFwaW1DX9DnlJGYw1Zj7+UCb0P249tsTfLFIhKY9
 wQMw==
X-Gm-Message-State: AOJu0YyhLpVC7Wg0KY4gxdDaRuArPl95FU9AC5sklOJxohPaAtwhz4P/
 bUOp/yVY1oGKr9vMpt1dmJKJCeAcZbMFvUM8iB/nZQ5buapnvEfKbLqhn2mpaTb9AMh5q4oE5o9
 SOFXy9kytviMCog7Qt53OF3Zqpyb0R/giwA3W7AkGyRCGfvwdEy3ZHAhs1pgcQ5Aqwks+j6ZQ+v
 OkgRy2Bzw7hubiZ0ZLFnzBDacXkY8CAmxauMV5
X-Received: by 2002:a2e:b889:0:b0:2ec:1042:fb04 with SMTP id
 38308e7fff4ca-2ee5e6cd745mr74098541fa.35.1720003423038; 
 Wed, 03 Jul 2024 03:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6stTBnGZA9mzHiowXuVjLePHuqmPO1RZFOnT6GL17dGsY9nSuVFoQbIVooWGRPVGuYv+bTg==
X-Received: by 2002:a2e:b889:0:b0:2ec:1042:fb04 with SMTP id
 38308e7fff4ca-2ee5e6cd745mr74098401fa.35.1720003422571; 
 Wed, 03 Jul 2024 03:43:42 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ee51680450sm18764071fa.76.2024.07.03.03.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 03:43:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mdroth@amd.com
Subject: [PATCH] target/i386: do not include undefined bits in the AMD topoext
 leaf
Date: Wed,  3 Jul 2024 12:43:40 +0200
Message-ID: <20240703104340.1642489-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Commit d7c72735f61 ("target/i386: Add new EPYC CPU versions with updated
cache_info", 2023-05-08) ensured that AMD-defined CPU models did not
have the 'complex_indexing' bit set, but left it set in "-cpu host"
which uses the default ("legacy") cache information.

Reimplement that commit using a CPU feature, so that it can be applied
to all guests using a new machine type, independent of the CPU model.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 3 +++
 hw/i386/pc.c      | 1 +
 target/i386/cpu.c | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 31c9b43849e..c43ac01c794 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2108,6 +2108,9 @@ struct ArchCPU {
     /* Only advertise CPUID leaves defined by the vendor */
     bool vendor_cpuid_only;
 
+    /* Only advertise TOPOEXT features that AMD defines */
+    bool amd_topoext_features_only;
+
     /* Enable auto level-increase for Intel Processor Trace leave */
     bool intel_pt_auto_level;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 77415064c62..5dff91422ff 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -80,6 +80,7 @@
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
 GlobalProperty pc_compat_9_0[] = {
+    { TYPE_X86_CPU, "x-amd-topoext-features-only", "false" },
     { TYPE_X86_CPU, "x-l1-cache-per-thread", "false" },
     { TYPE_X86_CPU, "guest-phys-bits", "0" },
     { "sev-guest", "legacy-vm-type", "true" },
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a042e6b4edb..c9d8f6339a4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6991,6 +6991,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
+        if (cpu->amd_topoext_features_only) {
+            *edx &= CACHE_NO_INVD_SHARING | CACHE_INCLUSIVE;
+        }
         break;
     case 0x8000001E:
         if (cpu->core_id <= 255) {
@@ -8302,6 +8305,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
+    DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
     DEFINE_PROP_BOOL("kvm-pv-enforce-cpuid", X86CPU, kvm_pv_enforce_cpuid,
-- 
2.45.2


