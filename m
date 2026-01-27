Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF88D25959
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 07:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkdmx-0008Cu-GX; Tue, 27 Jan 2026 02:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vkdmh-000866-EO; Tue, 27 Jan 2026 02:46:50 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vkdma-0001sX-80; Tue, 27 Jan 2026 02:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769500000; x=1801036000;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=itsoCTs3vaT05sTcBKoxeawrD9tparwVKI6jRwkJJls=;
 b=LPy3vu7WpjCDAHUnrGeph/bGcDO96c4UbQmwuLEWaoRVmUK5grgQKEY2
 v+V7FlykqjNhqHDrlL7VfIc0JhGcDx/Ryq6PFFwM72ZM6oRU1gHKiv+U9
 9OrTqSRu2zcXkcff30j4xxWjz+fqGxyZhCY19J4xxe+NgHW1Ft8O3wdG0
 r0NoYKXNDb+SJ6Av4NBKW7B5Kbd6YRKdXyO/Hd8YViA++uSVIV9rZzftV
 ymgHG3SgcEkEJMOQg5ZtbGyOsglipRxPKc/61W2hEi9tZ570SgxqUWwuH
 hwQjb7wr/q9Vb5YfoLyYHG0XRKu03gARKqHcoepOf0rgCiSWLTu+E+adE Q==;
X-CSE-ConnectionGUID: eyN0E4PgRp6iY1B4ovC/5Q==
X-CSE-MsgGUID: GiPVetYESXuHi+Te6/AZSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70404153"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="70404153"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 23:46:32 -0800
X-CSE-ConnectionGUID: j9kFpcOORn2SLAiqaXZzEg==
X-CSE-MsgGUID: +3qLvH98TXuEoBqhKBvixg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="212766266"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 26 Jan 2026 23:46:30 -0800
Date: Tue, 27 Jan 2026 16:12:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Mohd Kashif Khan <kashif04x@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] rust/hpet: remove stale TODO comment
Message-ID: <aXhzVd/08HrBSXHN@intel.com>
References: <20260126210910.28889-1-kashif04x@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126210910.28889-1-kashif04x@gmail.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
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

On Tue, Jan 27, 2026 at 02:39:10AM +0530, Mohd Kashif Khan wrote:
> Date: Tue, 27 Jan 2026 02:39:10 +0530
> From: Mohd Kashif Khan <kashif04x@gmail.com>
> Subject: [PATCH] rust/hpet: remove stale TODO comment
> X-Mailer: git-send-email 2.43.0
> 
> The irq binding is already implemented in the following line, so the TODO comment is obsolete.
> 
> Signed-off-by: Mohd Kashif Khan <kashif04x@gmail.com>
> ---
>  rust/hw/timer/hpet/src/device.rs | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


