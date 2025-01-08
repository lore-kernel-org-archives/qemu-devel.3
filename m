Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0FBE77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 08:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVRJh-0002B6-ER; Wed, 08 Jan 2025 03:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVRJf-0002As-9i; Wed, 08 Jan 2025 03:21:28 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVRJd-00034T-7J; Wed, 08 Jan 2025 03:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736324485; x=1767860485;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xQOv0/zapW7BXXy8+/VXKSl+ldZ/8GvMp6GJ/kSGU78=;
 b=XHEBcbyb23EB3Hc4vXmJFi2m3PV3ynDOFP2K1h6rWIHWpG1WHKLePOkS
 cW5qk0tlBj25DcVg07r6urIZayZ/1e/5aZTe6Z/xBUZwReapFXMny8rzo
 WVTkrVp+2iAu5/iwhZvfHrymeovJHmMeRWvQzUfW00IBebx6vXYhhGoN4
 fYYrQN7zFZVuybTPRANSMCspTKtFl3mUrGB+6cdHBADDEpWI8M5FOqzpx
 pRqI/Odin05vJ8MqMecEopycvl9yfzZFkCsoTXVVUURoc/WK4pRDbkSwG
 8+73iqNrOSzkBlyDkGBQqDmatMsOIEwH+cFd0tfHx9L/bv0edCIgDQMUz g==;
X-CSE-ConnectionGUID: pDQALm7AQP+7PEbdwgcleQ==
X-CSE-MsgGUID: GredvXoyQCicc/lqjciu1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="47529530"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; d="scan'208";a="47529530"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2025 00:21:21 -0800
X-CSE-ConnectionGUID: QRTp7K0NTSSICHJ4KHpcdA==
X-CSE-MsgGUID: 30fppuZCQU2D4bUMkxwxQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; d="scan'208";a="102835371"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 08 Jan 2025 00:21:19 -0800
Date: Wed, 8 Jan 2025 16:40:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [RFC PATCH 9/9] rust: vmstate: remove translation of C vmstate
 macros
Message-ID: <Z3455wmD0tXodiSL@intel.com>
References: <20241231002336.25931-1-pbonzini@redhat.com>
 <20241231002336.25931-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231002336.25931-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
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

On Tue, Dec 31, 2024 at 01:23:36AM +0100, Paolo Bonzini wrote:
> Date: Tue, 31 Dec 2024 01:23:36 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [RFC PATCH 9/9] rust: vmstate: remove translation of C vmstate
>  macros
> X-Mailer: git-send-email 2.47.1
> 
> Keep vmstate_clock!; because it uses a field of type VMStateDescription,
> it cannot be converted to the VMState trait without access to the
> const_refs_static feature.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/vmstate.rs | 274 +++--------------------------------
>  1 file changed, 23 insertions(+), 251 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


