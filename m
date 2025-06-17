Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF21C7115B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYLA-0005uY-4v; Tue, 17 Jun 2025 11:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uRYIo-0001i2-WE; Tue, 17 Jun 2025 11:32:47 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uRXLp-0001xX-S3; Tue, 17 Jun 2025 10:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750170709; x=1781706709;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DkReQpwCoxqQOKISDTYaZWJaqR4gFM3v6pz8O+TUqHo=;
 b=I6wgKyEMmOlBjYyc7+rrjHKLKojUbkk4NJl7sR4R4F/ZnDJnxNh4cCg9
 0OfpHsVmLSV4JS//ZBBdrdAbNxgHVv/e4727nMtIecz23iwjGiUKDHPgV
 TnOOH0tJjpaONq9V3CbMwJQOUWdG4onVF4hpSvK1nA2V2F9hm6WNh1Cmf
 cT4evpayXcT5s+r5K9ibNCkhBGV62FFWe/10elCCcSD/CdYV3e9Ya/0tW
 G26edhLozgmtarc8RkUOhJF9rIpjpDEIO4seVjP9uRaT8OmL1Lsqe6NBz
 w0fIYuQreqipW/Drz/d8xZiT9xqTkjofq0lsVkTclhv7U6K3UmMqwvfWJ w==;
X-CSE-ConnectionGUID: ruoe2seEToeZpo+QZoS8JA==
X-CSE-MsgGUID: AT4KVbhBRy+dy/qGdP3mFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="77753891"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="77753891"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 07:31:39 -0700
X-CSE-ConnectionGUID: lzTEqJILQCSuSVNYxtN2fQ==
X-CSE-MsgGUID: 3/XRiIIzTLCIX72XcY43YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="149690016"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 17 Jun 2025 07:31:37 -0700
Date: Tue, 17 Jun 2025 22:52:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, stefanha@redhat.com
Subject: Re: [PATCH] rust: hpet: fix new warning
Message-ID: <aFGBSJ2Fdpt/eaLq@intel.com>
References: <20250617081038.115099-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617081038.115099-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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

On Tue, Jun 17, 2025 at 10:10:38AM +0200, Paolo Bonzini wrote:
> Date: Tue, 17 Jun 2025 10:10:38 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] rust: hpet: fix new warning
> X-Mailer: git-send-email 2.49.0
> 
> Nightly rustc complains that HPETAddrDecode has a lifetime but it is not
> clearly noted that it comes from &self.  Apply the compiler's suggestion
> to shut it up.
> 
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/timer/hpet/src/device.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


