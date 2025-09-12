Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94A0CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwyqT-0003u3-02; Fri, 12 Sep 2025 04:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwyqP-0003t9-N5
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:09:22 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwyqK-0008TW-UT
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757664556; x=1789200556;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=fMgkQiXY7Jt6Nt1rrTnaC/uQn+hVzE2j3XJTpaXtgxY=;
 b=K4QpXm/QQMQXMaq7XWtqxey+wtPkj8B2dNJ3WzxkyFRRu+z4507GRAFK
 TS5jwiQ0L/jIgWp7t0D6Ue4m+SM4ZM6orGfnUP1NGiOc/SjQfY3k+qyNi
 BBzrOFdoYPz5As8A7nf+MsU+jc2cUsx4+jEAiohSSFMUZ3pVR2b7NpeIv
 VMmUutVAXO1k2V4I6mDzeEL8uerhPxi6HD8KJQkCMY+CD71cXck2ayOIk
 nADzOgvP3KSuqNtCoQxpucqwvHNKnvC7EUulsGixKS2ehFq/CgF+zDcZe
 r7j486iqmyE2XSeL1dzOzBj7HrnyqZLHuOezGqV9FNo4vB5ZfUJpXhrHX A==;
X-CSE-ConnectionGUID: 9a40xbwdSDO9rDluYxad3A==
X-CSE-MsgGUID: MACHznZQTBys5SG/CjbkAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="71381290"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="71381290"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 01:09:10 -0700
X-CSE-ConnectionGUID: 92DS6rEoQ9uUyKseBfrk0g==
X-CSE-MsgGUID: u64ghiitQcGkuTP9mn2OpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="173202968"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 12 Sep 2025 01:09:08 -0700
Date: Fri, 12 Sep 2025 16:31:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 20/33] rust: split "bql" crate
Message-ID: <aMPaRWk+oJN7n/Ug@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-21-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-21-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:49:52PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:52 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 20/33] rust: split "bql" crate
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Unfortunately, an example had to be compile-time disabled, since it
> relies on higher level crates (qdev, irq etc). The alternative is
> probably to move that code to an example in qemu-api or elsewere and
> make a link to it, or include_str.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-12-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS                          |  1 +
>  rust/bql/wrapper.h                   | 27 ++++++++
>  rust/Cargo.lock                      | 10 +++
>  rust/Cargo.toml                      |  1 +
>  rust/bql/Cargo.toml                  | 23 +++++++
>  rust/bql/build.rs                    |  1 +
>  rust/bql/meson.build                 | 52 ++++++++++++++++
>  rust/bql/src/bindings.rs             | 25 ++++++++
>  rust/{qemu-api => bql}/src/cell.rs   | 92 ++++++++++------------------
>  rust/bql/src/lib.rs                  | 29 +++++++++
>  rust/common/src/opaque.rs            |  4 +-
>  rust/hw/char/pl011/Cargo.toml        |  1 +
>  rust/hw/char/pl011/meson.build       |  1 +
>  rust/hw/char/pl011/src/device.rs     |  1 +
>  rust/hw/timer/hpet/Cargo.toml        |  1 +
>  rust/hw/timer/hpet/meson.build       |  1 +
>  rust/hw/timer/hpet/src/device.rs     |  2 +-
>  rust/hw/timer/hpet/src/fw_cfg.rs     |  5 +-
>  rust/meson.build                     |  1 +
>  rust/migration/src/vmstate.rs        |  4 +-
>  rust/qemu-api/Cargo.toml             |  5 +-
>  rust/qemu-api/meson.build            | 18 +-----
>  rust/qemu-api/src/chardev.rs         | 17 +++--
>  rust/qemu-api/src/irq.rs             |  1 +
>  rust/qemu-api/src/lib.rs             |  1 -
>  rust/qemu-api/src/prelude.rs         |  3 -
>  rust/qemu-api/src/qdev.rs            |  5 +-
>  rust/qemu-api/src/qom.rs             | 13 ++--
>  rust/qemu-api/src/sysbus.rs          | 13 ++--
>  rust/qemu-api/tests/tests.rs         |  4 +-
>  rust/qemu-api/tests/vmstate_tests.rs |  2 +-
>  31 files changed, 244 insertions(+), 120 deletions(-)
>  create mode 100644 rust/bql/wrapper.h
>  create mode 100644 rust/bql/Cargo.toml
>  create mode 120000 rust/bql/build.rs
>  create mode 100644 rust/bql/meson.build
>  create mode 100644 rust/bql/src/bindings.rs
>  rename rust/{qemu-api => bql}/src/cell.rs (92%)
>  create mode 100644 rust/bql/src/lib.rs

...

> diff --git a/rust/Cargo.lock b/rust/Cargo.lock
> index 048dd74757f..73ca9582a56 100644
> --- a/rust/Cargo.lock
> +++ b/rust/Cargo.lock
> @@ -44,6 +44,13 @@ dependencies = [
>   "qemu_api_macros",
>  ]
>  
> +[[package]]
> +name = "bql"
> +version = "0.1.0"
> +dependencies = [
> + "migration",
> +]

Yes, I also think this dependency is not much proper.

I also agree to move vmstate related things back to migration crate and
then we can make migration depend on bql (in fact, migration itself
indeed requires bql).

Current bql is good for now, so

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


