Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F52AC25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 09:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDhL8-0002BT-3t; Sun, 02 Jun 2024 05:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDhL6-0002Aj-1k
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 05:17:20 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDhL4-0002gG-74
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 05:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717319838; x=1748855838;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Dz4hA4bxQ930ETengnWeWOa/jvuG/8SxQ1Ui/rJJiEA=;
 b=iuHDLaeXSfnzXSxKSMYP1IDSXSbmGvY47Ud3N0IUsjO0Uzx9LEb/WSso
 bRqfel3uwCjwhvpv1/IMrWShqQ2zs9EjqPRGj0kIBYdpxGKSqq+cZKlZl
 V7kWFEIaY5NxUd82GlaQlmSTbkG+A5rF/WNxu/KfPBZwBOZq+SqY0zy6j
 5ghykyMxS55rUffOqvleNEQNziJzT1tXdX/Z3DeIO0gxfJpiJzJfYAKZ2
 coOdNcYTz5mG7Q9YGYpILhEJUoPS9meWL8YnxdXhs7C7Xq8uC33T5nQtj
 Fa/cLmMBBSpEMZm2vucGlpRHc6rkLuPXhEQvsnvuvqOWq7FEBj5T2ojrB A==;
X-CSE-ConnectionGUID: IeUzS3qeSrW+E03jRwLH+A==
X-CSE-MsgGUID: pykfZpd8RK2uA6aN6EbPrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="24943344"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; d="scan'208";a="24943344"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 02:17:16 -0700
X-CSE-ConnectionGUID: inMScKVrTHy4qHAMlJL8GQ==
X-CSE-MsgGUID: pFj1je9JRPKh9TdZIyY7Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; d="scan'208";a="67782483"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 02 Jun 2024 02:17:15 -0700
Date: Sun, 2 Jun 2024 17:32:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 5/6] host/i386: assume presence of SSSE3
Message-ID: <Zlw8OAEbE/KzhLn3@intel.com>
References: <20240531091457.42200-1-pbonzini@redhat.com>
 <20240531091457.42200-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531091457.42200-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.041,
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

On Fri, May 31, 2024 at 11:14:56AM +0200, Paolo Bonzini wrote:
> Date: Fri, 31 May 2024 11:14:56 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 5/6] host/i386: assume presence of SSSE3
> X-Mailer: git-send-email 2.45.1
> 
> QEMU now requires an x86-64-v2 host, which has SSSE3 instructions
> (notably, PSHUFB which is used by QEMU's AES implementation).
> Do not bother checking it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/cpuinfo-i386.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


