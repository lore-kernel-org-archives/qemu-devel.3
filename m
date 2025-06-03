Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86077C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 05:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMJxB-0006ui-5P; Tue, 03 Jun 2025 01:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMJx5-0006tT-KQ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 01:12:43 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMJx3-0003ON-SD
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 01:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748927562; x=1780463562;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aEBokaXE3lrXtpc+g4ptK8Bwk8vWkUXL1JJQu78WCfw=;
 b=gJtpt4IN9neEqkap1cGG2ZoPM3ksqrzD3XESH0ASTp/tWxVlli3kK2Og
 2VckD3dpcfGs2rjVIN5f24EOHwX5s3kYNKzXpcFSpqnMmX6BBvT7ud9dt
 +o/mOcIHnzeW9BTr88ZfbQdxDsIXqkoQahGWNz5x1EaWn7543pdWyhxZY
 7AWIormkAxvwObvKSj07f+DKsfD/n7VKBQAUnwcpOx5kvQhFLP5FUCG8P
 LWb3OA83pfIQihkHFWnP5hEFRNe5vRVKnymoHSJBKV6NwCz9DeF9MYzuY
 tkv90GHUZ2ejIsif5EjOZJfFMIcYKGEno++BsZk5DqxvrmGSrwIszotDC A==;
X-CSE-ConnectionGUID: X4ByoYRzQV+G65EFRrUjJQ==
X-CSE-MsgGUID: 7xGo6CViSyGxHkB3WwlKnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="62007533"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="62007533"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 22:09:14 -0700
X-CSE-ConnectionGUID: bcXopVodTeuuUmvu/P/hdA==
X-CSE-MsgGUID: G1Zc+D52SH25le8L4UpbTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="175700651"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa002.jf.intel.com with ESMTP; 02 Jun 2025 22:09:13 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Subject: [PATCH 3/3] i386/tdx: Clarify the error message of
 mrconfigid/mrowner/mrownerconfig
Date: Tue,  3 Jun 2025 01:03:05 -0400
Message-ID: <20250603050305.1704586-4-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603050305.1704586-1-xiaoyao.li@intel.com>
References: <20250603050305.1704586-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The error message is misleading - we successfully decoded the data,
the decoded data was simply with the wrong length.

Change the error message to show it is an length check failure with both
the received and expected values.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Suggested by Daniel at https://lore.kernel.org/qemu-devel/aBzT3TrdldaN-uqx@redhat.com/
---
 target/i386/kvm/tdx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 17e671f1710f..4172bbd23340 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1026,7 +1026,9 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
             return -1;
         }
         if (data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
-            error_setg(errp, "TDX: failed to decode mrconfigid");
+            error_setg(errp, "TDX 'mrconfigid' sha384 digest was %ld bytes, "
+                             "expected %d bytes", data_len,
+                             QCRYPTO_HASH_DIGEST_LEN_SHA384);
             return -1;
         }
         memcpy(init_vm->mrconfigid, data, data_len);
@@ -1039,7 +1041,9 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
             return -1;
         }
         if (data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
-            error_setg(errp, "TDX: failed to decode mrowner");
+            error_setg(errp, "TDX 'mrowner' sha384 digest was %ld bytes, "
+                             "expected %d bytes", data_len,
+                             QCRYPTO_HASH_DIGEST_LEN_SHA384);
             return -1;
         }
         memcpy(init_vm->mrowner, data, data_len);
@@ -1052,7 +1056,9 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
             return -1;
         }
         if (data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
-            error_setg(errp, "TDX: failed to decode mrownerconfig");
+            error_setg(errp, "TDX 'mrownerconfig' sha384 digest was %ld bytes, "
+                             "expected %d bytes", data_len,
+                             QCRYPTO_HASH_DIGEST_LEN_SHA384);
             return -1;
         }
         memcpy(init_vm->mrownerconfig, data, data_len);
-- 
2.43.0


