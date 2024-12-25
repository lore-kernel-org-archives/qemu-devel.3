Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1296BE7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 16:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQU9x-00059r-Sa; Wed, 25 Dec 2024 11:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQU9v-00059K-K7
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 11:22:55 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQU9t-0000YS-NW
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 11:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735143774; x=1766679774;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=OT+AtOTYBEi5P3jspX/yQ9Tuis+HpnkcfFsEwqDC50c=;
 b=BDvqitYhwXS4Gt6h0gx/M9jPebG68ODKpUE0U4Y8bkuZJpojtxWSvLYM
 t8rVpJ8VLQjjX6wfHAtru2SDwnOSdQ5Zi8n3p1FFBzkRKCjzzYtTiblG6
 kkyPq5/o2oKjVl7R5z3VMYmTeXnRnTV8KKmyi9K52dv2sg91V0DLvGyRI
 ZeP/nW8vNpgOBgxNPs3zxS9C8MjIS7EFqrmnDMhCPwKhMgI0HqCzzl5dm
 bQuwvuD7usWNHWHkWeSHm6uy3W6cowNYm4NIxBp4wvCBcwHHcu+PKfOsG
 AfQOtXBXGO9u+POq7st2Uy7XajXu7xweYgAawMKxMQB0a/0/3mcKhOsVU w==;
X-CSE-ConnectionGUID: DeTWmbGTSkC0Rg8rplMiQA==
X-CSE-MsgGUID: QRwdgU2IQC2MeRnrwmXc2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="34893534"
X-IronPort-AV: E=Sophos;i="6.12,263,1728975600"; d="scan'208";a="34893534"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2024 08:22:51 -0800
X-CSE-ConnectionGUID: HshrXgRET4+3S6BxK0ZH+w==
X-CSE-MsgGUID: MJt1xUIJQleYk1ceci93FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="130728433"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 25 Dec 2024 08:22:49 -0800
Date: Thu, 26 Dec 2024 00:41:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [PATCH 03/12] rust: macros: check that the first field of a
 #[derive(Object)] struct is a ParentField
Message-ID: <Z2w1vF06cTgLxL1K@intel.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
 <20241220142955.652636-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220142955.652636-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Fri, Dec 20, 2024 at 03:29:45PM +0100, Paolo Bonzini wrote:
> Date: Fri, 20 Dec 2024 15:29:45 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/12] rust: macros: check that the first field of a
>  #[derive(Object)] struct is a ParentField
> X-Mailer: git-send-email 2.47.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api-macros/src/lib.rs | 61 +++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 25 deletions(-)

Good idea!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


