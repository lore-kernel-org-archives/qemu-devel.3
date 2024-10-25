Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAECD0C5E6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 09:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4GBl-00087j-RP; Fri, 25 Oct 2024 05:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t4GBk-00087K-Np
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:00:56 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t4GBi-0006nx-44
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729846854; x=1761382854;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=c0QQ8g61bxMXaaZZ4l90yw1V8kdF6DShClTArY7IdnA=;
 b=VgErU5eib/nC0FqVE5jLuRboym/q+y/OEARyt0jh0IKU+Y+xfZzQ7WoW
 m5XUeOYuL7F/csNYx6kniR5kxSnpQUPgQRv/zIW/b3WvZYcIxozmNZrF8
 UFONn+bTL5ymVTIxrVSXXIGAg32hJVhXcnjcIyB3QkizuM0ZPf59+SwmJ
 7KGmlI1pJbRblNwykEOHAM3Tytg+bhTWpVEtZfv30m5VlCZLm8dAyaR3u
 eGwbqRnLQmYzlEMvmfr4eGiDDSHxeL+s8UBgyC4fmyfRH2YCAbkGiV4ka
 estm/wM5g/DQ4dRVcAbrQ3ZNqoaLBTDQPhylHHJ1srBaOW27fcTzCgHly Q==;
X-CSE-ConnectionGUID: I36uDbvRSh6bxU3+7X9qtw==
X-CSE-MsgGUID: 2duvOm8dSzaagTVu73WqeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52064441"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="52064441"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2024 02:00:52 -0700
X-CSE-ConnectionGUID: LcDkDpjFTs+4eIERXoH4xA==
X-CSE-MsgGUID: nzAP4tcNR7eRqD0Hw/sE8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; d="scan'208";a="85439751"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 25 Oct 2024 02:00:50 -0700
Date: Fri, 25 Oct 2024 17:17:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH v2 09/13] rust: clean up define_property macro
Message-ID: <ZxtiE63/pf80umxa@intel.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021163538.136941-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

On Mon, Oct 21, 2024 at 06:35:34PM +0200, Paolo Bonzini wrote:
> Date: Mon, 21 Oct 2024 18:35:34 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 09/13] rust: clean up define_property macro
> X-Mailer: git-send-email 2.46.2
> 
> Use the "struct update" syntax to initialize most of the fields to zero,
> and simplify the handmade type-checking of $name.
> 
> Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/device_class.rs | 29 ++++++-----------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


