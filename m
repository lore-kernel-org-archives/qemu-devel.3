Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F15C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 08:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPHtc-0007L6-R6; Thu, 04 Jul 2024 04:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPHtQ-0006oj-GI; Thu, 04 Jul 2024 04:32:43 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPHtM-00051M-DS; Thu, 04 Jul 2024 04:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720081956; x=1751617956;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XmoMpvmKAHPv2PSXeHNReCSPQ/rSyVyEIcqFuYeye7Y=;
 b=abdLOnLYMzUbFuFDpsCriOCFVcGrAiwfjraXu6DY1Ys91yLTKLE++UUo
 HczdQvNI51ikTlzlxpCqaCpuTj/F0RTXdNfAAhNomm5HF4yIxMvM1RcW1
 ik4uyGL4RuxFg0d3yYhXyzGM5hc5stejgHxoNrtouHcXpj+tg9CMaBpDJ
 9+t8qw4O5oQTbGcvPvd7dkjJYS1ajYVOKoZtt1tBjvXRxxPp4nw8caTFq
 IX+dGJoHBGFoH+9Uq7IYuO7+HIKrF9ychDh5M0Q9JQZCYqG2zIQcP+bSV
 evbOORuxTCqjncE8nlzPkEjtSMNza7QmIETcMHjHFC8vJj3ybQB5NNrJ6 g==;
X-CSE-ConnectionGUID: HHR55cafRiCnzdMOXQRKmg==
X-CSE-MsgGUID: l7gPOqTfTBW/Ac5hMDfyzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17215713"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="17215713"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 01:32:30 -0700
X-CSE-ConnectionGUID: WAglHtl0TcCefB+5nwVypA==
X-CSE-MsgGUID: P3Ew53cGTHWqI+MC9u8mwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="46597254"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 04 Jul 2024 01:32:29 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/4] util/oslib-posix: Fix superfluous trailing semicolon
Date: Thu,  4 Jul 2024 16:47:58 +0800
Message-Id: <20240704084759.1824420-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704084759.1824420-1-zhao1.liu@intel.com>
References: <20240704084759.1824420-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 util/oslib-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index e76441695bdc..b090fe0eed0d 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -263,7 +263,7 @@ int qemu_socketpair(int domain, int type, int protocol, int sv[2])
         return ret;
     }
 #endif
-    ret = socketpair(domain, type, protocol, sv);;
+    ret = socketpair(domain, type, protocol, sv);
     if (ret == 0) {
         qemu_set_cloexec(sv[0]);
         qemu_set_cloexec(sv[1]);
-- 
2.34.1


