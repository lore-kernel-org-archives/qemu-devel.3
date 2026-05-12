Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A597FCD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 08:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMiwJ-0000r1-1O; Tue, 12 May 2026 04:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiwH-0000q8-Ll
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:58:05 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiwE-0007RW-VK
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778576283; x=1810112283;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4oGdRsgYcFCJIGOUQkkzhU5cQ9VCQ2JvsyjXjqkYgmU=;
 b=U/FW5kliZ7zBC6/iB8qhEfxMenzvaefHtMbM0rP5MPkrqKZOr2K1W1nN
 klH8M/rKBYANNKtirBZOb6ESCiT8LjjlWauPgaGqbztf4EfHJtV6yfx7f
 +VxiRWemKZPw3hvNaEI971eoNy4Vjqw/mtiNwUwlvcK1uGGsvh5513DkA
 OGajVXMmv25WeYIFivx3G7uibcRuqdM60Inl67Tzet4P/kag8TEQNeJe5
 U90WC+1/5Zk8IF/VF8C4TUuKw7L9Tn1TQmlpo/pWSYM97V4GpZXrYpka8
 48kbNooIUzRIPfr0WsKso+dgps1MMvMhEvlrgLjUtuHUUitN+2p84ftjk Q==;
X-CSE-ConnectionGUID: JS0V1cidQTiYcoK8O7u+uQ==
X-CSE-MsgGUID: NCKiL4mwTTuv1jWfdoFn4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78510921"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="78510921"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 01:58:01 -0700
X-CSE-ConnectionGUID: bE34/gy4Ty+4h4ENBRkhqg==
X-CSE-MsgGUID: i7Uo5vGDSeSh3cQJONYo+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="242065519"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
 by orviesa004.jf.intel.com with ESMTP; 12 May 2026 01:58:00 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 xiaoyao.li@intel.com
Subject: [PATCH v2 1/5] i386/sev: Remove the example that references
 memory-encryption
Date: Tue, 12 May 2026 16:44:54 +0800
Message-ID: <20260512084458.622465-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512084458.622465-1-xiaoyao.li@intel.com>
References: <20260512084458.622465-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

"confidential-guest-support" is the recommended property to configure
sev for the machine, and amd-memory-encryption.rst has already switched
to use "confidential-guest-support" in the example.

Instead of changing "memory-encryption" to "confidential-guest-support"
in the comment of struct SevGuestState, just drop the example for
simplicity.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/sev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b44b5a1c2b94..f70f2ab4497f 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -160,10 +160,6 @@ struct SevCommonStateClass {
  *
  * The SevGuestState object is used for creating and managing a SEV
  * guest.
- *
- * # $QEMU \
- *         -object sev-guest,id=sev0 \
- *         -machine ...,memory-encryption=sev0
  */
 struct SevGuestState {
     SevCommonState parent_obj;
-- 
2.43.0


