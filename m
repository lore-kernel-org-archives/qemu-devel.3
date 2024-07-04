Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A638C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 08:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPHtZ-00074j-V5; Thu, 04 Jul 2024 04:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPHtO-0006fn-3e; Thu, 04 Jul 2024 04:32:38 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPHtF-00051c-Ff; Thu, 04 Jul 2024 04:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720081949; x=1751617949;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Nve8rjYfyslwkKIqRzp2KP9sBZfi1nRxUlX8uwegHko=;
 b=fhFxedor+yo+394rXFxRcaqmyJQgduWPNKSo7p09T6yYOZ6PhLmxmtaz
 U5FXkDxplFXbmaqW4wfeRaiRocqwksGcxbSD5DOk1TLilJGyklWTBUM7z
 uSbw0IsmyvQp9Y2SVY2ZHeClhMOKBr7/GgIjqxri24l6J+xMVvf6o9ymE
 PCf9JOpJ6bBd/vL5sgjmotcAEMiwdNIScYPuWp4GuBEgx0Z2gEiY4MZxl
 psc1Y5AUjaf/Mbu0+K4o4efvWOyHlgvvPNW23qtAKHDraVHDyutiBDEfA
 24LQvStE+J/q922/u15SDv9gdhDuydnNP6DnUYWbWIBe7bEsg2ujfm5r9 Q==;
X-CSE-ConnectionGUID: lkqxBjBtRKKQQ0oIAqwkfA==
X-CSE-MsgGUID: xBx4xcyyS8KCqxDWwNyUtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17215701"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="17215701"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 01:32:27 -0700
X-CSE-ConnectionGUID: +GZQsWQ/QSu+GPTatF73sw==
X-CSE-MsgGUID: ookhH1JuTsCNJo5ox9RLWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="46597235"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 04 Jul 2024 01:32:25 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/4] accel/kvm/kvm-all: Fix superfluous trailing semicolon
Date: Thu,  4 Jul 2024 16:47:56 +0800
Message-Id: <20240704084759.1824420-2-zhao1.liu@intel.com>
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
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 2b4ab896794b..64bf47a03300 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3878,7 +3878,7 @@ static StatsList *add_kvmstat_entry(struct kvm_stats_desc *pdesc,
     /* Alloc and populate data list */
     stats = g_new0(Stats, 1);
     stats->name = g_strdup(pdesc->name);
-    stats->value = g_new0(StatsValue, 1);;
+    stats->value = g_new0(StatsValue, 1);
 
     if ((pdesc->flags & KVM_STATS_UNIT_MASK) == KVM_STATS_UNIT_BOOLEAN) {
         stats->value->u.boolean = *stats_data;
-- 
2.34.1


