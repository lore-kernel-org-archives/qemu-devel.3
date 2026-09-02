Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4730AC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i1j-0006Gu-Ol; Wed, 02 Sep 2026 06:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1i1e-0006Cg-Dl
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:17:02 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1i1c-00057t-Sw
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788344221; x=1819880221;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3mrv0SmyYUtoltFxvjBhfe7xLwtnV6flfTfcqh42GSU=;
 b=fiF97MXODeUNq2/riab1UVCRck1I9p0PYwcN8RhETBMBG1tfczVYWOg3
 9J7qZ999yx05976y7woD2Ed11LgSlHThqxweAobGouwEuDEvLkE1sdVnv
 EP6TbBBEOv8byFn6H/TtCuP9HyrdlVb2Gphjkbt2cKjTvFSJk+B/Qi7HZ
 vezxtpZXZndPO7xI34sSqtXqeT+modOjQYlebDwk75MRIrWB3/Y52T78+
 M5QMVGpLDdauOyyD4IwOHMXYuxPZKFM13tL2/eyYqDKMlJYxczLDRQtVT
 CyWYjY4qtJ3UxwQCgvOd7NKhrTsMiJnYYJUXWW2YgP8H2TW9erL0biXVZ Q==;
X-CSE-ConnectionGUID: FdAhSyJPQqSiCDSBHkx3mg==
X-CSE-MsgGUID: iKiYuxpnTCG1NVJ+gL/4rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92665439"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="92665439"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 03:16:59 -0700
X-CSE-ConnectionGUID: t/pH+jfMTL2PjaZjo2fAzw==
X-CSE-MsgGUID: DaKkfQlmT4akNzePE8UKBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="274623550"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa005.fm.intel.com with ESMTP; 02 Sep 2026 03:16:57 -0700
Date: Wed, 2 Sep 2026 18:16:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kvm@vger.kernel.org,
 sohil.mehta@intel.com, xiaoyao.li@intel.com,
 binbin.wu@linux.intel.com, farrah.chen@intel.com
Subject: Re: [PATCH 3/5] target/i386: Introduce DiamondRapids-v3 to enable LASS
Message-ID: <apf3mEv1+8uSgukX@intel.com>
References: <20260826035734.114685-1-kishen.maloor@intel.com>
 <20260826035734.114685-4-kishen.maloor@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826035734.114685-4-kishen.maloor@intel.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Aug 25, 2026 at 08:57:32PM -0700, Kishen Maloor wrote:
> Date: Tue, 25 Aug 2026 20:57:32 -0700
> From: Kishen Maloor <kishen.maloor@intel.com>
> Subject: [PATCH 3/5] target/i386: Introduce DiamondRapids-v3 to enable LASS
> X-Mailer: git-send-email 2.47.1
> 
> Add DiamondRapids-v3 to expose Linear Address Space Separation (LASS)
> on the DiamondRapids CPU model.
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  target/i386/cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


