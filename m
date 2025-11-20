Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F5ECF8861
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 14:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM5kv-0005Od-Fl; Thu, 20 Nov 2025 09:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5kt-0005Nv-QH; Thu, 20 Nov 2025 09:35:27 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5ks-0006wz-AC; Thu, 20 Nov 2025 09:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763649327; x=1795185327;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=e/JMkSbWMtHvyUA9DUy8ek+fYt4Hi5AVya5FhO0+re8=;
 b=SF34ydmVhEX2jN6Ozv47bo/cIBM36968vRufuZAF6wKRVUghgQSN1n0N
 n4U73PaDefAjegwdSELU8o1iFZPRadr2I5990OkLMs/pHVl7O268WmUaz
 PAsYDWiyy3oHzl7AF7clQO5x7MLvi5p2dCzfGHNicP7kBHvOWdf5r1FPe
 kEMGqAzbbMiav83HUIMFTSeJA1eqExi84UkcHIgEHhjkfy2zXuxQHw12Y
 loqJvG5YUUIT+JWxmzq03pQnPyq89O+MgHgpRxSed+Qkr1rCFqivD26qn
 +c622VnrKliUzSokVyfgYRUyfQdPBs3U1VNF0BpJeaOPxW2xe75CNQSg4 Q==;
X-CSE-ConnectionGUID: HcHa45WiSn+tFv8+2r8nQA==
X-CSE-MsgGUID: Bg3bFLG7TeOYlf+Dd4Hhwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65880768"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="65880768"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2025 06:35:23 -0800
X-CSE-ConnectionGUID: EqJuRxrkRa246dIOaQUj+Q==
X-CSE-MsgGUID: nowOQ2DKQKSKtR3ilwu7PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="191634112"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 20 Nov 2025 06:35:16 -0800
Date: Thu, 20 Nov 2025 22:57:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 alistair@alistair23.me, edgar.iglesias@gmail.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, palmer@dabbelt.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 berrange@redhat.com, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, vsementsov@yandex-team.ru, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 5/5] error: Consistently name Error * objects err, and
 not errp
Message-ID: <aR8sYFmEauBGe/Ln@intel.com>
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-6-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119130855.105479-6-armbru@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

On Wed, Nov 19, 2025 at 02:08:55PM +0100, Markus Armbruster wrote:
> Date: Wed, 19 Nov 2025 14:08:55 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 5/5] error: Consistently name Error * objects err, and not
>  errp
> 
> This touches code in xen_enable_tpm() that is obviously wrong.  Since
> I don't know how to fix it properly, I'm adding a FIXME there.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/crypto.c          |  8 ++++----
>  hw/acpi/ghes.c          |  8 ++++----
>  hw/ppc/spapr.c          | 16 ++++++++--------
>  hw/xen/xen-pvh-common.c | 13 ++++++++++---
>  nbd/common.c            |  6 +++---
>  5 files changed, 29 insertions(+), 22 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


