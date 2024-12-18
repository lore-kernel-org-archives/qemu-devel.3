Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AC6E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwig-0003HF-0J; Wed, 18 Dec 2024 11:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNwiM-0003G4-66; Wed, 18 Dec 2024 11:15:59 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNwiJ-0003Cq-Jx; Wed, 18 Dec 2024 11:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734538556; x=1766074556;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ZDuCEKT0/oRRNImm1XMVi47v0lb6hMFRoy25AeCBJaw=;
 b=hs5unfKaj6L6rs5Za2gWQmuJhmBPpBlfOTaLwj8lE8rMPyo4+G6SR80Q
 B9UY+ECeobBqnop2WsmWz2HYK6XmeYqdF/bKmOmHhXQ6g/lTUoRNfcXTo
 9ijEVfdRTNPz3Ql03Dt0Y8x4rqx5VGbzSk8b08BR61Afz6Uv6ebfr10AH
 lMBVJ2mcxLI02J2eJP8M2Lg3rhDjmsb8nU4wPMW1CIw/deBvoLs7dANSM
 lIaUxlurulRx1s4KxEet+taWPNQn420iEy9b94D/eQ0kE79mGw/Ni/Pod
 Mj8/t7qKzhgkBLN3FklKKdndw+nOR0MHY+OM6v2WvDnvUoVFNH+m9/Z/G g==;
X-CSE-ConnectionGUID: nL1VGdUxSeGdTJ1sYs6v/w==
X-CSE-MsgGUID: TDiVPVK7Q/uDF/7WbGmulw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34911668"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; d="scan'208";a="34911668"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 08:15:52 -0800
X-CSE-ConnectionGUID: aEJDl8zWTMqdq1zsFDQVMA==
X-CSE-MsgGUID: or0tceHkRTuUzrBj/QC8pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; d="scan'208";a="98464566"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 18 Dec 2024 08:15:46 -0800
Date: Thu, 19 Dec 2024 00:34:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 2/2] target/i386/sev: Reduce system specific declarations
Message-ID: <Z2L5kvVIr3JpvMzu@intel.com>
References: <20241218155913.72288-1-philmd@linaro.org>
 <20241218155913.72288-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241218155913.72288-3-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Dec 18, 2024 at 04:59:13PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 18 Dec 2024 16:59:13 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 2/2] target/i386/sev: Reduce system specific declarations
> X-Mailer: git-send-email 2.45.2
> 
> "system/confidential-guest-support.h" is not needed,
> remove it. Reorder #ifdef'ry to reduce declarations
> exposed on user emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/sev.h  | 29 ++++++++++++++++-------------
>  hw/i386/pc_sysfw.c |  2 +-
>  2 files changed, 17 insertions(+), 14 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


