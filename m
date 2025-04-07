Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5E9C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 07:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1gje-0001qS-SX; Mon, 07 Apr 2025 03:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u1gjL-0001p4-1c; Mon, 07 Apr 2025 03:17:16 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u1gjH-0007UU-PX; Mon, 07 Apr 2025 03:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744010232; x=1775546232;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fUhb1ZCZwwLi1zdCwn9LJmso0eNNCkth9Pv2+pWAXYs=;
 b=DInSCMNnabVzxVCd24DlOD/SkXoTBYWNjZBxOoDVhnAwJH0+CEbjTtud
 BhacVYDGvhY8e5PMU0xhcVm/VxaRTfOjzz2UCgKt5sNpYSR/7NMJPJ24M
 NSjbEZoA94fznLomsaL/d9JEQoBToL6sEXTX211DhdQosxFuihaguhnLn
 05C2r9WMkc3PAVXphreN4KJn43WI6aHU8xMCgmd/0tbu8NMoaUN2BQlyb
 MSwEYk2g4ITeDxR3UrFBGrwsYzxj1V1wQ54TFNOgRpb3PJKBamvBKdVpM
 eUcfLPWtqOIC7TydNOOJ/ggkNmKVqgLwdS72RpWXVc+rt8loQ2BbVo1Xp g==;
X-CSE-ConnectionGUID: /cB3m/kKTNSnxs4IMlhLsw==
X-CSE-MsgGUID: lRGrl6hkR7KTxVI+uMSQUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="62924199"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="62924199"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:17:04 -0700
X-CSE-ConnectionGUID: ICk0s/fvQ5eZyj25XcwjIg==
X-CSE-MsgGUID: vroBV48rTea5UmEr/8AO1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="128370666"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 07 Apr 2025 00:17:02 -0700
Date: Mon, 7 Apr 2025 15:37:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH preview 0/3] rust: update build system for Meson 1.8.0
Message-ID: <Z/OAtJA8DUIsmuep@intel.com>
References: <20250405100603.253421-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405100603.253421-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
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

On Sat, Apr 05, 2025 at 12:06:00PM +0200, Paolo Bonzini wrote:
> Date: Sat,  5 Apr 2025 12:06:00 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH preview 0/3] rust: update build system for Meson 1.8.0
> X-Mailer: git-send-email 2.49.0
> 
> Meson 1.7.0 and 1.8.0 include improved support for Rust, namely:
> * support for "objects" in Rust executables
> * support for doctest targets

Is there a patch missing to actually bump the required meson version up
to v1.8.0?

Regards,
Zhao


