Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34618CAC594
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwzcH-000485-RH; Fri, 12 Sep 2025 04:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwzc6-00044G-NM
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:58:44 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwzbs-0008Ak-J4
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757667505; x=1789203505;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ae6VB5StLJkBhN0o0DIYZ0gzl+PFFo+PqPowdPSCtqo=;
 b=ZcHNhZXJJ5ixTYc0YO2ICpuL6qeJ5G6XCWHV5LRRSFmocRPEjlO/AOEs
 9sddeFPRxkRYnTHcW90RnBwERjVg+ORFa+ilQx/sGiIF/daCWJIalNzOa
 PBRXc5ifBa/CGBbunGM2g3JmK19ifU1cVotsJGuFd1pD6iMDk8kFJ+K37
 6gjU9AZruKr56M3XX6H4JGBhk2MaXRuFMUdFjzlhRQEbexm/DNKHcBpIp
 H+4kzIv3E2SpdZqgl9a8S9mD+aUSIO2kS8lMHObDMWyEJRMIyksgtiooY
 sql/s9HLqsmsqjl6qJGxcsn66JmpV3WL1PwBSwXPi/YIMlMmr6a9o71iE A==;
X-CSE-ConnectionGUID: DMg3VlYETDG+amluOfYYQw==
X-CSE-MsgGUID: YEY6j//fRJe6/ZmimqVWww==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59240005"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="59240005"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 01:58:21 -0700
X-CSE-ConnectionGUID: 9Tlk1MQJQQOlrnkk9uGuGA==
X-CSE-MsgGUID: No/BeYXVRRqO7ArEzmZX1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="174350737"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 12 Sep 2025 01:58:20 -0700
Date: Fri, 12 Sep 2025 17:20:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 32/33] rust: meson: remove unnecessary complication in
 device crates
Message-ID: <aMPlzP8CGEOh60d8@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-33-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908105005.2119297-33-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Sep 08, 2025 at 12:50:04PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:50:04 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 32/33] rust: meson: remove unnecessary complication in
>  device crates
> X-Mailer: git-send-email 2.51.0
> 
> It is not necessary anymore to explicitly list procedural macro crates
> when doing the final link using rustc.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/meson.build | 3 ---
>  rust/hw/timer/hpet/meson.build | 3 ---
>  2 files changed, 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


