Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0AFC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 05:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm5Zp-0005SJ-NM; Mon, 18 Mar 2024 01:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1rm5Ze-0005RH-MU
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 01:30:16 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pawan.kumar.gupta@linux.intel.com>)
 id 1rm5Za-00033T-Mn
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 01:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710739811; x=1742275811;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5VF0vsMzozi8SCiLfFc0MO30Z3rDvNY0jVo6Hzy29dE=;
 b=NpbBMJLMyNlINYhEUOZwMWw4ctngfZwAX6YlEIqOfNL0Bvcjrk9HyohY
 s3V5z+s/APlwIQGkLO/rKJG3odmD0WXTFf5DIWW7JLJohKCUC4h835Awx
 zubIlB5inKohXZIApAHHKd6Ym/ItKh2124so/dvDwvqfIlM7OZduaNJFu
 egdaKsyxcxTww4AFxHCgIr7OHhS3zSjGsOqF2ikpOLrH/gyoj7i3pWo0x
 1ltn9HA3IftHrMTxORiK4bPecXDpqHoSUmidoSOhqGaR0jgLZrCg1Abcg
 SfTEcVKqZ7i3mDqdsuUrFqWJHFSjJb0+cW75ImFDQuz4zojLbp0JfcjDC g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5473719"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5473719"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2024 22:30:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208";a="13244543"
Received: from kawserah-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.182])
 by fmviesa010-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 22:30:03 -0700
Date: Sun, 17 Mar 2024 22:30:10 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Chao Gao <chao.gao@intel.com>, antonio.gomez.iglesias@linux.intel.com,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [PATCH] target/i386: Export RFDS bit to guests
Message-ID: <20240318053010.6rlue36sygewcnvu@desk>
References: <9a38877857392b5c2deae7e7db1b170d15510314.1710341348.git.pawan.kumar.gupta@linux.intel.com>
 <ZfP9uor+3z9hT+5I@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfP9uor+3z9hT+5I@intel.com>
Received-SPF: none client-ip=198.175.65.21;
 envelope-from=pawan.kumar.gupta@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Fri, Mar 15, 2024 at 03:50:18PM +0800, Zhao Liu wrote:
> > Make RFDS_CLEAR and RFDS_NO bits available to guests.
> 
> Are these two bits going to be supported by microcode updates to
> existing products?

RFDS_CLEAR is supported by the microcode update that is needed to
mitigate RFDS. RFDS_NO will be supported by future unaffected parts and
some of the existing parts. AFAIK, not all unaffected existing parts
will get RFDS_NO, for such parts KVM synthesizes RFDS_NO.

> (Let me aslo attach the related spec to make it easy for more people to
> learn about backgrounds: 
> https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/advisory-guidance/register-file-data-sampling.html)
> 
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > ---
> >  target/i386/cpu.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> LGTM,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Thank you.

