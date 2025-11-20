Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487B4CF8863
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 14:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM5qG-0007TM-5g; Thu, 20 Nov 2025 09:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5pl-0007QZ-IR
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 09:40:30 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5ph-0008Iu-NW
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 09:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763649625; x=1795185625;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZQPBGdwEVZys6Nj70wp7Yb3SiJyeCijBmhuG0lV6h5Q=;
 b=BteejHV/AG3Vq+oE4avKYfnFcJoX7IPV7UhGTbCLHvJeWtFHlhW8AeXt
 9AgxKVk2GaQdUhs1Fr7eTw2vDWVbo6NFPqiAL2gIGEVElg+1lKiXY68gX
 cUianrTXkd+HxeSjyEpNSdOpHkphKp3aX8H3JqigmwT7GXNAJw4mTqQZn
 oK4smUZCC9OrpfcNotSWFoiD8neWKtqjSAFCU8OfMC+NKoUn6atv7pnD4
 LhL2I0T2sYiazamlhfRu+8ZRjama8e8AY86OAKHtN2umRR2rwc0F5juW8
 qLy8UH9Pc913ajALDv1eNnqCBCaI1ZrUhQ6bpV3amd6FtgEfjJGAAiNyo A==;
X-CSE-ConnectionGUID: X+/aKlYpTreOFaZvv8AmwQ==
X-CSE-MsgGUID: hhY7LSWzRESn2USZCKTY9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65661695"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="65661695"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2025 06:40:23 -0800
X-CSE-ConnectionGUID: dk/z4CbpQpyAYTgHbvfJ5g==
X-CSE-MsgGUID: WUqPPN0USVmVeYvcg4tdeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="191634661"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 20 Nov 2025 06:40:18 -0800
Date: Thu, 20 Nov 2025 23:02:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Glenn Miles <milesg@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH for-11.0 08/15] tests/functional/x86_64/test_memlock:
 Silence pylint warnings
Message-ID: <aR8tjvwkI8k+GBPR@intel.com>
References: <20251119082636.43286-1-thuth@redhat.com>
 <20251119082636.43286-9-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119082636.43286-9-thuth@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

On Wed, Nov 19, 2025 at 09:26:29AM +0100, Thomas Huth wrote:
> Date: Wed, 19 Nov 2025 09:26:29 +0100
> From: Thomas Huth <thuth@redhat.com>
> Subject: [PATCH for-11.0 08/15] tests/functional/x86_64/test_memlock:
>  Silence pylint warnings
> 
> From: Thomas Huth <thuth@redhat.com>
> 
> Pylint complains about a missing "encoding" parameter for the open()
> function here, and about a missing return statement in the "except"
> block (which cannot happen since skipTest() never returns). Rework
> the code a little bit to silence the warnings.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/x86_64/test_memlock.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


