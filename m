Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BECC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 07:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl27V-0006tG-1D; Fri, 15 Mar 2024 03:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rl27I-0006sp-Iz
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 03:36:38 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rl27F-0007Dd-RP
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 03:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710488194; x=1742024194;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=FPhHu+E09p0qcW4uoeaolFsTzzQwx3XBKo7tgz91Gx0=;
 b=P4lqvKcOq0jz9O+gJ+oDhIacGIkee/3+uD1W67R0yXZ0E65iGbxzepbD
 QO/8I3fSPJYtmseNEM5HVv+bEqIedH3dHD5CCfWW8OlAVfMAmEpXEi7MP
 F/Q4IdujQZcwmc/d4iUXGlZyWcVQJLfPnVVdqEYPpto/Ti6D8CqWgS1s/
 cGaFC+ssoay6DFrhpgNfKenPjKnkU1eX7QQZPotFG3GQsajGb1WJLWX8u
 evx34oLlpOkcOOdxPs5x/KMHurRJ0njvvB9BT8GH2/Yp1ntSLnYFUESDE
 b4rdSmYY0Ey++0IPZ890bs12WbQXYSwWzqWG9/LOahFHHk9tigijT4qfS A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="16070141"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; d="scan'208";a="16070141"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2024 00:36:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; d="scan'208";a="17308677"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 15 Mar 2024 00:36:28 -0700
Date: Fri, 15 Mar 2024 15:50:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Chao Gao <chao.gao@intel.com>, antonio.gomez.iglesias@linux.intel.com,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [PATCH] target/i386: Export RFDS bit to guests
Message-ID: <ZfP9uor+3z9hT+5I@intel.com>
References: <9a38877857392b5c2deae7e7db1b170d15510314.1710341348.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a38877857392b5c2deae7e7db1b170d15510314.1710341348.git.pawan.kumar.gupta@linux.intel.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Pawan,

On Wed, Mar 13, 2024 at 07:53:23AM -0700, Pawan Gupta wrote:
> Date: Wed, 13 Mar 2024 07:53:23 -0700
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Subject: [PATCH] target/i386: Export RFDS bit to guests
> 
> Register File Data Sampling (RFDS) is a CPU side-channel vulnerability
> that may expose stale register value. CPUs that set RFDS_NO bit in MSR
> IA32_ARCH_CAPABILITIES indicate that they are not vulnerable to RFDS.
> Similarly, RFDS_CLEAR indicates that CPU is affected by RFDS, and has
> the microcode to help mitigate RFDS.
> 
> Make RFDS_CLEAR and RFDS_NO bits available to guests.

Are these two bits going to be supported by microcode updates to
existing products?

(Let me aslo attach the related spec to make it easy for more people to
learn about backgrounds: 
https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/advisory-guidance/register-file-data-sampling.html)

> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  target/i386/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



