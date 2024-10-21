Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65409D0E6D3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2o7r-0004tn-MI; Mon, 21 Oct 2024 04:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2o7p-0004td-Gm
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:50:53 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2o7m-0006sl-28
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729500650; x=1761036650;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VqvgbKpK0ZXTqjdy6W4xM0uYDi6p+P3JYiKX4cX9a4Y=;
 b=eG3CVIRR7r17v8LhEgPMRAUXV4I4CYY4o5bnrMvJGVTvaYtO34FgobPQ
 hqSy1hBQHTNHLg0/qINlonZ1vqQ+ox5Luf44HKlMKc4op2cQKrkAKsjne
 szi572SeCSIV0j01aJPEEjm0fPF8KiZa1ao0i7xp4YOJfIL1XwyW1gPzE
 mO63fOUcVmvb60uFVZG30Ja9DbFw/l7cfgJKNtG1ESYG5o4udgy01GJud
 s2fEGPfRMIp2xt/hcbGSPhQJpGO+VfS2MrIQFywLXmVvqBgVatMwmWAFS
 IU8ZxngMkMP8euTN4qvIHrPY93lPw3k/yJynpAb6jgLvwngh9ha5o5+Kb Q==;
X-CSE-ConnectionGUID: TxcQ5wBnRQKwaIErlK9IwA==
X-CSE-MsgGUID: smOeWRnNRmWbGKx9igYBKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29089590"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29089590"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2024 01:50:46 -0700
X-CSE-ConnectionGUID: QipNsdAbR8qBfjXmdvTEhg==
X-CSE-MsgGUID: YafKmUwFRfa7AaJyCQJTzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; d="scan'208";a="79105527"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 21 Oct 2024 01:50:44 -0700
Date: Mon, 21 Oct 2024 17:07:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 08/16] rust: build tests for the qemu_api crate
Message-ID: <ZxYZtTtZbDRfxuQk@intel.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015131735.518771-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
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

On Tue, Oct 15, 2024 at 03:17:26PM +0200, Paolo Bonzini wrote:
> Date: Tue, 15 Oct 2024 15:17:26 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 08/16] rust: build tests for the qemu_api crate
> X-Mailer: git-send-email 2.46.2
> 
> Fix some bitrot in tests.rs, and allow the unit tests to be run via
> "meson test".
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/meson.build  | 3 +++
>  rust/qemu-api/src/tests.rs | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> index 42ea815fa5a..436e2f1e836 100644
> --- a/rust/qemu-api/meson.build
> +++ b/rust/qemu-api/meson.build
> @@ -5,6 +5,7 @@ _qemu_api_rs = static_library(
>        'src/lib.rs',
>        'src/definitions.rs',
>        'src/device_class.rs',
> +      'src/tests.rs',
>      ],
>      {'.' : bindings_rs},
>    ),
> @@ -19,6 +20,8 @@ _qemu_api_rs = static_library(
>    ],
>  )
>  
> +rust.test('rust-qemu-api-tests', _qemu_api_rs)
> +

It seems the change will bring a warning for "./configure --enable-rust":

WARNING: Unknown keyword argument(s) in target rust-qemu-api-tests: rust_abi, prelink, pic.

 

