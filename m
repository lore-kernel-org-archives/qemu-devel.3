Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36582C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 09:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQLH-0002O4-9q; Mon, 10 Feb 2025 04:44:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thQL6-0002NE-06; Mon, 10 Feb 2025 04:44:28 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thQL3-0002dr-VU; Mon, 10 Feb 2025 04:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739180666; x=1770716666;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=LrWzIYf7y4/tzTfRA1osd44qwzihUCBfoi+HSgPZkLc=;
 b=VY8som25rNvOonlPbVxMQR5atwLW4GWycbFLO9dqz53RHkijeWCgaFyD
 bIdmkFk2+LcavnuX0BNl5RjG62v7aqJDUoQRpSnGgCHA1HdlSqHl3Ghq5
 7UZU8YmvPbWcok2cj9+5k3ZAdZ5UTv27trBxXJCRfj8JVpv4GePMfVv/6
 G1E9XbAnFBEfyZEYFOcb9MWVcAvV94e3jwkhNGAINRkRrBisb/X4pveP2
 Lboq+esLYUOh914a+jskPSJe66HSMLm2OYOHKAFAKckP/R1p0efgIApUc
 3BdWXlK76PU2v6O1SPoKV9EcMQEUuLlYCPw6b8PidY9wx2vkU9XQn14X5 Q==;
X-CSE-ConnectionGUID: mpYzJrJwTD2fQnLiZgzwQA==
X-CSE-MsgGUID: QfWFVGt+QBqFZy6WX4PzCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39881016"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="39881016"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 01:44:22 -0800
X-CSE-ConnectionGUID: G3DjMSK/RKWE397kxvRIkg==
X-CSE-MsgGUID: Eym+uQp0T3ax1hBUhRE1Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116734597"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 10 Feb 2025 01:44:20 -0800
Date: Mon, 10 Feb 2025 18:03:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 05/10] rust: add bindings for memattrs
Message-ID: <Z6nPB8Pc70rccXNU@intel.com>
References: <20250210030051.2562726-1-zhao1.liu@intel.com>
 <20250210030051.2562726-6-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210030051.2562726-6-zhao1.liu@intel.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
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

> +/// A special `MemTxAttrs` constant, used to indicate that no memary

typo... s/memary/memory/

> +/// attributes are specified.
> +///
> +/// Bus masters which don't specify any attributes will get this,
> +/// which has all attribute bits clear except the topmost one
> +/// (so that we can distinguish "all attributes deliberately clear"
> +/// from "didn't specify" if necessary).
> +pub const MEMTXATTRS_UNSPECIFIED: MemTxAttrs = MemTxAttrs {
> +    unspecified: true,
> +    ..Zeroable::ZERO
> +};

