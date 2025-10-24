Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E484ECCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBgS-0006Z9-00; Fri, 24 Oct 2025 02:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBgP-0006Yc-VU
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:53:53 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBgN-0006It-8g
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761288831; x=1792824831;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=k8K81La8jvl+T9BeBc14GS65QJ2szzBca1z2xWdxc5A=;
 b=m86k9N6eytQGLFDKkfVtLJzayeH8QQl5zwr6t19ciYSdDF9isPBAZvyI
 wLG3/ni8i843no7tFOfv9OuMbpqUu0MQ3FD4RWMoESVYP6YwZz5nmzpfu
 2b7+YSWw0Zhysh7Myd+3MjJYXSNVc8FsmhghrgYWH/QLLnHLmwUF3PuIU
 YzcxBYeb9m0TfY5MZZ1bnVurA0Y/ommlmFaYhRi+GId6SuTXLqGld9Hjg
 WC9JQu1Z/Ax63vNmyMYpTAjexKo0gcgSrJsAJu7XWOSh0dYqn9Dsk2PqQ
 OfjEMEYNuhGNhVHlQ+hODTnyHFz886a2DqSGhm10f4z6tKhWwmCwlrM1r Q==;
X-CSE-ConnectionGUID: l2Kk2aTbS8afCEf+YMLcCw==
X-CSE-MsgGUID: 8NaPx20vRTql3dHFkdz/eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62497480"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="62497480"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 23:53:48 -0700
X-CSE-ConnectionGUID: 0FzHjXbQQSqr5E9xDZrE3w==
X-CSE-MsgGUID: SstUoEyNSzKHVSN5CWnlZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="183586197"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 23 Oct 2025 23:53:47 -0700
Date: Fri, 24 Oct 2025 15:15:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] target/i386: Introduce Zhaoxin Shijidadao-Server CPU
 model
Message-ID: <aPsnqxDZR4KxgcdN@intel.com>
References: <20250923021133.190725-1-ewanhai-oc@zhaoxin.com>
 <20250923021133.190725-4-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923021133.190725-4-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 22, 2025 at 10:11:33PM -0400, Ewan Hai wrote:
> Date: Mon, 22 Sep 2025 22:11:33 -0400
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH 3/3] target/i386: Introduce Zhaoxin Shijidadao-Server CPU
>  model
> X-Mailer: git-send-email 2.34.1
> 
> Shijidadao-Server hardware enables IA32_CORE_CAPABILITIES and relies on
> the SPLIT_LOCK_DETECT feature. When the kernel has not yet virtualized
> this MSR, KVM filters the capability and QEMU emits a warning.
> 
> This patch retains the core-capability bit in the CPU model so it will
> take effect once KVM support becomes available.
> 
> In QEMU, vCPU models default to '.version = 1'. Since there is currently
> no '.features[index]' mapping for the "x-force-cpuid-0x1f" property, this
> patch adds that property to the v1 version of the model.

I'm preparing the CPU model for Diamond Rapids, and also meet this
issue.

Well, I happen to have a patch for this and I think you could give it
a try. :)

Thanks,
Zhao


