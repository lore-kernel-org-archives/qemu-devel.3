Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE97AC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCflD-0001O1-NY; Thu, 30 May 2024 09:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCflC-0001NY-F9; Thu, 30 May 2024 09:24:02 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCflA-0000Mi-61; Thu, 30 May 2024 09:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717075440; x=1748611440;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HUjT5cOPLhJldYMpPflMISWAIexyiKlMnrZHGqUtPik=;
 b=aLjJiCuSJ7CiS1V5OYLeSUldpbLYtegk4kXBDZzI+Z764IKwYO2070wP
 UMnZP6A/yRaeQqg6b5Xq0n8tNAfau2mRmC1HcQQbEeKq+NDzYG/Xg1Yt8
 IuzMj9h6asUKjiAv4/mEpvfwR5IYwoVSpTYXwSSIOQvOjEGzcGsp0mLJG
 CJBNMjnVh0u8E2riwOaVleGa+76CyeMNMa/74uSODH41Gobiv+Ha5OfNM
 kxnuI5ThuXpsQ9H8hgZ+YsNdBxMaBga54au6FHysy9EeftMfRCAJWqBOA
 yVfMdR+qqUyyyox9SvQd49W8+I+X/byeV/SORB/n86WBfBU1tNXMb11ZD A==;
X-CSE-ConnectionGUID: ijoQTDYSS1eVDMKDbf7gzg==
X-CSE-MsgGUID: kJaaEkKyTlmZF3anjGvA2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="11805757"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="11805757"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 06:23:57 -0700
X-CSE-ConnectionGUID: egZ+TJBtRayBM2NCWUWuZA==
X-CSE-MsgGUID: b1iGvGEbQledJiDKK9HTTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="35757641"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 30 May 2024 06:23:54 -0700
Date: Thu, 30 May 2024 21:39:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Zide Chen <zide.chen@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 thuth@redhat.com, cfontana@suse.de, xiaoyao.li@intel.com,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH V2 1/3] vl: Allow multiple -overcommit commands
Message-ID: <ZliBhtmOSju79Liy@intel.com>
References: <20240524200017.150339-1-zide.chen@intel.com>
 <20240524200017.150339-2-zide.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524200017.150339-2-zide.chen@intel.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
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

On Fri, May 24, 2024 at 01:00:15PM -0700, Zide Chen wrote:
> Date: Fri, 24 May 2024 13:00:15 -0700
> From: Zide Chen <zide.chen@intel.com>
> Subject: [PATCH V2 1/3] vl: Allow multiple -overcommit commands
> X-Mailer: git-send-email 2.34.1
> 
> Both cpu-pm and mem-lock are related to system resource overcommit, but
> they are separate from each other, in terms of how they are realized,
> and of course, they are applied to different system resources.
> 
> It's tempting to use separate command lines to specify their behavior.
> e.g., in the following example, the cpu-pm command is quietly
> overwritten, and it's not easy to notice it without careful inspection.
> 
>   --overcommit mem-lock=on
>   --overcommit cpu-pm=on
> 
> Fixes: c8c9dc42b7ca ("Remove the deprecated -realtime option")
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> 
> v2:
> 
> Thanks to Thomas' suggestion, changed to this better approach, which
> is more generic and can handle situations like: "enabled the option in
> the config file, and now you'd like to disable it on the command line
> again".
> 
>  system/vl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


