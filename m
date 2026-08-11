Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC279C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kGp-0004Bf-LX; Mon, 21 Sep 2026 16:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x8kGf-0004BL-Qd
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:05:37 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x8kGd-0004w8-ID
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 16:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790021136; x=1821557136;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=f8rikpVbyaFET8zVHaQIkSEDKU6hhCacLv26b6xfxag=;
 b=mln+kLGgrijuP5t1VhBRnImD0tmKqtZnw+61/bDdEDY8o6zWGH/SAa+u
 3iFIxj7WlAvJNLtjV0Lyv+3Yy5AAATeD6Tfsd2DB8a4B513rbNuLZ4cz4
 p33HTr4zhaPlxI+GwoGKqdJVLrhoChUjSP8z19x77duEVXudAFuMolcf+
 xPIZQvBhbK/0T7l63WKoi3JZ4VEox/7vrX9Rr8aM72ebqxwP3SQDLBQln
 THNKgpmpzgIfgy+zxQvYR1PZs3kSD90KSDF6rDoFQSdnhFOUeX/ez33Nk
 54gyqA94pa9XqyS1UtAm0kPCJ85Cgs7iU8LLKrACHl+NDcS4Rhm2zCj+U Q==;
X-CSE-ConnectionGUID: ewC62YjmQEeohVC/BrEReQ==
X-CSE-MsgGUID: mKXYd4tPTvaDHbOzOE2tKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="94399577"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="94399577"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 13:05:30 -0700
X-CSE-ConnectionGUID: cwlL0JXvTuuj979UQpQLbA==
X-CSE-MsgGUID: ha6ZqWxgQhCobqHCqVVbvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="272001013"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.80.113.172])
 by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2026 13:05:29 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] ui/gtk: Hotkey and fullscreen handling fixes 
Date: Tue, 11 Aug 2026 03:24:23 -0700
Message-Id: <20260811102426.35538-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Dongwon Kim <dongwon.kim@intel.com>

This series resolves several issues regarding keyboard shortcuts and
fullscreen behavior in the QEMU GTK UI.

 1. Detached (untabified) windows properly support fullscreen and zoom
    accelerators.
 2. The "Grab Input" accelerator remains functional in fullscreen mode when
    the menubar is hidden.
 3. Initial fullscreen setup is deferred until the window is properly
    realized to avoid display configuration race conditions.

v2:
 - Return TRUE in accelerator callbacks (gd_accel_grab_input, gd_win_*) to
   comply with the GtkAccelGroupActivate prototype.
 - Restore scale to preferred_scale and trigger gd_update_cursor() on
   fullscreen exit.
 - Deduplicate zoom handling by sharing gd_win_zoom_* across menu actions.
 - Guard zoom helpers against NULL / non-GFX consoles.
 - Remove leftover debug fprintf in gd_win_grab.

Dongwon Kim (3):
  ui/gtk: Enable fullscreen and zoom hotkeys for detached windows
  ui/gtk: Register "Grab Input" shortcut to accel_group
  ui/gtk: Defer initial fullscreen activation until window is mapped

 ui/gtk.c | 188 ++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 146 insertions(+), 42 deletions(-)

-- 
2.43.0


