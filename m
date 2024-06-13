Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE38C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 10:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHhhp-0006aH-I6; Thu, 13 Jun 2024 06:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9LeC=NP=kaod.org=clg@ozlabs.org>)
 id 1sHhhn-0006Zu-7v; Thu, 13 Jun 2024 06:29:19 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9LeC=NP=kaod.org=clg@ozlabs.org>)
 id 1sHhhk-0001OW-KY; Thu, 13 Jun 2024 06:29:18 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W0JYM18Fkz4wc8;
 Thu, 13 Jun 2024 20:29:11 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W0JYH3QvDz4wb1;
 Thu, 13 Jun 2024 20:29:07 +1000 (AEST)
Message-ID: <2e9ad035-06bb-41e4-bdce-1256e4c17d46@kaod.org>
Date: Thu, 13 Jun 2024 12:29:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] hw/ppc: Prefer HumanReadableText over Monitor
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240610062105.49848-1-philmd@linaro.org>
 <cd48f836-3017-4559-b509-9945d041a327@kaod.org>
 <c44dcf6c-3e99-4a32-888d-3c7dfc305a01@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <c44dcf6c-3e99-4a32-888d-3c7dfc305a01@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=9LeC=NP=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/13/24 11:48 AM, Philippe Mathieu-Daudé wrote:
> On 10/6/24 10:19, Cédric Le Goater wrote:
>> On 6/10/24 8:20 AM, Philippe Mathieu-Daudé wrote:
>>> Hi,
>>>
>>> This series remove uses of Monitor in hw/ppc/,
>>> replacing by the more generic HumanReadableText.
>>> Care is taken to keep the commit bisectables by
>>> updating functions one by one, also easing review.
>>
>> Did you do any testing ? POWER[8-10] CPUs on pseries and powernv machines
>> should be checked. A bit tedious I agree but not that long.
> 
> I ran these smoke tests comparing monitor output with baseline:
> 
> $ ./qemu-system-ppc64 -M powernv8 -S -monitor stdio
> QEMU 9.0.50 monitor - type 'help' for more information
> (qemu) info pic
> CPU 0 XIRR=00000000 (0x0) PP=ff MFRR=ff
> ICS 1000..1005 0x14c03d9c0
>    1000 LSI ff 00
>    1001 LSI ff 00
>    1002 LSI ff 00
>    1003 LSI ff 00
>    1004 LSI ff 00
>    1005 LSI ff 00
> ICS    0.. 7ff 0x14c0e93e8
> ICS    0..   7 0x14c0e9328
>       0 LSI ff 00
>       1 LSI ff 00
>       2 LSI ff 00
>       3 LSI ff 00
>       4 LSI ff 00
>       5 LSI ff 00
>       6 LSI ff 00
>       7 LSI ff 00
> ICS    0.. 7ff 0x14c16ffe8
> ICS    0..   7 0x14c16ff28
>       0 LSI ff 00
>       1 LSI ff 00
>       2 LSI ff 00
>       3 LSI ff 00
>       4 LSI ff 00
>       5 LSI ff 00
>       6 LSI ff 00
>       7 LSI ff 00
> ICS    0.. 7ff 0x14c2177e8
> ICS    0..   7 0x14c217728
>       0 LSI ff 00
>       1 LSI ff 00
>       2 LSI ff 00
>       3 LSI ff 00
>       4 LSI ff 00
>       5 LSI ff 00
>       6 LSI ff 00
>       7 LSI ff 00
> Interrupt controller information not available for power8_v2.0-powerpc64-cpu.

This is only checking the older interrupt controller. Please try powernv10.

> (qemu) q
> 
> $ ./qemu-system-ppc64 -M pseries -cpu power10 -S -monitor stdio
> QEMU 9.0.50 monitor - type 'help' for more information
> qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-cfpc=workaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-sbbc=workaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ibs=workaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ccf-assist=on
> (qemu) info pic
> CPU 0 XIRR=00000000 (0x0) PP=ff MFRR=ff
> ICS 1000..1fff 0x600003b05b00
>    1000 MSI ff 00
>    1001 MSI ff 00
>    1100 MSI ff 00
>    1101 MSI ff 00
>    1102 MSI ff 00
>    1103 MSI ff 00
>    1200 LSI ff 00
>    1201 LSI ff 00
>    1202 LSI ff 00
>    1203 LSI ff 00
> irqchip: emulated
> Interrupt controller information not available for power10_v2.0-powerpc64-cpu.
> (qemu) q


This is only checking the old interrupt controller. Please try :

   qemu-system-ppc64 -M pseries,ic-mode=xive -cpu power10 -S -monitor stdio

and we should be fine.

Thanks,

C.




