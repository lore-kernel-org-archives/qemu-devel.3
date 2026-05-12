Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC31CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 08:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMiwK-0000s8-Fb; Tue, 12 May 2026 04:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiwI-0000qP-7q
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:58:06 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiwG-0007SD-OG
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778576285; x=1810112285;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e3vqDuzn5CebKXoD/rL/+POqcwdYe7Qne4/lWzZcVGk=;
 b=IRBXkImqCemO8Eebc3/h+KkyWvWveMpcAH29lOe7vZxKiFJfiuiGUKrt
 8nFeJkeQXHmuqCnAqCOOBvOrLA+4SGD3XjntHYu826X9hFGoh47475yZy
 nkWxjjMnAol+Kl6I5IT5/5H4b/bFKG/u80riQS+lOK9h6FXBx7H9GUmJa
 nxWLxyDUPb99V13fciSQq0Rj7BxxM4XfNh8b0OuaKJc8S7w9ikX4+hAyC
 jqX6zIDzjUc0uwmsCEHhIksx7UnVAsFY5q1Wfc6jN5w5aNgNx2xxdZNIj
 ibhoZWEb33CI3u77vXrGj/RFShsjpqKYyZ9SP6k4hwh7xqmehc41NJSqJ Q==;
X-CSE-ConnectionGUID: w+CxC1AnSTiZrdlw3GrD3g==
X-CSE-MsgGUID: PqrWfA3kS8ycS1LgBJ38wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78510925"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="78510925"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 01:58:03 -0700
X-CSE-ConnectionGUID: 98H/RvNqQpSpmZjDKe/now==
X-CSE-MsgGUID: mLd74FrjSdKEiBrhQlzKYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="242065530"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
 by orviesa004.jf.intel.com with ESMTP; 12 May 2026 01:58:01 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 xiaoyao.li@intel.com
Subject: [PATCH v2 2/5] qemu-options: Change memory-encryption to
 confidential-guest-support in the example
Date: Tue, 12 May 2026 16:44:55 +0800
Message-ID: <20260512084458.622465-3-xiaoyao.li@intel.com>
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

"confidential-guest-support" is the recommended property instead of
"memory-encryption". Switch to "confidential-guest-support" in the
example of sev-guest.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 96ae41f787ba..25ed486ff5d2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -6343,7 +6343,7 @@ SRST
              # |qemu_system_x86| \\
                  ...... \\
                  -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=1 \\
-                 -machine ...,memory-encryption=sev0 \\
+                 -machine ...,confidential-guest-support=sev0 \\
                  .....
 
     ``-object igvm-cfg,file=file``
-- 
2.43.0


