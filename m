Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31C0CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwyv2-0005NK-VR; Fri, 12 Sep 2025 04:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwyv1-0005Mq-2N
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:14:07 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwyur-0000yK-Fp
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757664838; x=1789200838;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=sQ5nwZ1sb/3GdRh141BaNUcGtXroNsf5f9WzS4fjWpo=;
 b=MHq7t7SDEMiKvU88hOdmgImoaMrUGcPwmnXaxWxzSiON4lhzvUFrsC+D
 gF5W4bEyKjOFtoy9+/72SGev0f7d3hPvT9cB0ox/CpqBBJHWFxsjVFnhK
 kaq58Y0LkSBIJtfFImDcYtosPmsl1W1B1mAoqWtKsRbbDvtnnsyHwyd1J
 z3gaULv7KJnJ3iqluHFShxYb7k4UK9BSh7p1ILseebv28FZ0wZKG+RQ5k
 /FK4KiJfHuBv+62SpMxtn8kEGq0/Wb1V5g/HE3us42odD0+h6xSGhJVAD
 VOY1OQEyXFbplZo1iyz72dmZdcMXOUukeUxAu10w4UGz1UXWhTcJQZXAi g==;
X-CSE-ConnectionGUID: 18NVw8GURr6qmcd+FRGyzg==
X-CSE-MsgGUID: IBf3pQO/Ri25tOBPJR+/zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="62637797"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="62637797"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 01:13:54 -0700
X-CSE-ConnectionGUID: zUMpOuEVQV+8Lv3CW9Jbnw==
X-CSE-MsgGUID: A8ohQCf7Rnioh8pTB4PStA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="204906942"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 12 Sep 2025 01:13:53 -0700
Date: Fri, 12 Sep 2025 16:35:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 22/33] rust: split "chardev" crate
Message-ID: <aMPbYpt8oyRmUBKB@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-23-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-23-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:49:54PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:54 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 22/33] rust: split "chardev" crate
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-14-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS                               |  1 +
>  rust/chardev/wrapper.h                    | 28 ++++++++++++++++
>  rust/qemu-api/wrapper.h                   |  2 --
>  rust/Cargo.lock                           | 14 ++++++++
>  rust/chardev/Cargo.toml                   | 24 +++++++++++++
>  rust/chardev/build.rs                     |  1 +
>  rust/chardev/meson.build                  | 41 +++++++++++++++++++++++
>  rust/chardev/src/bindings.rs              | 36 ++++++++++++++++++++
>  rust/{qemu-api => chardev}/src/chardev.rs |  0
>  rust/chardev/src/lib.rs                   |  6 ++++
>  rust/hw/char/pl011/Cargo.toml             |  1 +
>  rust/hw/char/pl011/meson.build            |  1 +
>  rust/hw/char/pl011/src/device.rs          |  2 +-
>  rust/meson.build                          |  1 +
>  rust/qemu-api/Cargo.toml                  |  1 +
>  rust/qemu-api/meson.build                 |  9 +++--
>  rust/qemu-api/src/bindings.rs             |  9 +----
>  rust/qemu-api/src/lib.rs                  |  1 -
>  rust/qemu-api/src/qdev.rs                 |  6 ++--
>  19 files changed, 164 insertions(+), 20 deletions(-)
>  create mode 100644 rust/chardev/wrapper.h
>  create mode 100644 rust/chardev/Cargo.toml
>  create mode 120000 rust/chardev/build.rs
>  create mode 100644 rust/chardev/meson.build
>  create mode 100644 rust/chardev/src/bindings.rs
>  rename rust/{qemu-api => chardev}/src/chardev.rs (100%)
>  create mode 100644 rust/chardev/src/lib.rs

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


