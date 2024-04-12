Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEC6C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 11:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvFBN-0000sp-Od; Fri, 12 Apr 2024 07:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rvFBL-0000sf-1K
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:34:59 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rvFBH-0002Cl-6d
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712921695; x=1744457695;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=dlyMxfaxOonmDS5+XCzDETRRzK4rIxMFOVjW/aZ5EP8=;
 b=Fz4wFn0ZwROIwW+K09P9WYta4B3Sq0k2uA6LLJksyt0xKZsN4R8oxpzz
 WsRMdmB25C+abpb77VGFT6x2nWm44W2p2UyJbv7CI1j7A+QpjZD4cd9ms
 iOkryDe+zPX01XO5uG4MuJ4im9UC7Z1rAlKTqcsMXPa9RtiMi2b+AS1kI
 EpK1E/Jqn10pZi21yVk6IkYQhqj2IW/f//EUHHoiyxj/ZG9kESoNaryQD
 FiLm7ckhgbjcKUFCpxOABNwoIuSeKTZ2pkL21U5YFVkXmgNwg0j4SFD0Q
 zZ+Sr33BU9N1bmdqzFalylOXan7L3BN/vXeepP1ZiVmuHV+adBO8r2M7y w==;
X-CSE-ConnectionGUID: ZTLXAY9nTs+ltaygKt0cUA==
X-CSE-MsgGUID: 1Wzp759sQLazAoIiH824kw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8228907"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8228907"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2024 04:34:53 -0700
X-CSE-ConnectionGUID: 68VQyTqzQVynbkCPUOO3uQ==
X-CSE-MsgGUID: +ZjAS4UbTe+1+W78AE19bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; d="scan'208";a="44470146"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 12 Apr 2024 04:34:51 -0700
Date: Fri, 12 Apr 2024 19:48:53 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers for
 PC Q35
Message-ID: <ZhkfpQUwRMXDUSsp@intel.com>
References: <20240412085358.731560-1-zhao1.liu@linux.intel.com>
 <305d659b-d4d6-4681-bdad-cd869e552333@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <305d659b-d4d6-4681-bdad-cd869e552333@linaro.org>
Received-SPF: none client-ip=192.198.163.18;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Philippe,

On Fri, Apr 12, 2024 at 11:57:35AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Fri, 12 Apr 2024 11:57:35 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers
>  for PC Q35
> 
> > -SMP is supported with up to 255 CPUs.
> > +SMP is supported with up to 255 CPUs (and 4096 CPUs for PC Q35 machine).
> 
> This comment is not accurate since a while, IIUC:
> 
> Up to q35-2.7: 255
> q35-2.8: 288
> q35-8.0+: 1024
> q35-9.0: 4096

Yes, I think there should be no need to mention older versions here?

Since the Q35's 4096 CPUs change will be stated in the v9.0 release, I
doubt we should synchronize the doc update (so I added the "for-v9.0?"
tag to throw this question out).

Thanks,
Zhao


