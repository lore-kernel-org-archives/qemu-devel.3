Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C037C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 23:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUxrA-0000ok-KV; Tue, 30 Jan 2024 18:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rUxr8-0000oV-SB
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 18:49:30 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rUxr5-0003Zp-Jf
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 18:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706658567; x=1738194567;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/I6hTJML4W3gynT9p14FVS1hx+RCSexpHKMqysXJs3E=;
 b=c+ViXghHpkVOLx2/UDC9P8pzxHZQA67SJfGr4efvVF4Zv5HPe1iuuc/F
 OMbqNQuVv3XCsAmyAhnP3SsJumeYso4A3Z4eew7xKNY512Bua5YWUmTmv
 VB4ubIkSRJLAqJkE2eQi4A24kWpWNh9BkgTd2L6Z0JeLYuQfUNTJYhXH0
 mjfhfm2TkZLXku5kYZyNXKqhNX2W0OkxUziL2Gxj0Nd9MjgKqKzDpSDlB
 jSl8TM0uUgzil7Aw4l/GOzgNceGVh6nae4emjFUaZ4YSIhQoD4mSVEBfv
 640N7Luf0uR51BAMpble3a+wOR1RQ+z2P1yHCWxBjwxRDfOYY6fkJaKJy w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="393887938"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; d="scan'208";a="393887938"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2024 15:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="737919632"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; d="scan'208";a="737919632"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orsmga003.jf.intel.com with ESMTP; 30 Jan 2024 15:49:23 -0800
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] ui/gtk: introducing vc->visible
Date: Tue, 30 Jan 2024 15:48:37 -0800
Message-Id: <20240130234840.53122-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Dongwon Kim <dongwon.kim@intel.com>

Drawing guest display frames can't be completed while the VC is not in
visible state, which could result in timeout in both the host and the
guest especially when using blob scanout. Therefore it is needed to
update and track the visiblity status of the VC and unblock the pipeline
in case when VC becomes invisible (e.g. windows minimization, switching
among tabs) while processing a guest frame.

First patch (0001-ui-gtk-skip...) is introducing a flag 'visible' to
VirtualConsole struct then set it only if the VC and its window is
visible.
 
Second patch (0002-ui-gtk-set-...) sets the ui size to 0 when VC is
invisible when the tab is closed or deactivated. This notifies the guest
that the associated guest display is not active anymore.

Third patch (0003-ui-gtk-reset-visible...) adds a callback for GTK
window-state-event. The flag, 'visible' is updated based on the
minization status of the window.

Dongwon Kim (3):
  ui/gtk: skip drawing guest scanout when associated VC is invisible
  ui/gtk: set the ui size to 0 when invisible
  ui/gtk: reset visible flag when window is minimized

 include/ui/gtk.h |  1 +
 ui/gtk-egl.c     |  8 +++++++
 ui/gtk-gl-area.c |  8 +++++++
 ui/gtk.c         | 62 ++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 77 insertions(+), 2 deletions(-)

-- 
2.34.1


