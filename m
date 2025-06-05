Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E8EC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 13:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNAMO-0001Ep-Uj; Thu, 05 Jun 2025 09:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uNAMD-0001Cj-E1; Thu, 05 Jun 2025 09:10:10 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uNAMB-00068W-Ck; Thu, 05 Jun 2025 09:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749129007; x=1780665007;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Gt84GNRJ2xXvJmeqMnz7MaJpNy/Bidb/adMPvyjhzIE=;
 b=gMi6nGO5K03KNedNd/d86DhfKUZuhafcg+rilKYBboSdik/XDGRlCjow
 /bTf16JAKz2jxkCxW6TVnfCxqAt1rwQNGDhrrm5EH4ydo2LeJxipjnu9a
 JX/3Zf7/tSdCHReiCcPxeszPdNFL41XgDF/qIHrDFr5Sq3A2M9i8Zmt+h
 rFPY+etGs9h+AjWCDZJaWHl/oZS0P7SzdfAN5OpF4KfLE5uAutrisF61P
 tSAh5ATQz3ALtKdufAerSJgL6fdTvg9bkOSYWrTxD0qNsgYuRIX3aE/ow
 5Wbn3p3pNZzO6aWnfAFP+QAZ99ktCkmGAzaeT3uY5W5wh4LblsbFd6aK+ w==;
X-CSE-ConnectionGUID: FeRKtUvqTtCpW7CGjqtp4w==
X-CSE-MsgGUID: GMvS3490TOaw5aslBv/8Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="50945022"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; d="scan'208";a="50945022"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 06:10:05 -0700
X-CSE-ConnectionGUID: Yxq+fDjYQbi1lqoRLkwp8Q==
X-CSE-MsgGUID: GdLz69TqTOCzmh4ig5i7zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; d="scan'208";a="145399985"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 05 Jun 2025 06:10:04 -0700
Date: Thu, 5 Jun 2025 21:31:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/14] util/error: expose Error definition to Rust code
Message-ID: <aEGcJc1hitxVoBmw@intel.com>
References: <20250605101544.368953-1-pbonzini@redhat.com>
 <20250605101544.368953-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605101544.368953-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jun 05, 2025 at 12:15:32PM +0200, Paolo Bonzini wrote:
> Date: Thu,  5 Jun 2025 12:15:32 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/14] util/error: expose Error definition to Rust code
> X-Mailer: git-send-email 2.49.0
> 
> This is used to preserve the file and line in a roundtrip from
> C Error to Rust and back to C.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qapi/error-internal.h | 26 ++++++++++++++++++++++++++
>  rust/wrapper.h                |  1 +
>  util/error.c                  | 10 +---------
>  3 files changed, 28 insertions(+), 9 deletions(-)
>  create mode 100644 include/qapi/error-internal.h

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


