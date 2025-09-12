Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F51DCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwzGg-0000XO-DN; Fri, 12 Sep 2025 04:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwzGS-0000CI-PQ
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:36:17 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwzGF-0005Dq-O6
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757666164; x=1789202164;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=8SL6GoKfIhyZd278iUOuxFCX4INIyw15lWQYJ8KrqPk=;
 b=aND2cJXXdRGiz6NTtj7n88LrRXetsmUAGDxeV6v57UxERsLq/08rqI02
 jRmwEic5F+3HXXjuoLVIixWYtm0fa4grYPvDWAFhBj7hk2fvHLuPu8WBt
 4kPgcFjeCjXEkkWJO+vEULsqt8g/i2qGUTRh1MOOS+nI05+EhwgfGKVHY
 rF5uLj81bxfcFHvqohDQ6TGPqmI1XpPa75pEJSM80YXpOSoY2XRQqe0er
 PLoPt0zw7NvhJf2WJqxT0z/igOXUykrbkQmbexlRzhDEgi2UIS4hR46LS
 RXi11ij94ylq5hl+ejNMbcleySbmd8DQHu4teQAAHqNeyGEhy1IBuHYKO A==;
X-CSE-ConnectionGUID: J5cHIixUQdW52s8FruQGuA==
X-CSE-MsgGUID: 45oaVTyVQAeeLxhm7IZ5aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="70262185"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="70262185"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 01:35:43 -0700
X-CSE-ConnectionGUID: L26maXTiSM+1BdBpyxttLg==
X-CSE-MsgGUID: El0DyOrfSyq4uzn0zXpeNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="204909272"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 12 Sep 2025 01:35:42 -0700
Date: Fri, 12 Sep 2025 16:57:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 28/33] rust: repurpose qemu_api -> tests
Message-ID: <aMPgf0/rZYWQvG0t@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-29-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-29-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Sep 08, 2025 at 12:50:00PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:50:00 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 28/33] rust: repurpose qemu_api -> tests
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The crate purpose is only to provide integration tests at this point,
> that can't easily be moved to a specific crate.
> 
> It's also often a good practice to have a single integration test crate
> (see for ex https://github.com/rust-lang/cargo/issues/4867)

Good reference material!

> Drop README.md, use docs/devel/rust.rst instead.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-20-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS                                   |  2 +-
>  rust/qemu-api/wrapper.h                       | 53 -------------
>  rust/Cargo.lock                               | 30 ++++----
>  rust/Cargo.toml                               |  2 +-
>  rust/meson.build                              |  4 +-
>  rust/qemu-api/.gitignore                      |  2 -
>  rust/qemu-api/README.md                       | 19 -----
>  rust/qemu-api/build.rs                        |  1 -
>  rust/qemu-api/meson.build                     | 75 -------------------
>  rust/qemu-api/src/bindings.rs                 | 33 --------
>  rust/qemu-api/src/lib.rs                      | 18 -----
>  rust/qemu-api/src/prelude.rs                  |  5 --
>  rust/{qemu-api => tests}/Cargo.toml           |  7 +-
>  rust/tests/meson.build                        | 14 ++++
>  .../tests/vmstate_tests.rs                    |  0
>  15 files changed, 35 insertions(+), 230 deletions(-)
>  delete mode 100644 rust/qemu-api/wrapper.h
>  delete mode 100644 rust/qemu-api/.gitignore
>  delete mode 100644 rust/qemu-api/README.md
>  delete mode 120000 rust/qemu-api/build.rs
>  delete mode 100644 rust/qemu-api/meson.build
>  delete mode 100644 rust/qemu-api/src/bindings.rs
>  delete mode 100644 rust/qemu-api/src/lib.rs
>  delete mode 100644 rust/qemu-api/src/prelude.rs
>  rename rust/{qemu-api => tests}/Cargo.toml (78%)
>  create mode 100644 rust/tests/meson.build
>  rename rust/{qemu-api => tests}/tests/vmstate_tests.rs (100%)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


