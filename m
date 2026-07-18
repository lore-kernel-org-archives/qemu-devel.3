Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5A3C4451C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 11:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wl3Zg-0000gb-Fc; Sat, 18 Jul 2026 07:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wl3Zd-0000g9-J7; Sat, 18 Jul 2026 07:51:18 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wl3Zb-0005wk-CK; Sat, 18 Jul 2026 07:51:17 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C058458430E;
 Sat, 18 Jul 2026 13:51:09 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ETzVHaHAU-_p; Sat, 18 Jul 2026 13:51:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 16A3A584314; Sat, 18 Jul 2026 13:51:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 146DF584313;
 Sat, 18 Jul 2026 13:51:07 +0200 (CEST)
Date: Sat, 18 Jul 2026 13:51:07 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org, 
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 eric.auger@redhat.com
Subject: Re: [PATCH 1/8] hw/vfio/listener.c: remove CONFIG_KVM
In-Reply-To: <f1a78cc4-a660-4d20-85ad-84431d5a5c13@redhat.com>
Message-ID: <cfa19c77-6783-0870-a509-691f0539ff2a@eik.bme.hu>
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-2-pierrick.bouvier@linaro.org>
 <c3a7cd83-7666-40c5-9baa-ebe64edacab6@tls.msk.ru>
 <3f98fbb6-16be-4de1-b9ae-6108f8f33b57@oss.qualcomm.com>
 <d3f85639-e6a4-4917-8300-d48a7852662f@oss.qualcomm.com>
 <5dc9f2fc-3bd6-4df3-8496-44e6037b51ad@tls.msk.ru>
 <73d87f66-6907-4e02-8026-b89c49912aeb@oss.qualcomm.com>
 <f1a78cc4-a660-4d20-85ad-84431d5a5c13@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1467441737-1784375467=:28375"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1467441737-1784375467=:28375
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 18 Jul 2026, Cédric Le Goater wrote:
> On 7/18/26 06:52, Pierrick Bouvier wrote:
>> On 7/17/2026 9:14 PM, Michael Tokarev wrote:
>>> On 7/17/26 22:40, Pierrick Bouvier wrote:
>>> 
>>>> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/vfio/Kconfig?
>>>> ref_type=heads#L5
>>>> 
>>>> ```
>>>> config VFIO
>>>>       bool
>>>>       depends on LINUX
>>>> ```
>>>> 
>>>> Incorrect, and it should exclude Linux hosts not supporting VFIO.
>>>> At least sparc64 to fix the current issue.
>>> 
>>> Shouldn't there be "depends on LINUX & KVM" ?  At least, this
>>> way we can do --disable-kvm and it will work.
>>> 
>> 
>> I think it's a safe choice, but not sure if we are supposed to be able
>> to use the exotic combination of vfio with tcg also. Maybe it doesn't
>> make any sense technically though, I don't know the arcane of vfio.
>
> VFIO works in some heterogeneous configurations, aarch64 TCG running
> on an x86 host for instance. The opposite doesn't. ppc64 TCG on an x86
> used to work. The limitations primarily stem from architectural
> differences in the host/guest memory mode, CPU/IOMMU address spaces,
> assumptions, etc.
>
>> @Cédric, Any idea of which matrix of host/target is supposed to be
>> supported?
>
> Overall, heterogeneous TCG configurations happen to work by accident.
> I would not consider them supported.

VFIO (vfio-pci) works with PPC TCG and is used for passing through cards 
including GPU to emulated AmigaNG machines (maybe also mac99). Please do 
not break that. There are some quirks mostly with GPUs, see 
https://qmiga.codeberg.page/qemu_vfio.html but it works and used by some 
people.

Regards,
BALATON Zoltan
--3866299591-1467441737-1784375467=:28375--

