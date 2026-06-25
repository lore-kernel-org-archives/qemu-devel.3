Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E621BCDB47F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 06:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcdBx-0000bD-ME; Thu, 25 Jun 2026 02:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wcdBv-0000ZW-QX; Thu, 25 Jun 2026 02:03:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wcdBu-000864-0l; Thu, 25 Jun 2026 02:03:59 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 44BF7596952;
 Thu, 25 Jun 2026 08:03:52 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id TssivsRiy8G0; Thu, 25 Jun 2026 08:03:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 28B86596946; Thu, 25 Jun 2026 08:03:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 25D25596858;
 Thu, 25 Jun 2026 08:03:50 +0200 (CEST)
Date: Thu, 25 Jun 2026 08:03:50 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: Aditya Gupta <adityag@linux.ibm.com>, 
 Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 Sourabh Jain <sourabhjain@linux.ibm.com>, 
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 devel@lists.libvirt.org, Misbah Anjum N <misanjum@linux.ibm.com>, 
 Anushree Mathur <anushree.mathur@linux.ibm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org, 
 Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH 3/8] tests/qtest: Add Power11 chip & machine to qtests
In-Reply-To: <4edf1ef8-1d88-4ad1-92eb-d587974bcd20@linux.ibm.com>
Message-ID: <2afab235-5239-8663-a35e-91ce83485ca0@eik.bme.hu>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-4-adityag@linux.ibm.com>
 <54a9b8d16347f6cc94a625aca81897ba6b875385.camel@linux.ibm.com>
 <ajvemcUx0k12xOIW@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <4edf1ef8-1d88-4ad1-92eb-d587974bcd20@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-919078764-1782367430=:20522"
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

--3866299591-919078764-1782367430=:20522
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 25 Jun 2026, Harsh Prateek Bora wrote:
> On 24/06/26 7:14 pm, Aditya Gupta wrote:
>> On 26/06/23 09:24PM, Shivang Upadhyay wrote:
>>> On Tue, 2026-06-23 at 19:49 +0530, Aditya Gupta wrote:
>>>> +static const char *pnv_get_machine_type(enum PnvChipType chip_type)
>>>> +{
>>>> +    if (chip_type == PNV_CHIP_POWER8) {
>>>> +        return "powernv8";
>>>> +    } else if (chip_type == PNV_CHIP_POWER9) {
>>>> +        return "powernv9";
>>>> +    } else if (chip_type == PNV_CHIP_POWER10) {
>>>> +        return "powernv10";
>>>> +    } else if (chip_type == PNV_CHIP_POWER11) {
>>>> +        return "powernv11";
>>>> +    } else {
>>>> +        g_assert_not_reached();
>>>> +    }
>>>> +}
>>> 
>>> How about refactoring to the following?
>>>
>>>      static const char *const machine_types[] = {
>>>          [PNV_CHIP_POWER8]  = "powernv8",
>>>          [PNV_CHIP_POWER9]  = "powernv9",
>>>          [PNV_CHIP_POWER10] = "powernv10",
>>>          [PNV_CHIP_POWER11] = "powernv11",
>>>      };
>>>      return machine_types[x];
>> 
>> Has a subtle difference, that it may not assert/segfault on unknown
>> value for x, I want the test to crash/fail if this is called with an
>> unknown/new processor chip. I believe the if-else/switch is better as it
>> handles (by 'crashing') unknown values too.
>
> We could just do:
>
> if (chip_type >= PNV_CHIP_MAX) {
>    g_assert_not_reached();
> } else {
>    return machine_types[chip_type];
> }

Or even g_assert(chip_type < PNV_CHIP_MAX); without the if?

Regards,
BALATON Zoltan

> That way just adding new array entry would work for future chips.
>
>> 
>> - Aditya G
>> 
>>> 
>>> ~Shivang.
>
>
>
--3866299591-919078764-1782367430=:20522--

