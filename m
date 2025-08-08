Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A07DC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHy0-0007iX-RG; Fri, 08 Aug 2025 03:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ukHxq-0007gF-Rm; Fri, 08 Aug 2025 03:56:35 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ukHxm-0004u1-Vk; Fri, 08 Aug 2025 03:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754639791; x=1786175791;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=MSBG2C2T4HKi4e6nVEf13wGKcbe/sABWR7tyiRwbU/0=;
 b=OwUmHRu2ULECXl6F2VcvXjOKNmeWDAm/NOQ1GPlltigqxB8dbRiOGNc5
 jLTCzLUNiqlD4LXm+EAeCVCCX69/LrQGomi3/OORjJogCQ04/J+dDSWK6
 pyn5q92YbaCNCZvOK+Kp+ac0CfLEDbUWUNcez3q3V+V5cQUWgwRfXWymb
 wXsPrV9eBLiJ5EqgFSwylL3wFpd9ggNqPkhEthmuRGbVdFrnGyb1+BZOE
 pC4QAHnS/LC1EB8buDHbsKXOzCsvKEHcPGASDlwlWeC1mEWVDlTdHhlWJ
 VaGZaaZLgI4RK5pN8bk3j3B8UD6GSruCPQh7gDY92fHs5LD/blRkRrJuy Q==;
X-CSE-ConnectionGUID: YNbyzv12Q7qbNiMubrK/Bg==
X-CSE-MsgGUID: d5t62mEJRYSy8xMY/UFrBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="79542219"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="79542219"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 00:56:24 -0700
X-CSE-ConnectionGUID: rKnuzrZ7TE+OnqxLaiTP6g==
X-CSE-MsgGUID: P2SlIW4iSEeaSqUEN+LCow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="166062214"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2025 00:56:20 -0700
Date: Fri, 8 Aug 2025 16:17:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: Re: [RFC 10/26] subprojects/vm-memory: Patch vm-memory for QEMU
 memory backend
Message-ID: <aJWyt+4JRzqhfIzU@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-11-zhao1.liu@intel.com>
 <d144ae17-afe3-4578-a875-79c1d6a4d723@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d144ae17-afe3-4578-a875-79c1d6a4d723@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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

(+Hanna: I would like to align with Hanna on 0002.diff patch :-))

On Thu, Aug 07, 2025 at 03:59:26PM +0200, Paolo Bonzini wrote:
> Date: Thu, 7 Aug 2025 15:59:26 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 10/26] subprojects/vm-memory: Patch vm-memory for QEMU
>  memory backend
> 
> On 8/7/25 14:30, Zhao Liu wrote:
> > Add 2 patches to support QEMU memory backend implementation.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   .../packagefiles/vm-memory-0.16-rs/0001.diff  |  81 +++++++++++++
> >   .../packagefiles/vm-memory-0.16-rs/0002.diff  | 111 ++++++++++++++++++
> >   subprojects/vm-memory-0.16-rs.wrap            |   2 +
> >   3 files changed, 194 insertions(+)
> >   create mode 100644 subprojects/packagefiles/vm-memory-0.16-rs/0001.diff
> >   create mode 100644 subprojects/packagefiles/vm-memory-0.16-rs/0002.diff
> > 
> > diff --git a/subprojects/packagefiles/vm-memory-0.16-rs/0001.diff b/subprojects/packagefiles/vm-memory-0.16-rs/0001.diff
> > new file mode 100644
> > index 000000000000..037193108d45
> > --- /dev/null
> > +++ b/subprojects/packagefiles/vm-memory-0.16-rs/0001.diff
> > @@ -0,0 +1,81 @@
> > +From 298f8ba019b2fe159fa943e0ae4dfd3c83ee64e0 Mon Sep 17 00:00:00 2001
> > +From: Zhao Liu <zhao1.liu@intel.com>
> > +Date: Wed, 6 Aug 2025 11:31:11 +0800
> > +Subject: [PATCH 1/2] guest_memory: Add a marker tarit to implement
> > + Bytes<GuestAddress> for GuestMemory
> 
> This was a bit surprising.  Maybe this is something where GuestMemory needs
> some extra flexibility.

At least, the default GuestMemory::try_access() need to re-implement in
QEMU, and this is because GuestMemory::iter() doesn't fit for QEMU's
case, and GuestMemory::to_region_addr() also needs adjustment to support
complete translation.

For details,

1) iter() - QEMU has implemented the two-level "page" walk in
   `phys_page_find`, which is more efficient than linear iteration.

2) to_region_addr() - it's function signature is:

    fn to_region_addr(
        &self,
	addr: GuestAddress
    ) -> Option<(&Self::R, MemoryRegionAddress)>;

but QEMU currentlt wants:

    fn translate(
        &self,
        addr: GuestAddress,
        len: GuestUsize,
        is_write: bool,
    ) -> Option<(&MemoryRegionSection, MemoryRegionAddress, GuestUsize)>

`is_write` is mainly about IOMMU (and read-only case, but that could be
workaround I think).

And the 3rd member `GuestUsize` of (&MemoryRegionSection,
MemoryRegionAddress, GuestUsize) indicates the remianing size, which is
used to detect cross-region case. Maybe this `GuestUsize` is not
necessary in its return, since we can check the size of `MemoryRegionSection`
later. But this would be a bit repetitive.

But at least, this marker trait is acceptable, right? :-)

The marker trait for GuestMemoryRegion is introduced at commit 66ff347
("refactor: use matches! instead of to_string() for tests").

> > @@ -0,0 +1,111 @@
> > +From 2af7ea12a589fde619690e5060c01710cb6f2e0e Mon Sep 17 00:00:00 2001
> > +From: Zhao Liu <zhao1.liu@intel.com>
> > +Date: Wed, 6 Aug 2025 14:27:14 +0800
> > +Subject: [PATCH 2/2] guest_memory: Add is_write argument for
> > + GuestMemory::try_access()
> 
> This should be fine.  But Hanna is also working on IOMMU so maybe this won't
> be needed!

I'm not sure what method could align with Hanna's design. If there's
another interface/method, I can have a try.

Or, should I just ignore all IOMMU code path directly? This may need
to decouple some C codes. For example, I can split flatview_do_translate
into a non-iommu case and an iommu case.

Thanks,
Zhao


