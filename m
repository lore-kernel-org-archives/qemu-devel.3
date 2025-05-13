Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E07C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 09:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEluT-0002yG-4M; Tue, 13 May 2025 05:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uEluR-0002xa-63; Tue, 13 May 2025 05:26:47 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uEluO-0003FU-Om; Tue, 13 May 2025 05:26:46 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BAE3C55CA5C;
 Tue, 13 May 2025 11:26:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id yB4rYU66MMtP; Tue, 13 May 2025 11:26:31 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B632C55CA5D; Tue, 13 May 2025 11:26:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B3669745683;
 Tue, 13 May 2025 11:26:31 +0200 (CEST)
Date: Tue, 13 May 2025 11:26:31 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org, 
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha <anisinha@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?ISO-8859-15?Q?Cl=E9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>, 
 qemu-arm@nongnu.org, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: How to mark internal properties
In-Reply-To: <87ecwshqj4.fsf@pond.sub.org>
Message-ID: <60cd3ba8-2ab1-74ac-54ea-5e3b309788a1@eik.bme.hu>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-13-philmd@linaro.org>
 <23260c74-01ba-45bc-bf2f-b3e19c28ec8a@intel.com> <aB2vjuT07EuO6JSQ@intel.com>
 <2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com>
 <CAFEAcA-kuHvxjuV_cMh-Px3C-k2Gd51jFqhwndO52vm++M_jAA@mail.gmail.com>
 <aCG6MuDLrQpoTqpg@redhat.com> <87jz6mqeu5.fsf@pond.sub.org>
 <eedd1fa2-5856-41b8-8e6b-38bd5c98ce8f@nutanix.com>
 <87ecwshqj4.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Tue, 13 May 2025, Markus Armbruster wrote:
> Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:
>> On a related note this also brings us back to the discussion as to the 
>> relationship between qdev and QOM: at one point I was under the 
>> impression that qdev properties were simply QOM properties that were 
>> exposed externally, i.e on the commmand line for use with -device.
>>
>> Can you provide an update on what the current thinking is in this area, 
>> in particular re: scoping of qdev vs QOM properties?
>
> qdev is a leaky layer above QOM.
>
> qdev properties are also QOM properties.
>
> All device properties are exposed externally.

That was clear but the question was if QOM properties (that are not qdev 
properties) exist and if so are they also exposed? If not exposed it may 
be used for internal properties (where simpler solutions aren't 
convenient) but maybe qdev also adds easier definition of properties 
that's why they used instead of QOM properties?

> We use device properties for:
>
> * Letting users configure pluggable devices, with -device or device_add
>
> * Letting code configure onboard devices
>
>  For onboard devices that are also pluggable, everything exposed to
>  code is also exposed externally.  This might be a mistake in places.

If a device is pluggable, theoretically a user could create a machine from 
them declaratively, e.g. starting from a "none" machine or like plugging 
cards in a motherboard so their properties should be exposed as long as 
those properties correspond to the device pins they model or configurable 
options. Only properties that are implementation details should not be 
exposed because setting them can break the device. There are a few places 
where we have such properties. But you say "in places" so I think you 
meant the same.

> * Letting the machine versioning machinery adjust device configuration
>
>  Some properties are meant to be used just for this.  They're exposed
>  externally regardless, which is a mistake.

Question is if we want to allow users to tweak these compatibility 
options, like selectively enable/disable when migrating between QEMU 
versions or for testing. It might have some uses and maybe that's the 
reason why people would like these to go through deprecation instead of 
just dropping them. Marking some properties not exposed would get the same 
resistance then so may not solve the issue.

Regards,
BALATON Zoltan

