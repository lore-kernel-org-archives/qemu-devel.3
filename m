Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772A0C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 02:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taQET-0000tq-KY; Tue, 21 Jan 2025 21:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taQER-0000tY-On; Tue, 21 Jan 2025 21:12:39 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taQEK-00032g-3A; Tue, 21 Jan 2025 21:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737511952; x=1769047952;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=75RHyr2RvQpWhe18SIrbqbgA8OuORkWTYTsASwaTDrg=;
 b=LkTVcCmXOJYR4Z39b445kdW2sItas39kWcADQ4kBYCip+kFmrXhFZMDi
 C5G0+h/0fC077EBUHO86V3M8aSFwHd5alTPmK4QlWbRUumjcA4vz0x0iJ
 XH4vFZ1uoWILQSR7W7vJ0H13MwUzGVLr7JLJlflKK1a/gEQDUczqYRW7O
 Q+uA1Czijiv70LZawiwVji9nFqPvvDoHoD8ZV1SBnW2nSYJAL5LsuPvRo
 LSgKZJgesxAwUzoqUpX0SHTG/d6Jt0dUoH+A8WLU9a3Ucj6pm5Umkyf4i
 q43j6/MKzPHi0WAkCiOOIcyHw1bNKFacNQwhxOZoW9z9nkUZ7rVSZNAn0 g==;
X-CSE-ConnectionGUID: UUyU43g1QN+QWSSCcBEpog==
X-CSE-MsgGUID: xpENcpuBTQibPatdZyOOZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37223321"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; d="scan'208";a="37223321"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 18:12:29 -0800
X-CSE-ConnectionGUID: Ua4grteDTGuwRPX7k5y76g==
X-CSE-MsgGUID: see2R4wxTUmQayvfkakW3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; d="scan'208";a="106810210"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 21 Jan 2025 18:12:27 -0800
Date: Wed, 22 Jan 2025 10:31:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: pl011: fix repr(C) for PL011Class
Message-ID: <Z5BYlWP/xwHJVckJ@intel.com>
References: <20250121161546.2233086-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121161546.2233086-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Tue, Jan 21, 2025 at 05:15:46PM +0100, Paolo Bonzini wrote:
> Date: Tue, 21 Jan 2025 17:15:46 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] rust: pl011: fix repr(C) for PL011Class
> X-Mailer: git-send-email 2.47.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 1 +
>  1 file changed, 1 insertion(+)
>  

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


