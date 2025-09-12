Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579DFCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwzJm-0001vQ-H1; Fri, 12 Sep 2025 04:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwzJk-0001v1-MP
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:39:40 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwzJh-0005RR-Fo
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757666377; x=1789202377;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=mR+Yc6W2LZpW9FcjUMtn0wAY0pOmP6olwK/wZYZPWkI=;
 b=Y1tNVf9rK2hb6aFVvbrfMXNvY/gsRKSzj6kWZEY/4ttQpX1A3qXp0QQp
 t234djjmCvSOGjYATf+B5JSiHbfEQ4ZdUFErsae4A0eLc2PW7aJ/CtcU+
 YSLn3SoMrsToLhBnTb8W0AreMYYtxwCVVi3xcWI4vdz2mrjcVR6qmDZ9G
 PcWEUGsXhI7ogYPXdtFQA7tFewSh1tgA6brfQhftrvRQtL+V9bBUYODwX
 7qIZ2PXjIEhTRBpZZ7k/UbtT1O3Llsc40PsKWC1igNL/XdS0mJHvErktE
 zZU03+1dAGzEQRM1w1AE8oA3sc9gDrHbdEVSowXZvFbL6Gl8BhZi3e+j+ w==;
X-CSE-ConnectionGUID: yCgPDCGNQDeFRbs4892r0Q==
X-CSE-MsgGUID: 4G3ayEjaRaisiZx0Lxl4Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="85444631"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="85444631"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 01:39:33 -0700
X-CSE-ConnectionGUID: 3/gtBYtWSOKnv0Tg2SIdGQ==
X-CSE-MsgGUID: 62tMFUHGSxOT/6b/9j/kAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="179096567"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 12 Sep 2025 01:39:31 -0700
Date: Fri, 12 Sep 2025 17:01:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 29/33] rust: re-export qemu_macros internal helper in
 "bits"
Message-ID: <aMPhZDZcWdhiV0gu@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-30-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-30-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:50:01PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:50:01 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 29/33] rust: re-export qemu_macros internal helper in "bits"
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Avoid the need to import "qemu_macros".
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-21-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/bits/src/lib.rs | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


