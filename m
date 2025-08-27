Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22CCCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 14:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHcI-0000H2-Eu; Wed, 27 Aug 2025 10:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urHcG-0000GA-OW; Wed, 27 Aug 2025 10:59:13 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urHcE-0003xk-Tv; Wed, 27 Aug 2025 10:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756306752; x=1787842752;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=sMfQvAzQJILc1q4t6dp+HRnBN19H6kuEgUBH+TWMMpI=;
 b=a07oTnel4Z05jUJBR7Y6zIhvV5uerYz+QAF4JtLO1oNL+D6q1jEEhG+E
 OfogiEV2u2BRYEJ6XRbLL8GmySVWt7h5pozUEowuj/Zie/rbNjiVAloII
 ZG0m5AF3K6NqCUXQiTX4R18NtWEl5A6MePi6TyDa/mRQP67Y6QebLlkkE
 leL7coafExKevt2rtOfTLOPlJV8XHVVyjpFFdC1RTWShvhrq4AEhLfXq6
 PgNTfJJ6E2nuueYskpnJBw5HPNbzyqCnyuxC68bs7nwgtm7gDGzdJLQ48
 xIC6qqLzq/LiXwkSOuwCzoYLjrPBifuj5ovU7jItQOm+omvCugUOJhsrj w==;
X-CSE-ConnectionGUID: C+OYgAN7QYSJA5nkUk0f8g==
X-CSE-MsgGUID: j2Rcg55JTDGdrMTXvXeWaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="76010512"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="76010512"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 07:59:08 -0700
X-CSE-ConnectionGUID: VqV8Pg+/Q621rNqjsBje6w==
X-CSE-MsgGUID: /X7jZCHJQDyopAcpdnNYtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169111490"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 27 Aug 2025 07:59:05 -0700
Date: Wed, 27 Aug 2025 23:20:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 pbonzini@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 05/22] rust: split Rust-only "common" crate
Message-ID: <aK8iVBVe8NgGnmm1@intel.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
 <20250827104147.717203-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827104147.717203-6-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

On Wed, Aug 27, 2025 at 02:41:27PM +0400, marcandre.lureau@redhat.com wrote:
> Date: Wed, 27 Aug 2025 14:41:27 +0400
> From: marcandre.lureau@redhat.com
> Subject: [PATCH 05/22] rust: split Rust-only "common" crate
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---

...

> diff --git a/rust/common/Cargo.toml b/rust/common/Cargo.toml
> new file mode 100644
> index 0000000000..5e106427e8
> --- /dev/null
> +++ b/rust/common/Cargo.toml
> @@ -0,0 +1,19 @@
> +[package]
> +name = "common"
> +version = "0.1.0"
> +description = "Rust common code for QEMU"

Meybe "Rust-only common code for QEMU"

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


