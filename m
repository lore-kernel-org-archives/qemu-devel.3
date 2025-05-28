Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CD0C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKCMZ-0004qv-2H; Wed, 28 May 2025 04:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uKCMW-0004qj-RF; Wed, 28 May 2025 04:42:12 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uKCMU-0001Ni-77; Wed, 28 May 2025 04:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748421730; x=1779957730;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Tv1Nmb9MVc0rlhYt0PJr2r6FT+vfiJYAXZOvqzzfDHI=;
 b=c3ClWkD4vr55BWCGcYad7QMgNRXXE5xobs2IurToHlvNKdMcYB1WnhMQ
 9suDY95hFgidHLh7M86zqEbRiHB8zQ43wFHFXw0v3iJms+/xo6Abjsouc
 hgkp95ZdBZEAFgpONxrZpa/mpVYmGGoThFgFqV8H8PP7xjBp7Sr2ehGgx
 QqQZ+BuKTv22b+VMBxkMPaF+GGmC7qo8la9kflFs6S7xYuJdyS8XddqB5
 TVqqeyi6Qrtk2pjhrk9GasfIACH1Mfuec1wXvzwXhQE3x5tnyIgryuWvd
 1QfK9UfcVMAvXcZ+V7HVKB28KUF+mpLJEW+NwhmVPNS0tnjfF0wT8cy9D A==;
X-CSE-ConnectionGUID: iQNn3Mp4QEainM2Wa98BPA==
X-CSE-MsgGUID: x1NorHcqTniYymjirCS2MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="61068642"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="61068642"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 01:40:52 -0700
X-CSE-ConnectionGUID: HBVPn3OeQzygx4G4J1heoA==
X-CSE-MsgGUID: Hf3+NJENQAOEySJNfAUFRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="174172358"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 01:40:46 -0700
Message-ID: <76cad745-2d12-4150-8592-6cc63a6992d7@intel.com>
Date: Wed, 28 May 2025 16:40:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/19] hw/i386/pc: Remove deprecated 2.4 and 2.5 PC
 machines
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <5a9ec134-d4cb-49d5-8747-437616e3c36a@intel.com>
 <60beed5e-2cf3-4b4a-b717-7ccae1df1fa7@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <60beed5e-2cf3-4b4a-b717-7ccae1df1fa7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/28/2025 4:11 PM, Thomas Huth wrote:
> On 28/05/2025 05.01, Xiaoyao Li wrote:
>> On 5/12/2025 4:39 PM, Philippe Mathieu-Daudé wrote:
>>> (series reviewed)
>>>
>>> Since v3:
>>> - Fixed 2 issues noticed by Thomas (floppy fallback, e1000)
>>>
>>> Since v2:
>>> - Removed qtest in test-x86-cpuid-compat.c
>>>
>>> Since v1:
>>> - Fixed issues noticed by Thomas
>>>
>>> The versioned 'pc' and 'q35' machines up to 2.12 been marked
>>> as deprecated two releases ago, and are older than 6 years,
>>> so according to our support policy we can remove them.
>>>
>>> This series only includes the 2.4 and 2.5 machines removal,
>>> as it is a big enough number of LoC removed. Rest will
>>> follow. Highlight is the legacy fw_cfg API removal :)
>>
>> Overall it looks good to me, except the below 4 patches
>>>    target/i386/cpu: Remove X86CPU::check_cpuid field
>>
>> This one gets hard NAK because it changes the default behavior of QEMU.
>>
>>>    hw/net/e1000: Remove unused E1000_FLAG_MAC flag
>>>    hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_MIGRATE_EXTRA definition
>>>    hw/block/fdc-isa: Remove 'fallback' property
>>
>> I'm not sure about the three. Because Unlike other properties removed 
>> by this series, the property name removed by above three patches don't 
>> have a 'x-' prefix.
>>
>> It should be OK to remove properties with 'x-' prefix, but I'm not 
>> sure about the ones without it. There might be user using them 
>> explicitly. If so, remove them needs to go through standard 
>> deprecation process.
> 
> As discussed in another thread, we have a lot of properties that are 
> meant for internal use, though they are exposed to the user (and "x-" 
> was originally meant for experimental properties, not for internal 
> ones). I assume these properties here are such internal ones, so I think 
> it should be ok to remove them now without explicit deprecation. We did 
> this in the past already for the older pc machine types, too, and so far 
> nobody ever complained AFAIK. So I suggest to remove them now, and if 
> someone comlains, we can still revert the corresponding patch.

I'm fine with it since nobody explicitly rejects the removal as I did 
for "target/i386/cpu: Remove X86CPU::check_cpuid field"

>   Thomas
> 


