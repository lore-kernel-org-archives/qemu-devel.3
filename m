Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE50C7EE30
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 02:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUz4w-0005yO-VP; Thu, 26 Jun 2025 22:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUz4u-0005xy-EB
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 22:44:36 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUz4s-0004EX-2e
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 22:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750992274; x=1782528274;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Yegej79wYfqDMWs9mZssB6fXngFv2T2RYAUAL2pkxD0=;
 b=fTVU9Jb5sEUpd93DWG8yo3pgSec6jdX5gbHDYseawrldklMOyKaTj3ih
 I8mpdfh45VB1J4Lreq6EgQJdQXDKw66MSNGhm/uuqBJtvsmz0fBorYnrp
 oYfIWTfP2fRh/CrkuzGwnLCchFmCSA9xoXqZNQkcowBez1kJV9S8+bCj4
 YwFvp3a5l3Dim4H9ZEt15C9fXXQ9lzDuczzP2t6kvbJ9LPyEyW0lxw74A
 tWkEu+/HNde63FvKgQFi1Y/4sueeRPL2iV5umQkKxQwBHTnWdyWGMN/eZ
 7RsEBOAB2V+1FjaP9qh1FidbNnpeo9lSZyQGd6o1g8JRVpkN/N8WMKsMP w==;
X-CSE-ConnectionGUID: F9qhTIquThqfQd5i9OQnrA==
X-CSE-MsgGUID: ScmleZfQSWawAthfequTAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="57086918"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="57086918"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 19:44:30 -0700
X-CSE-ConnectionGUID: ygNjwef8T+iFLOOF1ICoQQ==
X-CSE-MsgGUID: BKM2uZAeRrOa4vmA4hLGXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="152309735"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 26 Jun 2025 19:44:26 -0700
Date: Fri, 27 Jun 2025 11:05:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Zeng <jason.zeng@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>,
 Manish Mishra <manish.mishra@nutanix.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 5/8] i386/cpu: Add a "x-force-cpuid-0x1f" property
Message-ID: <aF4Kjf7iGhEORMSL@intel.com>
References: <20250626083105.2581859-1-zhao1.liu@intel.com>
 <20250626083105.2581859-6-zhao1.liu@intel.com>
 <0d038476-e7c6-4e7a-add2-aeb4d715c202@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d038476-e7c6-4e7a-add2-aeb4d715c202@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
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

> After applying these patches to QEMU mainline at commit 6e1571533fd9:

Ah, I forgot I've rebased these patches...Now you can rebase all the
patches at the latest master branch.

Or, you can try this repo - I just created it to make it easier for you:

https://gitlab.com/zhao.liu/qemu/-/tree/cache-model-v2.6-rebase-06-23-2025

Thanks,
Zhao

> $ git am patches-from-https://lore.kernel.org/qemu-devel/20250620092734.1576677-1-zhao1.liu@intel.com/
> $ git am patches-from-https://lore.kernel.org/all/20250626083105.2581859-6-zhao1.liu@intel.com/
> 
> and configure && make qemu with:
> 
> $ ./configure --target-list=x86_64-softmmu --enable-debug --enable-kvm
> --enable-sdl --enable-gtk --enable-spice --prefix=/usr --enable-libusb
> --enable-usb-redir --enable-trace-backends=simple && make -j32
> 
> I ran into this build error:
> 
> target/i386/cpu.c:9942:52: error: 'X86CPU' {aka 'struct ArchCPU'} has no
> member named 'force_cpuid_0x1f' ; did you mean 'enable_cpuid_0x1f' ?
> 
> I haven't debug it yet, because it seems like a simple mistake, asking you
> directly might be quicker.
> 

