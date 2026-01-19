Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428C6D4A5EB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 05:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhhZa-0001RZ-V8; Mon, 19 Jan 2026 00:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vhhZA-0001Nu-6X; Mon, 19 Jan 2026 00:12:42 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vhhZ8-0000xp-NZ; Mon, 19 Jan 2026 00:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768799559; x=1800335559;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xp8gD7P2Fqvqzlo/0u9OHfa9xkp7oMt3pTsX7kF8QLU=;
 b=kEMqh5R7D2DcNYkFdvIMrPnGrCCrZmLDq/fMgDGJNSkXos6pCd6CpHk5
 GxklXvj1kHX6/mVq3CgasqDRHnXkh39JKGO5tQNCoziQrbyh5I7LnzXXU
 4WEVPVWBoMvDKMQxMvn3kPbAYjBUcQXpX4p0mVI9V1WudNiECfWrETDOJ
 PMA29UltuhV0ynDebjKs8itGYc9JiN3rtmguRw4Obaiu/FmXnZXjl6GSI
 gkEMEdv4pBwAkFhKe9hpL3mkeWavuz2rrinFqb/96REyMs3sQ9TjMNeWR
 d51WbkqhJliR67YRsIWKZ/F4PUFBsJ13PjRO9ijRDugAjjAV3iSRNuzk5 A==;
X-CSE-ConnectionGUID: Ho4+JlQfSE2WzKAyHA7uRg==
X-CSE-MsgGUID: vvI3YisiReSAEDPMim0Ufg==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="80642843"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; d="scan'208";a="80642843"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2026 21:12:35 -0800
X-CSE-ConnectionGUID: 6CYPiwIVRe2Ufu/xn/bFHQ==
X-CSE-MsgGUID: 7L242cXyRpGe9SQbyPEqgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; d="scan'208";a="237052887"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 18 Jan 2026 21:12:33 -0800
Date: Mon, 19 Jan 2026 13:38:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: Add docs/system/i386/ to the general x86
 architecture section
Message-ID: <aW3DPHdOp6G8G2wz@intel.com>
References: <20260116101139.269906-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116101139.269906-1-thuth@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
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

On Fri, Jan 16, 2026 at 11:11:39AM +0100, Thomas Huth wrote:
> Date: Fri, 16 Jan 2026 11:11:39 +0100
> From: Thomas Huth <thuth@redhat.com>
> Subject: [PATCH] MAINTAINERS: Add docs/system/i386/ to the general x86
>  architecture section
> 
> From: Thomas Huth <thuth@redhat.com>
> 
> We've got a section for generic x86 architecture support in our
> MAINTAINERS file - this should cover the docs/system/i386/ folder, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


