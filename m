Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBFAC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 03:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua4Kh-0005ln-Ok; Thu, 10 Jul 2025 23:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ua4Kf-0005jm-KU
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 23:21:53 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ua4Kd-0007eH-6p
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 23:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752204111; x=1783740111;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6yoEiIgioc3P90CdQveTXP0LwldofyZDxp1VyDzAcU8=;
 b=fkKRWlgEyZ65oYBjbQUDy8ffuY7WBvjD5vRy/4ooMq7u5TlJvkiIbdBt
 OnXuwm8iR0o+NljEuFU/7n01/WHSYEaLtNORqq5ANnG4DoYgkzZkW2mWz
 WndiSVtrVyr0v/LtilXJv/NbzwOTZvLuHrafNwe83SOaUQbZ4Sqxxn0jZ
 +EeUj56QGLyYFziDmZk0OW6tjGC97Fnl+15wKFkvyn8BMDnpRNwTzOtsf
 x5lnqbotEhYXM9s1mdW6Ed6w9mhlOz/MkBYpdBSGg2B+SRaQvEuryMyIP
 aTL2tOUJpuJWXlnlQwC6TJb2P25Zf4U7gziYIImn2EUlLicxWNEVq673x Q==;
X-CSE-ConnectionGUID: swfLauQdRWaza9uPFhAlew==
X-CSE-MsgGUID: 06VATcvKRXyG2W8euqoVCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54215337"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="54215337"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 20:21:48 -0700
X-CSE-ConnectionGUID: FpHMVEJ+S2yD2Pyx/6lucQ==
X-CSE-MsgGUID: ed8bPhJYRv21Nx4BUqw/+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="156606988"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 10 Jul 2025 20:21:46 -0700
Date: Fri, 11 Jul 2025 11:43:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: Re: [PATCH 1/4] target/i386: move max_features to class
Message-ID: <aHCIU/YgKNkzPgEB@intel.com>
References: <20250711000603.438312-1-pbonzini@redhat.com>
 <20250711000603.438312-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711000603.438312-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
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

On Fri, Jul 11, 2025 at 02:06:00AM +0200, Paolo Bonzini wrote:
> Date: Fri, 11 Jul 2025 02:06:00 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 1/4] target/i386: move max_features to class
> X-Mailer: git-send-email 2.50.0
> 
> max_features is always set to true for instances created by -cpu max or
> -cpu host; it's always false for other classes.  Therefore it can be
> turned into a field in the X86CPUClass.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.h         | 2 +-
>  target/i386/cpu.c         | 5 +++--
>  target/i386/hvf/hvf-cpu.c | 3 ++-
>  target/i386/kvm/kvm-cpu.c | 5 +++--
>  4 files changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


