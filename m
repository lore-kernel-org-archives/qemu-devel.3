Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5FED2CE17
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 03:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSRfb-0004jC-KG; Sun, 07 Dec 2025 22:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vSRfa-0004j0-Oa; Sun, 07 Dec 2025 22:12:14 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vSRfZ-0004dy-4K; Sun, 07 Dec 2025 22:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765163533; x=1796699533;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nbYOH8EU3mPnvl9vwr+uqZpLjlZRwHDweW6sP5cU3Ms=;
 b=FlfZrHy9Xf1+SzCOHsoaUFpvWpfDSb55ZVCq7GS7JnsPe2y42Ir8++Kp
 3jaa7Pd6XlKPU90Hq54+8T0kAPyliqKFYOtp+ojc+Chb4WddfqtVf6n43
 oOPkHjwu4ZMzE51DjxiHkutdWnbX+cm6eq0/6Ubd71+UF+6cxKhil9flu
 8xKwfuwuiKZzgvjosfqLrGbN8BDd4uf7PcfB1Jg7qV03s27op/3jREIy3
 nrJrObUa1Ci7+JHGGfUuy5gqXVLQxA2vK4Lx2q8LxUFmeCO6yZ4bnFEiS
 IKHQQhbUiTCiMgunBb7Z12JvRU2ijElN0Yuovr94wNf4pg1n/OaK2n7gZ Q==;
X-CSE-ConnectionGUID: 1KGpc0ndRj+w8bZwylFYLw==
X-CSE-MsgGUID: llb/vkWUQsmQg8KgM5qLxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="92582273"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="92582273"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2025 19:12:08 -0800
X-CSE-ConnectionGUID: vwpIXQNxQAOzeHHBemOURw==
X-CSE-MsgGUID: Z6U4SK21TqeNgpoUvaAhIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="200296525"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 07 Dec 2025 19:12:07 -0800
Date: Mon, 8 Dec 2025 11:36:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: hide panicking default associated constants from
 rustdoc
Message-ID: <aTZH1JW+rYXNZK/E@intel.com>
References: <20251204105017.2564277-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204105017.2564277-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Dec 04, 2025 at 11:50:17AM +0100, Paolo Bonzini wrote:
> Date: Thu,  4 Dec 2025 11:50:17 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] rust: hide panicking default associated constants from
>  rustdoc
> X-Mailer: git-send-email 2.52.0
> 
> Work around rustdoc issue that panics while trying to evaluate
> the constants.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/core/src/qdev.rs      | 1 +
>  rust/migration/src/vmstate.rs | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


