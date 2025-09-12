Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DC9CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwyxU-0006c4-Lf; Fri, 12 Sep 2025 04:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwyxP-0006aU-J0
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:16:38 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwyxH-0001UY-Sf
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757664988; x=1789200988;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=jQm2DA276IETVuFo79Qq1BobD0zVfi+JS+CYUR6ofRw=;
 b=h9atiBksdTjYGCI9Y1ZGMTQLKvqJMCTtw0P3fdrlmablTUhLUpHVBcHY
 kpyl5IpdEATaU7zJsHDouwTPKdeGT+p7wzPqHtplIVmWUIioKAqk1Msfk
 OQjiUyeXWdjCT8ia6nYlSGi/U5sH21qUW55O5bzmo7mqjMl3/wZu9kidu
 4gRaBwM5U89dnKBovYZZ9Y6AxPUkIdz0aIHaASHY4pBhBUPqzDn1FuS7R
 ir2/0NJ/1F5DrjpQ4czUswaop0N8yfTp9/LmOT4VoFLHpC61BTznSkMNb
 CksP3oq+qQf/TxhoG+uhtxknju8D6ZBgMc5gQENCll53nqgXVuybjDsYf w==;
X-CSE-ConnectionGUID: jELijk3UTf+lHbPoElM6Bw==
X-CSE-MsgGUID: VZZ/Mt8NQ2yI2aiimlDeqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="70628046"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="70628046"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 01:16:19 -0700
X-CSE-ConnectionGUID: JeE6pP6bRGOfnorz8WWwsw==
X-CSE-MsgGUID: YEABBMlwTomjODMglNY4rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="174343186"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 12 Sep 2025 01:16:17 -0700
Date: Fri, 12 Sep 2025 16:38:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 23/33] rust: split "system" crate
Message-ID: <aMPb8mLY34AFv5dr@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-24-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-24-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Sep 08, 2025 at 12:49:55PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:55 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 23/33] rust: split "system" crate
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-15-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS                             |  1 +
>  rust/qemu-api/wrapper.h                 |  3 --
>  rust/system/wrapper.h                   | 29 +++++++++++++++++
>  rust/Cargo.lock                         | 13 ++++++++
>  rust/Cargo.toml                         |  1 +
>  rust/bql/src/cell.rs                    |  5 ++-
>  rust/hw/char/pl011/Cargo.toml           |  1 +
>  rust/hw/char/pl011/meson.build          |  1 +
>  rust/hw/char/pl011/src/device.rs        |  2 +-
>  rust/hw/timer/hpet/Cargo.toml           |  1 +
>  rust/hw/timer/hpet/meson.build          |  1 +
>  rust/hw/timer/hpet/src/device.rs        | 12 +++----
>  rust/meson.build                        |  1 +
>  rust/qemu-api/Cargo.toml                |  1 +
>  rust/qemu-api/meson.build               |  7 +++--
>  rust/qemu-api/src/bindings.rs           | 14 +--------
>  rust/qemu-api/src/lib.rs                |  1 -
>  rust/qemu-api/src/sysbus.rs             |  2 +-
>  rust/system/Cargo.toml                  | 22 +++++++++++++
>  rust/system/build.rs                    |  1 +
>  rust/system/meson.build                 | 42 +++++++++++++++++++++++++
>  rust/system/src/bindings.rs             | 41 ++++++++++++++++++++++++
>  rust/system/src/lib.rs                  |  6 ++++
>  rust/{qemu-api => system}/src/memory.rs |  2 +-
>  24 files changed, 177 insertions(+), 33 deletions(-)
>  create mode 100644 rust/system/wrapper.h
>  create mode 100644 rust/system/Cargo.toml
>  create mode 120000 rust/system/build.rs
>  create mode 100644 rust/system/meson.build
>  create mode 100644 rust/system/src/bindings.rs
>  create mode 100644 rust/system/src/lib.rs
>  rename rust/{qemu-api => system}/src/memory.rs (99%)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


