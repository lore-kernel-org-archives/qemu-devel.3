Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F73CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 14:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umCZZ-00040Q-8l; Wed, 13 Aug 2025 10:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1umCZO-0003zG-3S; Wed, 13 Aug 2025 10:35:14 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1umCZD-0006w1-1a; Wed, 13 Aug 2025 10:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755095703; x=1786631703;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GNjxa60oAcKUTX1ZgUGGqg5+CZgABow7Yu0WYKieG04=;
 b=aIm0EOyerxyrCb1taT6X6f1ZbPjJ6nHfm+U31s+H9BUcREjGusKYTq3X
 l7IZzPD0liuvPcN0NB7iul8jpCcFjKkvdebuYbbDBKE7opygn/k0fmoLp
 YaM1G58dVqCfxmvbBuhEi1USsOoucuIikbpeS1OrW6GmcJEAXkyxSWcFp
 5o/1PZHQqzfftBqYj6ITfeYXOGjPFYXv8uukP5vB16kMV2T6jt1Eea5S1
 nsEMyv3PhKvyOlbAUhZV7HccQS/7+wNWGdQpt20Y0s33IpDjrBcXjZXCl
 54lMe6AUq4wHSbjI6RaDRTexw+oDhlUfrXOtMBZzeCE1qM1Xzfn+TYn5Y Q==;
X-CSE-ConnectionGUID: oHzUjE4ARm+RQ/wHE6xxeA==
X-CSE-MsgGUID: ecZzSuQaTr6s/+GHslbWKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="60014627"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; d="scan'208";a="60014627"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2025 07:34:58 -0700
X-CSE-ConnectionGUID: 4ikoYzVoQHqqA/4ZfP2Jpg==
X-CSE-MsgGUID: L8ndYinvRDitUjqs9UKp9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; d="scan'208";a="171815249"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 13 Aug 2025 07:34:56 -0700
Date: Wed, 13 Aug 2025 22:56:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: Re: [RFC 00/26] rust/memory: Integrate the vm-memory API from rust-vmm
Message-ID: <aJynpEWNfbrTeirQ@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <a3272f93-8766-46a0-bda2-ddea777ef79c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3272f93-8766-46a0-bda2-ddea777ef79c@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Aug 07, 2025 at 04:13:00PM +0200, Paolo Bonzini wrote:
> Date: Thu, 7 Aug 2025 16:13:00 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 00/26] rust/memory: Integrate the vm-memory API from
>  rust-vmm
> 
> [Adding Hanna who's been working on vm-memory]
> 
> On 8/7/25 14:30, Zhao Liu wrote:
> > Hi,
> > 
> > This RFC series explores integrating the vm-memory API into QEMU's
> > rust/memory bindings.
> > 
> > Thanks to Paolo and Manos's many suggestions and feedback, I have
> > resolved many issues over the past few months, but there are still
> > some open issues that I would like to discuss.
> > 
> > This series finally provides the following safe interfaces in Rust:
> >   * AddressSpace::write in Rust <=> address_space_write in C
> >     - **but only** supports MEMTXATTRS_UNSPECIFIED
> > 
> >   * AddressSpace::read in Rust <=> address_space_read_full in C
> >     - **but only** supports MEMTXATTRS_UNSPECIFIED.
> > 
> >   * AddressSpace::store in Rust <=> address_space_st{size} in C
> >     - **but only** supports MEMTXATTRS_UNSPECIFIED and native endian.
> > 
> >   * AddressSpace::load in Rust <=> address_space_ld{size} in C
> >     - **but only** supports MEMTXATTRS_UNSPECIFIED and native endian.
> 
> Endianness can be handled by BeNN and LeNN.

About Endianness, I have more thoughts in the reply of patch 24.

> For MemTxAttrs we can use
> Bytes<(GuestAddress, MemTxAttrs)> (a variant on something you mention
> below).
> 
> Thinking out loud: maybe if we do our implementation in Bytes<(GuestAddress,
> MemTxAttrs)>, and Bytes<GuestAddress>::try_access wraps Bytes<(GuestAddress,
> MemTxAttrs)>, your downstream-only changes are not needed anymore?

with iommu support, the downstream patches are not necessary :-).

> > And this series involves changes mainly to these three parts:
> >   * NEW QEMU memory APIs wrapper at C side.
> >   * Extra changes for vm-memory (downstream for now).
> >   * NEW QEMU memory bindings/APIs based on vm-memory at Rust side.
> > 
> > Although the number of line changes appears to be significant, more
> > than half of them are documentation and comments.
> Yep, thanks for writing them.
> 
> This is a good RFC, it's complete enough to show the challenges and the
> things that are missing stand up easily.

Thank you for your quick feedback.

> I'll look into what vm-memory is missing so that we can simplify QEMU's code
> further, but the basic traits match which is nice.  And the final outcome,
> which is essentially:
> 
>     let (addr, value) = (GuestAddress(self.fsb >> 32),
>                          Le32(self.fsb as u32));
>     ADDRESS_SPACE_MEMORY.memory().store(addr, value);
> 
> is as clean as it can be, if anything a bit wordy due to the GuestAddress
> "newtype" wrapper.  (If we decide it's too bad, the convenience methods in
> AddressSpace can automatically do the GuestAddress conversion...)

Yes! For such a single function, there're lots of changes.

Thanks,
Zhao


