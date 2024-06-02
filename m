Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646C4C25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 09:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDhHP-000801-Hu; Sun, 02 Jun 2024 05:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDhHM-0007xa-Rv
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 05:13:28 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDhHK-000231-Ra
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 05:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717319607; x=1748855607;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6F4l0yGC0hQKmqE3u0rqTgEbV6gjluiP88xm/kLtKHQ=;
 b=YXXA3wa3WfzVCfYZaJE9YrKV+v1X+SQibYvRRQDsclZiaiQc+51tuI4Z
 dyM+bbdSX6Q3WmWQeZWwJmr7AnsAXr5kGD9kd+8IcntOSP3ozE4ARkWmj
 i+3zyssvKtulpTkOZ1QEFKJDQ5aKxWzs4XQq8NY2De6KGcsJ/oUPZqmeE
 IFQHgwe+jt/qjTFwIeOAut5SRbz3bZpsN1k+rmiq6ptgWIZAo9nJN5+Cc
 5CTTQ0uUdrtA/kTqe0JWtU987zvWTbILaHnW/le42ijmnG3k9o6duIIvb
 v3Iwwuuqfjas18skjMrs+AJpkH+VfZjhiocuW99B07e5Cd91FR0jkozcl A==;
X-CSE-ConnectionGUID: Jkoab0W4QFiDKmAU07WNiw==
X-CSE-MsgGUID: KNLRVoVYSE+CsCAFrGkPTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="24481873"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; d="scan'208";a="24481873"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 02:13:23 -0700
X-CSE-ConnectionGUID: oCnwptJfRWCrVUm3/55geg==
X-CSE-MsgGUID: xEAHqY0QSKCn+C00zWXi6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; d="scan'208";a="36615508"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 02 Jun 2024 02:13:22 -0700
Date: Sun, 2 Jun 2024 17:28:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/6] host/i386: nothing looks at CPUINFO_SSE4
Message-ID: <Zlw7Tw/ysyQC/inM@intel.com>
References: <20240531091457.42200-1-pbonzini@redhat.com>
 <20240531091457.42200-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531091457.42200-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.041,
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

On Fri, May 31, 2024 at 11:14:52AM +0200, Paolo Bonzini wrote:
> Date: Fri, 31 May 2024 11:14:52 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 1/6] host/i386: nothing looks at CPUINFO_SSE4
> X-Mailer: git-send-email 2.45.1
> 
> The only user was the SSE4.1 variant of buffer_is_zero, which has
> been removed; code to compute CPUINFO_SSE4 is dead.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  host/include/i386/host/cpuinfo.h | 1 -
>  util/cpuinfo-i386.c              | 1 -
>  2 files changed, 2 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


