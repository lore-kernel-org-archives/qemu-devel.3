Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90068C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaip-0005uI-DG; Thu, 15 May 2025 11:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uFaib-0005hM-M9; Thu, 15 May 2025 11:41:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uFaiS-000611-KI; Thu, 15 May 2025 11:41:57 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 992BD55C0D0;
 Thu, 15 May 2025 17:41:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id PduU3-ndk5SU; Thu, 15 May 2025 17:41:40 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B04F655BC02; Thu, 15 May 2025 17:41:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id ADEA0745683;
 Thu, 15 May 2025 17:41:40 +0200 (CEST)
Date: Thu, 15 May 2025 17:41:40 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Zhao Liu <zhao1.liu@intel.com>
cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=EF=BF=BD?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: Re: [PATCH 8/9] target/s390x/kvm/pv: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
In-Reply-To: <aCXxHEVZb8+ZCW/m@intel.com>
Message-ID: <c2466a27-8f8a-780d-ff78-491921bb41e5@eik.bme.hu>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-9-zhao1.liu@intel.com>
 <e0146386-ccf4-44ba-b58f-0bb4d3317f89@redhat.com>
 <aCS8aHsF+VAuj01D@intel.com>
 <7dec9c8e-93d6-81f0-b075-e29b8ede44a2@eik.bme.hu>
 <aCXxHEVZb8+ZCW/m@intel.com>
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

On Thu, 15 May 2025, Zhao Liu wrote:
> On Wed, May 14, 2025 at 06:24:03PM +0200, BALATON Zoltan wrote:
>> Date: Wed, 14 May 2025 18:24:03 +0200
>> From: BALATON Zoltan <balaton@eik.bme.hu>
>> Subject: Re: [PATCH 8/9] target/s390x/kvm/pv: Consolidate
>>  OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
>>
>> On Wed, 14 May 2025, Zhao Liu wrote:
>>>>> +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(S390PVGuest,
>>>>> +                                          s390_pv_guest,
>>>>> +                                          S390_PV_GUEST,
>>>>> +                                          CONFIDENTIAL_GUEST_SUPPORT,
>>>>> +                                          { TYPE_USER_CREATABLE },
>>>>> +                                          { NULL })
>>>>
>>>> I'll note that existing callers of OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
>>>> happily ignore the line limit and put it into a single line.
>>>>
>>>> (which ends up looking better IMHO)
>>>
>>> Ok, I'll onor the existing conventions (which I'll apply to other
>>> patches as well).
>>
>> There are two line limits. If something is clearer on one line you could
>> exceed the normal 80 chars and put up to 90 chars on one line for which
>> checkpatch will issue a warning that can be ignored for these cases. Over 90
>> lines checkpatch will give an error and I think you should not ignore that.
>
> Thank you. This makes sense!
>
>> Maybe try to put as much on one line as possible instead of new line after
>> each argument but without exceeding the 80 chars or if the whole line fits
>> in 90 chars then use that. Or maybe do not indent second line under ( but
>> with 4 spaces then you can fit it in two lines but lines over 90 chars are
>> undesirable.
>
> HMM, I understand you mean:
>
> OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(S390PVGuest, s390_pv_guest,
>    S390_PV_GUEST, CONFIDENTIAL_GUEST_SUPPORT, { TYPE_USER_CREATABLE }, { NULL })
>
> The second line is 82 chars and now I think this version is better.

Yes and maybe can even fit in 80 chars if using { } instead of { NULL }.

Regards,
BALATON Zoltan

