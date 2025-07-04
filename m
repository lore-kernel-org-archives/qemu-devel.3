Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEF1C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 04:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXY9R-00078V-IJ; Fri, 04 Jul 2025 00:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1uXY9Q-00077V-03
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 00:35:52 -0400
Received: from out-178.mta1.migadu.com ([95.215.58.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1uXY9N-0000k5-DO
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 00:35:51 -0400
Date: Fri, 4 Jul 2025 13:35:27 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1751603736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cpwlsgHAJHmGu3j0rbHKkvBMAPaTp7uD86HXoaJWHEE=;
 b=X3d+5IhYd6OuDRV/UG6J+gDg4M1q4Zla1NShlbf4noqAVLM/QeqWqRTiaGXEKXuthaAWBK
 mogpSn//fUNkGIpuIdO8EDty/WXD0u6+0Fk9eC1cZ9DTpWLSlbfhKt9dUXXDA69/Pq4R4X
 L7m1s4vfsbzFmbwB9DMLXz7zQNGWLFs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, mst@redhat.com,
 Zhijian Li <lizhijian@fujitsu.com>, linuxarm@huawei.com,
 linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH qemu v17 0/5] arm/virt: CXL support via pxb_cxl
Message-ID: <aGdaD6Q6GAZtjIDg@vm4>
References: <20250703104110.992379-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703104110.992379-1-Jonathan.Cameron@huawei.com>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.178;
 envelope-from=itaru.kitayama@linux.dev; helo=out-178.mta1.migadu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 03, 2025 at 11:41:05AM +0100, Jonathan Cameron wrote:
> v17: Thanks to Eric for review
> - Add a comment to the high memory map to reduce the chance of nasty
>   surprises in the future as similar to device_memory, the CXL
>   Fixed Memory Windows are of variable size as so can't be represented
>   by explicit entries in the map.
> - Updated a couple of patch descriptions to provide answers to questions
>   Eric raised.

I also tested the cxl/next kernel; it boots fine with CXL devices.  

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>

> 
> v16:
> - Mostly additional documentation and descriptive text in
>   patch titles.
> - Update test to reflect changes to other tests.
> - Update physmem_max in virt to include the CXL memory.
> 
> Updated cover letter
> 
> Back in 2022, this series stalled on the absence of a solution to device
> tree support for PCI Expander Bridges (PXB) and we ended up only having
> x86 support upstream. I've been carrying the arm64 support out of tree
> since then, with occasional nasty surprises (e.g. UNIMP + DT issue seen
> a few weeks ago) and a fair number of fiddly rebases.
> gitlab.com/jic23/qemu cxl-<latest date>.  Will update shortly with this
> series.
> 
> A recent discussion with Peter Maydell indicated that there are various
> other ACPI only features now, so in general he might be more relaxed
> about DT support being necessary. The upcoming vSMMUv3 support would
> run into this problem as well.
> 
> I presented the background to the PXB issue at Linaro connect 2022. In
> short the issue is that PXBs steal MMIO space from the main PCI root
> bridge. The challenge is knowing how much to steal.
> 
> On ACPI platforms, we can rely on EDK2 to perform an enumeration and
> configuration of the PCI topology and QEMU can update the ACPI tables
> after EDK2 has done this when it can simply read the space used by the
> root ports. On device tree, there is no entity to figure out that
> enumeration so we don't know how to size the stolen region.
> 
> Three approaches were discussed:
> 1) Enumerating in QEMU. Horribly complex and the last thing we want is a
>    3rd enumeration implementation that ends up out of sync with EDK2 and
>    the kernel (there are frequent issues because of how those existing
>    implementations differ.
> 2) Figure out how to enumerate in kernel. I never put a huge amount of work
>    into this, but it seemed likely to involve a nasty dance with similar
>    very specific code to that EDK2 is carrying and would very challenging
>    to upstream (given the lack of clarity on real use cases for PXBs and
>    DT).
> 3) Hack it based on the control we have which is bus numbers.
>    No one liked this but it worked :)
> 
> The other little wrinkle would be the need to define full bindings for CXL
> on DT + implement a fairly complex kernel stack as equivalent in ACPI
> involves a static table, CEDT, new runtime queries via _DSM and a description
> of various components. Doable, but so far there is no interest on physical
> platforms. Worth noting that for now, the QEMU CXL emulation is all about
> testing and developing the OS stack, not about virtualization (performance
> is terrible except in some very contrived situations!)
> 
> There is only a very simple test in here, because my intent is not to
> duplicate what we have on x86, but just to do a smoke test that everything
> is hooked up.  In general we need much more comprehensive end to end CXL
> tests but that requires a reaonsably stable guest software stack. A few
> people have expressed interest in working on that, but we aren't there yet.
> 
> Note that this series has a very different use case to that in the proposed
> SBSA-ref support:
> https://lore.kernel.org/qemu-devel/20250117034343.26356-1-wangyuquan1236@phytium.com.cn/
> 
> SBSA-ref is a good choice if you want a relatively simple mostly fixed
> configuration.  That works well with the limited host system
> discoverability etc as EDK2 can be build against a known configuration.
> 
> My interest with this support in arm/virt is support host software stack
> development (we have a wide range of contributors, most of whom are working
> on emulation + the kernel support). I care about the weird corners. As such
> I need to be able to bring up variable numbers of host bridges, multiple CXL
> Fixed Memory Windows with varying characteristics (interleave etc), complex
> NUMA topologies with wierd performance characteristics etc. We can do that
> on x86 upstream today, or my gitlab tree. Note that we need arm support
> for some arch specific features in the near future (cache flushing).
> Doing kernel development with this need for flexibility on SBSA-ref is not
> currently practical. SBSA-ref CXL support is an excellent thing, just
> not much use to me for this work.
> 
> Also, we are kicking off some work on DCD virtualization, particularly to
> support inter-host shared memory being presented up into a VM. That
> will need upstream support on arm64 as it is built on top of the existing
> CXL emulation to avoid the need for a separate guest software stack.
> 
> Note this is TCG only - it is possible to support limited use with KVM but
> that needs additional patches not yet ready for upstream.  The challenge
> is interleave - and the solution is don't interleave if you want to run
> with KVM.
> 
> Jonathan Cameron (5):
>   hw/cxl-host: Add an index field to CXLFixedMemoryWindow
>   hw/cxl: Make the CXL fixed memory windows devices.
>   hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances
>     pxb-cxl
>   docs/cxl: Add an arm/virt example.
>   qtest/cxl: Add aarch64 virt test for CXL
> 
>  docs/system/arm/virt.rst    |   9 ++
>  docs/system/devices/cxl.rst |  11 +++
>  include/hw/arm/virt.h       |   4 +
>  include/hw/cxl/cxl.h        |   5 +-
>  include/hw/cxl/cxl_host.h   |   5 +-
>  hw/acpi/cxl.c               |  76 ++++++++--------
>  hw/arm/virt-acpi-build.c    |  34 +++++++
>  hw/arm/virt.c               |  30 +++++++
>  hw/cxl/cxl-host-stubs.c     |   7 +-
>  hw/cxl/cxl-host.c           | 174 +++++++++++++++++++++++++++++-------
>  hw/i386/pc.c                |  50 +++++------
>  tests/qtest/cxl-test.c      |  58 +++++++++---
>  tests/qtest/meson.build     |   1 +
>  13 files changed, 354 insertions(+), 110 deletions(-)
> 
> -- 
> 2.48.1
> 

