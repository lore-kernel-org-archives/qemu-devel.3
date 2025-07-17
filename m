Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FBAC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 08:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucJrr-00056n-Hi; Thu, 17 Jul 2025 04:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ucJrX-0004qm-Sb
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:21:09 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ucJrW-0000vF-5f
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752740467; x=1784276467;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=8hjF//dfqCnZv9Z0UKjSHCR08IapYHDyB/EVH83yfRg=;
 b=Jei0jY5q7nBwgGv/xH1FUR1d+K8S9k3A6dGX/kHcMsoyggKJShByD87k
 /YiJWctqCYLYj4+DVxMEZM625ZPnDYDybgNBnvTjjVjXlSfAP6Z6XUzUe
 VINaviioJ6r4Z8aaNAqoqeH5F6pjqUdGAqzfNikcDuM2fquKBq6RWsXm5
 J37tPAHY8E5px8RaLXjweFnxDRcaIz+rOrmiIepadHUn5ZK0N8wepGYHn
 ldMgu9Br1TF1dVm30w2sYlH1awBMSNYn+kTBcVWm3jAVFK/VeIlYb7nx2
 JLsFjpcrcMOnT/XZatcdRde1aQ7xXS7RPeLfiXEp6Z42azM9JEy7QGE7q Q==;
X-CSE-ConnectionGUID: fK/onOxdSQiuLM2N0xQHGw==
X-CSE-MsgGUID: Qt5UnOqBR+avEDgIg+vJaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54222309"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="54222309"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 01:21:04 -0700
X-CSE-ConnectionGUID: 9iXgAv3RRNmmilucGPKzsA==
X-CSE-MsgGUID: xFkqR0MeTPuZNPhypOzwiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="157803315"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 17 Jul 2025 01:21:02 -0700
Date: Thu, 17 Jul 2025 16:42:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH-for-10.1] system/runstate: Document
 qemu_add_vm_change_state_handler_prio* in hdr
Message-ID: <aHi3eFLDgjvAnabV@intel.com>
References: <20250715171920.89670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250715171920.89670-1-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
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

On Tue, Jul 15, 2025 at 07:19:20PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue, 15 Jul 2025 19:19:20 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-10.1] system/runstate: Document
>  qemu_add_vm_change_state_handler_prio* in hdr
> X-Mailer: git-send-email 2.49.0
> 
> Generally APIs to the rest of QEMU should be documented in the headers.
> Comments on individual functions or internal details are fine to live
> in the C files. Make qemu_add_vm_change_state_handler_prio[_full]()
> docstrings consistent by moving them from source to header.
> 
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20250703173248.44995-4-philmd@linaro.org>
> ---
>  include/system/runstate.h | 30 ++++++++++++++++++++++++++++++
>  system/runstate.c         | 30 ------------------------------
>  2 files changed, 30 insertions(+), 30 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


