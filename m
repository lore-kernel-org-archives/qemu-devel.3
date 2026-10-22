Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68B606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F0zrjvy4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJydj-0005Ez-7j; Thu, 22 Oct 2026 15:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xJydT-0005Cp-B4
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 15:39:38 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1xJydR-0002bw-DF
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 15:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792697973; x=1824233973;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qMOJTchdD2usApRB5rO60wMDWB3UUJmyugCKfYO3CSw=;
 b=F0zrjvy40Uvm089lOeiVMgYbz7M7iv94DSUnYwN4U8zKY4vjZJ4+/1Ae
 bJlBITbjnnx4yCi+cr2M7HqR84m9us5NFNFEbhD2DTf9goB6hYZa+Dw7V
 EXa9vf6kn0w9ZgZj40FK3Yd75gv4YYY2V7Toqx8JXkhyyg4yiocPTh8+E
 lHM4KE2IqdsPhjYEJxc3qVcINi1G2tsp3H7PXfElfjyOVb9qE5IvG9Zwh
 EPYuELs3W/6sglnctQTUKlQkUmTkQpd68D51aXnOTCtqlnCcyBJQJC4i7
 J34ZPvcZ045q6maQ1h5N8mfJIg4c5JvA28uI5/qxYIvpydOdMvDEPz8LT A==;
X-CSE-ConnectionGUID: gOmI1TKDS8WBAxPqKsQHzg==
X-CSE-MsgGUID: 4PPfOv3uR32ubEPwIuV7XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1563780"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1563780"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 12:39:27 -0700
X-CSE-ConnectionGUID: 34ZVgBHHQ5mehZo81tq6cA==
X-CSE-MsgGUID: JwOy7ubdQBy1PGfEVJqIMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3530576"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.80.113.172])
 by orviesa006.jf.intel.com with ESMTP; 22 Oct 2026 12:39:27 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH v3 0/3] ui/gtk: Hotkey and fullscreen handling fixes
Date: Thu, 22 Oct 2026 12:39:41 -0700
Message-Id: <20261022193944.19266-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

v3:
 - Add gd_is_full_screen() to query GdkWindowState directly and replace
   s->full_screen checks across attached and detached consoles
 - Keep zoom_fit_item deactivation in gd_menu_zoom_* while keeping
   gd_win_zoom_* focused on per-VC scaling
 - Restrict global free_scale handling to attached consoles so detached
   window geometry is not overridden
 - Use gd_is_full_screen for full_screen check in gd_window_map_event

Dongwon Kim (3):
  ui/gtk: Enable fullscreen and zoom hotkeys for detached windows
  ui/gtk: Register "Grab Input" shortcut to accel_group
  ui/gtk: Defer initial fullscreen activation until window is mapped

 include/ui/gtk.h |   2 -
 ui/gtk.c         | 223 ++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 170 insertions(+), 55 deletions(-)

-- 
2.43.0


