Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D85E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 10:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ1o6-0006Av-9w; Tue, 24 Dec 2024 05:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQ1o3-00069x-9u; Tue, 24 Dec 2024 05:06:27 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQ1o0-0004OT-Us; Tue, 24 Dec 2024 05:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735034785; x=1766570785;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=osdiYZW0CdLm3EVBxnb+tNNyk+eYWyyromXnlXvy930=;
 b=lXdaBEvYtPPdsvkNx+cCzrtQXV9w1T7o6vZnbIOMqRYtp3G6WqWymCUx
 kzAgBYp64x6ie+tnswMhXksFfRESTuOIZqEdh0HNQNXPBlBJ3LPPX0SAq
 L8x/XeFmao8epeBVA6yXErVgQsL36iJVLBLpnJTUpcNjGDIrBe2rxAFfi
 1zhT0nPyKAC2dmUNK9bsmt3pE22WAxIUzxbgXIhcBWJqTtfXAFDm1PUod
 IDT7CEoNqOEs/2Pz/Spmb5/UFDiLGFSx7gcDVbmAaqvVwvogW2GokF0m+
 chn6ZeQ43VebCgX2oEq/793Zwi8x+DOwfyivUf2Xvy7za9OsvfKYz8EVq g==;
X-CSE-ConnectionGUID: dn3BcGt9RQSEd66oxXYqPA==
X-CSE-MsgGUID: 8QZhu6ElQOyK3oROFhaW7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="34777786"
X-IronPort-AV: E=Sophos;i="6.12,259,1728975600"; d="scan'208";a="34777786"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Dec 2024 02:06:17 -0800
X-CSE-ConnectionGUID: K+lGh2QfStKorA1v3WbDVg==
X-CSE-MsgGUID: s+akvikqQxyUOXwmwNoOBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,259,1728975600"; d="scan'208";a="104415634"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 24 Dec 2024 02:06:12 -0800
Date: Tue, 24 Dec 2024 18:24:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linuxarm@huawei.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, zhenyu.z.wang@intel.com,
 dapeng1.mi@linux.intel.com, yongwei.ma@intel.com, armbru@redhat.com,
 farman@linux.ibm.com, peter.maydell@linaro.org, mst@redhat.com,
 anisinha@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, shameerali.kolothum.thodi@huawei.com,
 jiangkunkun@huawei.com, yangyicong@hisilicon.com, sarsanaee@gmail.com
Subject: Re: [PATCH v4 1/7] i386/cpu: add IsDefined flag to smp-cache property
Message-ID: <Z2qL9veQyp7Itc2Q@intel.com>
References: <20241216175414.1953-1-alireza.sanaee@huawei.com>
 <20241216175414.1953-2-alireza.sanaee@huawei.com>
 <20241223174818.000025c7@huawei.com>
 <20241224084127.00004d43@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224084127.00004d43@huawei.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Tue, Dec 24, 2024 at 08:41:27AM +0000, Alireza Sanaee wrote:
> Date: Tue, 24 Dec 2024 08:41:27 +0000
> From: Alireza Sanaee <alireza.sanaee@huawei.com>
> Subject: Re: [PATCH v4 1/7] i386/cpu: add IsDefined flag to smp-cache
>  property
> X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
> 
> On Mon, 23 Dec 2024 17:48:18 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Mon, 16 Dec 2024 17:54:08 +0000
> > Alireza Sanaee <alireza.sanaee@huawei.com> wrote:
> > 
> > > This commit adds IsDefined flag to the object and this helps in
> > > avoiding extra checks for every single layer of caches in both x86
> > > and ARM.
> > > 
> > > There is already a discussion on mailing list to have this flag. A
> > > patch that enables this flag will follow later.
> > > 
> > > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>  
> > Makes sense.  Zhao Liu, is this something you plan to use in the x86
> > code?
> 
> Hi Jonathan,
> 
> Yes this one comes from Zhao Liu's new patch-set, thanks to him. I will
> have to send another version given that.

Welcome! You can rebase this series on my v6. This way, there won't be
any conflicts, and once v6 is merged, yours can also be naturally picked
by maintainer. :-)

Regards,
Zhao


