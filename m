Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BE7E63C82
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 07:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjubM-0005YJ-U2; Sun, 25 Jan 2026 02:32:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vjuam-0005Sv-S3; Sun, 25 Jan 2026 02:31:28 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vjuaj-0001P0-HX; Sun, 25 Jan 2026 02:31:28 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60P7UJSV095233
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 25 Jan 2026 16:31:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ETrxvUBb90UyOUZ6fmRCwlaHHAs1kRBDCwLaLAZpmpY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1769326277; v=1;
 b=F/OjnEbwbPyL4kz34Sz5kNxAvzk1KSY5B5sMj6b+9eFp/s5RI08U0lqFqEmyUiG1
 Z1iHdCL/Bohu5Cy26DKzK1L7Vld5xFcFCevynwpLd6N0io6GTEes6Xt3trKJIcx/
 WeHoubv8yJW97I7E5mwKWjJJWtWL9jzzXFtRLKIxXEmfwxDX0uTTQU5/r7PhwZHj
 eCA+OBVwBzTnGCrMwmHhE69K1JqYlHjW32TsGOqnmJDhJKwsYk7WuNVw5qH40JSb
 2qguY3vm1GOZRbsaraOJQy6GDjzv5d8BYtmJuKjxz5L0p27LlWyKoIx4efUMHPbX
 WybZ06nuFXo71dPhk4VVkw==
Message-ID: <52384324-11dc-4ee6-a059-c1dd245753d0@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 25 Jan 2026 16:30:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] hw/arm/virt: Remove the lower bound of HighMem IO
 Regions
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, "Michael S. Tsirkin"
 <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260125-virt-v4-0-00d726b27224@rsg.ci.i.u-tokyo.ac.jp>
 <11A957F3-794E-40DD-8E39-4DB8589B1657@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <11A957F3-794E-40DD-8E39-4DB8589B1657@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/01/25 16:23, Mohamed Mediouni wrote:
> 
> 
>> On 25. Jan 2026, at 06:46, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> Remove the lower bound of the Highmem IO Regions' addresses for the
>> latest machine version to increase the chance to fit the regions in the
>> PA space.
>>
>> The lower bound was especially problematic when using virt-install on
>> Apple M2. virt-install 5.0.0 adds multiple pcie-root-port devices that
>> require sufficient space in the ECAM region. However, the Highmem ECAM
>> region did not fit in the limited PA space on the hardware, and the ECAM
>> region size was limited to 16 MiB. If virt-install had added more than
>> 16 devices to the root bridge, the region overflowed, which prevented
>> edk2-stable202505 from scanning PCI devices, including the boot disk,
>> causing boot failures.
>>
>> Ideally, a virtual machine with more than 16 devices added to the root
>> bridge should just work so that users and management layers do not have
>> to care whether they use constrained hardware.
>>
>> The base address of the Highmem IO Regions was fixed when commit
>> f90747c4e8fb ("hw/arm/virt: GICv3 DT node with one or two redistributor
>> regions") added the first Highmem IO Region. Later, commit 957e32cffa57
>> ("hw/arm/virt: Dynamic memory map depending on RAM requirements")
>> allowed moving the Highmem IO Regions to higher addresses to accommodate
>> RAM more than 255 GiB, but the lower bound remained to keep the legacy
>> memory map.
>>
>> Remove the lower bound for the latest machine version to accommodate
>> more devices with the root bridge. Keeping the lower bound for the old
>> machine versions ensures the compatibility is still maintained.
>>
>> The hardcoded memory map in tests/qtest/libqos/generic-pcihost.c is also
>> updated.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>> Changes in v4:
>> - Rebased.
>> - Edited the patch message to avoid confusing git am.
>> - Link to v3: https://lore.kernel.org/qemu-devel/20251027-virt-v3-0-fa2a2f37e32d@rsg.ci.i.u-tokyo.ac.jp
>>
>> Changes in v3:
>> - Fixed test failures reported by Peter Maydell.
>> - Link to v2: https://lore.kernel.org/qemu-devel/20250901-virt-v2-1-ac2379402c80@rsg.ci.i.u-tokyo.ac.jp
>>
>> Changes in v2:
>> - Rebased.
>> - Link to v1: https://lore.kernel.org/qemu-devel/20250728-virt-v1-1-0ab9682262c8@rsg.ci.i.u-tokyo.ac.jp
>>
>> ---
>> Akihiko Odaki (3):
>>       test/acpi: aarch64/virt: Allow DSDT and MCFG changes
>>       hw/arm/virt: Remove the lower bound of HighMem IO Regions
>>       test/acpi: aarch64/virt: Update golden masters for DSDT and MCFG
> Hi,
> 
> Would it be a good idea to have a new test configuration that keeps the old memory map? To make sure that older machine versions don’t regress

It is a nice suggestion. I will add one with the next version.

Regards,
Akihiko Odaki

