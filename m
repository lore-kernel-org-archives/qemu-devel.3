Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212C5606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 04:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g/byAyds
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLC08-0002K4-DD; Mon, 26 Oct 2026 00:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xLBy8-0002Cw-KC
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 00:05:56 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xLBy5-0002z7-3f
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 00:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792987553; x=1824523553;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=9f4/zvJ+4/w+vltN76iBsmmcOzFENzng7BRapjyGg6I=;
 b=g/byAydsQqUjzuo14KgV+cJi+Os2OM1wUKcE9IK4Fz9udRD+kavRFuYa
 pQYtwja9o2YXbDDqZa5+iOW9o+0g8oLZ6nYfev+3//Go1wfWxVdAXpTEH
 8GoIoQXunaKx45mitPtBrxPaXz+KqprvKFhwHrm0EYVUcrrvYff+Pqyw4
 g0j538KIgT7Uurh5SYE1lcvw7R0Pdx2Kx1+87/lGsfPhjYHXP/ZNdB8pI
 XFWf/slplr6OWzl93Nyy2IecUCmAYlgQduRkoV3ZYJBLytX62NGSVmo8e
 ZnvV1Ng8dZhbJMnMJu38s/1vdTMRM8QHwglxuPiBMnPHeWF6eK8+B+q2g Q==;
X-CSE-ConnectionGUID: fTTFmla/Ql2f6I0AWQB6xg==
X-CSE-MsgGUID: Q1LqNcniRVy/xve2cXDqcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1524783"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1524783"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 21:05:12 -0700
X-CSE-ConnectionGUID: 4ffihOBsSsuUnZIeJGMblA==
X-CSE-MsgGUID: 4e+VoqlMTk6zUfl7qFcXWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4213609"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com (HELO [127.0.1.1])
 ([10.80.113.172])
 by orviesa009.jf.intel.com with ESMTP; 25 Oct 2026 21:05:12 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v4 0/3] ui/gtk: Hotkey and fullscreen handling fixes
Date: Sun, 25 Oct 2026 21:05:17 -0700
Message-Id: <20261025-gtk-ui-v4-v4-0-6cf2b6ffeb55@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH3R3moC/yXM0QpAMBSA4VfRuXZqZoRXkQvmbA6FNqTk3Q2XX
 /39F3hyTB6q6AJHB3te5gAVR6CHdraE3AeDFDJPhMzQbhPujIdCYXQqi7LMTVJA6FdHhs/vVTe
 //d6NpLd3APf9AN3FXNltAAAA
X-Change-ID: 20261025-gtk-ui-v4-0fc328996f18
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Dongwon Kim <dongwon.kim@intel.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=198.175.65.9; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

v3:
 - Add gd_is_full_screen() to query GdkWindowState directly and replace
   s->full_screen checks across attached and detached consoles
 - Keep zoom_fit_item deactivation in gd_menu_zoom_* while keeping
   gd_win_zoom_* focused on per-VC scaling
 - Restrict global free_scale handling to attached consoles so detached
   window geometry is not overridden
 - Use gd_is_full_screen for full_screen check in gd_window_map_event

v4: Resend full series with consistent patch versioning tags

Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
Dongwon Kim (3):
      ui/gtk: Enable fullscreen and zoom hotkeys for detached windows
      ui/gtk: Register "Grab Input" shortcut to accel_group
      ui/gtk: Defer initial fullscreen activation until window is mapped

 include/ui/gtk.h |   2 -
 ui/gtk.c         | 223 ++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 170 insertions(+), 55 deletions(-)
---
base-commit: d73149283205645625bfa9fe029cfb68e4c4a9ae
change-id: 20261025-gtk-ui-v4-0fc328996f18

Best regards,
--  
Dongwon Kim <dongwon.kim@intel.com>


