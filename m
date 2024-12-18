Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F167E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNweo-00008x-GN; Wed, 18 Dec 2024 11:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNwel-00007p-Ih; Wed, 18 Dec 2024 11:12:16 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNwei-0002MS-V3; Wed, 18 Dec 2024 11:12:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734538333; x=1766074333;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ucG6hpTV+IReE+lOfCzMaRfXRUtudEvIopsU4oH+NGE=;
 b=M/GS5RtrVveGtudhlsZ878c9COMJ1ngBOf9r/9TxqpDyqameeEpxEajO
 s+qzTY+9nw3/E6kMHWHlI8vkPcoiKYAtpeOyF6NcfJHsEUsNi/hlQtDvx
 9/onnS7zLaxFRckgGQZk+Zju/Jn45xG8wSYGFtQiXcgx7uCuG4fhk2tu5
 Y1Nmm07V+Yrf/EHMbffnlr5lszUke2x1dyYmnBBgCEgU6ZXS7EElWSOb2
 IXNw2WI+KcY4qLiPJEqo+qdeoHeUIYA7RxtQzjWq/FcgF2PTJlQrpnn/I
 +P0VxlIqQmVfat03KQRofkNAqHbDeb38dxAa+n9Gw0y1l88MY+tArMStK w==;
X-CSE-ConnectionGUID: fGBVPlgSTWa57y9aRZgTag==
X-CSE-MsgGUID: OrVy+VuiSSGBkZVs7DrZOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46029670"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; d="scan'208";a="46029670"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 08:12:06 -0800
X-CSE-ConnectionGUID: tmGK/hGKRq60K++Lad7knw==
X-CSE-MsgGUID: fWJY/bGUTrOKqmE5Tbi2rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="98724460"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 18 Dec 2024 08:12:02 -0800
Date: Thu, 19 Dec 2024 00:30:41 +0800
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
Subject: Re: [PATCH 1/2] system: Move 'exec/confidential-guest-support.h' to
 system/
Message-ID: <Z2L4seQo7Z7LPpTh@intel.com>
References: <20241218155913.72288-1-philmd@linaro.org>
 <20241218155913.72288-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241218155913.72288-2-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Wed, Dec 18, 2024 at 04:59:12PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 18 Dec 2024 16:59:12 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 1/2] system: Move 'exec/confidential-guest-support.h' to
>  system/
> X-Mailer: git-send-email 2.45.2
> 
> "exec/confidential-guest-support.h" is specific to system
> emulation, so move it under the system/ namespace.
> Mechanical change doing:
> 
>   $ sed -i \
>     -e 's,exec/confidential-guest-support.h,sysemu/confidential-guest-support.h,' \
>         $(git grep -l exec/confidential-guest-support.h)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/{exec => system}/confidential-guest-support.h | 6 +++---
>  target/i386/confidential-guest.h                      | 2 +-
>  target/i386/sev.h                                     | 2 +-
>  backends/confidential-guest-support.c                 | 2 +-
>  hw/core/machine.c                                     | 2 +-
>  hw/ppc/pef.c                                          | 2 +-
>  hw/ppc/spapr.c                                        | 2 +-
>  hw/s390x/s390-virtio-ccw.c                            | 2 +-
>  system/vl.c                                           | 2 +-
>  target/s390x/kvm/pv.c                                 | 2 +-
>  10 files changed, 12 insertions(+), 12 deletions(-)
>  rename include/{exec => system}/confidential-guest-support.h (96%)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

(MAINTAINERS is missed to change? :-))


