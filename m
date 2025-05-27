Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571CBC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 09:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJqXh-0002lk-Sy; Tue, 27 May 2025 05:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uJqXd-0002lO-PX; Tue, 27 May 2025 05:24:13 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uJqXb-0006gr-Ce; Tue, 27 May 2025 05:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748337851; x=1779873851;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8tqq70JQmth4Z77RNwe+VcagyPIJn7PSC/MTcSISgwk=;
 b=Y6IdOgsSs1i4YgzvoWghfprGyohjpJJYMT/FZREJg/8FUS/l2nR4Hi9Z
 5WWYlbU7ec9aKZ/V6grl6kzA6PH05mvlXy6ZYYvu17lxtO2L662xmnxNh
 7+n5d4JaoBOwmO4vrvHErtk1iUENuW1TUUYHofnubmv7CiovdAzH9T451
 QIQa6XH0QnIwSa2/sbjY6Kw1Wn9snnfL3NnNJ7p4qdkvNd96RoLhBxJ1T
 JG2IKsu6PKD/UvR44I5YU/EJbeMB4mKmq9/QFar8mrhvQNGCjfVMChBSh
 PODuwOqYkkr7xylLKJsYnUwCTsKvBSpriDFpkIcPMKRD3H1nHWzcoPWab Q==;
X-CSE-ConnectionGUID: xn0k0sImQZaaMqQeESeisw==
X-CSE-MsgGUID: 37yxC4swRsORu15xSnTYNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50244901"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="50244901"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 02:24:08 -0700
X-CSE-ConnectionGUID: Fj9Cj8DcTTmbMmR1GpC0HA==
X-CSE-MsgGUID: KMkqA91mSZulNdLetA40HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="146616792"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 27 May 2025 02:24:06 -0700
Date: Tue, 27 May 2025 17:45:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 02/12] subprojects: add the anyhow crate
Message-ID: <aDWJrNpRbKjpKqOi@intel.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
 <20250526142455.1061519-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526142455.1061519-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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

On Mon, May 26, 2025 at 04:24:45PM +0200, Paolo Bonzini wrote:
> Date: Mon, 26 May 2025 16:24:45 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 02/12] subprojects: add the anyhow crate
> X-Mailer: git-send-email 2.49.0
> 
> This is a standard replacement for Box<dyn Error> which is more efficient (it only
> occcupies one word) and provides a backtrace of the error.  This could be plumbed
> into &error_abort in the future.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/meson.build                              |  2 ++
>  subprojects/.gitignore                        |  1 +
>  subprojects/anyhow-1.0-rs.wrap                |  7 ++++
>  .../packagefiles/anyhow-1.0-rs/meson.build    | 33 +++++++++++++++++++
>  4 files changed, 43 insertions(+)
>  create mode 100644 subprojects/anyhow-1.0-rs.wrap
>  create mode 100644 subprojects/packagefiles/anyhow-1.0-rs/meson.build

Missed to change scripts/archive-source.sh & scripts/make-release?

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


