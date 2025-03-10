Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FA9C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 12:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trcf3-0003PG-Id; Mon, 10 Mar 2025 08:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trcen-000385-8v; Mon, 10 Mar 2025 08:55:00 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trcef-0001WZ-Sk; Mon, 10 Mar 2025 08:54:56 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4A2234E6030;
 Mon, 10 Mar 2025 13:54:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id eEgzcnJ1JlRt; Mon, 10 Mar 2025 13:54:40 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5C90B4E602E; Mon, 10 Mar 2025 13:54:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 58FC474577C;
 Mon, 10 Mar 2025 13:54:40 +0100 (CET)
Date: Mon, 10 Mar 2025 13:54:40 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Eric Auger <eric.auger@redhat.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 09/21] hw/vfio/pci: Convert CONFIG_KVM check to runtime
 one
In-Reply-To: <28c102c1-d157-4d22-a351-9fcc8f4260fd@redhat.com>
Message-ID: <2d44848e-01c1-25c5-dfcb-99f5112fcbd7@eik.bme.hu>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-10-philmd@linaro.org>
 <28c102c1-d157-4d22-a351-9fcc8f4260fd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1686296412-1741611280=:72286"
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

--3866299591-1686296412-1741611280=:72286
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 10 Mar 2025, Eric Auger wrote:
> Hi Philippe,
>
> On 3/9/25 12:09 AM, Philippe Mathieu-Daudé wrote:
>> Use the runtime kvm_enabled() helper to check whether
>> KVM is available or not.
>
> Miss the "why" of this patch.
>
> By the way I fail to remember/see where kvm_allowed is set.

It's in include/system/kvm.h

> I am also confused because we still have some code, like in
> vfio/common.c which does both checks:
> #ifdef CONFIG_KVM
>         if (kvm_enabled()) {
>             max_memslots = kvm_get_max_memslots();
>         }
> #endif

I think this is because if KVM is not available the if cannot be true so 
it can be left out altogether. This may make sense on platforms like 
Windows and macOS where QEMU is compiled without KVM so basically 
everywhere except Linux.

Regards,
BALATON Zoltan
--3866299591-1686296412-1741611280=:72286--

