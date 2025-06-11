Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE23EC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPMza-00038i-IJ; Wed, 11 Jun 2025 11:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPMzY-00038N-RI; Wed, 11 Jun 2025 11:03:52 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPMzW-0006PM-S8; Wed, 11 Jun 2025 11:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749654231; x=1781190231;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DfzGUjwb+a4TDpGYGcU/G2ITlow1Fg8h03KOgk9GmwI=;
 b=Y8E6bXAU5lpv1hZpEnM8ybygouMMe24g8yxb5pKesar2O/sQlchDXFr3
 JCE0TQDClQnFOlxTBrNzS6xwtENvt1QqsKthY6k36mhv0PLq03fqUdlid
 d8Qq0f4rXo1PFYdtkpWvM1f+AxMDjZsyBt4bQlwrvzMQ7Gp9EG0AQbxNF
 kOJcREDYZxK67w4d547Qg2rDNoEjEriBfbr/cW4KLFwB1l+3hCUO2S3i+
 xvRDSY1TjYS9I05jcjKNLkJ9+KNXae1E+7pg6yRcoQXpZ7kd114DEScd/
 mVg//1AcnvuERgkUvpIOGWOmycxlEMPs6aXF9VkIcq79XSDRH8yX44SQV Q==;
X-CSE-ConnectionGUID: XTdnpMdeSXaTQGRvBPGtTw==
X-CSE-MsgGUID: /XZ/0PluS7SChLFG/5WNxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62081722"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; d="scan'208";a="62081722"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 08:03:48 -0700
X-CSE-ConnectionGUID: zC2q91qXQPye49Irs+YFDw==
X-CSE-MsgGUID: N+f5b9JrRTeDji7F2RuNZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; d="scan'208";a="178171883"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 11 Jun 2025 08:03:47 -0700
Date: Wed, 11 Jun 2025 23:25:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 3/5] rust: qom: introduce ParentInit
Message-ID: <aEmfzssEUlYIP9MR@intel.com>
References: <20250609154423.706056-1-pbonzini@redhat.com>
 <20250609154423.706056-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609154423.706056-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Mon, Jun 09, 2025 at 05:44:21PM +0200, Paolo Bonzini wrote:
> Date: Mon,  9 Jun 2025 17:44:21 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 3/5] rust: qom: introduce ParentInit
> X-Mailer: git-send-email 2.49.0
> 
> This is a smart pointer for MaybeUninit; it can be upcasted to the
> already-initialized parent classes, or dereferenced to a MaybeUninit
> for the class that is being initialized.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/qom.rs | 86 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 85 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


