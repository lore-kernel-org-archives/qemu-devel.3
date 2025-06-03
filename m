Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DA6C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 05:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMJx6-0006th-3p; Tue, 03 Jun 2025 01:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMJx3-0006tA-CE
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 01:12:42 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMJwz-0003OJ-UB
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 01:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748927558; x=1780463558;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5yCR1xkAwt2Ej/VPGCPcKRypG3VTb85Nj16RO6mSwyw=;
 b=hzR7R/xFtubk5kt25AfvSKWwt1KdzIzxsfGmeRu4+py9/q7Aa3pKB/VG
 zcbadCQ5yZ+e2zN9ELTHV3qFI7T63dSp2Vb2FWhk47ma8znUmeweD6YPH
 5oapkLL3b9Bv+ZqnDndrlAjcNvYMUOaRAX8bgYlopAYso39Qgfm7wqLKp
 T6NmX4Spftg0M3dq28jAV1rQvsgoveSsRVfSMWyqNhe2vZ8Z6TLwVFqIo
 FSr0sDQNlI60+5LDiaw6tO1GR+0qqrJ5ikKvo5de4T7+cKWvuFeU80QLo
 I1XyEg0eVzGTQU2ksNCEmsz+vqKujXlAaJWMj6xzxJrZPnoU3PIXixo5R Q==;
X-CSE-ConnectionGUID: TX6wKDw6Qsu2e2P4S+/bbQ==
X-CSE-MsgGUID: oivO8biFT+exFMlPARYz+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="62007523"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="62007523"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 22:09:11 -0700
X-CSE-ConnectionGUID: so70jWytR1mKKPJV7qjFqA==
X-CSE-MsgGUID: tWPGf3viSZm0a2SI+XhDZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="175700641"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa002.jf.intel.com with ESMTP; 02 Jun 2025 22:09:10 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/3] i386/cpu: Rename enable_cpuid_0x1f to force_cpuid_0x1f
Date: Tue,  3 Jun 2025 01:03:03 -0400
Message-ID: <20250603050305.1704586-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603050305.1704586-1-xiaoyao.li@intel.com>
References: <20250603050305.1704586-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

The name of "enable_cpuid_0x1f" isn't right to its behavior because the
leaf 0x1f can be enabled even when "enable_cpuid_0x1f" is false.

Rename it to "force_cpuid_0x1f" to better reflect its behavior.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Suggested by Igor at https://lore.kernel.org/qemu-devel/20250513144515.37615651@imammedo.users.ipa.redhat.com/
---
 target/i386/cpu.h     | 4 ++--
 target/i386/kvm/tdx.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1146465c8c62..aaef6a2a6767 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2270,7 +2270,7 @@ struct ArchCPU {
     bool enable_cpuid_0xb;
 
     /* Force to enable cpuid 0x1f */
-    bool enable_cpuid_0x1f;
+    bool force_cpuid_0x1f;
 
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
@@ -2540,7 +2540,7 @@ void mark_forced_on_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
 
 static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
 {
-    return cpu->enable_cpuid_0x1f ||
+    return cpu->force_cpuid_0x1f ||
            x86_has_extended_topo(cpu->env.avail_cpu_topo);
 }
 
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 0a21ae555c5c..17e671f1710f 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -746,7 +746,7 @@ static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
     /* invtsc is fixed1 for TD guest */
     object_property_set_bool(OBJECT(cpu), "invtsc", true, &error_abort);
 
-    x86cpu->enable_cpuid_0x1f = true;
+    x86cpu->force_cpuid_0x1f = true;
 }
 
 static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
-- 
2.43.0


