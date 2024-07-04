Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DAFC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 08:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPHtY-0006zZ-PI; Thu, 04 Jul 2024 04:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPHtN-0006er-JI; Thu, 04 Jul 2024 04:32:37 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPHtH-00051p-6t; Thu, 04 Jul 2024 04:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720081951; x=1751617951;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5hujl58AvrZ/on+e6096dEufyQnj74Jlw/4R9zcO3Qk=;
 b=a/gliyOnUAGvMCEIFjzKrxFzIWUS/u/s/H3klJEKQxyltg2a+zFOVdcm
 Tb9aHWTE6sPy6c8pF3D268lZZk3f4BrWF2Q9fg3o3acthnVA5zmPEAor5
 vfDqmuPokn2io+XbG2KohVzoWCOPakJyVz8vEOTcn35oZHDyTl9B+lxHd
 k2sChZ/bIny1IUrcI38c/FYp2nIRIPS8Pvziv4li3cdrz2gwRih9GoAcU
 klD8mR8H5hZFIWCEQjdRywSGRneJCRSzcXNqa4+LBBAlO0OgZEP2s+UPP
 wCdlujqSXAIbQY+26CyWL1n+HX/2n8oNfDBUQjPRkGE47ASL16wW1WzFI Q==;
X-CSE-ConnectionGUID: bcw3DM53RouerE7MNXplWQ==
X-CSE-MsgGUID: Vw67vI1BSyKqryh3HPky5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17215708"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="17215708"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 01:32:28 -0700
X-CSE-ConnectionGUID: OfqZiTpSRCekWdrFoa/2vw==
X-CSE-MsgGUID: Ga0YK8oJSTuvKY/kY9JhKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="46597249"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 04 Jul 2024 01:32:27 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/4] hw/i386/x86: Fix superfluous trailing semicolon
Date: Thu,  4 Jul 2024 16:47:57 +0800
Message-Id: <20240704084759.1824420-3-zhao1.liu@intel.com>
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
 hw/i386/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index a4aa8e081098..01fc5e656272 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -242,7 +242,7 @@ static void x86_machine_get_pit(Object *obj, Visitor *v, const char *name,
 static void x86_machine_set_pit(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
-    X86MachineState *x86ms = X86_MACHINE(obj);;
+    X86MachineState *x86ms = X86_MACHINE(obj);
 
     visit_type_OnOffAuto(v, name, &x86ms->pit, errp);
 }
-- 
2.34.1


