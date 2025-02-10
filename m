Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66579C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUWf-0007Fz-8s; Mon, 10 Feb 2025 09:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thUWS-0007Dk-9j; Mon, 10 Feb 2025 09:12:33 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thUWP-00053L-Pz; Mon, 10 Feb 2025 09:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739196746; x=1770732746;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8bZA4Uzy6BHrko0L1T3EoFFplZmi9GTEN8JhOqR3zYU=;
 b=e82qb/KmSuXkrrBlW+yFUG+LRt27XPGz6dNqZ00hv7g0hJGANxdqTbCV
 2jvaQ5qYihs9Dolr7OWEUU4SbZl74sb8Mxy8e0Sm4fdB0JLaPyRQwbfF6
 3sF1kBzD+cDNaLMvCnjpca1emNLtjJT1TENdrzHeJUHlxN5GDnCE60sPg
 +kLWgcKkZfNWqEniaKQrva9GryeBPDia9K8DtT7XmV3WryeQtYq/t7E+t
 /5it2wK8nphIXm1UkVsG8QvU3rRSP0WFnC9qm4NfBARIqovW42n1Izm8Y
 Wyj7YSeVSrodL1SvYJCF6+VfOohhUA76z+qJLuGBA58zDRsookRmkk48v A==;
X-CSE-ConnectionGUID: jvV2+jdOTTebMX9VSx2R8A==
X-CSE-MsgGUID: INcyIQrMShunGQyw0h3TZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="62252958"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="62252958"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 06:12:23 -0800
X-CSE-ConnectionGUID: IlnqHOzYRIu5mZ+/IPaQ8A==
X-CSE-MsgGUID: KXqy4DV0Ri+lLXY1XEY54Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="112039099"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 10 Feb 2025 06:12:21 -0800
Date: Mon, 10 Feb 2025 22:31:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/12] rust: callbacks: allow passing optional callbacks
 as ()
Message-ID: <Z6oN2KMfyMcmiZWD@intel.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
 <20250207101623.2443552-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207101623.2443552-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
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

On Fri, Feb 07, 2025 at 11:16:14AM +0100, Paolo Bonzini wrote:
> Date: Fri,  7 Feb 2025 11:16:14 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/12] rust: callbacks: allow passing optional callbacks as
>  ()
> X-Mailer: git-send-email 2.48.1
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
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


