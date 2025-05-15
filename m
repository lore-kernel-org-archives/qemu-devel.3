Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB8AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 06:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFSCL-0001G9-Dk; Thu, 15 May 2025 02:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFSCD-000199-Oz
 for qemu-devel@nongnu.org; Thu, 15 May 2025 02:35:59 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFSCB-0006mD-AT
 for qemu-devel@nongnu.org; Thu, 15 May 2025 02:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747290956; x=1778826956;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kAamd3NDqCRnl+i58U7rvWZb5OrDockqtnaselZ/NBs=;
 b=OuA94c8QMfSISdf4aTptXkLkuKf6wbzSj26SRL2k/6Je7juT6OhpWE+a
 yp/tRNNlCei4RY3KMnaVaktBEIjj36WTTohYZj4ktCwSTkZy0EJ6LBROq
 LA7Y96zSRTu9AOP1g1Dxt6C50hhEvF8wA8DdihBwMCY6v7f7LxqRn0Npb
 +UzFZ817QsfwIzW9mhXlaG4GNDuhRzXzEajLfo7QRQvaJqvyDeWbT0Nwp
 rNiIZQMkpyf+x+jvNW/+Qb2dMDIdFASYnlFgrE/O9gniIR3B3yTwD6iMM
 Y9d7vfi8J1St1LpyfURyliANvwt4luDk8+6cYH7RCeDplejfK+EN2J+am Q==;
X-CSE-ConnectionGUID: 58dMZLIsR3WCHqKWtaWzsQ==
X-CSE-MsgGUID: 3ECbCxhST1GAxu9QqaRsjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49080045"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="49080045"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 23:35:51 -0700
X-CSE-ConnectionGUID: 0A2dnBhwQu+5nyMCTRJw1g==
X-CSE-MsgGUID: 8NenaQmNQVCLxiiy2pXIAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="143152387"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 14 May 2025 23:35:49 -0700
Date: Thu, 15 May 2025 14:56:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] qapi/misc-target: Fix the doc of query-sgx and
 query-sgx-capabilities
Message-ID: <aCWQNdZ0dy3641jE@intel.com>
References: <20250513143131.2008078-1-zhao1.liu@intel.com>
 <87cyca4dbt.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyca4dbt.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, May 15, 2025 at 08:07:02AM +0200, Markus Armbruster wrote:
> Date: Thu, 15 May 2025 08:07:02 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH 0/2] qapi/misc-target: Fix the doc of query-sgx and
>  query-sgx-capabilities
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > Hi all,
> >
> > There're 2 QMP commands: query-sgx and query-sgx-capabilities, but
> > their outputs are very similar and the documentation lacks clear
> > differentiation.
> >
>  >From the codes, query-sgx is used to gather guest's SGX capabilities
> > (including SGX related CPUIDs and EPC sections' size, in SGXInfo), and
> > query-sgx-capabilities is used to gather host's SGX capabilities 
> > (descripted by SGXInfo as well).
> >
> > Therefore, fix their documentation to reflect this difference.
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 
> I'll take this through my tree unless Paolo is faster.

Thanks Markus!

I was also thinking you would like "SgxInfo" and "SgxEpcSection" instead
of current "SGXInfo" and "SGXEPCSection".

But I'm not sure if modifying the old names has any compatibility issues
for QAPI? If you think it's ok, I can continue to make the SGX naming
styles more QAPI compliant.

Regards,
Zhao


