Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F01CC25B76
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF3PR-0006gP-PW; Wed, 05 Jun 2024 23:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sF3PO-0006ft-NX
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:03:22 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sF3PL-0007xI-Vz
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717643000; x=1749179000;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=QLV5xfERdZMAcWHeU/yCzSXNLddso4YYteFuSjcJ76A=;
 b=eOCkg3bZbEwDwU0z6KyzYPg4ZbCkdEZ53TvTCrvktSNQDrmbquJejsG5
 Xf3dt7ED02dLxUymqbub4tg4o+uVsR1OvzRoT/tZVp7G5YR4xsNKMKDdS
 OvS9Cq7XvP/ah2pYPdS7G9IfRfe6fnBMCOPhqhq37NCT0iKSvQb4prh6t
 tqvNGR9+Jko+yiBNjHIsw17Q81/9MKqtp3t4RzOw+83DuiA05L/WPssV6
 JD3qAkmySvNbrOjU08CVRTAqTfu+LB8NfJEUgp6GXoOnYS6fyV4D1xH8H
 VRpGusJr8zuECjwI5gbtUMOK6pcPDW7gGiLC9JR8XnJpsjJC5l2AcDHuL w==;
X-CSE-ConnectionGUID: ftZQpTEVS2qgryXLggLQhg==
X-CSE-MsgGUID: bVJN1fFvQJWjCVGQ21dXVg==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="11932715"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="11932715"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 20:03:16 -0700
X-CSE-ConnectionGUID: MzjnbXzWRT+iJbGOxR+z+A==
X-CSE-MsgGUID: 9l7S5P92SteioprvYvjaDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="38370178"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 05 Jun 2024 20:03:15 -0700
Date: Thu, 6 Jun 2024 11:18:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] stubs/meson: Fix qemuutil build when --disable-system
Message-ID: <ZmEqkYLVIsfP99GH@intel.com>
References: <20240605152549.1795762-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240605152549.1795762-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jun 05, 2024 at 11:25:49PM +0800, Zhao Liu wrote:
> Date: Wed, 5 Jun 2024 23:25:49 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [PATCH] stubs/meson: Fix qemuutil build when --disable-system
> X-Mailer: git-send-email 2.34.1
> 
> Compiling without system, user, tools or guest-agent fails with the
> following error message:
> 
> ./configure --disable-system --disable-user --disable-tools \
> --disable-guest-agent
> 
> error message:
> 
> /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `error_printf':
> /media/liuzhao/data/qemu-cook/build/../util/error-report.c:38: undefined reference to `error_vprintf'
> /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `vreport':
> /media/liuzhao/data/qemu-cook/build/../util/error-report.c:215: undefined reference to `error_vprintf'
> collect2: error: ld returned 1 exit status
> 
> This is because tests/bench and tests/unit both need qemuutil, which
> requires error_vprintf stub when system is disabled.
> 
> Add error_vprintf stub into stub_ss for all cases other than disabling
> system.
> 
> Fixes: 3a15604900c4 ("stubs: include stubs only if needed")
> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  stubs/meson.build | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 3b9d42023cb2..a99522ab6bbf 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -45,17 +45,10 @@ if have_block or have_ga
>    stub_ss.add(files('qmp-quit.c'))
>  endif
>  
> -if have_ga
> -  stub_ss.add(files('error-printf.c'))
> -endif
> -
>  if have_block or have_user
>    stub_ss.add(files('qtest.c'))
>    stub_ss.add(files('vm-stop.c'))
>    stub_ss.add(files('vmstate.c'))
> -
> -  # more symbols provided by the monitor
> -  stub_ss.add(files('error-printf.c'))
>  endif
>  
>  if have_user
> @@ -76,6 +69,9 @@ if have_system
>    stub_ss.add(files('target-monitor-defs.c'))
>    stub_ss.add(files('win32-kbd-hook.c'))
>    stub_ss.add(files('xen-hw-stub.c'))
> +else
> +  # more symbols provided by the monitor
> +  stub_ss.add(files('error-printf.c'))
>  endif

Oops, it's not a correct fix. error-printf.c should still be added
unconditionally.

>  
>  if have_system or have_user
> -- 
> 2.34.1
> 

