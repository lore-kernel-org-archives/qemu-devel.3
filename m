Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FE9C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 03:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thgbl-0005z0-LG; Mon, 10 Feb 2025 22:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thgbi-0005wE-4J; Mon, 10 Feb 2025 22:06:42 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thgbd-0007bx-Q4; Mon, 10 Feb 2025 22:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739243198; x=1770779198;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RusancdOSN5pZD6hD2Db6zM0IygsyfsprIX4VM9JsYM=;
 b=E8uO2mLV3kix3weksZ9V2FzitiZnA1rHx+Ky2/oc26OdbGgVNJwcAAut
 TQ31H7Z+JoqWrYCeofycJKYsyL24Ocxndc5/c8JwjFP3IambKleQj8yz5
 GavuFFcSp+4nV2PTxa7O4QHCH6dzn9nHiT9CAb1HZ0jMCErr6b4yatRTN
 QbXlBttIxQBD6iCm85n4JTmVqZPs1+IZpWIB6K+7jSj6qrfKAsyb9eatd
 PhDeT1gx9na5qG9viazsVq6YaFX51dmgKMTRh0IXE6C0yJVoynlWAUxAt
 jcsLqrqGens/wN7mIdpVanMfA8Nsi6Gc41r7KSfVVXl4QUECsCcaZPDxh Q==;
X-CSE-ConnectionGUID: zn5fIYZ7SROBuIU2wBe3sw==
X-CSE-MsgGUID: owpvWxz/SyeXpyygC9NKng==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39993556"
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; d="scan'208";a="39993556"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 19:06:34 -0800
X-CSE-ConnectionGUID: BLkAhMPTQbu6TqSr1p31pg==
X-CSE-MsgGUID: GMHBskXXT56DUh3Ro7voPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; d="scan'208";a="113024933"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 10 Feb 2025 19:06:32 -0800
Date: Tue, 11 Feb 2025 11:26:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 09/12] rust: bindings for MemoryRegionOps
Message-ID: <Z6rDTM4X3P95V+UA@intel.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
 <20250207101623.2443552-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207101623.2443552-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
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

On Fri, Feb 07, 2025 at 11:16:20AM +0100, Paolo Bonzini wrote:
> Date: Fri,  7 Feb 2025 11:16:20 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 09/12] rust: bindings for MemoryRegionOps
> X-Mailer: git-send-email 2.48.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs     |  51 +++----
>  rust/hw/char/pl011/src/lib.rs        |   1 -
>  rust/hw/char/pl011/src/memory_ops.rs |  34 -----
>  rust/qemu-api/meson.build            |   1 +
>  rust/qemu-api/src/lib.rs             |   1 +
>  rust/qemu-api/src/memory.rs          | 191 +++++++++++++++++++++++++++
>  rust/qemu-api/src/sysbus.rs          |   7 +-
>  rust/qemu-api/src/zeroable.rs        |   1 +
>  8 files changed, 226 insertions(+), 61 deletions(-)
>  delete mode 100644 rust/hw/char/pl011/src/memory_ops.rs
>  create mode 100644 rust/qemu-api/src/memory.rs
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


