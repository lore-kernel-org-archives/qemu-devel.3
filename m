Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DB1C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 08:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcKO2-0002H7-BU; Mon, 27 Jan 2025 03:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tcKO0-0002GQ-0P; Mon, 27 Jan 2025 03:22:24 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tcKNx-0004JO-Dn; Mon, 27 Jan 2025 03:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737966142; x=1769502142;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=A6CWQx7dOOYy0iRH1Pi9Ekl4iJ390pJ2cTjmmpYgulg=;
 b=fJ2UR8bv6dcsBfc3hPoe5a5eN54qgPXo7Kyd9/FajjG8MBpczngVWxVT
 I6wR1F2iqeiHTV2D4wLpfIUWvugTJhNrgL8EA6Zsg/tDPsx32toVCsteB
 ZMY2r9mPFjvr60HWIeiEoG9lrgquDqE5cN1S7KO0TGENthTUDpqQNIUxp
 8dPJm6lMgrpwoo8jUohIaH6ZJUIrble3yD9/Nua9MwugdEIJmm8reAz3H
 Kbw325gybMXhl9bdP2WDbCmH6NPiG32cgopY30JrQ3gBW9GqXNrm/dMWB
 FL2KAnGX+JrZVLjkjuPB+5Buu6vo4sI60GqtbqePNfVgItHhgiaFAd/Re Q==;
X-CSE-ConnectionGUID: RprspQcRRTCXiS/adDzoPA==
X-CSE-MsgGUID: y7lGvBm2QPiuFHw1iGHuWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11327"; a="48921854"
X-IronPort-AV: E=Sophos;i="6.13,237,1732608000"; d="scan'208";a="48921854"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2025 00:22:18 -0800
X-CSE-ConnectionGUID: z7Ru6dXDTvOkoNZYZ4lfSw==
X-CSE-MsgGUID: GQ7IprNCRhmp7sDNhtGyjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,237,1732608000"; d="scan'208";a="108179328"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 27 Jan 2025 00:22:16 -0800
Date: Mon, 27 Jan 2025 16:41:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 04/10] rust: callbacks: allow passing optional callbacks
 as ()
Message-ID: <Z5dGxClUIceaTRaO@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117194003.1173231-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Date: Fri, 17 Jan 2025 20:39:57 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 04/10] rust: callbacks: allow passing optional callbacks as
>  ()
> X-Mailer: git-send-email 2.47.1
> 
> In some cases, callbacks are optional.  Using "Some(function)" and "None"
> does not work well, because when someone writes "None" the compiler does
> not know what to use for "F" in "Option<F>".
> 
> Therefore, adopt () to mean a "null" callback.  It is possible to enforce
> that a callback is valid by adding a "let _: () = F::ASSERT_IS_SOME" before
> the invocation of F::call.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/callbacks.rs | 97 ++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)

Awesome trick.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> +    /// Referring to this constant asserts that the `Self` type is an actual
> +    /// function type, which can be used to catch incorrect use of `()`
> +    /// at  compile time.

An extra whitespace.


