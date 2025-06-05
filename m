Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2A8C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 13:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNAhm-0000nt-4O; Thu, 05 Jun 2025 09:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uNAhd-0000nX-0g; Thu, 05 Jun 2025 09:32:17 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uNAha-0006bT-6a; Thu, 05 Jun 2025 09:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749130334; x=1780666334;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5iIKznaaZZVprT39oIWpXnAfEhzR/jmtopESJxCX+fM=;
 b=kojgiEXS9Y7efz5rz7Pnrf3x0pAiV+IgWRL6T9nQnIRe3eaRRLXm3bKl
 XjFlNGOsXNTI0Kld7I7zXNR4DbDy77/ASkq9dlBCqGgodLghLHFMbDwnK
 uSpNHES6WHkbGeo9DpYH4h18woc4iz9Uiacyx7pD/LgukehsoJeePGUU7
 qxtjAF8IQ1wmo38C2XVNHLEztmFGBPYLMsBsiDQ+EtpdApUH6gVuFr/aJ
 NzYr99IeGLg6LdXcFeRx9q4dNrNmisKXSE9KDm/MhhJ9y46ML6HE79iZb
 /2+dlO+qaZc/XsdtSqPa4K12h2S8XZZUhBL4g3LeJSiuRERDDgz3U77u/ Q==;
X-CSE-ConnectionGUID: egzf/SgLSN6TY1XEXG847g==
X-CSE-MsgGUID: 7tsMmvbXSCq6PjAyFq/LdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="61868697"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; d="scan'208";a="61868697"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 06:32:09 -0700
X-CSE-ConnectionGUID: GurPdgnWRByQZFH0efRw1g==
X-CSE-MsgGUID: GjNnel32QsOvImeUQZPyVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; d="scan'208";a="145405041"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 05 Jun 2025 06:32:08 -0700
Date: Thu, 5 Jun 2025 21:53:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 07/14] rust: qemu-api: add tests for Error bindings
Message-ID: <aEGhUZspokWIoMpw@intel.com>
References: <20250605101544.368953-1-pbonzini@redhat.com>
 <20250605101544.368953-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605101544.368953-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

On Thu, Jun 05, 2025 at 12:15:36PM +0200, Paolo Bonzini wrote:
> Date: Thu,  5 Jun 2025 12:15:36 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 07/14] rust: qemu-api: add tests for Error bindings
> X-Mailer: git-send-email 2.49.0
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/error.rs | 104 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


