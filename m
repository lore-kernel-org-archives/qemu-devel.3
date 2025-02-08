Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEC9C02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 10:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgiP5-0002Bu-Qw; Sat, 08 Feb 2025 05:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgiP2-0002An-9o; Sat, 08 Feb 2025 05:49:36 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgiOz-00078U-CP; Sat, 08 Feb 2025 05:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739011773; x=1770547773;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Cy5VVsknm5zsC/HihgWK+UncHjKAAjs0R8p5lxvKrcQ=;
 b=OAdMPVXqJcxP2RDvbw3gDX/pCC2pdSZ5tp9VdydfVKacbJ6T9Ox2v1yZ
 /+c8acxDOYLQujF3o0RsEoZhP+TS52FwPz1kQWmaNh0YIwo26U1PuiJLJ
 aVPMV2VGsBuOy1WWTuFDkEv/kYqpRn3muQCBBthu2Id5D2JIe27udn7R3
 DCb0ebShpqmVCnpb3m9aHDWMyrJXXmJQ959VyVv9nYGQ55ZtEOQxClmIj
 ZskWUx1IE+8J/bwPDEccF2p23J3Khint0UAICvAwcolCPen5cUeCppn5R
 hCeNUSFQRLCygQrW/cI5ngA2eYCNcU4eYGMJvjgJYM86PlPPH+7UIKynm g==;
X-CSE-ConnectionGUID: umPRpedvTJyqc1skhcYb0w==
X-CSE-MsgGUID: GidjXDPnSZWNWKdwyRLcuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50277805"
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; d="scan'208";a="50277805"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2025 02:49:29 -0800
X-CSE-ConnectionGUID: naLD3lQoQS6nNDL8gdN48A==
X-CSE-MsgGUID: R0xGM25SQ06cPwBdxEFpPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; d="scan'208";a="111523686"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 08 Feb 2025 02:49:26 -0800
Date: Sat, 8 Feb 2025 19:08:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 06/10] rust: add bindings for timer
Message-ID: <Z6c7SEjLmG6BIEQn@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-7-zhao1.liu@intel.com>
 <a30bfa1c-ddb8-4a5b-9f95-7b000c11cd54@redhat.com>
 <Z6YLwAqDGm+9aiaM@intel.com>
 <57c08026-81a2-4643-8c2a-bab1e3299432@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c08026-81a2-4643-8c2a-bab1e3299432@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
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

> Please keep init_full(); init() would be a version without some of the
> arguments (e.g. the TimerListGroup, or the attributes).

Done.

...

> > > > +        scale: u32,
> 
> While at it, can you add constants for the scale, i.e.
> 
>     pub const NS: u32 = bindings::SCALE_NS;
>     pub const US: u32 = bindings::SCALE_US;
>     pub const MS: u32 = bindings::SCALE_MS;
> 
> ? Using Timer::NS is clear enough and removes the need to import from
> "bindings".  At least in theory, bindings should not even have to be "pub"
> (or at least that's where the code should move towards).

Great! I realized this case, too.

Thanks,
Zhao


