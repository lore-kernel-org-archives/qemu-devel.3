Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775ACC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 20:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr0vP-0007Nk-Kc; Sat, 08 Mar 2025 15:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tr0vM-0007NN-5N; Sat, 08 Mar 2025 15:37:32 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tr0vJ-0002Lj-E4; Sat, 08 Mar 2025 15:37:31 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 87EFE4E6019;
 Sat, 08 Mar 2025 21:37:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id r1rTlAZHgZ2I; Sat,  8 Mar 2025 21:37:14 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8D0354E600E; Sat, 08 Mar 2025 21:37:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8A24974577C;
 Sat, 08 Mar 2025 21:37:14 +0100 (CET)
Date: Sat, 8 Mar 2025 21:37:14 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Tony Krowiak <akrowiak@linux.ibm.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, kvm@vger.kernel.org, 
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhenzhong Duan <zhenzhong.duan@intel.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, 
 Jason Herne <jjherne@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 00/14] hw/vfio: Build various objects once
In-Reply-To: <180f941a-74ce-41c0-999d-e0d4cef85c3d@redhat.com>
Message-ID: <8a529a1f-e2d7-81b6-1416-821c8f038d5e@eik.bme.hu>
References: <20250307180337.14811-1-philmd@linaro.org>
 <180f941a-74ce-41c0-999d-e0d4cef85c3d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1416162988-1741466234=:44901"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1416162988-1741466234=:44901
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 8 Mar 2025, Cédric Le Goater wrote:
> Hello,
>
> On 3/7/25 19:03, Philippe Mathieu-Daudé wrote:
>> By doing the following changes:
>> - Clean some headers up
>> - Replace compile-time CONFIG_KVM check by kvm_enabled()
>> - Replace compile-time CONFIG_IOMMUFD check by iommufd_builtin()
>> we can build less vfio objects.
>> 
>> Philippe Mathieu-Daudé (14):
>>    hw/vfio/common: Include missing 'system/tcg.h' header
>>    hw/vfio/spapr: Do not include <linux/kvm.h>
>>    hw/vfio: Compile some common objects once
>>    hw/vfio: Compile more objects once
>>    hw/vfio: Compile iommufd.c once
>>    system: Declare qemu_[min/max]rampagesize() in 'system/hostmem.h'
>>    hw/vfio: Compile display.c once
>>    system/kvm: Expose kvm_irqchip_[add,remove]_change_notifier()
>>    hw/vfio/pci: Convert CONFIG_KVM check to runtime one
>>    system/iommufd: Introduce iommufd_builtin() helper
>>    hw/vfio/pci: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
>>    hw/vfio/ap: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
>>    hw/vfio/ccw: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
>>    hw/vfio/platform: Check CONFIG_IOMMUFD at runtime using
>>      iommufd_builtin
>>
>>   docs/devel/vfio-iommufd.rst  |  2 +-
>>   include/exec/ram_addr.h      |  3 --
>>   include/system/hostmem.h     |  3 ++
>>   include/system/iommufd.h     |  8 +++++
>>   include/system/kvm.h         |  8 ++---
>>   target/s390x/kvm/kvm_s390x.h |  2 +-
>>   accel/stubs/kvm-stub.c       | 12 ++++++++
>>   hw/ppc/spapr_caps.c          |  1 +
>>   hw/s390x/s390-virtio-ccw.c   |  1 +
>>   hw/vfio/ap.c                 | 27 ++++++++---------
>>   hw/vfio/ccw.c                | 27 ++++++++---------
>>   hw/vfio/common.c             |  1 +
>>   hw/vfio/iommufd.c            |  1 -
>>   hw/vfio/migration.c          |  1 -
>>   hw/vfio/pci.c                | 57 +++++++++++++++++-------------------
>>   hw/vfio/platform.c           | 25 ++++++++--------
>>   hw/vfio/spapr.c              |  4 +--
>>   hw/vfio/meson.build          | 33 ++++++++++++---------
>>   18 files changed, 117 insertions(+), 99 deletions(-)
>> 
>
> Patches 1-9 look ok and should be considered for the next PR if
> maintainers ack patch 6 and 8.
>
>
> Some comments,
>
> vfio-amd-xgbe and vfio-calxeda-xgmac should be treated like
> vfio-platform, and since vfio-platform was designed for aarch64,
> these devices should not be available on arm, ppc, ppc64, riscv*,
> loongarch. That said, vfio-platform and devices being deprecated in
> the QEMU 10.0 cycle, we could just wait for the removal in QEMU 10.2.
>
> How could we (simply) remove CONFIG_VFIO_IGD in hw/vfio/pci-quirks.c ?
> and compile this file only once.
>
> The vfio-pci devices are available in nearly all targets when it
> only makes sense to have them in i386, x86_64, aarch64, ppc64,
> where they are supported, and also possibly in ppc (tcg) and arm
> (tcg) for historical reasons and just because they happen to work.
> ppc (tcg) doesn't support MSIs with vfio-pci devices so I don't
> think we care much.

Maybe it does not support MSI yet but if it can be fixed I might be 
interested later. But I don't know how that should work and what's needed 
for it in QEMU. There are ppc machines with PCIe ports (like sam460ex but 
I did not implement PCIe on it yet) and some GPUs could be used on those 
so having MSI might help or be needed. If it works on the real machine it 
could work on QEMU too. Currently people who tried GPU pass through on ppc 
told that it works but slow. I don't know the why or how to debug that but 
could it be due to missing MSI support? If so we might be interested to 
solve that eventually if possible.

Regards,
BALATON Zoltan
--3866299591-1416162988-1741466234=:44901--

