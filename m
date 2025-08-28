Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A7FCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 06:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urWRQ-0007Ct-6D; Thu, 28 Aug 2025 02:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urWRL-0007CE-QW; Thu, 28 Aug 2025 02:48:56 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urWRJ-0007Xv-GB; Thu, 28 Aug 2025 02:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756363733; x=1787899733;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=yk3A0mXtLjuj3HnAv21ZrBNCwVMg/mTxBC9PX/iOGL4=;
 b=XrzmhoqU5IlLaubeKSgb3pxdRaTUlUafnkrOUpGST9p7Ee4I+lc4gW/e
 ZJilQT3smOK6NFicVAuf2w4aRt4Pqh3U1F9ugMkZ/esDijLYJwFdSlzjF
 n/GwlkP3nxtaDP9hARY9PBNpdXnT9BXGiUagVufOUCvu9cShxrQX42IRt
 BL0VmPuAWSfKSt13LKCc2eaIPxHC19ts1laHd9lRtT7NbEwheosRtPw/3
 kWc0B2O6KQJbPuM5SaDXkjGsb57izpI8li9NAMN6x9xDr3/MpZgHYuu9z
 0InEwhU4wrGaLtUUxt409MmweK3FyJWvTxwHPbOi4MlTEWGxzjgAnCtsQ w==;
X-CSE-ConnectionGUID: TEjJxZD7QmaNZpUGGQDZ0A==
X-CSE-MsgGUID: 7YyPpllVSpGvLmDufdwfSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="62267440"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="62267440"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 23:48:49 -0700
X-CSE-ConnectionGUID: Ok1WvA29QAmUdf/9Zh7MpQ==
X-CSE-MsgGUID: pJAaFlAHRZOaRfQ7/SWg3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="207183164"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 27 Aug 2025 23:48:47 -0700
Date: Thu, 28 Aug 2025 15:10:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 pbonzini@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 06/22] rust: split "util" crate
Message-ID: <aLAA6ophs8N4OFr+@intel.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
 <20250827104147.717203-7-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827104147.717203-7-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

On Wed, Aug 27, 2025 at 02:41:28PM +0400, marcandre.lureau@redhat.com wrote:
> Date: Wed, 27 Aug 2025 14:41:28 +0400
> From: marcandre.lureau@redhat.com
> Subject: [PATCH 06/22] rust: split "util" crate
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---

...

> diff --git a/rust/common/src/errno.rs b/rust/common/src/errno.rs
> index b48247b947..a7b23b4092 100644
> --- a/rust/common/src/errno.rs
> +++ b/rust/common/src/errno.rs
> @@ -240,7 +240,7 @@ pub fn into_neg_errno<T: MergeErrno, E: Into<Errno>>(value: Result<T, E>) -> T::
>  mod tests {
>      use std::io::ErrorKind;
>  
> -    use common::assert_match;
> +    use bindings::assert_match;

typo?

>      use super::*;
>  

...

> diff --git a/rust/qemu-api/src/error.rs b/rust/util/src/error.rs
> similarity index 98%
> rename from rust/qemu-api/src/error.rs
> rename to rust/util/src/error.rs
> index 8bac3cbec8..a1b11a97ca 100644
> --- a/rust/qemu-api/src/error.rs
> +++ b/rust/util/src/error.rs
> @@ -19,7 +19,7 @@
>  //!
>  //! This module is most commonly used at the boundary between C and Rust code;
>  //! other code will usually access it through the
> -//! [`qemu_api::Result`](crate::Result) type alias, and will use the
> +//! [`utils::Result`](crate::Result) type alias, and will use the
>  //! [`std::error::Error`] interface to let C errors participate in Rust's error
>  //! handling functionality.
>  //!
> @@ -30,7 +30,7 @@
>  //! type up to C code, or from a combination of the two.
>  //!
>  //! The third case, corresponding to [`Error::with_error`], is the only one that
> -//! requires mentioning [`qemu_api::Error`](crate::Error) explicitly.  Similar
> +//! requires mentioning [`utils::Error`](crate::Error) explicitly.  Similar
>  //! to how QEMU's C code handles errno values, the string and the
>  //! `anyhow::Error` object will be concatenated with `:` as the separator.
>  
> @@ -316,11 +316,10 @@ mod tests {
>      use std::ffi::CStr;
>  
>      use anyhow::anyhow;
> -    use common::assert_match;
> +    use bindings::assert_match;

typo?

With fixed,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


