Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D094FD2D9C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxga-0002Oo-ND; Tue, 10 Mar 2026 10:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxgZ-0002OO-Gf
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:03:47 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxgX-00028D-Gl
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773151426; x=1804687426;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=lbSdy8D4M6pzEumt6lrzqaGyhHSvWigYKJbSw7rfn7Q=;
 b=KEIw3X6NkyY4kKKkibyF9L+dYtvpzCa9r9vjXiMEYhDA8I6HD+FMraBN
 faqpR4h80jwNLwvNpz9V3pSv8EKsY5jHzKfdmADTW/L44U+jSDXP2WvCn
 MCST37wXyYLDx6InWZ1fUO/zMPJeDpVHvOYKBp+AXsHhFxQ24N2DHVliL
 RIbEpcIXoznEM18mQEt+R+iNZU5JbC7BFjG0QILtkNHY9VjbRLICVh/QT
 VhaAqfe5unrMbALaE2Cv3sHfMLRgyi2T2QF/ac+9fLWw5PemLY2o4n83F
 nJMJ3oonYGJLcJ6EpEmPG44yCzu3f8MuXkTgr5AKEcuSDko8b00DIbzv1 Q==;
X-CSE-ConnectionGUID: BMyRg+LWSri5V2r7k46qvQ==
X-CSE-MsgGUID: kmoHP0+BQ6KpH6Qfp+TIrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74077797"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="74077797"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 07:03:42 -0700
X-CSE-ConnectionGUID: Iud0bvdQSXaAIeV7aMBwaw==
X-CSE-MsgGUID: 3Q1V1DJTTROPz0XViN08ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="222717465"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 10 Mar 2026 07:03:39 -0700
Date: Tue, 10 Mar 2026 22:29:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 06/10] hw/i386/iommu: Remove
 IntelIOMMUState::dma_drain field
Message-ID: <abAq3RsUD8bNWK30@intel.com>
References: <20260309145013.44327-1-philmd@linaro.org>
 <20260309145013.44327-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309145013.44327-7-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 09, 2026 at 03:50:08PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon,  9 Mar 2026 15:50:08 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 06/10] hw/i386/iommu: Remove IntelIOMMUState::dma_drain
>  field
> X-Mailer: git-send-email 2.53.0
> 
> The IntelIOMMUState::dma_drain boolean was only set in
> the pc_compat_3_1[] array, via the 'dma-drain=off' property.
> We removed all machines using that array, lets remove that
> property and all the code around it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20260307152635.83893-7-philmd@linaro.org>
> ---
>  include/hw/i386/intel_iommu.h |  1 -
>  hw/i386/intel_iommu.c         | 11 +----------
>  2 files changed, 1 insertion(+), 11 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


