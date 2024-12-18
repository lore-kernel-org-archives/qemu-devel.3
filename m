Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CF9E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 14:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNv4H-0000h9-La; Wed, 18 Dec 2024 09:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNv3w-0000Ya-Tf; Wed, 18 Dec 2024 09:30:14 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNv3v-0004FM-4U; Wed, 18 Dec 2024 09:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734532207; x=1766068207;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ECYa1ISu3mUk8ZxqBTRCpB9mnPeFUyXwRxUzf2tDNLM=;
 b=QZug9hUmeUKuryWNIv2Wj43ArMGCPglxDLJzP0FqwJ8b+inXs5IFK+Zg
 6HELaz8rLTV4osT1xvpz5k3OupICyoz5ESnq7OFrUy2KG/az5NwDOeXLD
 TucPkndSlGj9IM+0km+ZDYhvK4eR65ojCzrqP2l4E/mq2HF55sd48JETG
 /O9s9o/K6+4k8fuIRC8+ewyr43kkoEc1h6sQt6ifO6ZyiyDQA+CgO+W0e
 1SHqYHRcm8BFueP3nhKlYS0HqBci3ujkw1Q3t8KBH/6bNO+dSju0yv96G
 9z1QFx0h7sp/giXWfoMoi9jpaLWTpBGj+C7IJvbhQrfTMMBj0YA7BA0sF g==;
X-CSE-ConnectionGUID: hy2up2pAQzS23wSrWgoY6A==
X-CSE-MsgGUID: k7oD2YOsQRepm4oPV0JIOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="52535594"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; d="scan'208";a="52535594"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 06:28:44 -0800
X-CSE-ConnectionGUID: 5u3AVuLqSxukXA4SqUdiBw==
X-CSE-MsgGUID: rCfhBhv+Qb+DBddVO2/law==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="102019948"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 18 Dec 2024 06:28:43 -0800
Date: Wed, 18 Dec 2024 22:47:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 24/26] rust: qom: move device_id to PL011 class side
Message-ID: <Z2Lge39BPLR2dTAt@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-25-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-25-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
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

On Mon, Dec 09, 2024 at 01:37:15PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:37:15 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 24/26] rust: qom: move device_id to PL011 class side
> X-Mailer: git-send-email 2.47.1
> 
> There is no need to monkeypatch DeviceId::Luminary into the already-initialized
> PL011State.  Instead, now that we can define a class hierarchy, we can define
> PL011Class and make device_id a field in there.
> 
> There is also no need anymore to have "Arm" as zero, so change DeviceId into a
> wrapper for the array; all it does is provide an Index<hwaddr> implementation
> because arrays can only be indexed by usize.
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 59 +++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 31 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


