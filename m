Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3A2C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 08:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPHte-0007cq-Ca; Thu, 04 Jul 2024 04:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPHtY-0006xW-7Y; Thu, 04 Jul 2024 04:32:48 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPHtP-00051p-Dh; Thu, 04 Jul 2024 04:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720081959; x=1751617959;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lJ3uEcOixGTUXfyfihGmHOnuYHgDolQXivQigTutBRU=;
 b=Z1uDeKksg2n69p7ku+fmoqdh6NyKu8vSJ/lkTaKvnR4ck3wJ72Gn6pBS
 wtpoeyYgwBnVY3kZlMYmUr4im5+qiJagjc18lRmw0+nDCSgGaZJTVZmQd
 nWqDh5GoMz6EOSGvLznAhlYtEpohT0cbwkoVRFZEyEYNAQ1QGG1t4ThYs
 /+L9Kq0PDF26fhNowkQYDdCSCFs0APOBNUsMZIefEUZ81MsDSQDF/Pu+3
 IbX3V/eeKqxLz4GH15PjULL1VBJtE81Dbk7jXbYi1X7DhKByh2C+fq1VG
 XlMt6aehK+IO4tgjov2OxqXDVJXQTU9V3eO3++mRf7IRH0cUnqVy0slpC g==;
X-CSE-ConnectionGUID: 4tES1O8hTkCuP2NlxehWvA==
X-CSE-MsgGUID: VmaNae26TOi8PvWp5u8Kjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17215721"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="17215721"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 01:32:32 -0700
X-CSE-ConnectionGUID: tIo86+0xTliphpbj0bxmRg==
X-CSE-MsgGUID: R16Q5F3NTPqzvjrftjj2UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="46597259"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 04 Jul 2024 01:32:30 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Brian Cain <bcain@quicinc.com>
Subject: [PATCH 4/4] target/hexagon/imported/mmvec: Fix superfluous trailing
 semicolon
Date: Thu,  4 Jul 2024 16:47:59 +0800
Message-Id: <20240704084759.1824420-5-zhao1.liu@intel.com>
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

Fix the superfluous trailing semicolon in target/hexagon/imported/mmvec/
ext.idef.

Cc: Brian Cain <bcain@quicinc.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/hexagon/imported/mmvec/ext.idef | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index 98daabfb07c4..03d31f6181d7 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -2855,7 +2855,7 @@ EXTINSN(V6_vscattermhw_add,  "vscatter(Rt32,Mu2,Vvv32.w).h+=Vw32", ATTRIBS(A_EXT
     fVALIGN(RtV, element_size);
     fVFOREACH(32, i) {
         for(j = 0; j < 2; j++) {
-             EA =  RtV + fVALIGN(VvvV.v[j].uw[i],ALIGNMENT);;
+             EA =  RtV + fVALIGN(VvvV.v[j].uw[i],ALIGNMENT);
              fVLOG_VTCM_HALFWORD_INCREMENT_DV(EA,VvvV.v[j].uw[i],VwV,(2*i+j),i,j,ALIGNMENT,MuV);
         }
     }
-- 
2.34.1


