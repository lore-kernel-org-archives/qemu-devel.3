Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A134BCD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 08:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMiwN-0000tG-9f; Tue, 12 May 2026 04:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiwL-0000sP-IP
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:58:09 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiwJ-0007RW-Vr
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778576288; x=1810112288;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ccTxULIS1GySBSoFJkKx4mBbmknXtDaG4L2R2ogo9cQ=;
 b=f5OOw7c6UmoijNPco/AIexJxrwvlz3JK1PDJzCEaDAbtANeALwW2NCMF
 2nUE7rYio0wvPFeirG/MtWniF+GFfLJOdLvonXTT04kCxI1xVBI902T0e
 UDmjAZs4Jf1hCy62UoowMvayJigYMjzhvD70k4uoq+El7kdACH26/Uq3i
 DfrftiwcwwiN8VOH3SMM1SGhH16KOXmUZx25JTSkqBoicuFaI1SCHLBol
 vaU/8ljFKUtLZpMTSQElrPflZm+DBD9NBLUrUYwFx3okvmwLqwgg3mRvB
 chT4voQgF0ZZpWmGfe30MiXf4rYlGwrizasA8VGLDZzPx/an1bKUO7Ast g==;
X-CSE-ConnectionGUID: B+YuZEj9S968/UOocvoptw==
X-CSE-MsgGUID: VMKtPY/2QZWhV2KLcnZBZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78510933"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="78510933"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 01:58:07 -0700
X-CSE-ConnectionGUID: icoK65rAS46hwQ+dE1NtcA==
X-CSE-MsgGUID: 6Vo1KRwlTOSHG8b/KS349Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="242065547"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
 by orviesa004.jf.intel.com with ESMTP; 12 May 2026 01:58:05 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 xiaoyao.li@intel.com
Subject: [PATCH v2 4/5] qemu-options: Add description of tdx-guest object
Date: Tue, 12 May 2026 16:44:57 +0800
Message-ID: <20260512084458.622465-5-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512084458.622465-1-xiaoyao.li@intel.com>
References: <20260512084458.622465-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
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

Add description of tdx-guest object so that QEMU doc page can have the
description.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v2:
- fix typo and add property after each property name; (Daniel)
- include how 'quote-generation-socket' is configured in the example; (Daniel)
---
 qemu-options.hx | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index ea4ae26b8d72..f13ce0a3aa22 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -6351,6 +6351,47 @@ SRST
                  -machine ...,confidential-guest-support=sev0 \\
                  .....
 
+    ``-object tdx-guest,id=id,[attributes=attrs,sept-ve-disable=on|off,mrconfigid=sha384_digest,mrowner=sha384_digest,mrownerconfig=sha384_digest,quote-generation-socket=socketaddr]``
+        Create an Intel Trusted Domain eXtensions (TDX) guest object, which is
+        the type of ``confidential-guest-support`` object. When pass the object
+        ID to machine's ``confidential-guest-support`` property, it can create
+        a TDX guest.
+
+        The ``attributes`` property is a 64-bit integer, which specifies the
+        TD attributes of the TD.
+
+        The ``sept-ve-disable`` property controls the bit 28 of TD attributes
+        specifically. When it's on, the EPT violation conversion to #VE on
+        guest access of PENDING pages is disabled. Some guest OS (e.g., Linux
+        TD guest) may require this to be set, otherwise they refuse to boot.
+        The default value is on.
+
+        The ``mrconfigid`` property is base64 encoded SHA384 digest, which
+        provides the ID for non-owner-defined configuration of the guest TD,
+        e.g., run-time or OS configuration. The default value is all zeros.
+
+        The ``mrowner`` property is base64 encoded SHA384 digest, which
+        provides the ID for guest TD's owner. The default value is all zeros.
+
+        The ``mrownerconfig`` property is base64 encoded SHA384 digest, which
+        provides the ID for owner-defined configuration of the guest TD, e.g.,
+        the configuration specific to the workload rather than the run-time of
+        OS. The default value is all zeros.
+
+        The ``quote-generation-socket`` property specifies the socket address
+        of the Quote Generation Service (QGS). QGS is a daemon running on the
+        host. QEMU forwards the <GetQuote> request from TD guest to QGS and
+        sents the reply (which contains generated QUOTE on success) from QGS
+        to guest TD.
+
+        .. parsed-literal::
+
+             # |qemu_system_x86| \\
+                 ...... \\
+                 -object '{"qom-type":"tdx-guest","id":"tdx","quote-generation-socket":{"type":"unix","path":"/var/run/qgs.socket"}}' \\
+                 -machine ...,confidential-guest-support=tdx \\
+                 ......
+
     ``-object igvm-cfg,file=file``
         Create an IGVM configuration object that defines the initial state
         of the guest using a file in that conforms to the Independent Guest
-- 
2.43.0


