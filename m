Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E4A606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LPlJaFxq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnsl-0001uV-3j; Tue, 24 Nov 2026 05:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xVnsi-0001tS-GE; Tue, 24 Nov 2026 05:36:12 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xVnsg-0003F8-2r; Tue, 24 Nov 2026 05:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795516570; x=1827052570;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1nunOaCofKheZ39A20r7xO5iVAxgTA5Vsl/6aqQpx78=;
 b=LPlJaFxqKKeESOfqKCIanH51SeIC53Ss37s1s0KHO348yRSsxqInHGv5
 4e8DfGNzIsuMVC6A2WZdf8IPeckFX1DXCMh2ebY7sF0CdzDoqAqOrTLqF
 mcHGqfkXUqh9nSORiuhMarj3lJ/xLBr4ep1SMf8LDYcsLtNN6jEKe0D/4
 KTc6RaGVF0RkPZO+9DWY7GGbIUj9R1B30QaLPac6bwAIbx8s1nEW8ilX/
 kAibTG5RT0XRPb0pRNE7MFk21g7/cqdpPtimmHChbhdgNCILF8E5+mbCk
 /8r9VTa+x36D4QuRwOhcRX1SabY9PsJXHciYdKD8DsPalPpk/RI2FD5Nz w==;
X-CSE-ConnectionGUID: DzVUJ+crSeSd9eacpXxjZg==
X-CSE-MsgGUID: zw0H50OXT8O80VqO2h+JXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4401954"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4401954"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 02:36:06 -0800
X-CSE-ConnectionGUID: 1qSAT6IaTNuyy5stn/c8kg==
X-CSE-MsgGUID: vLoyiNA3QxK913Ry8FOyuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11519695"
Received: from zhaoliu1-desk.sh.intel.com ([10.112.226.173])
 by orviesa007.jf.intel.com with ESMTP; 24 Nov 2026 02:36:05 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] rust: Fix `make rustfmt` failure
Date: Tue, 24 Nov 2026 18:35:54 +0800
Message-Id: <20261124103554.465545-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

At present, `make rustfmt` triggers the following error:

[0/1] Running external command rustfmt (wrapped by meson to set env)
Failed to find targets
This utility formats all bin and lib files of the current crate using rustfmt.
...
FAILED: meson-internal__rustfmt

Since commit 6d28fc60891f moved Cargo.toml to the top-level source
directory, rust/ is neither the workspace root nor a package
directory. Now "cargo fmt" only formats the package in the current
directory, so running it from rust/ (i.e. @CURRENT_SOURCE_DIR@) finds no
targets.

So fix this by specifying the project source root (where Cargo.toml is),
just like CI did in commit 6d28fc60891f.

Fixes: 6d28fc60891f ("rust: switch to cargo subprojects")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/meson.build b/rust/meson.build
index c0c4e52c1b0c..08edbd50ad11 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -30,7 +30,7 @@ cargo = find_program('cargo', required: false)
 if cargo.found()
   run_target('rustfmt',
     command: [config_host['MESON'], 'devenv',
-              '--workdir', '@CURRENT_SOURCE_DIR@',
+              '--workdir', meson.project_source_root(),
               cargo, 'fmt'],
     depends: genrs)
 endif
-- 
2.34.1


