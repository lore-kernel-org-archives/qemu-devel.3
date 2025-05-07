Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17820C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 12:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCe7Z-0003Gd-TR; Wed, 07 May 2025 08:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCe7X-0003F7-Hd; Wed, 07 May 2025 08:43:31 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCe7T-0005Nl-DC; Wed, 07 May 2025 08:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746621807; x=1778157807;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RLal0QSny7MhpWsbU2LrAZCM4jg0TFU5MJHApMM6pvg=;
 b=KBrNkpVdDEarFcA4Fy3iSx4DROicFfrnXZJICIWQ6S419ATqUlgNIk3w
 i+3ykh47M7EZ6rPFAlb+ucJUTEFXgiD9ODpA1TU1tsUYkyw9ZIv+WlR6O
 bUPUukzBvZobC64GAKXuy9ektE6VRmAHescNCaqs5GHynQwYvWszQAh8A
 8quiF3ly8zrwyApls6IEPUZegLKSf5r6i/XLQz9XKvg7calm4kqrozZ/Z
 k9TytwIHjZfqAEJqEmedunOxM6qwC3WOGwWVEbOOchbEwtIS8gmCuxgdI
 0Ry8sz2EWDSpKKlpAZ24rcjqIEIh1kO7N5vFeg6dRS9OfrJaLJArKXv6b A==;
X-CSE-ConnectionGUID: 6rF1yyIaSCqrDOVN4xs6Fg==
X-CSE-MsgGUID: qsPvOmkIRcK1vfepGC2pmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="65878854"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="65878854"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 05:43:19 -0700
X-CSE-ConnectionGUID: 21aa5MlvQbiMx9Vc/SVJDA==
X-CSE-MsgGUID: +vGheIrIRHO3TxziUlV6LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="135915271"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 07 May 2025 05:43:17 -0700
Date: Wed, 7 May 2025 21:04:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, pbonzini@redhat.com,
 xiaoyao.li@intel.com, ewanhai@zhaoxin.com, cobechen@zhaoxin.com,
 qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v4] target/i386: Fix model number of Zhaoxin YongFeng
 vCPU template
Message-ID: <aBtaUkEnm3bdeW4U@intel.com>
References: <20250415024545.517897-1-ewanhai-oc@zhaoxin.com>
 <8159d6e6-7de6-47ed-92ca-a6ec2721cf10@tls.msk.ru>
 <970df0f3-f26f-4f3c-8259-22f8508e57e8@zhaoxin.com>
 <cc878857-66e9-4599-9982-cf88fd1f320b@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc878857-66e9-4599-9982-cf88fd1f320b@tls.msk.ru>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Wed, May 07, 2025 at 02:30:50PM +0300, Michael Tokarev wrote:
> Date: Wed, 7 May 2025 14:30:50 +0300
> From: Michael Tokarev <mjt@tls.msk.ru>
> Subject: Re: [PATCH v4] target/i386: Fix model number of Zhaoxin YongFeng
>  vCPU template
> 
> On 25.04.2025 14:14, Ewan Hai wrote:
> > On 4/24/25 3:25 PM, Michael Tokarev wrote:
> > > 
> > > On 15.04.2025 05:45, Ewan Hai wrote:
> > > > The model number was mistakenly set to 0x0b (11) in commit ff04bc1ac4.
> > > > The correct value is 0x5b. This mistake occurred because the extended
> > > > model bits in cpuid[eax=0x1].eax were overlooked, and only the base
> > > > model was used.
> > > > 
> > > > Using the wrong model number can affect guest behavior. One known issue
> > > > is that vPMU (which relies on the model number) may fail to operate
> > > > correctly.
> > > > 
> > > > This patch corrects the model field by introducing a new vCPU version.
> > > > 
> > > > Additionally, it adds a "Preferred CPU models for Zhaoxin x86 hosts"
> > > > section in docs/system/cpu-models-x86.rst.inc to recommend the
> > > > appropriate Zhaoxin CPU model(s).
> > > > 
> > > > Fixes: ff04bc1ac4 ("target/i386: Introduce Zhaoxin Yongfeng CPU model")
> > > > Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> > > > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> > > 
> > > Is it a qemu-stable material (for 10.0.x)?
> > > 
> > > I'm picking this one up, please let me know if I should not.
> > 
> > I'm not sure if this should go into qemu-stable. Maybe Paolo Bonzini or
> > Zhao can answer?
> 
> Ping?  Paolo, Zhao, - can you comment please?

Sorry for late. Though I didn't find the similar case, without this
patch, the original model can't support vPMU function correctly.

Therefore I think it makes sense to include this patch into stable QEMU,
so that the Zhaoxin user could have a normal CPU model.

Thanks,
Zhao


