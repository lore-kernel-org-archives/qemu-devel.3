Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2410CA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 06:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uylbE-0007Jk-CJ; Wed, 17 Sep 2025 02:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uylb0-0007IX-Ev; Wed, 17 Sep 2025 02:24:53 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uylai-0007Bz-2w; Wed, 17 Sep 2025 02:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758090272; x=1789626272;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=RGmMowDRCbSSZDE+Jt7DwfGm1bZzQY5qksrq9moMJxA=;
 b=d2Kqc6RzQqC7eTgIpiXWzJlXxk7zp2Vqe5kFF+ndnGGwsAnGLveiLwYX
 t+31j4n4Lue+K1iYDIc6ZNrl80JmpzLR7QR97pqFz1927aWaeEkh41A00
 egG4k983ypx8gCNHnaJfDAdWLDUGi8yv2gfhCBLSpBJI9ntNo+x9uO53Y
 T9j0ubP1nPuTy9WMBuoUCEPr9ghVtQxkqw+W8L7HBKONuJeJWK150cwH6
 jeuW8hQu1YoP6qHIaFPKS2YosXGHX/mcmUqsBv1aXL6PxGdIvYZ4DFwn1
 m2Ji5YarLP3kNfeUsHt9uQKX4jgJV+oloVR7iGKeFrIG01vWYT2T8X26L w==;
X-CSE-ConnectionGUID: LH6QT3zAQRa1AfmXjl73CQ==
X-CSE-MsgGUID: sIcBcnC9RnSVal7tsasBJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="59430655"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="59430655"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 23:24:28 -0700
X-CSE-ConnectionGUID: 7AW4v/EDRnarBfA2xyXR8g==
X-CSE-MsgGUID: RzL7vxUrTHWZ5VqCZ0H1Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="175068190"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 16 Sep 2025 23:24:27 -0700
Date: Wed, 17 Sep 2025 14:46:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [PATCH 07/12] rust/qdev: Rename PropertyInfo field from VALUE to
 BASE_INFO
Message-ID: <aMpZPedisDFfG1yN@intel.com>
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
 <20250916085557.2008344-8-zhao1.liu@intel.com>
 <CAAjaMXYSDGCr4H_Pk8gOHn6NbsOp0+q==V7GgdtR_60tT4FCPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXYSDGCr4H_Pk8gOHn6NbsOp0+q==V7GgdtR_60tT4FCPw@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
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

On Tue, Sep 16, 2025 at 01:10:39PM +0300, Manos Pitsidianakis wrote:
> Date: Tue, 16 Sep 2025 13:10:39 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: Re: [PATCH 07/12] rust/qdev: Rename PropertyInfo field from VALUE
>  to BASE_INFO
> 
> On Tue, Sep 16, 2025 at 11:34 AM Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > Bit property info will added next. To distinguish different info fields,
> > rename `VALUE` to `BASE_INFO`, then it can better reflect that it
> > represents the basic property info.
> >
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks!

> You can squash this patch to the bit info one

Yes, after patch 8, renaming doesn't need to change too many places.

Regards,
Zhao


