Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C19CCD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU3UR-0003u2-AK; Mon, 01 Jun 2026 10:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wU3UN-0003tc-HJ; Mon, 01 Jun 2026 10:19:37 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wU3UI-0002Lb-Or; Mon, 01 Jun 2026 10:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780323570; x=1811859570;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=m4uBVnhmdsMiDwZDG3EPdF56hHk5VGvqGLyfdqMsYk0=;
 b=i1r/rIv188ZVz8EjzOYKjneZ9NAvr+0qiBBIjRF0qr/jnQq3j4hf8lyk
 LrdG1DgdOw52yexBe6nkH1lipHqSh6Gf/qLIf8nctDF9OZ65hzSvvOp+0
 eagwCd5iqnh7/HGfo2jx6ylTm18iysv6t9yHu30DQava1QYaTh2Wcmo5M
 2rRxtPPboPxshLWmrVBAxP4RDiSyhEw+9S7yPBGZX/5/vywgykP1DZKJ0
 vJz3OhmOAA7SjGVdyGVCvnY8CHunZv/qnEIKsd+Fipno8c4ecl6kuTFrE
 supmWGLRdz63fyC7zMeYhnTY4FbM0G4beATVhUQUxNUWbaP11VBpfdMo4 w==;
X-CSE-ConnectionGUID: yrgjoLSXQTeVVMKEOnGDnQ==
X-CSE-MsgGUID: U4A3pOa5QRW9AeOCNwA9iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="92194513"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="92194513"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 07:19:25 -0700
X-CSE-ConnectionGUID: GIz5AegcTOOMQdAWP/FhFA==
X-CSE-MsgGUID: iisY+Ol5Qe2Hnrmy2u7NRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="245407463"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 01 Jun 2026 07:19:24 -0700
Date: Mon, 1 Jun 2026 22:47:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com, zhao1.liu@intel.com
Subject: Re: [PATCH v3 02/19] subprojects: add serde
Message-ID: <ah2bc8Ee9FGcRCZn@intel.com>
References: <20260526175618.227743-1-pbonzini@redhat.com>
 <20260526175618.227743-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526175618.227743-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

>  anyhow_rs = dependency('anyhow-1-rs')
>  bilge_rs = dependency('bilge-0.2-rs')
> @@ -19,6 +21,8 @@ foreign_rs = dependency('foreign-0.3-rs')
>  glib_sys_rs = dependency('glib-sys-0.21-rs')
>  libc_rs = dependency('libc-0.2-rs')
>  probe_rs = dependency('probe-0.5-rs')
> +serde_rs = dependency('serde-1-rs')
> +serde_derive_rs = dependency('serde_derive-1-rs', native: true)
                                                     ^^^^^^^^^^^^
Here we register dependency on build system...

> +serde_derive_dep = declare_dependency(
> +  link_with: _serde_derive_rs,
> +)
> +
> +meson.override_dependency('serde_derive-1-rs', serde_derive_dep)

... but here it seems we register serde_derive-1-rs to host system, so
this may trigger error for cross-compilation.

IIUC, we should have:

meson.override_dependency('serde_derive-1-rs', serde_derive_dep, native: true)

Regards,
Zhao


