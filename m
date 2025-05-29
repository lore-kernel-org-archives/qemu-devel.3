Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00C2C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKVaa-00070L-Hr; Thu, 29 May 2025 01:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1uKVaY-00070A-It
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:13:58 -0400
Received: from out-178.mta0.migadu.com ([91.218.175.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1uKVaP-0007ut-UJ
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:13:58 -0400
Date: Thu, 29 May 2025 14:13:30 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1748495620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ft5agwKDm8mVsjeLDhOw5RT0PS9jra2LFUmmBHo9PzE=;
 b=YMikC+Lt8WyYOzjn3zlw0vWqHTGW1zCE2G6beXc++FC/N1ZK4RytW87EtTmHQp/9ZefJNv
 8GSKMe+uPmC1wWA7cxxXzjWUYUgdB+fQVzJpWzGGXOTRporoy0vxi/emfirt/H7r1NINB3
 +qtBmZG7Q1tuZKXF4bP4EAuRQYUbZpo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>, mst@redhat.com,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alireza Sanaee <alireza.sanaee@huawei.com>
Subject: Re: [PATCH v14 0/5] arm/virt: CXL support via pxb_cxl
Message-ID: <aDfs+gIkK5ekKBXx@vm4>
References: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.178;
 envelope-from=itaru.kitayama@linux.dev; helo=out-178.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, May 28, 2025 at 12:07:21PM +0100, Jonathan Cameron wrote:
> v14: Simplifications suggeseted by Itaru (and some extra simplifications
>      that became apparent) and gather tags.
>      See individual patches for more information.
> 
> Updated cover letter
> 
> Richard Henderson has posted a pull request with a fix for the TCG TLB
> issue which will hopefully merge shortly (Thanks Richard!).
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

Series applied cleanly on top of today's QEMU. And I confirm that
qtest-aarch64/cxl-test passes the test as it should and ndctl cxl test
suite ran fine 11 out of 12 (1 SKIP) on this series again this time tracing
subsystem enabled as Alison suggested. Used the Intel folk cxl/next
kernel.

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>

Thanks,
Itaru.

> 
> Jonathan Cameron (5):
>   hw/cxl-host: Add an index field to CXLFixedMemoryWindow
>   hw/cxl: Make the CXL fixed memory windows devices.
>   hw/cxl-host: Allow split of establishing memory address and mmio
>     setup.
>   hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances
>     pxb-cxl
>   qtest/cxl: Add aarch64 virt test for CXL
> 
>  include/hw/arm/virt.h     |   4 +
>  include/hw/cxl/cxl.h      |   4 +
>  include/hw/cxl/cxl_host.h |   6 +-
>  hw/acpi/cxl.c             |  76 +++++++--------
>  hw/arm/virt-acpi-build.c  |  34 +++++++
>  hw/arm/virt.c             |  29 ++++++
>  hw/cxl/cxl-host-stubs.c   |   8 +-
>  hw/cxl/cxl-host.c         | 190 ++++++++++++++++++++++++++++++++------
>  hw/i386/pc.c              |  51 +++++-----
>  tests/qtest/cxl-test.c    |  59 +++++++++---
>  tests/qtest/meson.build   |   1 +
>  11 files changed, 353 insertions(+), 109 deletions(-)
> 
> -- 
> 2.48.1
> 

