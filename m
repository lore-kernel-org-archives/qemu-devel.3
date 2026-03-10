Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A09FD2D92
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxM4-00074e-GJ; Tue, 10 Mar 2026 09:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxLx-00070O-JY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:42:30 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxLw-0003DW-2Y
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773150148; x=1804686148;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=23oFSQFeckjBSHClRj8x1vVwScp8+dwkHgm070uUpNo=;
 b=G7J1ffeP8LMAGbNChuzM4S1lpLYnD2RkPBhjlMDC32HtdGHRTLDwYZFJ
 c8ahDWmS9KsOBk4MIKkuTQfPgPAVB7feilZQuUsR7Y1K3bpENA+LtK4QD
 zP6XHMwb5cYRu1oF6G2EPT7buKrV2krHCXSzXjO9AogQiBGdAXa5opteK
 lysHgtsBf9kgvFgKLUHhkMzldw/aZt7Cky082l2R7TLnXvTMSh1q3BDUS
 Og01Ze1uBaRvoazfQNSeA3QXAEm9JEKIs4TgMEWrVnizK5uIaGiE/XFV4
 ePb2D8cmAJMSCcP7a6WYX4z4LlYu9Y6vAn7KDHxVqgvaxwjiqasnbWDyG w==;
X-CSE-ConnectionGUID: wTmKERFRR8CxeaG+M7cJDA==
X-CSE-MsgGUID: jgJQQhnzQASvwdpZMkyaQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78048241"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="78048241"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 06:42:24 -0700
X-CSE-ConnectionGUID: o/W/iWanRrylRWIyUJhLwg==
X-CSE-MsgGUID: Ee42vWskQ2Os8tM6v7sQxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="217647985"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 10 Mar 2026 06:42:22 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 4/5] i386/cpu: Adjust the note for CPU models with its-no
Date: Tue, 10 Mar 2026 22:08:18 +0800
Message-Id: <20260310140819.1563084-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310140819.1563084-1-zhao1.liu@intel.com>
References: <20260310140819.1563084-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For new versioned CPU models with its-no enabled, since CET was already
enabled in previous versions, remove the related description from the
notes of its-no related CPU models.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c6323fee94bb..a3c8f523e85b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5263,7 +5263,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 6,
-                .note = "with cet-ss, cet-ibt, its-no",
+                .note = "with its-no",
                 .props = (PropValue[]) {
                     { "its-no", "on" },
                     { /* end of list */ },
@@ -5444,7 +5444,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 5,
-                .note = "with cet-ss, cet-ibt, its-no",
+                .note = "with its-no",
                 .props = (PropValue[]) {
                     { "its-no", "on" },
                     { /* end of list */ },
@@ -5809,7 +5809,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 5,
-                .note = "with ITS_NO",
+                .note = "with its-no",
                 .props = (PropValue[]) {
                     { "its-no", "on" },
                     { /* end of list */ },
@@ -5963,7 +5963,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 3,
-                .note = "with cet-ss, cet-ibt, ITS_NO",
+                .note = "with its-no",
                 .props = (PropValue[]) {
                     { "its-no", "on" },
                     { /* end of list */ },
-- 
2.34.1


