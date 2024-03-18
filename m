Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C912C54E71
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 08:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm8b4-0002o9-4B; Mon, 18 Mar 2024 04:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rm8b2-0002iN-GH
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:43:52 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rm8b0-0007ln-Db
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710751430; x=1742287430;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ry8bSGbNxxZnqluLVRrpeRyXBX79wYPqAMy795gVJoo=;
 b=O2WQp1bmQaeSRjE5akCEwjlFura7a6pI5W7WMf3WxzaSN2TOBu/eFn8U
 dKSmaarXL2nnKgY7WoagsOvWboSC2EKVW/2R/pJnJNW3PoSDfTeQ6a6Me
 FfO7cByg34OwlgfJJ+ddg0CDR/0e328seLbcx2mu8XGY2/t+7itwDjvUt
 iKXRt9R1fMerw7ULBtkhj7p6qEcdpgSEcKJs+cisoRyH77xQSH2UiSNfY
 BjA4lg2aNLvaNWbOUvGGPth86rBB9vrT2EzZZK9BByylWz2dum9iabVEo
 UcjkeTvUmuthx0FpZYSsIf6EwStm29JQh/07ddP9UOJFLevLv01+J1yCF w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5386991"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5386991"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 01:43:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208";a="13344152"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 18 Mar 2024 01:43:46 -0700
Date: Mon, 18 Mar 2024 16:57:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, chao.p.peng@intel.com
Subject: Re: [PATCH v2 3/3] qom/object_interfaces: Remove local_err in
 user_creatable_add_type
Message-ID: <ZfgCAfLCgxvzlvno@intel.com>
References: <20240318033211.459006-1-zhenzhong.duan@intel.com>
 <20240318033211.459006-4-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318033211.459006-4-zhenzhong.duan@intel.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
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

On Mon, Mar 18, 2024 at 11:32:10AM +0800, Zhenzhong Duan wrote:
> Date: Mon, 18 Mar 2024 11:32:10 +0800
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Subject: [PATCH v2 3/3] qom/object_interfaces: Remove local_err in
>  user_creatable_add_type
> X-Mailer: git-send-email 2.34.1
> 
> In user_creatable_add_type, there is mixed usage of ERRP_GUARD and
> local_err. This makes error_abort not taking effect in those callee
> functions with &local_err passed.
> 
> Now that we already use ERRP_GUARD, remove local_err and pass errp.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  qom/object_interfaces.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


