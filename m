Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406B0D30019
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1p4I-0001ip-Lz; Fri, 18 Oct 2024 11:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1p4D-0001ad-MQ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:39:05 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1p49-0000UT-QY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729265942; x=1760801942;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GwmZO2yTE0HlvRQDKxXlG0S/PHmepUUMltt+SvxZdOg=;
 b=GUHUqJpWe4XDd11EKaUZKOxlN8rUIGLu1OR/XMXL8mGsBdgeW/B/+sd1
 UZQeJXd33qPNuaNGRpYtBwMcflM0Oldc9oCgd5xQZKEjF4FFoX9vakj9q
 pHDuh614sT0JEjgpCfdlFPyWtg9eAh6HXpho8VPTgKxAJ4/y+hYbk+xGp
 VmrZmqmIODd8Kwef2eUj9TzyxJE9xr262KE3FCiFRMd2466FuDWb1WSoo
 qifE4M23TKDar24umrqOtJ3yf6IUfE4JaYenPyjOsDi2lrbKoRPucqwWU
 DJ1jbEjU4vV7Rx+yjOP0sjdDDbITd5OcmmmUDvHI+KAknA0XX36yvH1Xs A==;
X-CSE-ConnectionGUID: JvIEIgDPSVOsoUOqZyOc6A==
X-CSE-MsgGUID: pNRk9Rd8Sc6CYGWxIuIavA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39345699"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="39345699"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 08:39:00 -0700
X-CSE-ConnectionGUID: HVFmqqryQZKqucqd7brDVg==
X-CSE-MsgGUID: rNLgTtW+QxeUHBkQq5lfwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; d="scan'208";a="79243723"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 18 Oct 2024 08:38:58 -0700
Date: Fri, 18 Oct 2024 23:55:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 04/16] rust: patch bilge-impl to allow compilation with
 1.63.0
Message-ID: <ZxKE4iRE0TA4P5Ja@intel.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015131735.518771-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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

On Tue, Oct 15, 2024 at 03:17:22PM +0200, Paolo Bonzini wrote:
> Date: Tue, 15 Oct 2024 15:17:22 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 04/16] rust: patch bilge-impl to allow compilation with
>  1.63.0
> X-Mailer: git-send-email 2.46.2
> 
> Apply a patch that removes "let ... else" constructs, replacing them with
> "if let ... else" or "let ... = match ...".  "let ... else" was stabilized in
> Rust 1.65.0.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .gitattributes                                |  2 +
>  subprojects/bilge-impl-0.2-rs.wrap            |  1 +
>  .../packagefiles/bilge-impl-1.63.0.patch      | 45 +++++++++++++++++++
>  3 files changed, 48 insertions(+)
>  create mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


