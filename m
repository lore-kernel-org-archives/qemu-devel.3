Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078F4CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmvm-00015C-IP; Mon, 20 Oct 2025 06:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vAmvi-00014k-VJ
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:15:55 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vAmvf-0005Z1-OK
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:15:54 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cqrnX30gvz6K918;
 Mon, 20 Oct 2025 18:12:00 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 3AD2D14033C;
 Mon, 20 Oct 2025 18:15:37 +0800 (CST)
Received: from localhost (10.195.245.43) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Oct
 2025 11:15:36 +0100
Date: Mon, 20 Oct 2025 11:15:34 +0100
To: fanhuang <FangSheng.Huang@amd.com>
CC: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, David Hildenbrand
 <david@redhat.com>, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2] numa: add 'spm' option for Specific Purpose Memory
Message-ID: <20251020111534.00004a29@huawei.com>
In-Reply-To: <20251020090701.4036748-1-FangSheng.Huang@amd.com>
References: <20251020090701.4036748-1-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.245.43]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 20 Oct 2025 17:07:00 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Hi David and Igor,
> 
> I apologize for the delayed response. Thank you very much for your thoughtful
> questions and feedback on the SPM patch series.
> 
> Before addressing your questions, I'd like to briefly mention what the new
> QEMU patch series additionally resolves:
> 
> 1. **Corrected SPM terminology**: Fixed the description error from the previous
>    version. The correct acronym is "Specific Purpose Memory" (not "special
>    purpose memory" as previously stated).
> 
> 2. **Fixed overlapping E820 entries**: Updated the implementation to properly
>    handle overlapping E820 RAM entries before adding E820_SOFT_RESERVED
>    regions. 
> 
>    The previous implementation created overlapping E820 entries by first adding
>    a large E820_RAM entry covering the entire above-4GB memory range, then
>    adding E820_SOFT_RESERVED entries for SPM regions that overlapped with the
>    RAM entry. This violated the E820 specification and caused OVMF/UEFI
>    firmware to receive conflicting memory type information for the same
>    physical addresses.
> 
>    The new implementation processes SPM regions first to identify reserved
>    areas, then adds RAM entries around the SPM regions, generating a clean,
>    non-overlapping E820 map.

I'm definitely in favor of this support for testing purposes as well as
for the GPU cases you describe.

Given I took your brief comment on hotplug and expanded on it +CC David
and Oscar.

> 
> Now, regarding your questions:
> 
> ========================================================================
> Why SPM Must Be Boot Memory
> ========================================================================
> 
> SPM cannot be implemented as hotplug memory (DIMM/NVDIMM) because:
> 
> The primary goal of SPM is to ensure that memory is managed by guest
> device drivers, not the guest OS. This requires boot-time discovery
> for three key reasons:
> 
> 1. SPM regions must appear in the E820 memory map as `E820_SOFT_RESERVED`
>    during firmware initialization, before the OS starts.
> 
> 2. Hotplug memory is integrated into kernel memory management, making
>    it unavailable for device-specific use.

This is only sort of true and perhaps reflects support in the kernel for ACPI
features being missing as no one has yet been interested in them.
See 9.11.3 Hot-pluggable Memory Description Illustrated in the 6.6 ACPI spec.
That has an example where the EFI_MEMORY_SP bit is provided. 
I had a dig around and for now ACPICA / kernel doesn't seem to put that alongside
write_protect and the other bits that IIUC come from the same field.
It would be relatively easy to pipe that through and potentially add handling
in the memory hotplug path to allow for drivers to pick these regions up
(which boils down I think to making them visible in some way but doing nothing
else with them)

Other path would be to use a discoverable path such as emulating CXL memory.
Hotplug of that would work fine from point of view of coming up as driver managed
SPM style (the flag is in runtime data provided by the device). It would however
look different to the firmware managed approach you are using in the host.

All I want to draw attention to is that there are other ways of doing this
that might be relevant in future, but don't work for what you need to do today.
So don't see this an objection to this specific bit of work!

Thanks,

Jonathan


