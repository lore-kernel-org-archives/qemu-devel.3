Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B260C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 11:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjzXU-0000R3-KP; Mon, 17 Feb 2025 06:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tjzXS-0000QP-8w
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 06:43:50 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tjzXP-0001Qa-06
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 06:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739792627; x=1771328627;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7WDka1pTtZn9l1MzSf4sbDVprrsZO0IpOdM1Nckx1zI=;
 b=MGP4LnFqyd/CmXE20hyQ4EYpW/Ip0aDgdyPp/jWWRlVC2/URjYGDCbyC
 bGPLF7Sh8G1VKQXE6WCSkK3LSEwcCNaal8CvmeHe1f8vc4kx5dl8H+Fv6
 HOi8pBAEk2qJMhUvvHJ3tDilRKhjWGNwyfRO0zUIMdnropeuGC87r0lIN
 UDeSb00UvMwtFUM3mbjIKUcl1OIfI6EU/TEDiUQtbgQ1ldzLPV8RdY8cC
 4x5q+01IVx87BHtM5OyWxnCTMYzaNKYvr0IGzz81IiRJo2ldzTkAochEN
 tIRaqwMGsjwuH6bQHOo1pnDcg2tkIA+X8xVgHQgNiewe8guynKc7XfAAA w==;
X-CSE-ConnectionGUID: O089A4dERNK7ZV1ztIM7yg==
X-CSE-MsgGUID: xy3YLfewTf65ogT04xWcxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44400597"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; d="scan'208";a="44400597"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 03:43:42 -0800
X-CSE-ConnectionGUID: hvNCcdd7QXGRmulDcaC8ng==
X-CSE-MsgGUID: YWj3AFtETdSKpmNFPj4X2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="119022450"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 17 Feb 2025 03:43:41 -0800
Date: Mon, 17 Feb 2025 20:03:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] stub: Remove monitor-fd.c
Message-ID: <Z7MlgwOe8Dnjdkff@intel.com>
References: <20250217104900.230122-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217104900.230122-1-iii@linux.ibm.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
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

On Mon, Feb 17, 2025 at 11:48:49AM +0100, Ilya Leoshkevich wrote:
> Date: Mon, 17 Feb 2025 11:48:49 +0100
> From: Ilya Leoshkevich <iii@linux.ibm.com>
> Subject: [PATCH] stub: Remove monitor-fd.c
> X-Mailer: git-send-email 2.48.1
> 
> Both monitor-fd.c and monitor-internal.c contain a stub for
> monitor_get_fd(), which causes a duplicate symbol linker error when
> linking rust-qemu-api-integration. Use monitor-internal.c instead of
> monitor-fd.c and remove the latter.
> 
> Reported-by: Zhao Liu <zhao1.liu@intel.com>
> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> Fixes: fccb744f41c6 ("gdbstub: Try unlinking the unix socket before binding")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  stubs/meson.build  | 2 +-
>  stubs/monitor-fd.c | 9 ---------
>  2 files changed, 1 insertion(+), 10 deletions(-)
>  delete mode 100644 stubs/monitor-fd.c

Thanks Ilya! LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


