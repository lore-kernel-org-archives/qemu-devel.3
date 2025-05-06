Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6D0C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDUZ-0002Kb-Lw; Tue, 06 May 2025 04:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCDUX-0002Hd-Js; Tue, 06 May 2025 04:17:29 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCDUV-0003CB-UL; Tue, 06 May 2025 04:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746519448; x=1778055448;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=10YWkdaa4tg+9NYJj8T8Tk7sWC4fZfGCSRMUZqJZ3B8=;
 b=AN0eJBASL5XbV6uReNf7jU5qn5i8cQnBNg3u1lfzBWJi4g+GrubQgYLg
 44U3L32Ytb/TRVgZu97UWrnp77bw94lfSeywrD5QKfH/x5rXIAG2tut4r
 3yW2G8EVzvf0bwQvez3fP9c/OauOoBZQt0zFxyAvBVvAbQtT12C4uipCr
 u0wnvQvQXMdg9XVDD6JFklh2Gb6jYjLvW66BL9lajhl6WrgIDq0e0vitd
 0WYcadI22ipYA4/5b9mLIkMYAoUwGEYOdhUlzyi6SswcPwOVxyNPdRQXW
 NihXg4ZqNzkjE37t08en/riKzU1qeHyajyVtgeWoQH9W9BoJwV4eO+tbS w==;
X-CSE-ConnectionGUID: qY9CitosTmGtXhyXmdoErw==
X-CSE-MsgGUID: 34FuWFaPSM6qnuKIQU1FsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="48079556"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="48079556"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 01:17:19 -0700
X-CSE-ConnectionGUID: 4pwteoLLQMORc/wu9tLw6Q==
X-CSE-MsgGUID: WJuBnpQpQCG0sglJ/xaXsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="140500056"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 06 May 2025 01:17:17 -0700
Date: Tue, 6 May 2025 16:38:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 11/11] docs: rust: update for newer minimum supported
 version
Message-ID: <aBnKeU9fIKxzBGs5@intel.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
 <20250505090438.24992-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505090438.24992-12-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

> -* Generic Associated Types (1.65.0)
> -
> -* ``CStr::from_bytes_with_nul()`` as a ``const`` function (1.72.0).
> -
> -* "Return position ``impl Trait`` in Traits" (1.75.0, blocker for including
> -  the pinned-init create).
> -

Glad to see it's possible to include pinned-init. 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


