Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1C6C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1Gc-0006pq-R9; Tue, 11 Mar 2025 11:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1ts1Ga-0006os-Ci
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:11:36 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1ts1GX-0003kd-Kp
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:11:36 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1ts1GE-00000000dJQ-1Hsa; Tue, 11 Mar 2025 16:11:14 +0100
Message-ID: <b5325f88-0f04-4989-8b2c-2a23456ae6b9@maciej.szmigiero.name>
Date: Tue, 11 Mar 2025 16:11:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/10] Add Hyper-V Dynamic Memory Protocol driver
 (hv-balloon) base
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <cover.1699279190.git.maciej.szmigiero@oracle.com>
 <0d9e8c0b670b7856d36ed155d43548d2491230e7.1699279190.git.maciej.szmigiero@oracle.com>
 <a140cfae-261e-4d78-985c-efbad93b7a9d@linaro.org>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <a140cfae-261e-4d78-985c-efbad93b7a9d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 11.03.2025 16:00, Philippe Mathieu-Daudé wrote:
> Hi Maciej,
> 
> On 6/11/23 15:20, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> This driver is like virtio-balloon on steroids: it allows both changing the
>> guest memory allocation via ballooning and (in the next patch) inserting
>> pieces of extra RAM into it on demand from a provided memory backend.
>>
>> The actual resizing is done via ballooning interface (for example, via
>> the "balloon" HMP command).
>> This includes resizing the guest past its boot size - that is, hot-adding
>> additional memory in granularity limited only by the guest alignment
>> requirements, as provided by the next patch.
>>
>> In contrast with ACPI DIMM hotplug where one can only request to unplug a
>> whole DIMM stick this driver allows removing memory from guest in single
>> page (4k) units via ballooning.
>>
>> After a VM reboot the guest is back to its original (boot) size.
>>
>> In the future, the guest boot memory size might be changed on reboot
>> instead, taking into account the effective size that VM had before that
>> reboot (much like Hyper-V does).
>>
>> For performance reasons, the guest-released memory is tracked in a few
>> range trees, as a series of (start, count) ranges.
>> Each time a new page range is inserted into such tree its neighbors are
>> checked as candidates for possible merging with it.
>>
>> Besides performance reasons, the Dynamic Memory protocol itself uses page
>> ranges as the data structure in its messages, so relevant pages need to be
>> merged into such ranges anyway.
>>
>> One has to be careful when tracking the guest-released pages, since the
>> guest can maliciously report returning pages outside its current address
>> space, which later clash with the address range of newly added memory.
>> Similarly, the guest can report freeing the same page twice.
>>
>> The above design results in much better ballooning performance than when
>> using virtio-balloon with the same guest: 230 GB / minute with this driver
>> versus 70 GB / minute with virtio-balloon.
>>
>> During a ballooning operation most of time is spent waiting for the guest
>> to come up with newly freed page ranges, processing the received ranges on
>> the host side (in QEMU and KVM) is nearly instantaneous.
>>
>> The unballoon operation is also pretty much instantaneous:
>> thanks to the merging of the ballooned out page ranges 200 GB of memory can
>> be returned to the guest in about 1 second.
>> With virtio-balloon this operation takes about 2.5 minutes.
>>
>> These tests were done against a Windows Server 2019 guest running on a
>> Xeon E5-2699, after dirtying the whole memory inside guest before each
>> balloon operation.
>>
>> Using a range tree instead of a bitmap to track the removed memory also
>> means that the solution scales well with the guest size: even a 1 TB range
>> takes just a few bytes of such metadata.
>>
>> Since the required GTree operations aren't present in every Glib version
>> a check for them was added to the meson build script, together with new
>> "--enable-hv-balloon" and "--disable-hv-balloon" configure arguments.
>> If these GTree operations are missing in the system's Glib version this
>> driver will be skipped during QEMU build.
>>
>> An optional "status-report=on" device parameter requests memory status
>> events from the guest (typically sent every second), which allow the host
>> to learn both the guest memory available and the guest memory in use
>> counts.
>>
>> Following commits will add support for their external emission as
>> "HV_BALLOON_STATUS_REPORT" QMP events.
>>
>> The driver is named hv-balloon since the Linux kernel client driver for
>> the Dynamic Memory Protocol is named as such and to follow the naming
>> pattern established by the virtio-balloon driver.
>> The whole protocol runs over Hyper-V VMBus.
>>
>> The driver was tested against Windows Server 2012 R2, Windows Server 2016
>> and Windows Server 2019 guests and obeys the guest alignment requirements
>> reported to the host via DM_CAPABILITIES_REPORT message.
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   Kconfig.host                           |    3 +
>>   hw/hyperv/Kconfig                      |   10 +
>>   hw/hyperv/hv-balloon-internal.h        |   33 +
>>   hw/hyperv/hv-balloon-page_range_tree.c |  228 +++++
>>   hw/hyperv/hv-balloon-page_range_tree.h |  118 +++
>>   hw/hyperv/hv-balloon.c                 | 1160 ++++++++++++++++++++++++
>>   hw/hyperv/meson.build                  |    1 +
>>   hw/hyperv/trace-events                 |   13 +
>>   include/hw/hyperv/hv-balloon.h         |   18 +
>>   meson.build                            |   28 +-
>>   meson_options.txt                      |    2 +
>>   scripts/meson-buildoptions.sh          |    3 +
>>   12 files changed, 1616 insertions(+), 1 deletion(-)
>>   create mode 100644 hw/hyperv/hv-balloon-internal.h
>>   create mode 100644 hw/hyperv/hv-balloon-page_range_tree.c
>>   create mode 100644 hw/hyperv/hv-balloon-page_range_tree.h
>>   create mode 100644 hw/hyperv/hv-balloon.c
>>   create mode 100644 include/hw/hyperv/hv-balloon.h
>>
>> diff --git a/Kconfig.host b/Kconfig.host
>> index d763d892693c..2ee71578f38f 100644
>> --- a/Kconfig.host
>> +++ b/Kconfig.host
>> @@ -46,3 +46,6 @@ config FUZZ
>>   config VFIO_USER_SERVER_ALLOWED
>>       bool
>>       imply VFIO_USER_SERVER
>> +
>> +config HV_BALLOON_POSSIBLE
>> +    bool
>> diff --git a/hw/hyperv/Kconfig b/hw/hyperv/Kconfig
>> index fcf65903bd05..41dd827c841b 100644
>> --- a/hw/hyperv/Kconfig
>> +++ b/hw/hyperv/Kconfig
>> @@ -16,3 +16,13 @@ config SYNDBG
>>       bool
>>       default y
>>       depends on VMBUS
>> +
>> +config HV_BALLOON_SUPPORTED
>> +    bool
>> +
>> +config HV_BALLOON
>> +    bool
>> +    default y
>> +    depends on VMBUS
>> +    depends on HV_BALLOON_POSSIBLE
> 
> Where is HV_BALLOON_POSSIBLE set?

In meson.build:
> host_kconfig = \
(..)
>  (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \

Then meson passes this as a command-line parameter
to scripts/minikconf.py, together with other similar
config values in host_kconfig.

See build/meson-logs/meson-log.txt for scripts/minikconf.py
complete command line.

Thanks,
Maciej


