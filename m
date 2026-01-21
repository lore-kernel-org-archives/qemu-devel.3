Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEB0C44526
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viXqB-0004Oh-Fn; Wed, 21 Jan 2026 08:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1viXq2-0004MZ-TO
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:01:35 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1viXq0-0004VK-QZ
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769000493; x=1800536493;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XSglhLok9v55nedhhZLtyMEL7rQzVx198ECkAyf19gU=;
 b=m9uPr9QLuWpAhWfmmaywWr4BvMPHTSUGH0rboErbO8nmoEqd2A5L22at
 a/uAs+m+oftBqaGGhF3YIaVGrARMdjHSeXJvfjdXc7gdMhyHeFzDkW3ep
 K5lrFJ2f+oFidD7eJx7b2iCBu1POrvH71ShV5O1Jgr1BDuk82Kv/xnEXk
 HyK59Iom9xjdSQ9N2Wd5S1msacSwOYLSkdf6+LGPXt4gKaRhzHfz+Nxzv
 Tm6ulQTO1esslMcS0xGcfsanW4zFZOrf73dGAjwuCs7CzJuJuGHCrsBZq
 eWGaFNzpKoTUaSIhwDjmyz+QI4ouICabgjuIkPxljcOibKNezne3Z8Bl0 A==;
X-CSE-ConnectionGUID: 1jeKWY0ERNGzx55M5pURtQ==
X-CSE-MsgGUID: lwpBywPlTjuZGH2eGMVr4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="92894308"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="92894308"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 05:01:31 -0800
X-CSE-ConnectionGUID: +sLrMauTRsG087urvEIt0A==
X-CSE-MsgGUID: ggeDhwfoQeu2dfq1Hnnrag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="205692678"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 21 Jan 2026 05:01:29 -0800
Date: Wed, 21 Jan 2026 21:27:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com
Subject: Re: [PATCH v3 2/3] target/i386: Introduce Zhaoxin Shijidadao CPU model
Message-ID: <aXDUJdDp/ja9PXkJ@intel.com>
References: <20260109021028.83985-1-ewanhai-oc@zhaoxin.com>
 <20260109021028.83985-3-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109021028.83985-3-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Jan 08, 2026 at 09:10:27PM -0500, Ewan Hai wrote:
> Date: Thu, 8 Jan 2026 21:10:27 -0500
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH v3 2/3] target/i386: Introduce Zhaoxin Shijidadao CPU model
> X-Mailer: git-send-email 2.34.1
> 
> Introduce the Zhaoxin Shijidadao CPU model with two versions:
> 
> - v1 (alias: Shijidadao-Server) - Server variant with CORE_CAPABILITY
>   and SPLIT_LOCK_DETECT support
> - v2 (alias: Shijidadao-Client) - Client variant with different FMS
>   (model=0x6b, stepping=1) and without CORE_CAPABILITY features
> 
> The model_id for both variants is 'Zhaoxin Shijidadao Processor'.
> 
> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> ---
>  target/i386/cpu.c | 149 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 149 insertions(+)

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


