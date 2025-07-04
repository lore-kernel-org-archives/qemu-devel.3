Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E1CC83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXcRK-0002ER-Os; Fri, 04 Jul 2025 05:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcRI-0002EH-Tb
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:10:36 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcRG-0000VO-Hz
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751620234; x=1783156234;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=/WcIW2V4RQ1qMDmRJzAhWm9P80zzP9IHLGjdO1qvN+g=;
 b=H7pf/ZjE+3+WN9F2fB0vmtMaFXCFzqIi8tsi1K+4Spsjhik03bBNthhT
 LkHobDwDTVYEs/KOJod8CWGMYv/ZkiH7kRvmjhgVYva+PQgefiuSQdyR/
 LUPmdxvLYsHIUyTYIDBTDpiG4dK7YATnFkqWpD1R89SzOHetFbcV/rn57
 TAF9plXRyl1BwJwActus4CjJVgCJw2i4dVxlTGISQmi+FR16u/AfyH1cg
 IcktJB9xdHYhtX+JCVsMiQqw6gLez8QUQ9TLWLmGVjXsd557kWmzAG6HD
 OdXz9H2mL5KoVZXf0gGqVIwO9cj0gFLrOBdDHQ22sEzGOrYurwoMBb4bg Q==;
X-CSE-ConnectionGUID: VZfw/7bZQoqtTo7z4ihkLA==
X-CSE-MsgGUID: 59bcW6kKQiagh5kelvdi0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53176353"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="53176353"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:10:31 -0700
X-CSE-ConnectionGUID: FnZJ2/33QvqQLMlycPiirQ==
X-CSE-MsgGUID: g9Viid2ST1OXzqXZ2sQuYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="158869467"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 04 Jul 2025 02:10:30 -0700
Date: Fri, 4 Jul 2025 17:31:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 03/39] system/runstate: Document
 qemu_add_vm_change_state_handler()
Message-ID: <aGefjGfkAY+QivL6@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-4-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 03, 2025 at 07:32:09PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:09 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 03/39] system/runstate: Document
>  qemu_add_vm_change_state_handler()
> X-Mailer: git-send-email 2.49.0
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/system/runstate.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


