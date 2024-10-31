Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B499ED74959
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 13:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6VGF-0003LU-8f; Thu, 31 Oct 2024 09:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6VGB-0003Kx-PB
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 09:30:48 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6VG9-0007AC-4E
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 09:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730381446; x=1761917446;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nv2P7qx0B3oRyf/4Rdy3YFjcM46Soe3nMtcpyr6Byfc=;
 b=FRn86GUjL1tpHlbuMUbRwCVmD8fCkPZaT8wDPcb2gur9VIVFbUWUhnQT
 fUFuV/Ddo0uZgWaL6zuiioFuVf1+mjuyX2ReUPbn3GsPGl/dztz/uBGU+
 kBl8z9XJRAskY9eyQu61wIzpRUOmVA4VBMaxnAMXc8+TurAWcatyEa08N
 IjtW+2vv8a5YkaTqmuWzm5XBXEfiWtxdex0EJQCbwEwMS8/SToh0Luhp4
 /2EfSr6kvxt43eHJRDjbklraNz2V9F+BDa2h971uX7rT0hGQDxBXxED42
 n7pAtW/pnuml1Mrg/4romoIiwcZPSEy9eaWjZ+x4XlB5TRYL5M4JKikYy Q==;
X-CSE-ConnectionGUID: x8pS6JiPTh2c72qREe9P5w==
X-CSE-MsgGUID: nLU1OivzQRa65vPIvjffZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40664560"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="40664560"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 06:30:40 -0700
X-CSE-ConnectionGUID: gdOXPXoyTvufR+tti1qtKA==
X-CSE-MsgGUID: bfWGcOgcQAuBWA15cv6SAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="87761478"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 31 Oct 2024 06:30:37 -0700
Date: Thu, 31 Oct 2024 21:46:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: Re: [PATCH 14/23] rust: create a cargo workspace
Message-ID: <ZyOKUbbgniBRSlW3@intel.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-15-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025160209.194307-15-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Fri, Oct 25, 2024 at 06:01:59PM +0200, Paolo Bonzini wrote:
> Date: Fri, 25 Oct 2024 18:01:59 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 14/23] rust: create a cargo workspace
> X-Mailer: git-send-email 2.47.0
> 
> Workspaces allows tracking dependencies for multiple crates at once,
> by having a single Cargo.lock file at the top of the rust/ tree.
> Because QEMU's Cargo.lock files have to be synchronized with the versions
> of crates in subprojects/, using a workspace avoids the need to copy
> over the Cargo.lock file when adding a new device (and thus a new crate)
> under rust/hw/.
> 
> In addition, workspaces let cargo download and build dependencies just
> once.  While right now we have one leaf crate (hw/char/pl011), this
> will not be the case once more devices are added.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/{hw/char/pl011 => }/Cargo.lock |  0
>  rust/Cargo.toml                     |  7 ++++
>  rust/hw/char/pl011/Cargo.toml       |  3 --
>  rust/qemu-api-macros/Cargo.lock     | 48 -------------------------
>  rust/qemu-api-macros/Cargo.toml     |  3 --
>  rust/qemu-api/Cargo.lock            | 54 -----------------------------
>  rust/qemu-api/Cargo.toml            |  3 --
>  7 files changed, 7 insertions(+), 111 deletions(-)
>  rename rust/{hw/char/pl011 => }/Cargo.lock (100%)
>  create mode 100644 rust/Cargo.toml
>  delete mode 100644 rust/qemu-api-macros/Cargo.lock
>  delete mode 100644 rust/qemu-api/Cargo.lock
 
Workspace is a good idea and "cargo build" works fine on my side.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


