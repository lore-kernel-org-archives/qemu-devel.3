Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6781EC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1kFC-0002Lx-H9; Wed, 02 Sep 2026 08:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1kFA-0002Kk-6J
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:39:08 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1kF8-0007M4-9m
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788352746; x=1819888746;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=cn3iogYEPWpA9gI7bnwCiMYsWb8K3Y77UrWJBub9vzc=;
 b=KUX8ab7SlO3Bw9HcG/setJTQo0TJbZwqS/N7MeEe9U7oEjIv03AwaETs
 N5v8H7iglnSpVIfV8P7Ij+iA1az7NCDiZnVGHitdoDO6MQBBgRGHi+pqB
 vCTJn6lyTXGxi4Mhcryknia+4hQSMI7tMwEcxt5aceKBrAS16bp17Cvxg
 VCIu8mwaEqKqsSAAoxiEEFT85uuiZfXGV++l/M4lrKKvP1cLQIioF1+Z4
 nJxZkPENM48XLDOvBcifYkEC+CcJNCS/8h0GYmHtU2SkBmn7KeH/7WDYT
 bQhPoNl/02ofNdU+ZAhHkMy4hM5ahvT/X6g5pQt1Oo9ANoMQLt9uoPwXs A==;
X-CSE-ConnectionGUID: wIj3AQA7S+iGSjvmUiFqcA==
X-CSE-MsgGUID: AffQ8ADTRCm33deSccuoOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88829173"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="88829173"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 05:39:04 -0700
X-CSE-ConnectionGUID: l7bdkdF+SqeueBuHCestIw==
X-CSE-MsgGUID: K/yxMTVqTwiPEAI5DTaD/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="269417761"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa007.jf.intel.com with ESMTP; 02 Sep 2026 05:39:03 -0700
Date: Wed, 2 Sep 2026 20:39:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com
Subject: Re: [PATCH v4 3/4] target/i386: Introduce Zhaoxin Shijidadao CPU model
Message-ID: <apgY5SQpUFnOFIkI@intel.com>
References: <20260826084838.2107629-1-ewanhai-oc@zhaoxin.com>
 <20260826084838.2107629-4-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826084838.2107629-4-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 26, 2026 at 04:48:37PM +0800, Ewan Hai-oc wrote:
> Date: Wed, 26 Aug 2026 16:48:37 +0800
> From: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH v4 3/4] target/i386: Introduce Zhaoxin Shijidadao CPU model
> X-Mailer: git-send-email 2.34.1
> 
> Introduce the Zhaoxin Shijidadao CPU model with two versions:
> 
> - v1 (alias: Shijidadao-Server) - Server variant with CORE_CAPABILITY
>   and SPLIT_LOCK_DETECT support
> - v2 (alias: Shijidadao-Client) - Client variant with different FMS
>   (model=0x6b, stepping=1), with neither CORE_CAPABILITY features nor
>   the ACE2 feature pair
> 
> Both versions include the SM2, CCS, RNG2, PHE2 and RSA feature pairs
> exposed by KVM.
> 
> The model_id for both variants is 'Zhaoxin Shijidadao Processor'.
> 
> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> ---
>  target/i386/cpu.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


