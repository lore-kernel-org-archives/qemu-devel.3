Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F085C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 19:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD7Sm-0004JN-51; Fri, 31 May 2024 14:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sD7Sk-0004JE-Hp
 for qemu-devel@nongnu.org; Fri, 31 May 2024 14:58:50 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sD7Si-0002bf-25
 for qemu-devel@nongnu.org; Fri, 31 May 2024 14:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717181928; x=1748717928;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Lij9uVQurRRs5/BvJvEOF0wP4CPbn2T6iMTPe7I3Lqo=;
 b=e2PveGQSuk3gdSjVOlKCaHJL0Zu/fcKGpsuz+Gd0Fa4nP048CZ6bKUmJ
 8ujx9gEl9OWETvn8t9Fs6dmX1lmB8RTKEfLrQHTrdmXNiSykYU4n5ccvM
 /cB1FRR2qPDYVs74DVjpbOgGdiLfOlg8oGZHIciaFnXhlJ2QwR+/j6MPT
 T70ojIxvYraKpAUuk2yywnX+IZZPs9JyN7BD6WZqaKr+2WyXUfhML5OOB
 +i5fFC4nw+Q3QIzUNezNqsNBU6KHmZKRo3x7CS7IfZY2ne+0csolvn+m9
 +PScEuxx49cPpwA4hqIl42/bmRELJ4ucQ0ZfIXGuobrg1b/aZM1CbjToF w==;
X-CSE-ConnectionGUID: gxR8xkTbSx2mSCJb744jXg==
X-CSE-MsgGUID: 07l0OAiWT+GAj3fHQDno1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13965361"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; d="scan'208";a="13965361"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2024 11:58:44 -0700
X-CSE-ConnectionGUID: Arost7qWTnWhzSvRpUIGHg==
X-CSE-MsgGUID: n4GP3USVScef8lGkGSixMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; d="scan'208";a="67442163"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa001.fm.intel.com with ESMTP; 31 May 2024 11:58:44 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 0/2] ui/gtk: Introduce new param - Connectors
Date: Fri, 31 May 2024 11:58:02 -0700
Message-Id: <20240531185804.119557-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patch series is a replacement of
https://mail.gnu.org/archive/html/qemu-devel/2023-06/msg03989.html

There is a need, expressed by several users, to assign ownership of one
or more physical monitors/connectors to individual guests. This creates
a clear notion of which guest's contents are being displayed on any given
monitor. Given that there is always a display server/compositor running
on the host, monitor ownership can never truly be transferred to guests.
However, the closest approximation is to request the host compositor to
fullscreen the guest's windows on individual monitors. This allows for
various configurations, such as displaying four different guests' windows
on four different monitors, a single guest's windows (or virtual consoles)
on four monitors, or any similar combination.

This patch series attempts to accomplish this by introducing a new
parameter named "connector" to assign monitors to the GFX VCs associated
with a guest. If the assigned monitor is not connected, the guest's window
will not be displayed, similar to how a host compositor behaves when
connectors are not connected. Once the monitor is hot-plugged, the guest's
window(s) will be positioned on the assigned monitor.

Usage example:

-display gtk,gl=on,connectors=DP-1:eDP-1:HDMI-2...

In this example, the first graphics virtual console will be placed on the
DP-1 display, the second on eDP-1, and the third on HDMI-2.

v2: Connectors is now in a string format that includes all connector names
    separated with a colon (previously it was a linked list)

    Code refactoring

Vivek Kasireddy (2):
  ui/gtk: Factor out tab window creation into a separate
  ui/gtk: Add a new parameter to assign connectors/monitors

 qapi/ui.json     |  25 +++-
 include/ui/gtk.h |   1 +
 ui/gtk.c         | 301 +++++++++++++++++++++++++++++++++++++++++++----
 qemu-options.hx  |   4 +
 4 files changed, 308 insertions(+), 23 deletions(-)

-- 
2.34.1


