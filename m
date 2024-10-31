Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48478E68972
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 10:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6SL6-0001dm-MQ; Thu, 31 Oct 2024 06:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6SL4-0001dc-Oh
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 06:23:38 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6SL1-0005jJ-Tk
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 06:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730370216; x=1761906216;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dZj8mX2sHWvJbxwOqDjN5V1LsRCVXmeEVj8nN2d88JQ=;
 b=PtOXWbPxZuIX/c/oC/4xvB1M0VLWsSw13fw42JyQC9gWFoVj2YVmfWPw
 lUhJDPI17xd7ZjdQ/1Cn6mJ2kOzYBSYI6fKTp3G6SXadBC31QSf5FrIak
 0UH0FofE9r8Fm9NUrn0+zeGa1U9wyhaCaNt2AGencFDWz+2CetU34Xchq
 U4t/+o3wvHgruKsMLW8SQbp1j5laMXIKVjpPNeFoeHBdWOiPxWd/hLaIU
 b+O2/tC7wmTUrpmIYzmnd8ZmVVz4WcrcYxeL4MABkc6TrmTIdbEK09lY3
 CJ1/o2LoHk6qtY0fofsDYN0fuRsiCga2BcWbUBG2Cs8Oy1BU20hlws1vV w==;
X-CSE-ConnectionGUID: oIEHxsARQkK2mLU5ES3oEg==
X-CSE-MsgGUID: u5kpXAjlSA27KEiWIlZfGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="30207512"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="30207512"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 03:23:33 -0700
X-CSE-ConnectionGUID: BiIlKBbmQCGXtrP6Yd4NRA==
X-CSE-MsgGUID: 3/i3vz2mT4eWRQCRPTc5uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="82707451"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 31 Oct 2024 03:23:31 -0700
Date: Thu, 31 Oct 2024 18:39:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: Re: [PATCH 11/23] rust: introduce a c_str macro
Message-ID: <ZyNed5puZOaUcj42@intel.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025160209.194307-12-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

> +#[macro_export]
> +/// Given a string constant _without_ embedded or trailing NULs, return
> +/// a CStr.
> +///
> +/// Needed for compatibility with Rust <1.77.
> +macro_rules! c_str {
> +    ($str:expr) => {{
> +        const STRING: &str = concat!($str, "\0");
> +        const BYTES: &[u8] = STRING.as_bytes();
> +
> +        // "for" is not allowed in const context... oh well,
> +        // everybody loves some lisp.  This could be turned into
> +        // a procedural macro if this is a problem; alternatively
> +        // Rust 1.72 makes CStr::from_bytes_with_nul a const function.
> +        const fn f(b: &[u8], i: usize) {
> +            if i == b.len() - 1 {
> +            } else if b[i] == 0 {
> +                panic!("c_str argument contains NUL")
> +            } else {
> +                f(b, i + 1)
> +            }
> +        }
> +        f(BYTES, 0);
> +
> +        // SAFETY: absence of NULs apart from the final byte was checked above
> +        unsafe { std::ffi::CStr::from_bytes_with_nul_unchecked(BYTES) }
> +    }};
> +}
> +

It's not worth introducing the const_for crate for the loop, and I can't
come up with a better solution. The current implementation is simple and
effective, so for now, it's the best option for me.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


