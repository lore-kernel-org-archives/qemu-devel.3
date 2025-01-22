Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD4FC02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 01:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taPWF-0007Qt-RW; Tue, 21 Jan 2025 20:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1taPWC-0007M6-R9
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 20:26:56 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1taPWB-0000Je-CN
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 20:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737509215; x=1769045215;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=g29BVfRw90+61pCIUikzTiukbJSf5iTT4Tn4wk9u0No=;
 b=UK+52UcdrJ0IkqCmj7x24e2VlEJiDIIyNMCqRbYyJqHrp+duSvyld8m+
 B3t/wgbd5sKU0joOeK3nW0t5jbDjG/+zZ3hG0oO9o4ZFiPvt7XynH9j2M
 PSl6bEWVtbkM3N5syWz0A+yrzBlemuS3BTDNw11hoGZC9mj3BrjmMCat2
 80X3hGDmrNCkx4/Mt91afgakLBN+Z8/vGNi4qDA/K8gLjfW2LjNXHMWZ2
 TUSXA0VOZ8iq49DCYVL7jRMLdDItk/3ZT1Zvj6z9s/Drgfyt7WhEhlqkY
 h0MwI37vcpUhI3OhrTrQuA5uU5yJETrxnYaJtQ+ck5ptDq/FBsbFcD0Mw Q==;
X-CSE-ConnectionGUID: 5SnLbJeMT/SIDK4Q9ZTLfQ==
X-CSE-MsgGUID: C4t5r/B+QW6vQGShZFep+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37836916"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; d="scan'208";a="37836916"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 17:26:52 -0800
X-CSE-ConnectionGUID: 19SI4TTsTLeDCfe6/CozCA==
X-CSE-MsgGUID: bK47U0NWQ3WhErYWDDgt2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; d="scan'208";a="107587994"
Received: from linux.bj.intel.com ([10.238.157.71])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 17:26:50 -0800
Date: Wed, 22 Jan 2025 09:21:56 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, xiaoyao.li@intel.com,
 zhao1.liu@linux.intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH 0/4] Introduce SierraForest-v2 and ClearwaterForest CPU
 model
Message-ID: <Z5BINMvNUAb8hMDI@linux.bj.intel.com>
References: <20250121020650.1899618-1-tao1.su@linux.intel.com>
 <20250121133843.2112669-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121133843.2112669-2-pbonzini@redhat.com>
Received-SPF: none client-ip=198.175.65.21;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 21, 2025 at 02:38:44PM +0100, Paolo Bonzini wrote:
> Queued with the tweaks suggested by Zoltan and Zhao; thanks!

Thank you Paolo :-)

