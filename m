Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AE3C52D71
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 14:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbhTH-0005Lz-3p; Wed, 07 Aug 2024 10:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sbhTE-0005LG-DR
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 10:16:56 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sbhTC-0001Ul-L5
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 10:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723040215; x=1754576215;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=FuSgMD04SqrzRCXoRnWNrBv+OiFSDp9HYzVPTL4nETU=;
 b=fYKOBnhCyKLAuHWWYc7QU3Kb4n0dm0LflA1+2hLog2lAFP0oYUWMtY90
 iXDDcwZQ71tBvFoTCL+6DEqvO9AoDb7jHlPFoCJjVO8kfkXeS/Nh0XHgS
 ooIR5cetbU48kxng5LtGA+aJuo4dDj32OroTE+evM8PutVyqenvdnHbr0
 X34GlGAQtLNBIaXoXpDng7Gjfq3qJ/g5I62COSg8RC1jAR89Qd1kNh8FZ
 QcQJTc1my69cX4a8YaUy2KcB8qr17uF8LYPyKSFqn36YmKRmpl+QXGH/j
 kNSQrHf///H+izV02rAk302+ISc+yCudVmiIwsDpEWKzZ8Oej3ZJvP8+Z w==;
X-CSE-ConnectionGUID: 1EHRBMT5TiGF30fgH+1i3g==
X-CSE-MsgGUID: qUuvwd7UQXW8BX0EBzQOCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32501343"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="32501343"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 07:16:51 -0700
X-CSE-ConnectionGUID: 00/VtAqjQo6ycHeYSzn6eA==
X-CSE-MsgGUID: nuabMJ5qQnGO0eilVs9ARw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="87530139"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 07 Aug 2024 07:16:48 -0700
Date: Wed, 7 Aug 2024 22:32:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 lei4.wang@intel.com, xin3.li@intel.com
Subject: Re: [PATCH v1 1/3] target/i386: Delete duplicated macro definition
 CR4_FRED_MASK
Message-ID: <ZrOFhijavHLeI6D4@intel.com>
References: <20240807081813.735158-1-xin@zytor.com>
 <20240807081813.735158-2-xin@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807081813.735158-2-xin@zytor.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Wed, Aug 07, 2024 at 01:18:10AM -0700, Xin Li (Intel) wrote:
> Date: Wed,  7 Aug 2024 01:18:10 -0700
> From: "Xin Li (Intel)" <xin@zytor.com>
> Subject: [PATCH v1 1/3] target/i386: Delete duplicated macro definition
>  CR4_FRED_MASK
> X-Mailer: git-send-email 2.45.2
> 
> Macro CR4_FRED_MASK is defined twice, delete one.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>  target/i386/cpu.h | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


