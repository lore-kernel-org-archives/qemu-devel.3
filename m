Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FBECAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13se-0004BN-Kh; Tue, 23 Sep 2025 10:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v13sY-0004Af-Gw; Tue, 23 Sep 2025 10:20:26 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v13sW-00008y-LE; Tue, 23 Sep 2025 10:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758637224; x=1790173224;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ITBM+hMk3c8l02OaHOmHO4xclWEMj7F82su987zSES0=;
 b=SfF7xDZB3aSMV+sogZfuRb4iYddDiZ2MuTf5alyrVaCwq9uOo4xANW//
 r2MwM3tU5jW8Sq++CJGuv9IoXlkbArLStcV1MatwgKasvDO/BAiFQl/R7
 qOh3C+/jlrCCGgIm+teXjIOmNXhyQzv51O7rBT043AOJeI/UEDLHN8GtI
 zX1oiKhSCfEsfte6TbbUBSEVkVdtQY3HnllseAEfXxpyaGgfCWJqEuKBy
 Mzb69lw3XXopf0rBiouexwH9IOSrei64p+maBhdYzsuymYY330I3fpU2j
 dxMkfo5jO5jCtU9TKlbBHiFOhM+mk2IdHZ3CVHmfXlMh5jye8LmMK+jN+ Q==;
X-CSE-ConnectionGUID: Ro4DtQulSBmz4WasrtoZjA==
X-CSE-MsgGUID: iDRkEtMXRJSMlTFNX+xAZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="86356328"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="86356328"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 07:20:14 -0700
X-CSE-ConnectionGUID: DtpuKLCMQsGKW221u0H2HA==
X-CSE-MsgGUID: BqJkGfBcQTyieRJIow88ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="176371456"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 23 Sep 2025 07:20:13 -0700
Date: Tue, 23 Sep 2025 22:42:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: build: remove "protocol: rust: from doctests
Message-ID: <aNKxwqw1dVOIP88U@intel.com>
References: <20250919101642.121190-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919101642.121190-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Fri, Sep 19, 2025 at 12:16:42PM +0200, Paolo Bonzini wrote:
> Date: Fri, 19 Sep 2025 12:16:42 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] rust: build: remove "protocol: rust: from doctests
> 
> It is added already by rust.doctest.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/bql/meson.build       | 1 -
>  rust/common/meson.build    | 1 -
>  rust/migration/meson.build | 1 -
>  rust/qom/meson.build       | 1 -
>  rust/util/meson.build      | 1 -
>  5 files changed, 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


