Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA57CF2590
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 07:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLcMx-0003Mh-LT; Wed, 19 Nov 2025 02:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLcMw-0003MK-HV
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 02:12:46 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLcMu-0006Ml-NA
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 02:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763536365; x=1795072365;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ByplCGQG329EMQifwPghkySu4IjurQY8RGCXOJxk/q4=;
 b=SDb7lcrm9Il1/hNehAnJ3AnIUTZnL29T+BBqJAzdgtBHWex168XG5siU
 aNgPLv7j4pJ0knOHzmTXsR1ik8i2mdOEaM8gYwht3u0UGWXiyCptov/i7
 wlzLXcnpURop2teQbsJGVOhi7wqNqUqeQlPeC07qc+0GLvEM0vZzZYhFp
 7qi9Z4LB7sBUTV58b0EjcvSKIdObbI5I1h5mWog95B2iE0l834KgnqXwX
 NamWAhXOnQ7rBlzuHnQjzbYHgrmZRQ/uO/j12SMBfDcaNbDDrrfbK4Ffu
 EqIkQ9i0W2f654FiTmU3Gj9ytAv8K5vYSmKWb/OdmT+aTOM9TDeDNVfAg Q==;
X-CSE-ConnectionGUID: xIo4oHL8S9+TeEkz0B8WWA==
X-CSE-MsgGUID: mRqi9pqISa+GKw+4XJIhnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65502600"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="65502600"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 23:12:40 -0800
X-CSE-ConnectionGUID: bfOL8vzqRFefP0/JbJ0C1Q==
X-CSE-MsgGUID: eE6YlQUhT3eJEjiMvKEBmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="196108309"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 18 Nov 2025 23:12:38 -0800
Date: Wed, 19 Nov 2025 15:34:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Peter Fang <peter.fang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 4/5] i386/cpu: Support APX CPUIDs
Message-ID: <aR1zIb4GHh9FrK31@intel.com>
References: <20251118065817.835017-1-zhao1.liu@intel.com>
 <20251118065817.835017-5-zhao1.liu@intel.com>
 <CABgObfZfGrx3TvT7iR=JGDvMcLzkEDndj7jb5ZVV3G3rK54Feg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZfGrx3TvT7iR=JGDvMcLzkEDndj7jb5ZVV3G3rK54Feg@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> Please just make the new leaf have constant values based on just
> APX_F. We'll add the optional NCI/NDD/NF support if needed, i.e.
> never. :)

Maybe not never?

> > Note, APX_NCI_NDD_NF is documented as always enabled for Intel
> > processors since APX spec (revision v7.0). Now any Intel processor
> > that enumerates support for APX_F (CPUID.(EAX=0x7, ECX=1).EDX[21])
> > will also enumerate support for APX_NCI_NDD_NF.

This sentence (from APX spec rev.7) emphasizes the ¡°Intel¡± vendor,
and its primary goal was to address and explain compatibility concern
for pre-enabling work based on APX spec v6. Prior to v7, APX included
NCI_NDD_NF by default, but this feature has now been separated from
basic APX and requires explicit checking CPUID bit.

x86 ecosystem advisory group has aligned on APX so it may be possible
for other x86 vendors to implement APX without NCI_NDD_NF and this still
match with the APX spec.

If we default to setting this NCI_NDD_NF bit for APX, then in the future
when we run into other vendors that don't support this feature, we'll not
only have to make it optional again, but we'll also need to do fixes
similar to the ARCH_CAPABILITIES situation - checking vendors, fixing
compatibility issues, and all that stuff.

Therefore, compared to default setting to constant, I think the optional
NCI_NDD_NF now not only aligns with arch spec but also prevents future
compatibility issues. :)

Thanks,
Zhao


